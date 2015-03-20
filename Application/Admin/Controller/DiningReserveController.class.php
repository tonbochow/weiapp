<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-20
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微餐饮微信公众平台 | 客户预定控制器
 */
class DiningReserveController extends FoodBaseController {

    //客户预定列表(后台管理员)
    public function index() {
        
    }

    //客户预定列表(前台面向商家)
    public function show() {
        if (DINING_ROOM_ID != '') {//连锁分店店员登录
            $map['dining_room_id'] = DINING_ROOM_ID;
        }
        $map['mp_id'] = MP_ID;
        $get_user_name = I('get.user_name');
        if (isset($get_user_name)) {
            $map['user_name'] = array('like', '%' . (string) I('user_name') . '%');
        }
        $list = $this->lists('DiningReserve', $map, 'status,id');
        $this->assign('list', $list);
        $this->meta_title = '客户预定';
        $this->display('show');
    }

    //创建预定(前台面向客户)
    public function add() {


        $this->meta_title = '我要预定';
        $this->display('add');
    }

    //客户取消预定(前台面向客户)
    public function cancel() {
        if (IS_POST) {
            $id = I('post.id');
            $diningReserveModel = M('DiningReserve');
            $map['id'] = $id;
            $map['wx_openid'] = '';
            $dining_reserve = $diningReserveModel->where($map)->find();
            if ($dining_reserve == false) {
                $this->error('未检索到您要取消的预定!', '', true);
            }
            $cancel_data['status'] = \Admin\Model\DiningReserveModel::$STATUS_CANCEL;
            $cancel_data['update_time'] = time();
            $reserve_cancel = $diningReserveModel->where($map)->save($cancel_data);
            if ($reserve_cancel) {
                $this->success('取消预定成功!', '', true);
            }
            $this->error($diningReserveModel->getError(), '', true);
        }
    }

    //商家确认客户预定(前台面向商家)
    public function confirm() {
        if (IS_POST) {
            $reserve_id_arr = I('post.id');
            if (empty($reserve_id_arr)) {
                $this->error('请选择要操作的数据!');
            }
            $reserve_ids = array_unique($reserve_id_arr);
            $reserve_ids_str = is_array($reserve_ids) ? implode(',', $reserve_ids) : $reserve_ids;
            $map['id'] = array('in', $reserve_ids_str);
            $map['mp_id'] = MP_ID;
            $map['status'] = \Admin\Model\DiningReserveModel::$STATUS_COMMITED; //只有已提交的预定才能确认
            $reserveModel = M('DiningReserve');
            $reserve_data['status'] = \Admin\Model\DiningReserveModel::$STATUS_CONFIRM;
            $reserve_data['update_time'] = time();
            $reserve_confirm = $reserveModel->where($map)->save($reserve_data);
            if ($reserve_confirm) {
                //给微信客户发送消息通知用户
                $info_content = '恭喜您预定成功!期待您的光临！';
                $reserves = $reserveModel->where($map)->select();
                foreach ($reserves as $reserve) {//发送微信消息通知客户预定成功
                    \Admin\Model\MicroPlatformModel::sendCustomerMessage(APPID, APPSERCERT, $reserve['wx_openid'], $info_content);
                }
                $this->success('确认用户预定成功!');
            }
            $this->error('确认用户预定失败!');
        }
    }

    //完成预定(前台面向商家|客户)
    public function finish() {
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
            $this->success('禁用餐厅菜品风格成功!');
        }
        $this->error('禁用餐厅菜品风格失败!');
    }

    //商家作废客户预定(前台面向商家)
    public function drop() {
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
            $this->success('启用餐厅菜品风格成功!');
        }
        $this->error('启用餐厅菜品风格失败!');
    }

}