<?php

/**
 * 微信公众平台 PHP SDK 示例文件
 */
//require('./Wechat.class.php');

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
	$fromtype = \Mobile\Model\MemberModel::FROM_WEIXIN;
	$wx_member_model = M('Member');
	$data = $wx_member_model->where(array('openid' => $openid, 'fromtype' => $fromtype))->find();
	if(empty($data)){
	    $data['nickname'] = '微信用户';
	    $data['openid'] = $openid;
	    $data['fromtype'] = $fromtype;
	    $data['regtime'] = time();
	    $data['logintime'] = time();
	    $data['loginip'] = ip2long(get_client_ip());
	    $data['status'] = 1;
	    $data['loginnum'] = 1;
	    $member_id = $wx_member_model->add($data);
	    $this->_red_envelope($openid, $member_id);
	}else{
	    $this->_red_envelope($openid, $data['id']);
	}
	
	$items = array(
	    new NewsResponseItem('欢迎关注邻购,发送语音搜索商品试试!如需咨询在线客服请输入 客服 ！' , '发送语音搜索商品试试!如需咨询在线客服请输入 客服 ', '', ''),
	    new NewsResponseItem('关注即送100元红包！首次关注邻购服务号即送百元红包，可到“邻购发现-去逛逛-个人中心-我的会员卡”查看' , '首次关注邻购服务号即送百元红包，可到“个人中心-我的会员卡查看。”', '', 'http://www.lingou.com/mobile/Member/modify'),
	    new NewsResponseItem('福利第二波！首次参与完成问卷调查即可再送百元红包！' , '首次参与完成问卷调查即可再送百元红包！', 'http://www.lingou.com/Public/Mobile/images/red_envelope.jpg', 'http://www.lingou.com/mobile/Member/question'),
	);
	$this->responseNews($items);
//        $this->responseText('欢迎您关注邻购,关注即送100元红包，您还可以参加问卷调查赢取红包!发送语音搜索商品试试!如需咨询在线客服请输入 客服 ');
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
//        $this->responseText('邻购收到您位置推送：' . $this->getRequest('Latitude') . ',' . $this->getRequest('Longitude'));
    }

    /**
     * 收到文本消息时触发，回复收到的文本消息内容
     */
    protected function onText() {
        $key = trim($this->getRequest('content'));
        if($key == '客服'){//转移到多客服
            $this->responseCustomerService();
        }
        $goodsModel = M('Goods');
        //采用sphinx 模糊搜索
        import('Common.Extends.Sphinx.coreseek');
        $cl = new \SphinxClient ();
        $cl->SetServer('localhost', 9312);
        $cl->SetArrayResult(true);
        $cl->SetLimits(0, 10); //首页检索10个
        $res = $cl->Query($key, "*");
        if (!empty($res['matches'])) {
            $member_id_arr = array_map('array_shift', $res['matches']);
            $member_ids = implode(',', $member_id_arr);
            $cond = " and goods.id in($member_ids) ";
        }
        $goods = $goodsModel
                ->join('left  join goods_photo_video ON goods.id = goods_photo_video.goodsid')
                ->where('goods.status=1 and left(goods_photo_video.exttype,5)="image"' . " $cond")
                ->group('goods_photo_video.goodsid')
                ->order('rand()')
                ->limit(10)
                ->field('goods.id,goods.goodsname,goods.sellprice,goods.content,goods_photo_video.filename')
                ->select();
        if (!empty($goods)) {
            $items = array();
            foreach ($goods as $val) {
                if (IS_LOCAL) {
                    $items[] = new NewsResponseItem($val['goodsname'] . ' 价格:' . $val['sellprice'], $val['content'], 'http://115.28.34.82/Uploads/' . $val['filename'], 'http://115.28.34.82/mobile/goods/view/id/' . $val['id']);
                } else {
                    $items[] = new NewsResponseItem($val['goodsname'] . ' 价格:' . $val['sellprice'], $val['content'], 'http://www.lingou.com/Uploads/' . $val['filename'], 'http://www.lingou.com/mobile/goods/view/id/' . $val['id']);
                }
            }
            $this->responseNews($items);
        } else {
            $this->responseText('您要搜索的商品可能暂时没有哦！请搜索其他的试试手气!');
        }
        $this->responseText('邻购收到您的发送文字消息：' . $this->getRequest('content'));
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
//        $this->responseText('邻购收到您发送的位置消息：' . $this->getRequest('location_x') . ',' . $this->getRequest('location_y'));
    }

    /**
     * 收到链接消息时触发，回复收到的链接地址
     */
    protected function onLink() {
        $this->responseText('邻购收到您发送的链接：' . $this->getRequest('url'));
    }

    /**
     * 收到语音消息时触发，回复语音识别结果(需要开通语音识别功能)
     */
    protected function onVoice() {
        $voice_recognition = $this->getRequest('Recognition');
        $goodsModel = M('Goods');
//        $cond = " and goods.goodsname like '%$voice_recognition%' ";
        //采用sphinx 模糊搜索
        import('Common.Extends.Sphinx.coreseek');
        $cl = new \SphinxClient ();
        $cl->SetServer('localhost', 9312);
        $cl->SetArrayResult(true);
        $cl->SetLimits(0, 10); //首页检索10个
        $res = $cl->Query($voice_recognition, "*");
        if (!empty($res['matches'])) {
            $member_id_arr = array_map('array_shift', $res['matches']);
            $member_ids = implode(',', $member_id_arr);
            $cond = " and goods.id in($member_ids) ";
        }
        $goods = $goodsModel
                ->join('left  join goods_photo_video ON goods.id = goods_photo_video.goodsid')
                ->where('goods.status=1 and left(goods_photo_video.exttype,5)="image"' . " $cond")
                ->group('goods_photo_video.goodsid')
                ->order('rand()')
                ->limit(10)
                ->field('goods.id,goods.goodsname,goods.sellprice,goods.content,goods_photo_video.filename')
                ->select();
        if (!empty($goods)) {
            $items = array();
            foreach ($goods as $val) {
                if (IS_LOCAL) {
                    $items[] = new NewsResponseItem($val['goodsname'] . ' 价格:' . $val['sellprice'], $val['content'], 'http://115.28.34.82/Uploads/' . $val['filename'], 'http://115.28.34.82/mobile/goods/view/id/' . $val['id']);
                } else {
                    $items[] = new NewsResponseItem($val['goodsname'] . ' 价格:' . $val['sellprice'], $val['content'], 'http://www.lingou.com/Uploads/' . $val['filename'], 'http://www.lingou.com/mobile/goods/view/id/' . $val['id']);
                }
            }
            $this->responseNews($items);
        } else {
            $this->responseText('您要搜索的商品可能暂时没有哦！请搜索其他的试试手气!');
        }
        $this->responseText('收到了语音消息,识别结果为：' . $this->getRequest('Recognition'));
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
        $this->responseText('客官邻购助手不太懂您的意思哦!点击邻购平台按钮试试吧!');
//        $this->responseText('收到了未知类型消息：' . $this->getRequest('msgtype'));
    }

    /**
     * 随机检索几个商品
     */
    protected function goods() {
        $goodsModel = M('Goods');
        $goods = $goodsModel
                ->join('left  join goods_photo_video ON goods.id = goods_photo_video.goodsid')
                ->where('goods.status=1 and left(goods_photo_video.exttype,5)="image"')
                ->group('goods_photo_video.goodsid')
                ->order('rand()')
                ->limit(5)
                ->field('goods.id,goods.goodsname,goods.sellprice,goods.content,goods_photo_video.filename')
                ->select();
        if (!empty($goods)) {
            $items = array();
            foreach ($goods as $val) {
                if (IS_LOCAL) {
                    $items[] = new NewsResponseItem($val['goodsname'] . ' 价格:' . $val['sellprice'], $val['content'], 'http://115.28.34.82/Uploads/' . $val['filename'], 'http://115.28.34.82/mobile/goods/view/id/' . $val['id']);
                } else {
                    $items[] = new NewsResponseItem($val['goodsname'] . ' 价格:' . $val['sellprice'], $val['content'], 'http://www.lingou.com/Uploads/' . $val['filename'], 'http://www.lingou.com/mobile/goods/view/id/' . $val['id']);
                }
            }
            $this->responseNews($items);
        } else {
            $this->responseText('暂时没有哦请耐心等待...');
        }
    }

    /**
     * 联系领购
     */
    protected function contact() {
        $contact = "<<邻购联系方式>>\n 全国统一客服电话:\n 400-006-5106 \n 客服邮箱: \n lgkf@lingou.com \n POS购买: \n http://xpos.taobao.com/ \n 邻购官网: \n www.lingou.com";
        $this->responseText($contact);
    }
    
    /**
     * 判断当前微信用户是否拥有关注红包，没有则生成红包，并计入会员卡余额
     * @param array $open_id 微信用户open_id
     * @param int $member_id 用户ID
     */
    private function _red_envelope($open_id, $member_id) {
	$money = 0;
	$now = time();
	$envelop_model = D('MemberRedEnvelope');
	$card_model = M('member_card');
	// 会员卡是否存在
	$member_card = $card_model->where(array('open_id' => $open_id, 'member_id' => $member_id))->find();
	if(empty($member_card)){
	    $card_data = array(
		'member_id' => $member_id,
		'open_id' => $open_id,
		'card_no' => genOrderNo(),
		'money' => 0,
		'create_time' => $now
	    );
	    $card_id = $card_model->add($card_data);
	}else{
	    $card_id = $member_card['id'];
	    $money = $member_card['money'];
	}
	
	// 关注红包是否存在
	$envelop_data = $envelop_model->where(array('open_id' => $open_id, 'envelope_type' => \Common\Model\MemberRedEnvelopeModel::$TYPE_UP, 'member_card_id' => $card_id))->find();
	if(empty($envelop_data) && intval($card_id)>0){
	    $envelop_data = array(
		'red_envelope_no' => genOrderNo(),
		'envelope_type' => \Common\Model\MemberRedEnvelopeModel::$TYPE_UP,
		'open_id' => $open_id,
		'member_card_id' => $card_id,
		'create_time' => $now,
		'bind_time' => $now,
		'money' => 100,
	    );
	    $envelop_model->add($envelop_data);
	    $card_model->where('id=' . intval($card_id))->field('money')->save(array('money' => floatval($money + $envelop_data['money'])));
	}
    }

}
