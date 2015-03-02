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
    public function index() {
        $this->display();
    }

    //微餐饮平台列表
    public function lists() {

        $this->display('list');
    }

    //微餐饮公众平台(前台)
    public function food() {
        if (IS_POST) {
            $micro_platform_data = I('post.');
            unset($micro_platform_data['wx_pay_arr']);
            unset($micro_platform_data['is_chain_arr']);
            $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . $micro_platform_data['id'] . '/info/';
            if (!file_exists($save_path)) {
                $mkdir_res = mkdir($save_path, 0777, true);
                if (!$mkdir_res) {
                    $this->error('创建上传图片目录失败','',true);
                }
            }
            if (!empty($micro_platform_data['mp_qrcode']) && !preg_match('/\/Uploads\w*/', $micro_platform_data['mp_qrcode'])) {//生成微信公众平台二维码图片
                $mp_qrcode_path = $save_path . C('MP_QRCODE_UPLOAD')['saveName'] . '.jpg';
                $mp_qrcode_tmp = base64_decode($micro_platform_data['mp_qrcode']);
                $create_mp_qrcode = file_put_contents($mp_qrcode_path, $mp_qrcode_tmp);
                if ($create_mp_qrcode == false) {
                    $this->error('生成微信公众平台二维码图片失败!', '', true);
                }
                $micro_platform_data['mp_qrcode'] = '/Uploads/Mp/' . $micro_platform_data['id'] . '/info/'. C('MP_QRCODE_UPLOAD')['saveName'] . '.jpg';
            }
            if (!empty($micro_platform_data['mp_img']) && !preg_match('/\/Uploads\w*/', $micro_platform_data['mp_img'])) {//生成微信工作平台头像图片
                $mp_img_path = $save_path . C('MP_IMG_UPLOAD')['saveName'] . '.jpg';
                $mp_img_tmp = base64_decode($micro_platform_data['mp_img']);
                $create_mp_img = file_put_contents($mp_img_path, $mp_img_tmp);
                if ($create_mp_img == false) {
//                    @unlink($mp_qrcode_path);
                    $this->error('生成微信公众平台头像图片失败!', '', true);
                }
                $micro_platform_data['mp_img'] = '/Uploads/Mp/' . $micro_platform_data['id'] . '/info/'.C('MP_IMG_UPLOAD')['saveName'] . '.jpg';
            }
            $microPlatformModel = D('MicroPlatform');
            $micro_platform_data['update_time'] = NOW_TIME;
            if ($microPlatformModel->create($micro_platform_data)) {
                $platform_save = $microPlatformModel->save($micro_platform_data);
                if ($platform_save == false) {
                    $this->error('更新微信工作平台信息失败!', '', true);
                }
            } else {
                $this->error($microPlatformModel->getError(), '', true);
            }
            $this->success('更新成功!请登录微信公众平台进行绑定!', '', true);
        }
        $microPlatformModel = M('MicroPlatform');
        $micro_platform = $microPlatformModel->where(array('member_id' => UID, 'app_type' => \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD))->find();
        $mp_wxpay = \Admin\Model\MicroPlatformModel::getMpWxPay(null, false);
        foreach ($mp_wxpay as $id => $val) {
            $mp_wxpay_arr[] = array('id' => $id, 'wx_pay' => $val);
        }
        $this->assign('mp_wxpay_arr', json_encode($mp_wxpay_arr));
        $this->assign('selected_wx_pay', isset($micro_platform['support_wxpay'])?$micro_platform['support_wxpay']:\Admin\Model\MicroPlatformModel::$WX_PAY_DISABLE);
        $is_chain = \Admin\Model\MicroPlatformModel::getMpChain(null, false);
        foreach ($is_chain as $id => $val) {
            $is_chain_arr[] = array('id' => $id, 'is_chain' => $val);
        }
        $this->assign('is_chain_arr', json_encode($is_chain_arr));
        $this->assign('selected_is_chain', isset($micro_platform['is_chain'])?$micro_platform['is_chain']:\Admin\Model\MicroPlatformModel::$NOT_CHAIN);
        $this->assign('micro_platform', $micro_platform);
        $this->assign('json_micro_platform', !is_null($micro_platform)?json_encode($micro_platform):  json_encode(array()));
        $this->meta_title = '微餐饮公众平台';
        $this->display('food');
    }

}
