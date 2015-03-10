<?php
// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮微信公众平台 | 餐厅控制器
 */
class DiningRoomController extends FoodBaseController {
    //餐厅列表(后台管理员)
    public function index(){
        
    }
    
    //餐厅列表(前台面向商家)
    public function show(){
        
        $this->meta_title = '餐厅列表';
        $this->display('show');
    }
}