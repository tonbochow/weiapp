<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-02
// | 购餐车明细模型
// +----------------------------------------------------------------------

namespace Wechat\Model;

use Think\Model;

class FoodCarDetailModel extends Model {

    public static $TYPE_FOOD = 1; //菜品
    public static $TYPE_SETMENU = 2; //套餐

    /* 自动验证规则 */
    protected $_validate = array(
        array('car_id', 'require', '购餐车id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wx_openid', 'require', '微信用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取购餐车明细类型
    public static function getFoodCarDetailType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$TYPE_FOOD] = '菜品';
        $type_arr[self::$TYPE_SETMENU] = '套餐';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

}
