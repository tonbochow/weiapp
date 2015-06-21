<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-15
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食微信公众平台 | 门店美食分类控制器
 */
class FoodCategoryController extends FoodBaseController {

    //门店美食分类列表(后台管理员)
    public function index() {
        $get_cate_name= I('get.cate_name');
        if (!empty($get_cate_name)) {
            $map['cate_name'] = array('like', '%' . (string) I('cate_name') . '%');
        }
        $list = $this->lists('FoodCategory', $map, 'mp_id,status,sort');
        $this->assign('list', $list);
        $this->meta_title = '微美食美食分类列表';
        $this->display('index');
    }

    //门店美食分类列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_cate_name = I('get.cate_name');
        if (isset($get_cate_name)) {
            $map['cate_name'] = array('like', '%' . (string) I('cate_name') . '%');
        }
        $list = $this->lists('FoodCategory', $map, 'status,id');
        $this->assign('list', $list);
        $this->meta_title = '门店美食分类列表';
        $this->display('show');
    }

    //创建门店美食分类(前台面向商家) 一个门店可以创建多个
    public function add() {
        //检索所有连锁门店
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        if (empty($dining_rooms)) {
            if (IS_POST) {
                $this->error('请先创建门店!', '', true);
            } else {
                $this->error('请先创建门店!');
            }
        }
        if (IS_CHAIN) {
            $dining_room_arr[] = array('id' => '0', 'dining_name' => '所有门店通用');
        }
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('selected_dining_room_id', json_encode(null));
        if (IS_POST) {
            $food_cate_data = I('post.');
            $foodCateModel = D('FoodCategory');
            $foodCateModel->startTrans();
            //保存门店美食分类
            unset($food_cate_data['dining_room_arr']);
            $food_cate_data['mp_id'] = MP_ID;
            $food_cate_data['member_id'] = UID;
            $food_cate_data['status'] = \Admin\Model\FoodCategoryModel::$STATUS_ENABLED;
            $food_cate_data['create_time'] = time();
            if ($foodCateModel->create($food_cate_data)) {
                $food_cate_add = $foodCateModel->add();
                if ($food_cate_add) {
                    $foodCateModel->commit();
                    $this->success('保存门店美食分类成功!', '', true);
                } else {
                    $foodCateModel->rollback();
                    $this->error($foodCateModel->getError(), '', true);
                }
            } else {
                $foodCateModel->rollback();
                $this->error('保存门店美食分类失败!', '', true);
            }
        }

        $this->meta_title = '创建门店美食分类';
        $this->display('add');
    }

    //编辑门店美食分类(前台面向商家)
    public function edit() {
        if (IS_POST) {
            $food_cate_data = I('post.');
            unset($food_cate_data['dining_room_arr']);
            $foodCateModel = D('FoodCategory');
            if ($foodCateModel->create($food_cate_data)) {
                $food_cate_edit = $foodCateModel->save();
                if ($food_cate_edit) {
                    $this->success('保存门店美食分类成功', '', true);
                } else {
                    $this->error($foodCateModel->getError(), '', true);
                }
            } else {
                $this->error('门店美食分类编辑失败!', '', true);
            }
        }
        $id = intval(I('get.id', '', 'trim'));
        $foodCateModel = M('FoodCategory');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $food_cate = $foodCateModel->where($map)->find();
        if ($food_cate == false) {
            $this->error('未检索到您要编辑的门店美食分类!');
        }

        //检索所有连锁门店
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        if (IS_CHAIN) {
            $dining_room_arr[] = array('id' => '0', 'dining_name' => '所有门店通用');
        }
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('selected_dining_room_id', json_encode($food_cate['dining_room_id']));
        $this->assign('food_cate', $food_cate);
        $this->assign('json_food_cate', json_encode($food_cate));
        $this->meta_title = '编辑门店美食分类';
        $this->display('edit');
    }

    //启用门店美食分类(前台面向商家)
    public function enable() {
        $food_cate_id_arr = I('post.id');
        if (empty($food_cate_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_cate_ids = array_unique($food_cate_id_arr);
        $food_cate_ids_str = is_array($food_cate_ids) ? implode(',', $food_cate_ids) : $food_cate_ids;
        $map['id'] = array('in', $food_cate_ids_str);
        $map['mp_id'] = MP_ID;
        $foodCateModel = M('FoodCategory');
        $food_cate_data['status'] = \Admin\Model\FoodCategoryModel::$STATUS_ENABLED;
        $food_cate_data['update_time'] = time();
        $food_cate_enable = $foodCateModel->where($map)->save($food_cate_data);
        if ($food_cate_enable) {
            $this->success('启用门店美食分类成功!');
        }
        $this->error('启用门店美食分类失败!');
    }

    //禁用门店美食分类(前台面向商家)
    public function disable() {
        $food_cate_id_arr = I('post.id');
        if (empty($food_cate_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_cate_ids = array_unique($food_cate_id_arr);
        $food_cate_ids_str = is_array($food_cate_ids) ? implode(',', $food_cate_ids) : $food_cate_ids;
        $map['id'] = array('in', $food_cate_ids_str);
        $map['mp_id'] = MP_ID;
        $foodCateModel = M('FoodCategory');
        $food_cate_data['status'] = \Admin\Model\FoodCategoryModel::$STATUS_DISABLED;
        $food_cate_data['update_time'] = time();
        $food_cate_disable = $foodCateModel->where($map)->save($food_cate_data);
        if ($food_cate_disable) {
            $this->success('禁用门店美食分类成功!');
        }
        $this->error('禁用门店美食分类失败!');
    }

}
