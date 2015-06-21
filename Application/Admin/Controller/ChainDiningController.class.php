<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-10
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食公众平台 | 连锁门店控制器
 */
class ChainDiningController extends FoodBaseController {

    /**
     * 连锁门店管理(后台管理员)
     */
    public function index() {
        $get_chain_dining_name = I('get.chain_dining_name');
        if (!empty($get_chain_dining_name)) {
            $map['chain_dining_name'] = array('like', '%' . (string) I('chain_dining_name') . '%');
        }
        $list = $this->lists('ChainDining', $map, 'mp_id,status,id');
        $this->assign('list', $list);
        $this->meta_title = '微美食连锁门店列表';
        $this->display('index');
    }

    //连锁门店信息设置(前台面向商家)
    public function info() {
        if (!IS_CHAIN) {
            $this->error('您不是连锁门店请直接创建门店信息即可!');
        }
        if (IS_POST) {
            $chain_dining_data = I('post.');
            $chain_dining_data['mp_id'] = MP_ID;
            $chain_dining_data['member_id'] = UID;
            $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/chain_dining/';
            if (!file_exists($save_path)) {
                $mkdir_res = mkdir($save_path, 0777, true);
                if (!$mkdir_res) {
                    $this->error('创建上传图片目录失败', '', true);
                }
            }
            if (!empty($chain_dining_data['carousel_fir']) && !preg_match('/\/Uploads\w*/', $chain_dining_data['carousel_fir'])) {
                $carousel_fir_path = $save_path . 'carousel_fir.jpg';
                $carousel_fir_tmp = base64_decode($chain_dining_data['carousel_fir']);
                $create_carousel_fir = file_put_contents($carousel_fir_path, $carousel_fir_tmp);
                if ($create_carousel_fir == false) {
                    $this->error('生成连锁门店第一张轮播图片失败!', '', true);
                }
                $chain_dining_data['carousel_fir'] = '/Uploads/Mp/' . MP_ID . '/chain_dining/' . 'carousel_fir.jpg';
            }
            if (!empty($chain_dining_data['carousel_sec']) && !preg_match('/\/Uploads\w*/', $chain_dining_data['carousel_sec'])) {
                $carousel_sec_path = $save_path . 'carousel_sec.jpg';
                $carousel_sec_tmp = base64_decode($chain_dining_data['carousel_sec']);
                $create_carousel_sec = file_put_contents($carousel_sec_path, $carousel_sec_tmp);
                if ($create_carousel_sec == false) {
                    $this->error('生成连锁门店第二张轮播图片失败!', '', true);
                }
                $chain_dining_data['carousel_sec'] = '/Uploads/Mp/' . MP_ID . '/chain_dining/' . 'carousel_sec.jpg';
            }
            if (!empty($chain_dining_data['carousel_thr']) && !preg_match('/\/Uploads\w*/', $chain_dining_data['carousel_thr'])) {
                $carousel_thr_path = $save_path . 'carousel_thr.jpg';
                $carousel_thr_tmp = base64_decode($chain_dining_data['carousel_thr']);
                $create_carousel_thr = file_put_contents($carousel_thr_path, $carousel_thr_tmp);
                if ($create_carousel_thr == false) {
                    $this->error('生成连锁门店第三张轮播图片失败!', '', true);
                }
                $chain_dining_data['carousel_thr'] = '/Uploads/Mp/' . MP_ID . '/chain_dining/' . 'carousel_thr.jpg';
            }
            //更新该平台门店信息为连锁门店
            $diningRoomModel = M('DiningRoom');
            $dining_map['mp_id'] = MP_ID;
            $dining_data['is_chain_dining'] = \Admin\Model\DiningRoomModel::$IS_CHAIN;
            $dining_data['update_time'] = time();
            $chainDiningModel = D('ChainDining');
            if ($chainDiningModel->create($chain_dining_data)) {
                $map['mp_id'] = MP_ID;
                $map['member_id'] = UID;
                $chain_dining_exist = M('ChainDining')->where($map)->find();
                if ($chain_dining_exist == false) {
                    $chain_dining_res = $chainDiningModel->add();
                    $dining_data['chain_dining_id'] = $chain_dining_res;
                } else {
                    $chain_dining_res = $chainDiningModel->save();
                    $dining_data['chain_dining_id'] = $chain_dining_exist['id'];
                }
                if ($chain_dining_res) {
                    $diningRoomModel->where($dining_map)->save($dining_data);
                    $this->success('保存连锁门店信息成功!', '', true);
                } else {
                    $this->error($chainDiningModel->getError(), '', true);
                }
                $this->error('保存连锁门店信息失败!', '', true);
            } else {
                $this->error('连锁门店数据创建失败!', '', true);
            }
        }
        $chainDiningModel = M('ChainDining');
        $map['mp_id'] = MP_ID;
        $map['member_id'] = UID;
        $chain_dining = $chainDiningModel->where($map)->find();
        $chain_dining['description'] = htmlspecialchars_decode(stripslashes($chain_dining['description']));

        $this->assign('chain_dining', $chain_dining);
        $this->assign('json_chain_dining', json_encode($chain_dining));
        $this->meta_title = '连锁门店信息设置';
        $this->display('info');
    }

}
