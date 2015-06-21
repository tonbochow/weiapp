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
 * 美食门店美食风格模型
 */
class FoodStyleModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 禁用
    public static $STATUS_ENABLED = 1; //状态 启用

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '门店用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('name', 'require', '美食风格内容不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取美食风格状态
    public static function getFoodStyleStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DISABLED] = '禁用';
        $status_arr[self::$STATUS_ENABLED] = '启用';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取美食风格内容
    public static function getFoodStyleName($id) {
        $food_style = M('FoodStyle')->where(array('id' => $id))->find();
        return $food_style['name'];
    }

}
