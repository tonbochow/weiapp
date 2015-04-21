<?php

/**
 * 微信公众平台 PHP SDK 示例文件
 */
require('Wechat.class.php');

/**
 * 微信公众平台演示类
 */
class WeiXin extends Wechat {
    /**
     * 微信用户于公众平台交互时 通过openid检索微信用户
     */

    /**
     * 用户关注时触发，回复「欢迎关注」
     */
    protected function onSubscribe() {
        $openid = $this->getRequest('fromusername');
        $memberWeixinModel = M('MemberWeixin');
        $data = $memberWeixinModel->where(array('wx_openid' => $openid))->find();
        if (empty($data)) {//关注可以拉取微信用户信息
            $weixin_userinfo = \Admin\Model\MicroPlatformModel::getWeixinUserInfoByOpenid($this->mp['appid'], $this->mp['appsecret'], $openid);
            $data['wx_openid'] = $openid;
            $data['nickname'] = $weixin_userinfo['nickname'];
            $data['sex'] = $weixin_userinfo['sex'];
            $data['province'] = $weixin_userinfo['province'];
            $data['city'] = $weixin_userinfo['city'];
            $data['country'] = $weixin_userinfo['country'];
            $data['headimgurl'] = $weixin_userinfo['headimgurl'];
            $data['subscribe_time'] = $weixin_userinfo['subscribe_time'];
            $data['is_subscribe'] = $weixin_userinfo['subscribe'];
            $data['status'] = Admin\Model\MemberWeixinModel::$STATUS_ENABLED;
            $data['create_time'] = time();
            $data['update_time'] = time();
            $member_weixin_id = M('MemberWeixin')->add($data);
        }

        $items = array(
            new NewsResponseItem('欢迎关注' . $this->mp['mp_name'] . ',发送语音搜索试试!如需咨询在线客服请输入 客服 ！', '发送语音搜索试试!如需咨询在线客服请输入 客服 ', 'http://www.52gdp.com' . $this->mp['back_img'], 'http://www.52gdp.com/wechat/index/index/t/' . $this->token),
//            new NewsResponseItem('福利第二波！首次参与完成问卷调查即可再送百元红包！', '首次参与完成问卷调查即可再送百元红包！', 'http://www.lingou.com/Public/Mobile/images/red_envelope.jpg', 'http://www.lingou.com/mobile/Member/question'),
        );
        $this->responseNews($items);
//        $this->responseText('欢迎您关注');
    }

    /**
     * 用户已关注时,扫描带参数二维码时触发，回复二维码的EventKey (测试帐号似乎不能触发)
     */
    protected function onScan() {
        $this->responseText('二维码的EventKey：' . $this->getRequest('EventKey'));
    }

    /**
     * 用户取消关注时触发
     */
    protected function onUnsubscribe() {
        $this->responseText('悄悄的我走了,正如我悄悄的来;我挥一挥衣袖,不带走一片云彩.');
    }

    /**
     * 上报地理位置时触发,回复收到的地理位置
     */
    protected function onEventLocation() {
//        $this->responseText('收到您位置推送：' . $this->getRequest('Latitude') . ',' . $this->getRequest('Longitude'));
    }

    /**
     * 收到文本消息时触发，回复收到的文本消息内容
     */
    protected function onText() {
        $key = trim($this->getRequest('content'));
        if ($key == '客服') {//转移到多客服
            $this->responseCustomerService();
        }
        $foodModel = M('Food');
        if (!empty($key)) {
            $cond .= " and (weiapp_food.food_name like '%" . $key . "%' or weiapp_food.cate_name like '%" . $key . "%' or weiapp_food.dining_name  like '%" . $key . "%') ";
        }

        $foods = $foodModel
                ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                ->where('weiapp_food.mp_id =' . $this->mp['id'] . ' and weiapp_food.status=1' . " $cond")
                ->group('weiapp_food_detail.food_id')
                ->order('rand()')
                ->field('weiapp_food.id,weiapp_food.food_name,weiapp_food.price,weiapp_food.weixin_price,weiapp_food.dining_room_id,weiapp_food_detail.url')
                ->limit(10)
                ->select();

        if (!empty($foods)) {
            $items = array();
            foreach ($foods as $val) {
                $items[] = new NewsResponseItem($val['food_name'] . ' 原价:' . $val['price'] . ' 微信价:' . $val['weixin_price'], $val['description'], 'http://www.52gdp.com' . $val['url'], 'http://www.52gdp.com/Wechat/food/view/id/' . $val['id'] . '/t/' . $this->token);
            }
            $this->responseNews($items);
        } else {
            $this->responseText('您要搜索的可能暂时没有哦！请搜索其他的试试手气!');
        }
        $this->responseText('收到您的发送文字消息：' . $this->getRequest('content'));
    }

    /**
     * 收到图片消息时触发，回复由收到的图片组成的图文消息
     *
     * @return void
     */
    protected function onImage() {
        $items = array(
            new NewsResponseItem('图片', '描述', $this->getRequest('picurl'), $this->getRequest('picurl')),
        );

        $this->responseNews($items);
    }

    /**
     * 收到地理位置消息时触发，回复收到的地理位置
     */
    protected function onLocation() {
//        $this->responseText('收到您发送的位置消息：' . $this->getRequest('location_x') . ',' . $this->getRequest('location_y'));
    }

    /**
     * 收到链接消息时触发，回复收到的链接地址
     */
    protected function onLink() {
        $this->responseText('收到您发送的链接：' . $this->getRequest('url'));
    }

    /**
     * 收到语音消息时触发，回复语音识别结果(需要开通语音识别功能)
     */
    protected function onVoice() {
        $voice_recognition = $this->getRequest('Recognition');
        if ($voice_recognition == '客服') {//转移到多客服
            $this->responseCustomerService();
        }
        $foodModel = M('Food');
        if (!empty($voice_recognition)) {
            $cond .= " and (weiapp_food.food_name like '%" . $voice_recognition . "%' or weiapp_food.cate_name like '%" . $voice_recognition . "%' or weiapp_food.dining_name  like '%" . $voice_recognition . "%') ";
        }

        $foods = $foodModel
                ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                ->where('weiapp_food.mp_id=' . $this->mp['id'] . ' and weiapp_food.status=1' . " $cond")
                ->group('weiapp_food_detail.food_id')
                ->order('rand()')
                ->field('weiapp_food.id,weiapp_food.food_name,weiapp_food.price,weiapp_food.weixin_price,weiapp_food.dining_room_id,weiapp_food_detail.url')
                ->limit(10)
                ->select();

        if (!empty($foods)) {
            $items = array();
            foreach ($foods as $val) {
                $items[] = new NewsResponseItem($val['food_name'] . ' 原价:' . $val['price'] . ' 微信价:' . $val['weixin_price'], $val['description'], 'http://www.52gdp.com' . $val['url'], 'http://www.52gdp.com/Wechat/food/view/id/' . $val['id'] . '/t/' . $this->token);
            }
            $this->responseNews($items);
        } else {
            $this->responseText('您要搜索的可能暂时没有哦！请搜索其他的试试手气!');
        }
        $this->responseText('收到您的发送文字消息：' . $this->getRequest('content'));
    }

    /**
     * 收到自定义菜单消息时触发，回复菜单的EventKey
     */
    protected function onClick() {
        $event_key = $this->getRequest('EventKey');
        $this->$event_key();
        $this->responseText('你点击了菜单：' . $this->getRequest('EventKey'));
    }

    /**
     * 收到未知类型消息时触发，回复收到的消息类型
     */
    protected function onUnknown() {
        $this->responseText('客官助手不太懂您的意思哦!点击平台按钮试试吧!');
//        $this->responseText('收到了未知类型消息：' . $this->getRequest('msgtype'));
    }

    /**
     * 接入客服会话消息
     */
    protected function customer() {
        $this->responseCustomerService();
    }

    /**
     * 随机检索几个菜品
     */
    protected function goods() {
        $foodModel = M('Food');
        $foods = $foodModel
                ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                ->where('weiapp_food.mp_id=' . $this->mp['id'] . ' and weiapp_food.status=1')
                ->group('weiapp_food_detail.food_id')
                ->order('rand()')
                ->field('weiapp_food.id,weiapp_food.food_name,weiapp_food.price,weiapp_food.weixin_price,weiapp_food.dining_room_id,weiapp_food_detail.url')
                ->limit(10)
                ->select();

        if (!empty($foods)) {
            $items = array();
            foreach ($foods as $val) {
                $items[] = new NewsResponseItem($val['food_name'] . ' 原价:' . $val['price'] . ' 微信价:' . $val['weixin_price'], $val['description'], 'http://www.52gdp.com' . $val['url'], 'http://www.52gdp.com/Wechat/food/view/id/' . $val['id'] . '/t/' . $this->token);
            }
            $this->responseNews($items);
        } else {
            $this->responseText('您要搜索的可能暂时没有哦！请搜索其他的试试手气!');
        }
        $this->responseText('收到您的发送文字消息：' . $this->getRequest('content'));
    }

    /**
     * 联系餐厅
     */
    protected function contact() {
        $map['mp_id'] = $this->mp['id'];
        $map['status'] = Admin\Model\DiningRoomModel::$STATUS_ENABLED;
        if ($this->mp['is_chain']) {//连锁餐厅
            $dining_rooms = M('DiningRoom')->where($map)->select();
            $items = array();
            foreach ($dining_rooms as $val) {
                $address_info = \Admin\Model\RegionModel::getRegionName($val['city']) . \Admin\Model\RegionModel::getRegionName($val['town']) . $val['address'];
                $dining_pic = \Admin\Model\DiningRoomDetailModel::getDiningRoomPic($val['id']);
                $items[] = new NewsResponseItem($val['dining_name'], "电话:" . $dining_room['phone'] . "\n手机:" . $dining_room['mobile'] . " \n地址:" . $address_info, 'http://www.52gdp.com' . $dining_pic, 'http://www.52gdp.com/Wechat/DiningRoom/view/id/' . $val['id'] . '/t/' . $this->token);
            }
            $this->responseNews($items);
        } else {
            $dining_room = M('DiningRoom')->where($map)->find();
            $address_info = \Admin\Model\RegionModel::getRegionName($dining_room['city']) . \Admin\Model\RegionModel::getRegionName($dining_room['town']) . $dining_room['address'];
            $dining_pic = \Admin\Model\DiningRoomDetailModel::getDiningRoomPic($dining_room['id']);
            $items[] = new NewsResponseItem($dining_room['dining_name'], "电话:" . $dining_room['phone'] . "\n手机:" . $dining_room['mobile'] . " \n地址:" . $address_info, 'http://www.52gdp.com' . $dining_pic, 'http://www.52gdp.com/Wechat/DiningRoom/view/id/' . $dining_room['id'] . '/t/' . $this->token);
            $this->responseNews($items);
//            $contact = "<<".$dining_room['dining_name'].">>\n 电话: ".$dining_room['phone']." \n 手机: ".$dining_room['mobile']." \n 地址:".$address_info;
//            $this->responseText($contact);
        }
    }

    /**
     * 关于餐厅
     */
    protected function abouts() {
        $map['mp_id'] = $this->mp['id'];
        $map['status'] = Admin\Model\DiningRoomModel::$STATUS_ENABLED;
        if ($this->mp['is_chain']) {//连锁餐厅
            $dining_rooms = M('DiningRoom')->where($map)->select();
            $items = array();
            foreach ($dining_rooms as $val) {
                $address_info = \Admin\Model\RegionModel::getRegionName($val['city']) . \Admin\Model\RegionModel::getRegionName($val['town']) . $val['address'];
                $dining_pic = \Admin\Model\DiningRoomDetailModel::getDiningRoomPic($val['id']);
                $items[] = new NewsResponseItem($val['dining_name'], htmlspecialchars_decode(stripslashes($val['description'])), 'http://www.52gdp.com' . $dining_pic, 'http://www.52gdp.com/Wechat/DiningRoom/view/id/' . $val['id'] . '/t/' . $this->token);
            }
            $this->responseNews($items);
        } else {
            $dining_room = M('DiningRoom')->where($map)->find();
            $address_info = \Admin\Model\RegionModel::getRegionName($dining_room['city']) . \Admin\Model\RegionModel::getRegionName($dining_room['town']) . $dining_room['address'];
            $dining_pic = \Admin\Model\DiningRoomDetailModel::getDiningRoomPic($dining_room['id']);
            $items[] = new NewsResponseItem($dining_room['dining_name'], htmlspecialchars_decode(stripslashes($dining_room['description'])), 'http://www.52gdp.com' . $dining_pic, 'http://www.52gdp.com/Wechat/DiningRoom/view/id/' . $dining_room['id'] . '/t/' . $this->token);
            $this->responseNews($items);
        }
    }

}
