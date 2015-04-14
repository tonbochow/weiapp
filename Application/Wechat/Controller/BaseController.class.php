<?php

// +----------------------------------------------------------------------
// | 微信端控制器基类
// | Author: tonbochow 2015-03-28
// +----------------------------------------------------------------------

namespace Wechat\Controller;

use Think\Controller;

/**
 * 微信前台公共控制器
 * 为防止多分组Controller名称冲突，公共Controller名称统一使用分组名称
 */
class BaseController extends Controller {

    protected $mp = ''; //微信公众平台信息
    protected $weixin_userinfo = ''; //微信登录用户信息

    // 空操作，用于输出404页面 

    public function _empty() {
        $this->redirect('Index/index');
    }

    protected function _initialize() {
        //1 验证是否为微信浏览器内打开
        $is_weixin_browser = is_weixin_browser();
        if ($is_weixin_browser == false) {//请从微信浏览器内打开
            $this->redirect('Exception/index');
        }
        //2 验证微信版本是否6.0及以上(领取卡劵必须)
        $weixin_browser = get_weixin_browser_version();
        if (!$weixin_browser) {//为获得更好体验请将微信版本升级到6.0及以上
            $this->redirect('/Exception/version');
        }
        //3 获取get|post参数token检索是否存在 设置微信支付参数为常量 公众平台信息为对象
        $mp_token = I('request.t', '', 'trim'); //获取get或post的t即mp_token值
        $mp = $this->getMpInfo($mp_token);
        $this->mp = $mp;
        define("MP_ID", $mp['id']);
        define("MP_NAME", $mp['mp_name']);
        define("SIGNTYPE", "SHA1");
        define("APPID", trim($mp['appid']));
        define("APPSERCERT", trim($mp['appsecret']));
        define("APPKEY", trim($mp['paysignkey']));
        define("PARTNERKEY", trim($mp['partnerkey']));
        define("PARTNERID", trim($mp['partnerid']));
        define("KEY", trim($mp['key']));
        define("MCHID", trim($mp['mchid']));
        //4 检测是否登录(获取到openid即可)
        $weixin_userinfo = $this->getWeixinUserInfo();
        $this->weixin_userinfo = $weixin_userinfo;
        $this->assign('mp', $this->mp);
        $this->assign('weixin_userinfo', $this->weixin_userinfo);
        //5 设置微信分享基本参数
        $signPackage = \Admin\Model\MicroPlatformModel::getJsApiPrams(APPID);
        $this->assign('signPackage', $signPackage);
        $cate_id = I('request.cate_id', '', 'trim');
        $key = I('request.key', '', 'trim');
        $this->assign('cate_id', $cate_id);
        $this->assign('key', $key);
        //检索购餐车菜品或套餐数量
        $car_num = M('FoodCarDetail')->where(array('mp_id' => MP_ID, 'wx_openid' => $this->weixin_userinfo['wx_openid']))->count();
//        $car_num = M('FoodCarDetail')->where(array('mp_id'=>MP_ID,'wx_openid'=>'wx_abcdef'))->count();
        $this->assign('car_num', $car_num);
    }

    //获取微信公众平台信息
    protected function getMpInfo($mp_token) {
        $mp_info = \Admin\Model\MicroPlatformModel::getMpByToken($mp_token);
        if ($mp_info == false) {
            $this->redirect('/Wechat/Exception/mp/mp_error/未获取到微信公众平台信息');
        }
        if ($mp_info['status'] == \Admin\Model\MicroPlatformModel::$STATUS_DENY) {
            $this->redirect('/Wechat/Exception/mp/mp_error/您的微信公众平台禁止使用,请联系管理员');
        }
        if ($mp_info['start_time'] > time()) {
            $this->redirect('/Wechat/Exception/mp/mp_error/您的微信公众平台开始使用时间未到');
        }
        if ($mp_info['end_time'] < time()) {
            $this->redirect('/Wechat/Exception/mp/mp_error/您的微信公众平台使用期限已到请联系管理员续费');
        }
        if ($mp_info['is_bind'] == \Admin\Model\MicroPlatformModel::$NOT_BIND) {
            $this->redirect('/Wechat/Exception/mp/mp_error/请先登录微信公众平台绑定');
        }
        return $mp_info;
    }

    //获取微信用户信息
    protected function getWeixinUserInfo() {
        $wx_openid = session('wx_openid');
        if (empty($wx_openid)) {//用户未登录
            $current_url = get_current_url();
            //先通过基本授权snsapi_base获取微信用户信息是否已存在于系统
            $get_code = I('get.code');
            $get_state = I('get.state');
            if (empty($get_code) && empty($get_state)) {//state =1 为snsapi_base模式
                $get_code_url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' . APPID . '&redirect_uri=' . $current_url . '&response_type=code&scope=snsapi_base&state=1#wechat_redirect';
                header("Location:$get_code_url");
            } else if (!empty($get_code) && ($get_state == 1)) {//微信服务器返回code和state  获取access_token凭证
                $base_access_token_info = \Admin\Model\MicroPlatformModel::getSnsAccessTokenByCode(APPID, APPSERCERT, $get_code); //同时获取到微信用户openid
                $wx_openid = $base_access_token_info['openid'];
                session('temp_openid', $wx_openid); //设置临时wx_openid 微信用户不同意时用
                if (empty($base_access_token_info['access_token'])) {//获取access_token失败(服务号未设置网页授权域名)
                    $this->redirect('/Wechat/Exception/mp/mp_error/微信公众平台可能未设置网页授权域名');
                }
                //检索系统中是否已存在该openid 1 存在直接设置session 2 不存在snsapi_userinfo尝试获取用户信息
                $member_weixin = \Admin\Model\MemberWeixinModel::getWeixinUserinfo($wx_openid);
                if ($member_weixin == false) {
                    //尝试通过openid直接拉取微信用户信息(只有关注者才能拉取到)
                    $subscribe_weixin_user = \Admin\Model\MicroPlatformModel::getWeixinUserInfoByOpenid(APPID, APPSERCERT, $wx_openid);
                    if (!empty($subscribe_weixin_user['openid'])) {
                        $memberWeixinModel = D('Admin/MemberWeixin');
                        $member_weixin_data['mp_id'] = MP_ID;
                        $member_weixin_data['wx_openid'] = $wx_openid;
                        $member_weixin_data['nickname'] = $subscribe_weixin_user['nickname'];
                        $member_weixin_data['sex'] = $subscribe_weixin_user['sex'];
                        $member_weixin_data['province'] = $subscribe_weixin_user['province'];
                        $member_weixin_data['city'] = $subscribe_weixin_user['city'];
                        $member_weixin_data['country'] = $subscribe_weixin_user['country'];
                        $member_weixin_data['headimgurl'] = $subscribe_weixin_user['headimgurl'];
                        $member_weixin_data['privilege'] = $subscribe_weixin_user['privilege'];
                        if ($memberWeixinModel->create($member_weixin_data, \Admin\Model\MemberWeixinModel::MODEL_INSERT)) {
                            $member_weixin_id = $memberWeixinModel->add();
                        }
                        session('wx_openid', $wx_openid);
                    } else {//尝试oauth2 授权模式拉取
                        $userinfo_url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' . APPID . '&redirect_uri=' . $current_url . '&response_type=code&scope=snsapi_userinfo&state=2#wechat_redirect';
                        header("Location:$userinfo_url");
                    }
                } else {
                    session('wx_openid', $member_weixin['wx_openid']);
                }
            } else if (!empty($get_code) && ($get_state == 2)) {//snsapi_userinfo模式获取微信用户详细信息
                $userinfo_access_token_info = \Admin\Model\MicroPlatformModel::getSnsAccessTokenByCode(APPID, APPSERCERT, $get_code);
                $wx_openid = $userinfo_access_token_info['openid'];
                if (empty($userinfo_access_token_info['access_token'])) {//获取access_token失败(服务号未设置网页授权域名)
                    $this->redirect('/Wechat/Exception/mp/mp_error/微信公众平台可能未设置网页授权域名');
                }
                $weixin_userinfo = \Admin\Model\MicroPlatformModel::getSnsUserinfoByOpenid($userinfo_access_token_info['access_token'], $wx_openid);
                $memberWeixinModel = D('Admin/MemberWeixin');
                $member_weixin_data['mp_id'] = MP_ID;
                $member_weixin_data['wx_openid'] = $wx_openid;
                $member_weixin_data['nickname'] = $weixin_userinfo['nickname'];
                $member_weixin_data['sex'] = $weixin_userinfo['sex'];
                $member_weixin_data['province'] = $weixin_userinfo['province'];
                $member_weixin_data['city'] = $weixin_userinfo['city'];
                $member_weixin_data['country'] = $weixin_userinfo['country'];
                $member_weixin_data['headimgurl'] = $weixin_userinfo['headimgurl'];
                $member_weixin_data['privilege'] = $weixin_userinfo['privilege'];
                if ($memberWeixinModel->create($member_weixin_data, \Admin\Model\MemberWeixinModel::MODEL_INSERT)) {
                    $member_weixin_id = $memberWeixinModel->add();
                }
                session('wx_openid', $wx_openid);
            } else if (empty($get_code) && !empty($get_state)) {//snaapi_userinfo 用户不同意授权 仅能获取openid
//                $base_access_token_info = \Admin\Model\MicroPlatformModel::getSnsAccessTokenByCode(APPID, APPSERCERT, I('get.code')); //同时获取到微信用户openid
//                $wx_openid = $base_access_token_info['openid'];
                $wx_openid = session('temp_openid'); //使用临时设置的openid
                session('temp_openid', null); //销毁临时openid
                //将用户openid插入到数据库中
                $memberWeixinModel = D('Admin/MemberWeixin');
                $member_weixin_data['mp_id'] = MP_ID;
                $member_weixin_data['wx_openid'] = $wx_openid;
                if ($memberWeixinModel->create($member_weixin_data, \Admin\Model\MemberWeixinModel::MODEL_INSERT)) {
                    $member_weixin_id = $memberWeixinModel->add();
                }
                session('wx_openid', $wx_openid);
            }
        }
        $member_weixin_info = M('MemberWeixin')->where(array('wx_openid' => $wx_openid, 'mp_id' => MP_ID))->find();
        return $member_weixin_info;
    }

}
