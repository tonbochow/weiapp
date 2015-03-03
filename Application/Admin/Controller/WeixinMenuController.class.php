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

    //创建微信一级菜单(前台)
    public function add(){
        $microPlatformModel = M('MicroPlatform');
        $platform_data['member_id'] = UID;
        $platform_data['app_type'] = \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD;
        $micro_platform = $microPlatformModel->where($platform_data)->find();
        $mp_id = $micro_platform['id'];
        if(IS_POST){//添加微信一级菜单
//            dump(I('post.'));exit;
            $menu_data = I('post.');
            unset($menu_data['menu_type_arr']);
            $weixinMenuModel = D('WeixinMenu');
            if($weixinMenuModel->create($menu_data)){
                $weixin_menu_add = $weixinMenuModel->add();
                if($weixin_menu_add){
                    $this->success('添加一级菜单成功!','',true);
                }else{
                    $this->error('添加一级菜单失败!','',true);
                }
            }else{
                $this->error($weixinMenuModel->getError(),'',true);
            }
        }
        //检索是否满足创建一级菜单条件
        $weixin_menu_data['mp_id'] = $mp_id;
        $weixin_menu_data['member_id'] = UID;
        $weixin_menu_data['pid'] = 0;
        $menu_count = M('WeixinMenu')->where($weixin_menu_data)->count();
        if($menu_count >=3){
            $this->error('您已创建了3个一级菜单！','/Admin/WeixinMenu/food');
        }
        $menu_type = \Admin\Model\WeixinMenuModel::getWxCaMenuType(null, false);
        foreach ($menu_type as $id => $val) {
            $menu_type_arr[] = array('id' => $id, 'menu_type' => $val);
        }
        $this->assign('menu_type_arr', json_encode($menu_type_arr));
        $this->assign('wxmenu',array());
        $this->assign('json_wxmenu', json_encode(array()));
        $this->meta_title = '创建微餐饮公众平台一级菜单';
        $this->display('add');
    }
    
    //创建微信子菜单(前台)
    public function addsubmenu(){
        $this->meta_title = '创建微餐饮公众平台子菜单';
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
