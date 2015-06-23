<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 用户美食控制器
 */
class CanYinController extends FoodBaseController {

    /**
     * 美食管理
     */
    public function index() {
        //检索订单
        $order_map['mp_id'] = MP_ID;
        $orders = M('FoodOrder')->where($order_map)->select();
        $commit_orders_num = 0;
        $wxpay_orders_num = 0;
        $finish_orders_num = 0;
        if (!empty($orders)) {
            foreach ($orders as $order) {
                if ($order['status'] == \Admin\Model\FoodOrderModel::$STATUS_COMMITED) {
                    $commit_orders_num += 1;
                }
                if ($order['status'] == \Admin\Model\FoodOrderModel::$STATUS_WXPAYED) {
                    $wxpay_orders_num += 1;
                }
                IF ($order['status'] == \Admin\Model\FoodOrderModel::$STATUS_FINISHED) {
                    $finish_orders_num += 1;
                }
            }
        }
        $this->assign('order_total',count($orders));
        $this->assign('commit_orders_num', $commit_orders_num);
        $this->assign('wxpay_orders_num', $wxpay_orders_num);
        $this->assign('finish_orders_num', $finish_orders_num);
        //检索门店
        $dining_map['mp_id'] = MP_ID;
        $dinings = M('DiningRoom')->where($dining_map)->select();
        $used_num = 0;
        $unuse_num = 0;
        if (!empty($dinings)) {
            foreach ($dinings as $dining) {
                if ($dining['status'] == \Admin\Model\DiningRoomModel::$STATUS_ENABLED) {
                    $used_num += 1;
                }
                if ($dining['status'] == \Admin\Model\DiningRoomModel::$STATUS_DISABLED) {
                    $unuse_num += 1;
                }
            }
        }
        $this->assign('total_dinings', count($dinings));
        $this->assign('used_num', $used_num);
        $this->assign('unuse_num', $unuse_num);
        //检索商品
        $food_map['mp_id'] = MP_ID;
        $foods = M('Food')->where($food_map)->select();
        $online_num = 0;
        $offline_num = 0;
        if (!empty($foods)) {
            foreach ($foods as $food) {
                if ($food['status'] == \Admin\Model\FoodModel::$STATUS_DISABLED) {
                    $offline_num += 1;
                }
                if ($food['status'] == \Admin\Model\FoodModel::$STATUS_ENABLED) {
                    $online_num += 1;
                }
            }
        }
        $this->assign('food_total', count($foods));
        $this->assign('online_num', $online_num);
        $this->assign('offline_num', $offline_num);
        $this->meta_title = '微美食';
        $this->display('index');
    }

}
