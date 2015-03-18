<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-17
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮微信公众平台 | 餐厅菜品控制器
 */
class FoodController extends FoodBaseController {

    //餐厅菜品列表(后台管理员)
    public function index() {
        
    }

    //餐厅菜品列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_name = I('get.name');
        if (isset($get_name)) {
            $map['food_name'] = array('like', '%' . $get_name . '%');
            $map['dining_name'] = array('like', '%' . $get_name . '%');
        }
        $list = $this->lists('Food', $map, 'status,id');
        $this->assign('list', $list);
        $this->meta_title = '餐厅菜品列表';
        $this->display('show');
    }

    //创建餐厅菜品(前台面向商家) 平台管理人员或连锁餐厅员工负责添加
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
        //检索是否设置了菜品分类
        $food_category = M('FoodCategory')->where(array('mp_id' => MP_ID))->select();
        if (empty($food_category)) {
            if (IS_POST) {
                $this->error('请先创建菜品分类!', '', true);
            } else {
                $this->error('请先创建菜品分类!');
            }
        }

        if (IS_POST) {
            $food_data = I('post.');
            unset($food_data['dining_room_arr']);
            unset($food_data['promotion_arr']);
            unset($food_data['hot_arr']);
            unset($food_data['offline_arr']);
            unset($food_data['card_arr']);
            unset($food_data['status_arr']);
            unset($food_data['cate_arr']);
            unset($food_data['food_styles']);
            $foodModel = D('Food');
            //保存餐厅菜品
            $food_data['mp_id'] = MP_ID;
            $food_data['member_id'] = UID;
            $food_data['dining_name'] = \Admin\Model\DiningRoomModel::getDiningRoomName($food_data['dining_room_id']);
            if(empty($food_data['dining_name'])){//保存所有门店
                $food_data['dining_name'] = \Admin\Model\DiningRoomModel::getAllDiningRoomNames();
            }
            $food_data['cate_name'] = \Admin\Model\FoodCategoryModel::getFoodCategoryName($food_data['cate_id']);
            $food_data['share_title'] = !empty($food_data['share_title'])?$food_data['share_title']:$food_data['food_name'];
            $food_data['share_desc'] = !empty($food_data['share_desc'])?$food_data['share_desc']:$food_data['food_name'];
            if ($foodModel->create($food_data,  \Admin\Model\FoodModel::MODEL_INSERT)) {
                $food_add = $foodModel->add();
                if ($food_add) {
                    $this->success('保存餐厅菜品成功!', '', true);
                } else {
                    $this->error($foodModel->getError(), '', true);
                }
            } else {
                $this->error($foodModel->getError(), '', true);
            }
        }
        //检索餐厅
        if (IS_CHAIN) {
            $dining_room_arr[] = array('id' => '0', 'dining_name' => '所有门店通用');
        }
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        //检索菜品风格
        $food_styles = M('FoodStyle')->where(array('mp_id'=>MP_ID,'status'=>1))->select();
        $arr_food_styles = array();
        if(!empty($food_styles)){
            foreach($food_styles as $food_style){
                $arr_food_styles[] = array(
                    'id'=>$food_style['id'],
                    'food_style_name' =>$food_style['name'],
                );
            }
        }
        $promotion_arr = \Admin\Model\FoodModel::getFoodPromotion(null, false);
        foreach($promotion_arr as $key=>$promotion){
            $arr_promotion[] = array(
                'id'=>$key,
                'promotion_name'=>$promotion,
            );
        }
        $hot_arr = \Admin\Model\FoodModel::getFoodHot(null, false);
        foreach($hot_arr as $key=>$hot){
            $arr_hot[] = array(
                'id'=>$key,
                'hot_name'=>$hot,
            );
        }
        $offline_arr = \Admin\Model\FoodModel::getFoodOffline(null, false);
        foreach($offline_arr as $key=>$offline){
            $arr_offline[] = array(
                'id'=>$key,
                'offline_name'=>$offline,
            );
        }
        $card_arr = \Admin\Model\FoodModel::getFoodCard(null, false);
        foreach($card_arr as $key=>$card){
            $arr_card[] = array(
                'id'=>$key,
                'card_name'=>$card,
            );
        }
        $status_arr = \Admin\Model\FoodModel::getFoodStatus(null, false);
        foreach($status_arr as $key=>$status){
            $arr_status[] = array(
                'id'=>$key,
                'status_name'=>$status,
            );
        }
        $this->assign('promotion_arr', json_encode($arr_promotion));
        $this->assign('hot_arr', json_encode($arr_hot));
        $this->assign('offline_arr', json_encode($arr_offline));
        $this->assign('card_arr', json_encode($arr_card));
        $this->assign('status_arr', json_encode($arr_status));
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('selected_dining_room_id', json_encode(null));
        $this->assign('food_styles',  json_encode($arr_food_styles));

        $this->meta_title = '创建餐厅菜品';
        $this->display('add');
    }

    //编辑餐厅菜品(前台面向商家)
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

    //启用餐厅菜品(前台面向商家)
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

    //禁用餐厅菜品(前台面向商家)
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

    //根据餐厅id检索菜品分类
    public function cate(){
        if(IS_POST){
            $dining_room_id = I('post.select_dining_room_id');
            $foodCategoryModel = M('FoodCategory');
            $food_categorys = $foodCategoryModel->where(array('mp_id'=>MP_ID,'dining_room_id'=>$dining_room_id,'status'=>  \Admin\Model\FoodCategoryModel::$STATUS_ENABLED))->select();
            if(empty($food_categorys)){
                $this->error('该餐厅未创建菜品分类请先创建菜品分类','',true);
            }
            foreach($food_categorys as $food_category){
                $arr_cate[] = array(
                    'id'=>$food_category['id'],
                    'cate_name'=>$food_category['cate_name'],
                );
            }
            $this->success($arr_cate,"",true);
        }
    }
    
    //菜品详细查看及保存(面向商家)
    public function detail() {
        $this->meta_title = '餐厅菜品详细';
        $this->display('edit');
    }

}
