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
            $menu_data['p_order'] = $weixin_p_menu['p_order'];
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
        if (IS_POST) {
            $menu_data = I('post.');
            unset($menu_data['menu_type_arr']);
            if ($menu_data['pid'] == 0) {//更新二级菜单p_order
                $submenu_data['p_order'] = $menu_data['p_order'];
                $submenu_data['update_time'] = time();
                $submenu_save = M('WeixinMenu')->where(array('pid' => $menu_data['id'], 'member_id' => UID, 'mp_id' => MP_ID))->save($submenu_data);
            }
            $weixinMenuModel = D('WeixinMenu');
            if ($weixinMenuModel->create($menu_data)) {
                $weixin_menu_save = $weixinMenuModel->save();
                if ($weixinMenuModel) {
                    $this->success('更新微信菜单成功!', '', true);
                }
                $this->error('更新微信菜单失败!', '', true);
            } else {
                $this->error($weixinMenuModel->getError(), '', true);
            }
        }
        $id = intval(I('get.id'));
        $weixin_menu = M('WeixinMenu')->where(array('id' => $id, 'member_id' => UID, 'mp_id' => MP_ID))->find();
        if ($weixin_menu == false) {
            $this->error('您无权编辑此菜单!');
        }
        $menu_type = \Admin\Model\WeixinMenuModel::getWxCaMenuType(null, false);
        foreach ($menu_type as $id => $val) {
            $menu_type_arr[] = array('id' => $id, 'menu_type' => $val);
        }
        $this->assign('menu_type_arr', json_encode($menu_type_arr));
        $this->assign('weixin_menu', $weixin_menu);
        $this->assign('json_weixin_menu', json_encode($weixin_menu));
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
        if ($weixin_menu_enable) {
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
        if ($weixin_menu_enable) {
            $this->success('禁用微信公众平台菜单成功!');
        }
        $this->error('禁用微信公众平台菜单失败!');
    }

    //一键生成推荐菜单(前台)
    public function recommend() {
        $this->meta_title = '一键生成推荐菜单';
        $this->display('recommend');
    }

    //一键生成自定义菜单(前台)
    public function custom() {
        $weixinMenuModel = M('WeixinMenu');
        $map['member_id'] = UID;
        $map['mp_id'] = MP_ID;
        $map['status'] = \Admin\Model\WeixinMenuModel::$STATUS_ENABLE;
        $weixin_menu = $weixinMenuModel->where($map)->order('p_order,c_order,create_time')->select();
        if ($weixin_menu == false) {
            if (IS_POST) {
                $this->error('您未创建自定义菜单!', '', true);
            } else {
                $this->error('您未创建自定义菜单!');
            }
        }
        foreach ($weixin_menu as $menu) {
            if ($menu['pid'] == 0) {
                $top_menu_arr[$menu['id']] = $menu;
            } else {
                $sub_menu_arr[$menu['id']] = $menu;
            }
        }

        $menu_arr = array();
        foreach ($top_menu_arr as $top_menu) {
            $top_arr = array();
            if (!empty($sub_menu_arr)) {
                foreach ($sub_menu_arr as $sub_menu) {
                    if ($sub_menu['pid'] == $top_menu['id']) {
                        $top_arr[$sub_menu['id']] = $sub_menu;
                    }
                }
                if (empty($top_arr)) {
                    $menu_arr[$top_menu['id']] = '';
                } else {
                    $menu_arr[$top_menu['id']] = $top_arr;
                }
            } else {
                $menu_arr[$top_menu['id']][] = $top_menu;
            }
        }

        if (IS_POST) {//生成微信公众平台菜单
            $custom = I('post.custom');
            if ($custom) {
                $wx_menu_str = '{"button":[';
                foreach ($menu_arr as $pid => $sub_arr) {
                    if (!empty($sub_arr)) {
                        $wx_menu_str .= '{"name":"' . $top_menu_arr[$pid]['menu_name'] . '","sub_button":[';
                        foreach ($sub_arr as $sub) {
                            if ($sub['menu_type'] == 'click') {
                                $wx_menu_str .= '{"type":"' . $sub['menu_type'] . '","name":' . $sub['menu_name'] . '","key":' . $sub['menu_key'] . '"}';
                            } else if ($sub['menu_type'] == 'view') {
                                $wx_menu_str .= '{"type":"' . $sub['menu_type'] . '","name":' . $sub['menu_name'] . '","url":' . $sub['menu_url'] . '"}';
                            }
                            $wx_menu_str .= ',';
                        }
                        $sub_str = substr($wx_menu_str,0,-1);
                        $wx_menu_str = $sub_str.']}';
                    } else {
                        if ($top_menu_arr[$pid]['menu_type'] == 'click') {
                            $wx_menu_str .= '{"type":"' . $top_menu_arr[$pid]['menu_type'] . '","name":"' . $top_menu_arr[$pid]['menu_name'] . '","key":"' . $top_menu_arr[$pid]['menu_key'] . '"}';
                        } else if ($top_menu_arr[$pid]['menu_type'] == 'view') {
                            $wx_menu_str .= '{"type":"' . $top_menu_arr[$pid]['menu_type'] . '","name":"' . $top_menu_arr[$pid]['menu_name'] . '","url":"' . $top_menu_arr[$pid]['menu_url'] . '"}';
                        }
                    }
                    $wx_menu_str .= ',';
                }
                $menu_str = substr($wx_menu_str,0,-1);
                $wx_menu_str = $menu_str."]}";
            }
            if(APPID == '' || APPSERCERT == ''){
                $this->error('微信公众平台appid或appsercert参数为空!','',true);
            }
            $create_menu_res = \Admin\Model\MicroPlatformModel::createWeixinMenu(APPID, APPSERCERT, $wx_menu_str);
            if($create_menu_res){
                $this->success('微信公众平台菜单创建成功!','',true);
            }
            $this->error('微信公众平台菜单创建失败!','',true);
        }
        
        $this->assign('menu_arr', $menu_arr);
        $this->assign('top_menu_arr', $top_menu_arr);
        $this->meta_title = '一键生成自定义菜单';
        $this->display('custom');
    }

}
