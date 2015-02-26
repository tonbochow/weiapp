<?php

// +----------------------------------------------------------------------
// |2015-02-14
// +----------------------------------------------------------------------
// | Author: tonbochow
// +----------------------------------------------------------------------

namespace Home\Controller;

/**
 * 帮助模型
 */
class HelpController extends HomeController {
    public function index() {
        //验证权限
        if (!is_administrator()) {
            $authGroupAccessModel = M('AuthGroupAccess');
            $access_data['uid'] = session('user_auth.uid');
            $group_access = $authGroupAccessModel->where($access_data)->find();
            if ($group_access == false) {
                $this->error('您无权申请试用!');
            }
        }
        $this->display('index');
    }

}
