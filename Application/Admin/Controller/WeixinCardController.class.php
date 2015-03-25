<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-25
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台 | 微信卡劵控制器
 */
class WeixinCardController extends FoodBaseController {

    /**
     * 卡劵管理(后台管理员)
     */
    public function index() {
        $list = $this->lists('WxCard', '', 'mp_id,id');
        $this->assign('list', $list);
        $this->meta_title = '微餐饮卡劵管理';
        $this->display('index');
    }

    //微信公众平台卡劵列表(前台面向商家)
    public function show() {
        /* 查询条件初始化 */
        $map['mp_id'] = MP_ID;
        $get_card_id = I('get.card_id'); //告警描述
        if (isset($get_card_id)) {
            $map['card_id'] = $get_card_id;
        }
        $list = $this->lists('WxCard', $map, 'mp_id,id');

        $this->assign('list', $list);
        $this->meta_title = '微信卡劵';
        $this->display('show');
    }

}
