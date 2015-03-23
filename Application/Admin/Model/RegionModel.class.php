<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Admin\Model;

use Think\Model;

class RegionModel extends Model {

    // 获取区域方法
    public function getRegion($parent) {
        $list = array();
        if (!empty($parent)) {
            $map['parent'] = $parent;
            $list = $this->where($map)->select();
        }
        return $list;
    }
    
    //获取省市县名称
    public static function  getRegionName($id){
        $regionModel = M('Region');
        $data['id'] = $id;
        $res = $regionModel->where($data)->find();
        return $res['name'];
    }

}
