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
 * 微美食客户预定模型
 */
class DiningReserveModel extends Model {

    public static $STATUS_DROP = -2; //状态 已作废
    public static $STATUS_CANCEL = - 1; //状态 已取消
    public static $STATUS_COMMITED = 1; //状态 已提交
    public static $STATUS_CONFIRM = 2; //状态  已确认
    public static $STATUS_FINISH = 3; //状态  已完成

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('dining_room_id', 'require', '门店id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('user_name', 'require', '联系人不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('user_num', '/^[1-9]\d*$/', '用餐人数应为正整数', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mobile', 'require', '联系人手机号不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mobile', '/^1\d{10}$/', '联系人手机号不正确', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('user_num', 'require', '用餐人数不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('meal_time', 'require', '用餐时间不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('remark', 'require', '用餐描述不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取客户预定状态
    public static function getDiningReserveStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DROP] = '已作废';
        $status_arr[self::$STATUS_CANCEL] = '已取消';
        $status_arr[self::$STATUS_COMMITED] = '已提交';
        $status_arr[self::$STATUS_CONFIRM] = '已确认[预定成功]';
        $status_arr[self::$STATUS_FINISH] = '已完成';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

}
