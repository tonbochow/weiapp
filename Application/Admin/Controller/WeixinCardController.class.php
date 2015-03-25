<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-25
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台 | 微信卡劵控制器
 */
class WeixinCardController extends FoodBaseController {

    /**
     * 卡劵管理(后台管理员)
     */
    public function index() {
        $list = $this->lists('WxCard', '', 'mp_id,id');
        $this->assign('list', $list);
        $this->meta_title = '微餐饮卡劵管理';
        $this->display('index');
    }

    //微信公众平台卡劵列表(前台面向商家)
    public function show() {
        /* 查询条件初始化 */
        $map['mp_id'] = MP_ID;
        $get_card_id = I('get.card_id'); //告警描述
        if (isset($get_card_id)) {
            $map['card_id'] = $get_card_id;
        }
        $list = $this->lists('WxCard', $map, 'mp_id,id');

        $this->assign('list', $list);
        $this->meta_title = '微信卡劵';
        $this->display('show');
    }

    //检测卡劵创建条件
    protected function checkcond() {
        //1检测是否上传了卡劵logo
        $platform = M('MicroPlatform')->where(array('id' => MP_ID))->find();
        if (empty($platform['card_pic_url'])) {
            redirect('/Admin/WeixinCard/uploadlogo');
        }
        //2检测是否创建了门店及拉取了门店列表
        $dining_rooms = M('DiningRoom')->where(array('mp_id' => MP_ID))->select();
        if ($dining_rooms == false) {
            redirect('/Admin/DiningRoom/add');
        }
        $wx_card_diningrooms = M('WxCardDiningroom')->where(array('mp_id' => MP_ID))->select();
        if ($wx_card_diningrooms == false) {
            foreach ($dining_rooms as $card_diningroom) {
                $location_arr [] = array(
                    'business_name' => strval(MP_NAME),
                    'branch_name' => strval($card_diningroom['dining_name']),
                    'province' => strval(\Admin\Model\RegionModel::getRegionName($card_diningroom['province'])),
                    'city' => strval(\Admin\Model\RegionModel::getRegionName($card_diningroom['city'])),
                    'district' => strval(\Admin\Model\RegionModel::getRegionName($card_diningroom['town'])),
                    'address' => strval($card_diningroom['address']),
                    'telephone' => strval($card_diningroom['phone']),
                    'category' => '餐饮',
                    'longitude' => $card_diningroom['longitude'],
                    'latitude' => $card_diningroom['latitude'],
                );
            }
            $location_list['location_list'] = $location_arr;
            //批量导入门店
            $batch_import_diningroom = \Admin\Model\WxCardModel::batchImportDiningRoom(APPID, APPSERCERT, json_encode($location_list));
            if ($batch_import_diningroom == false) {
                $this->error('批量导入门店失败!');
            }
            //批量拉取门店
            $get_diningroom_cond['offset'] = 0;
            $get_diningroom_cond['count'] = 0;
            $batch_get_dining_rooms = \Admin\Model\WxCardModel::batchgetDiningRoom(APPID, APPSERCERT, $get_diningroom_cond);
            if ($batch_get_dining_rooms == false) {
                $this->error('批量获取门店失败!');
            }
            foreach ($batch_get_dining_rooms as $dining_room) {
                $wx_diningroom_data[] = array(
                    'mp_id' => MP_ID,
                    'member_id' => UID,
                    'location_id' => $dining_room['location_id'],
                    'business_name' => $dining_room['business_name'],
                    'phone' => $dining_room['phone'],
                    'address' => $dining_room['address'],
                    'longitude' => $dining_room['longitude'],
                    'latitude' => $dining_room['latitude'],
                    'create_time' => time(),
                    'update_time' => time(),
                );
            }
            $card_diningroom_addall = M('WxCardDiningroom')->addAll($wx_diningroom_data);
            if ($card_diningroom_addall == false) {
                $this->error('批量添加卡劵门店失败!');
            }
        }
        //3检测是否获取了卡劵颜色
        $wx_card_colors = M('WxCardColor')->where(array('mp_id' => MP_ID))->select();
        if ($wx_card_colors == false) {
            $wx_card_colors = \Admin\Model\WxCardModel::getCardColor(APPID, APPSERCERT);
            foreach ($wx_card_colors as $card_color) {
                $card_color_data[] = array(
                    'mp_id' => MP_ID,
                    'name' => $card_color['name'],
                    'value' => $card_color['value'],
                    'create_time' => time(),
                    'update_time' => time(),
                );
            }
            $card_color_addall = M('WxCardColor')->addAll($card_color_data);
            if ($card_color_addall == false) {
                $this->error('批量添加卡劵颜色失败!');
            }
        }
    }

    //上传卡劵需要的商户logo
    public function uploadlogo() {
        $this->meta_title = '上传微信卡劵logo';
        $this->display('uploadlogo');
    }

    //创建卡劵
    public function add() {
        //检测创建卡劵条件
        $this->checkcond();
        $this->meta_title = '创建卡劵';
        $this->display('add');
    }

    //批量投放卡劵
    public function batchuse() {
        
    }

    //批量核销卡劵
    public function batchdestroy() {
        
    }

    //批量删除卡劵
    public function batchdelete() {
        
    }

    //批量失效卡劵
    public function batchdisable() {
        
    }

    //修改卡劵库存
    public function modifystock(){
        
    }
}
