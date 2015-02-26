<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-02-26
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 微信公众平台模型
 */
class MicroPlatformModel extends Model {

    public static $STATUS_DENY = 0; //用户状态 待审核
    public static $STATUS_ALLOW = 1; //用户状态 申请通过
    public static $MP_TYPE_SERVICE = 1; //微信工作平台类型：服务号
    public static $MP_TYPE_SUBSCRIBE = 2; //微信工作平台类型：订阅号
    public static $MP_TYPE_COMPANY = 3; //微信工作平台类型：企业号
    public static $APP_TYPE_FOOD = 1; //微应用类型1餐饮
    public static $APP_TYPE_PHOTO = 2; //微应用类型2摄影
    public static $WX_PAY_ENABLE = 1; //支持微信支付
    public static $WX_PAY_DISABLE = 0; //不支持微信支付
    public static $IS_CHAIN = 1; //连锁
    public static $NOT_CHAIN = 0; //非连锁

    /* 自动验证规则 */
    protected $_validate = array(
        array('name', '/^[a-zA-Z]\w{0,39}$/', '文档标识不合法', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('name', 'checkName', '标识已经存在', self::VALUE_VALIDATE, 'callback', self::MODEL_BOTH),
        array('title', 'require', '标题不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title', '1,80', '标题长度不能超过80个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
        array('level', '/^[\d]+$/', '优先级只能填正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        //TODO: 外链编辑验证
        //array('link_id', 'url', '外链格式不正确', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('description', '1,140', '简介长度不能超过140个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
        array('category_id', 'require', '分类不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_INSERT),
        array('category_id', 'require', '分类不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_UPDATE),
        array('category_id', 'checkCategory', '该分类不允许发布内容', self::EXISTS_VALIDATE, 'callback', self::MODEL_UPDATE),
        array('model_id,category_id', 'checkModel', '该分类没有绑定当前模型', self::MUST_VALIDATE, 'callback', self::MODEL_INSERT),
        array('deadline', '/^\d{4,4}-\d{1,2}-\d{1,2}(\s\d{1,2}:\d{1,2}(:\d{1,2})?)?$/', '日期格式不合法,请使用"年-月-日 时:分"格式,全部为数字', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('create_time', '/^\d{4,4}-\d{1,2}-\d{1,2}(\s\d{1,2}:\d{1,2}(:\d{1,2})?)?$/', '日期格式不合法,请使用"年-月-日 时:分"格式,全部为数字', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('title', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        array('description', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        array('root', 'getRoot', self::MODEL_BOTH, 'callback'),
        array('link_id', 'getLink', self::MODEL_BOTH, 'callback'),
        array('attach', 0, self::MODEL_INSERT),
        array('view', 0, self::MODEL_INSERT),
        array('comment', 0, self::MODEL_INSERT),
        array('extend', 0, self::MODEL_INSERT),
        array('create_time', 'getCreateTime', self::MODEL_BOTH, 'callback'),
        array('reply_time', 'getCreateTime', self::MODEL_INSERT, 'callback'),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
        array('status', 'getStatus', self::MODEL_BOTH, 'callback'),
        array('position', 'getPosition', self::MODEL_BOTH, 'callback'),
        array('deadline', 'strtotime', self::MODEL_BOTH, 'function'),
    );

    //获取微信公众平台状态
    public static function getMpStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DENY] = '禁用';
        $status_arr[self::$STATUS_ALLOW] = '启用';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取微信公众平台类型
    public static function getMpType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$MP_TYPE_SERVICE] = '服务号';
        $type_arr[self::$MP_TYPE_SUBSCRIBE] = '订阅号';
        $type_arr[self::$MP_TYPE_COMPANY] = '企业号';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取微信公众平台微应用类型
    public static function getMpAppType($appType = null, $has_choice = true) {
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
