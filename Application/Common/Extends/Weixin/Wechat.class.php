<?php

/**
 * 微信公众平台 PHP SDK
 */
class Wechat {

    protected $mp = ''; //微信公众平台信息
    protected $token = ''; //全局设置token
    /**
     * 调试模式，将错误通过文本消息回复显示
     *
     * @var boolean
     */
    private $debug;

    /**
     * 以数组的形式保存微信服务器每次发来的请求
     *
     * @var array
     */
    private $request;

    /**
     * 初始化，判断此次请求是否为验证请求，并以数组形式保存
     *
     * @param string $token 验证信息
     * @param boolean $debug 调试模式，默认为关闭
     */
    public function __construct($token, $debug = FALSE) {
        $decrypt_token = think_decrypt($token,'@zwz@');
        if (!$this->validateSignature($decrypt_token)) {
            exit('签名验证失败');
        }

        if ($this->isValid()) {
            // 网址接入验证
            exit($_GET['echostr']);
        }

        if (!isset($GLOBALS['HTTP_RAW_POST_DATA'])) {
            exit('缺少数据');
        }

        $this->debug = $debug;
        set_error_handler(array(&$this, 'errorHandler'));
        // 设置错误处理函数，将错误通过文本消息回复显示

        $xml = (array) simplexml_load_string($GLOBALS['HTTP_RAW_POST_DATA'], 'SimpleXMLElement', LIBXML_NOCDATA);

        $this->request = array_change_key_case($xml, CASE_LOWER);
        // 将数组键名转换为小写，提高健壮性，减少因大小写不同而出现的问题
        /*
         * 全局初始化微信公众平台信息
         */
//        $mp_wechat_name = $this->request('tousername'); //微信公众平台微信号 也是唯一
        $microPlatformModel = M('MicroPlatform');
//        $map['mp_original_id'] = $mp_wechat_name;
//        $map['mp_wxcode'] = $mp_wechat_name;
//        $map['_logic'] = 'OR';
//        $micro_platform = $microPlatformModel->where($map)->find();
//        if ($micro_platform == false) {//未检索到公众平台信息
//            return false;
//        }
//        $decrypt_token = think_decrypt($token,'@zwz@');
//        $map['mp_token'] = $token;
        $map['mp_token'] = $decrypt_token;
        $micro_platform = $microPlatformModel->where($map)->find();
        $this->token = $decrypt_token;
//        $this->token = $token;
        $this->mp = $micro_platform; //全局初始化微信公众平台信息
    }

    /**
     * 判断此次请求是否为验证请求
     *
     * @return boolean
     */
    private function isValid() {
        return isset($_GET['echostr']);
    }

    /**
     * 验证此次请求的签名信息
     *
     * @param  string $token 验证信息
     * @return boolean
     */
    private function validateSignature($token) {
        if (!(isset($_GET['signature']) && isset($_GET['timestamp']) && isset($_GET['nonce']))) {
            return FALSE;
        }

        $signature = $_GET['signature'];
        $timestamp = $_GET['timestamp'];
        $nonce = $_GET['nonce'];

        /**
         * 添加验证token是否正确
         */
        $map['mp_token'] = $token;
        $micro_platform = M('MicroPlatform')->where($map)->find();
        if($micro_platform == false){//token不正确直接返回false
            return false;
        }
        if($micro_platform['status'] == \Admin\Model\MicroPlatformModel::$STATUS_DENY){//微信公众平台禁用状态
            return false;
        }
        if($micro_platform['start_time'] > time()){//微信公众平台开始使用时间未到
            return false;
        }
        if($micro_platform['end_time'] < time()){//微信公众平台使用期限已到
            return false;
        }
//        $map['status'] = \Admin\Model\MicroPlatformModel::$STATUS_ALLOW;
//        $map['start_time'] = array("elt", time());
//        $map['end_time'] = array("egt", time());
//        $micro_platforms = M('MicroPlatform')->where($map)->select();
//        foreach ($micro_platforms as $mp) {
//            file_put_contents($_SERVER['DOCUMENT_ROOT'].'/Runtime/log.txt',$mp['mp_token'].'<BR>',FILE_APPEND);
//            $signatureArray = array($mp['mp_token'], $timestamp, $nonce);
//            sort($signatureArray, SORT_STRING);
//            $res  = (sha1(implode($signatureArray)) == $signature);
//            if($res){
//                return true;
//            }
//        }
//        return false;
        /**
         * 添加验证token是否正确
         */
        $signatureArray = array($token, $timestamp, $nonce);
        sort($signatureArray, SORT_STRING);

        $signature_res = (sha1(implode($signatureArray)) == $signature);
        if($signature_res){
            $mp_map['token'] = $token;
            $mp_data['is_bind'] = \Admin\Model\MicroPlatformModel::$IS_BIND;
            $mp_data['update_time'] = time();
            M('MicroPlatform')->where($mp_map)->save($mp_data);
            return true;
        }
        return false;
//        return sha1(implode($signatureArray)) == $signature;
    }

    /**
     * 获取本次请求中的参数，不区分大小
     *
     * @param  string $param 参数名，默认为无参
     * @return mixed
     */
    protected function getRequest($param = FALSE) {
        if ($param === FALSE) {
            return $this->request;
        }

        $param = strtolower($param);

        if (isset($this->request[$param])) {
            return $this->request[$param];
        }

        return NULL;
    }

    /**
     * 用户关注时触发，用于子类重写
     */
    protected function onSubscribe() {
        
    }

    /**
     * 卡劵审核通过,用于子类重写
     */
    protected function onCardPassCheck(){
        
    }

    /**
     * 卡劵审核未通过,用于子类重写
     */
    protected function onCardNotPassCheck(){
        
    }
    
    /**
     * 用户领取卡劵,用于子类重写
     */
    protected function onUserGetCard(){
        
    }
    
    /**
     * 用户删除卡劵,用于子类重写
     */
    protected function onUserDelCard(){
        
    }
    
    /**
     * 用户进入会员卡时,用户子类重写
     */
    protected function onUserViewCard(){
        
    }
    
    /**
     * 用户卡劵被核销时,用于子类重写
     */
    protected function onUserConsumeCard(){
        
    }

    /**
     * 用户取消关注时触发，用于子类重写
     */
    protected function onUnsubscribe() {
        
    }

    /**
     * 收到文本消息时触发，用于子类重写
     */
    protected function onText() {
        
    }

    /**
     * 收到图片消息时触发，用于子类重写
     */
    protected function onImage() {
        
    }

    /**
     * 收到视频消息是触发,用于子类重写
     */
    protected function onVideo() {
        
    }

    /**
     * 收到地理位置消息时触发，用于子类重写
     */
    protected function onLocation() {
        
    }

    /**
     * 收到链接消息时触发，用于子类重写
     */
    protected function onLink() {
        
    }

    /**
     * 收到自定义菜单消息时触发，用于子类重写
     */
    protected function onClick() {
        
    }

    /**
     * 收到自定义菜单跳转链接消息时触发，用于子类重写
     */
    protected function onView() {
        
    }

    /**
     * 收到地理位置事件消息时触发，用于子类重写
     */
    protected function onEventLocation() {
        
    }

    /**
     * 收到语音消息时触发，用于子类重写
     */
    protected function onVoice() {
        
    }

    /**
     * 扫描二维码时触发，用于子类重写
     */
    protected function onScan() {
        
    }

    /**
     * 收到未知类型消息时触发，用于子类重写
     */
    protected function onUnknown() {
        
    }

    /**
     * 回复文本消息
     *
     * @param  string  $content  消息内容
     * @param  integer $funcFlag 默认为0，设为1时星标刚才收到的消息
     * @return void
     */
    protected function responseText($content, $funcFlag = 0) {
        exit(new TextResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $content, $funcFlag));
    }

    /**
     * 回复图片消息
     * @param  string  $media_id  图片上传到微信服务器后返回的mediaId
     * @param  integer $funcFlag 默认为0，设为1时星标刚才收到的消息
     */
    protected function responseImage($media_id, $funcFlag = 0) {
        exit(new ImageResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $media_id, $funcFlag));
    }

    /**
     * 回复语音消息
     * @param  string  $media_id  语音上传到微信服务器后返回的mediaId
     * @param  integer $funcFlag 默认为0，设为1时星标刚才收到的消息
     */
    protected function responseVoice($media_id, $funcFlag = 0) {
        exit(new VoiceResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $media_id, $funcFlag));
    }

    /**
     * 回复视频消息
     * @param  string  $media_id  视频上传到微信服务器后返回的mediaId
     * @param  string  $title 视频标题
     * @param string  $desc 视频描述
     * @param  integer $funcFlag 默认为0，设为1时星标刚才收到的消息
     */
    protected function responseVideo($media_id, $title, $desc, $funcFlag = 0) {
        exit(new VideoResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $media_id, $title, $desc, $funcFlag));
    }

    /**
     * 回复音乐消息
     *
     * @param  string  $title       音乐标题
     * @param  string  $description 音乐描述
     * @param  string  $musicUrl    音乐链接
     * @param  string  $hqMusicUrl  高质量音乐链接，Wi-Fi 环境下优先使用
     * @param  integer $funcFlag    默认为0，设为1时星标刚才收到的消息
     * @return void
     */
    protected function responseMusic($title, $description, $musicUrl, $hqMusicUrl, $funcFlag = 0) {
        exit(new MusicResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $title, $description, $musicUrl, $hqMusicUrl, $funcFlag));
    }

    /**
     * 回复图文消息
     * @param  array   $items    由单条图文消息类型 NewsResponseItem() 组成的数组
     * @param  integer $funcFlag 默认为0，设为1时星标刚才收到的消息
     * @return void
     */
    protected function responseNews($items, $funcFlag = 0) {
        exit(new NewsResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $items, $funcFlag));
    }

    /**
     * 将用户消息转移到多客服
     */
    protected function responseCustomerService($funcFlag = 0) {
        exit(new CustomerServiceResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $funcFlag));
    }

    /**
     * 分析消息类型，并分发给对应的函数
     *
     * @return void
     */
    public function run() {
        switch ($this->getRequest('msgtype')) {

            case 'event':
                switch ($this->getRequest('event')) {

                    case 'subscribe':
                        $this->onSubscribe();
                        break;
                    
                    case 'card_pass_check':
                        $this->onCardPassCheck();
                        break;
                    
                    case 'card_not_pass_check':
                        $this->onCardNotPassCheck();
                        break;
                    
                    case 'user_get_card':
                        $this->onUserGetCard();
                        break;
                    
                    case 'user_del_card':
                        $this->onUserDelCard();
                        break;
                    
                    case 'user_view_card':
                        $this->onUserViewCard();
                        break;
                    
                    case 'user_consume_card':
                        $this->onUserConsumeCard();
                        break;

                    case 'unsubscribe':
                        $this->onUnsubscribe();
                        break;

                    case 'SCAN':
                        $this->onScan();
                        break;

                    case 'LOCATION':
                        $this->onEventLocation();
                        break;

                    case 'CLICK':
                        $this->onClick();
                        break;

                    case 'VIEW':
                        $this->onView();
                        break;

                    default:
                        $this->onUnknown();
                        break;
                }

                break;

            case 'text':
                $this->onText();
                break;

            case 'image':
                $this->onImage();
                break;

            case 'video':
                $this->onVideo();
                break;

            case 'location':
                $this->onLocation();
                break;

            case 'link':
                $this->onLink();
                break;

            case 'voice':
                $this->onVoice();
                break;

            default:
                $this->onUnknown();
                break;
        }
    }

    /**
     * 自定义的错误处理函数，将 PHP 错误通过文本消息回复显示
     * @param  int $level   错误代码
     * @param  string $msg  错误内容
     * @param  string $file 产生错误的文件
     * @param  int $line    产生错误的行数
     * @return void
     */
    protected function errorHandler($level, $msg, $file, $line) {
        if (!$this->debug) {
            return;
        }

        $error_type = array(
            // E_ERROR             => 'Error',
            E_WARNING => 'Warning',
            // E_PARSE             => 'Parse Error',
            E_NOTICE => 'Notice',
            // E_CORE_ERROR        => 'Core Error',
            // E_CORE_WARNING      => 'Core Warning',
            // E_COMPILE_ERROR     => 'Compile Error',
            // E_COMPILE_WARNING   => 'Compile Warning',
            E_USER_ERROR => 'User Error',
            E_USER_WARNING => 'User Warning',
            E_USER_NOTICE => 'User Notice',
            E_STRICT => 'Strict',
            E_RECOVERABLE_ERROR => 'Recoverable Error',
            E_DEPRECATED => 'Deprecated',
            E_USER_DEPRECATED => 'User Deprecated',
        );

        $template = <<<ERR
PHP 报错啦！

%s: %s
File: %s
Line: %s
ERR;

        $this->responseText(sprintf($template, $error_type[$level], $msg, $file, $line
        ));
    }

}

/**
 * 用于回复的基本消息类型
 */
abstract class WechatResponse {

    protected $toUserName;
    protected $fromUserName;
    protected $funcFlag;
    protected $template;

    public function __construct($toUserName, $fromUserName, $funcFlag) {
        $this->toUserName = $toUserName;
        $this->fromUserName = $fromUserName;
        $this->funcFlag = $funcFlag;
    }

    abstract public function __toString();
}

/**
 * 用于回复的文本消息类型
 */
class TextResponse extends WechatResponse {

    protected $content;

    public function __construct($toUserName, $fromUserName, $content, $funcFlag = 0) {
        parent::__construct($toUserName, $fromUserName, $funcFlag);

        $this->content = $content;
        $this->template = <<<XML
<xml>
  <ToUserName><![CDATA[%s]]></ToUserName>
  <FromUserName><![CDATA[%s]]></FromUserName>
  <CreateTime>%s</CreateTime>
  <MsgType><![CDATA[text]]></MsgType>
  <Content><![CDATA[%s]]></Content>
  <FuncFlag>%s</FuncFlag>
</xml>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->toUserName, $this->fromUserName, time(), $this->content, $this->funcFlag
        );
    }

}

/**
 * 用于回复图片消息类型
 */
class ImageResponse extends WechatResponse {

    protected $media_id; //图片上传到微信服务器后的得到到MediaId

    public function __construct($toUserName, $fromUserName, $media_id, $funcFlag) {
        parent::__construct($toUserName, $fromUserName, $funcFlag);
        $this->media_id = $media_id;
        $this->template = <<<XML
<xml>
  <ToUserName><![CDATA[%s]]></ToUserName>
  <FromUserName><![CDATA[%s]]></FromUserName>
  <CreateTime>%s</CreateTime>
  <MsgType><![CDATA[image]]></MsgType>
  <Image>
    <MediaId><![CDATA[%s]]></MediaId>
  </Image>
  <FuncFlag>%s</FuncFlag>
</xml>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->toUserName, $this->fromUserName, time(), $this->media_id, $this->funcFlag);
    }

}

/**
 * 用于回复语音消息类型
 */
class VoiceResponse extends WechatResponse {

    protected $media_id; //语音上传到微信服务器后的得到到MediaId

    public function __construct($toUserName, $fromUserName, $media_id, $funcFlag) {
        parent::__construct($toUserName, $fromUserName, $funcFlag);
        $this->media_id = $media_id;
        $this->template = <<<XML
<xml>
  <ToUserName><![CDATA[%s]]></ToUserName>
  <FromUserName><![CDATA[%s]]></FromUserName>
  <CreateTime>%s</CreateTime>
  <MsgType><![CDATA[voice]]></MsgType>
  <Voice>
    <MediaId><![CDATA[%s]]></MediaId>
  </Voice>
  <FuncFlag>%s</FuncFlag>
</xml>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->toUserName, $this->fromUserName, time(), $this->media_id, $this->funcFlag);
    }

}

/**
 * 用于回复视频消息类型
 */
class VideoResponse extends WechatResponse {

    protected $media_id; //视频上传到微信服务器后的得到到MediaId
    protected $title; //上传到微信服务器视频标题
    protected $desc; //上传到微信服务器视频描述

    public function __construct($toUserName, $fromUserName, $media_id, $title, $desc, $funcFlag) {
        parent::__construct($toUserName, $fromUserName, $funcFlag);
        $this->media_id = $media_id;
        $this->title = $title;
        $this->desc = $desc;
        $this->template = <<<XML
<xml>
  <ToUserName><![CDATA[%s]]></ToUserName>
  <FromUserName><![CDATA[%s]]></FromUserName>
  <CreateTime>%s</CreateTime>
  <MsgType><![CDATA[video]]></MsgType>
  <Video>
    <MediaId><![CDATA[%s]]></MediaId>
    <Title><![CDATA[%s]]></Title>
    <Description><![CDATA[%s]]></Description>
  </Video>
  <FuncFlag>%s</FuncFlag>
</xml>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->toUserName, $this->fromUserName, time(), $this->media_id, $this->title, $this->desc, $this->funcFlag);
    }

}

/**
 * 用于回复的音乐消息类型
 */
class MusicResponse extends WechatResponse {

    protected $title;
    protected $description;
    protected $musicUrl;
    protected $hqMusicUrl;

    public function __construct($toUserName, $fromUserName, $title, $description, $musicUrl, $hqMusicUrl, $funcFlag) {
        parent::__construct($toUserName, $fromUserName, $funcFlag);

        $this->title = $title;
        $this->description = $description;
        $this->musicUrl = $musicUrl;
        $this->hqMusicUrl = $hqMusicUrl;
        $this->template = <<<XML
<xml>
  <ToUserName><![CDATA[%s]]></ToUserName>
  <FromUserName><![CDATA[%s]]></FromUserName>
  <CreateTime>%s</CreateTime>
  <MsgType><![CDATA[music]]></MsgType>
  <Music>
    <Title><![CDATA[%s]]></Title>
    <Description><![CDATA[%s]]></Description>
    <MusicUrl><![CDATA[%s]]></MusicUrl>
    <HQMusicUrl><![CDATA[%s]]></HQMusicUrl>
  </Music>
  <FuncFlag>%s</FuncFlag>
</xml>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->toUserName, $this->fromUserName, time(), $this->title, $this->description, $this->musicUrl, $this->hqMusicUrl, $this->funcFlag
        );
    }

}

/**
 * 用于回复的图文消息类型
 */
class NewsResponse extends WechatResponse {

    protected $items = array();

    public function __construct($toUserName, $fromUserName, $items, $funcFlag) {
        parent::__construct($toUserName, $fromUserName, $funcFlag);

        $this->items = $items;
        $this->template = <<<XML
<xml>
  <ToUserName><![CDATA[%s]]></ToUserName>
  <FromUserName><![CDATA[%s]]></FromUserName>
  <CreateTime>%s</CreateTime>
  <MsgType><![CDATA[news]]></MsgType>
  <ArticleCount>%s</ArticleCount>
  <Articles>
    %s
  </Articles>
  <FuncFlag>%s</FuncFlag>
</xml>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->toUserName, $this->fromUserName, time(), count($this->items), implode($this->items), $this->funcFlag
        );
    }

}

/**
 * 单条图文消息类型
 */
class NewsResponseItem {

    protected $title;
    protected $description;
    protected $picUrl;
    protected $url;
    protected $template;

    public function __construct($title, $description, $picUrl, $url) {
        $this->title = $title;
        $this->description = $description;
        $this->picUrl = $picUrl;
        $this->url = $url;
        $this->template = <<<XML
<item>
  <Title><![CDATA[%s]]></Title>
  <Description><![CDATA[%s]]></Description>
  <PicUrl><![CDATA[%s]]></PicUrl>
  <Url><![CDATA[%s]]></Url>
</item>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->title, $this->description, $this->picUrl, $this->url
        );
    }

}

/**
 * 用于回复微信服务器将消息转移到多客服
 */
class CustomerServiceResponse extends WechatResponse {

    public function __construct($toUserName, $fromUserName, $funcFlag = 0) {
        parent::__construct($toUserName, $fromUserName, $funcFlag);

        $this->template = <<<XML
<xml>
  <ToUserName><![CDATA[%s]]></ToUserName>
  <FromUserName><![CDATA[%s]]></FromUserName>
  <CreateTime>%s</CreateTime>
  <MsgType><![CDATA[transfer_customer_service]]></MsgType>
  <FuncFlag>%s</FuncFlag>
</xml>
XML;
    }

    public function __toString() {
        return sprintf($this->template, $this->toUserName, $this->fromUserName, time(), $this->funcFlag
        );
    }

}
