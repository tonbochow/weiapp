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

}
