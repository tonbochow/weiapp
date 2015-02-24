<?php

// +----------------------------------------------------------------------
// |2015-02-14
// +----------------------------------------------------------------------
// | Author: tonbochow
// +----------------------------------------------------------------------

namespace Home\Controller;

/**
 * 试用模型
 */
class TryController extends HomeController {

    //微应用申请测试页面
    public function index() {
        if (!is_login()) {//试用需登录
            redirect('/Home/User/login');
        }
        if (IS_POST) {
            $data = I('post.');
            $data['member_id'] = session('user_auth.uid');
            $data['app_type'] = \Home\Model\MemberInfoModel::$APP_TYPE_FOOD;
            $data['type'] = \Home\Model\MemberInfoModel::$TYPE_TRY;
            $memberInfoModel = D('MemberInfo');
            if ($memberInfoModel->create($data)) {
                $member_info_id = $memberInfoModel->add();
                if ($member_info_id) {
                    $result = array(
                        'status' => true,
                        'info' => '申请提交成功请等待',
                    );
                } else {
                    $result = array(
                        'status' => false,
                        'info' => '申请提交失败请重试',
                    );
                }
            } else {
                $result = array(
                    'status' => false,
                    'info' => $memberInfoModel->getError(),
                );
            }
            $this->ajaxReturn($result);
        }
        //是否已申请试用
        $memberInfo = M('MemberInfo')->where(array('member_id' => session('user_auth.uid')))->find();
        $this->assign('member_info_id', $memberInfo['id']);
        $this->display('index');
    }

}
