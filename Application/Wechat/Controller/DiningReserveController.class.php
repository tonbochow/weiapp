<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-09
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端用户预定控制器
 */
class DiningReserveController extends BaseController {

    //预定列表
    public function index() {
        $diningReserveModel = M('DiningReserve');
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['mp_id'] = MP_ID;
        $comment_count = $diningReserveModel->where($map)->count();
        $page_num = 10;
        import('Common.Extends.Page.BootstrapPage');
        $Page = new \BootstrapPage($comment_count, $page_num);
        $show = $Page->show();
        $reserves = $diningReserveModel->where($map)->order('create_time desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
        if (!empty($reserves)) {
            foreach ($reserves as $key => $reserve) {
                $reserves[$key]['remark'] = htmlspecialchars_decode(stripslashes($reserve['remark']));
            }
        }

        $this->assign('page', $show);
        $this->assign('reserves', $reserves);
        $this->meta_title = $this->mp['mp_name'] . " | 预定列表";
        $this->display('index');
    }

    //创建预定
    public function create() {
        if (IS_POST) {
            $reserve_data = I('post.');
            $reserve_data['mp_id'] = MP_ID;
            $reserve_data['wx_openid'] = $this->weixin_userinfo['wx_openid'];
//            $reserve_data['wx_openid'] = $this->weixin_userinfo['wx_openid'] ='wx_abcdef';
            $reserve_data['meal_time'] = strtotime($reserve_data['meal_time']);
            $reserveModel = D('Admin/DiningReserve');
            if ($reserveModel->create($reserve_data, \Admin\Model\DiningReserveModel::MODEL_INSERT)) {
                $reserve_id = $reserveModel->add();
                if ($reserve_id) {
                    $this->success('创建预定成功', '', true);
                }
            }
            $this->error($reserveModel->getError(), '', true);
        }
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        foreach ($dining_rooms as $val) {
            $dining_room_arr[] = array('id' => $val['id'], 'dining_name' => $val['dining_name']);
        }

        $this->assign('dining_room_arr', json_encode($dining_room_arr));
        $this->meta_title = $this->mp['mp_name'] . " | 创建预定";
        $this->display('create');
    }

    //取消预定
    public function cancel() {
        $id = I('post.id', '', 'trim');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $reserve = M('DiningReserve')->where($map)->find();
        if ($reserve == false) {
            $this->error('未检索到您要取消的预定', '', true);
        }
        if ($reserve['status'] != \Admin\Model\DiningReserveModel::$STATUS_COMMITED) {
            $this->error('此预定不允许取消', '', true);
        }
        $reserve_data['status'] = \Admin\Model\DiningReserveModel::$STATUS_CANCEL;
        $reserve_data['update_time'] = time();
        $reserve_save = M('DiningReserve')->where($map)->save($reserve_data);
        if ($reserve_save) {
            $this->success('已取消', '', true);
        }
        $this->error('取消预定失败', '', true);
    }

    //完成预定
    public function finish() {
        $id = I('post.id', '', 'trim');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'];
//        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $reserve = M('DiningReserve')->where($map)->find();
        if ($reserve == false) {
            $this->error('未检索到您要完成的预定', '', true);
        }
        if ($reserve['status'] != \Admin\Model\DiningReserveModel::$STATUS_CONFIRM) {
            $this->error('此预定不允许完成', '', true);
        }
        $reserve_data['status'] = \Admin\Model\DiningReserveModel::$STATUS_FINISH;
        $reserve_data['update_time'] = time();
        $reserve_save = M('DiningReserve')->where($map)->save($reserve_data);
        if ($reserve_save) {
            $this->success('已完成', '', true);
        }
        $this->error('完成预定失败', '', true);
    }

}
