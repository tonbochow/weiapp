<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-32
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端订单控制器
 */
class FoodOrderController extends BaseController {

    //订单列表
    public function index() {

        $this->meta_title = $this->mp['mp_name'] . "订单列表";
        $this->display('index');
    }

    //创建订单(微信支付订单 | 线下付款订单)
    public function create() {
        dump(I('post.'));
        exit;
        $car_id = I('post.car_id');
        $real_name_arr = I('post.real_name');
        $phone_arr = I('post.phone');
        $province_name_arr = I('post.province_name');
        $city_name_arr = I('post.city_name');
        $town_name_arr = I('post.town_name');
        $detail_addr_arr = I('post.detail_addr');
        $dining_type_arr = I('post.dining_type'); //餐厅类型 2餐厅用餐 3配送到家
        //判断是否有配送到家订单 有的话检测是否填写了送餐地址
        if (in_array(\Admin\Model\DiningRoomModel::$TYPE_HOME, $dining_type_arr)) {
            foreach ($dining_type_arr as $dining_room_id => $dining_type) {
                if ($dining_type == \Admin\Model\DiningRoomModel::$TYPE_HOME) {
                    if (empty($real_name_arr[$dining_room_id])) {
                        $this->error('请填写送餐联系人真实姓名', '', true);
                    }
                    if (empty($phone_arr[$dining_room_id])) {
                        $this->error('请填写送餐联系人电话', '', true);
                    }
                    if (empty($province_name_arr[$dining_room_id])) {
                        $this->error('请填写送餐联系人省份', '', true);
                    }
                    if (empty($city_name_arr[$dining_room_id])) {
                        $this->error('请填写送餐联系人城市', '', true);
                    }
                    if (empty($town_name_arr[$dining_room_id])) {
                        $this->error('请填写送餐联系人市区', '', true);
                    }
                    if (empty($detail_addr_arr[$dining_room_id])) {
                        $this->error('请填写送餐联系人详细地址', '', true);
                    }
                }
            }
        }
        $dining_pay_type_arr = I('post.dining_pay_type'); //支付方式 1微信支付 3线下付款
        $map['mp_id'] = MP_ID;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['car_id'] = $car_id;
        $car_details = M('FoodCarDetail')->where($map)->select();
        if ($car_details == false) {
            $this->error('未检索到购餐车明细无法提交订单', '', true);
        }
        import('Common.Extends.WxPay.lib.WxPayApi');
        $out_trade_no = \WxPayConfig::MCHID . date("YmdHis"); //微信支付out_trade_no
        $wxpay_flag = false;
        $foodOrderModel = M('FoodOrder'); //开启事务 
        $foodOrderModel->startTrans();
        //1生成订单(中间有可能保存微信用户送餐地址)
        foreach ($dining_pay_type_arr as $dining_room_id => $dining_pay_type) {
            $order_no = genOrderNo(); //订单order_no
            if ($dining_pay_type == \Admin\Model\DiningRoomModel::$PAY_TYPE_WEIXIN) {
                $wxpay_flag = true; //标识是否有微信支付的订单
            }
            $dining_room_info = \Admin\Model\DiningRoomModel::getDiningRoom($dining_room_id);
            if ($dining_type_arr[$dining_room_id] == \Admin\Model\DiningRoomModel::$TYPE_DINING) {//餐厅用餐无送餐费用
                $delivery_fee = 0;
            } else {//送餐到家可能需要送餐费用
                $delivery_fee = $dining_room_info['delivery_fee']; //送餐费
            }
            $total_amount = 0;
            $total_count = 0;
            $total_food_amount = 0;
            $total_real_pay_amount = 0;
            //检索该餐厅的购餐车明细中菜品详细
            $car_detail_map['dining_room_id'] = $dining_room_id;
            $car_detail_map['mp_id'] = MP_ID;
            $car_detail_map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
            $car_detail_map['car_id'] = $car_id;
            $car_details = M('FoodCarDetail')->where($car_detail_map)->select();
            foreach ($car_details as $car_detail) {
                $total_count += $car_detail['count'];
                $total_food_amount += bcmod($car_detail['count'], $car_detail['price'], 2);
            }
            $total_real_pay_amount = $total_food_amount + $delivery_fee; //实际微信支付金额为 菜品金额+送餐费(送餐费包含到支付)
//                $total_real_pay_amount = $total_food_amount;//实际微信支付金额为 菜品金额 (送餐费不包含到支付)
            $total_amount = $total_real_pay_amount; //总金额等于实际支付金额
            //a若为送餐到家订单则先保存送餐地址
            if ($dining_type_arr[$dining_room_id] == \Admin\Model\DiningRoomModel::$TYPE_HOME) {//微信支付送餐到家订单
                $address_data['wx_openid'] = $this->weixin_userinfo['wx_openid'];
                $address_data['real_name'] = $real_name_arr[$dining_room_id];
                $address_data['phone'] = $phone_arr[$dining_room_id];
                $address_data['province_name'] = $province_name_arr[$dining_room_id];
                $address_data['city_name'] = $city_name_arr[$dining_room_id];
                $address_data['town_name'] = $town_name_arr[$dining_room_id];
                $address_data['address'] = $detail_addr_arr[$dining_room_id];
                $address_data['status'] = \Admin\Model\MemberAddressModel::$STATUS_ENABLE;
                $member_address = M('MemberAddress')->where($address_data)->find();
                if ($member_address == false) { //不存在则进行保存
                    $memberAddressModel = D('MemberAddress');
                    if ($memberAddressModel->create($address_data, \Admin\Model\MemberAddressModel::MODEL_INSERT)) {
                        $address_id = $memberAddressModel->add();
                        if ($address_id == false) {
                            $foodOrderModel->rollback();
                            $this->error($memberAddressModel->getError(), '', true);
                        }
                    } else {
                        $foodOrderModel->rollback();
                        $this->error($memberAddressModel->getError(), '', true);
                    }
                } else {
                    $address_id = $member_address['id'];
                }
            }
            $food_order_data['wx_openid'] = $this->weixin_userinfo['wx_openid'];
            $food_order_data['mp_id'] = MP_ID;
            $food_order_data['dining_room_id'] = $dining_room_id;
            $food_order_data['order_no'] = $order_no;
            $food_order_data['type'] = $dining_type_arr[$dining_room_id];
            $food_order_data['pay_type'] = $dining_pay_type;
            $food_order_data['delivery_fee'] = $delivery_fee;
            $food_order_data['count'] = $total_count;
            $food_order_data['amount'] = $total_amount;
            $food_order_data['food_amount'] = $total_food_amount;
            $food_order_data['real_pay_amount'] = $total_real_pay_amount;
            $food_order_data['address_id'] = isset($address_id) ? $address_id : 0;
            $food_order_data['status'] = \Admin\Model\FoodOrderModel::$STATUS_COMMITED;
            if ($dining_pay_type == \Admin\Model\DiningRoomModel::$PAY_TYPE_WEIXIN) {//线下付款
                $food_order_data['out_trade_no'] = $out_trade_no; //微信支付订单out_trade_no和微信同步 唯一
            }
            //b生成订单主单
            if ($foodOrderModel->create($food_order_data, \Admin\Model\FoodOrderModel::MODEL_INSERT)) {
                $food_order_id = $foodOrderModel->add();
                if ($food_order_id == false) {
                    $foodOrderModel->rollback();
                    $this->error($foodOrderModel->getError(), '', true);
                }
                if ($dining_pay_type == \Admin\Model\DiningRoomModel::$PAY_TYPE_WEIXIN) {//线下付款
                    $food_order_ids[] = $food_order_id; //把微信支付订单id存到数组中
                }
            } else {
                $foodOrderModel->rollback();
                $this->error($foodOrderModel->getError(), '', true);
            }
            //c生成订单明细
            foreach ($car_details as $car_detail) {
                $food = M('Food')->where(array('id' => $car_detail['food_setmenu_id']))->find();
                $order_detail_data['wx_openid'] = $this->weixin_userinfo['wx_openid'];
                $order_detail_data['mp_id'] = MP_ID;
                $order_detail_data['dining_room_id'] = $dining_room_id;
                $order_detail_data['order_id'] = $food_order_id;
                $order_detail_data['food_id'] = $car_detail['food_setmenu_id'];
                $order_detail_data['count'] = $car_detail['count'];
                $order_detail_data['price'] = $food['price'];
                $order_detail_data['weixin_price'] = $car_detail['price'];
                $order_detail_data['unit'] = $food['unit'];
                $order_detail_data['amount'] = $car_detail['amount'];
                $order_detail_data['real_pay_amount'] = $car_detail['amount'];
                $order_detail_data['create_time'] = time();
                $order_detail_data['update_time'] = time();
                $order_detail_id = M('FoodOrderDetail')->add($order_detail_data);
                if ($order_detail_id == false) {
                    $foodOrderModel->rollback();
                    $this->error('生成订单明细失败', '', true);
                }
            }
        }

        //2删除购餐车
        $car_detail_del = M('FoodCarDetail')->where($map)->delete();
        if ($car_detail_del == false) {
            $foodOrderModel->rollback();
            $this->error('删除购餐车失败', '', true);
        }

        //3 判断是否需要生成微信支付订单中间表 food_wx_order
        if ($wxpay_flag) {//需要生成微信支付订单中间表
            $wxOrderModel = M('FoodWxOrder');
            $wx_order_data['wx_openid'] = $this->weixin_userinfo['wx_openid'];
            $wx_order_data['mp_id'] = MP_ID;
            $wx_order_data['out_trade_no'] = $out_trade_no;
            $wx_order_data['content'] = json_encode($food_order_ids);
            $wx_order_data['status'] = \Admin\Model\FoodOrderModel::$STATUS_COMMITED;
            $wx_order_data['create_time'] = time();
            $wx_order_data['update_time'] = time();
            $wxOrderAdd_id = $wxOrderModel->add($wx_order_data);
            if (!$wxOrderAdd_id) {
                $foodOrderModel->rollback();
                $this->error('生成微信支付中间表失败', '', true);
            }
        }
        //4 微信发送消息通知餐厅有用户下单
        
        $foodOrderModel->commit();
        if ($wxpay_flag) {
            echo json_encode(array(
                'status' => true,
                'info' => '创建订单成功',
                'out_trade_no' => $out_trade_no,
            ));
        } else {
            echo json_encode(array(
                'status' => true,
                'info' => '创建微信支付订单成功',
                'out_trade_no' => false,
            ));
        }
    }

}
