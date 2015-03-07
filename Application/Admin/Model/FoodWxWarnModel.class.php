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
 * 餐饮 微信公众平台告警模型
 */
class FoodWxWarnModel extends Model {

    public static $STATUS_UNDEAL = 0; //告警状态 未处理
    public static $STATUS_DEALED = 1; //告警状态 已处理

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wx_openid', 'require', '告警用户wx_openid不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('appid', 'require', '告警appid不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('error_type', 'require', '告警error_type不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('description', 'require', '告警description不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('alarm_content', 'require', '告警alarm_content不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 0, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取告警状态
    public static function getFoodWxWarnStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_UNDEAL] = '未处理';
        $status_arr[self::$STATUS_DEALED] = '已处理';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }



}
