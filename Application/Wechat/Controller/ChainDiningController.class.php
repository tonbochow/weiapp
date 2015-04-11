<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-11
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端 连锁餐厅信息控制器
 */
class ChainDiningController extends BaseController {

    //连锁餐厅详细信息页面
    public function view() {
        $chainDiningModel = M('ChainDining');
        $map['weiapp_chain_dining.status'] = \Admin\Model\ChainDiningModel::$STATUS_ENABLE;
        $map['weiapp_chain_dining.mp_id'] = MP_ID;
        $map['weiapp_dining_room.status'] = \Admin\Model\DiningRoomModel::$STATUS_ENABLED;

        $chain_dining = $chainDiningModel
                ->join('left  join weiapp_dining_room ON weiapp_chain_dining.id = weiapp_dining_room.chain_dining_id')
                ->where($map)
                ->order('weiapp_dining_room.create_time asc')
                ->field('weiapp_chain_dining.*,weiapp_dining_room.id as dining_room_id,weiapp_dining_room.dining_name,weiapp_dining_room.phone as dining_phone,weiapp_dining_room.mobile as dining_mobile,weiapp_dining_room.province,weiapp_dining_room.city,weiapp_dining_room.town,weiapp_dining_room.address,weiapp_dining_room.longitude,weiapp_dining_room.latitude')
                ->select();

        if ($chain_dining == false) {
            $this->error('未检索到连锁餐厅信息');
        }
        foreach ($chain_dining as $key => $chain) {
            $chain_dining[$key]['description'] = htmlspecialchars_decode(stripslashes($chain['description']));
        }

        $this->assign('chain_dining', $chain_dining);
        $this->meta_title = $chain_dining[0]['chain_dining_name'] . '详细页面';
        $this->display('view');
    }

}
