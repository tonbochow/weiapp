<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

//use User\Api\UserApi;

/**
 * 微餐饮微信公众平台 | 餐厅控制器
 */
class DiningRoomController extends FoodBaseController {

    //餐厅列表(后台管理员)
    public function index() {
        
    }

    //餐厅列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_dining_name = I('get.dining_name');
        if (isset($get_dining_name)) {
            $map['dining_name'] = array('like', '%' . (string) I('dining_name') . '%');
        }
        $list = $this->lists('DiningRoom', $map, 'status,id');

        $this->assign('list', $list);
        $this->meta_title = '餐厅列表';
        $this->display('show');
    }

    //创建餐厅(前台面向商家) 非连锁只能创建一个 连锁可以创建多个
    public function add() {
        if (IS_CHAIN) {//若为连锁餐厅 检查是否已创建了连锁餐厅信息
            $chain_dining = M('ChainDining')->where(array('mp_id' => MP_ID))->find();
            if ($chain_dining == false) {
                if (IS_POST) {
                    $this->error('请先创建连锁餐厅信息!', '/Admin/ChainDining/info', true);
                }
                $this->error('请先创建连锁餐厅信息!', '/Admin/ChainDining/info');
            }
        }
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
//            //2 将用户添加入微餐饮店员组
//            $authGroupModel = M('AuthGroup');
//            $group = $authGroupModel->where(array('description' => 'food_member'))->find();
//            $access_data['uid'] = $dining_uid;
//            $access_data['group_id'] = $group['id'];
//            $authGroupAccessModel = M('AuthGroupAccess');
//            $group_access_add = $authGroupAccessModel->add($access_data);
//            if ($group_access_add == false) {
//                $diningRoomModel->rollback();
//                $this->error('添加用户到微餐饮店员组失败!', '', true);
//            }
//            //3 保存餐厅信息
//            unset($dining_room_data['username']);
//            unset($dining_room_data['password']);
//            unset($dining_room_data['email']);
            $dining_room_data['mp_id'] = MP_ID;
            $dining_room_data['member_id'] = UID;
//            $dining_room_data['dining_staff_id'] = $dining_uid;
            $dining_room_data['is_chain_dining'] = IS_CHAIN ? \Admin\Model\DiningRoomModel::$IS_CHAIN : \Admin\Model\DiningRoomModel::$NOT_CHAIN;
            $dining_room_data['chain_dining_id'] = IS_CHAIN ? $chain_dining['id'] : '';
            if ($diningRoomModel->create($dining_room_data)) {
                $dining_room_res = $diningRoomModel->add();
                if ($dining_room_res) {
                    $diningRoomModel->commit();
                    $this->success('保存餐厅信息成功!', '', true);
                } else {
                    $diningRoomModel->rollback();
                    $this->error($diningRoomModel->getError(), '', true);
                }
            } else {
                $diningRoomModel->rollback();
                $this->error('保存餐厅信息失败!', '', true);
            }
        }
        //省市县设置
        $region_model = D('Region');
        $province = $region_model->getRegion(86);
        $this->assign('province', $province);
        $this->assign('json_dining', json_encode(null));
        $this->meta_title = '创建餐厅';
        $this->display('add');
    }

    //获取市县
    public function getRegion() {
        $model = D('Region');
        $parent = intval($_REQUEST['pid']);
        $list = $model->getRegion($parent);
        echo json_encode($list);
    }

    //编辑餐厅(前台面向商家)
    public function edit() {
        $id = intval(I('get.id', '', 'trim'));
        $diningRoomModel = M('DiningRoom');
        $map['id'] = $id;
        $map['member_id'] = UID;
        $map['mp_id'] = MP_ID;
        $dining_room = $diningRoomModel->where($map)->find();
        if ($dining_room == false) {
            $this->error('未检索到您要编辑的餐厅信息!');
        }
        $dining_room['description'] = htmlspecialchars_decode(stripslashes($dining_room['description']));
        //省市县设置
        $region_model = D('Region');
        $province = $region_model->getRegion(86);
        $this->assign('province', $province);
        $city = $region_model->getRegion($dining_room['city']);
        $this->assign('city', $city);
        $town = $region_model->getRegion($dining_room['town']);
        $this->assign('town', $town);

        $this->assign('dining_room', $dining_room);
        $this->assign('json_dining', json_encode($dining_room));
        $this->meta_title = '编辑餐厅';
        $this->display('edit');
    }

    //编辑餐厅详细(图片设置)
    public function detail() {
        
    }

    //启用餐厅(前台面向商家)
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
        $diningroom_data['status'] = \Admin\Model\WeixinMenuModel::$STATUS_ENABLE;
        $diningroom_data['update_time'] = time();
        $diningroom_enable = $DiningRoomModel->where($map)->save($diningroom_data);
        if ($diningroom_enable) {
            $this->success('启用餐厅成功!');
        }
        $this->error('启用餐厅失败!');
    }

    //禁用餐厅(前台面向商家)
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
        $diningroom_data['status'] = \Admin\Model\WeixinMenuModel::$STATUS_DISABLE;
        $diningroom_data['update_time'] = time();
        $diningroom_disable = $DiningRoomModel->where($map)->save($diningroom_data);
        if ($diningroom_disable) {
            $this->success('禁用餐厅成功!');
        }
        $this->error('禁用餐厅失败!');
    }

}
