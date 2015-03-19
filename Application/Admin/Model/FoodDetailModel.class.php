<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-18
// | 餐饮餐厅菜品明细模型
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

class FoodDetailModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 禁用
    public static $STATUS_ENABLED = 1; //状态 启用
    public static $DEFAULT_SHARE_NO = 0; //非默认分享图片
    public static $DEFAULT_SHARE_YES = 1; //默认分享图片

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '餐厅用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('url', 'require', '菜品明细url不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('input_name', 'require', '菜品表达字段名次不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );


    //获取菜品状态
    public static function getFoodDetailStatus($status = null, $has_choice = true) {
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

}
