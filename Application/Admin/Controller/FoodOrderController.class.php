<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-07
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台 | 订单控制器
 */
class FoodOrderController extends FoodBaseController {

    /**
     * 订单管理(后台管理员)
     */
    public function index() {
        $this->display();
    }

    //微信支付的订单(前台面向商家)
    public function weixinpay() {
        /* 查询条件初始化 */
        if(!empty(DINING_ROOM_ID)){//连锁分店店员登录
            $map['dining_room_id'] = DINING_ROOM_ID;
            $map['dining_member_id'] =UID;
            $map['mp_id'] = MP_ID;
            $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
            $dining_room_name = \Admin\Model\DiningRoomModel::getDiningRoomName(DINING_ROOM_ID);
        }else{
            $map['mp_id'] = MP_ID;
            $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
            $dining_room_name = '';
        }
        $get_order_no = I('get.order_no');//订单编号唯一
        if (isset($get_order_no)) {
            $map['order_no'] = $get_order_no;
        }
        $list = $this->lists('FoodOrder', $map, 'status,id', array('status' => array('egt', -1)));

        $this->assign('dining_room_name',$dining_room_name);
        $this->assign('list', $list);
        $this->meta_title = '微信支付的订单列表';
        $this->display('weixinpay');
    }

    //微信支付的订单查看明细页面(前台面向商家)
    public function wxpayview(){
        
        $this->meta_title = '微信支付订单详细页面';
        $this->display('wxpayview');
    }
    
    //微信支付订单确认送餐页面(前台面向商家)
    public function confirm(){
        
        $this->meta_title = '微信支付订单确认送餐页面';
        $this->display('wxpayview');
    }
    
    //微信支付订单确认完成(前台面向商家)
    public function finish(){
        
        $this->meta_title = '微信支付订单确认完成页面';
        $this->display('wxpayview');
    }
    
    
}
