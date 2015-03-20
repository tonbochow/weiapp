<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-07
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 餐饮连锁餐厅分店明细模型
 */
class DiningRoomDetailModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 无效
    public static $STATUS_ENABLED = 1; //状态 有效

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('member_id', 'require', '下单用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取餐厅分店状态
    public static function getDiningRoomDetailStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DISABLED] = '无效';
        $status_arr[self::$STATUS_ENABLED] = '有效';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

}