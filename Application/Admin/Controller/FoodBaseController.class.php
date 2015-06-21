<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食基类控制器
 */
class FoodBaseController extends AdminController {

    protected function _initialize() {
        parent::_initialize();
        if (!is_administrator()) {
            //微美食管理员登录获取微信公众平台信息
            $micro_platform = $this->getMpFoodManager();
            if ($micro_platform == false) {
                //微美食店员登录获取微信公众平台信息
                $micro_platform = $this->getMpDiningMember();
                if (!empty($micro_platform)) {
                    $this->checkMicroPlatformRequire($micro_platform, false);
                }
            } else {
                $this->checkMicroPlatformRequire($micro_platform, true);
                define('DINING_ROOM_ID', ''); //定义连锁分店id
            }
            if ($micro_platform == false) {
                $this->error('请无权限登录试用平台,请联系管理员', '/Admin/Public/logout');
            }

            $mp_id = !empty($micro_platform) ? trim($micro_platform['id']) : '';
            $mp_name = !empty($micro_platform['mp_name']) ? trim($micro_platform['mp_name']) : '';
            $appid = !empty($micro_platform['appid']) ? trim($micro_platform['appid']) : '';
            $appsecret = !empty($micro_platform['appsecret']) ? trim($micro_platform['appsecret']) : '';
            $partnerid = !empty($micro_platform['partnerid']) ? trim($micro_platform['partnerid']) : '';
            $partnerkey = !empty($micro_platform['partnerkey']) ? trim($micro_platform['partnerkey']) : '';
            $paysignkey = !empty($micro_platform['paysignkey']) ? trim($micro_platform['paysignkey']) : '';
            $mp_token = !empty($micro_platform['mp_token']) ? trim($micro_platform['mp_token']) : '';
            $support_wxpay = !empty($micro_platform['support_wxpay']) ? trim($micro_platform['support_wxpay']) : '';
            $is_chain = !empty($micro_platform['is_chain']) ? true : false;
            define('IS_CHAIN', $is_chain); //门店是否连锁
            define('MP_ID', $mp_id); //微信公众平台ID
            define('MP_NAME', $mp_name);
            define('APPID', $appid); //微信公众平台APPID  基本参数
            define('APPSECRET', $appsecret); //微信公众平台APPSECRET 基本参数
            define("PARTNERID", $partnerid); //微信公众平台PARTNERID  微信支付必需参数
            define("PARTNERKEY", $partnerkey); //微信公众平台PARTNERKEY  微信支付必需参数
            define("APPKEY", $paysignkey); //微信公众平台APPKEY 微信支付必需参数
            define("MP_TOKEN", $mp_token); //微信公众平台接入token  唯一  非常重要参数
            define("SUPPORT_WXPAY", $support_wxpay);
            $this->assign('mp', $micro_platform);
        }
    }

    /**
     * 检测当前登录用户的微信公众平台是否满足条件
     * $cond true:微美食管理员  false:微美食店员
     */
    protected function checkMicroPlatformRequire($micro_platform, $cond) {
        if ($cond) {
            if (strtolower(CONTROLLER_NAME) != 'microplatform' && strtolower(ACTION_NAME) != 'food') {
                if ($micro_platform['status'] == \Admin\Model\MicroPlatformModel::$STATUS_DENY) {
                    $this->error('您的微信公众平台禁止使用(可能未绑定微信公众平台)！', '/Admin/MicroPlatform/food');
                }
                if ($micro_platform['start_time'] > time()) {
                    $this->error('您的微信公众平台开始使用时间未到！', '/Admin/MicroPlatform/food');
                }
                if ($micro_platform['end_time'] < time()) {
                    $this->error('您的微信公众平台使用期限已到请联系管理员续费！', '/Admin/MicroPlatform/food');
                }
                if ($micro_platform['is_bind'] == \Admin\Model\MicroPlatformModel::$NOT_BIND) {
                    $this->error('请先登录微信公众平台绑定！', '/Admin/MicroPlatform/food');
                }
            }
        } else {
            if ($micro_platform['status'] == \Admin\Model\MicroPlatformModel::$STATUS_DENY) {
                $this->error('您的微信公众平台禁止使用(可能未绑定微信公众平台)！', '/Admin/MicroPlatform/food');
            }
            if ($micro_platform['start_time'] > time()) {
                $this->error('您的微信公众平台开始使用时间未到！', '/Admin/MicroPlatform/food');
            }
            if ($micro_platform['end_time'] < time()) {
                $this->error('您的微信公众平台使用期限已到请联系管理员续费！', '/Admin/MicroPlatform/food');
            }
            if ($micro_platform['is_bind'] == \Admin\Model\MicroPlatformModel::$NOT_BIND) {
                $this->error('请先登录微信公众平台绑定！', '/Admin/MicroPlatform/food');
            }
        }
    }

    /**
     * 检测微美食管理员登录获取微信公众平台信息
     */
    protected function getMpFoodManager() {
        $microPlatformModel = M('MicroPlatform');
        $platform_data['member_id'] = UID;
        $platform_data['app_type'] = \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD;
        $micro_platform = $microPlatformModel->where($platform_data)->find();
        if ($micro_platform == false) {
            return false;
        }
        return $micro_platform;
    }

    /**
     * 检测微美食店员登录获取微信公众平台信息
     */
    protected function getMpDiningMember() {
        $diningMemberModel = M('DiningMember');
        $map['member_id'] = UID; //美食店员
        $map['status'] = \Admin\Model\DiningMemberModel::$STATUS_ENABLED;
        $dining_member = $diningMemberModel->where($map)->find();
        if ($dining_member == false) {
            return false;
        }
        define('DINING_ROOM_ID', $dining_member['dining_room_id']); //定义连锁分店id
        $platform_map['mp_id'] = $dining_member['mp_id'];
        $micro_platform = M('MicroPlatform')->where($platform_map)->find();
        return $micro_platform;
    }

}
