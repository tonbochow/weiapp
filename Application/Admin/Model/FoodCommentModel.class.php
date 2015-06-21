<?php

// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.52gdp.com
// +----------------------------------------------------------------------
// | Author: tonbochow <tonbochow@qq.com>
// | date  : 2015-03-02
// | 微信用户美食或套餐评论模型
// +----------------------------------------------------------------------

namespace Admin\Model;

use Think\Model;

class FoodCommentModel extends Model {

    public static $STATUS_ENABLE = 1; //显示
    public static $STATUS_DISABLE = 0; //隐藏
    public static $TYPE_FOOD = 1; //美食
    public static $TYPE_SETMENU = 2; //套餐

    /* 自动验证规则 */
    protected $_validate = array(
        array('mp_id', 'require', '微信公众号平台id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('wx_openid', 'require', '微信用户id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('food_setmenu_id', 'require', '美食或套餐id不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('comment', 'require', '评论内容不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
    );

    //获取微信用户评论状态
    public static function getFoodCommentStatus($status = null, $has_choice = true) {
        if ($has_choice) {
            $status_arr = array('' => '请选择');
        }
        $status_arr[self::$STATUS_ENABLE] = '显示';
        $status_arr[self::$STATUS_DISABLE] = '隐藏';
        if ($status !== null) {
            return $status_arr[$status];
        }
        return $status_arr;
    }

    //获取微信用户评论类型
    public static function getFoodCommentType($type = null, $has_choice = true) {
        if ($has_choice) {
            $type_arr = array('' => '请选择');
        }
        $type_arr[self::$TYPE_FOOD] = '美食';
        $type_arr[self::$TYPE_SETMENU] = '套餐';
        if ($type !== null) {
            return $type_arr[$type];
        }
        return $type_arr;
    }

    //获取微信用户评论
    public static function getComments($id) {
        $foodCommentModel = M('FoodComment');
        $map['id'] = $id;
        $comments = $foodCommentModel->where($map)->order("create_time desc")->select();
        return $comments;
    }

    //获取微信用户评论内容
    public static function getComment($id) {
        return M('FoodComment')->where(array('id' => $id))->field('comment');
    }

    //通过food_setmenu_id 和wx_openid 获取评论
    public static function getCommentByWxopenidFoodid($wx_openid, $food_setmenu_id, $order_id = '') {
        if (!empty($order_id)) {
            $map['order_id'] = $order_id;
        }
        $map['wx_openid'] = $wx_openid;
        $map['food_setmenu_id'] = $food_setmenu_id;
        $map['mp_id'] = MP_ID;
        $comment = M('FoodComment')->where($map)->find();
        return $comment;
    }

}
