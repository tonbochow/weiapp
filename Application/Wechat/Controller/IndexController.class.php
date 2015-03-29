<?php
// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-28
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信首页控制器
 */
class IndexController extends BaseController {

	//微信首页
    public function index(){
                 
        $this->display('index');
    }

}