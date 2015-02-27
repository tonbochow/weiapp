<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台微餐饮申请试用控制器
 */
class MemberInfoController extends AdminController {

    /**
     * 申请列表(后台)
     */
    public function apply() {
        /* 查询条件初始化 */
        $map = array();
        $get_real_name = I('get.real_name');
        if (isset($get_real_name)) {
            $map['real_name'] = array('like', '%' . (string) I('real_name') . '%');
        }
        $list = $this->lists('MemberInfo', $map, 'status,id', array('status' => array('egt', -1)));
//        // 记录当前列表页的cookie
//        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('list', $list);
        $this->meta_title = '申请试用列表';
        $this->display('apply');
    }

    /**
     * 编辑用户申请(后台)
     */
    public function edit() {
        if (IS_POST) {
            $member_info_data = I('post.');
            if (empty($member_info_data)) {
                $this->error('提交保存的数据为空');
            }
            $member_info_data['start_time'] = strtotime($member_info_data['start_time']);
            $member_info_data['end_time'] = strtotime($member_info_data['end_time']);
            $member_info_data['update_time'] = time();
            unset($member_info_data['app_type_arr']);
            unset($member_info_data['type_arr']);
            unset($member_info_data['status_arr']);
            $memberInfoModel = D('MemberInfo');
            $memberInfoModel->startTrans();
            //1更新用户使用申请
            if ($memberInfoModel->create($member_info_data)) {
                $member_info_save = $memberInfoModel->save($member_info_data);
                if ($member_info_save == false) {
                    $memberInfoModel->rollback();
                    $this->error('更新用户使用申请失败!', '', true);
                }
            } else {
                $memberInfoModel->rollback();
                $this->error('更新用户使用申请失败!', '', true);
            }
            //2判断是否需要将用户移入或移除权限组
            $authGroupAccessModel = M('AuthGroupAccess');
            $group_access = $authGroupAccessModel->where(array('uid' => $member_info_data['member_id']))->find();
            $access_data['uid'] = $member_info_data['member_id'];
            $access_data['group_id'] = 3; //暂时写死
            if ($member_info_data['status'] == \Home\Model\MemberInfoModel::$STATUS_ALLOW) {
                if ($group_access == false) {
                    $group_access_add = $authGroupAccessModel->add($access_data);
                    if ($group_access_add == false) {
                        $memberInfoModel->rollback();
                        $this->error('添加用户到应用权限组失败!', '', true);
                    }
                    $memberInfoModel->commit();
                    $this->success('保存用户使用申请成功!', '', true);
                }
            } else {
                if ($group_access != false) {
                    $group_access_del = $authGroupAccessModel->where($access_data)->delete();
                    if ($group_access_del == false) {
                        $memberInfoModel->rollback();
                        $this->error('移除用户出应用权限组失败!', '', true);
                    }
                    $memberInfoModel->commit();
                    $this->success('保存用户使用申请成功!', '', true);
                }
            }
            $memberInfoModel->commit();
            $this->success('保存用户使用申请成功!', '', true);
        }
        $id = I('get.id', '', 'trim');
        if (empty($id)) {
            $this->error('参数不能为空!');
        }
        $member_info = M('MemberInfo')->where(array('id' => $id))->find();
        $app_type = \Home\Model\MemberInfoModel::getAppType(null, false);
        foreach ($app_type as $id => $val) {
            $app_type_arr[] = array('id' => $id, 'app_type' => $val);
        }
        $status = \Home\Model\MemberInfoModel::getMemberInfoStatus(null, false);
        foreach ($status as $id => $val) {
            $status_arr[] = array('id' => $id, 'status' => $val);
        }
        $type = \Home\Model\MemberInfoModel::getMemberInfoType(null, false);
        foreach ($type as $id => $val) {
            $type_arr[$id] = array('id' => $id, 'type' => $val);
        }
        $this->assign('app_type_arr', json_encode($app_type_arr));
        $this->assign('selected_app_type', $member_info['app_type']);
        $this->assign('status_arr', json_encode($status_arr));
        $this->assign('selected_status', $member_info['status']);
        $this->assign('type_arr', json_encode($type_arr));
        $this->assign('selected_type', $member_info['type']);
        $member_info['start_time'] = date('Y-m-d H:i:s', $member_info['start_time']);
        $member_info['end_time'] = date('Y-m-d H:i:s', $member_info['end_time']);
        $this->assign('member_info', json_encode($member_info));
        $this->meta_title = '编辑用户微应用申请';
        $this->display('edit');
    }

    /**
     * 删除用户申请(后台)|禁用用户并从权限组移除
     */
    public function delete() {
        $member_id = intval(I('get.member_id', '', trim));
        $memberInfoModel = M('MemberInfo');
        $memberInfoModel->startTrans();
        //1禁用用户
        $member_info_data['status'] = \Home\Model\MemberInfoModel::$STATUS_DENY;
        $member_info_data['update_time'] = time();
        $member_info_save = $memberInfoModel->where(array('member_id' => $member_id))->save($member_info_data);
        if ($member_info_save == false) {
            $memberInfoModel->rollback();
            $this->error('删除用户(禁用)失败!');
        }
        //2去除用户权限
        $authGroupAccessModel = M('AuthGroupAccess');
        $group_access = $authGroupAccessModel->where(array('uid' => $member_id))->find();
        if($group_access != false) {
            $access_del = $authGroupAccessModel->where(array('uid' => $member_id))->delete();
            if ($access_del == false) {
                $memberInfoModel->rollback();
                $this->error('移除用户权限失败!');
            }
        }
        $memberInfoModel->commit();
        $this->success('删除成功!');
    }

    /**
     * 用户申请通过(后台)
     */
    public function allow() {
        $member_id_arr = I('post.id');
        if (empty($member_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $member_ids = array_unique($member_id_arr);
        foreach ($member_ids as $member_id) {
            $access_data[] = array('uid' => intval($member_id), 'group_id' => 3);
        }
        $member_ids_str = is_array($member_ids) ? implode(',', $member_ids) : $member_ids;
        $map['member_id'] = array('in', $member_ids_str);
        $memberInfoModel = M('MemberInfo');
        $memberInfoModel->startTrans();
        //1把用户加入到微应用组(餐饮组)
        $authGroupAccessModel = M('AuthGroupAccess');
        $access_res = $authGroupAccessModel->addAll($access_data);
        if ($access_res == false) {
            $memberInfoModel->rollback();
            $this->error('添加用户到微应用组失败');
        }
        //2更新用户状态及应用使用期限
        $member_info_data['status'] = \Home\Model\MemberInfoModel::$STATUS_ALLOW;
        $member_info_data['start_time'] = time(); //使用时期从审核通过开始计算 期限暂定半个月
        $member_info_data['end_time'] = strtotime("+15 days");
        $member_info_data['update_time'] = time();
        $member_info_res = $memberInfoModel->where($map)->save($member_info_data);
        if ($member_info_res == false) {
            $memberInfoModel->rollback();
            $this->error('审核用户通过失败');
        }
        $memberInfoModel->commit();
        $this->success('审核用户通过成功');
    }

    /**
     * 用户申请禁止(后台)
     * 1 待审核用户(直接更新member_info表状态)
     * 2 已通过用户 试用用户|式使用用户 都从auth_group_access表移除用户
     */
    public function deny() {
        $member_id_arr = I('post.id');
        if (empty($member_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $member_ids = array_unique($member_id_arr);
        $member_ids_str = is_array($member_ids) ? implode(',', $member_ids) : $member_ids;
        $map['member_id'] = array('in', $member_ids_str);
        $memberInfoModel = M('MemberInfo');
        $memberInfoModel->startTrans();
        //1更新用户状态
        $member_info_data['status'] = \Home\Model\MemberInfoModel::$STATUS_DENY;
        $member_info_data['update_time'] = time();
        $member_info_res = $memberInfoModel->where($map)->save($member_info_data);
        if ($member_info_res == false) {
            $memberInfoModel->rollback();
            $this->error('审核用户未通过失败');
        }
        //2从微应用权限组移除用户
        $authGroupAccessModel = M('AuthGroupAccess');
        $access_map['uid'] = array('in', $member_ids_str);
        $access_map['group_id'] = 3; //暂时写死
        $access_del = $authGroupAccessModel->where($access_map)->delete();
        if ($access_del == false) {
            $memberInfoModel->rollback();
            $this->error('微应用权限组移除用户失败');
        }
        $memberInfoModel->commit();
        $this->success('审核用户未通过成功');
    }
    
    /**
     * 审核通过创建微信公众平台token
     */
    public function token(){
        $member_id = intval(I('get.member_id', '', trim));
        $microPlatformModel = M('MicroPlatform');
        $platform_data['member_id'] = $member_id;
        $platform_data['app_type'] = \Admin\Model\MicroPlatformModel::$APP_TYPE_FOOD;
        $micro_platform = $microPlatformModel->where($platform_data)->find();
        if($micro_platform != false){
            $this->error('已创建过token!');
        }
        $memberInfoModel = M('MemberInfo');
        $memberInfoModel->startTrans();
        //1更新member_info表token_created
        $member_info_data['token_created'] = \Home\Model\MemberInfoModel::$TOKEN_CREATED;
        $member_info_data['update_time'] = time();
        $member_info_save = $memberInfoModel->where(array('member_id'=>$member_id))->save($member_info_data);
        if($member_info_save == false){
            $memberInfoModel->rollback();
            $this->error('更新创建token状态失败!');
        }
        //2生成微信公众平台token及mp_url等
        $token = gen_uuid();
        $platform_data['mp_url'] = $_SERVER['HTTP_HOST'].'/Mobile/Base/weixin/token/'.$token;
        $platform_data['mp_token'] = $token;//token
        $platform_data['create_time'] = time();
        $micro_platform_add = $microPlatformModel->add($platform_data);
        if($micro_platform_add == false){
            $memberInfoModel->rollback();
            $this->error('创建微信公众平台token失败!');
        }
        $memberInfoModel->commit();
        $this->success('创建token成功!');
    }
}
