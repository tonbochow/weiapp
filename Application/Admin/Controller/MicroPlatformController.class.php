<?php
// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台控制器
 */
class MicroPlatformController extends FoodBaseController {

    /**
     * 餐饮管理(后台)
     */
    public function index(){
        $this->display();
    }
    
    //微餐饮平台列表
    public function lists(){
        
        $this->display('list');
    }

    //微餐饮公众平台(前台)
    public function food(){
        $this->meta_title = '微餐饮公众平台';
        $this->display('food');
    }
}
