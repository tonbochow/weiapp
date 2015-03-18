<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-18
// | 餐饮餐厅菜品模型
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

class FoodModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 下架
    public static $STATUS_ENABLED = 1; //状态 上架
    public static $HOT_YES = 1; //热销菜品 
    public static $HOT_NO = 0; //非热销菜品
    public static $PROMOTION_YES = 1; //促销菜品
    public static $PROMOTION_NO = 0; //非促销菜品
    public static $OFFLINE_YES = 1; //允许餐到付款
    public static $OFFLINE_NO = 0; //不允许餐到付款
    public static $CARD_YES = 1; //允许使用卡劵
    public static $CARD_NO = 0; //不允许使用卡劵

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '餐厅用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('food_name', 'require', '菜品不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('food_name', '/^[\u0391-\uFFE5]|\w{1,30}$/', '菜品名不符要求', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('price', '/^\d+(\.\d+)?$/', '菜品原价为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('weixin_price', '/^\d+(\.\d+)?$/', '菜品微信价为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('cost_price', '/^\d+(\.\d+)?$/', '菜品成本价为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('stock', '/^\d+(\.\d+)?$/', '菜品库存应为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('cate_id', 'require', '菜品所属分类id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('cate_name', 'require', '菜品所属分类不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('price', 'require', '菜品原价不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('weixin_price', 'require', '菜品微信价不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('unit', 'require', '菜品单位不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取菜品名
    public static function getFoodName($id) {
        $food = M('Food')->where(array('id' => $id))->find();
        return $food['food_name'];
    }

    //获取菜品状态
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

    //获取菜品是否热销
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

    //获取菜品是否促销
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

    //获取菜品是否餐到付款
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

    //获取菜品是否允许使用卡劵
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

}
