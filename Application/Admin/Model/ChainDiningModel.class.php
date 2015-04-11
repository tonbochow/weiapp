<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-10
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 餐饮连锁餐厅信息模型
 */
class ChainDiningModel extends Model {

    public static $STATUS_ENABLE = 1; //状态 禁用
    public static $STATUS_DISABLE = 0; //状态 启用

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '连锁餐厅负责人id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('chain_dining_name', 'require', '连锁餐厅名称不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mobile', '/^1\d{10}$/', '手机号码不符要求', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('description', 'require', '连锁餐厅简介不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('carousel_fir', 'require', '连锁餐厅第一张轮播不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('carousel_sec', 'require', '连锁餐厅第二张轮播不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('carousel_thr', 'require', '连锁餐厅第三张轮播不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
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

    //获取连锁餐厅信息状态
    public static function getChainDiningStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DISABLE] = '禁用';
        $status_arr[self::$STATUS_ENABLE] = '启用';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //通过mp_id获取连锁餐厅名称
    public static function getChainDiningNameByMpId($mp_id) {
        $chain_dining = M('ChainDining')->where(array('mp_id' => $mp_id))->find();
        return $chain_dining['chain_dining_name'];
    }

    //通过id获取连锁餐厅名称
    public static function getChainDiningNameById($id) {
        $chain_dining = M('ChainDining')->where(array('id' => $id))->find();
        return $chain_dining['chain_dining_name'];
    }

}
