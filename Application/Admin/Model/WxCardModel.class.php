<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-25
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 美食 微信卡劵模型
 */
class WxCardModel extends Model {

    public static $CARD_STATUS_NOT_VERIFY = 'CARD_STATUS_NOT_VERIFY'; //待审核
    public static $CARD_STATUS_VERIFY_FALL = 'CARD_STATUS_VERIFY_FALL'; //审核失败
    public static $CARD_STATUS_VERIFY_OK = 'CARD_STATUS_VERIFY_OK'; //通过审核
    public static $CARD_STATUS_USER_DELETE = 'CARD_STATUS_USER_DELETE'; //卡劵被用户删除
    public static $CARD_STATUS_USER_DISPATCH = 'CARD_STATUS_USER_DISPATCH'; //在公众平台投放过的卡劵
    public static $CAN_SHARE_YES = 1; //可分享
    public static $CAN_SHARE_NO = 0; //不可分享
    public static $CAN_GIVE_FRIEND_YES = 1; //可转赠
    public static $CAN_GIVE_FRIEND_NO = 0; //不可转赠
    public static $FIXED_DATE = 1; //卡劵有效期类型:固定日期
    public static $FIXED_TERM = 2; //固定时长
    public static $GENERAL_COUPON = 'GENERAL_COUPON'; //通用劵 优惠券
    public static $GROUPON = 'GROUPON'; //团购劵
    public static $DISCOUNT = 'DISCOUNT'; //折扣劵
    public static $GIFT = 'GIFT'; //礼品劵
    public static $CASH = 'CASH'; //代金劵
    public static $MEMBER_CARD = 'MEMBER_CARD'; //会员卡
    public static $SCENIC_TICKET = 'SCENIC_TICKET'; //门票
    public static $MOVIE_TICKET = 'MOVIE_TICKET'; //电影票
    public static $BOARDING_PASS = 'BOARDING_PASS'; //飞机票
    public static $LUCKY_MONEY = 'LUCKY_MONEY'; //红包
    public static $MEETING_TICKET = 'MEETING_TICKET'; //会议门票

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('card_id', 'require', '卡劵id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('card_type', 'require', '卡劵类型不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('logo_url', 'require', '卡劵logo不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('brand_name', 'require', '卡劵品牌名不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title', 'require', '卡劵标题不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('sub_title', 'require', '卡劵副标题不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('color', 'require', '卡劵颜色不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('service_phone', 'require', '客服电话不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('deal_detail', 'require', '优惠详情不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('description', 'require', '使用须知不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('quantity', 'require', '库存不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取卡劵状态
    public static function getWxCardStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$CARD_STATUS_NOT_VERIFY] = '待审核';
        $status_arr[self::$CARD_STATUS_VERIFY_FALL] = '审核失败';
        $status_arr[self::$CARD_STATUS_VERIFY_OK] = '通过审核';
        $status_arr[self::$CARD_STATUS_USER_DELETE] = '卡劵被用户删除';
        $status_arr[self::$CARD_STATUS_USER_DISPATCH] = '公众平台投放过的卡劵';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取卡劵领取页面是否可分享
    public static function getCardShareStatus($share = null, $has_choice = true) {
        if ($has_choice) {
            $share_arr = array('' => '请选择');
        }
        $share_arr[self::$CAN_SHARE_NO] = '不可分享';
        $share_arr[self::$CAN_SHARE_YES] = '可分享';
        if ($share !== null) {
            return $share_arr[$share];
        }
        return $share_arr;
    }

    //获取卡劵领取页面是否可赠送
    public static function getCardGiveStatus($give = null, $has_choice = true) {
        if ($has_choice) {
            $give_arr = array('' => '请选择');
        }
        $give_arr[self::$CAN_GIVE_FRIEND_NO] = '不可转赠';
        $give_arr[self::$CAN_GIVE_FRIEND_YES] = '可转赠';
        if ($give !== null) {
            return $give_arr[$give];
        }
        return $give_arr;
    }

    //根据卡劵颜色值获取卡劵颜色名
    public static function getCardColorStatus($value = null, $has_choice = true) {
        if ($has_choice) {
            $color_arr = array('' => '请选择');
        }
        $colors = M('WxCardColor')->where(array('mp_id' => MP_ID))->select();
        foreach ($colors as $color) {
            $color_arr[$color['value']] = $color['name'];
        }
        if ($value !== null) {
            return $color_arr[$value];
        }
        return $color_arr;
    }

    //获取卡劵有效期类型
    public static function getValidateType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$FIXED_DATE] = '固定日期';
        $type_arr[self::$FIXED_TERM] = '固定时长';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取卡劵类型
    public static function getCardType($type = null, $has_choice = true, $base = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$GENERAL_COUPON] = '通用劵|优惠券'; //对应 0
        $type_arr[self::$GROUPON] = '团购劵'; //对应 1
        $type_arr[self::$DISCOUNT] = '折扣劵'; //对应 2
        $type_arr[self::$GIFT] = '礼品劵'; //对应 3
        $type_arr[self::$CASH] = '代金劵'; //对应 4
//        $type_arr[self::$MEMBER_CARD] = '会员卡';
        if (!$base) {
            $type_arr[self::$MEMBER_CARD] = '会员卡'; //对应 5
            $type_arr[self::$SCENIC_TICKET] = '门票'; //对应 6
            $type_arr[self::$MOVIE_TICKET] = '电影票'; //对应 8
            $type_arr[self::$BOARDING_PASS] = '飞机票';
            $type_arr[self::$LUCKY_MONEY] = '红包';
            $type_arr[self::$MEETING_TICKET] = '会议门票';
        }

        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //卡劵接口创建卡劵时对应卡劵数值类型
    public static function getCardTypeNum($type) {
        $type_arr[self::$GENERAL_COUPON] = 0;
        $type_arr[self::$GROUPON] = 1;
        $type_arr[self::$DISCOUNT] = 2;
        $type_arr[self::$GIFT] = 3;
        $type_arr[self::$CASH] = 4;
        $type_arr[self::$MEMBER_CARD] = 5;
        $type_arr[self::$SCENIC_TICKET] = 6;
        $type_arr[self::$MOVIE_TICKET] = 8;
        return $type_arr[$type];
    }

    //获取卡劵颜色
    public static function getCardColorByName($name) {
        $card = M('WxCard')->where(array('mp_id' => MP_ID, 'name' => $name))->find();
        return $card['value'];
    }

    /**
     * 获取商户logoURL
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $pic_buffer 图片文件的数据流
     */
    public static function getCardPicUrl($appid, $appsecret, $pic_buffer) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=" . $access_token;
        $upload = MicroPlatformModel::media_curl($url, $pic_buffer);
        if ($upload['errcode'] > 0) {
            return false;
        }
        return $upload['url'];
    }

    /**
     * 批量导入商家门店信息
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $dining_room_data 商家门店信息
     */
    public static function batchImportDiningRoom($appid, $appsecret, $dining_room_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/location/batchadd?access_token=" . $access_token;
        $import = MicroPlatformModel::curl($url, $dining_room_data);
        if ($import['errcode'] == 0 && $import['errmsg'] == 'ok') {
            return $import['location_id_list'];
        }
        return false;
    }

    /**
     * 批量拉取商家门店信息
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $cond['offset'] 偏移量 0开始
     * $cond['count'] 拉取数量
     * return 门店信息
     * [{'location_id':'233',
     *   'business_name':'微应用',
     *   'phone':'13123332322,
     *   'address':'河北省保定市',
     *   'longitude':131.23423423,
     *   'latitude':38.234234,
     * }]
     */
    public static function batchgetDiningRoom($appid, $appsecret, $cond) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/location/batchget?access_token=" . $access_token;
        $dining_rooms = MicroPlatformModel::curl($url, $cond);
        if ($dining_rooms['errcode'] == 0 && $dining_rooms['errmsg'] == 'ok') {
            return $dining_rooms['location_list'];
        }
        return false;
    }

    /**
     * 获取卡劵颜色列表
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * return 颜色列表数组[{'name':'Color010','value':'#fff'}]
     */
    public static function getCardColor($appid, $appsecret) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/getcolors?access_token=" . $access_token;
        $colors = MicroPlatformModel::curl($url);
        if ($colors['errcode'] == 0 && $colors['errmsg'] == 'ok') {
            return $colors['colors'];
        }
        return false;
    }

    /**
     * 创建卡劵接口
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $card_data 卡劵详细信息
     * return card_id  返回卡劵id
     */
    public static function createCard($appid, $appsecret, $card_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/create?access_token=" . $access_token;
        $card = MicroPlatformModel::curl($url, $card_data);
        if ($card['errcode'] == 0 && $card['errmsg'] == 'ok') {
            return $card['card_id'];
        }
        return false;
    }

    /**
     * 创建卡劵投放二维码
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $card_data 卡劵详细信息
     * return ticket  返回创建卡劵ticket
     */
    public static function createCardQrcode($appid, $appsecret, $card_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/qrcode/create?access_token=" . $access_token;
        $card_qrcode = MicroPlatformModel::curl($url, $card_data);
        if ($card_qrcode['errcode'] == 0 && $card_qrcode['errmsg'] == 'ok') {
            return $card_qrcode['ticket'];
        }
        return false;
    }

    /**
     * 获取api_ticket js添加调起添加微信卡劵到卡包
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $card_data 卡劵详细信息
     * return ticket  返回创建卡劵ticket
     */
    public static function getApiTicket($appid, $appsecret) {
        $wxPlatform = M('MicroPlatform');
        $platform_data['appid'] = $appid;
        $platform_data['appsecret'] = $appsecret;
        $wx_platform = $wxPlatform->where($platform_data)->find();
        if ($wx_platform['cardapi_ticket'] == false || $wx_platform['cardapi_expires'] < time()) {//已过期重新获取
            $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
            $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" . $access_token . "&type=wx_card";
            $api_ticket = MicroPlatformModel::curl($url);
            if ($api_ticket['errcode'] == 0 && $api_ticket['errmsg'] == 'ok') {
                $cardapi_ticket = $api_ticket['ticket'];
                $cardapi_expires = $api_ticket['expires_in'];
                //更新weiapp_micro_platform表的cardapi_ticket和cardapi_expires
                $platform['cardapi_ticket'] = $cardapi_ticket;
                $platform['cardapi_expires'] = time() + $cardapi_expires;
                $platform['update_time'] = time();
                $wxPlatform->where($platform_data)->save($platform);
//                return $wxPlatform->getLastSql();
            }
            return $cardapi_ticket;
        } else {
            $cardapi_ticket = $wx_platform['cardapi_ticket'];
        }
        return $cardapi_ticket;
    }

    /**
     * 消耗code 核销卡劵
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $card_data['code']核销卡劵详信息
     * $card_data['card_id'] 核销卡劵详信息
     * return ticket  返回创建卡劵ticket
     * array(
     *    'card'=>array(
     *         'card_id'=>'23423'
     *    ),
     *    'openid':'abcdefegdsdf'
     * )
     */
    public static function consumeCard($appid, $appsecret, $card_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/code/consume?access_token=" . $access_token;
        $card_consume_info = MicroPlatformModel::curl($url, $card_data);
        if ($card_consume_info['errcode'] == 0 && $card_consume_info['errmsg'] == 'ok') {
            $card_consume['card'] = $card_consume_info['card'];
            $card_consume['openid'] = $card_consume_info['openid'];
            return $card_consume;
        }
        return false;
    }

    /**
     * code解码 商家获取choose_card_info进行解码获取真实code
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $encrypt 通过choose_card_info获取的加密字符串
     * return code  返回卡劵真实code
     */
    public static function getDecryptCode($appid, $appsecret, $encrypt) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/code/decrypt?access_token=" . $access_token;
        $card_info = MicroPlatformModel::curl($url, $encrypt);
        if ($card_info['errcode'] == 0 && $card_info['errmsg'] == 'ok') {
            return $card_info['code'];
        }
        return false;
    }

    /**
     * 删除卡劵
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $car_id card_id
     * return true or false
     */
    public static function deleteCard($appid, $appsecret, $card_id) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/delete?access_token=" . $access_token;
        $card_res = MicroPlatformModel::curl($url, $card_id);
        if ($card_res['errcode'] == 0 && $card_res['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

    /**
     * 查询code 获取code信息
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $code_data['code'] 必须
     * $code_data['car_id'] card_id  自定义code必须post card_id
     * return code信息
     * array(
     *    'openid':'sfdsdfs',
     *    'card'=>array(
     *        'card_id'=>'sdfsdf',
     *        'begin_time'=>1453434334,
     *        'end_time'=>1485748584,
     *    )
     * )
     */
    public static function getCodeInfo($appid, $appsecret, $code_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/code/get?access_token=" . $access_token;
        $card_info = MicroPlatformModel::curl($url, $code_data);
        if ($card_info['errcode'] == 0 && $card_info['errmsg'] == 'ok') {
            $info_data['openid'] = $card_info['openid'];
            $info_data['card'] = $card_info['card'];
            return $info_data;
        }
        return false;
    }

    /**
     * 批量查询卡劵列表 获取卡劵信息
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $cond['offset'] 偏移量
     * $cond['count'] 数量
     * return card信息
     * array(
     *    'card_id_list'=>array(
     *        'sfsadf',
     *        'werdfs',
     *    ),
     *    'total_num'=> 1,
     * )
     */
    public static function batchGetCard($appid, $appsecret, $cond) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/code/get?access_token=" . $access_token;
        $card_info = MicroPlatformModel::curl($url, $cond);
        if ($card_info['errcode'] == 0 && $card_info['errmsg'] == 'ok') {
            $info_data['card_id_list'] = $card_info['card_id_list'];
            $info_data['total_num'] = $card_info['total_num'];
            return $info_data;
        }
        return false;
    }

    /**
     * 获取卡劵详细信息接口
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $card_id
     * return card详细信息
     */
    public static function getCardDetail($appid, $appsecret, $card_id) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/get?access_token=" . $access_token;
        $card_info = MicroPlatformModel::curl($url, $card_id);
        if ($card_info['errcode'] == 0 && $card_info['errmsg'] == 'ok') {
            return $card_info['card'];
        }
        return false;
    }

    /**
     * 更改code
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $code_data['card_id']  $code_data['code'] $code_data['new_code']
     * return true or false
     */
    public static function updateCode($appid, $appsecret, $code_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/code/update?access_token=" . $access_token;
        $card_info = MicroPlatformModel::curl($url, $code_data);
        if ($card_info['errcode'] == 0 && $card_info['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

    /**
     * 设置卡劵失效
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $code_data['card_id']  $code_data['code'] 
     * return true or false
     */
    public static function setCardUnavailable($appid, $appsecret, $code_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/code/unavailable?access_token=" . $access_token;
        $card_info = MicroPlatformModel::curl($url, $code_data);
        if ($card_info['errcode'] == 0 && $card_info['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

    /**
     * 更改卡劵信息接口
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $card_data 卡劵信息
     * return true or false
     */
    public static function updateCard($appid, $appsecret, $card_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/update?access_token=" . $access_token;
        $card_update = MicroPlatformModel::curl($url, $card_data);
        if ($card_update['errcode'] == 0 && $card_update['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

    /**
     * 卡劵库存修改接口
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $card_data 卡劵信息 $card_data['card_id'] $card_data['increase_stock_value'] $card_data['reduce_stock_value']
     * return true or false
     */
    public static function modifyCardStock($appid, $appsecret, $card_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/modifystock?access_token=" . $access_token;
        $card_stock_update = MicroPlatformModel::curl($url, $card_data);
        if ($card_stock_update['errcode'] == 0 && $card_stock_update['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

    /**
     * 特殊卡劵 激活绑定会员卡 
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $membercard_data 卡劵信息 $card_data['card_id'] $card_data['increase_stock_value'] $card_data['reduce_stock_value']
     * return true or false
     */
    public static function membercardActive($appid, $appsecret, $membercard_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/membercard/activate?access_token=" . $access_token;
        $membercard_activate = MicroPlatformModel::curl($url, $membercard_data);
        if ($membercard_activate['errcode'] == 0 && $membercard_activate['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

    /**
     * 会员卡交易
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $membercard_data 卡劵信息 $card_data['card_id'] $card_data['increase_stock_value'] $card_data['reduce_stock_value']
     * return true or false
     */
    public static function membercardUpdateuser($appid, $appsecret, $membercard_data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/membercard/updateuser?access_token=" . $access_token;
        $membercard_update = MicroPlatformModel::curl($url, $membercard_data);
        if ($membercard_update['errcode'] == 0 && $membercard_update['errmsg'] == 'ok') {
            $info_data['result_bonus'] = $membercard_update['result_bonus'];
            $info_data['result_balance'] = $membercard_update['result_balance'];
            $info_data['openid'] = $membercard_update['openid'];
            return $info_data;
        }
        return false;
    }

    /**
     * 更新红包金额
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $data 卡劵信息 $data['card_id'] $data['code'] $data['balance']
     * return true or false
     */
    public static function updateUserBalance($appid, $appsecret, $data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/luckmoney/updateuserbalance?access_token=" . $access_token;
        $balance_update = MicroPlatformModel::curl($url, $data);
        if ($balance_update['errcode'] == 0 && $balance_update['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

    /**
     * 设置测试卡劵用户白名单
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     * $data 卡劵信息 $data['card_id'] $data['code'] $data['balance']
     * return true or false
     */
    public static function testWhiteList($appid, $appsecret, $data) {
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/card/testwhitelist/set?access_token=" . $access_token;
        $white_list_res = MicroPlatformModel::curl($url, $data);
        if ($white_list_res['errcode'] == 0 && $white_list_res['errmsg'] == 'ok') {
            return true;
        }
        return false;
    }

}
