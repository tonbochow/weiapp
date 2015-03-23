<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-07
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台 | 微信告警控制器
 */
class FoodWxWarnController extends FoodBaseController {

    /**
     * 告警管理(后台管理员)
     */
    public function index() {
        $list = $this->lists('FoodWxWarn', $map, 'mp_id,status,id');
        $this->assign('list', $list);
        $this->meta_title = '微餐饮告警管理';
        $this->display('index');
    }

    //微信公众平台告警列表(前台面向商家)
    public function show() {
        /* 查询条件初始化 */
        $map['mp_id'] = MP_ID;
        $get_description = I('get.description'); //告警描述
        if (isset($get_description)) {
            $map['description'] = $get_description;
        }
        $list = $this->lists('FoodWxWarn', $map, 'status,id', array('status' => array('gt', -1)));

        $this->assign('list', $list);
        $this->meta_title = '微信支付告警';
        $this->display('show');
    }

}
