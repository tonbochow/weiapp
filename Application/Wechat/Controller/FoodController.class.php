<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-31
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端菜品控制器
 */
class FoodController extends BaseController {

    //菜品列表
    public function index() {

        $this->display('index');
    }

    //菜品详细页面
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
        
        $this->assign('food', $food);
        $this->meta_title = $food['food_name'] . '详细页面';
        $this->display('view');
    }

    //菜品添加到购物车
    public function addcar() {
        if (IS_POST) {
            $food_id = I('post.id', '', 'intval');
            $wx_open_id = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
            $map['wx_openid'] = $wx_open_id;
            $map['mp_id'] = MP_ID;
            $map['food_setmenu_id'] = $food_id;
            $food_car_detail = M('FoodCarDetail')->where($map)->find();
            if ($food_car_detail) {
                $this->error('已加入购餐车', '', true);
            }
            $foodCarModel = D('FoodCar');
            $foodCarModel->startTrans();
            $car_map['wx_openid'] = $wx_open_id;
            $car_map['mp_id'] = MP_ID;
            $food_car = M('FoodCar')->where($car_map)->find();
            if ($food_car == false) {//购餐车主表插入
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
            }else{
                $car_id = $food_car['id'];
            }
            $food_info = M('Food')->where(array('id' => $food_id))->find();
            $car_detail_data['mp_id'] = MP_ID;
            $car_detail_data['wx_openid'] = $wx_open_id;
            $car_detail_data['car_id'] = $car_id;
            $car_detail_data['dining_room_id'] = $food_info['dining_room_id'];
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
            $this->success('加入购餐车成功', '', true);
        }
    }

}
