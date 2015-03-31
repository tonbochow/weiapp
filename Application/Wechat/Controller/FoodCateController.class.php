<?php
// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-32
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端菜品分类控制器
 */
class FoodCateController extends BaseController {

    //菜品分类
    public function index(){
                 
        $this->display('index');
    }

}