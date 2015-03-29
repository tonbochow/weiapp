<?php

// +----------------------------------------------------------------------
// | 微信端控制器基类
// | Author: tonbochow 2015-03-28
// +----------------------------------------------------------------------

namespace Wechat\Controller;

use Think\Controller;

/**
 * 微信前台公共控制器
 * 为防止多分组Controller名称冲突，公共Controller名称统一使用分组名称
 */
class BaseController extends Controller {
    /* 空操作，用于输出404页面 */

    public function _empty() {
        $this->redirect('Index/index');
    }

    protected function _initialize() {
        //1 验证是否为微信浏览器内打开
        
        //2 验证微信版本是否6.0及以上(领取卡劵必须)
        
        //3 获取get|post参数token检索是否存在 设置微信支付参数为常量 公众平台信息为对象
        
        //4 检测是否登录(获取到openid即可)
    }

}
