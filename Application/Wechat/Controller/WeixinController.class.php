<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-13
// +----------------------------------------------------------------------

namespace Wechat\Controller;

use Think\Controller;

/**
 * 微信公众平台控制器
 */
class WeixinController extends Controller {

    //微信公众平台接入入口
    public function index() {
        $mp_token = I('request.t');
        import('Common.Extends.Weixin.Weixin');
        ob_clean();
        
        $weixin = new \WeiXin($mp_token);
        $weixin->run();
    }

}
