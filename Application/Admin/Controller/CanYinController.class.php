<?php
// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 用户餐饮控制器
 */
class CanYinController extends AdminController {

    /**
     * 餐饮管理
     */
    public function index(){

        $this->meta_title = '微美食';
        $this->display('index');
    }
    
}
