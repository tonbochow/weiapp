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
 * 餐饮 微信卡劵模型
 */
class WxCardModel extends Model {

    public static $STATUS_UNDEAL = 0; //告警状态 未处理
    public static $STATUS_DEALED = 1; //告警状态 已处理

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 0, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

//获取卡劵状态
    public static function getWxCardStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_UNDEAL] = '未处理';
        $status_arr[self::$STATUS_DEALED] = '已处理';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
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
        $upload = MicroPlatformModel::curl($url, $pic_buffer);
        if ($upload['errcode'] == 0 && $upload['errmsg'] == 'ok') {
            return $upload[0]['url'];
        }
        return false;
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
        $access_token = MicroPlatformModel::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" . $access_token . "&type=wx_card";
        $api_ticket = MicroPlatformModel::curl($url);
        if ($api_ticket['errcode'] == 0 && $api_ticket['errmsg'] == 'ok') {
            return $api_ticket['ticket'];
        }
        return false;
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
