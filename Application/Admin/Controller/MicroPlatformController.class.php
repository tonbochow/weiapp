<?php
// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台微餐饮公众平台控制器
 */
class MicroPlatformController extends AdminController {

    /**
     * 餐饮管理
     */
    public function index(){
        /* 查询条件初始化 */
//        $map = array();
//        $map  = array('status' => 1);
//        if(isset($_GET['group'])){
//            $map['group']   =   I('group',0);
//        }
//        if(isset($_GET['name'])){
//            $map['name']    =   array('like', '%'.(string)I('name').'%');
//        }
//
//        $list = $this->lists('Config', $map,'sort,id');
//        // 记录当前列表页的cookie
//        Cookie('__forward__',$_SERVER['REQUEST_URI']);
//
//        $this->assign('group',C('CONFIG_GROUP_LIST'));
//        $this->assign('group_id',I('get.group',0));
//        $this->assign('list', $list);
//        $this->meta_title = '配置管理';
        $this->display();
    }
    
    //微餐饮平台列表
    public function lists(){
        
        $this->display('list');
    }

}
