<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-32
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端菜品分类控制器
 */
class FoodCateController extends BaseController {

    //菜品分类
    public function index() {
        if ($this->mp['is_chain']) {
            $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
            $dining_room_arr[] = array('id' => '0', 'dining_name' => '所有门店通用');
            foreach ($dining_rooms as $val) {
                $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
            }
        }
        

        $foodCateModel = M('FoodCategory');
        $map['mp_id'] = MP_ID;
        $map['status'] = \Admin\Model\FoodCategoryModel::$STATUS_ENABLED;
        $food_cates = $foodCateModel->where($map)->select();
//        dump($food_cates);
        
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('selected_dining_room_id', json_encode(null));
        $this->assign('food_cates', $food_cates);
        $this->meta_title = $this->mp['mp_name'] . "菜品分类";
        $this->display('index');
    }

}
