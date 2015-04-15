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
 * 餐饮订单模型
 */
class FoodOrderModel extends Model {

    public static $STATUS_CANCEL = -1; //订单状态 已取消
    public static $STATUS_COMMITED = 1; //订单状态 已提交
    public static $STATUS_WXPAYED = 2; //订单状态 已支付待送餐
    public static $STATUS_DELIVERY = 3; //订单状态 送餐中
    public static $STATUS_FINISHED = 4; //订单状态 已完成
    public static $TYPE_DINING_ROOM = 1; //订单类型 0 到餐厅用餐
    public static $TYPE_DELIVERY_HOME = 2; //订单类型 1 送餐到家
    public static $PAY_TYPE_WEIXIN = 1; //支付类型:微信支付
    public static $PAY_TYPE_ZHIFUBAO = 2; //支付类型:支付宝支付
    public static $PAY_TYPE_OFFLINE = 3; //支付类型:线下支付
    public static $PRINT_STATUS_NO = 0; //打印状态:未打印
    public static $PRINT_STATUS_YES = 1; //打印状态:已打印

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '下单用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('menu_name', 'require', '微信菜单名称不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('dining_room_id', 'require', '下单餐厅id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('order_no', 'require', '订单编号order_no不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('type', 'require', '订单类型类型为必选', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('pay_type', 'require', '订单支付类型为必选', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('menu_url', '/^(([a-zA-Z]+)(:\/\/))?([a-zA-Z]+)\.(\w+)\.([\w.]+)(\/([\w]+)\/?)*(\/[a-zA-Z0-9]+\.(\w+))*(\/([\w]+)\/?)*(\?(\w+=?[\w]*))*((&?\w+=?[\w]*))*$/', '菜单view类型URL不正确', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('mp_original_id', 'require', '微信公众平台原始ID不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('mp_original_id', '/^[a-zA-Z_]\w{1,256}$/', '微信公众平台原始ID以字母或下划线开头', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('mp_wxcode', 'require', '微信公众平台微信号不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('mp_wxcode', '/^[a-zA-Z_]\w{1,128}$/', '微信号以字母或下划线开头', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('appid', 'require', '微信公众平台appid不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('appid', '/^\w{1,256}$/', 'appid以字母数字或下划线开头最大长度256', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('appsecret', 'require', '微信公众平台appsecret不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('appsecret', '/^\w{1,256}$/', 'appsecret以字母数字或下划线开头最大长度256', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('partnerid', '/^\w{1,256}$/', 'partnerid以字母数字或下划线开头最大长度256', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('partnerkey', '/^\w{1,256}$/', 'partnerkey以字母数字或下划线开头最大长度256', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('paysignkey', '/^\w{1,256}$/', 'paysignkey以字母数字或下划线开头最大长度256', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('pid', '/^[\d]+$/', '父菜单ID只能填正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('c_order', '/^[1|2|3|4|5]$/', '菜单顺序只能填1-5正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('p_order', '/^[1|2|3]$/', '菜单顺序只能填1-3正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取订单状态
    public static function getFoodOrderStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_CANCEL] = '已取消';
        $status_arr[self::$STATUS_COMMITED] = '已提交';
        $status_arr[self::$STATUS_WXPAYED] = '已支付';
        $status_arr[self::$STATUS_DELIVERY] = '送餐中';
        $status_arr[self::$STATUS_FINISHED] = '已完成';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取订单类型
    public static function getFoodOrderType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$TYPE_DINING_ROOM] = '到餐厅用餐';
        $type_arr[self::$TYPE_DELIVERY_HOME] = '送餐到家';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取订单支付类型
    public static function getFoodPayType($type = null, $has_choice = true, $zfb = false) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$PAY_TYPE_WEIXIN] = '微信支付';
        $type_arr[self::$PAY_TYPE_OFFLINE] = '线下结算';
        if ($zfb) {
            $type_arr[self::$PAY_TYPE_ZHIFUBAO] = '支付宝支付';
        }
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取订单打印状态
    public static function getFoodOrderPrintStatus($print = null, $has_choice = true) {
        if ($has_choice) {
            $print_arr = array('' => '请选择');
        }
        $print_arr[self::$PRINT_STATUS_NO] = '未打印';
        $print_arr[self::$PRINT_STATUS_YES] = '已打印';
        if ($print !== null) {
            return $print_arr[$print];
        }
        return $print_arr;
    }

    //获取订单order_no
    public static function getFoodOrderNo($order_id) {
        $order_no = M('FoodOrder')->where(array('id' => $order_id))->field('order_no');
        return $order_no;
    }

    //获取订单信息
    public static function getFoodOrder($order_id) {
        return M('FoodOrder')->where(array('id' => $order_id))->find();
    }

}
