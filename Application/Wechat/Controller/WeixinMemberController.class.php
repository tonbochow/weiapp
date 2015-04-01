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

        $this->display('index');
    }

}
