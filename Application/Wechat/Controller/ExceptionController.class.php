<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-28
// +----------------------------------------------------------------------

namespace Wechat\Controller;

use Think\Controller;

/**
 * 异常错误控制器
 */
class ExceptionController extends Controller {

    //不是微信内置浏览器打开错误
    public function index() {

        $this->display('index');
    }

    //微信版本错误
    public function version() {
        $this->display('version');
    }

    //微信公众平台错误
    public function mp() {
        $mp_error = I('get.mp_error');
        $this->assign('mp_error', $mp_error);
        $this->display('mp_error');
    }

}
