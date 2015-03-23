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
        $get_food_name= I('get.food_name');
        if (!empty($get_food_name)) {
            $map['food_name'] = array('like', '%' . (string) I('food_name') . '%');
        }
        $list = $this->lists('Food', $map, 'mp_id,status,id');
        $this->assign('list', $list);
        $this->meta_title = '微餐饮菜品列表';
        $this->display('index');
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
            unset($food_data['food_styles_arr']);
            $foodModel = D('Food');
            //保存餐厅菜品
            $food_data['mp_id'] = MP_ID;
            $food_data['member_id'] = UID;
            $food_data['dining_name'] = \Admin\Model\DiningRoomModel::getDiningRoomName($food_data['dining_room_id']);
            if (empty($food_data['dining_name'])) {//保存所有门店
                $food_data['dining_name'] = \Admin\Model\DiningRoomModel::getAllDiningRoomNames();
            }
            $food_data['style_name'] = \Admin\Model\FoodStyleModel::getFoodStyleName($food_data['style_id']);
            $food_data['cate_name'] = \Admin\Model\FoodCategoryModel::getFoodCategoryName($food_data['cate_id']);
            $food_data['share_title'] = !empty($food_data['share_title']) ? $food_data['share_title'] : $food_data['food_name'];
            $food_data['share_desc'] = !empty($food_data['share_desc']) ? $food_data['share_desc'] : $food_data['food_name'];
            if ($foodModel->create($food_data, \Admin\Model\FoodModel::MODEL_INSERT)) {
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
        $food_styles = M('FoodStyle')->where(array('mp_id' => MP_ID, 'status' => \Admin\Model\FoodStyleModel::$STATUS_ENABLED))->select();
        $arr_food_styles = array();
        if (!empty($food_styles)) {
            foreach ($food_styles as $food_style) {
                $arr_food_styles[] = array(
                    'id' => $food_style['id'],
                    'food_style_name' => $food_style['name'],
                );
            }
        }
        $promotion_arr = \Admin\Model\FoodModel::getFoodPromotion(null, false);
        foreach ($promotion_arr as $key => $promotion) {
            $arr_promotion[] = array(
                'id' => $key,
                'promotion_name' => $promotion,
            );
        }
        $hot_arr = \Admin\Model\FoodModel::getFoodHot(null, false);
        foreach ($hot_arr as $key => $hot) {
            $arr_hot[] = array(
                'id' => $key,
                'hot_name' => $hot,
            );
        }
        $offline_arr = \Admin\Model\FoodModel::getFoodOffline(null, false);
        foreach ($offline_arr as $key => $offline) {
            $arr_offline[] = array(
                'id' => $key,
                'offline_name' => $offline,
            );
        }
        $card_arr = \Admin\Model\FoodModel::getFoodCard(null, false);
        foreach ($card_arr as $key => $card) {
            $arr_card[] = array(
                'id' => $key,
                'card_name' => $card,
            );
        }
        $status_arr = \Admin\Model\FoodModel::getFoodStatus(null, false);
        foreach ($status_arr as $key => $status) {
            $arr_status[] = array(
                'id' => $key,
                'status_name' => $status,
            );
        }
        $this->assign('promotion_arr', json_encode($arr_promotion));
        $this->assign('hot_arr', json_encode($arr_hot));
        $this->assign('offline_arr', json_encode($arr_offline));
        $this->assign('card_arr', json_encode($arr_card));
        $this->assign('status_arr', json_encode($arr_status));
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('selected_dining_room_id', json_encode(null));
        $this->assign('food_styles', json_encode($arr_food_styles));

        $this->meta_title = '创建餐厅菜品';
        $this->display('add');
    }

    //编辑餐厅菜品(前台面向商家)
    public function edit() {
        if (IS_POST) {
            $food_data = I('post.');
            unset($food_data['dining_room_arr']);
            unset($food_data['promotion_arr']);
            unset($food_data['hot_arr']);
            unset($food_data['offline_arr']);
            unset($food_data['card_arr']);
            unset($food_data['status_arr']);
            unset($food_data['cate_arr']);
            unset($food_data['food_styles_arr']);
            $food_data['style_name'] = \Admin\Model\FoodStyleModel::getFoodStyleName($food_data['style_id']);
            $foodModel = D('Food');
            if ($foodModel->create($food_data, \Admin\Model\FoodModel::MODEL_UPDATE)) {
                $food_edit = $foodModel->save();
                if ($food_edit) {
                    $this->success('保存餐厅菜品成功', '', true);
                } else {
                    $this->error($foodModel->getError(), '', true);
                }
            } else {
                $this->error($foodModel->getError(), '', true);
            }
        }
        $id = intval(I('get.id', '', 'trim'));
        $foodModel = M('Food');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $food = $foodModel->where($map)->find();
        if ($food == false) {
            $this->error('未检索到您要编辑的餐厅菜品!');
        }
        $food['description'] = htmlspecialchars_decode(stripslashes($food['description']));
        //检索所有连锁餐厅
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        if (IS_CHAIN) {
            $dining_room_arr[] = array('id' => '0', 'dining_name' => '所有门店通用');
        }
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        //检索菜品分类
        $food_categorys = M('FoodCategory')->where(array('mp_id' => MP_ID, 'dining_room_id' => $food['dining_room_id'], 'status' => \Admin\Model\FoodCategoryModel::$STATUS_ENABLED))->select();
        foreach ($food_categorys as $food_category) {
            $arr_food_cates[] = array(
                'id' => $food_category['id'],
                'cate_name' => $food_category['cate_name'],
            );
        }
        //检索菜品风格
        $food_styles = M('FoodStyle')->where(array('mp_id' => MP_ID, 'status' => \Admin\Model\FoodStyleModel::$STATUS_ENABLED))->select();
        $arr_food_styles = array();
        if (!empty($food_styles)) {
            foreach ($food_styles as $food_style) {
                $arr_food_styles[] = array(
                    'id' => $food_style['id'],
                    'food_style_name' => $food_style['name'],
                );
            }
        }
        $promotion_arr = \Admin\Model\FoodModel::getFoodPromotion(null, false);
        foreach ($promotion_arr as $key => $promotion) {
            $arr_promotion[] = array(
                'id' => strval($key),
                'promotion_name' => $promotion,
            );
        }
        $hot_arr = \Admin\Model\FoodModel::getFoodHot(null, false);
        foreach ($hot_arr as $key => $hot) {
            $arr_hot[] = array(
                'id' => strval($key),
                'hot_name' => $hot,
            );
        }
        $offline_arr = \Admin\Model\FoodModel::getFoodOffline(null, false);
        foreach ($offline_arr as $key => $offline) {
            $arr_offline[] = array(
                'id' => strval($key),
                'offline_name' => $offline,
            );
        }
        $card_arr = \Admin\Model\FoodModel::getFoodCard(null, false);
        foreach ($card_arr as $key => $card) {
            $arr_card[] = array(
                'id' => strval($key),
                'card_name' => $card,
            );
        }
        $status_arr = \Admin\Model\FoodModel::getFoodStatus(null, false);
        foreach ($status_arr as $key => $status) {
            $arr_status[] = array(
                'id' => strval($key),
                'status_name' => $status,
            );
        }
        $this->assign('promotion_arr', json_encode($arr_promotion));
        $this->assign('hot_arr', json_encode($arr_hot));
        $this->assign('offline_arr', json_encode($arr_offline));
        $this->assign('card_arr', json_encode($arr_card));
        $this->assign('status_arr', json_encode($arr_status));
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('food_cate_arr', json_encode($arr_food_cates));
        $this->assign('food_styles_arr', json_encode($arr_food_styles));
        $this->assign('food', $food);
        $this->assign('json_food', json_encode($food));
        $this->meta_title = '编辑餐厅菜品分类';
        $this->display('edit');
    }

    //上架餐厅菜品(前台面向商家)
    public function enable() {
        $food_id_arr = I('post.id');
        if (empty($food_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_ids = array_unique($food_id_arr);
        $food_ids_str = is_array($food_ids) ? implode(',', $food_ids) : $food_ids;
        $map['id'] = array('in', $food_ids_str);
        $map['mp_id'] = MP_ID;
        $foodModel = M('Food');
        $food_data['status'] = \Admin\Model\FoodModel::$STATUS_ENABLED;
        $food_data['update_time'] = time();
        $food_enable = $foodModel->where($map)->save($food_data);
        if ($food_enable) {
            $this->success('上架餐厅菜品成功!');
        }
        $this->error('上架餐厅菜品失败!');
    }

    //下架餐厅菜品(前台面向商家)
    public function disable() {
        $food_id_arr = I('post.id');
        if (empty($food_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_ids = array_unique($food_id_arr);
        $food_ids_str = is_array($food_ids) ? implode(',', $food_ids) : $food_ids;
        $map['id'] = array('in', $food_ids_str);
        $map['mp_id'] = MP_ID;
        $foodModel = M('Food');
        $food_data['status'] = \Admin\Model\FoodModel::$STATUS_DISABLED;
        $food_data['update_time'] = time();
        $food_disable = $foodModel->where($map)->save($food_data);
        if ($food_disable) {
            $this->success('下架餐厅菜品成功!');
        }
        $this->error('下架餐厅菜品失败!');
    }

    //根据餐厅id检索菜品分类
    public function cate() {
        if (IS_POST) {
            $dining_room_id = I('post.select_dining_room_id');
            $foodCategoryModel = M('FoodCategory');
            $food_categorys = $foodCategoryModel->where(array('mp_id' => MP_ID, 'dining_room_id' => $dining_room_id, 'status' => \Admin\Model\FoodCategoryModel::$STATUS_ENABLED))->select();
            if (empty($food_categorys)) {
                $this->error('该餐厅未创建菜品分类请先创建菜品分类', '', true);
            }
            foreach ($food_categorys as $food_category) {
                $arr_cate[] = array(
                    'id' => $food_category['id'],
                    'cate_name' => $food_category['cate_name'],
                );
            }
            $this->success($arr_cate, "", true);
        }
    }

    //菜品详细查看及保存(面向商家)
    public function detail() {
        if (IS_POST) {
            $detail_data = I('post.');
            $food_id = I('post.id');
            $map['id'] = $food_id;
            $map['mp_id'] = MP_ID;
            $food = M('Food')->where($map)->find();
            if ($food == false) {
                $this->error('未检索到您要添加图片的菜品信息!', '', true);
            }
            $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/food/' . $food_id . '/';
            if (!file_exists($save_path)) {
                $mkdir_res = mkdir($save_path, 0777, true);
                if (!$mkdir_res) {
                    $this->error('创建上传图片目录失败', '', true);
                }
            }
            unset($detail_data['id']);
            $default_share = $detail_data['default_share'];
            unset($detail_data['default_share']);
            foreach ($detail_data as $input_name => $image_data) {
                if (!empty($image_data) && !preg_match('/\/Uploads\w*/', $image_data)) {
                    $pic_url = $save_path . "$input_name.jpg";
                    $final_url = '/Uploads/Mp/' . MP_ID . '/food/' . $food_id . '/' . "$input_name.jpg";
                    $pic_tmp = base64_decode($image_data);
                    $create_pic = file_put_contents($pic_url, $pic_tmp);
                    if ($create_pic == false) {
                        $this->error('生成图片失败!', '', true);
                    }
                    //写入或更新菜品明细表
                    $detail_map['mp_id'] = MP_ID;
                    $detail_map['member_id'] = UID;
                    $detail_map['input_name'] = $input_name;
                    $detail_map['food_id'] = $food_id;
                    $detail_exist = M('FoodDetail')->where($detail_map)->find();
                    if ($detail_exist == false) {//写入明细表
//                        if($default_share == $input_name){
//                            $add_data['default_share'] = \Admin\Model\FoodDetailModel::$STATUS_ENABLED;
//                        }else{
//                            $add_data['default_share'] = \Admin\Model\FoodDetailModel::$STATUS_DISABLED;
//                        }
                        $add_data['mp_id'] = MP_ID;
                        $add_data['member_id'] = UID;
                        $add_data['input_name'] = $input_name;
                        $add_data['food_id'] = $food_id;
                        $add_data['url'] = $final_url;
                        $detailModel = D('FoodDetail');
                        if ($detailModel->create($add_data, \Admin\Model\FoodModel::MODEL_INSERT)) {
                            $add_res = $detailModel->add();
                            if (!$add_res) {
                                $this->error($detailModel->getError(), '', true);
                            }
                        } else {
                            $this->error($detailModel->getError());
                        }
                    } else {//更新明细表
//                        if($default_share == $input_name){
//                            $save_data['default_share'] = \Admin\Model\FoodDetailModel::$STATUS_ENABLED;
//                        }else{
//                            $save_data['default_share'] = \Admin\Model\FoodDetailModel::$STATUS_DISABLED;
//                        }
                        $save_data['id'] = $detail_exist['id'];
                        $save_data['mp_id'] = MP_ID;
                        $save_data['member_id'] = UID;
                        $save_data['food_id'] = $food_id;
                        $save_data['input_name'] = $input_name;
                        $save_data['url'] = $final_url;
                        $detailModel = D('FoodDetail');
                        if ($detailModel->create($save_data, \Admin\Model\FoodModel::MODEL_UPDATE)) {
                            $save_res = $detailModel->save();
                            if (!$save_res) {
                                $this->error($detailModel->getError(), '', true);
                            }
                        } else {
                            $this->error($detailModel->getError());
                        }
                    }
                }
            }
            $this->success('保存菜品图片成功!', '', true);
        }
        $id = intval(I('get.id', '', 'trim'));
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $food = M('Food')->where($map)->find();
        if ($food == false) {
            $this->error('未检索到您要查看的菜品信息!');
        }
        //检索菜品明细信息
        $food_info['id'] = $id;
        $food_info['default_share'] = '';
        $food_details = M('FoodDetail')->where(array('mp_id' => MP_ID, 'food_id' => $id))->select();
        if ($food_details != false) {
            foreach ($food_details as $detail) {
                if ($detail['default_share']) {
                    $food_info['default_share'] = $detail['input_name'];
                }
                $food_info[$detail['input_name']] = $detail['url'];
            }
        }

        $this->assign('food_info', $food_info);
        $this->assign('json_food_info', json_encode($food_info));
        $this->assign('food', $food);
        $this->meta_title = '餐厅菜品详细';
        $this->display('detail');
    }

    //设置微信分享显示图片(前台商家)
    public function share() {
        if (IS_POST) {
            $post_data = I('post.');
            $food_id = I('post.id');
            $input_name = I('post.default_share');
            $foodDetailModel = M('FoodDetail');
            $exist = $foodDetailModel->where(array('mp_id' => MP_ID, 'food_id' => $food_id, 'input_name' => $input_name))->find();
            if ($exist == false) {
                $this->error('请先设置图片！', '', true);
            }
            $foodDetailModel->startTrans();
            $detail_data['default_share'] = \Admin\Model\FoodDetailModel::$DEFAULT_SHARE_YES;
            $detail_data['update_time'] = time();
            $default_save = $foodDetailModel->where(array('food_id' => $food_id, 'mp_id' => MP_ID, 'input_name' => $input_name))->save($detail_data);
            if ($default_save == false) {
                $foodDetailModel->rollback();
                $this->error('设为默认分享图片失败', '', true);
            }
            $not_default_data['default_share'] = \Admin\Model\FoodDetailModel::$DEFAULT_SHARE_NO;
            $not_default_data['update_time'] = time();
            $map['food_id'] = $food_id;
            $map['mp_id'] = MP_ID;
            $map['input_name'] = array('neq', $input_name);
            $exist_other = $foodDetailModel->where($map)->select();
            if ($exist_other != false) {
                $not_default_save = $foodDetailModel->where($map)->save($not_default_data);
                if ($not_default_save == false) {
                    $foodDetailModel->rollback();
                    $this->error('设置其它图片为非默认分享图片失败', '', true);
                }
            }
            $default_share_url = $post_data[$input_name];
            $foodModel = M('Food');
            $food_data['share_imgurl'] = $default_share_url;
            $food_data['update_time'] = time();
            $food_save = $foodModel->where(array('id' => $food_id, 'mp_id' => MP_ID))->save($food_data);
            if ($food_save == false) {
                $foodDetailModel->rollback();
                $this->error('保存商品默认图片url失败', '', true);
            }
            $foodDetailModel->commit();
            $this->success('设置默认分享图片成功', '', true);
        }
    }

}
