<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-07
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台 | 微信维权控制器
 */
class FoodWxFeedbackController extends FoodBaseController {

    /**
     * 维权管理(后台管理员)
     */
    public function index() {
        $list = $this->lists('FoodWxFeedback', $map, 'mp_id,msg_type');
        $this->assign('list', $list);
        $this->meta_title = '微餐饮维权管理';
        $this->display('index');
    }

    //微信公众平台维权列表(前台面向商家)
    public function show() {
        if (IS_POST) {
            $feedback_id = I('post.feedback_id');
            $food_wx_feedback = M('FoodWxFeedback')->where(array('feedback_id' => $feedback_id))->find();
            $wx_openid = $food_wx_feedback['wx_openid'];
            $micro_platform = M('MicroPlatform')->where(array('id' => $food_wx_feedback['mp_id']))->find();
            $access_token = \Admin\Model\MicroPlatformModel::getAccessToken($micro_platform['appid'], $micro_platform['appsecret']);
            import('Common.Extends.Weixin.Wechat');
            ob_clean();
            $info_url = 'https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=' . $access_token;
            $info_content = "您的维权单:$feedback_id 我们已收到,请向我们的公众平台回复 客服  两字,接入客服为您服务";
            $post_data = '{
                            "touser":"' . $wx_openid . '",
                            "msgtype":"text",
                            "text":
                            {
                                "content":"' . $info_content . '"
                            }
                        }';
            \Admin\Model\MicroPlatformModel::curl($info_url, $post_data);
            $this->success("已给微信用户发送消息等待用户接入人工客服");
        }
        /* 查询条件初始化 */
        $map['mp_id'] = MP_ID;
        $get_reason = I('get.reason'); //维权描述
        if (isset($get_reason)) {
            $map['reason'] = $get_reason;
        }
        $list = $this->lists('FoodWxFeedback', $map, 'id');

        $this->assign('list', $list);
        $this->meta_title = '微信支付维权';
        $this->display('show');
    }

}
