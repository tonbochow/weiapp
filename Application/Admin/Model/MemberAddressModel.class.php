<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-02
// | 微信用户地址模型
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

class MemberAddressModel extends Model {

    public static $STATUS_ENABLE = 1; //可用
    public static $STATUS_DISABLE = 0; //不可用

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wx_openid', 'require', '微信用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取微信用户地址状态
    public static function getMemberAddressStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_ENABLE] = '启用';
        $status_arr[self::$STATUS_DISABLE] = '禁用';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取微信用户地址
    public static function getMemberAddress($address_id) {
        $addressModel = M('MemberAddress');
        $map['id'] = $address_id;
        $map['status'] = self::$STATUS_ENABLE;
        $member_address = $addressModel->where($map)->order("is_default desc,create_time asc")->find();
        return $member_address;
    }

}
