<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

//use User\Api\UserApi;

/**
 * 微美食微信公众平台 | 门店控制器
 */
class DiningRoomController extends FoodBaseController {

    //门店列表(后台管理员)
    public function index() {
        $get_dining_name = I('get.dining_name');
        if (!empty($get_dining_name)) {
            $map['dining_name'] = array('like', '%' . (string) I('dining_name') . '%');
        }
        $list = $this->lists('DiningRoom', $map, 'mp_id,status,id');
        $this->assign('list', $list);
        $this->meta_title = '微美食门店列表';
        $this->display('index');
    }

    //门店列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_dining_name = I('get.dining_name');
        if (isset($get_dining_name)) {
            $map['dining_name'] = array('like', '%' . (string) I('dining_name') . '%');
        }
        $list = $this->lists('DiningRoom', $map, 'status,id');
        $dining_room_num = count($list);
        $this->assign('dining_room_num', $dining_room_num);
        $this->assign('list', $list);
        $this->meta_title = '门店列表';
        $this->display('show');
    }

    //创建门店(前台面向商家) 非连锁只能创建一个 连锁可以创建多个
    public function add() {
        $dining_room_num = M('DiningRoom')->where(array('mp_id' => MP_ID, 'member_id' => UID))->count();
        if (IS_CHAIN) {//若为连锁门店 检查是否已创建了连锁门店信息
            $chain_dining = M('ChainDining')->where(array('mp_id' => MP_ID))->find();
            if ($chain_dining == false) {
                if (IS_POST) {
                    $this->error('请先创建连锁门店信息!', '/Admin/ChainDining/info', true);
                }
                $this->error('请先创建连锁门店信息!', '/Admin/ChainDining/info');
            }
            if ($dining_room_num >= 10) {
                if (IS_POST) {
                    $this->error('连锁门店最多允许创建10个门店!', '/Admin/DiningRoom/show', true);
                }
                $this->error('连锁门店最多允许创建10个门店!', '/Admin/DiningRoom/show');
            }
        } else {
            if ($dining_room_num > 1) {
                if (IS_POST) {
                    $this->error('非连锁门店最多允许创建1个门店!', '/Admin/DiningRoom/show', true);
                }
                $this->error('非连锁门店最多允许创建1个门店!', '/Admin/DiningRoom/show');
            }
        }
        
        $dining_types = \Admin\Model\DiningRoomModel::getDiningRoomType(null,false);
        foreach ($dining_types as $key=>$val) {
            $dining_type_arr[] = array('id' => $key, 'dining_type' => $val);
        }
        $this->assign('dining_type_arr',  json_encode($dining_type_arr));
        
        $dining_pay_types = \Admin\Model\DiningRoomModel::getDiningRoomPayType(null, false, false);
        foreach ($dining_pay_types as $key=>$val) {
            $dining_pay_type_arr[] = array('id' => $key, 'dining_pay_type' => $val);
        }
        $this->assign('dining_pay_type_arr',  json_encode($dining_pay_type_arr));
        if (IS_POST) {
            $dining_room_data = I('post.');
            $diningRoomModel = D('DiningRoom');
            $diningRoomModel->startTrans();
//            //1创建后台登录用户 
//            $User = new UserApi;
//            $dining_uid = $User->register($dining_room_data['username'], $dining_room_data['password'], $dining_room_data['email']);
//            if ($dining_uid <=0) {
//                $diningRoomModel->rollback();
//                $this->error($this->showRegError($dining_uid));
//            }
//            //2 将用户添加入微美食店员组
//            $authGroupModel = M('AuthGroup');
//            $group = $authGroupModel->where(array('description' => 'food_member'))->find();
//            $access_data['uid'] = $dining_uid;
//            $access_data['group_id'] = $group['id'];
//            $authGroupAccessModel = M('AuthGroupAccess');
//            $group_access_add = $authGroupAccessModel->add($access_data);
//            if ($group_access_add == false) {
//                $diningRoomModel->rollback();
//                $this->error('添加用户到微美食店员组失败!', '', true);
//            }
//            //3 保存门店信息
//            unset($dining_room_data['username']);
//            unset($dining_room_data['password']);
//            unset($dining_room_data['email']);
            $wechat_name = $dining_room_data['wechat_name'];
            if(!empty($wechat_name)){
                $memberWeixinModel = M('MemberWeixin');
                $weixin_map['wechat_name'] = $wechat_name;
                $member_weixin = $memberWeixinModel->where($weixin_map)->find();
                if($member_weixin != false){
                    $dining_room_data['service_openid'] = $member_weixin['wx_openid'];//接收订单等推送消息的客服服务号
                }
            }
            $dining_room_data['mp_id'] = MP_ID;
            $dining_room_data['member_id'] = UID;
//            $dining_room_data['dining_staff_id'] = $dining_uid;
            $dining_room_data['is_chain_dining'] = IS_CHAIN ? \Admin\Model\DiningRoomModel::$IS_CHAIN : \Admin\Model\DiningRoomModel::$NOT_CHAIN;
            $dining_room_data['chain_dining_id'] = IS_CHAIN ? $chain_dining['id'] : '';
            //判断是否支持微信支付
            if(!SUPPORT_WXPAY){
                if($dining_room_data['pay_type'] == \Admin\Model\DiningRoomModel::$PAY_TYPE_WEIXIN  || $dining_room_data['pay_type'] == \Admin\Model\DiningRoomModel::$PAY_TYPE_WEIXIN_OFFLINE){
                    $this->error("当前平台不支持微信支付",'',true);
                }
            }
            if ($diningRoomModel->create($dining_room_data)) {
                $dining_room_res = $diningRoomModel->add();
                if ($dining_room_res) {
                    $diningRoomModel->commit();
                    $this->success('保存门店信息成功!', '', true);
                } else {
                    $diningRoomModel->rollback();
                    $this->error($diningRoomModel->getError(), '', true);
                }
            } else {
                $diningRoomModel->rollback();
                $this->error('保存门店信息失败!', '', true);
            }
        }
        //省市县设置
        $region_model = D('Region');
        $province = $region_model->getRegion(86);
        $this->assign('province', $province);
        $this->assign('json_dining', json_encode(null));
        $this->meta_title = '创建门店';
        $this->display('add');
    }

    //获取市县
    public function getRegion() {
        $model = D('Region');
        $parent = intval($_REQUEST['pid']);
        $list = $model->getRegion($parent);
        echo json_encode($list);
    }

    //编辑门店(前台面向商家)
    public function edit() {
        if (IS_POST) {
            $dining_room_data = I('post.');
            //判断是否支持微信支付
            if(!SUPPORT_WXPAY){
                if($dining_room_data['pay_type'] == \Admin\Model\DiningRoomModel::$PAY_TYPE_WEIXIN || $dining_room_data['pay_type'] == \Admin\Model\DiningRoomModel::$PAY_TYPE_WEIXIN_OFFLINE){
                    $this->error("当前平台不支持微信支付",'',true);
                }
            }
            $wechat_name = $dining_room_data['wechat_name'];
            if(!empty($wechat_name)){
                $memberWeixinModel = M('MemberWeixin');
                $weixin_map['wechat_name'] = $wechat_name;
                $member_weixin = $memberWeixinModel->where($weixin_map)->find();
                if($member_weixin != false){
                    $dining_room_data['service_openid'] = $member_weixin['wx_openid'];//接收订单等推送消息的客服服务号
                }
            }
            $diningRoomModel = D('DiningRoom');
            if ($diningRoomModel->create($dining_room_data)) {
                $dining_room_edit = $diningRoomModel->save();
                if ($dining_room_edit) {
                    $this->success('保存门店成功', '', true);
                } else {
                    $this->error($diningRoomModel->getError(), '', true);
                }
            } else {
                $this->error('门店编辑失败!', '', true);
            }
        }
        $id = intval(I('get.id', '', 'trim'));
        $diningRoomModel = M('DiningRoom');
        $map['id'] = $id;
        $map['member_id'] = UID;
        $map['mp_id'] = MP_ID;
        $dining_room = $diningRoomModel->where($map)->find();
        if ($dining_room == false) {
            $this->error('未检索到您要编辑的门店信息!');
        }
        $dining_room['description'] = htmlspecialchars_decode(stripslashes($dining_room['description']));
        
        $dining_types = \Admin\Model\DiningRoomModel::getDiningRoomType(null,false);
        foreach ($dining_types as $key=>$val) {
            $dining_type_arr[] = array('id' => strval($key), 'dining_type' => $val);
        }
        $this->assign('dining_type_arr',  json_encode($dining_type_arr));
        $dining_pay_types = \Admin\Model\DiningRoomModel::getDiningRoomPayType(null, false, false);
        foreach ($dining_pay_types as $key=>$val) {
            $dining_pay_type_arr[] = array('id' => strval($key), 'dining_pay_type' => $val);
        }
        $this->assign('dining_pay_type_arr',  json_encode($dining_pay_type_arr));
        //省市县设置
        $region_model = D('Region');
        $province = $region_model->getRegion(86);
        $this->assign('province', $province);
        $city = $region_model->getRegion($dining_room['province']);
        $this->assign('city', $city);
        $town = $region_model->getRegion($dining_room['city']);
        $this->assign('town', $town);

        $this->assign('dining_room', $dining_room);
        $this->assign('json_dining', json_encode($dining_room));
        $this->meta_title = '编辑门店';
        $this->display('edit');
    }

    //编辑门店详细(图片设置)
    public function detail() {
        if (IS_POST) {
            $detail_data = I('post.');
            $dining_room_id = I('post.id');
            $map['id'] = $dining_room_id;
            $map['mp_id'] = MP_ID;
            $map['member_id'] = UID;
            $dining_room = M('DiningRoom')->where($map)->find();
            if ($dining_room == false) {
                $this->error('未检索到您要添加图片的门店信息!', '', true);
            }
            $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/dining_room/' . $dining_room_id . '/';
            if (!file_exists($save_path)) {
                $mkdir_res = mkdir($save_path, 0777, true);
                if (!$mkdir_res) {
                    $this->error('创建上传图片目录失败', '', true);
                }
            }
            unset($detail_data['id']);
            foreach ($detail_data as $input_name => $image_data) {
                if (!empty($image_data) && !preg_match('/\/Uploads\w*/', $image_data)) {
                    $pic_url = $save_path . "$input_name.jpg";
                    $final_url = '/Uploads/Mp/' . MP_ID . '/dining_room/' . $dining_room_id . '/' . "$input_name.jpg";
                    $pic_tmp = base64_decode($image_data);
                    $create_pic = file_put_contents($pic_url, $pic_tmp);
                    if ($create_pic == false) {
                        $this->error('生成图片失败!', '', true);
                    }
                    //写入或更新门店明细表
                    $detail_map['mp_id'] = MP_ID;
                    $detail_map['member_id'] = UID;
                    $detail_map['input_name'] = $input_name;
                    $detail_map['dining_room_id'] = $dining_room_id;
                    $detail_exist = M('DiningRoomDetail')->where($detail_map)->find();
                    if ($detail_exist == false) {//写入明细表
                        $add_data['mp_id'] = MP_ID;
                        $add_data['member_id'] = UID;
                        $add_data['input_name'] = $input_name;
                        $add_data['dining_room_id'] = $dining_room_id;
                        $add_data['url'] = $final_url;
                        $detailModel = D('DiningRoomDetail');
                        if ($detailModel->create($add_data)) {
                            $add_res = $detailModel->add();
                            if (!$add_res) {
                                $this->error($detailModel->getError(), '', true);
                            }
                        } else {
                            $this->error('保存门店图片失败!');
                        }
                    } else {//更新明细表
                        $save_data['id'] = $detail_exist['id'];
                        $save_data['mp_id'] = MP_ID;
                        $save_data['member_id'] = UID;
                        $save_data['dining_room_id'] = $dining_room_id;
                        $save_data['input_name'] = $input_name;
                        $save_data['url'] = $final_url;
                        $detailModel = D('DiningRoomDetail');
                        if ($detailModel->create($save_data)) {
                            $save_res = $detailModel->save();
                            if (!$save_res) {
                                $this->error($detailModel->getError(), '', true);
                            }
                        } else {
                            $this->error('更新门店图片失败!');
                        }
                    }
                }
            }
            $this->success('保存门店图片成功!', '', true);
        }
        $id = intval(I('get.id', '', 'trim'));
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $map['member_id'] = UID;
        $dining_room = M('DiningRoom')->where($map)->find();
        if ($dining_room == false) {
            $this->error('未检索到您要添加图片的门店信息!');
        }
        //检索门店明细信息
        $detail_info['id'] = $id;
        $dining_room_details = M('DiningRoomDetail')->where(array('mp_id' => MP_ID, 'member_id' => UID, 'dining_room_id' => $id))->select();
        if ($dining_room_details != false) {
            foreach ($dining_room_details as $detail) {
                $detail_info[$detail['input_name']] = $detail['url'];
            }
        }

//        dump($detail_info);
        $this->assign('detail_info', $detail_info);
        $this->assign('json_detail', json_encode($detail_info));
        $this->assign('dining_room', $dining_room);
        $this->meta_title = '门店图片添加(详细设置)';
        $this->display('detail');
    }

    //启用门店(前台面向商家)
    public function enable() {
        $diningroom_id_arr = I('post.id');
        if (empty($diningroom_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $diningroom_ids = array_unique($diningroom_id_arr);
        $diningroom_ids_str = is_array($diningroom_ids) ? implode(',', $diningroom_ids) : $diningroom_ids;
        $map['id'] = array('in', $diningroom_ids_str);
        $map['mp_id'] = MP_ID;
        $DiningRoomModel = M('DiningRoom');
        $diningroom_data['status'] = \Admin\Model\DiningRoomModel::$STATUS_ENABLED;
        $diningroom_data['update_time'] = time();
        $diningroom_enable = $DiningRoomModel->where($map)->save($diningroom_data);
        if ($diningroom_enable) {
            $this->success('启用门店成功!');
        }
        $this->error('启用门店失败!');
    }

    //禁用门店(前台面向商家)
    public function disable() {
        $diningroom_id_arr = I('post.id');
        if (empty($diningroom_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $diningroom_ids = array_unique($diningroom_id_arr);
        $diningroom_ids_str = is_array($diningroom_ids) ? implode(',', $diningroom_ids) : $diningroom_ids;
        $map['id'] = array('in', $diningroom_ids_str);
        $map['mp_id'] = MP_ID;
        $DiningRoomModel = M('DiningRoom');
        $diningroom_data['status'] = \Admin\Model\DiningRoomModel::$STATUS_DISABLED;
        $diningroom_data['update_time'] = time();
        $diningroom_disable = $DiningRoomModel->where($map)->save($diningroom_data);
        if ($diningroom_disable) {
            $this->success('禁用门店成功!');
        }
        $this->error('禁用门店失败!');
    }

}
