<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-31
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端微信用户控制器
 */
class WeixinMemberController extends BaseController {

    //用户个人中心
    public function index() {
        $foodOrderModel = M('FoodOrder');
        $map['mp_id'] = MP_ID;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        //检索待付款订单数量
        $map['status'] = \Admin\Model\FoodOrderModel::$STATUS_COMMITED;
        $map['pay_type'] = \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN;
        $need_pay_count = $foodOrderModel->where($map)->count();
        //检索送餐中订单数量
        $map['status'] = \Admin\Model\FoodOrderModel::$STATUS_DELIVERY;
        unset($map['pay_type']);
        $delivery_count = $foodOrderModel->where($map)->count();
        //检索已完成订单数量
        $map['status'] = \Admin\Model\FoodOrderModel::$STATUS_FINISHED;
        $finish_count = $foodOrderModel->where($map)->count();

        $this->assign('status_delivery', \Admin\Model\FoodOrderModel::$STATUS_DELIVERY);
        $this->assign('status_need_pay', \Admin\Model\FoodOrderModel::$STATUS_COMMITED);
        $this->assign('status_finish', \Admin\Model\FoodOrderModel::$STATUS_FINISHED);
        $this->assign('weixin_pay', \Admin\Model\FoodOrderModel::$PAY_TYPE_WEIXIN);
        $this->assign('need_pay_count', $need_pay_count);
        $this->assign('delivery_count', $delivery_count);
        $this->assign('finish_count', $finish_count);
        $this->display('index');
    }

    //用户账户面板
    public function manage() {

        $this->meta_title = $this->mp['mp_name'] . "微信用户账户管理面板";
        $this->display('manage');
    }

    //微信用户查看个人信息
    public function info() {
        $this->meta_title = $this->mp['mp_name'] . "微信用户个人信息";
        $this->display('info');
    }

    //微信用户账户绑定
    public function bind() {
        if (IS_POST) {
            $username = I('post.username', '', 'trim');
            $map['username'] = $username;
            $password = I('post.password', '', 'trim');
            $map['password'] = md5($password);
            $email = I('post.email', '', 'trim');
            $map['email'] = $email;
            $ucenter_member = M('UcenterMember')->where($map)->find();
            if ($ucenter_member == false) {
                $this->error('绑定失败,您输入的绑定信息有误', '', true);
            }
            $weixinMemberModel = M('WeixinMember');
            $data['member_id'] = $ucenter_member['id'];
            $data['update_time'] = time();
            $bind = $weixinMemberModel->where(array('wx_openid' => $this->weixin_userinfo['wx_openid'], 'mp_id' => MP_ID))->save($data);
            if ($bind) {
                $this->success('绑定成功', '', true);
            }
            $this->error('绑定失败', '', true);
        }
        $username = '';
        if ($this->weixin_userinfo['member_id']) {
            $user_info = M(UcenterMember)->where(array('id' => $this->weixin_userinfo['member_id']))->find();
            $username = $user_info['username'];
        }
        $this->assign('username', $username);
        $this->meta_title = $this->mp['mp_name'] . "微信用户绑定帐号";
        $this->display('bind');
    }

}
