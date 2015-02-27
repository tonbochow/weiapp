<?php
// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮公众平台控制器
 */
class MicroPlatformController extends FoodBaseController {

    /**
     * 餐饮管理(后台)
     */
    public function index(){
        $this->display();
    }
    
    //微餐饮平台列表
    public function lists(){
        
        $this->display('list');
    }

    //微餐饮公众平台(前台)
    public function food(){
        if(IS_POST){
            
        }
        $microPlatformModel = M('MicroPlatform');
        $micro_platform = $microPlatformModel->where(array('member_id'=>UID,'app_type'=>  \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD))->find();
        $mp_wxpay = \Admin\Model\MicroPlatformModel::getMpWxPay(null,false);
        foreach ($mp_wxpay as $id => $val) {
            $mp_wxpay_arr[] = array('id' => $id, 'wx_pay' => $val);
        }
        $this->assign('mp_wxpay_arr',  json_encode($mp_wxpay_arr));
        $this->assign('selected_wx_pay',$micro_platform['support_wxpay']);
        $is_chain = \Admin\Model\MicroPlatformModel::getMpChain(null,false);
        foreach ($is_chain as $id => $val) {
            $is_chain_arr[] = array('id' => $id, 'is_chain' => $val);
        }
        $this->assign('is_chain_arr',  json_encode($is_chain_arr));
        $this->assign('selected_is_chain',$micro_platform['is_chain']);
        $this->assign('micro_platform',  $micro_platform);
        $this->assign('json_micro_platform',  json_encode($micro_platform));
        $this->meta_title = '微餐饮公众平台';
        $this->display('food');
    }
}
