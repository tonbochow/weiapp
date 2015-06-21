<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-20
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食微信公众平台 | 门店美食风格控制器
 */
class FoodStyleController extends FoodBaseController {

    //门店美食风格列表(后台管理员)
    public function index() {
        $get_name= I('get.name');
        if (!empty($get_name)) {
            $map['name'] = array('like', '%' . (string) I('name') . '%');
        }
        $list = $this->lists('FoodStyle', $map, 'mp_id,status');
        $this->assign('list', $list);
        $this->meta_title = '微美食美食风格列表';
        $this->display('index');
    }

    //门店美食风格列表(前台面向商家)
    public function show() {
        $map['mp_id'] = MP_ID;
        $get_name = I('get.name');
        if (isset($get_name)) {
            $map['name'] = array('like', '%' . (string) I('name') . '%');
        }
        $list = $this->lists('FoodStyle', $map, 'status,id');
        $this->assign('list', $list);
        $this->meta_title = '门店美食风格列表';
        $this->display('show');
    }

    //创建门店美食风格(前台面向商家)
    public function add() {
        if (IS_POST) {
            $food_style_data = I('post.');
            $foodStyleModel = D('FoodStyle');
            //保存门店美食风格
            $food_style_data['mp_id'] = MP_ID;
            $food_style_data['member_id'] = UID;
            $food_style_data['status'] = \Admin\Model\FoodStyleModel::$STATUS_ENABLED;
            if ($foodStyleModel->create($food_style_data, \Admin\Model\FoodStyleModel::MODEL_INSERT)) {
                $food_style_add = $foodStyleModel->add();
                if ($food_style_add) {
                    $this->success('保存门店美食风格成功!', '', true);
                }
            }
            $this->error($foodStyleModel->getError(), '', true);
        }

        $this->meta_title = '创建门店美食风格';
        $this->display('add');
    }

    //编辑门店美食风格(前台面向商家)
    public function edit() {
        if (IS_POST) {
            $food_style_data = I('post.');
            $foodStyleModel = D('FoodStyle');
            if ($foodStyleModel->create($food_style_data, \Admin\Model\FoodStyleModel::MODEL_UPDATE)) {
                $food_style_edit = $foodStyleModel->save();
                if ($food_style_edit) {
                    $this->success('保存门店美食风格成功', '', true);
                }
            }
            $this->error($foodStyleModel->getError(), '', true);
        }
        $id = intval(I('get.id', '', 'trim'));
        $foodStyleModel = M('FoodStyle');
        $map['id'] = $id;
        $map['mp_id'] = MP_ID;
        $food_style = $foodStyleModel->where($map)->find();
        if ($food_style == false) {
            $this->error('未检索到您要编辑的门店美食风格!');
        }

        $this->assign('food_style', $food_style);
        $this->assign('json_food_style', json_encode($food_style));
        $this->meta_title = '编辑门店美食风格';
        $this->display('edit');
    }

    //启用门店美食分类(前台面向商家)
    public function enable() {
        $food_style_id_arr = I('post.id');
        if (empty($food_style_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_style_ids = array_unique($food_style_id_arr);
        $food_style_ids_str = is_array($food_style_ids) ? implode(',', $food_style_ids) : $food_style_ids;
        $map['id'] = array('in', $food_style_ids_str);
        $map['mp_id'] = MP_ID;
        $foodStyleModel = M('FoodStyle');
        $food_style_data['status'] = \Admin\Model\FoodStyleModel::$STATUS_ENABLED;
        $food_style_data['update_time'] = time();
        $food_style_enable = $foodStyleModel->where($map)->save($food_style_data);
        if ($food_style_enable) {
            $this->success('启用门店美食风格成功!');
        }
        $this->error('启用门店美食风格失败!');
    }

    //禁用门店美食分类(前台面向商家)
    public function disable() {
        $food_style_id_arr = I('post.id');
        if (empty($food_style_id_arr)) {
            $this->error('请选择要操作的数据!');
        }
        $food_style_ids = array_unique($food_style_id_arr);
        $food_style_ids_str = is_array($food_style_ids) ? implode(',', $food_style_ids) : $food_style_ids;
        $map['id'] = array('in', $food_style_ids_str);
        $map['mp_id'] = MP_ID;
        $foodStyleModel = M('FoodStyle');
        $food_style_data['status'] = \Admin\Model\FoodStyleModel::$STATUS_DISABLED;
        $food_style_data['update_time'] = time();
        $food_style_disable = $foodStyleModel->where($map)->save($food_style_data);
        if ($food_style_disable) {
            $this->success('禁用门店美食风格成功!');
        }
        $this->error('禁用门店美食风格失败!');
    }

}
