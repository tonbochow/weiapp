<?php

/**
 * 微餐饮订单明细表food_order_detail
 * @author tonbochow
 * date:2015-04-07
 */

namespace Common\Model;

use Think\Model\ViewModel;

class FoodOrderDetailViewModel extends ViewModel {

    public $viewFields = array(
        'FoodOrderDetail' => array(
            'id',
            'order_id',
            'dining_room_id',
            'food_id',
            'count',
            'price',
            'weixin_price',
            'unit',
            'amount',
            'real_pay_amount',
            'use_card',
            'card_used_amount',
            '_type' => 'LEFT',
        ),
        'Food' => array(
            'id'=>'food_id',
            'food_name',
            'price'=>'food_price',
            'weixin_price'=>'food_weixin_price',
            '_type' => 'LEFT',
            '_on' => 'FoodOrderDetail.food_id = Food.food_id',
        ),
        'FoodDetail'=>array(
            'id'=>'food_detail_id',
            'food_id'=>'detail_food_id',
            'url',
            'default_share',
            '_type' => 'LEFT',
            '_on' => 'FoodOrderDetail.food_id = FoodDetail.detail_food_id',
        ),
    );

}
