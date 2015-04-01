<?php

// +----------------------------------------------------------------------
// | Author: tonbochow 2015-03-28
// +----------------------------------------------------------------------

namespace Wechat\Controller;

/**
 * 微信首页控制器
 */
class IndexController extends BaseController {

    //微信首页
    public function index() {
        //检索菜品
        $key = I('request.key', '', 'trim');
        $cate_id = I('request.cate_id', '', 'trim');
        $search_key = $key;
        $cond = '';
        if (!empty($cate_id)) {
            $cond = " and weiapp_food.cate_id=$cate_id ";
        }
        $page_num = 10; //每页商品检索数量

        /* 数据流大时启用sphinx
        if (!empty($search_key)) {
            //采用sphinx 模糊搜索
            import('Common.Extends.Sphinx.coreseek');
            $cl = new \SphinxClient ();
            $cl->SetServer('localhost', 9312);
            $cl->SetArrayResult(true);
            $cl->setFilter('status', array(1));
            $cl->SetSortMode(SPH_SORT_ATTR_DESC, "sell_count,view_times,create_time");
            //            $cl->SetSortMode(SPH_SORT_EXTENDED, "@random");
            $cl->SetLimits(0, 10); //首页检索10个
            $res = $cl->Query($search_key, "*");
            if (!empty($res['matches'])) {
                $food_id_arr = array_map('array_shift', $res['matches']);
                $food_ids = implode(',', $food_id_arr);
                $cond .= " and weiapp_food.id in($food_ids) ";
                $foodModel = M('Food');
                $foods = $foodModel
                        ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                        ->where('weiapp_food.status=1' . " $cond")
                        //                        ->where('food.status=1 and left(goods_photo_video.exttype,5)="image"' . " $cond")
                        ->group('weiapp_food_detail.food_id')
                        //                        ->order('goods.addtime desc')
                        //                        ->page(1, $page_num)
                        ->field('weiapp_food.id,weiapp_food.food_name,weiapp_food.price,weiapp_food.weixin_price,weiapp_food_detail.url')
                        ->select();
            } else {
                $foods = '';
            }
        } else {
            $foodModel = M('Food');
            $foods = $foodModel
                    ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                    ->where('weiapp_food.status=1' . " $cond")
                    //                    ->where('foods.status=1 and left(food_detail.exttype,5)="image"' . " $cond")
                    ->group('weiapp_food_detail.food_id')
                    ->order('weiapp_food_detail.default_share')
                    ->page(1, $page_num)
                    ->field('weiapp_food.id,weiapp_food.food_name,weiapp_food.price,weiapp_food.weixin_price,weiapp_food_detail.url')
                    ->select();
        }
        */

//        echo $foodModel->getLastSql();
        $foodModel = M('Food');
        if (!empty($key)) {
            $cond .= " and (weiapp_food.food_name like '%" . $key . "%' or weiapp_food.cate_name like '%" . $key . "%' or weiapp_food.dining_name  like '%" . $key . "%') ";
        }
        $foods_count = $foodModel->where('weiapp_food.status=1' . " $cond")->count();
        import('Common.Extends.Page.BootstrapPage');
        $Page = new \BootstrapPage($foods_count, $page_num);
        $show = $Page->show();
        $foods = $foodModel
                ->join('left  join weiapp_food_detail ON weiapp_food.id = weiapp_food_detail.food_id')
                ->where('weiapp_food.status=1' . " $cond")
                ->group('weiapp_food_detail.food_id')
                ->order('weiapp_food_detail.default_share')
                ->field('weiapp_food.id,weiapp_food.food_name,weiapp_food.price,weiapp_food.weixin_price,weiapp_food_detail.url')
                ->limit($Page->firstRow . ',' . $Page->listRows)
                ->select();
        

        $this->assign('page', $show);
        $this->assign('foods', $foods);
        $this->meta_title = $this->mp['mp_name'] . "菜品首页";
        $this->display('index');
    }

}
