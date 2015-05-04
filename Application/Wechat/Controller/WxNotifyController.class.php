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
                if($mp['app_type'] == \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD){
                    $foodWxNotifyModel = M('FoodWxNotify');
                    $notify_map['out_trade_no'] = $notify->data['out_trade_no'];
                    $food_wx_notify = $foodWxNotifyModel->where($notify_map)->find();
                    if($food_wx_notify == false){//未存入支付结果通知表
                        $notify_data['out_trade_no'] = $notifyp->data['out_trade_no'];
                        $notify_data['wx_openid'] = $notify->data['openid'];
                        $notify_data['mp_id'] = $mp['id'];
                        $notify_data[''] = '';
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




        $pay_notice_data = $this->pay_notice_data;

        if (!empty($pay_notice_data)) {//手动微信服务器推送的支付结果通知
            $postObj = simplexml_load_string($postStr, 'SimpleXMLElement', LIBXML_NOCDATA);
            $trade_mode = isset($pay_notice_data['trade_mode']) ? $pay_notice_data['trade_mode'] : ''; //交易模式 1即时到账
            $trade_state = isset($pay_notice_data['trade_state']) ? $pay_notice_data['trade_state'] : ''; //支付结果 0 成功
            $pay_info = isset($pay_notice_data['pay_info']) ? strval($pay_notice_data['pay_info']) : ''; //支付结果信息
            $partner = isset($pay_notice_data['partner']) ? strval($pay_notice_data['partner']) : ''; //商户号
            $bank_type = isset($pay_notice_data['bank_type']) ? strval($pay_notice_data['bank_type']) : ''; //付款银行 微信中WX
            $bank_billno = isset($pay_notice_data['bank_billno']) ? strval($pay_notice_data['bank_billno']) : ''; //银行订单号
            $total_fee = isset($pay_notice_data['total_fee']) ? $pay_notice_data['total_fee'] : ''; //总金额
            $fee_type = isset($pay_notice_data['fee_type']) ? $pay_notice_data['fee_type'] : ''; //币种
            $notify_id = isset($pay_notice_data['notify_id']) ? strval($pay_notice_data['notify_id']) : ''; //通知id
            $transaction_id = isset($pay_notice_data['transaction_id']) ? strval($pay_notice_data['transaction_id']) : ''; //订单号
            $out_trade_no = isset($pay_notice_data['out_trade_no']) ? strval($pay_notice_data['out_trade_no']) : ''; //商户订单号
            $attach = isset($pay_notice_data['attach']) ? strval($pay_notice_data['attach']) : ''; //商户数据包
            $time_end = isset($pay_notice_data['time_end ']) ? strval($pay_notice_data['time_end']) : ''; //支付完成时间
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
            $transport_fee = isset($pay_notice_data['transport_fee']) ? $pay_notice_data['transport_fee'] : ''; //物流费用
            $product_fee = isset($pay_notice_data['product_fee']) ? $pay_notice_data['product_fee'] : ''; //物品费用
            $discount = isset($pay_notice_data['discount']) ? $pay_notice_data['discount'] : ''; //折扣价格
            $buyer_alias = isset($pay_notice_data['buyer_alias']) ? strval($pay_notice_data['buyer_alias']) : ''; //买家别名
            //1先从 wx_notify 表中检索是否已存在  存在直接返回success 通知微信服务器不用在发送订单支付结果
            $wxNotifyModel = M('WxNotify');
            $wx_warn = $wxNotifyModel->where("out_trade_no='" . $out_trade_no . "'")->find();
            if (!empty($wx_warn)) {
                $this->Logger($transaction_id);
                $this->Logger('支付结果通知已存在');
                echo 'success'; //返回success 通知微信服务器收到支付结果通知
                $lock->unlock();
                exit;
            }

            //2不存在wx_notify 表中则插入到wx_notify表中 并返回 success
            $wx_notify_data = array(
                'out_trade_no' => $out_trade_no,
                'trade_mode' => $trade_mode,
                'trade_state' => $trade_state,
                'pay_info' => $pay_info,
                'partner' => $partner,
                'bank_type' => $bank_type,
                'bank_billno' => $bank_billno,
                'total_fee' => $total_fee,
                'fee_type' => $fee_type,
                'notify_id' => $notify_id,
                'transaction_id' => $transaction_id,
                'attach' => $attach,
                'time_end' => $end_time,
                'transport_fee' => $transport_fee,
                'product_fee' => $product_fee,
                'discount' => $discount,
                'buyer_alias' => $buyer_alias,
                'openid' => $this->openid,
                'appid' => APPID,
                'create_time' => time(),
                'update_time' => time(),
            );
            $res = $wxNotifyModel->add($wx_notify_data);

            if ($res) {
                $this->Logger($transaction_id);
                $this->Logger('支付结果通知插入成功');
                echo 'success'; //返回success 通知微信服务器收到支付结果通知
                $lock->unlock();
                exit;
            }
            $this->Logger('微信支付结果通知插入失败');
            echo 'fail'; //通知微信服务器未收到支付结果通知或通知微信服务器需要重新发送通知
            $lock->unlock();
            exit;
        } else {//微信服务器推送无get详细数据 返回fail 继续推送
            $this->Logger('未获取到支付结果详细数据');
            echo 'fail';
            $lock->unlock();
            exit;
        }
    }

}
