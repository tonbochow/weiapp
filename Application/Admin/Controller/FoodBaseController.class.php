<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮基类控制器
 */
class FoodBaseController extends AdminController {

    protected function _initialize() {
        parent::_initialize();
        if(!is_administrator()) {
            $this->checkUserRequire();
            if (strtolower(CONTROLLER_NAME) != 'microplatform' && strtolower(ACTION_NAME) != 'food') {
                $this->checkMicroPlatformRequire();
            }
            $microPlatformModel = M('MicroPlatform');
            $platform_data['member_id'] = UID;
            $platform_data['app_type'] = \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD;
            $micro_platform = $microPlatformModel->where($platform_data)->find();
            if ($micro_platform == false) {//可能是连锁分店店员登录
                $dining_member = $this->CheckDiningMember();
                if (empty($dining_member)) {
                    $this->error('您无权登录使用平台,请联系联系连锁总店负责人', '/Admin/Public/logout');
                }
                $platform_map['mp_id'] = $dining_member['mp_id'];
                $micro_platform = $microPlatformModel->where($platform_map)->find();
                if ($micro_platform['status'] == \Admin\Model\MicroPlatformModel::$STATUS_DENY) {
                    $this->error('您的微信公众平台禁止使用(可能负责人到期未续费)！', '/Admin/Public/logout');
                }
                if ($micro_platform['start_time'] > time()) {
                    $this->error('您的微信公众平台开始使用时间未到！', '/Admin/Public/logout');
                }
                if ($micro_platform['end_time'] < time()) {
                    $this->error('您的微信公众平台使用期限已到请联系管理员续费！', '/Admin/Public/logout');
                }
                if ($micro_platform['is_bind'] == \Admin\Model\MicroPlatformModel::$NOT_BIND) {
                    $this->error('请先登录微信公众平台绑定！', '/Admin/Public/logout');
                }
                define('DINING_ROOM_ID', $dining_member['dining_room_id']); //定义连锁分店id
            } else {
                define('DINING_ROOM_ID', ''); //定义连锁分店id
            }
            $mp_id = !empty($micro_platform) ? $micro_platform['id'] : '';
            $appid = !empty($micro_platform['appid']) ? $micro_platform['appid'] : '';
            $appsecret = !empty($micro_platform['appsecret']) ? trim($micro_platform['appsecret']) : '';
            $partnerid = !empty($micro_platform['partnerid']) ? trim($micro_platform['partnerid']) : '';
            $partnerkey = !empty($micro_platform['partnerkey']) ? trim($micro_platform['partnerkey']) : '';
            $paysignkey = !empty($micro_platform['paysignkey']) ? trim($micro_platform['paysignkey']) : '';
            $mp_token = !empty($micro_platform['mp_token']) ? trim($micro_platform['mp_token']) : '';
            $is_chain = !empty($micro_platform['is_chain']) ? true : false;
            define('IS_CHAIN', $is_chain); //餐厅是否连锁
            define('MP_ID', $mp_id); //微信公众平台ID
            define('APPID', $appid); //微信公众平台APPID  基本参数
            define('APPSERCERT', $appsecret); //微信公众平台APPSERCERT 基本参数
            define("PARTNERID", $partnerid); //微信公众平台PARTNERID  微信支付必需参数
            define("PARTNERKEY", $partnerkey); //微信公众平台PARTNERKEY  微信支付必需参数
            define("APPKEY", $paysignkey); //微信公众平台APPKEY 微信支付必需参数
            define("MP_TOKEN", $mp_token); //微信公众平台接入token  唯一  非常重要参数
        }
    }

    /**
     * 检测当前登录用户是否满足条件
     */
    protected function checkUserRequire() {
        if (!is_administrator()) {
            //检测是否是连锁分店店员登录(平台可使用情况才能分配连锁店员)
            $dining_member = $this->CheckDiningMember();
            if ($dining_member == false) {//连锁分店不存在该用户则检测该用户是否为微信平台管理者
                $memberInfoModel = M('MemberInfo');
                $member_info = $memberInfoModel->where(array('member_id' => UID))->find();
                if ($member_info == false) {
                    $this->error('您的信息不存在！', '/Admin/Public/login');
                }
                if ($member_info['status'] != \Home\Model\MemberInfoModel::$STATUS_ALLOW) {
                    $this->error('您无权创建公众平台及其他应用！', '/Admin/Public/logout');
                }
                if ($member_info['start_time'] > time() || $member_info['end_time'] < time()) {
                    $this->error('您使用期限未开始或已过期请联系管理员续费！', '/Admin/Index/index');
                }
                $microPlatformModel = M('MicroPlatform');
                $mp_data['member_id'] = UID;
                $mp_data['app_type'] = \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD;
                $micro_platform = $microPlatformModel->where($mp_data)->find();
                if ($micro_platform == false) {
                    $this->error('请等待管理员审核!！', '/Admin/Index/index');
                }
            }
        }
    }

    /**
     * 检测当前登录用户的微信公众平台是否满足条件
     */
    protected function checkMicroPlatformRequire() {
        if (!is_administrator()) {
            //检测是否是连锁分店店员登录(平台可使用情况才能分配连锁店员)
            $dining_member = $this->CheckDiningMember();
            if ($dining_member == false) {//连锁分店不存在该用户则检测该用户是否为微信平台管理者
                $microPlatformModel = M('MicroPlatform');
                $mp_data['member_id'] = UID;
                $mp_data['app_type'] = \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD;
                $micro_platform = $microPlatformModel->where($mp_data)->find();
                if ($micro_platform == false) {
                    $this->error('请先创建微信公众平台！', '/Admin/MicroPlatform/food');
                }
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
    }

    //检测当前用户是否餐厅店员(dining_member表)
    protected function CheckDiningMember() {
        $diningMemberModel = M('DiningMember');
        $map['member_id'] = UID; //餐饮店员
        $map['status'] = \Admin\Model\DiningMemberModel::$STATUS_ENABLED;
        $dining_member = $diningMemberModel->where($map)->find();
        return $dining_member;
    }

}
