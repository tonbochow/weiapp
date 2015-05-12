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
        $signPackage = \Admin\Model\MicroPlatformModel::getJsApiPrams(APPID, APPSECRET);
        $this->assign('signPackage', $signPackage);
        //设置微信默认分享设置
        $share_info = array(
            'title' => MP_NAME,
            'desc' =>  MP_NAME.' 发放优惠劵了!超值优惠!小伙伴们快来领取吧!' ,
            'link' => get_current_url(),
            'imgUrl' => 'http://' . $_SERVER['HTTP_HOST'] . $this->mp['mp_img'],
        );
        $this->assign('share_info', $share_info);
        
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
        $wx_openid = $this->weixin_userinfo['wx_openid'];
        $timestamp = time();
        $signatureObj = new \Signature();
        $signatureObj->add_data(strval($api_ticket));
        $signatureObj->add_data(strval($wx_card['card_id']));
        $signatureObj->add_data(strval($timestamp));
        $signatureObj->add_data(strval($wx_openid));
        $signature =  $signatureObj->get_signature();
//        $card = '{cardList: [{cardId: \'' . $wx_card['card_id'] . '\',cardExt:\'{"code":"","openid":"","timestamp":"'.$timestamp.'","signature":"'.$signature.'"}\'}],success: function (res) {}}';
        $card_info['card_id'] = $wx_card['card_id'];
        $card_info['card_ext'] = '{"code":"","openid":"'.$wx_openid.'","timestamp":"'.$timestamp.'","signature":"'.$signature.'"}';
        $this->success($card_info,'',true);
    }

}
