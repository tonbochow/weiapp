<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-31
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端微信用户控制器
 */
class WeixinMemberController extends BaseController {

    //用户个人中心
    public function index() {
        $foodOrderModel = M('FoodOrder');
        $map['mp_id'] = MP_ID;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        //检索待付款订单数量
        $map['status'] = \Admin\Model\FoodOrderModel::$STATUS_COMMITED;
        $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
        $need_pay_count = $foodOrderModel->where($map)->count();
        //检索送餐中订单数量
        $map['status'] = \Admin\Model\FoodOrderModel::$STATUS_DELIVERY;
        unset($map['pay_type']);
        $delivery_count = $foodOrderModel->where($map)->count();
        //检索已完成订单数量
        $map['status'] = \Admin\Model\FoodOrderModel::$STATUS_FINISHED;
        $finish_count = $foodOrderModel->where($map)->count();

        $this->assign('status_delivery', \Admin\Model\FoodOrderModel::$STATUS_DELIVERY);
        $this->assign('status_need_pay', \Admin\Model\FoodOrderModel::$STATUS_COMMITED);
        $this->assign('status_finish', \Admin\Model\FoodOrderModel::$STATUS_FINISHED);
        $this->assign('weixin_pay', \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN);
        $this->assign('need_pay_count', $need_pay_count);
        $this->assign('delivery_count', $delivery_count);
        $this->assign('finish_count', $finish_count);
        $this->display('index');
    }

}
