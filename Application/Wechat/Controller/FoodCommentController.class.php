<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-04-09
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信端用户菜品评论控制器
 */
class FoodCommentController extends BaseController {

    //评论列表
    public function index() {
        $foodCommentModel = M('FoodComment');
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['mp_id'] = MP_ID;
        $comment_count = $foodCommentModel->where($map)->count();
        $page_num = 10;
        import('Common.Extends.Page.BootstrapPage');
        $Page = new \BootstrapPage($comment_count, $page_num);
        $show = $Page->show();
        $comments = $foodCommentModel->where($map)->order('create_time desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
        if (!empty($comments)) {
            foreach ($comments as $key => $comment) {
                $comments[$key]['comment'] = htmlspecialchars_decode(stripslashes($comment['comment']));
            }
        }

        $this->assign('page', $show);
        $this->assign('comments', $comments);
        $this->meta_title = $this->mp['mp_name'] . "评论";
        $this->display('index');
    }

    //评论详细
    public function view() {
        $id = I('get.id', '', 'intval');
        $map['id'] = $id;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['mp_id'] = MP_ID;
        $comment = M('FoodComment')->where($map)->find();
        if ($comment == false) {
            $this->error('未检索到您要查看的评论');
        }
        $comment['comment'] = htmlspecialchars_decode(stripcslashes($comment['comment']));

        $this->assign('comment', $comment);
        $this->meta_title = $this->mp['mp_name'] . "评论详细";
        $this->display('view');
    }

    //创建评论
    public function create() {
        $food_setmenu_id = I('request.food_setmenu_id', '', 'intval');
        $type = I('request.type', '', 'intval');
        $map['food_setmenu_id'] = $food_setmenu_id;
        $map['type'] = $type;
        $map['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
        $map['mp_id'] = MP_ID;
        $comment = M('FoodComment')->where($map)->find();
        if (!empty($comment)) {
            if (IS_POST) {
                $this->error('您已评论过', '', true);
            }
            $this->error('您已评论过');
        }
        if (IS_POST) {
            $foodCommentModel = D('FoodComment');
            $data['wx_openid'] = $this->weixin_userinfo['wx_openid'] = 'wx_abcdef';
            $data['mp_id'] = MP_ID;
            $data['food_setmenu_id'] = $food_setmenu_id;
            if ($type == \Admin\Model\FoodOrderDetailModel::$TYPE_FOOD) {
                $data['food_setmenu_name'] = \Admin\Model\FoodModel::getFoodName($food_setmenu_id);
            } else {
                $data['food_setmenu_name'] = '';
            }
            $data['type'] = $type;
            $data['comment'] = I('post.comment');
            $data['status'] = \Admin\Model\FoodCommentModel::$STATUS_ENABLE;
            $data['create_time'] = time();
            $data['update_time'] = time();
            if ($foodCommentModel->create($data, \Admin\Model\FoodCommentModel::MODEL_INSERT)) {
                $comment_id = $foodCommentModel->add();
                if ($comment_id) {
                    $this->success('评论成功,感谢您的评论', '', true);
                }
            }
            $this->error('评论失败', '', true);
        }

        if ($type == \Admin\Model\FoodOrderDetailModel::$TYPE_FOOD) {
            $food = M('Food')->where(array('id' => $food_setmenu_id))->find();
        } else {
            $food = M('FoodSetmenu')->where(array('id' => $food_setmenu_id))->find();
        }

        $this->assign('food', $food);
        $this->assign('food_setmenu_id', $food_setmenu_id);
        $this->assign('type', $type);
        $this->meta_title = $this->mp['mp_name'] . "创建评论";
        $this->display('create');
    }

}
