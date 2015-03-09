<?php

/**
 * 微餐饮订单主表food_order
 * @author tonbochow
 * date:2015-03-09
 */

namespace Common\Model;

use Think\Model\ViewModel;

class FoodOrderViewModel extends ViewModel {

    public $viewFields = array(
        'FoodOrder' => array(
            'id',
            'mp_id',
            'member_id',
            'wx_openid',
            'dining_member_id',
            'dining_room_id',
            'order_no',
            'type',
            'pay_type',
            'delivery_fee',
            'count',
            'amount',
            'food_amount',
            'real_pay_amount',
            'envelope_used_amount',
            'address_id',
            'out_trade_no',
            'is_printed',
            'status',
            'pay_time',
            'delivery_time',
            'finish_time',
            '_type' => 'LEFT',
        ),
        'FoodOrderDetail' => array(
            'food_id',
            'count' => 'd_count',
            'price' => 'd_price',
            'weixin_price' => 'weixin_price',
            'unit',
            'amount'=>'d_amount',
            'real_pay_amount'=>'d_real_pay_amount',
            'use_card' =>'d_use_card',
            'card_used_amount'=>'d_card_used_amount',
            '_table' => "weiapp_food_order_detail",
            '_as' => "d",
            '_type' => 'LEFT',
            '_on' => 'FoodOrder.id = d.order_id'
        ),
        'MemberAddress' => array(
            'real_name',
            'mobile',
            'phone',
            'address',
            '_type' => 'LEFT',
            '_on' => 'FoodOrder.address_id = MemberAddress.id',
        ),
//        'Province' => array(
//            'name' => 'p_name',
//            '_table' => 'weiapp_region',
//            '_type' => 'LEFT',
//            '_on' => 'MemberAddress.province = Province.id',
//        ),
//        'City' => array(
//            'name' => 'c_name',
//            '_table' => 'weiapp_region',
//            '_type' => 'LEFT',
//            '_on' => 'MemberAddress.city = City.id',
//        ),
//        'Town' => array(
//            'name' => 'a_name',
//            '_table' => 'weiapp_region',
//            '_type' => 'LEFT',
//            '_on' => 'MemberAddress.town = Town.id',
//        ),
    );

}
