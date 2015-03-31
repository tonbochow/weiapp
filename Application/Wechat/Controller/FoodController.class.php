<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-31
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端菜品控制器
 */
class FoodController extends BaseController {

    //菜品列表
    public function index() {

        $this->display('index');
    }

}
