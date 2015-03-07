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
 * 餐饮 微信公众平台维权模型
 */
class FoodWxFeedbackModel extends Model {

    public static $MSG_TYPE_REQUEST = 'request';//用户提交投诉
    public static $MSG_TYPE_CONFIRM = 'confirm';//户确认取消投诉
    public static $MSG_TYPE_REJECT  = 'reject'; //用户拒绝取消投诉

    /* 自动验证规则 */
    protected $_validate = array(
        array('feedback_id', 'require', '用户投诉单id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wx_openid', 'require', '维权用户wx_openid不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('dining_room_id', 'require', '餐厅dining_room_id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('appid', 'require', '维权appid不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('msg_type', 'require', '用户维权类型msg_type不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('trans_id', 'require', '交易单号不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('reason', 'require', '维权投诉原因不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取维权状态
    public static function getFoodWxFeedbackMsgType($msg_type = null, $has_choice = true) {
        if ($has_choice) {
            $msg_type_arr = array('' => '请选择');
        }
        $msg_type_arr[self::$MSG_TYPE_REQUEST] = '用户提交投诉';
        $msg_type_arr[self::$MSG_TYPE_CONFIRM] = '户确认取消投诉';
        $msg_type_arr[self::$MSG_TYPE_REJECT] = '用户拒绝取消投诉';
        if ($msg_type !== null) {
            return $msg_type_arr[$msg_type];
        }
        return $msg_type_arr;
    }



}
