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
        $get_mp_name = I('get.mp_name');
        if (!empty($get_mp_name)) {
            $map['mp_name'] = array('like', '%' . (string) I('mp_name') . '%');
        }
        $list = $this->lists('MicroPlatform', $map, 'status,id');
        $micro_platform_num = count($list);
        $this->assign('micro_platform_num', $micro_platform_num);
        $this->assign('list', $list);
        $this->meta_title = '微信公众平台列表';
        $this->display('index');
    }

    /**
     * 微餐饮公众平台详细页面(后台)
     */
    public function detail() {
        $id = I('get.id', '', 'intval');
        $micro_platform = M('MicroPlatform')->where(array('id' => $id))->find();

        $this->assign('micro_platform', $micro_platform);
        $this->meta_title = '微信公众平台详细';
        $this->display('detail');
    }

    /**
     * 微餐饮公众平台编辑页面(后台)
     */
    public function edit() {
        if (IS_POST) {
            $post_data = I('post.');
            $mp_data['start_time'] = strtotime($post_data['start_time']);
            $mp_data['end_time'] = strtotime($post_data['end_time']);
            $mp_data['update_time'] = time();
            $mpModel = M('MicroPlatform');
            $mp_save = $mpModel->where(array('id' => $post_data['id']))->save($mp_data);
            if ($mp_save) {
                $this->success('设置微应用有效期限成功', '', true);
            }
            $this->error($mpModel->getError(), '', true);
        }
        $id = I('get.id', '', 'intval');
        $micro_platform = M('MicroPlatform')->where(array('id' => $id))->find();
        $micro_platform['start_time'] = date('Y-m-d H:i:s', $micro_platform['start_time']);
        $micro_platform['end_time'] = date('Y-m-d H:i:s', $micro_platform['end_time']);

        $this->assign('micro_platform', $micro_platform);
        $this->assign('json_micro_platform', json_encode($micro_platform));
        $this->meta_title = '微信公众平台编辑页面';
        $this->display('edit');
    }

    /**
     * 微餐饮公众平台启用公众平台(后台)
     */
    public function enable() {
        $platform_id_arr = I('post.id');
        if (empty($platform_id_arr)) {
            $this->error('请选择要操作的微信公众平台!');
        }
        $platform_ids = array_unique($platform_id_arr);
        $platform_ids_str = is_array($platform_ids) ? implode(',', $platform_ids) : $platform_ids;
        $map['id'] = array('in', $platform_ids_str);
        $platformModel = M('MicroPlatform');
        $platform_data['status'] = \Admin\Model\MicroPlatformModel::$STATUS_ALLOW;
        $platform_data['update_time'] = time();
        $platform_enable = $platformModel->where($map)->save($platform_data);
        if ($platform_enable) {
            $this->success('启用微信公众平台成功!');
        }
        $this->error('启用微信公众平台失败!');
    }

    /**
     * 微餐饮公众平台禁用公众平台(后台)
     */
    public function disable() {
        $platform_id_arr = I('post.id');
        if (empty($platform_id_arr)) {
            $this->error('请选择要操作的微信公众平台!');
        }
        $platform_ids = array_unique($platform_id_arr);
        $platform_ids_str = is_array($platform_ids) ? implode(',', $platform_ids) : $platform_ids;
        $map['id'] = array('in', $platform_ids_str);
        $platformModel = M('MicroPlatform');
        $platform_data['status'] = \Admin\Model\MicroPlatformModel::$STATUS_DENY;
        $platform_data['update_time'] = time();
        $platform_disable = $platformModel->where($map)->save($platform_data);
        if ($platform_disable) {
            $this->success('禁用微信公众平台成功!');
        }
        $this->error('禁用微信公众平台失败!');
    }

    /**
     * 微餐饮公众平台设为连锁(后台)
     */
    public function chain() {
        $platform_id_arr = I('post.id');
        if (empty($platform_id_arr)) {
            $this->error('请选择要操作的微信公众平台!');
        }
        $platform_ids = array_unique($platform_id_arr);
        $platform_ids_str = is_array($platform_ids) ? implode(',', $platform_ids) : $platform_ids;
        $map['id'] = array('in', $platform_ids_str);
        $platformModel = M('MicroPlatform');
        $platform_data['is_chain'] = \Admin\Model\MicroPlatformModel::$IS_CHAIN;
        $platform_data['update_time'] = time();
        $platform_enable = $platformModel->where($map)->save($platform_data);
        if ($platform_enable) {
            $this->success('设为连锁成功!');
        }
        $this->error('设为连锁失败!');
    }

    /**
     * 微餐饮公众平台设为非连锁(后台)
     */
    public function notchain() {
        $platform_id_arr = I('post.id');
        if (empty($platform_id_arr)) {
            $this->error('请选择要操作的微信公众平台!');
        }
        $platform_ids = array_unique($platform_id_arr);
        $platform_ids_str = is_array($platform_ids) ? implode(',', $platform_ids) : $platform_ids;
        $map['id'] = array('in', $platform_ids_str);
        $platformModel = M('MicroPlatform');
        $platform_data['is_chain'] = \Admin\Model\MicroPlatformModel::$NOT_CHAIN;
        $platform_data['update_time'] = time();
        $platform_disable = $platformModel->where($map)->save($platform_data);
        if ($platform_disable) {
            $this->success('设为非连锁成功!');
        }
        $this->error('设为非连锁失败!');
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
                    $this->error('创建上传图片目录失败', '', true);
                }
            }
            if (!empty($micro_platform_data['mp_qrcode']) && !preg_match('/\/Uploads\w*/', $micro_platform_data['mp_qrcode'])) {//生成微信公众平台二维码图片
                $mp_qrcode_path = $save_path . C('MP_QRCODE_UPLOAD')['saveName'] . '.jpg';
                $mp_qrcode_tmp = base64_decode($micro_platform_data['mp_qrcode']);
                $create_mp_qrcode = file_put_contents($mp_qrcode_path, $mp_qrcode_tmp);
                if ($create_mp_qrcode == false) {
                    $this->error('生成微信公众平台二维码图片失败!', '', true);
                }
                $micro_platform_data['mp_qrcode'] = '/Uploads/Mp/' . $micro_platform_data['id'] . '/info/' . C('MP_QRCODE_UPLOAD')['saveName'] . '.jpg';
            }
            if (!empty($micro_platform_data['mp_img']) && !preg_match('/\/Uploads\w*/', $micro_platform_data['mp_img'])) {//生成微信工作平台头像图片
                $mp_img_path = $save_path . C('MP_IMG_UPLOAD')['saveName'] . '.jpg';
                $mp_img_tmp = base64_decode($micro_platform_data['mp_img']);
                $create_mp_img = file_put_contents($mp_img_path, $mp_img_tmp);
                if ($create_mp_img == false) {
//                    @unlink($mp_qrcode_path);
                    $this->error('生成微信公众平台头像图片失败!', '', true);
                }
                $micro_platform_data['mp_img'] = '/Uploads/Mp/' . $micro_platform_data['id'] . '/info/' . C('MP_IMG_UPLOAD')['saveName'] . '.jpg';
            }
            if (!empty($micro_platform_data['back_img']) && !preg_match('/\/Uploads\w*/', $micro_platform_data['back_img'])) {//生成微信背景图片
                $back_img_path = $save_path . 'back_img.jpg';
                $back_img_tmp = base64_decode($micro_platform_data['back_img']);
                $create_back_img = file_put_contents($back_img_path, $back_img_tmp);
                if ($create_back_img == false) {
//                    @unlink($mp_qrcode_path);
                    $this->error('生成微信公众平台背景图片失败!', '', true);
                }
                $micro_platform_data['back_img'] = '/Uploads/Mp/' . $micro_platform_data['id'] . '/info/' . 'back_img.jpg';
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
        $this->assign('selected_wx_pay', isset($micro_platform['support_wxpay']) ? $micro_platform['support_wxpay'] : \Admin\Model\MicroPlatformModel::$WX_PAY_DISABLE);
        $is_chain = \Admin\Model\MicroPlatformModel::getMpChain(null, false);
        foreach ($is_chain as $id => $val) {
            $is_chain_arr[] = array('id' => $id, 'is_chain' => $val);
        }
        $this->assign('is_chain_arr', json_encode($is_chain_arr));
        $this->assign('selected_is_chain', isset($micro_platform['is_chain']) ? $micro_platform['is_chain'] : \Admin\Model\MicroPlatformModel::$NOT_CHAIN);
        $this->assign('micro_platform', $micro_platform);
        $this->assign('json_micro_platform', !is_null($micro_platform) ? json_encode($micro_platform) : json_encode(array()));
        $this->meta_title = '微餐饮公众平台';
        $this->display('food');
    }

}
