<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-12
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 美食门店店员模型
 */
class DiningMemberModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 禁用
    public static $STATUS_ENABLED = 1; //状态 启用
    public static $ROLE_STAFF = 1; //员工
    public static $ROLE_MANAGER = 0; //门店经理

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '门店用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('dining_room_id', 'require', '门店ID不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('pay_type', 'require', '订单支付类型为必选', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取门店员工状态
    public static function getDiningMemberStatus($status = null, $has_choice = true) {
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

    //获取门店员工角色
    public static function getDiningMemberRoleType($role, $has_choice = true) {
        if ($has_choice) {
            $role_arr = array('' => '请选择');
        }
        $role_arr[self::$ROLE_STAFF] = '店员';
        $role_arr[self::$ROLE_MANAGER] = '经理';
        if ($role !== null) {
            return $role_arr[$role];
        }
        return $role_arr;
    }

    //获取门店名称
    public static function getDiningRoomName($id) {
        $dining_room = M('DiningRoom')->where(array('id' => $id))->find();
        return $dining_room['dining_name'];
    }

    //获取门店列表
    public static function getDiningRooms() {
        $dining_rooms = M('DiningRoom')->where(array('mp_id' => MP_ID))->select();
        return $dining_rooms;
    }

}
