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
 * 美食连锁门店分店模型
 */
class DiningRoomModel extends Model {

    public static $STATUS_DISABLED = 0; //状态 禁用
    public static $STATUS_ENABLED = 1; //状态 启用
    public static $IS_CHAIN = 1; //连锁
    public static $NOT_CHAIN = 0; //非连锁
    public static $TYPE_DINING_HOME = 3; //门店用餐和配送到家同时支持
    public static $TYPE_DINING = 1; //仅支持到门店用餐
    public static $TYPE_HOME = 2; //仅支持配送到家
    public static $PAY_TYPE_WEIXIN = 1; //支付类型:微信支付
    public static $PAY_TYPE_ZHIFUBAO = 2; //支付类型:支付宝支付
    public static $PAY_TYPE_OFFLINE = 3; //支付类型:线下支付
    public static $PAY_TYPE_WEIXIN_OFFLINE = 4; //支付类型:微信支付和线下支付

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('member_id', 'require', '下单用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('dining_name', 'require', '门店名称不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('dining_header', 'require', '门店负责人不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('description', 'require', '门店描述不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('type', 'require', '订单类型类型为必选', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('pay_type', 'require', '订单支付类型为必选', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取门店分店状态
    public static function getDiningRoomStatus($status = null, $has_choice = true) {
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

    //获取门店名称
    public static function getDiningRoomName($id) {
        $dining_room = M('DiningRoom')->where(array('id' => $id))->find();
        return $dining_room['dining_name'];
    }

    //获取所有门店拼接的名称
    public static function getAllDiningRoomNames() {
        $dining_rooms = M('DiningRoom')->where(array('mp_id' => MP_ID))->select();
        if (empty($dining_rooms)) {
            return '';
        }
        $dining_room_str = '';
        foreach ($dining_rooms as $dining_room) {
            $dining_room_str .= $dining_room['dining_name'];
        }
        return $dining_room_str;
    }

    //获取门店是否连锁
    public static function getDiningRoomChain($chain = null, $has_choice = true) {
        if ($has_choice) {
            $chain_arr = array('' => '请选择');
        }
        $chain_arr[self::$IS_CHAIN] = '连锁';
        $chain_arr[self::$NOT_CHAIN] = '非连锁';
        if ($chain !== null) {
            return $chain_arr[$chain];
        }
        return $chain_arr;
    }

    //获取门店类型
    public static function getDiningRoomType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$TYPE_DINING_HOME] = '门店用餐和配送到家';
        $type_arr[self::$TYPE_DINING] = '门店用餐';
        $type_arr[self::$TYPE_HOME] = '配送到家';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }
    
    //微信用户选择门店类型
    public static function getWeixinDiningRoomType($type = null, $has_choice = true){
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$TYPE_DINING] = '门店用餐';
        $type_arr[self::$TYPE_HOME] = '配送到家';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }
    
    //获取门店支付类型
    public static function getDiningRoomPayType($type = null, $has_choice = true, $zfb = false) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$PAY_TYPE_WEIXIN] = '微信支付';
        $type_arr[self::$PAY_TYPE_OFFLINE] = '线下结算';
        $type_arr[self::$PAY_TYPE_WEIXIN_OFFLINE] = '微信支付和线下支付';
        if ($zfb) {
            $type_arr[self::$PAY_TYPE_ZHIFUBAO] = '支付宝支付';
        }
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }
    
    //微信用户选择门店支付类型
    public static function getWeixinDiningRoomPayType($type = null, $has_choice = true, $zfb = false){
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
    
    public static function getDiningRoom($dining_room_id){
        $dining_room = M('DiningRoom')->where(array('id'=>$dining_room_id))->find();
        return $dining_room;
    }
}
