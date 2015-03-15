<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-14
// +----------------------------------------------------------------------

namespace Admin\Controller;

use User\Api\UserApi;

/**
 * 微餐饮微信公众平台 | 餐厅员工控制器
 */
class DiningMemberController extends FoodBaseController {

    //餐厅员工列表(后台管理员)
    public function index() {
        
    }

    //餐厅员工列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_real_name = I('get.real_name');
        if (isset($get_real_name)) {
            $map['real_name'] = array('like', '%' . (string) I('real_name') . '%');
        }
        $list = $this->lists('DiningMember', $map, 'status,member_id');
        $this->assign('list', $list);
        $this->meta_title = '餐厅员工列表';
        $this->display('show');
    }

    //创建餐厅员工(前台面向商家) 一个餐厅可以创建多个员工
    public function add() {
        //检索所有连锁餐厅
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        if (empty($dining_rooms)) {
            if (IS_POST) {
                $this->error('请先创建餐厅!', '', true);
            } else {
                $this->error('请先创建餐厅!');
            }
        }
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('selected_dining_room_id', json_encode(null));
        if (IS_POST) {
            $dining_member_data = I('post.');
            $diningMemberModel = D('DiningMember');
            $diningMemberModel->startTrans();
            //1创建后台登录用户 
            $User = new UserApi;
            $dining_uid = $User->register($dining_member_data['username'], $dining_member_data['password'], $dining_member_data['email']);
            if ($dining_uid <= 0) {
                $diningMemberModel->rollback();
                $this->error($dining_uid, '', true);
                $this->error('添加餐厅员工登录信息失败', '', true);
            }
            //2 将用户添加入微餐饮店员组
            $authGroupModel = M('AuthGroup');
            $group = $authGroupModel->where(array('description' => 'food_member'))->find();
            $access_data['uid'] = $dining_uid;
            $access_data['group_id'] = $group['id'];
            $authGroupAccessModel = M('AuthGroupAccess');
            $group_access_add = $authGroupAccessModel->add($access_data);
            if ($group_access_add == false) {
                $diningMemberModel->rollback();
                $this->error('添加用户到微餐饮店员组失败!', '', true);
            }
            //3 保存餐厅员工信息
            unset($dining_member_data['username']);
            unset($dining_member_data['password']);
            unset($dining_member_data['email']);
            unset($dining_member_data['dining_room_arr']);
            $dining_member_data['mp_id'] = MP_ID;
            $dining_member_data['member_id'] = $dining_uid;
            $dining_member_data['role_type'] = \Admin\Model\DiningMemberModel::$ROLE_STAFF;
            $dining_member_data['status'] = \Admin\Model\DiningMemberModel::$STATUS_ENABLED;
            $dining_member_data['create_time'] = time();
            if ($diningMemberModel->create($dining_member_data)) {
                $dining_member_res = $diningMemberModel->add();
                if ($dining_member_res) {
                    $diningMemberModel->commit();
                    $this->success('保存餐厅员工信息成功!', '', true);
                } else {
                    $diningMemberModel->rollback();
                    $this->error($diningMemberModel->getError(), '', true);
                }
            } else {
                $diningMemberModel->rollback();
                $this->error('保存餐厅员工信息失败!', '', true);
            }
        }

        $this->meta_title = '创建餐厅员工';
        $this->display('add');
    }

    //编辑餐厅员工(前台面向商家)
    public function edit() {
        if (IS_POST) {
            $dining_member_data = I('post.');
            unset($dining_member_data['dining_room_arr']);
            $diningMemberModel = D('DiningMember');
            if ($diningMemberModel->create($dining_member_data)) {
                $dining_member_edit = $diningMemberModel->save();
                if ($dining_member_edit) {
                    $this->success('保存餐厅员工成功', '', true);
                } else {
                    $this->error($diningMemberModel->getError(), '', true);
                }
            } else {
                $this->error('餐厅员工编辑失败!', '', true);
            }
        }
        $id = intval(I('get.id', '', 'trim'));
        $diningMemberModel = M('DiningMember');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $dining_member = $diningMemberModel->where($map)->find();
        if ($dining_member == false) {
            $this->error('未检索到您要编辑的餐厅员工信息!');
        }

        //检索所有连锁餐厅
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }
        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->assign('selected_dining_room_id', json_encode($dining_member['dining_room_id']));
        $this->assign('dining_member', $dining_member);
        $this->assign('json_dining_member', json_encode($dining_member));
        $this->meta_title = '编辑餐厅员工';
        $this->display('edit');
    }

    //启用餐厅员工(前台面向商家)
    public function enable() {
        $diningmember_id_arr = I('post.id');
        if (empty($diningmember_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $diningmember_ids = array_unique($diningmember_id_arr);
        $diningmember_ids_str = is_array($diningmember_ids) ? implode(',', $diningmember_ids) : $diningmember_ids;
        $map['member_id'] = array('in', $diningmember_ids_str);
        $map['mp_id'] = MP_ID;
        $DiningMemberModel = M('DiningMember');
        $diningmember_data['status'] = \Admin\Model\DiningMemberModel::$STATUS_ENABLED;
        $diningmember_data['update_time'] = time();
        $diningmember_enable = $DiningMemberModel->where($map)->save($diningmember_data);
        if ($diningmember_enable) {
            $this->success('启用餐厅员工成功!');
        }
        $this->error('启用餐厅员工失败!');
    }

    //禁用餐厅员工(前台面向商家)
    public function disable() {
        $diningmember_id_arr = I('post.id');
        if (empty($diningmember_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $diningmember_ids = array_unique($diningmember_id_arr);
        $diningmember_ids_str = is_array($diningmember_ids) ? implode(',', $diningmember_ids) : $diningmember_ids;
        $map['member_id'] = array('in', $diningmember_ids_str);
        $map['mp_id'] = MP_ID;
        $DiningMemberModel = M('DiningMember');
        $diningmember_data['status'] = \Admin\Model\DiningMemberModel::$STATUS_DISABLED;
        $diningmember_data['update_time'] = time();
        $diningmember_disable = $DiningMemberModel->where($map)->save($diningmember_data);
        if ($diningmember_disable) {
            $this->success('禁用餐厅用户成功!');
        }
        $this->error('禁用餐厅用户失败!');
    }

}
