<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-02
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台菜单控制器
 */
class WeixinMenuController extends FoodBaseController {

    /**
     * 菜单管理(后台)
     */
    public function index() {
        $this->display();
    }

    //微餐饮公众平台微信菜单(前台)
    public function food() {
        /* 查询条件初始化 */
        $map = array('member_id'=>UID,'mp_id'=>'');
        $get_menu_name = I('get.menu_name');
        if (isset($get_menu_name)) {
            $map['menu_name'] = array('like', '%' . (string) I('menu_name') . '%');
        }
        $list = $this->lists('WeixinMenu', $map, 'status,id');

        $this->assign('list', $list);
        $this->meta_title = '微餐饮公众平台微信菜单';
        $this->display('food');
    }

    //创建微信菜单(前台)
    public function add(){
        $this->meta_title = '创建微餐饮公众平台菜单';
        $this->display('add');
    }
    
    //编辑微信菜单(前台)
    public function edit(){
        $this->meta_title = '编辑微餐饮公众平台菜单';
        $this->display('edit');
    }
    
    //启用菜单(前台)
    public function enable(){
        
    }
    
    //禁用菜单(前台)
    public function disable(){
        
    }
}
