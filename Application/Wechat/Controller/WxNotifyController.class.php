<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-05-04
// +----------------------------------------------------------------------

namespace Wechat\Controller;

use Think\Controller;

class WxNotifyController extends Controller {

    /**
     * 微信支付notify_url 微信服务器推送支付结果url
     */
    public function ReceivePayResult() {
        import('Common.Extends.Weixin.CacheLock');
        import('Common.Extends.WxPayPubHelper.WxPayPubHelper');
        $lock = new \CacheLock('key_name'); //并发下加锁  重要
        $lock->lock();
        //使用通用通知接口
        $notify = new \Notify_pub();
        //存储微信的回调
        $xml = $GLOBALS['HTTP_RAW_POST_DATA'];
        $notify->saveData($xml);
        //验证签名，并回应微信。
        //对后台通知交互时，如果微信收到商户的应答不是成功或超时，微信认为通知失败，
        //微信会通过一定的策略（如30分钟共8次）定期重新发起通知，
        //尽可能提高通知的成功率，但微信不保证通知最终能成功。
        //以log文件形式记录回调信息
        $log_ = new \Log_();
        $log_name = "./notify_url.log"; //log文件路径
        $log_->log_result($log_name, "【接收到的notify通知】:\n" . $xml . "\n");
        if ($notify->checkSign() == TRUE) {
            if ($notify->data["return_code"] == "FAIL") {
                //此处应该更新一下订单状态，商户自行增删操作
                $log_->log_result($log_name, "【通信出错】:\n" . $xml . "\n");
                $notify->setReturnParameter("return_code", "FAIL"); //返回状态码
                $notify->setReturnParameter("return_msg", "通信出错"); //返回信息
            } elseif ($notify->data["result_code"] == "FAIL") {
                //此处应该更新一下订单状态，商户自行增删操作
                $log_->log_result($log_name, "【业务出错】:\n" . $xml . "\n");
                $notify->setReturnParameter("return_code", "FAIL"); //返回状态码
                $notify->setReturnParameter("return_msg", "业务出错"); //返回信息
            } else {
                //此处应该更新一下订单状态，商户自行增删操作
                $log_->log_result($log_name, "【支付成功】:\n" . $xml . "\n");
                $appid = $notify->data['appid'];
                $mchid = $notify->data['mch_id'];
                $microPlatformModel = M('MicroPlatform');
                $map['appid'] = $appid;
                $map['mchid'] = $mchid;
                $mp = $microPlatformModel->where($map)->find();
                if ($mp == false) {
                    $notify->setReturnParameter("return_code", "FAIL"); //返回状态码
                    $notify->setReturnParameter("return_msg", "appid或mchid不正确"); //返回信息
                    $returnXml = $notify->returnXml();
                    echo $returnXml;
                }
                if ($mp['app_type'] == \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD) {
                    $foodWxNotifyModel = M('FoodWxNotify');
                    $notify_map['out_trade_no'] = $notify->data['out_trade_no'];
                    $food_wx_notify = $foodWxNotifyModel->where($notify_map)->find();
                    if ($food_wx_notify == false) {//存入支付结果通知表
                        $notify_data['out_trade_no'] = $notifyp->data['out_trade_no'];
                        $notify_data['wx_openid'] = $notify->data['openid'];
                        $notify_data['mp_id'] = $mp['id'];
                        $notify_data['result_code'] = $notify->data['result_code'];
                        $notify_data['err_code'] = $notify->data['err_code'];
                        $notify_data['err_code_des'] = $notify->data['err_code_des'];
                        $notify_data['trade_type'] = $notify->data['trade_type'];
                        $notify_data['bank_type'] = $notify->data['bank_type'];
                        $notify_data['total_fee'] = $notify->data['total_fee'];
                        $notify_data['fee_type'] = $notify->data['fee_type'];
                        $notify_data['cash_fee'] = $notify->data['cash_fee'];
                        $notify_data['cash_fee_type'] = $notify->data['cash_fee_type'];
                        $notify_data['coupon_fee'] = $notify->data['coupon_fee'];
                        $notify_data['coupon_count'] = $notify->data['coupon_count'];
                        $notify_data['transaction_id'] = $notify->data['transaction_id'];
                        $notify_data['attach'] = $notify->data['attach'];
                        $notify_data['product_fee'] = $notify->data['product_fee'];
                        $notify_data['appid'] = $notify->data['appid'];
                        $notify_data['mchid'] = $notify->data['mch_id'];
                        $notify_data['create_time'] = time();
                        $notify_data['update_time'] = time();
                        $time_end = $notify->data['time_end'];
                        if (!empty($time_end)) {
                            $year = substr($time_end, 0, 4);
                            $month = substr($time_end, 4, 2);
                            $day = substr($time_end, 6, 2);
                            $hour = substr($time_end, 8, 2);
                            $minute = substr($time_end, 10, 2);
                            $second = substr($time_end, 12, 2);
                            $end_time = mktime($hour, $minute, $second, $month, $day, $year);
                        } else {
                            $end_time = '';
                        }
                        $notify_data['time_end'] = $end_time;
                        $notify_add_res = $foodWxNotifyModel->add($notify_data);
                        if ($notify_add_res == false) {
                            $notify->setReturnParameter("return_code", "FAIL"); //返回状态码
                            $notify->setReturnParameter("return_msg", "业务出错"); //返回信息
                            $returnXml = $notify->returnXml();
                            echo $returnXml;
                        }
                    }
                }

                $notify->setReturnParameter("return_code", "SUCCESS"); //设置返回码
                $notify->setReturnParameter("return_msg", "OK"); //返回信息
            }
        } else {
            $notify->setReturnParameter("return_code", "FAIL"); //返回状态码
            $notify->setReturnParameter("return_msg", "签名失败"); //返回信息
        }

        $returnXml = $notify->returnXml();
        echo $returnXml;
        $lock->unlock();
    }

}
