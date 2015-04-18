<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-09
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端 菜品套餐控制器
 */
class FoodSetmenuController extends BaseController {

    //菜品套餐列表
    public function index() {
        $foodSetmenuModel = M('FoodSetmenu');
        $map['mp_id'] = MP_ID;
        $map['status'] = \Admin\Model\FoodSetmenuModel::$STATUS_ENABLED;
        $setmenu_count = $foodSetmenuModel->where($map)->count();
        $page_num = 10;
        import('Common.Extends.Page.BootstrapPage');
        $Page = new \BootstrapPage($setmenu_count, $page_num);
        $show = $Page->show();
        $setmenus = $foodSetmenuModel->where($map)->order('create_time desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        foreach ($dining_rooms as $val) {
            $dining_room_arr[$val['id']] = $val['dining_name'];
        }

        $this->assign('dining_room_arr', $dining_room_arr);
        $this->assign('page', $show);
        $this->assign('setmenus', $setmenus);
        $this->meta_title = $this->mp['mp_name'] . " | 菜品套餐列表";
        $this->display('index');
    }

    //菜品套餐详细页面
    public function view() {
        $foodSetmenuModel = M('FoodSetmenu');
        $id = I('get.id', '', 'intval');
        $map['weiapp_food_setmenu.id'] = $id;
        $map['weiapp_food_setmenu.status'] = \Admin\Model\FoodSetmenuModel::$STATUS_ENABLED;
        $map['weiapp_food_setmenu.mp_id'] = MP_ID;
        $map['weiapp_food_setmenu_detail.status'] = \Admin\Model\FoodSetmenuDetailModel::$STATUS_ENABLED;

        $foodsetmenu = $foodSetmenuModel
                ->join('left  join weiapp_food_setmenu_detail ON weiapp_food_setmenu.id = weiapp_food_setmenu_detail.setmenu_id')
                ->where($map)
                ->order('weiapp_food_setmenu_detail.create_time asc')
                ->field('weiapp_food_setmenu.*,weiapp_food_setmenu_detail.food_id,weiapp_food_setmenu_detail.food_name,weiapp_food_setmenu_detail.weixin_price,weiapp_food_setmenu_detail.count as food_count,weiapp_food_setmenu_detail.amount as food_amount')
                ->select();
        if($foodsetmenu == false){ //可能是未设置明细 则只检索主表
            unset($map['weiapp_food_setmenu_detail.status']);
            $foodsetmenu = $foodSetmenuModel->where($map)->select();
        }

        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('foodsetmenu', $foodsetmenu);
        $this->meta_title = $this->mp['mp_name']. ' | 套餐详细页面';
        $this->display('view');
    }

    //菜品套餐添加到购物车
    public function addcar() {
        if (IS_POST) {
            $setmenu_id = I('post.id', '', 'intval');
            $post_dining_room_id = I('post.dining_room_id', '', 'intval');
//            $wx_open_id = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
            $wx_open_id = $this->weixin_userinfo['wx_openid'];
            if($post_dining_room_id){
                $map['dining_room_id'] = $post_dining_room_id;
            }
            $map['wx_openid'] = $wx_open_id;
            $map['mp_id'] = MP_ID;
            $map['food_setmenu_id'] = $setmenu_id;
            $map['type'] = \Wechat\Model\FoodCarDetailModel::$TYPE_SETMENU;
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
            } else {
                $car_id = $food_car['id'];
            }
            $setmenu_info = M('FoodSetmenu')->where(array('id' => $setmenu_id))->find();
            if (intval($setmenu_info['dining_room_id']) == 0) {
                $dining_room_id = I('post.dining_room_id');
                if (intval($dining_room_id) == 0) {
                    $this->error('请先选择用餐或配送餐厅', '', true);
                }
            }
            $car_detail_data['mp_id'] = MP_ID;
            $car_detail_data['wx_openid'] = $wx_open_id;
            $car_detail_data['car_id'] = $car_id;
            $car_detail_data['dining_room_id'] = !empty($setmenu_info['dining_room_id']) ? $setmenu_info['dining_room_id'] : $dining_room_id;
            $car_detail_data['type'] = \Wechat\Model\FoodCarDetailModel::$TYPE_SETMENU;
            $car_detail_data['food_setmenu_id'] = $setmenu_id;
            $car_detail_data['name'] = $setmenu_info['setmenu_name'];
            $car_detail_data['count'] = 1;
            $car_detail_data['price'] = $setmenu_info['setmenu_money'];
            $car_detail_data['amount'] = bcmul($setmenu_info['setmenu_money'], 1, 2);
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
