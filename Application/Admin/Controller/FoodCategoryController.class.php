<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-15
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮微信公众平台 | 餐厅菜品分类控制器
 */
class FoodCategoryController extends FoodBaseController {

    //餐厅菜品分类列表(后台管理员)
    public function index() {
        
    }

    //餐厅菜品分类列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_cate_name = I('get.cate_name');
        if (isset($get_cate_name)) {
            $map['cate_name'] = array('like', '%' . (string) I('cate_name') . '%');
        }
        $list = $this->lists('FoodCategory', $map, 'status,id');
        $this->assign('list', $list);
        $this->meta_title = '餐厅菜品分类列表';
        $this->display('show');
    }

    //创建餐厅菜品分类(前台面向商家) 一个餐厅可以创建多个
    public function add() {
        //检索所有连锁餐厅
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        if (empty($dining_rooms)) {
            if (IS_POST) {
                $this->error('请先创建餐厅!', '', true);
            } else {
                $this->error('请先创建餐厅!');
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
            //保存餐厅菜品分类
            unset($food_cate_data['dining_room_arr']);
            $food_cate_data['mp_id'] = MP_ID;
            $food_cate_data['member_id'] = UID;
            $food_cate_data['status'] = \Admin\Model\FoodCategoryModel::$STATUS_ENABLED;
            $food_cate_data['create_time'] = time();
            if ($foodCateModel->create($food_cate_data)) {
                $food_cate_add = $foodCateModel->add();
                if ($food_cate_add) {
                    $foodCateModel->commit();
                    $this->success('保存餐厅菜品分类成功!', '', true);
                } else {
                    $foodCateModel->rollback();
                    $this->error($foodCateModel->getError(), '', true);
                }
            } else {
                $foodCateModel->rollback();
                $this->error('保存餐厅菜品分类失败!', '', true);
            }
        }

        $this->meta_title = '创建餐厅菜品分类';
        $this->display('add');
    }

    //编辑餐厅菜品分类(前台面向商家)
    public function edit() {
        if (IS_POST) {
            $food_cate_data = I('post.');
            unset($food_cate_data['dining_room_arr']);
            $foodCateModel = D('FoodCategory');
            if ($foodCateModel->create($food_cate_data)) {
                $food_cate_edit = $foodCateModel->save();
                if ($food_cate_edit) {
                    $this->success('保存餐厅菜品分类成功', '', true);
                } else {
                    $this->error($foodCateModel->getError(), '', true);
                }
            } else {
                $this->error('餐厅菜品分类编辑失败!', '', true);
            }
        }
        $id = intval(I('get.id', '', 'trim'));
        $foodCateModel = M('FoodCategory');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $food_cate = $foodCateModel->where($map)->find();
        if ($food_cate == false) {
            $this->error('未检索到您要编辑的餐厅菜品分类!');
        }

        //检索所有连锁餐厅
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
        $this->meta_title = '编辑餐厅菜品分类';
        $this->display('edit');
    }

    //启用餐厅菜品分类(前台面向商家)
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
            $this->success('启用餐厅菜品分类成功!');
        }
        $this->error('启用餐厅菜品分类失败!');
    }

    //禁用餐厅菜品分类(前台面向商家)
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
            $this->success('禁用餐厅菜品分类成功!');
        }
        $this->error('禁用餐厅菜品分类失败!');
    }

}
