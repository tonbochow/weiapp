<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-11
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端餐厅控制器
 */
class DiningRoomController extends BaseController {

    //餐厅详细页面
    public function view() {
        $diningRoomModel = M('DiningRoom');
        $id = I('get.id', '', 'intval');
        $map['weiapp_dining_room.id'] = $id;
        $map['weiapp_dining_room.status'] = \Admin\Model\DiningRoomModel::$STATUS_ENABLED;
        $map['weiapp_dining_room.mp_id'] = MP_ID;

        $dining_rooms = $diningRoomModel
                ->join('left  join weiapp_dining_room_detail ON weiapp_dining_room.id = weiapp_dining_room_detail.dining_room_id')
                ->where($map)
                ->order('weiapp_dining_room_detail.input_name,create_time asc')
                ->field('weiapp_dining_room.*,weiapp_dining_room_detail.url')
                ->select();
        if ($dining_rooms == false) {
            $this->error('未检索到餐厅信息');
        }
        foreach ($dining_rooms as $key => $dining_room) {
            $dining_rooms[$key]['description'] = htmlspecialchars_decode(stripslashes($dining_room['description']));
        }
//        dump($dining_rooms);
        $this->assign('dining_rooms', $dining_rooms);
        $this->meta_title = $dining_rooms[0]['dining_name'] . ' | 详细信息页面';
        $this->display('view');
    }

}
