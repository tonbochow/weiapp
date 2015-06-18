<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-31
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端美食控制器
 */
class FoodController extends BaseController {

    //美食列表
    public function index() {

        $this->display('index');
    }

    //美食详细页面
    public function view() {
        $foodModel = M('Food');
        $id = I('get.id', '', 'intval');
        $map['weiapp_food.id'] = $id;
        $map['weiapp_food.status'] = \Admin\Model\FoodModel::$STATUS_ENABLED;
        $map['weiapp_food.mp_id'] = MP_ID;

        $food = $foodModel
                ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                ->where($map)
                ->order('weiapp_food_detail.default_share desc')
                ->field('weiapp_food.*,weiapp_food_detail.url,weiapp_food_detail.default_share')
                ->select();
        if (!empty($food)) {//美食浏览次数自增
            $inc = $foodModel->where("id=$id")->setInc('view_times',1);
        }

        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }

        $default_pic = \Admin\Model\FoodDetailModel::getFoodPic($food[0]['id']);
        //美食详细页面微信分享设置
        $share_info = array(
            'title' => $food[0]['share_title'],
            'desc' => $food[0]['share_desc'],
            'link' => get_current_url(),
            'imgUrl' => 'http://' . $_SERVER['HTTP_HOST'] . $default_pic,
        );

        $this->assign('share_info', $share_info);
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('food', $food);
        $this->meta_title = $this->mp['mp_name'] . ' | ' . $food[0]['food_name'];
        $this->display('view');
    }

    //美食添加到美食篮
    public function addcar() {
        if (IS_POST) {
            $food_id = I('post.id', '', 'intval');
            $post_dining_room_id = I('post.dining_room_id', '', 'intval');
//            $wx_open_id = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
            $wx_open_id = $this->weixin_userinfo['wx_openid'];
            if ($post_dining_room_id) {
                $map['dining_room_id'] = $post_dining_room_id;
            }
            $map['wx_openid'] = $wx_open_id;
            $map['mp_id'] = MP_ID;
            $map['food_setmenu_id'] = $food_id;
            $map['type'] = \Wechat\Model\FoodCarDetailModel::$TYPE_FOOD;
            $food_car_detail = M('FoodCarDetail')->where($map)->find();
            if ($food_car_detail) {
                $this->error('已加入美食篮', '', true);
            }

            $foodCarModel = D('FoodCar');
            $foodCarModel->startTrans();
            $car_map['wx_openid'] = $wx_open_id;
            $car_map['mp_id'] = MP_ID;
            $food_car = M('FoodCar')->where($car_map)->find();
            if ($food_car == false) {//美食篮主表插入
                $food_car_data['mp_id'] = MP_ID;
                $food_car_data['wx_openid'] = $wx_open_id;
                if ($foodCarModel->create($food_car_data, \Wechat\Model\FoodCarModel::MODEL_INSERT)) {
                    $car_id = $foodCarModel->add();
                    if ($car_id == false) {
                        $foodCarModel->rollback();
                        $this->error($foodCarModel->getError(), '', true);
                    }
                } else {
                    $foodCarModel->rollback();
                    $this->error($foodCarModel->getError(), '', true);
                }
            } else {
                $car_id = $food_car['id'];
            }
            $food_info = M('Food')->where(array('id' => $food_id))->find();
            if (intval($food_info['dining_room_id']) == 0) {
                $dining_room_id = I('post.dining_room_id');
                if (intval($dining_room_id) == 0) {
                    $this->error('请先选择用餐或配送餐厅', '', true);
                }
            }
            $car_detail_data['mp_id'] = MP_ID;
            $car_detail_data['wx_openid'] = $wx_open_id;
            $car_detail_data['car_id'] = $car_id;
            $car_detail_data['dining_room_id'] = !empty($food_info['dining_room_id']) ? $food_info['dining_room_id'] : $dining_room_id;
            $car_detail_data['type'] = \Wechat\Model\FoodCarDetailModel::$TYPE_FOOD;
            $car_detail_data['food_setmenu_id'] = $food_id;
            $car_detail_data['name'] = $food_info['food_name'];
            $car_detail_data['count'] = 1;
            $car_detail_data['price'] = $food_info['weixin_price'];
            $car_detail_data['amount'] = bcmul($food_info['weixin_price'], 1, 2);
            $foodCarDetailModel = D('FoodCarDetail');
            if ($foodCarDetailModel->create($car_detail_data, \Wechat\Model\FoodCarDetailModel::MODEL_INSERT)) {
                $food_car_detail_id = $foodCarDetailModel->add();
                if ($food_car_detail_id == false) {
                    $foodCarModel->rollback();
                    $this->error($foodCarDetailModel->getError(), '', true);
                }
            } else {
                $foodCarModel->rollback();
                $this->error($foodCarDetailModel->getError(), '', true);
            }
            $foodCarModel->commit();
            $this->success('加入美食篮成功', '', true);
        }
    }

}
