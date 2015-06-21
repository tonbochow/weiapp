<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-18
// | 美食门店美食模型
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

class FoodModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 下架
    public static $STATUS_ENABLED = 1; //状态 上架
    public static $HOT_YES = 1; //热销美食 
    public static $HOT_NO = 0; //非热销美食
    public static $PROMOTION_YES = 1; //促销美食
    public static $PROMOTION_NO = 0; //非促销美食
    public static $OFFLINE_YES = 1; //允许餐到付款
    public static $OFFLINE_NO = 0; //不允许餐到付款
    public static $CARD_YES = 1; //允许使用卡劵
    public static $CARD_NO = 0; //不允许使用卡劵

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '门店用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('food_name', 'require', '美食不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('food_name', '/^(.*){1,30}$/', '美食名不符要求', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('price', '/^\d+(\.\d+)?$/', '美食原价为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('weixin_price', '/^\d+(\.\d+)?$/', '美食微信价为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('cost_price', '/^\d+(\.\d+)?$/', '美食成本价为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('stock', '/^\d+(\.\d+)?$/', '美食库存应为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('cate_id', 'require', '美食所属分类id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('cate_name', 'require', '美食所属分类不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('price', 'require', '美食原价不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('weixin_price', 'require', '美食微信价不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('unit', 'require', '美食单位不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取美食名
    public static function getFoodName($id) {
        $food = M('Food')->where(array('id' => $id))->find();
        return $food['food_name'];
    }

    //获取美食状态
    public static function getFoodStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DISABLED] = '下架';
        $status_arr[self::$STATUS_ENABLED] = '上架';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取美食是否热销
    public static function getFoodHot($hot = null, $has_choice = true) {
        if ($has_choice) {
            $hot_arr = array('' => '请选择');
        }
        $hot_arr[self::$HOT_NO] = '非热销';
        $hot_arr[self::$HOT_YES] = '热销';
        if ($hot !== null) {
            return $hot_arr[$hot];
        }
        return $hot_arr;
    }

    //获取美食是否促销
    public static function getFoodPromotion($promotion = null, $has_choice = true) {
        if ($has_choice) {
            $promotion_arr = array('' => '请选择');
        }
        $promotion_arr[self::$PROMOTION_NO] = '非促销';
        $promotion_arr[self::$PROMOTION_YES] = '促销';
        if ($promotion !== null) {
            return $promotion_arr[$promotion];
        }
        return $promotion_arr;
    }

    //获取美食是否餐到付款
    public static function getFoodOffline($offline = null, $has_choice = true) {
        if ($has_choice) {
            $offline_arr = array('' => '请选择');
        }
        $offline_arr[self::$OFFLINE_NO] = '不允许餐到付款';
        $offline_arr[self::$OFFLINE_YES] = '允许餐到付款';
        if ($offline !== null) {
            return $offline_arr[$offline];
        }
        return $offline_arr;
    }

    //获取美食是否允许使用卡劵
    public static function getFoodCard($card = null, $has_choice = true) {
        if ($has_choice) {
            $card_arr = array('' => '请选择');
        }
        $card_arr[self::$CARD_NO] = '不允许使用卡劵';
        $card_arr[self::$CARD_YES] = '允许使用卡劵';
        if ($card !== null) {
            return $card_arr[$card];
        }
        return $card_arr;
    }

    //获取门店美食数量
    public static function getFoodsCount($mp_id, $cate_id, $dining_room_id) {
       if(!empty($cate_id)){
           $map['cate_id'] = $cate_id;
       }
       if(!empty($dining_room_id)){
           $map['dining_room_id'] = $dining_room_id;
       }
       $map['mp_id'] = $mp_id;
       $foods_count = M('Food')->where($map)->count();
       return $foods_count;
    }

}
