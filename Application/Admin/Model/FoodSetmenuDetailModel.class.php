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
 * 美食门店美食套餐明细模型
 */
class FoodSetmenuDetailModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 套餐中禁用
    public static $STATUS_ENABLED = 1; //状态 套餐中启用

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('setmenu_id', 'require', '美食套餐id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('food_id', 'require', '美食id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('food_name', 'require', '美食名不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取美食套餐明细状态
    public static function getFoodSetmenuDetailStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DISABLED] = '套餐中禁用';
        $status_arr[self::$STATUS_ENABLED] = '套餐中启用';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

}
