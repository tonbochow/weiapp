<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-30
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 微信用户模型
 */
class MemberWeixinModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 不可用
    public static $STATUS_ENABLED = 1; //状态 可用
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wx_openid', 'require', '微信用户openid不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wx_openid', '', '此微信openid已经存在！', 0, 'unique',1),
        array('wechat_name', '/^\w{1,32}$/', '微信号不正确', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wechat_name', '', '此微信号已经存在！', 0, 'unique'),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取微信用户信息
    public static function getWeixinUserinfo($wx_openid) {
        return M('MemberWeixin')->where(array('wx_openid' => $wx_openid, 'mp_id' => MP_ID))->find();
    }

    //获取微信用户状态
    public static function getWeixinUserStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DISABLED] = '不可用';
        $status_arr[self::$STATUS_ENABLED] = '可用';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取微信用户昵称
    public static function getWeixinUserNickname($wx_openid) {
        return M('MemberWeixin')->where(array('wx_openid' => $wx_openid, 'mp_id' => MP_ID))->field('nickname');
    }

}
