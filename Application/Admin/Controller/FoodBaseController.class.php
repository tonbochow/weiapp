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
        $this->checkUserRequire();
        if(strtolower(CONTROLLER_NAME)!='microplatform' && strtolower(ACTION_NAME) != 'food'){
            $this->checkMicroPlatformRequire();
        }
    }

    /**
     * 检测当前登录用户是否满足条件
     */
    protected function checkUserRequire() {
        if (!is_administrator()) {
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
            if($micro_platform == false){
                $this->error('请等待管理员审核!！', '/Admin/Index/index');
            }
        }
    }

    /**
     * 检测当前登录用户的微信公众平台是否满足条件
     */
    protected function checkMicroPlatformRequire() {
        if (!is_administrator()) {
            $microPlatformModel = M('MicroPlatform');
            $mp_data['member_id'] = UID;
            $mp_data['app_type'] = \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD;
            $micro_platform = $microPlatformModel->where($mp_data)->find();
            if ($micro_platform == false) {
                $this->error('请先创建微信公众平台！','/Admin/MicroPlatform/food');
            }
            if ($micro_platform['status'] == \Admin\Model\MicroPlatformModel::$STATUS_DENY) {
                $this->error('您的微信公众平台禁止使用请联系管理员！','/Admin/MicroPlatform/food');
            }
            if ($micro_platform['start_time'] > time()) {
                $this->error('您的微信公众平台开始使用时间未到！','/Admin/MicroPlatform/food');
            }
            if ($micro_platform['end_time'] < time()) {
                $this->error('您的微信公众平台使用期限已到请联系管理员续费！','/Admin/MicroPlatform/food');
            }
            if ($micro_platform['is_bind'] == \Admin\Model\MicroPlatformModel::$NOT_BIND) {
                $this->error('请先登录微信公众平台绑定！','/Admin/MicroPlatform/food');
            }
        }
    }

}
