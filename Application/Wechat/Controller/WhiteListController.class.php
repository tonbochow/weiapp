<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-21
// +----------------------------------------------------------------------

namespace Wechat\Controller;

use Think\Controller;

/**
 * 微信测试卡劵白名单控制器
 */
class WhiteListController extends Controller {

    public function index() {
        $list = '{
                  "username":["chowtonbo","qunxing1234"]
                 }';
        $add_res = \Admin\Model\WxCardModel::testWhiteList('wx571d493fc32f0ba3', '6677a350c853729910c9481dab475570', $list);
        dump($add_res);
    }

}
