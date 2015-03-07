<?php

/**
 * 通过微信接口推送消息
 * 包含可能实现的任何消息类功能实现，逐一完善
 *
 * @author wl
 * 
 * @version 1.0
 * 
 * @date 2014-10-31
 */
class WeiXinMessage {
    private $appid;
    private $appsercert;
    private $M;
    private $api_url;
    function __construct($appid = null, $appsercert = null, $m = null) {
	$this->appid = $appid;
	$this->appsercert = $appsercert;
	if(is_null($m)){
	    $m = M('WxPlatform');
	}
	$this->M = $m;
	$url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . $this->appid . "&secret=" . $this->appsercert;
	$access_token = $this->wxAccessToken($url);
	$this->api_url = 'https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=' . $access_token;
    }

    //通过appid secret 获取access_token
    protected function wxAccessToken($url) {
        //先从wx_platform检索access_token 或 过期再从微信服务器获取access_token
        $wxPlatform = $this->M;
        $wx_platform = $wxPlatform->where(array('appid' => $this->appid))->find();
	if ($wx_platform['token_expire'] < time()) {//已过期重新获取
            $access_token_arr = self::_getAccessToken($url);
            $access_token = $access_token_arr['access_token'];
            //更新wx_platform表
            $platform['access_token'] = $access_token;
            $platform['token_expire'] = time() + $access_token_arr['expires_in'];
            $wxPlatform->where(array('appid' => $this->appid))->save($platform);
	} else {
            $access_token = $wx_platform['access_token'];
        }
        return $access_token;
    }

    /**
     * 获取微信公众平台access_token
     * @param type $url
     * @return string
     */
    private static function _getAccessToken($url) {
        $access_token_arr = self::_curl($url);
        if (!empty($access_token_arr['access_token']) && !empty($access_token_arr['expires_in'])) {
            return $access_token_arr;
        }
        return '';
    }

    /**
     * crul http请求方式获取数据
     * @param type $url
     * @param type $post_data
     * @return type
     */
    private static function _curl($url, $post_data = null) {
        $ch = curl_init();
        $timeout = 30;
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
    
    public function sendTextMessage($open_id, $message = '欢迎关注邻购平台^_^!') {
	if(is_null($open_id)){
	    return;
	}
	$data = '{
	    "touser":"' . $open_id . '",
	    "msgtype":"text",
	    "text":
	    {
		 "content":"' . $message . '"
	    }
	}';
	$ch = curl_init();
	$timeout = 30;
	curl_setopt($ch, CURLOPT_URL, $this->api_url); //设置链接
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //设置是否返回信息
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
	
	curl_setopt($ch, CURLOPT_POST, 1);
	if (is_array($data)) {
	    $data = json_encode($data, JSON_UNESCAPED_UNICODE);
	}
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
	curl_exec($ch);
	curl_close($ch);
    }
}
