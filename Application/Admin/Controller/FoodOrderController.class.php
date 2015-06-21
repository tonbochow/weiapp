<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-07
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食公众平台 | 订单控制器
 */
class FoodOrderController extends FoodBaseController {

    /**
     * 订单管理(后台管理员)
     */
    public function index() {
        $get_order_no = I('get.order_no');
        if (!empty($get_order_no)) {
            $map['order_no'] = $get_order_no;
        }
        $list = $this->lists('FoodOrder', $map, 'mp_id,status,id');
        $this->assign('list', $list);
        $this->meta_title = '微美食订单列表';
        $this->display('index');
    }

    //订单列表页面(前台面向商家)
    public function show() {
//        dump(I('get.'));exit;
        /* 查询条件初始化 */
        if (DINING_ROOM_ID != '') {//连锁分店店员登录
            $map['dining_room_id'] = DINING_ROOM_ID;
//            $map['dining_member_id'] = UID;
            $map['mp_id'] = MP_ID;
//            $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
            $dining_room_name = \Admin\Model\DiningRoomModel::getDiningRoomName(DINING_ROOM_ID);
        } else {
            $map['mp_id'] = MP_ID;
//            $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
            $dining_room_name = '';
        }
        $get_order_no = I('get.order_no'); //订单编号唯一
        if (isset($get_order_no)) {
            $map['order_no'] = $get_order_no;
        }
        $get_pay_type = I('get.pay_type');
        if ($get_pay_type) {
            $map['pay_type'] = $get_pay_type;
        }

        $list = $this->lists('FoodOrder', $map, 'create_time desc,pay_type,status,id', array('status' => array('egt', -1)));
        $pay_type_arr = \Admin\Model\FoodOrderModel::getFoodPayType();
        $this->assign('pay_type_arr', $pay_type_arr);
        $this->assign('select_pay_type', $get_pay_type);

        $this->assign('dining_room_name', $dining_room_name);
        $this->assign('list', $list);
        $this->meta_title = '订单列表';
        $this->display('show');
    }

    //订单查看明细页面(前台面向商家)
    public function view() {
        $id = I('get.id');
        $food_order = M('FoodOrder')->where(array('id' => $id, 'mp_id' => MP_ID))->find();
        if ($food_order == false) {
            $this->error('未检索到订单!', '', true);
        }
//        $foodOrderViewModel = D('FoodOrderView');
        $map['weiapp_food_order.mp_id'] = MP_ID;
        $map['weiapp_food_order.id'] = $id;
//        $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
//        $food_order_info = $foodOrderViewModel->where($map)->select();
        $foodOrderModel = M('FoodOrder');
        $food_order_info = $foodOrderModel
                ->join('left  join weiapp_food_order_detail ON weiapp_food_order.id = weiapp_food_order_detail.order_id')
                ->where($map)
                ->field('weiapp_food_order.*,weiapp_food_order_detail.food_id,weiapp_food_order_detail.unit,weiapp_food_order_detail.weixin_price,weiapp_food_order_detail.count as d_count,weiapp_food_order_detail.amount as d_amount,weiapp_food_order_detail.real_pay_amount as d_real_pay_amount')
                ->select();

        $this->assign('food_order', $food_order);
        $this->assign('food_order_info', $food_order_info);
        $this->meta_title = '订单详细页面';
        $this->display('view');
    }

    //订单确认送餐页面(前台面向商家)
    public function confirm() {
        if (IS_POST) {
            $id = I('post.id');
            $food_order = M('FoodOrder')->where(array('id' => $id, 'mp_id' => MP_ID))->find();
            if ($food_order == false) {
                $this->error('未检索到可确认送餐的订单!', '', true);
            }
            $food_order_data['status'] = \Admin\Model\FoodOrderModel::$STATUS_DELIVERY;
            $food_order_data['update_time'] = time();
            $food_order_data['delivery_time'] = time();
            $food_order_confirm = M('FoodOrder')->where(array('id' => $id, 'mp_id' => MP_ID))->save($food_order_data);
            import('Common.Extends.Weixin.Wechat');
            ob_clean();
            $access_token = \Admin\Model\MicroPlatformModel::getAccessToken(APPID, APPSECRET);
            $info_url = 'https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=' . $access_token;
            $info_content = "您的餐单:" . $food_order['order_no'] . " 我们正在送餐中请等待!";
            $post_data = '{
                            "touser":"' . $food_order['wx_openid'] . '",
                            "msgtype":"text",
                            "text":
                            {
                                "content":"' . $info_content . '"
                            }
                        }';
            \Admin\Model\MicroPlatformModel::curl($info_url, $post_data);
            if ($food_order_confirm) {
                $this->success('确认送餐成功,并微信发消息通知了用户!', '', true);
            }
            $this->error('确认送餐失败!', '', true);
        }

        $this->meta_title = '订单确认送餐页面';
        $this->display('wxpayview');
    }

    //订单确认完成(前台面向商家)
    public function finish() {
        if (IS_POST) {
            $id = I('post.id');
            $food_order = M('FoodOrder')->where(array('id' => $id, 'mp_id' => MP_ID))->find();
            if ($food_order == false) {
                $this->error('未检索到可确认完成的订单!', '', true);
            }
            $food_order_details = M('FoodOrderDetail')->where(array('order_id'=>$id,'mp_id'=>MP_ID))->select();
            if(!empty($food_order_details)){
                foreach($food_order_details as $detail){
                    if($detail['type'] == \Admin\Model\FoodOrderDetailModel::$TYPE_FOOD){
                        M('Food')->where("id=".$detail['food_id'])->setInc('sell_count',$detail['count`']);
                    }
                }
            }
            $food_order_data['status'] = \Admin\Model\FoodOrderModel::$STATUS_FINISHED;
            $food_order_data['update_time'] = time();
            $food_order_data['finish_member_id'] = UID;
            $food_order_data['finish_time'] = time();
            $food_order_finish = M('FoodOrder')->where(array('id' => $id, 'mp_id' => MP_ID))->save($food_order_data);
            if ($food_order_finish) {
                $this->success('确认订单完成成功!', '', true);
            }
            $this->error('确认订单完成失败!', '', true);
        }

        $this->meta_title = '订单确认完成页面';
        $this->display('wxpayview');
    }

    //微美食订单打印页面
    public function orderprint() {
        if (I('post.print')) {
            $id = I('post.id');
            $foodOrderModel = M('FoodOrder');
            $map['id'] = $id;
            $map['mp_id'] = MP_ID;
//            $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
            $food_order = $foodOrderModel->where($map)->select();
            if (empty($food_order)) {
                $this->error('未检索到打印的订单!');
            }
            $print_data['is_printed'] = \Admin\Model\FoodOrderModel::$PRINT_STATUS_YES;
            $print_data['update_time'] = time();
            $food_order_print = $foodOrderModel->where($map)->save($print_data);
            if ($food_order_print) {
                $this->success('更新订单打印状态成功!', '', true);
            }
            $this->error('更新订单打印状态失败!', '', true);
        }
        $id = I('post.id');
        $map['weiapp_food_order.id'] = $id;
        $map['weiapp_food_order.mp_id'] = MP_ID;
        
        $foodOrderModel = M('FoodOrder');
        $food_order = $foodOrderModel
                ->join('left  join weiapp_food_order_detail ON weiapp_food_order.id = weiapp_food_order_detail.order_id')
                ->where($map)
                ->field('weiapp_food_order.*,weiapp_food_order_detail.food_id,weiapp_food_order_detail.unit,weiapp_food_order_detail.weixin_price,weiapp_food_order_detail.count as d_count,weiapp_food_order_detail.amount as d_amount,weiapp_food_order_detail.real_pay_amount as d_real_pay_amount')
                ->select();

        $this->assign('food_order', $food_order);
        $this->meta_title = '订单打印页面';
        $this->display('orderprint');
    }

}
