<?php

// | Author: tonbochow
// | date:2015-02-23
// +----------------------------------------------------------------------

namespace Home\Model;

use Think\Model;

/**
 * 用户详细信息模型
 */
class MemberInfoModel extends Model {

    public static $STATUS_UNCHECK = 0; //用户状态 待审核
    public static $STATUS_ALLOW = 1; //用户状态 申请通过
    public static $STATUS_DENY = -1; //用户状态 申请未通过
    public static $TYPE_TRY = 0; //用户详细信息类型0试用
    public static $TYPE_OFFICIAL = 1; //用户详细信息类型1正式
    public static $APP_TYPE_FOOD = 1; //微应用类型1餐饮
    public static $APP_TYPE_PHOTO = 2; //微应用类型2摄影

    /* 自动验证规则 */
    protected $_validate = array(
        array('member_id', 'require', '用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('real_name', '/^[\x{4e00}-\x{9fa5}]{1,10}$/u', '输入姓名不符要求', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('real_name', 'require', '姓名不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_INSERT),
        array('mobile', '', '手机号码已经存在', self::EXISTS_VALIDATE, 'unique', self::MODEL_BOTH),
        array('mobile', 'require', '手机号码不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_INSERT),
        array('mobile', '/^1\d{10}$/', '手机号码不符要求', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('introduce', 'require', '申请简介不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_INSERT),
        array('introduce', '3,256', '申请简介长度为3-256个字符', self::EXISTS_VALIDATE, 'length'),
    );

    /* 用户详细信息模型自动完成 */
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_UPDATE),
        array('status', 0, self::MODEL_INSERT),
    );

    //获取用户申请状态
    public static function getMemberInfoStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DENY] = '未通过';
        $status_arr[self::$STATUS_UNCHECK] = '待审核';
        $status_arr[self::$STATUS_ALLOW] = '通过';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取申请类型
    public static function getMemberInfoType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$TYPE_TRY] = '试用';
        $type_arr[self::$TYPE_OFFICIAL] = '正式';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取微应用类型
    public static function getAppType($appType = null, $has_choice = true) {
        if ($has_choice) {
            $app_type_arr = array('' => '请选择');
        }
        $app_type_arr[self::$APP_TYPE_FOOD] = '餐饮';
        $app_type_arr[self::$APP_TYPE_PHOTO] = '摄影';
        if ($appType !== null) {
            return $app_type_arr[$appType];
        }
        return $app_type_arr;
    }

}
