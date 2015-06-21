<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-20
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 美食门店美食套餐模型
 */
class FoodSetmenuModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 下架
    public static $STATUS_ENABLED = 1; //状态 上架
    public static $USE_CARD_NO = 0; //使用卡劵 禁用
    public static $USE_CARD_YES = 1; //使用卡劵 允许

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '门店用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('setmenu_name', 'require', '美食套餐名不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('setmenu_money', '/^\d+(\.\d+)?$/', '美食套餐优惠价为数字', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取美食套餐状态
    public static function getFoodSetmenuStatus($status = null, $has_choice = true) {
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

    //获取美食套餐使用卡劵状态
    public static function getFoodSetmenuCard($card = null, $has_choice = true) {
        if ($has_choice) {
            $card_arr = array('' => '请选择');
        }
        $card_arr[self::$USE_CARD_NO] = '禁用';
        $card_arr[self::$USE_CARD_YES] = '允许';
        if ($card !== null) {
            return $card_arr[$card];
        }
        return $card_arr;
    }

    //获取美食套餐名
    public static function getFoodSetmenuName($id) {
        $food_setmenu = M('FoodSetmenu')->where(array('id' => $id))->find();
        return $food_setmenu['setmenu_name'];
    }

    //获取美食套餐默认图片
    public static function getFoodSetmenuUrl($id) {
        $food_setmenu =  M('FoodSetmenu')->where(array('id' => $id))->field('url')->find();
        return $food_setmenu['url'];
    }

}
