<?php

// +----------------------------------------------------------------------
// |2015-02-14
// +----------------------------------------------------------------------
// | Author: tonbochow
// +----------------------------------------------------------------------

namespace Home\Controller;

/**
 * 试用模型
 */
class TryController extends HomeController {
    public function index() {
        if(!is_login()){//试用需登录
            redirect('/Home/User/login');
        }
//        dump(session('user_auth'));
        //是否已申请试用
        $memberInfo = M('MemberInfo')->where(array('member_id'=>session('user_auth.uid')))->find();
        $this->assign('memberInfo',$memberInfo);
        $this->display('index');
    }

}
