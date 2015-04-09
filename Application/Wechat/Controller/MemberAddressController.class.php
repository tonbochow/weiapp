<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-09
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端微信用户地址控制器
 */
class MemberAddressController extends BaseController {

    //用户地址
    public function index() {
        $memberAddressModel = M('MemberAddress');
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $address_count = $memberAddressModel->where($map)->count();
        $page_num = 10; 
        import('Common.Extends.Page.BootstrapPage');
        $Page = new \BootstrapPage($address_count, $page_num);
        $show = $Page->show();
        $member_addrs = $memberAddressModel->where($map)->limit($Page->firstRow . ',' . $Page->listRows)->select();
         
        $this->assign('page', $show);
        $this->assign('member_addrs',$member_addrs);
        $this->meta_title = $this->mp['mp_name'] . "微信用户地址信息";
        $this->display('index');
    }

}
