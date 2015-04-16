<?php

/**
 * 微信公众平台 共享收获地址
 */
class WeixinAddress {

    public function __construct() {
        
    }

    /**
     * 	作用：产生随机字符串，不长于32位
     */
    public function create_noncestr($length = 16) {
        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        $str = "";
        for ($i = 0; $i < $length; $i++) {
            $str.= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
            //$str .= $chars[ mt_rand(0, strlen($chars) - 1) ];  
        }
        return $str;
    }

    /**
     * 	作用：格式化参数，签名过程需要使用
     */
    public function formatBizQueryParaMap($paraMap, $urlencode) {
        $buff = "";
        ksort($paraMap);
        foreach ($paraMap as $k => $v) {
            if ($urlencode) {
                $v = urlencode($v);
            }
            $buff .= strtolower($k) . "=" . $v . "&";
        }
        $reqPar = '';
        if (strlen($buff) > 0) {
            $reqPar = substr($buff, 0, strlen($buff) - 1);
        }
        return $reqPar;
    }

    /**
     * 	作用：生成签名 address
     */
    public function getSign_address($obj) {
        foreach ($obj as $k => $v) {
            $parameters[strtolower($k)] = $v;
        }
        //签名步骤一：按字典序排序参数
        ksort($parameters);
        $string = $this->formatBizQueryParaMap($parameters, false);
        $result = SHA1($string);
        return $result;
    }

    /*
     * 	作用：设置地址签名
     */

    public function get_address_sign($infolist) {
        $jsApiObj["accesstoken"] = $infolist['accesstoken'];
        $jsApiObj["appid"] = $infolist['appid'];
        $jsApiObj["noncestr"] = $infolist['noncestr'];
        $jsApiObj["timestamp"] = $infolist['timestamp'];
        $jsApiObj["url"] = $infolist['url'];
        $addresssign = $this->getSign_address($jsApiObj);
        return $addresssign;
    }

}

?>