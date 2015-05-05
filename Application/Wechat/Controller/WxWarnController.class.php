<?php

/*
 * 微信告警通知
 * 1 微信post告警信息给商户
 * 2 商户接收微信告警 按情况处理告警
 * 3 处理完成后管理开发的告警管理功能
 */

namespace Wechat\Controller;

use Think\Controller;

class WxWarnController extends Controller {
    /*
     * 接收微信告警
     */

    public function receive() {
        import('Common.Extends.Weixin.CacheLock');
        import('Common.Extends.WxPayPubHelper.WxPayPubHelper');
        $lock = new \CacheLock('key_name'); //并发下加锁  重要
        $lock->lock();
        //使用通用通知接口
        $warn = new \Notify_pub();
        //存储微信的回调
        $xml = $GLOBALS['HTTP_RAW_POST_DATA'];
        $warn->saveData($xml);
        //验证签名，并回应微信。
        //对后台通知交互时，如果微信收到商户的应答不是成功或超时，微信认为通知失败，
        //微信会通过一定的策略（如30分钟共8次）定期重新发起通知，
        //尽可能提高通知的成功率，但微信不保证通知最终能成功。
        //以log文件形式记录回调信息
        $log_ = new \Log_();
        $log_name = "./wx_warn.log"; //log文件路径
        if (!empty($warn)) {
            $log_->log_result($log_name, "【接收到的warn通知】:\n" . $xml . "\n");
            $appid = $warn->data['AppId'];
            $errorType = $warn->data['ErrorType'];
            $description = $warn->data['Descriptiong'];
            $alarmContent = $warn->data['AlarmContent'];
            $create_time = $warn->data['TimeStamp'];
            $appSignature = $warn->data['AppSignature'];
            $microPlatformModel = M('MicroPlatform');
            $map['appid'] = $appid;
            $mp = $microPlatformModel->where($map)->find();
            if ($mp == false) {
                $warn->setReturnParameter("return_code", "FAIL"); //返回状态码
                $warn->setReturnParameter("return_msg", "appid不正确"); //返回信息
                $returnXml = $warn->returnXml();
                echo $returnXml;
                $lock->unlock();
                exit;
            }
            if ($mp['app_type'] == \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD) {
                $foodWxWarnModel = M('FoodWxWarn');
                $warn_map['appid'] = $appid;
                $wx_warn = $foodWxWarnModel->where($warn_map)->find();
                if (empty($wx_warn)) {
                    $wx_warn_data = array(
                        'mp_id' => $mp['id'],
                        'appid' => $appid,
                        'appsignature' => $appSignature,
                        'error_type' => $errorType,
                        'description' => $description,
                        'alarm_content' => $alarmContent,
                        'create_time' => $create_time,
                        'status' => \Admin\Model\FoodWxWarnModel::$STATUS_UNDEAL, //告警未处理
                        'update_time' => $create_time,
                    );
                    $add_res = $foodWxWarnModel->add($wx_warn_data);
                    if ($add_res == false) {
                        $log_->log_result($log_name, "【微信告警插入失败】:\n" . $xml . "\n");
                        echo 'fail';
                        exit;
                    }
                }
                echo 'success';
                $lock->unlock();
                exit;
            }
        }
        $lock->unlock();
    }

}
