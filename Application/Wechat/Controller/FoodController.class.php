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
    public function view(){
        $foodModel = M('Food');
        $id = I('get.id','','intval');
        $map['weiapp_food.id'] = $id;
        $map['weiapp_food.status'] = \Admin\Model\FoodModel::$STATUS_ENABLED;
        $map['weiapp_food.mp_id'] = MP_ID;
        $map['weiapp_food_detail.status'] = \Admin\Model\FoodDetailModel::$STATUS_ENABLED;
        
        $food = $foodModel
                ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                ->where($map)
                ->order('weiapp_food_detail.default_share desc')
                ->field('weiapp_food.*,weiapp_food_detail.url,weiapp_food_detail.default_share')
                ->select();
//        dump($food);
        $this->assign('food',$food);
        $this->meta_title = $food['food_name'].'详细页面';
        $this->display('view');
    }

}
