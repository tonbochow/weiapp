<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-02-26
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

/**
 * 微信公众平台模型
 */
class MicroPlatformModel extends Model {

    public static $STATUS_DENY = 0; //用户状态 待审核
    public static $STATUS_ALLOW = 1; //用户状态 申请通过
    public static $MP_TYPE_SERVICE = 1; //微信工作平台类型：服务号
    public static $MP_TYPE_SUBSCRIBE = 2; //微信工作平台类型：订阅号
    public static $MP_TYPE_COMPANY = 3; //微信工作平台类型：企业号
    public static $APP_TYPE_FOOD = 1; //微应用类型1美食
    public static $APP_NAME_FOOD = 'food'; //美食
    public static $APP_NAME_PHOTO = 'photo'; //摄影
    public static $APP_TYPE_PHOTO = 2; //微应用类型2摄影
    public static $APP_TYPE_KTV = 3; //微应用ktv
    public static $APP_NAME_KTV = 'ktv'; //KTV
    public static $WX_PAY_ENABLE = 1; //支持微信支付
    public static $WX_PAY_DISABLE = 0; //不支持微信支付
    public static $IS_CHAIN = 1; //连锁
    public static $NOT_CHAIN = 0; //非连锁
    public static $NOT_BIND = 0; //未绑定微信公众平台
    public static $IS_BIND = 1; //已绑定微信公众平台

    /* 自动验证规则 */
    protected $_validate = array(
        array('member_id', 'require', '用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mp_name', 'require', '微信公众平台名称不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mp_original_id', 'require', '微信公众平台原始ID不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mp_original_id', '/^[a-zA-Z_]\w{1,256}$/', '微信公众平台原始ID以字母或下划线开头', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mp_original_id', '', '微信公众平台原始ID已经存在！', 0, 'unique'),
        array('mp_wxcode', 'require', '微信公众平台微信号不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('mp_wxcode', '/^[a-zA-Z_]\w{1,128}$/', '微信号以字母或下划线开头', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('appid', 'require', '微信公众平台appid不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('appid', '/^\w{1,256}$/', 'appid以字母数字或下划线开头最大长度256', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('appid', '', 'appid已经存在！', 0, 'unique'),
        array('appsecret', 'require', '微信公众平台appsecret不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('appsecret', '/^\w{1,256}$/', 'appsecret以字母数字或下划线开头最大长度256', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('appsecret', '', 'appsecret已经存在！', 0, 'unique'),
        array('partnerid', '/^\w{1,256}$/', 'partnerid以字母数字或下划线开头最大长度256', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('partnerid', '', 'partnerid已经存在！', 0, 'unique'),
        array('partnerkey', '/^\w{1,256}$/', 'partnerkey以字母数字或下划线开头最大长度256', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('partnerkey', '', 'partnerkey已经存在！', 0, 'unique'),
        array('paysignkey', '/^\w{1,256}$/', 'paysignkey以字母数字或下划线开头最大长度256', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('paysignkey', '', 'paysignkey已经存在！', 0, 'unique'),
        array('chain_num', '/^[\d]+$/', '连锁门店数量只能填正整数', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        //array('link_id', 'url', '外链格式不正确', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('description', '1,140', '简介长度不能超过140个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
//        array('category_id', 'require', '分类不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_INSERT),
//        array('category_id', 'require', '分类不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_UPDATE),
//        array('category_id', 'checkCategory', '该分类不允许发布内容', self::EXISTS_VALIDATE, 'callback', self::MODEL_UPDATE),
//        array('model_id,category_id', 'checkModel', '该分类没有绑定当前模型', self::MUST_VALIDATE, 'callback', self::MODEL_INSERT),
//        array('start_time', '/^\d{4,4}-\d{1,2}-\d{1,2}(\s\d{1,2}:\d{1,2}(:\d{1,2})?)?$/', '日期格式不合法,请使用"年-月-日 时:分"格式,全部为数字', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
//        array('end_time', '/^\d{4,4}-\d{1,2}-\d{1,2}(\s\d{1,2}:\d{1,2}(:\d{1,2})?)?$/', '日期格式不合法,请使用"年-月-日 时:分"格式,全部为数字', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('member_id', 'is_login', self::MODEL_INSERT, 'function'),
        array('mp_name', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        array('status', 1, self::MODEL_INSERT),
        array('start_time', 'strtotime', self::MODEL_BOTH, 'function'),
        array('end_time', 'strtotime', self::MODEL_BOTH, 'function'),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取微信公众平台名称
    public static function getMpName($mp_id) {
        $micro_platform = M('MicroPlatform')->where(array('id' => $mp_id))->find();
        return $micro_platform['mp_name'];
    }

    //获取微信公众平台状态
    public static function getMpStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_DENY] = '禁用';
        $status_arr[self::$STATUS_ALLOW] = '启用';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取微信公众平台类型
    public static function getMpType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$MP_TYPE_SERVICE] = '服务号';
        $type_arr[self::$MP_TYPE_SUBSCRIBE] = '订阅号';
        $type_arr[self::$MP_TYPE_COMPANY] = '企业号';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取微信公众平台微应用类型
    public static function getMpAppType($appType = null, $has_choice = true) {
        if ($has_choice) {
            $app_type_arr = array('' => '请选择');
        }
        $app_type_arr[self::$APP_TYPE_FOOD] = '美食';
        $app_type_arr[self::$APP_TYPE_PHOTO] = '摄影';
        if ($appType !== null) {
            return $app_type_arr[$appType];
        }
        return $app_type_arr;
    }

    //获取微信公众平台是否支持微信支付
    public static function getMpWxPay($pay = null, $has_choice = true) {
        if ($has_choice) {
            $wx_pay_arr = array('' => '请选择');
        }
        $wx_pay_arr[self::$WX_PAY_DISABLE] = '不支持';
        $wx_pay_arr[self::$WX_PAY_ENABLE] = '支持';
        if ($pay !== null) {
            return $wx_pay_arr[$pay];
        }
        return $wx_pay_arr;
    }

    //获取微信公众平台是否连锁
    public static function getMpChain($chain = null, $has_choice = true) {
        if ($has_choice) {
            $chain_arr = array('' => '请选择');
        }
        $chain_arr[self::$IS_CHAIN] = '连锁';
        $chain_arr[self::$NOT_CHAIN] = '非连锁';
        if ($chain !== null) {
            return $chain_arr[$chain];
        }
        return $chain_arr;
    }

    //获取微信公众平台是否绑定
    public static function getMpBind($bind = null, $has_choice = true) {
        if ($has_choice) {
            $bind_arr = array('' => '请选择');
        }
        $bind_arr[self::$IS_BIND] = '已绑定';
        $bind_arr[self::$NOT_BIND] = '未绑定';
        if ($bind !== null) {
            return $bind_arr[$bind];
        }
        return $bind_arr;
    }

    //获取微信公众平台应用名称
    public static function getMpAppName($app_type) {
        $name_arr[self::$APP_TYPE_FOOD] = self::$APP_NAME_FOOD;
        $name_arr[self::$APP_TYPE_PHOTO] = self::$APP_NAME_PHOTO;
        $name_arr[self::$APP_TYPE_KTV] = self::$APP_NAME_KTV;
        return $name_arr[$app_type];
    }

    //获取微信公众平台信息通过mp_token(永远唯一)
    public static function getMpByToken($mp_token) {
        $mp = M('MicroPlatform')->where(array('mp_token' => $mp_token))->find();
        return $mp;
    }

    /*     * ***************************************************************************************
     * 以下为与微信公众平台有关方法 
     * ********************************************************************************************
     */

    /**
     * crul http请求方式获取数据
     * @param type $url
     * @param type $post_data
     * @return type
     */
    public static function curl($url, $post_data = null) {
        $ch = curl_init();
        $timeout = 30;
        curl_setopt($ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);
        curl_setopt($ch, CURLOPT_URL, $url); //设置链接
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //设置是否返回信息
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
        if ($post_data) {
            curl_setopt($ch, CURLOPT_POST, 1);
            if (is_array($post_data)) {
                $post_data = json_encode($post_data, JSON_UNESCAPED_UNICODE);
            }
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        }
        $contents = curl_exec($ch);
        curl_close($ch);
        return json_decode($contents, true);
    }
    
    /**
     * 
     * @param type $url
     * @param type $post_data
     * @return 多媒体图片上传
     */
    public static function media_curl($url, $post_data = null) {
        $ch = curl_init();
        $timeout = 30;
        curl_setopt($ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);
        curl_setopt($ch, CURLOPT_URL, $url); //设置链接
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //设置是否返回信息
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
        if ($post_data) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        }
        $contents = curl_exec($ch);
        curl_close($ch);
        return json_decode($contents, true);
    }

    /**
     * 获取微信公众平台access_token 公众号的全局唯一票据
     * $appid 微信公众平台appid weiapp_micro_platform中唯一
     * $appsecret 微信公众平台appsecret weiapp_micro_platform中唯一
     */
    public static function getAccessToken($appid, $appsecret) {
        $access_token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$appid&secret=$appsecret";
        //先从weiapp_micro_platform检索access_token 或 过期再从微信服务器获取access_token
        $wxPlatform = M('MicroPlatform');
        $platform_data['appid'] = $appid;
        $platform_data['appsecret'] = $appsecret;
        $wx_platform = $wxPlatform->where($platform_data)->find();
        if ($wx_platform['access_token'] == false || $wx_platform['token_expire'] < time()) {//已过期重新获取
            $access_token_arr = self::curl($access_token_url);
            $access_token = $access_token_arr['access_token'];
            //更新weiapp_micro_platform表的access_token和token_expire
            $platform['access_token'] = $access_token;
            $platform['token_expire'] = time() + $access_token_arr['expires_in'];
            $platform['update_time'] = time();
            $wxPlatform->where($platform_data)->save($platform);
        } else {
            $access_token = $wx_platform['access_token'];
        }
        return $access_token;
    }

    /**
     * 获取微信服务器ip地址列表
     * $appid 微信公众平台appid 
     * $appsecret 微信公众平台appsecret
     */
    public static function getWeixinSeverIp($appid, $appsecret) {
        $access_token = self::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/cgi-bin/getcallbackip?access_token=$access_token";
        $wx_ips = self::curl($url);
        return $wx_ips['ip_list'];
    }

    /**
     * 生成微信公众平台菜单
     * $appid 微信公众平台appid
     * $appsecret 微信公众平台appsecret
     */
    public static function createWeixinMenu($appid, $appsecret, $menu) {
        $access_token = self::getAccessToken($appid, $appsecret);
        $menu_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=$access_token";
        $create_menu_res = self::curl($menu_url, $menu);
        if ($create_menu_res['errcode'] == 0 && $create_menu_res['errmsg'] == 'ok') {
            return true;
        }
        return $create_menu_res['errcode'] . $create_menu_res['errmsg'];
        return false;
    }

    /**
     * 主动发送微信客服消息
     * $appid 微信公众平台appid
     * $appsecret 微信公众平台appsecret
     * $wx_openid 微信用户openid
     * $info_content 发送消息内容
     */
    public static function sendCustomerMessage($appid, $appsecret, $wx_openid, $info_content) {
//        import('Common.Extends.Weixin.Wechat');
//        ob_clean();
        $access_token = self::getAccessToken($appid, $appsecret);
        $info_url = 'https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=' . $access_token;
        $post_data = '{
                            "touser":"' . $wx_openid . '",
                            "msgtype":"text",
                            "text":
                            {
                                "content":"' . $info_content . '"
                            }
                        }';
        self::curl($info_url, $post_data);
    }

    /**
     * 主动发送微信客服消息(图文)
     * $appid 微信公众平台appid
     * $appsecret 微信公众平台appsecret
     * $wx_openid 微信用户openid
     * $info_data 发送消息内容数组:title   description  url  image_url
     */
    public static function sendCustomerArticleMessage($appid, $appsecret, $wx_openid, $info_data) {
        import('Common.Extends.Weixin.Wechat');
        ob_clean();
        $access_token = self::getAccessToken($appid, $appsecret);
        $info_url = 'https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=' . $access_token;
        $post_data = '{
                            "touser":"' . $wx_openid . '",
                            "msgtype":"news",
                            "news": {
                                "articles": [
                                    {
                                        "title": "' . $info_data['title'] . '", 
                                        "description": "' . $info_data['description'] . '", 
                                        "url": "' . $info_data['url'] . '", 
                                        "picurl": "' . $info_data['image_url'] . '"
                                    }
                                ]
                            }
                        }';
        self::curl($info_url, $post_data);
    }

    /**
     * 通过code获取网页授权所需的access_token(与公众平台access_token不同)
     * $appid 微信公众平台appid
     * $appsecret 微信公众平台appsecret
     * $code
     */
    public static function getSnsAccessTokenByCode($appid, $appsecret, $code) {
        $code_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" . $appid . "&secret=" . $appsecret . "&code=$code&grant_type=authorization_code";
        $sns_access_token_info = self::curl($code_url);
        return $sns_access_token_info;
    }

    /**
     * 获取oauth2.0 access_token  和公众平台access_token不同
     */
    public static function getOauthAccessToken($appid, $appsecret) {
        $get_code = I('get.code');
        $get_state = I('get.state');
        $current_url = get_current_url();
        if (empty($get_code) && empty($get_state)) {//state =1 为snsapi_base模式
            $get_code_url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' . $appid . '&redirect_uri=' . $current_url . '&response_type=code&scope=snsapi_base&state=1#wechat_redirect';
            header("Location:$get_code_url");
        } else if (!empty($get_code) && ($get_state == 1)) {//微信服务器返回code和state  获取access_token凭证
            $base_access_token_info = self::getSnsAccessTokenByCode($appid, $appsecret, $get_code); //同时获取到微信用户openid
            $oauth_access_token = $base_access_token_info['access_token'];
            return $oauth_access_token;
//            $oauth_access_token_arr['access_token'] = $base_access_token_info['access_token'];
//            $oauth_access_token_arr['code'] = $get_code;
//            $oauth_access_token_arr['state'] = $get_state;
//            return $oauth_access_token_arr;
        }
    }

    /**
     * 通过openid 获取微信用户详细信息(snsapi_useinfo模式)
     * $oauth_access_token oauth的access_token
     * $openid
     */
    public static function getSnsUserinfoByOpenid($oauth_access_token, $openid) {
        $user_info_url = "https://api.weixin.qq.com/sns/userinfo?access_token=$oauth_access_token&openid=$openid&lang=zh_CN";
        $user_info = self::curl($user_info_url);
        return $user_info;
    }

    /**
     * 用户关注微信公众平台后通过微信openid获取用户信息
     * $appid $appsecret 微信公众平台基本参数
     * $openid 微信用openid
     */
    public static function getWeixinUserInfoByOpenid($appid, $appsecret, $openid) {
        $access_token = self::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=$access_token&openid=$openid&lang=zh_CN";
        $user_info = self::curl($url);
        return $user_info;
    }

    /**
     * 获取行业模版template_id
     * $appid $appsecret
     */
    public static function getTemplateId($appid, $appsecret) {
        $access_token = self::getAccessToken($appid, $appsecret);
        $url = "https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token=$access_token";
        $template_info = self::curl($url);
        return $template_info;
    }

    /**
     * 微信用户支付成功发送模版消息
     * $appid $appsecret $opeind $order_info
     */
    public static function sendTemplateMessage($appid, $appsecret, $openid, $order_info) {
        $access_token = self::getAccessToken($appid, $appsecret);
        $template_id = self::getTemplateId($appid, $appsecret);
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=$access_token";
        $post_data = '{
                            "touser":"' . $openid . '",
                            "template_id":"' . $template_id . '",
                            "url":"' . $order_info['url'] . '",
                            "topcolor":"#FF0000",
                            "data": {
                                "first": {
                                        "value":"恭喜你支付成功！",
                                        "color":"#173177"
                                },
                                "keynote1": {
                                        "value":"' . $order_info['food_name'] . '",
                                        "color":"#173177"
                                },
                                "keynote2": {
                                        "value":"' . $order_info['amount'] . '",
                                        "color":"#173177"
                                },
                                "keynote3": {
                                        "value":"' . $order_info['pay_time'] . '",
                                        "color":"#173177"
                                },
                                "remark": {
                                        "value":"感谢您的支持!本店会继续推出更多优惠,请多关注我们!",
                                        "color":"#173177"
                                }
                            }
                        }';
        self::curl($url, $post_data);
    }

    /**
     * JS-SDK获取jsapi_ticket
     * $appid
     * $appsecret
     */
    public static function getJsApiTicket($appid, $appsecret) {
        $access_token = self::getAccessToken($appid, $appsecret);
        $jsapi_ticket_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token=$access_token";
        //先从micro_platform检索access_token 或 过期再从微信服务器获取access_token
        $platform = M('MicroPlatform');
        $plat_form = $platform->where("appid='" . $appid . "'")->find();
        if ($plat_form['jsapi_ticket'] == false || $plat_form['jsapi_expires'] < time()) {//已过期重新获取
            $jsapi_ticket_info = self::curl($jsapi_ticket_url);
            $jsapi_ticket = $jsapi_ticket_info['ticket'];
            //更新micro_platform表
            $platform_data['jsapi_ticket'] = $jsapi_ticket;
            $platform_data['jsapi_expires'] = time() + $jsapi_ticket_info['expires_in'];
            $platform_data['update_time'] = time();
            $platform->where(array('appid' => $appid))->save($platform_data);
        } else {
            $jsapi_ticket = $plat_form['jsapi_ticket'];
        }
        return $jsapi_ticket;
    }

    /**
     * JS-SDK获取生成签名的随机串
     */
    public static function createNonceStr($length = 16) {
        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        $str = "";
        for ($i = 0; $i < $length; $i++) {
            $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
        }
        return $str;
    }

    /**
     * JS-SDK所需参数
     * @param string 
     * $appid
     */
    public static function getJsApiPrams($appid, $appsecret) {
        $jsapi_ticked = self::getJsApiTicket($appid, $appsecret);
        $noncestr = self::createNonceStr();
        $time = strval(time());
        $url = get_current_url();
        $str = "jsapi_ticket=$jsapi_ticked&noncestr=$noncestr&timestamp=$time&url=$url";
        $signature = SHA1($str);
        return array(
            'appId' => $appid,
            'timestamp' => $time,
            'nonceStr' => $noncestr,
            'signature' => $signature,
        );
    }

}
