<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-31
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端购餐车控制器
 */
class FoodCarController extends BaseController {

    //购餐车
    public function index() {
//        $map['mp_id'] = MP_ID;
////        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
//        $map['wx_openid'] = 'wx_abcdef';
//        $carDetails = M('FoodCarDetail')->where($map)->select();
        $map['weiapp_food_car_detail.mp_id'] = MP_ID;
        $map['weiapp_food_car_detail.wx_openid'] = 'wx_abcdef';
        $carDetails = M('FoodCarDetail')
                ->join('left  join weiapp_food_detail ON weiapp_food_car_detail.food_setmenu_id = weiapp_food_detail.food_id')
                ->where($map)
                ->group('weiapp_food_car_detail.food_setmenu_id')
                ->order('weiapp_food_detail.default_share')
                ->field('weiapp_food_car_detail.*,weiapp_food_detail.url')
                ->select();
//        dump($carDetails);

        $this->assign('car_details', $carDetails);
        $this->assign('json_car_details',  json_encode($carDetails));
        $this->meta_title = "购餐车详细";
        $this->display('index');
    }

    //购餐车菜品或套餐数量增加
    public function add() {
        
    }

    //购餐车菜品或套餐数量减少
    public function reduce() {
        
    }

    //从购餐车去除菜品或套餐
    public function del() {
        
    }

}
