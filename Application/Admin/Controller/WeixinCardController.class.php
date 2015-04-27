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
            $batch_import_diningroom = \Admin\Model\WxCardModel::batchImportDiningRoom(APPID, APPSECRET, $location_list);
            if ($batch_import_diningroom == false) {
                $this->error('批量导入门店失败!');
            }
            //批量拉取门店
            $get_diningroom_cond['offset'] = 0;
            $get_diningroom_cond['count'] = 0;
            $batch_get_dining_rooms = \Admin\Model\WxCardModel::batchgetDiningRoom(APPID, APPSECRET, $get_diningroom_cond);
            if ($batch_get_dining_rooms == false) {
                $this->error('批量获取门店失败!');
            }

            foreach ($batch_get_dining_rooms as $dining_room) {
                $wx_diningroom_data[] = array(
                    'mp_id' => MP_ID,
                    'member_id' => UID,
                    'location_id' => !empty($dining_room['id']) ? $dining_room['id'] : $dining_room['location_id'],
                    'business_name' => !empty($dining_room['name']) ? $dining_room['name'] : $dining_room['business_name'],
                    'branch_name' => !empty($dining_room['branch_name']) ? $dining_room['branch_name'] : '',
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
            $wx_card_colors = \Admin\Model\WxCardModel::getCardColor(APPID, APPSECRET);
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
        if (IS_POST) {
            $mp_img = I('post.mp_img');
            $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/info/';
            if (!file_exists($save_path)) {
                $mkdir_res = mkdir($save_path, 0777, true);
                if (!$mkdir_res) {
                    $this->error('创建上传图片目录失败', '', true);
                }
            }
            if (!empty($mp_img) && !preg_match('/\/Uploads\w*/', $mp_img)) {//生成微信工作平台头像图片
                $mp_img_path = $save_path . C('MP_IMG_UPLOAD')['saveName'] . '.jpg';
                $mp_img_tmp = base64_decode($mp_img);
                $create_mp_img = file_put_contents($mp_img_path, $mp_img_tmp);
                if ($create_mp_img == false) {
                    $this->error('生成微信公众平台头像图片失败!', '', true);
                }
                //上传logo图片到微信服务器
                $upload_data['media'] = "@$mp_img_path";
                $media = "media=@" . $mp_img_path;
                $card_pic_url = \Admin\Model\WxCardModel::getCardPicUrl(APPID, APPSECRET, $upload_data);
                //更新公众平台
                $platform_data['mp_img'] = '/Uploads/Mp/' . MP_ID . '/info/' . C('MP_IMG_UPLOAD')['saveName'] . '.jpg';
                $platform_data['card_pic_url'] = $card_pic_url;
                $platform_data['update_time'] = time();
                $mpModel = M('MicroPlatform');
                $platform_update = $mpModel->where(array('id' => MP_ID))->save($platform_data);
                if ($platform_update == false) {
                    $this->error('更新微信公众平台头像或logo图片失败!', '', true);
                }
            } else {
                $mp_img_path = C('WEBSITE_URL') . $mp_img;
                //上传logo图片到微信服务器
                $upload_data['media'] = "@$mp_img_path";
                $media = "media=@" . $mp_img_path;
                $card_pic_url = \Admin\Model\WxCardModel::getCardPicUrl(APPID, APPSECRET, $upload_data);
                //更新公众平台
                $platform_data['card_pic_url'] = $card_pic_url;
                $platform_data['update_time'] = time();
                $mpModel = M('MicroPlatform');
                $platform_update = $mpModel->where(array('id' => MP_ID))->save($platform_data);
                if ($platform_update == false) {
                    $this->error('更新微信公众平台logo图片失败!', '', true);
                }
            }
            $this->success('上传微信公众平台卡劵logo成功', '', true);
        }
        $platform = M('MicroPlatform')->where(array('id' => MP_ID))->find();
        $card = array('mp_img' => $platform['mp_img']);
        $this->assign('card', $card);
        $this->assign('json_card', json_encode($card));
        $this->meta_title = '上传微信卡劵logo';
        $this->display('uploadlogo');
    }

    //创建卡劵
    public function add() {
        if (IS_POST) {
            $post_data = I('post.');
            if ($post_data['type'] == 1) {
                if (empty($post_data['begin_timestamp']) || empty($post_data['end_timestamp'])) {
                    $this->error('固定日期开始或结束时间必填', '', true);
                }
                $card_date_arr = array(
                    "type" => intval($post_data['type']),
                    "begin_timestamp" => strtotime($post_data['begin_timestamp']),
                    "end_timestamp" => strtotime($post_data['end_timestamp']),
                );
                $card_date_str = '"type":' . $card_date_arr['type'] . ',"begin_timestamp":' . $card_date_arr['begin_timestamp'] . ',"end_timestamp":' . $card_date_arr['end_timestamp'];
            } else if ($post_data['type'] == 2) {
                if (empty($post_data['fixed_begin_term']) || empty($post_data['fixed_term'])) {
                    $this->error('领取后多少天生效或有效天数必填', '', true);
                }
                $card_date_arr = array(
                    "type" => intval($post_data['type']),
                    "fixed_begin_term" => $post_data['fixed_begin_term'],
                    "fixed_term" => $post_data['fixed_term'],
                );
                $card_date_str = '"type":' . $card_date_arr['type'] . ',"fixed_begin_term":' . $card_date_arr['fixed_begin_term'] . ',"fixed_term":' . $card_date_arr['fixed_term'];
            }
            if (empty($post_data['location_id_list'])) {
                $card_diningrooms = M('WxCardDiningroom')->where(array('mp_id' => MP_ID))->select();
                foreach ($card_diningrooms as $dining_room) {
                    $dining_room_arr [] = $dining_room['location_id'];
                }
                $loction_id_str = implode(',', $dining_room_arr);
                $card_location_id_list = array($loction_id_str);
            } else {
                $card_location_id_list = array($post_data['location_id_list']);
                $loction_id_str = $post_data['location_id_list'];
            }
            $can_share_str = empty($post_data['can_share']) ? false : true;
            $can_give_str = empty($post_data['can_give_friend']) ? false : true;
            //微信卡劵sdk
            import('Common.Extends.Weixin.CardSDK');
            if ($card_date_arr['type'] == 1) {
                $card_date_obj = new \DateInfo($card_date_arr['type'], $card_date_arr['begin_timestamp'], $card_date_arr['end_timestamp']);
            } else {
                $card_date_obj = new \DateInfo($card_date_arr['type'], $card_date_arr['fixed_begin_term'], $card_date_arr['fixed_term']);
            }


            $base_info = new \BaseInfo($post_data['logo_url'], MP_NAME, 0, $post_data['title'], \Admin\Model\WxCardModel::getCardColorStatus($post_data['color']), $post_data['notice'], $post_data['service_phone'], $post_data['description'], $card_date_obj, new \Sku($post_data['stock']));
            $base_info->set_sub_title($post_data['title']);
            $base_info->set_use_limit(intval($post_data['get_limit']));
            $base_info->set_get_limit(intval($post_data['get_limit']));
            $base_info->set_use_custom_code(false);
            $base_info->set_bind_openid($can_give_str);
            $base_info->set_can_share($can_share_str);
            $base_info->set_url_name_type(1);
            $base_info->set_location_id_list($loction_id_str);
            $base_info->set_custom_url("http://www.52gdp.com");

            $card = new \Card($post_data['card_type'], $base_info);
            if ($post_data['card_type'] == 'GENERAL_COUPON') {
                $card->get_card()->set_default_detail($post_data['deal_detail']);
            } else if ($post_data['card_type'] == 'GROUPON') {
                $card->get_card()->set_deal_detail($post_data['deal_detail']);
            } else if ($post_data['card_type'] == 'DISCOUNT') {
                if (!is_numeric($post_data['discount']) || $post_data['discount'] <= 0 || $post_data['discount'] >= 100) {
                    $this->error('折扣比例必填0-100之间', '', true);
                }
                $card->get_card()->set_discount($post_data['discount']);
            } else if ($post_data['card_type'] == 'GIFT') {
                if (empty($post_data['gift'])) {
                    $this->error('礼品劵礼品名必填', '', true);
                }
                $card->get_card()->set_gift($post_data['gift']);
            } else if ($post_data['card_type'] == 'CASH') {
                if (!is_numeric($post_data['least_cost']) || empty($post_data['least_cost'])) {
                    $this->error('代金劵起用金额必填且必须为数字', '', true);
                }
                if (!is_numeric($post_data['reduce_cost']) || empty($post_data['reduce_cost'])) {
                    $this->error('代金劵减免金额必填且必须为数字', '', true);
                }
                $card->get_card()->set_least_cost(intval($post_data['least_cost']) * 10);
                $card->get_card()->set_reduce_cost(intval($post_data['reduce_cost']) * 10);
            } else if ($post_data['card_type'] == 'MEMBER_CARD') {
//                $card->get_card()->set_supply_bonus($post_data['deal_detail']);
            }

            $card_data = $card->toJson();
            $card_id = \Admin\Model\WxCardModel::createCard(APPID, APPSECRET, $card_data);
            if ($card_id == false) {
                $this->error('生成卡劵失败', '', true);
            }
            $post_data['brand_name'] = MP_NAME;
            $post_data['code_type'] = 0;
            $post_data['begin_timestamp'] = strtotime($post_data['begin_timestamp']);
            $post_data['end_timestamp'] = strtotime($post_data['end_timestamp']);
            $post_data['quantity'] = $post_data['stock'];
            $post_data['card_id'] = $card_id;
            $post_data['mp_id'] = MP_ID;
            $post_data['member_id'] = UID;
            $post_data['status'] = \Admin\Model\WxCardModel::$CARD_STATUS_NOT_VERIFY; //默认待审核状态
            $wxCardModel = D('WxCard');
            if ($wxCardModel->create($post_data, \Admin\Model\WxCardModel::MODEL_INSERT)) {
                $card_create = $wxCardModel->add();
                if ($card_create) {
                    $this->success('创建卡劵成功', '', true);
                }
            }
            $this->error($wxCardModel->getError(), '', true);
            //保存卡劵信息
        }
        //检测创建卡劵条件
        $this->checkcond();
        $platform = M('MicroPlatform')->where(array('id' => MP_ID))->find();
        //检索卡劵类型
        $card_types = \Admin\Model\WxCardModel::getCardType(null, false);
        foreach ($card_types as $card_id => $card_name) {
            $type_arr[] = array(
                'id' => $card_id,
                'type_name' => $card_name,
            );
        }
        //检索卡劵颜色
        $card_colors = M('WxCardColor')->where(array('mp_id' => MP_ID))->select();
        foreach ($card_colors as $color) {
            $color_arr[] = array(
                'id' => $color['value'],
                'color_name' => $color['name'],
            );
        }
        //分享领取链接
        $card_shares = \Admin\Model\WxCardModel::getCardShareStatus(null, false);
        foreach ($card_shares as $share_id => $share_name) {
            $share_arr[] = array(
                'id' => $share_id,
                'share_name' => $share_name,
            );
        }
        //卡劵转赠
        $card_gives = \Admin\Model\WxCardModel::getCardGiveStatus(null, false);
        foreach ($card_gives as $give_id => $give_name) {
            $give_arr[] = array(
                'id' => $give_id,
                'give_name' => $give_name,
            );
        }
        //检索微信服务器门店
        $card_diningrooms = M('WxCardDiningroom')->where(array('mp_id' => MP_ID))->select();
        foreach ($card_diningrooms as $diningroom) {
            if (IS_CHAIN) {
                $diningroom_arr[] = array(
                    'id' => $diningroom['location_id'],
                    'diningroom_name' => $diningroom['branch_name'],
                );
            } else {
                $diningroom_arr[] = array(
                    'id' => $diningroom['location_id'],
                    'diningroom_name' => $diningroom['business_name'],
                );
            }
        }
        //检索卡劵有效期类型
        $card_validatetype = \Admin\Model\WxCardModel::getValidateType(null, false);
        foreach ($card_validatetype as $id => $validate_type) {
            $validatetype_arr[] = array(
                'id' => $id,
                'validate_type' => $validate_type,
            );
        }

        $card_pic_url = !empty($platform['card_pic_url']) ? "'" . $platform['card_pic_url'] . "'" : "''";
        $this->assign('card_pic_url', $card_pic_url);
        $this->assign('type_arr', !empty($type_arr) ? json_encode($type_arr) : '');
        $this->assign('color_arr', !empty($color_arr) ? json_encode($color_arr) : '');
        $this->assign('share_arr', !empty($share_arr) ? json_encode($share_arr) : '');
        $this->assign('give_arr', !empty($give_arr) ? json_encode($give_arr) : '');
        $this->assign('diningroom_arr', !empty($diningroom_arr) ? json_encode($diningroom_arr) : '');
        $this->assign('validatetype_arr', !empty($validatetype_arr) ? json_encode($validatetype_arr) : '');
        $this->assign('platform', $platform);
        $this->meta_title = '创建卡劵';
        $this->display('add');
    }

    //生成推广卡劵二维码
    public function qrcode() {
        $card_id = I('get.card_id', '', '');
        $card_info = M('WxCard')->where(array('mp_id' => MP_ID, 'card_id' => $card_id))->find();
        if ($card_info == false) {
            $this->error('未检索到要要创建二维码的卡劵');
        }
        $qrcode_data = array(
            "action_name" => "QR_CARD",
            "action_info" => array(
                "card" => array(
                    "card_id" => $card_id,
                    "code" => "",
                    "openid" => "",
                    "expire_seconds" => "",
                    "is_unique_code" => false,
                    "outer_id" => 1
                )
            )
        );
//        $qrcode_data = '{
//            "action_name":"QR_CARD",
//            "action_info":{
//                "card":{
//                    "card_id":"'. $card_id.'",
//                    "code":"",
//                    "openid":"",
//                    "expire_seconds":"",
//                    "is_unique_code":false,
//                    "outer_id":0
//                }
//             }
//        }';
//        var_dump(json_encode($qrcode_data,JSON_UNESCAPED_UNICODE));
        $qrcode_data = '{
       "action_name":"QR_CARD", 
       "action_info":{ 
            "card":{ 
                "card_id":"p-Wvujg4pZnM93exuL4dvUhnp2kA", 
                "code":"", 
                "openid":"o-WvujkhZr2kYmlQVeAnNNovdO5M", 
                "expire_seconds":"1800"， 
                "is_unique_code":false, 
                "outer_id": 1 
                } 
            } 
       }';
        $qrcode_ticket = \Admin\Model\WxCardModel::createCardQrcode(APPID, APPSECRET, $qrcode_data);
        if ($qrcode_ticket == false) {
            $this->error('获取二维码ticket失败');
        }
        $qrcode_url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" . $qrcode_ticket;
        redirect($qrcode_url);
    }

    //微信卡劵详细
    public function detail() {
        $id = I('get.id', '', 'intval');
        $wx_card = M('WxCard')->where(array('mp_id' => MP_ID, 'id' => $id))->find();
        if (empty($wx_card)) {
            $this->error('未检索到您要查看的卡劵');
        }

//        $wx_card['color'] = \Admin\Model\WxCardModel::getCardColorStatus($wx_card['color']);
        $this->assign('wx_card', $wx_card);
        $this->meta_title = '卡劵详细';
        $this->display('detail');
    }

    //批量投放卡劵
    public function batchuse() {
        
    }

    //核销卡劵
    public function destroy() {
        if (IS_POST) {
            $card_data = I('post.');
            if (empty($card_data['card_id'])) {
                unset($card_data['card_id']);
            }
            $consume_card = \Admin\Model\WxCardModel::consumeCard(APPID, APPSECRET, $card_data);
            if ($consume_card) {
                $this->success('核销成功', '', true);
            }
            $this->error('核销失败', '', true);
        }
        $this->meta_title = '核销卡劵';
        $this->display('destroy');
    }

    //批量删除卡劵
    public function batchdelete() {
        $card_id_arr = I('post.card_ids');
        if (empty($card_id_arr)) {
            $this->error('请选择要操作的卡劵!');
        }
        $card_ids = array_unique($card_id_arr);
        //循环批量删除card_id
        foreach ($card_ids as $card_id) {
            $card_del = \Admin\Model\WxCardModel::deleteCard(APPID, APPSECRET, $card_id);
            if ($card_del == false) {
                $this->error($card_id . "卡劵删除失败", '', true);
            }
        }
        $this->success('卡劵删除成功', '', true);
    }

    //批量失效卡劵
    public function batchdisable() {
        $card_id_arr = I('post.card_ids');
        if (empty($card_id_arr)) {
            $this->error('请选择要操作的卡劵!');
        }
        $card_ids = array_unique($card_id_arr);
        //循环批量设置card_id失效
        foreach ($card_ids as $card_id) {
            $card_info = M('WxCard')->where(array('mp_id' => MP_ID, 'card_id' => $card_id))->find();
            if ($card_info['use_custom_code']) {
                $card_data['card_id'] = $card_id;
            }
            $card_data['code'] = $card_info['code'];
            $card_unavailable = \Admin\Model\WxCardModel::setCardUnavailable(APPID, APPSECRET, $card_data);
            if ($card_unavailable == false) {
                $this->error($card_id . "设置卡劵失效失败", '', true);
            }
        }
        $this->success('设置卡劵失效成功', '', true);
    }

    //修改卡劵库存
    public function modifystock() {
        if (IS_POST) {
            $card_data = I('post.');
            $card_data['card_id'] = $card_data['card_id'];
            $card_data['increase_stock_value'] = isset($card_data['increase_stock_value']) ? intval($card_data['increase_stock_value']) : 0;
            $card_data['reduce_stock_value'] = isset($card_data['reduce_stock_value']) ? intval($card_data['reduce_stock_value']) : 0;
            $modify_stock = \Admin\Model\WxCardModel::modifyCardStock(APPID, APPSECRET, $card_data);
            if ($modify_stock) {
                $map['mp_id'] = MP_ID;
                $map['card_id'] = $card_data['card_id'];
                $quantity = bcsub($card_data['increase_stock_value'], $card_data['reduce_stock_value']);
                M('WxCard')->where($map)->setInc('quantity', $quantity);
//                if ($quantity >= 0) {
//                    M('WxCard')->where($map)->setInc('quantity', intval($quantity));
//                } else {
//                    M('WxCard')->where($map)->setDec('quantity', intval($quantity));
//                }
                $this->success('修改卡劵库存成功', '', true);
            }
            $this->error('修改卡劵库存失败', '', true);
        }
        $card_id = I('get.card_id', '', 'trim');
        $card_info = M('WxCard')->where(array('mp_id' => MP_ID, 'card_id' => $card_id))->find();
        if ($card_info == false) {
            $this->error('修改库存的卡劵不存在');
        }
        $this->assign('card_id', $card_id);
        $this->meta_title = '设置卡劵库存';
        $this->display('modifystock');
    }

}
