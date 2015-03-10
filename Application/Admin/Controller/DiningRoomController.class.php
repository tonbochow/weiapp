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
    public function index() {
        
    }

    //餐厅列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_dining_name = I('get.dining_name');
        if (isset($get_dining_name)) {
            $map['dining_name'] = array('like', '%' . (string) I('dining_name') . '%');
        }
        $list = $this->lists('DiningRoom', $map, 'status,id');

        $this->assign('list', $list);
        $this->meta_title = '餐厅列表';
        $this->display('show');
    }

    //创建餐厅(前台面向商家) 非连锁只能创建一个 连锁可以创建多个
    public function add() {
        if(IS_CHAIN){//若为连锁餐厅 检查是否已创建了连锁餐厅信息
            $chain_dining = M('ChainDining')->where(array('mp_id'=>MP_ID))->find();
            if($chain_dining == false){
                $this->error('请先创建连锁餐厅信息!','/Admin/ChainDining/info');
            }
        }
        $this->meta_title = '创建餐厅';
        $this->display('add');
    }

    //编辑餐厅(前台面向商家)
    public function edit() {
        $this->meta_title = '编辑餐厅';
        $this->display('edit');
    }

    //启用餐厅(前台面向商家)
    public function enable() {
        $diningroom_id_arr = I('post.id');
        if (empty($diningroom_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $diningroom_ids = array_unique($diningroom_id_arr);
        $diningroom_ids_str = is_array($diningroom_ids) ? implode(',', $diningroom_ids) : $diningroom_ids;
        $map['id'] = array('in', $diningroom_ids_str);
        $map['mp_id'] = MP_ID;
        $DiningRoomModel = M('DiningRoom');
        $diningroom_data['status'] = \Admin\Model\WeixinMenuModel::$STATUS_ENABLE;
        $diningroom_data['update_time'] = time();
        $diningroom_enable = $DiningRoomModel->where($map)->save($diningroom_data);
        if ($diningroom_enable) {
            $this->success('启用餐厅成功!');
        }
        $this->error('启用餐厅失败!');
    }

    //禁用餐厅(前台面向商家)
    public function disable() {
        $diningroom_id_arr = I('post.id');
        if (empty($diningroom_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $diningroom_ids = array_unique($diningroom_id_arr);
        $diningroom_ids_str = is_array($diningroom_ids) ? implode(',', $diningroom_ids) : $diningroom_ids;
        $map['id'] = array('in', $diningroom_ids_str);
        $map['mp_id'] = MP_ID;
        $DiningRoomModel = M('DiningRoom');
        $diningroom_data['status'] = \Admin\Model\WeixinMenuModel::$STATUS_DISABLE;
        $diningroom_data['update_time'] = time();
        $diningroom_disable = $DiningRoomModel->where($map)->save($diningroom_data);
        if ($diningroom_disable) {
            $this->success('禁用餐厅成功!');
        }
        $this->error('禁用餐厅失败!');
    }

}
