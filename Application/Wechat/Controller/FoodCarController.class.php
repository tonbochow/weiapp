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
        $map['mp_id'] = MP_ID;
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $carDetails = M('FoodCarDetail')->where($map)->select();
        foreach ($carDetails as $key=>$detail){
            if($detail['type'] == \Wechat\Model\FoodCarDetailModel::$TYPE_FOOD){
                $carDetails[$key]['url'] = \Admin\Model\FoodDetailModel::getFoodPic($detail['food_setmenu_id']);
            }else{
                $carDetails[$key]['url'] = \Admin\Model\FoodSetmenuModel::getFoodSetmenuUrl($detail['food_setmenu_id']);
            }
        }
//        $map['weiapp_food_car_detail.mp_id'] = MP_ID;
//        $map['weiapp_food_car_detail.wx_openid'] = 'wx_abcdef';
//        $carDetails = M('FoodCarDetail')
//                ->join('left  join weiapp_food_detail ON weiapp_food_car_detail.food_setmenu_id = weiapp_food_detail.food_id')
//                ->where($map)
//                ->group('weiapp_food_car_detail.food_setmenu_id')
//                ->order('weiapp_food_detail.default_share')
//                ->field('weiapp_food_car_detail.*,weiapp_food_detail.url')
//                ->select();
//        dump($carDetails);
        $total_amount = M('FoodCarDetail')->where(array('mp_id' => MP_ID, 'wx_openid' => $this->weixin_userinfo['wx_openid']))->sum('amount');
//        $total_amount = M('FoodCarDetail')->where(array('mp_id' => MP_ID, 'wx_openid' => 'wx_abcdef'))->sum('amount');

        $this->assign('total_amount', $total_amount);
        $this->assign('car_details', $carDetails);
        $this->assign('json_car_details', json_encode($carDetails));
        $this->meta_title = $this->mp['mp_name'] ." | 美食篮详细";
        $this->display('index');
    }

    //购餐车菜品或套餐数量增加
    public function add() {
        $carDetailModel = M('FoodCarDetail');
        $car_detail_id = I('post.id');
        $map['id'] = $car_detail_id;
        $map['mp_id'] = MP_ID;
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $car_detail = $carDetailModel->where($map)->find();
        $data['count'] = $car_detail['count'] + 1;
        $data['amount'] = bcmul($data['count'], $car_detail['price'], 2);
        $data['update_time'] = time();
        $car_detail_save = $carDetailModel->where($map)->save($data);
        if ($car_detail_save) {
            $total_amount = $carDetailModel->where(array('car_id' => $car_detail['car_id']))->sum('amount');
            $this->success($total_amount, '', true);
        }
        $this->error($car_detail['name'] . '增加失败', '', true);
    }

    //购餐车菜品或套餐数量减少
    public function reduce() {
        $carDetailModel = M('FoodCarDetail');
        $car_detail_id = I('post.id');
        $map['id'] = $car_detail_id;
        $map['mp_id'] = MP_ID;
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $car_detail = $carDetailModel->where($map)->find();
        $data['count'] = $car_detail['count'] - 1;
        $data['amount'] = bcmul($data['count'], $car_detail['price'], 2);
        $data['update_time'] = time();
        $car_detail_save = $carDetailModel->where($map)->save($data);
        if ($car_detail_save) {
            $total_amount = $carDetailModel->where(array('car_id' => $car_detail['car_id']))->sum('amount');
            $this->success($total_amount, '', true);
        }
        $this->error($car_detail['name'] . '减少失败', '', true);
    }

    //从购餐车去除菜品或套餐
    public function del() {
        $carDetailModel = M('FoodCarDetail');
        $car_detail_id = I('post.id');
        $map['id'] = $car_detail_id;
        $map['mp_id'] = MP_ID;
        $car_detail = $carDetailModel->where($map)->find();
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $car_detail_del = $carDetailModel->where($map)->delete();
        if ($car_detail_del) {
            $total_amount = $carDetailModel->where(array('car_id' => $car_detail['car_id']))->sum('amount');
            $this->success($total_amount, '', true);
        }
        $this->error($car_detail['name'] . '删除失败', '', true);
    }

    //预生成订单
    public function commitorder() {
        //微信收货地址共享
        import('Common.Extends.Weixin.WeixinAddress');
        $url = get_current_url();
        $weixinAddress = new \WeixinAddress();
        $access_token_arr = \Admin\Model\MicroPlatformModel::getOauthAccessToken(APPID, APPSECRET);
        $access_token = $access_token_arr['access_token'];
        $sign_url = $url.'&code='.$access_token_arr['code'].'&state='.$access_token_arr['state'];
        $sign_info = array(
            'accessToken' => $access_token,
            'url' => $sign_url,
            'timeStamp' => time(),
            'nonceStr' => $weixinAddress->create_noncestr(),
            'appId' => $this->mp['appid']
        );
        $address_sign = $weixinAddress->get_address_sign($sign_info);
        $info_array = array(
            'appId' => $this->mp['appid'],
            'scope' => 'jsapi_address',
            'signType' => "sha1",
            "addrSign" => $address_sign,
            'timeStamp' => '"'.$sign_info['timeStamp'].'"',
            'nonceStr' => '"'.$sign_info['nonceStr'].'"'
        );
        $address_sign_info = json_encode($info_array);
        $this->assign('address_sign_info', $address_sign_info);
//        $map['weiapp_food_car_detail.mp_id'] = MP_ID;
////        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
//        $map['weiapp_food_car_detail.wx_openid'] = 'wx_abcdef';
////        $car_details = M('FoodCarDetail')->where($map)->select();
//        $car_details = M('FoodCarDetail')
//                ->join('left  join weiapp_food_detail ON weiapp_food_car_detail.food_setmenu_id = weiapp_food_detail.food_id')
//                ->where($map)
//                ->group('weiapp_food_car_detail.food_setmenu_id')
//                ->order('weiapp_food_detail.default_share')
//                ->field('weiapp_food_car_detail.*,weiapp_food_detail.url')
//                ->select();
        $map['mp_id'] = MP_ID;
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
        $car_details = M('FoodCarDetail')->where($map)->select();
        foreach ($car_details as $key=>$detail){
            if($detail['type'] == \Wechat\Model\FoodCarDetailModel::$TYPE_FOOD){
                $car_details[$key]['url'] = \Admin\Model\FoodDetailModel::getFoodPic($detail['food_setmenu_id']);
            }else{
                $car_details[$key]['url'] = \Admin\Model\FoodSetmenuModel::getFoodSetmenuUrl($detail['food_setmenu_id']);
            }
        }
        
        if ($car_details == false) {
            $this->error('美食篮无美食或套餐');
        }
        $total_amount = 0;
        foreach ($car_details as $key => $detail) {
//            $detail['dining_name'] = \Admin\Model\DiningRoomModel::getDiningRoomName($detail['dining_room_id']);
            $detail['dining_info'] = \Admin\Model\DiningRoomModel::getDiningRoom($detail['dining_room_id']);
            $car_detail_arr[$detail['dining_room_id']][] = $detail;
            $total_amount = bcadd($detail['amount'], $total_amount, 2);
        }

        $dining_types = \Admin\Model\DiningRoomModel::getWeixinDiningRoomType(null, false);
        $this->assign('dining_types', $dining_types);
        $dining_pay_types = \Admin\Model\DiningRoomModel::getWeixinDiningRoomPayType(null, false);
        $this->assign('dining_pay_types', $dining_pay_types);

        $this->assign('car_id', $car_details[0]['car_id']);
        $this->assign('total_amount', $total_amount);
        $this->assign('car_details', $car_detail_arr);
        $this->assign('json_car_detail_arr', json_encode($car_detail_arr));
        $this->meta_title = "美食篮预生成订单";
        $this->display('commitorder');
    }

}
