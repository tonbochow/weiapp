<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-22
// +----------------------------------------------------------------------

namespace Wechat\Controller;

use Think\Controller;

/**
 * 微信端卡劵功能控制器
 */
class WxCardController extends BaseController {

    //微信卡劵列表页面
    public function index() {
//        define('MP_ID', 1);
        $wxCardModel = M('WxCard');
//        $map['status'] = \Admin\Model\WxCardModel::$CARD_STATUS_VERIFY_OK;
        $map['mp_id'] = MP_ID;
        $card_count = $wxCardModel->where($map)->count();
        $page_num = 10;
        import('Common.Extends.Page.BootstrapPage');
        $Page = new \BootstrapPage($card_count, $page_num);
        $show = $Page->show();
        $cards = $wxCardModel->where($map)->order('create_time desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

        $this->assign('page', $show);
        $this->assign('cards', $cards);
        $this->meta_title = $this->mp['mp_name'] . " | 卡劵";
        $this->display('index');
    }

    //拉取卡劵相关信息 card_id card_ext
    public function getcard() {
        $card_id = I('post.card_id', '', 'intval');
        $map['id'] = $card_id;
        $map['mp_id'] = MP_ID;
        $wx_card = M('WxCard')->where($map)->find();
        if ($wx_card == false) {
            $this->error('未检索到卡劵', '', true);
        }
        import('Common.Extends.Weixin.CardSDK');
        $api_ticket = \Admin\Model\WxCardModel::getApiTicket(APPID, APPSECRET);
//        $this->success($api_ticket,'',true);
        $timestamp = time();
        $signatureObj = new \Signature();
        $signatureObj->add_data($api_ticket);
        $signatureObj->add_data($wx_card['card_id']);
        $signatureObj->add_data($timestamp);
        $signature =  $signatureObj->get_signature();
        $card = '{"card_list": [{"card_id": "' . $wx_card['card_id'] . '","card_ext":"{\"code\":\"\",\"openid\":\"\",\"timestamp\":\"'.$timestamp.'\",\"signature\":\"'.$signature.'\"}"}]}';
        $this->success($card,'',true);
    }

}
