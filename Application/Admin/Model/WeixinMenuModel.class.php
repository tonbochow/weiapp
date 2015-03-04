<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-02
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 微信公众平台微信菜单模型
 */
class WeixinMenuModel extends Model {

    public static $STATUS_DISABLE = 0; //菜单状态 不可用
    public static $STATUS_ENABLE = 1; //菜单状态 可用
    public static $MENU_TYPE_CLICK = 1; //微信菜单类型:click
    public static $MENU_NAME_CLICK = 'click'; //点击推事件菜单
    public static $MENU_TYPE_VIEW = 2; //微信菜单类型:view
    public static $MENU_NAME_VIEW = 'view'; //跳转url
    public static $MENU_TYPE_SCANCODE_PUSH = 3; //微信菜单类型:scancode_push 扫码推事件 微信版本5.4以上
    public static $MENU_NAME_SCANCODE_PUSH = 'scancode_push'; //扫码推事件 微信版本5.4以上
    public static $MENU_TYPE_SCANCODE_WAITMSG = 4; //微信菜单类型:scancode_waitmsg 扫码推事件且弹出“消息接收中”提示框  微信版本5.4以上
    public static $MENU_NAME_SCANCODE_WAITMSG = 'scancode_waitmsg'; //扫码推事件且弹出“消息接收中”提示框 微信版本5.4以上
    public static $MENU_TYPE_PIC_SYSPHOTO = 5; //微信菜单类型:pic_sysphoto 弹出系统拍照发图  微信版本5.4以上
    public static $MENU_NAME_PIC_SYSPHOTO = 'pic_sysphoto'; //弹出系统拍照发图 微信版本5.4以上
    public static $MENU_TYPE_PIC_PHOTO_OR_ALBUM = 6; //微信菜单类型:pic_photo_or_album 弹出拍照或者相册发图  微信版本5.4以上
    public static $MENU_NAME_PIC_PHOTO_OR_ALBUM = 'pic_photo_or_album'; //弹出拍照或者相册发图 微信版本5.4以上
    public static $MENU_TYPE_PIC_WEIXIN = 7; //微信菜单类型:pic_weixin 弹出微信相册发图器  微信版本5.4以上
    public static $MENU_NAME_PIC_WEIXIN = 'pic_weixin'; //弹出微信相册发图器  微信版本5.4以上
    public static $MENU_TYPE_LOCATION_SELECT = 8; //微信菜单类型:location_select 弹出地理位置选择器  微信版本5.4以上
    public static $MENU_NAME_LOCATION_SELECT = 'location_select'; //弹出地理位置选择器  微信版本5.4以上

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('member_id', 'require', '用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('menu_name', 'require', '微信菜单名称不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('menu_name', '/^([\u0391-\uFFE5]|\w){1,7}$/', '菜单名称长度1-7', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('menu_type', 'require', '微信菜单类型为必选', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
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
        array('pid', '/^[\d]+$/', '父菜单ID只能填正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('c_order', '/^[1|2|3|4|5]$/', '菜单顺序只能填1-5正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('p_order', '/^[1|2|3]$/', '菜单顺序只能填1-3正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('member_id', 'is_login', self::MODEL_INSERT, 'function'),
        array('menu_name', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取微信公众平台菜单状态
    public static function getWxMenuStatus($status = null, $has_choice = true) {
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

    //获取微信公众平台菜单类型(中文)
    public static function getWxCaMenuType($type = null, $has_choice = true, $base = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$MENU_NAME_CLICK] = '点击推事件';
        $type_arr[self::$MENU_NAME_VIEW] = '跳转URL';
        if (!$base) {
            $type_arr[self::$MENU_NAME_SCANCODE_PUSH] = '扫码推事件';
            $type_arr[self::$MENU_NAME_SCANCODE_WAITMSG] = '扫码推事件且弹出“消息接收中”提示框';
            $type_arr[self::$MENU_NAME_PIC_SYSPHOTO] = '弹出系统拍照发图';
            $type_arr[self::$MENU_NAME_PIC_PHOTO_OR_ALBUM] = '弹出拍照或者相册发图';
            $type_arr[self::$MENU_NAME_PIC_WEIXIN] = '弹出微信相册发图器';
            $type_arr[self::$MENU_NAME_LOCATION_SELECT] = '弹出地理位置选择器';
        }
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取微信公众平台菜单类型(英文)
    public static function getWxEnMenuType($type = null, $has_choice = true, $base = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$MENU_TYPE_CLICK] = self::$MENU_NAME_CLICK;
        $type_arr[self::$MENU_TYPE_CLICK] = self::$MENU_NAME_VIEW;
        if (!$base) {
            $type_arr[self::$MENU_TYPE_SCANCODE_PUSH] = self::$MENU_NAME_SCANCODE_PUSH;
            $type_arr[self::$MENU_TYPE_SCANCODE_WAITMSG] = self::$MENU_NAME_SCANCODE_WAITMSG;
            $type_arr[self::$MENU_TYPE_PIC_SYSPHOTO] = self::$MENU_NAME_PIC_SYSPHOTO;
            $type_arr[self::$MENU_TYPE_PIC_PHOTO_OR_ALBUM] = self::$MENU_NAME_PIC_PHOTO_OR_ALBUM;
            $type_arr[self::$MENU_TYPE_PIC_WEIXIN] = self::$MENU_NAME_PIC_WEIXIN;
            $type_arr[self::$MENU_TYPE_LOCATION_SELECT] = self::$MENU_NAME_LOCATION_SELECT;
        }
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    /*
     * $id 菜单id
     * 通过id获取菜单名称
     */
    public static function getWxMenuName($id){
        $weixin_menu = M('WeixinMenu')->where(array('id'=>$id))->find();
        return $weixin_menu['menu_name'];
    }
    
    /**
     * 获取微信公众平台一级菜单个数
     */
    public static  function getTopMenuNum(){
        $top_menu_num = M('WeixinMenu')->where(array('member_id'=>UID,'mp_id'=>MP_ID,'pid'=>0))->count();
        return $top_menu_num;
    }
    
    /**
     * 获取微信公众平台二级菜单个数
     */
    public static function getSubMenuNum($pid){
        $menu_data['member_id']= UID;
        $menu_data['mp_id'] = MP_ID;
        $menu_data['pid'] = $pid;
        $sub_menu_num = M('WeixinMenu')->where($menu_data)->count();
        return $sub_menu_num;
    }
}
