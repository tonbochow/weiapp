<?php
// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-02-23
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台微餐饮申请试用控制器
 */
class MemberInfoController extends AdminController {

    /**
     * 申请列表(后台)
     */
    public function apply(){
        /* 查询条件初始化 */
        $map = array();
        $get_real_name = I('get.real_name');
        if(isset($get_real_name)){
            $map['real_name']    =   array('like', '%'.(string)I('real_name').'%');
        }

        $list = $this->lists('MemberInfo', $map,'status,id');
//        // 记录当前列表页的cookie
//        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('list', $list);
        $this->meta_title = '申请试用列表';
        $this->display('apply');
    }
    
    /**
     * 编辑用户申请(后台)
     */
    public function edit(){
        $this->display('edit');
    }
    
    /**
     * 删除用户申请(后台)
     */
    public function delete(){
        
    }
    
    /**
     * 用户申请通过(后台)
     */
    public function allow(){
        $id = array_unique((array)I('id',0));
        $ids = is_array($id) ? implode(',',$id) : $id;
        if ( empty($ids) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['id'] =   array('in',$ids);
    }
    
    /**
     * 用户申请禁止(后台)
     */
    public function deny(){
        
    }
    
    /**
     * 微餐饮公众平台(用户)
     */
    public function view(){
        
    }
    
    /**
     * 添加微餐饮公众平台(用户)
     */
    public function add(){
        
    }
    
    /**
     * 编辑微餐饮公众平台(用户)
     */
    public function modify(){
        
    }
}
