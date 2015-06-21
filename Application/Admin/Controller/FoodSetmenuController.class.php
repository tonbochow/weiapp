<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-20
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食微信公众平台 | 美食套餐控制器
 */
class FoodSetmenuController extends FoodBaseController {

    //门店美食风格列表(后台管理员)
    public function index() {
        $get_setmenu_name = I('get.setmenu_name');
        if (!empty($get_setmenu_name)) {
            $map['setmenu_name'] = array('like', '%' . (string) I('setmenu_name') . '%');
        }
        $list = $this->lists('FoodSetmenu', $map, 'mp_id,status,id');
        $this->assign('list', $list);
        $this->meta_title = '微美食美食套餐列表';
        $this->display('index');
    }

    //门店美食套餐列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_setmenu_name = I('get.setmenu_name');
        if (isset($get_setmenu_name)) {
            $map['setmenu_name'] = array('like', '%' . (string) I('setmenu_name') . '%');
        }
        $list = $this->lists('FoodSetmenu', $map, 'status,id');
        $this->assign('list', $list);
        $this->meta_title = '门店美食套餐列表';
        $this->display('show');
    }

    //创建门店美食套餐(前台面向商家)
    public function add() {
        //检索是否添加了美食
        $food = M('Food')->where(array('mp_id' => MP_ID, 'status' => \Admin\Model\FoodModel::$STATUS_ENABLED))->select();
        if (empty($food)) {
            if (IS_POST) {
                $this->error('请先创建美食!', '', true);
            } else {
                $this->error('请先创建美食!');
            }
        }
        if (IS_POST) {
            $food_setmenu_data = I('post.');
            if (empty($food_setmenu_data['url'])) {
                $this->error('请上传一张美食套餐图片', '', true);
            }
//            $setmenu_pic = $food_setmenu_data['url'];
//            unset($food_setmenu_data['url']);
            $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/setmenu/';
            if (!file_exists($save_path)) {
                $mkdir_res = mkdir($save_path, 0777, true);
                if (!$mkdir_res) {
                    $this->error('创建上传图片目录失败', '', true);
                }
            }
            $pic_name = genOrderNo();
            $pic_url = $save_path . $pic_name . ".jpg";
            $final_url = '/Uploads/Mp/' . MP_ID . '/setmenu/' . "$pic_name.jpg";
            $pic_tmp = base64_decode($food_setmenu_data['url']);
            $create_pic = file_put_contents($pic_url, $pic_tmp);
            if ($create_pic == false) {
                $this->error('生成套餐图片失败!', '', true);
            }
            $food_setmenu_data['url'] = $final_url;
            $foodSetmenuModel = D('FoodSetmenu');
            //保存门店美食套餐
            $food_setmenu_data['mp_id'] = MP_ID;
            $food_setmenu_data['member_id'] = UID;
            $food_setmenu_data['share_title'] = !empty($food_setmenu_data['share_title']) ? $food_setmenu_data['share_title'] : $food_setmenu_data['setmenu_name`'];
            $food_setmenu_data['share_desc'] = !empty($food_setmenu_data['share_desc']) ? $food_setmenu_data['share_desc'] : $food_setmenu_data['setmenu_name`'];
            if ($foodSetmenuModel->create($food_setmenu_data, \Admin\Model\FoodSetmenuModel::MODEL_INSERT)) {
                $food_setmenu_add = $foodSetmenuModel->add();
                if ($food_setmenu_add) {
                    $this->success('保存门店美食套餐成功!', '', true);
                }
            }
            @unlink(C('WEBSITE_URL') . $final_url);
            $this->error($foodSetmenuModel->getError(), '', true);
        }
        //检索门店
        if (IS_CHAIN) {
            $dining_room_arr[] = array('id' => '0', 'dining_name' => '所有门店通用');
        }
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        $card_arr = \Admin\Model\FoodSetmenuModel::getFoodSetmenuCard(null, false);
        foreach ($card_arr as $key => $card) {
            $arr_card[] = array(
                'id' => $key,
                'card_name' => $card,
            );
        }

        $this->assign('card_arr', json_encode($arr_card));
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->meta_title = '创建门店美食套餐';
        $this->display('add');
    }

    //编辑门店美食套餐(前台面向商家)
    public function edit() {

        $id = intval(I('request.id', '', 'trim'));
        $foodSetmenuModel = M('FoodSetmenu');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $food_setmenu = $foodSetmenuModel->where($map)->find();
        if ($food_setmenu == false) {
            if (IS_POST) {
                $this->error('未检索到您要编辑的门店美食套餐!', '', true);
            } else {
                $this->error('未检索到您要编辑的门店美食套餐!');
            }
        }
        if (IS_POST) {
            $food_setmenu_data = I('post.');
            if (!empty($food_setmenu_data['url']) && !preg_match('/\/Uploads\w*/', $food_setmenu_data['url'])) {
                $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/setmenu/';
                if (!file_exists($save_path)) {
                    $mkdir_res = mkdir($save_path, 0777, true);
                    if (!$mkdir_res) {
                        $this->error('创建上传图片目录失败', '', true);
                    }
                }
                $pic_url_arr = explode('/',$food_setmenu['url']);
                $pic_name_str = end($pic_url_arr);
                $pic_str_arr = explode('.',$pic_name_str);
                $pic_name = $pic_str_arr[0];
                if(empty($pic_name)){
                    $pic_name = genOrderNo();
                }
                $pic_url = $save_path . $pic_name . ".jpg";
                $final_url = '/Uploads/Mp/' . MP_ID . '/setmenu/' . "$pic_name.jpg";
                $pic_tmp = base64_decode($food_setmenu_data['url']);
                $create_pic = file_put_contents($pic_url, $pic_tmp);
                if ($create_pic == false) {
                    $this->error('生成套餐图片失败!', '', true);
                }
                $food_setmenu_data['url'] = $final_url;
            }
            $foodSetmenuModel = D('FoodSetmenu');
            if ($foodSetmenuModel->create($food_setmenu_data, \Admin\Model\FoodSetmenuModel::MODEL_UPDATE)) {
                $food_setmenu_edit = $foodSetmenuModel->save();
                if ($food_setmenu_edit) {
                    $this->success('保存门店美食套餐成功', '', true);
                }
            }
            $this->error($foodSetmenuModel->getError(), '', true);
        }

        //检索门店
        if (IS_CHAIN) {
            $dining_room_arr[] = array('id' => '0', 'dining_name' => '所有门店通用');
        }
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        $card_arr = \Admin\Model\FoodSetmenuModel::getFoodSetmenuCard(null, false);
        foreach ($card_arr as $key => $card) {
            $arr_card[] = array(
                'id' => strval($key),
                'card_name' => $card,
            );
        }
        $food_setmenu['description'] = htmlspecialchars_decode(stripslashes($food_setmenu['description']));

        $this->assign('card_arr', json_encode($arr_card));
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('food_setmenu', $food_setmenu);
        $this->assign('json_food_setmenu', json_encode($food_setmenu));
        $this->meta_title = '编辑门店美食套餐';
        $this->display('edit');
    }

    //添加门店美食明细(面向前台商家)
    public function addfood() {
        if (IS_POST) { //添加美食入套餐
            $setmenu_id = I('get.setmenu_id');
            $map['id'] = $setmenu_id;
            $map['mp_id'] = MP_ID;
            $foodSetmenuModel = M('FoodSetmenu');
            $food_setmenu = $foodSetmenuModel->where($map)->find();
            if ($food_setmenu == false) {
                $this->error('未检索到您要添加美食的套餐');
            }
            $food_id_arr = I('post.id');
            if (empty($food_id_arr)) {
                $this->error('请选择要加入套餐的美食!');
            }
            $food_ids = array_unique($food_id_arr);
            $food_ids_str = is_array($food_ids) ? implode(',', $food_ids) : $food_ids;
            $food_map['id'] = array('in', $food_ids_str);
            $food_map['mp_id'] = MP_ID;
            $food_map['dining_room_id'] = $food_setmenu['dining_room_id'];
            $foodModel = M('Food');
            $foods = $foodModel->where($food_map)->select();
            $total_amount = $food_setmenu['setmenu_money'];
            $setmenuDetailModel = D('FoodSetmenuDetail');
            $setmenuDetailModel->startTrans();
            foreach ($foods as $food) {//添加美食如套餐
                $detail_data['setmenu_id'] = $setmenu_id;
                $detail_data['mp_id'] = MP_ID;
                $detail_data['food_id'] = $food['id'];
                $detail_data['food_name'] = $food['food_name'];
                $detail_data['weixin_price'] = $food['weixin_price'];
                $detail_data['count'] = 1;
                $detail_data['amount'] = $food['weixin_price'];
                $exist_food = M('FoodSetmenuDetail')->where(array('mp_id' => MP_ID, 'setmenu_id' => $setmenu_id, 'food_id' => $food['id']))->find();
                if ($exist_food) {
                    continue;
                }
                if ($setmenuDetailModel->create($detail_data, \Admin\Model\FoodSetmenuDetailModel::MODEL_INSERT)) {
                    $detail_add = $setmenuDetailModel->add();
                    if ($detail_add == false) {
                        $setmenuDetailModel->rollback();
                        $this->error($setmenuDetailModel->getError(), '', true);
                    }
                } else {
                    $setmenuDetailModel->rollback();
                    $this->error($setmenuDetailModel->getError(), '', true);
                }
                $total_amount += bcadd(0, $food['weixin_price'], 2);
            }
            //更新套餐应付总金额
            $setmenu_data['amount'] = $total_amount;
            $setmenu_data['setmenu_money'] = $total_amount;
            $setmenu_data['update_time'] = time();
            $setmenu_save = $foodSetmenuModel->where(array('id' => $setmenu_id))->save($setmenu_data);
            if ($setmenu_save) {
                $setmenuDetailModel->commit();
                $this->success('添加美食入套餐成功!', '', true);
            }
            $setmenuDetailModel->rollback();
            $this->error($foodSetmenuModel->getError(), '', true);
        }
        $id = I('get.id', '', 'trim');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $foodSetmenuModel = M('FoodSetmenu');
        $food_setmenu = $foodSetmenuModel->where($map)->find();
        if ($food_setmenu == false) {
            $this->error('未检索到您要编辑的美食套餐');
        }
        //检索美食
        $get_food_name = I('get.food_name');
        if (!empty($get_food_name)) {
            $food_map['food_name'] = array('like', '%' . (string) I('food_name') . '%');
        }
        $food_map['mp_id'] = MP_ID;
        $food_map['dining_room_id'] = $food_setmenu['dining_room_id'];
        $food_map['status'] = \Admin\Model\FoodModel::$STATUS_ENABLED;
        $list = $this->lists('Food', $food_map, 'status,id');

        $this->assign('list', $list);

        $this->assign('food_setmenu', $food_setmenu);
        $this->meta_title = '添加美食入套餐';
        $this->display('addfood');
    }

    //编辑门店美食明细(面向前台商家)
    public function editfood() {
        if (IS_POST) {
            $setmenu_id = I('post.setmenu_id');
            $food_count = I('post.count', '', 'intval');
            $setmenuDetailModel = M('FoodSetmenuDetail');
            $setmenuDetailModel->startTrans();
            $amount = bcmul($food_count, I('post.weixin_price'), 2);
            $detail_data['count'] = $food_count;
            $detail_data['amount'] = $amount;
            $detail_data['update_time'] = time();
            $detail_save = $setmenuDetailModel->where(array('id' => I('post.id'), 'mp_id' => MP_ID))->save($detail_data);
            if ($detail_save == false) {
                $setmenuDetailModel->rollback();
                $this->error('保存美食明细失败', '', true);
            }
            $save_setmenu_money = $this->updateSetmenuMoney($setmenu_id);
            if ($save_setmenu_money) {
                $setmenuDetailModel->commit();
                $this->success('保存美食明细成功', '', true);
            }
            $setmenuDetailModel->rollback();
            $this->error('保存美食明细失败!', '', true);
        }
        $id = I('get.id', '', 'trim');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $setmenuDetailModel = M('FoodSetmenuDetail');
        $setmenu_detail = $setmenuDetailModel->where($map)->find();
        if ($setmenu_detail == false) {
            $this->error('未检索到您要编辑的套餐明细');
        }

        $this->assign('setmenu_detail', $setmenu_detail);
        $this->assign('json_setmenu_detail', json_encode($setmenu_detail));
        $this->meta_title = '编辑美食套餐明细';
        $this->display('editfood');
    }

    //查看美食套餐(面向前台商家)
    public function view() {
        $id = I('get.id');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $food_setmenu = M('FoodSetmenu')->where($map)->find();
        if ($food_setmenu == false) {
            $this->error('未检索到您要查看的美食套餐');
        }

        $detail_map['mp_id'] = MP_ID;
        $detail_map['setmenu_id'] = $id;
        $list = $this->lists('FoodSetmenuDetail', $detail_map, 'status,id');

        $this->assign('list', $list);

        $this->assign('food_setmenu', $food_setmenu);
        $this->meta_title = '查看美食套餐';
        $this->display('view');
    }

    //上架门店美食套餐(面向前台商家)
    public function up() {
        $food_setmenu_id_arr = I('post.id');
        if (empty($food_setmenu_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_setmenu_ids = array_unique($food_setmenu_id_arr);
        $food_setmenu_ids_str = is_array($food_setmenu_ids) ? implode(',', $food_setmenu_ids) : $food_setmenu_ids;
        $map['id'] = array('in', $food_setmenu_ids_str);
        $map['mp_id'] = MP_ID;
        $foodSetmenuModel = M('FoodSetmenu');
        $food_setmenu_data['status'] = \Admin\Model\FoodSetmenuModel::$STATUS_ENABLED;
        $food_setmenu_data['update_time'] = time();
        $food_setmenu_enable = $foodSetmenuModel->where($map)->save($food_setmenu_data);
        if ($food_setmenu_enable) {
            $this->success('上架门店美食套餐成功!');
        }
        $this->error('上架门店美食套餐失败!');
    }

    //下架门店美食套餐(面向前台商家)
    public function down() {
        $food_setmenu_id_arr = I('post.id');
        if (empty($food_setmenu_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_setmenu_ids = array_unique($food_setmenu_id_arr);
        $food_setmenu_ids_str = is_array($food_setmenu_ids) ? implode(',', $food_setmenu_ids) : $food_setmenu_ids;
        $map['id'] = array('in', $food_setmenu_ids_str);
        $map['mp_id'] = MP_ID;
        $foodSetmenuModel = M('FoodSetmenu');
        $food_setmenu_data['status'] = \Admin\Model\FoodStyleModel::$STATUS_DISABLED;
        $food_setmenu_data['update_time'] = time();
        $food_setmenu_disable = $foodSetmenuModel->where($map)->save($food_setmenu_data);
        if ($food_setmenu_disable) {
            $this->success('下架门店美食套餐成功!');
        }
        $this->error('下架门店美食套餐失败!');
    }

    //更新套餐金额 $setmenu_id 套餐id
    protected function updateSetmenuMoney($setmenu_id) {
        $setmenuDetailModel = M('FoodSetmenuDetail');
        $map['setmenu_id'] = $setmenu_id;
        $map['mp_id'] = MP_ID;
        $map['status'] = \Admin\Model\FoodSetmenuModel::$STATUS_ENABLED;
        $total_amount = $setmenuDetailModel->where($map)->sum('amount');
        $setmenuModel = M('FoodSetmenu');
        $setmenu_map['id'] = $setmenu_id;
        $setmenu_data['amount'] = $total_amount;
        $setmenu_data['setmenu_money'] = $total_amount;
        $setmenu_data['update_time'] = time();
        $setmenu_save = $setmenuModel->where($setmenu_map)->save($setmenu_data);
        return $setmenu_save;
    }

    //启用门店美食明细(前台面向商家)
    public function enable() {
        $setmenu_detail_id_arr = I('post.id');
        if (empty($setmenu_detail_id_arr)) {
            $this->error('请选择要操作的明细!');
        }
        $setmenu_detail_ids = array_unique($setmenu_detail_id_arr);
        $setmenu_detail_ids_str = is_array($setmenu_detail_ids) ? implode(',', $setmenu_detail_ids) : $setmenu_detail_ids;
        $map['id'] = array('in', $setmenu_detail_ids_str);
        $map['mp_id'] = MP_ID;
        $setmenuDetailModel = M('FoodSetmenuDetail');
        $setmenu_detail = $setmenuDetailModel->where($map)->find();
        $setmenuDetailModel->startTrans();
        $setmenu_detail_data['status'] = \Admin\Model\FoodSetmenuDetailModel::$STATUS_ENABLED;
        $setmenu_detail_data['update_time'] = time();
        $setmenu_detail_enable = $setmenuDetailModel->where($map)->save($setmenu_detail_data);
        if ($setmenu_detail_enable == false) {
            $setmenuDetailModel->rollback();
            $this->error('在套餐中启用失败!');
        }
        $save_setmenu_money = $this->updateSetmenuMoney($setmenu_detail['setmenu_id']);
        if ($save_setmenu_money) {
            $setmenuDetailModel->commit();
            $this->success('在套餐中启用成功');
        }
        $setmenuDetailModel->rollback();
        $this->error('在套餐中启用失败!');
    }

    //禁用门店美食明细(前台面向商家)
    public function disable() {
        $setmenu_detail_id_arr = I('post.id');
        if (empty($setmenu_detail_id_arr)) {
            $this->error('请选择要操作的明细!');
        }
        $setmenu_detail_ids = array_unique($setmenu_detail_id_arr);
        $setmenu_detail_ids_str = is_array($setmenu_detail_ids) ? implode(',', $setmenu_detail_ids) : $setmenu_detail_ids;
        $map['id'] = array('in', $setmenu_detail_ids_str);
        $map['mp_id'] = MP_ID;
        $setmenuDetailModel = M('FoodSetmenuDetail');
        $setmenu_detail = $setmenuDetailModel->where($map)->find();
        $setmenuDetailModel->startTrans();
        $setmenu_detail_data['status'] = \Admin\Model\FoodSetmenuDetailModel::$STATUS_DISABLED;
        $setmenu_detail_data['update_time'] = time();
        $setmenu_detai_disable = $setmenuDetailModel->where($map)->save($setmenu_detail_data);
        if ($setmenu_detai_disable == false) {
            $setmenuDetailModel->rollback();
            $this->error('在套餐中禁用失败!');
        }
        $save_setmenu_money = $this->updateSetmenuMoney($setmenu_detail['setmenu_id']);
        if ($save_setmenu_money) {
            $setmenuDetailModel->commit();
            $this->success('在套餐中禁用成功');
        }
        $setmenuDetailModel->rollback();
        $this->error('在套餐中禁用失败!');
    }

}
