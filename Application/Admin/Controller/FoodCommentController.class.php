<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-04-09
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食微信公众平台 | 微信用户美食套餐评论控制器
 */
class FoodCommentController extends FoodBaseController {

    //微信用户评论(后台管理员)
    public function index() {
        $get_comment = I('get.comment');
        if (!empty($get_comment)) {
            $map['comment'] = array('like', '%' . $get_comment . '%');
        }
        $list = $this->lists('FoodComment', $map, 'mp_id,status');
        $this->assign('list', $list);
        $this->meta_title = '微美食微信用户评论列表';
        $this->display('index');
    }

    //微信用户美食套餐评论(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_comment = I('get.comment');
        if (isset($get_comment)) {
            $map['comment'] = array('like', '%' . $get_comment . '%');
        }
        $list = $this->lists('FoodComment', $map, 'status,id');
        if (!empty($list)) {
            foreach ($list as $key => $val) {
                $list[$key]['comment'] = htmlspecialchars_decode(stripcslashes($val['comment']));
            }
        }
        $this->assign('list', $list);
        $this->meta_title = '微信用户美食套餐评论';
        $this->display('show');
    }

    //显示微信用户评论(前台面向商家)
    public function enable() {
        $comment_id_arr = I('post.id');
        if (empty($comment_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $comment_ids = array_unique($comment_id_arr);
        $comment_ids_str = is_array($comment_ids) ? implode(',', $comment_ids) : $comment_ids;
        $map['id'] = array('in', $comment_ids_str);
        $map['mp_id'] = MP_ID;
        $foodCommentModel = M('FoodComment');
        $comment_data['status'] = \Admin\Model\FoodCommentModel::$STATUS_ENABLE;
        $comment_data['update_time'] = time();
        $comment_enable = $foodCommentModel->where($map)->save($comment_data);
        if ($comment_enable) {
            $this->success('显示微信用户评论成功!');
        }
        $this->error('显示微信用户评论失败!');
    }

    //隐藏微信用户评论(前台面向商家)
    public function disable() {
        $comment_id_arr = I('post.id');
        if (empty($comment_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $comment_ids = array_unique($comment_id_arr);
        $comment_ids_str = is_array($comment_ids) ? implode(',', $comment_ids) : $comment_ids;
        $map['id'] = array('in', $comment_ids_str);
        $map['mp_id'] = MP_ID;
        $foodCommentModel = M('FoodComment');
        $comment_data['status'] = \Admin\Model\FoodCommentModel::$STATUS_DISABLE;
        $comment_data['update_time'] = time();
        $comment_disable = $foodCommentModel->where($map)->save($comment_data);
        if ($comment_disable) {
            $this->success('隐藏微信用户评论成功!');
        }
        $this->error('隐藏微信用户评论失败!');
    }

    //查看微信用户评论详细
    public function detail() {
        $commentModel = M('FoodComment');
        $id = I('get.id', '', 'intval');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $comment = $commentModel->where($map)->find();
        if($comment == false){
            $this->error('未检索到美食或套餐评论');
        }
        $comment['comment'] = htmlspecialchars_decode(stripcslashes($comment['comment']));

        $this->assign('comment', $comment);
        $this->meta_title = '微信用户美食套餐评论详细';
        $this->display('detail');
    }

}
