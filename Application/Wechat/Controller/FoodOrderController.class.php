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
        $foodOrderModel = M('FoodOrder');
//        $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $this->weixin_userinfo['wx_openid'];
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $map['mp_id'] = MP_ID;
        $order_no = I('request.order_no', '', 'trim');
        $cond = '';
        $status = I('get.status', '', 'trim');
        $pay_type = I('get.pay_type', '', 'trim');
        if (!empty($status)) {
            $map['status'] = $status;
            $cond .= " and weiapp_food_order.status=$status";
        }
        if (!empty($pay_type)) {
            $map['pay_type'] = $pay_type;
            $cond .= " and weiapp_food_order.pay_type=$pay_type";
        }
        if (!empty($order_no)) {
            $cond .= " and weiapp_food_order.order_no='$order_no'";
        }
        $page_num = 10;
        $order_count = $foodOrderModel->where($map)->count();
        import('Common.Extends.Page.BootstrapPage');
        $Page = new \BootstrapPage($order_count, $page_num);
        $show = $Page->show();
        $food_orders = $foodOrderModel
                ->join('left  join weiapp_food_order_detail ON weiapp_food_order.id = weiapp_food_order_detail.order_id')
                ->where('weiapp_food_order.mp_id=' . MP_ID . ' and weiapp_food_order.wx_openid ="' . $this->weixin_userinfo['wx_openid'] . '"' . $cond)
                ->order('weiapp_food_order.create_time desc')
                ->group('id')
                ->field('weiapp_food_order.*,weiapp_food_order_detail.food_id')
                ->limit($Page->firstRow . ',' . $Page->listRows)
                ->select();
//        dump($food_orders);
//        echo $foodOrderModel->getLastSql();

        $this->assign('food_orders', $food_orders);
        $this->assign('page', $show);
        $this->meta_title = $this->mp['mp_name'] . "订单列表";
        $this->display('index');
    }

    //查看订单
    public function view() {
        $order_id = I('get.id', '', 'trim');
        $foodOrderModel = M('FoodOrder');
        $map['id'] = $order_id;
        $map['mp_id'] = MP_ID;
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $food_order_info = $foodOrderModel->where($map)->find();
        if ($food_order_info == false) {
            $this->error('未检索您要查看的订单', '/Wechat/FoodOrder/index/t/' . MP_TOKEN);
        }
        $food_orders = $foodOrderModel
                ->join("left join weiapp_food_order_detail on weiapp_food_order.id = weiapp_food_order_detail.order_id")
                ->where('weiapp_food_order.mp_id=' . MP_ID . ' and weiapp_food_order.wx_openid ="' . $this->weixin_userinfo['wx_openid'] . '" and weiapp_food_order.id =' . $order_id)
                ->field('weiapp_food_order.*,weiapp_food_order_detail.food_id,weiapp_food_order_detail.count as food_count,weiapp_food_order_detail.weixin_price as food_weixin_price,weiapp_food_order_detail.unit,weiapp_food_order_detail.real_pay_amount as food_real_pay_amount,weiapp_food_order_detail.type as detail_type')
                ->select();
        $address_info = array();
        if ($food_orders[0]['type'] == \Admin\Model\FoodOrderModel::$TYPE_DELIVERY_HOME) {
            $address_info = \Admin\Model\MemberAddressModel::getMemberAddress($food_orders[0]['address_id']);
        }

//        echo $foodOrderModel->getLastSql();
//        dump($food_orders);

        $this->assign('address_info', $address_info);
        $this->assign('food_orders', $food_orders);
        $this->meta_title = $this->mp['mp_name'] . "订单详细页面";
        $this->display('view');
    }

    //取消订单
    public function cancel() {
        $order_id = I('post.order_id', '', 'trim');
        $map['id'] = $order_id;
        $map['mp_id'] = MP_ID;
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $food_order = M('FoodOrder')->where($map)->find();
        if ($food_order == false) {
            $this->error('未检索到您要取消的订单', '', true);
        }
        if ($food_order['status'] != \Admin\Model\FoodOrderModel::$STATUS_COMMITED) {
            $this->error('此订单不允许取消', '', true);
        }
        $order_data['status'] = \Admin\Model\FoodOrderModel::$STATUS_CANCEL;
        $order_data['update_time'] = time();
        $order_save = M('FoodOrder')->where($map)->save($order_data);
        if ($order_save) {
            $this->success('已取消', '', true);
        }
        $this->error('取消订单失败', '', true);
    }

    //完成订单
    public function finish() {
        $order_id = I('post.order_id', '', 'trim');
        $map['id'] = $order_id;
        $map['mp_id'] = MP_ID;
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $food_order = M('FoodOrder')->where($map)->find();
        if ($food_order == false) {
            $this->error('未检索到您要完成的订单', '', true);
        }
        if ($food_order['status'] != \Admin\Model\FoodOrderModel::$STATUS_DELIVERY) {
            $this->error('此订单不允许完成', '', true);
        }
        $order_data['status'] = \Admin\Model\FoodOrderModel::$STATUS_FINISHED;
        $order_data['update_time'] = time();
        $order_save = M('FoodOrder')->where($map)->save($order_data);
        if ($order_save) {
            $this->success('已完成', '', true);
        }
        $this->error('完成订单失败', '', true);
    }

    //创建订单(微信支付订单 | 线下付款订单)
    public function create() {
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
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $map['car_id'] = $car_id;
        $car_details = M('FoodCarDetail')->where($map)->select();
        if ($car_details == false) {
            $this->error('未检索到购餐车明细无法提交订单', '', true);
        }
        import('Common.Extends.WxPay.lib.WxPayApi');
        $out_trade_no = \WxPayConfig::MCHID . date("YmdHis"); //微信支付out_trade_no
        $wxpay_flag = false;
        $foodOrderModel = D('Admin/FoodOrder'); //开启事务 
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
//                $total_food_amount += bcmul($car_detail['count'], $car_detail['price'], 2);
                $total_food_amount += $car_detail['amount'];
            }
            $total_real_pay_amount += $total_food_amount + $delivery_fee; //实际微信支付金额为 菜品金额+送餐费(送餐费包含到支付)
//                $total_real_pay_amount = $total_food_amount;//实际微信支付金额为 菜品金额 (送餐费不包含到支付)
            $total_amount += $total_real_pay_amount; //总金额等于实际支付金额
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
                    $memberAddressModel = D('Admin/MemberAddress');
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
            foreach ($car_details as $car_detail) {//包括菜品和套餐
                if ($car_detail['type'] == \Wechat\Model\FoodCarDetailModel::$TYPE_FOOD) {//菜品
                    $detail_info = M('Food')->where(array('id' => $car_detail['food_setmenu_id']))->find();
                } else {
                    $detail_info = M('FoodSetmenu')->where(array('id' => $car_detail['food_setmenu_id']))->find();
                }
//                $food = M('Food')->where(array('id' => $car_detail['food_setmenu_id']))->find();
                $order_detail_data['wx_openid'] = $this->weixin_userinfo['wx_openid'];
                $order_detail_data['mp_id'] = MP_ID;
                $order_detail_data['dining_room_id'] = $dining_room_id;
                $order_detail_data['order_id'] = $food_order_id;
                $order_detail_data['food_id'] = $car_detail['food_setmenu_id'];
                $order_detail_data['count'] = $car_detail['count'];
                $order_detail_data['weixin_price'] = $car_detail['price'];
                $order_detail_data['amount'] = $car_detail['amount'];
                $order_detail_data['real_pay_amount'] = $car_detail['amount'];
                if ($car_detail['type'] == \Wechat\Model\FoodCarDetailModel::$TYPE_FOOD) {
                    $order_detail_data['price'] = $detail_info['price'];
                    $order_detail_data['unit'] = $detail_info['unit'];
                } else {
                    $order_detail_data['price'] = $detail_info['amount']; //套餐原价
                    $order_detail_data['unit'] = '套餐';
                }
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
            $this->success($out_trade_no, '', true);
//            echo json_encode(array(
//                'status' => true,
//                'info' => '创建订单成功',
//                'out_trade_no' => $out_trade_no,
//            ));
        } else {
            $this->success(0, '', true);
//            echo json_encode(array(
//                'status' => true,
//                'info' => '创建微信支付订单成功',
//                'out_trade_no' => false,
//            ));
        }
    }

    //微信支付页面
    public function pay() {
        //先检测微信版本
        $weixin_version = get_weixin_browser_version();
        if (!$weixin_version) {
            $this->error('微信支付需微信版本大于5,请升级微信到最新版本', '/Wechat/FoodOrder/index');
        }
        $out_trade_no = I('get.out_trade_no', '', 'trim');
        $order_id = I('get.order_id', '', 'trim');
        $map['mp_id'] = MP_ID;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $map['out_trade_no'] = $out_trade_no;
        $wx_order = M('FoodWxOrder')->where($map)->find();
        if ($wx_order == false) {
            $this->error('未检索到微信支付订单', '/Wechat/FoodOrder/index');
        }
        //检索订单
        $map['status'] = \Admin\Model\FoodOrderModel::$STATUS_COMMITED;
        if (empty($order_id)) {//下完订单直接跳转到支付页面(以out_trad_no为微信支付唯一交易号进行微信支付)
            $wx_pay_outTradeNo = $out_trade_no;
        } else {//从订单列表或详细页面跳转到支付页面(以order_no为微信支付唯一交易号进行微信支付)
            $map['id'] = $order_id;
        }
        $food_orders = M('FoodOrder')->where($map)->select();
        if (empty($food_orders)) {
            $this->error('未检测到您的微信订单', '/Wechat/FoodOrder/index');
        }
        if (!empty($order_id)) {
            $wx_pay_outTradeNo = $food_orders[0]['order_no'];
        }
        $total_amount = 0; //微信支付总金额
        $wxPay_desc = '';
        foreach ($food_orders as $food_order) {
            $total_amount += $food_order['real_pay_amount'];
            $wxPay_desc .= '订单号:' . trim($food_order['order_no']);
//            $orderDetailModel = D('FoodOrderDetailView');
//            $detail_cond['order_id'] = $food_order['id'];
//            $order_details = $orderDetailModel->where($detail_cond)->order("default_share desc")->group('food_id')->select();
            $detail_cond['order_id'] = $food_order['id'];
            $detail_cond['mp_id'] = MP_ID;
            $detail_cond['wx_openid'] = $this->weixin_userinfo['wx_openid'];
            $order_details = M('FoodOrderDetail')->where($detail_cond)->select();
            $goods_desc = '';
            foreach ($order_details as $order_detail) {
                if ($order_detail['type'] == \Admin\Model\FoodOrderDetailModel::$TYPE_FOOD) {
                    $food_name = \Admin\Model\FoodModel::getFoodName($order_detail['food_id']);
                    $wxPay_desc .= '菜品:' . trim($food_name) . '微信价:' . trim($order_detail['weixin_price']);
                    $goods_desc .= '菜品:' . trim($food_name) . ' 微信价:￥' . trim($order_detail['weixin_price']).'<br>';
                } else {
                    $setmenu_name = \Admin\Model\FoodSetmenuModel::getFoodSetmenuName($order_detail['food_id']);
                    $wxPay_desc .= '菜品:' . trim($setmenu_name) . '微信价:' . trim($order_detail['weixin_price']);
                    $goods_desc .= '菜品:' . trim($setmenu_name) . ' 微信价:￥' . trim($order_detail['weixin_price']).'<br>';
                }
            }
            $order_ids_arr[] = $food_order['id'];
            $food_order_info[] = array(
                'order_id' => $food_order['id'],
                'order_no' => $food_order['order_no'],
                'goods_desc' => $goods_desc,
            );
        }

        $food_order_ids = implode(",", $order_ids_arr);
        $body = $attach = mb_substr($wxPay_desc, 0, 40, 'utf-8') . '..';

        $jsApiParameters = $this->_wxPay($wx_pay_outTradeNo, $body, $attach, $total_amount);

        $this->assign('out_trade_no', $wx_pay_outTradeNo);
        $this->assign('wx_pay_amount', $total_amount);
        $this->assign('food_order_ids', $food_order_ids);
        $this->assign('food_order_info', $food_order_info);
        $this->assign('jsApiParameters', $jsApiParameters);
        $this->meta_title = $this->mp['mp_name'] . "微信支付页面";
        $this->display('pay');
    }

    //微信支付
    private function _wxPay($out_trade_no, $body, $attach, $total_amount) {
        $openid = $this->weixin_userinfo['wx_openid'];
        //引入微信支付相关文件
        import('Common.Extends.WxPay.lib.Log'); //日志记录类
        import('Common.Extends.WxPay.lib.JsApiPay'); //微信支付类
        //初始化日志
        $logHandler = new \CLogFileHandler("../logs/" . date('Y-m-d') . '.log');
        $log = \Log::Init($logHandler, 15);
        //微信支付
        $tools = new \JsApiPay();
        $input = new \WxPayUnifiedOrder();
        $input->SetBody($body);
        $input->SetAttach($attach);
        $input->SetOut_trade_no($out_trade_no); //微信支付out_trade_no
        $input->SetTotal_fee(strval($total_amount * 100)); //微信支付总金额
        $input->SetTime_start(date("YmdHis")); //微信支付开始时间
        $input->SetTime_expire(date("YmdHis", time() + 1800)); //微信支付有效时间
        $input->SetGoods_tag("'" . MP_NAME . "'");
        $input->SetNotify_url("http://www.52gdp.com/Wechat/WxNotify/ReceivePayResult");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid(strval($openid)); //微信用户openid
        $order = \WxPayApi::unifiedOrder($input);
        if(!empty($order['err_code']) && !empty($order['err_code_des'])){
            $this->error($order['err_code_des'],'','true');
        }
        $jsApiParameters = $tools->GetJsApiParameters($order);

        return $jsApiParameters;
    }

    //完成微信支付
    public function completepay() {
        $food_order_ids = I('post.food_order_ids');
        $out_trade_no = I('post.out_trade_no');
        $wx_pay_amount = I('post.wx_pay_amount');
        if (empty($food_order_ids)) {
            $this->error('支付成功后处理订单失败','',true);
        }
        $food_orderIds_arr = explode(',', $food_order_ids);
        $foodOrderModel = M('FoodOrder');
//        $foodOrderModel->startTrans();
        foreach ($food_orderIds_arr as $order_id) {
            $food_order = $foodOrderModel->where(array('id' => $order_id))->find();
            //1更新订单状态
            $order_data['status'] = \Admin\Model\FoodOrderModel::$STATUS_WXPAYED;
            $order_data['update_time'] = time();
            $food_save = $foodOrderModel->where(array('id' => $order_id, 'mp_id' => MP_ID, 'wx_openid' => $this->weixin_userinfo['wx_openid']))->save($order_data);
            if ($food_save == false) {
//                $foodOrderModel->rollback();
                $this->error($food_order['order_no'].'订单更新失败','',true);
            }
            //2生成餐厅资金流水
            $waterModel = M('FoodMoneyWater');
            $water_data['wx_openid'] = $this->weixin_userinfo['wx_openid'];
            $water_data['mp_id'] = MP_ID;
            $water_data['order_no'] = \Admin\Model\FoodOrderModel::getFoodOrderNo($order_id);
            $water_data['amount'] = $wx_pay_amount;
            $water_data['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
            $water_data['create_time'] = time();
            $water_data['update_time'] = time();
            $water_data['current_amount'] = bcadd($this->mp['account'], $wx_pay_amount, 2);
            $water_data['note'] = '订单号:' . $order_id . '生成的订单流水';
            $water_id = $waterModel->add($water_data);
            if (!$water_id) {//资金流水生成失败回滚
//                $foodOrderModel->rollback();
                $this->error('生成餐厅资金流水失败','',true);
            }
            //3更新微信公众平台帐号资金
            $mp_data['account'] = bcadd($this->mp['account'], $wx_pay_amount, 2);
            $mp_data['update_time'] = time();
            M('MicroPlatform')->where(array('id' => MP_ID))->save($mp_data);
            //4微信发送模版消息通知用户支付成功
            $order_detail = M('FoodOrderDetail')->where(array('order_id'=>$order_id,'mp_id'=>MP_ID,'wx_openid'=>$this->weixin_userinfo['wx_openid']))->find();
            if($order_detail['type'] == \Admin\Model\FoodOrderDetailModel::$TYPE_FOOD){
                $food_name = \Admin\Model\FoodModel::getFoodName($order_detail['food_id']);
            }else{
                $food_name = \Admin\Model\FoodSetmenuModel::getFoodSetmenuName($order_detail['food_id']);
            }
            $foods_name_str = $food_name.'等';
            $order_info['url'] = 'http://www.52gdp.com/Wechat/FoodOrder/index/id/' . $order_id . '/t/' . MP_TOKEN;
            $order_info['food_name'] = $foods_name_str;
            $order_info['amount'] = $wx_pay_amount;
            $order_info['pay_time'] = date('Y-m-d H:i:s',time());
//            \Admin\Model\MicroPlatformModel::sendTemplateMessage(APPID, APPSERCERT, $this->weixin_userinfo['wx_openid'], $order_info);   
            //5发送微信消息通知餐厅的微信号 需要绑定餐厅 每日进行签到
            $dining_room = M('DiningRoom')->where(array('id'=>$food_order['dining_room_id']))->find();
            $dining_wx_openid = $dining_room['service_openid'];//餐厅前台服务号
            if(!empty($dining_wx_openid)){
                $info_data = '订单:'.$food_order['order_no'].' 微信支付成功!请查看';
                \Admin\Model\MicroPlatformModel::sendCustomerMessage(APPID, APPSERCERT, $dining_wx_openid, $info_data);
            } 
        }
//        $foodOrderModel->commit();
        $this->success('恭喜您支付成功','',true);
//        echo json_encode(array(
//            'status' => true,
//            'info' => '支付成功',
//            'out_trade_no' => $out_trade_no,
//        ));
    }

}
