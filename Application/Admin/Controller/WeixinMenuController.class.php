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
        $map = array('member_id' => UID, 'mp_id' => '');
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
    public function add() {
        if (IS_POST) {//添加微信一级菜单
            $menu_data = I('post.');
            $menu_data['mp_id'] = MP_ID;
            unset($menu_data['menu_type_arr']);
            $weixinMenuModel = D('WeixinMenu');
            if ($weixinMenuModel->create($menu_data)) {
                $weixin_menu_add = $weixinMenuModel->add();
                if ($weixin_menu_add) {
                    $this->success('添加一级菜单成功!', '', true);
                } else {
                    $this->error('添加一级菜单失败!', '', true);
                }
            } else {
                $this->error($weixinMenuModel->getError(), '', true);
            }
        }
        //检索是否满足创建一级菜单条件
        $weixin_menu_data['mp_id'] = MP_ID;
        $weixin_menu_data['member_id'] = UID;
        $weixin_menu_data['pid'] = 0;
        $menu_count = M('WeixinMenu')->where($weixin_menu_data)->count();
        if ($menu_count >= 3) {
            $this->error('您已创建了3个一级菜单！', '/Admin/WeixinMenu/food');
        }
        $menu_type = \Admin\Model\WeixinMenuModel::getWxCaMenuType(null, false);
        foreach ($menu_type as $id => $val) {
            $menu_type_arr[] = array('id' => $id, 'menu_type' => $val);
        }
        $this->assign('menu_type_arr', json_encode($menu_type_arr));
        $this->meta_title = '创建微餐饮公众平台一级菜单';
        $this->display('add');
    }

    //创建微信子菜单(前台)
    public function addsubmenu() {
        //是否可以创建二级菜单
        $pid = intval(I('get.pid'));
        $weixinMenuModel = M('WeixinMenu');
        $weixin_p_menu = $weixinMenuModel->where(array('id' => $pid, 'member_id' => UID, 'mp_id' => MP_ID, 'pid' => 0))->find();
        if ($weixin_p_menu == false) {
            $this->error('父菜单不存在无法创建子菜单!');
        }
        $submenu_num = $weixinMenuModel->where(array('member_id' => UID, 'mp_id' => MP_ID, 'pid' => $pid))->count();
        if ($submenu_num >= 5) {
            $this->error('二级菜单已创建了5个!');
        }
        if (IS_POST) {//添加微信二级菜单
            $menu_data = I('post.');
            $menu_data['mp_id'] = MP_ID;
            $menu_data['pid'] = $pid;
            unset($menu_data['menu_type_arr']);
            $weixinMenuModel = D('WeixinMenu');
            if ($weixinMenuModel->create($menu_data)) {
                $weixin_menu_add = $weixinMenuModel->add();
                if ($weixin_menu_add) {
                    $this->success('添加二级菜单成功!', '', true);
                } else {
                    $this->error('添加二级菜单失败!', '', true);
                }
            } else {
                $this->error($weixinMenuModel->getError(), '', true);
            }
        }
        $menu_type = \Admin\Model\WeixinMenuModel::getWxCaMenuType(null, false);
        foreach ($menu_type as $id => $val) {
            $menu_type_arr[] = array('id' => $id, 'menu_type' => $val);
        }
        $this->assign('pid', $pid);
        $this->assign('menu_type_arr', json_encode($menu_type_arr));
        $this->meta_title = '创建微餐饮公众平台子菜单';
        $this->display('addsubmenu');
    }

    //编辑微信菜单(前台)
    public function edit() {
        $this->meta_title = '编辑微餐饮公众平台菜单';
        $this->display('edit');
    }

    //启用菜单(前台)
    public function enable() {
        $menu_id_arr = I('post.id');
        if (empty($menu_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $menu_ids = array_unique($menu_id_arr);
        $menu_ids_str = is_array($menu_ids) ? implode(',', $menu_ids) : $menu_ids;
        $map['id'] = array('in', $menu_ids_str);
        $map['member_id'] = UID;
        $map['mp_id'] = MP_ID;
        $weixinMenuModel = M('WeixinMenu');
        $menu_data['status'] = \Admin\Model\WeixinMenuModel::$STATUS_ENABLE;
        $menu_data['update_time'] = time();
        $weixin_menu_enable = $weixinMenuModel->where($map)->save($menu_data);
        if($weixin_menu_enable){
            $this->success('启用微信公众平台菜单成功!');
        }
        $this->error('启用微信公众平台菜单失败!');
    }

    //禁用菜单(前台)
    public function disable() {
        $menu_id_arr = I('post.id');
        if (empty($menu_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $menu_ids = array_unique($menu_id_arr);
        $menu_ids_str = is_array($menu_ids) ? implode(',', $menu_ids) : $menu_ids;
        $map['id'] = array('in', $menu_ids_str);
        $map['member_id'] = UID;
        $map['mp_id'] = MP_ID;
        $weixinMenuModel = M('WeixinMenu');
        $menu_data['status'] = \Admin\Model\WeixinMenuModel::$STATUS_DISABLE;
        $menu_data['update_time'] = time();
        $weixin_menu_enable = $weixinMenuModel->where($map)->save($menu_data);
        if($weixin_menu_enable){
            $this->success('禁用微信公众平台菜单成功!');
        }
        $this->error('禁用微信公众平台菜单失败!');
    }

}
