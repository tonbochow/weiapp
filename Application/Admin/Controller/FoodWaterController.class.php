<?php

// +----------------------------------------------------------------------
// | Author: tonbochow
// | date: 2015-03-07
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 微美食公众平台 | 资金流水控制器
 */
class FoodWaterController extends FoodBaseController {

    /**
     * 资金流水管理(后台管理员)
     */
    public function index() {
        $get_order_no = I('get.order_no');
        if (!empty($get_order_no)) {
            $map['order_no'] = $get_order_no;
        }
        $list = $this->lists('FoodMoneyWater', $map, 'mp_id,id');
        $this->assign('list', $list);
        $this->meta_title = '资金流水列表';
        $this->display('index');
    }

    //资金流水列表页面(前台面向商家)
    public function show() {
        /* 查询条件初始化 */
        $map['mp_id'] = MP_ID;
        $get_order_no = I('get.order_no'); //订单编号唯一
        if (isset($get_order_no)) {
            $map['order_no'] = $get_order_no;
        }
        $get_dining_room_id = I('get.dining_room_id');
        if (!empty($get_dining_room_id)) {
            $map['dining_room_id'] = $get_dining_room_id;
        }
        $list = $this->lists('FoodMoneyWater', $map, 'create_time desc');
        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
        if (IS_CHAIN) {
            $dining_room_arr[0] = '所有门店通用';
        }
        foreach ($dining_rooms as $val) {
            $dining_room_arr[$val['id']] = $val['dining_name'];
        }
        $micro_platform = M('MicroPlatform')->where(array('id' => MP_ID))->find();

        $this->assign('account', $micro_platform['account']);
        $this->assign('select_dining_room_id', $get_dining_room_id);
        $this->assign('dining_room_arr', $dining_room_arr);
        $this->assign('list', $list);
        $this->meta_title = '资金流水列表';
        $this->display('show');
    }

    //资金流水打印页面
    public function csv() {
        $dining_room_id = I('get.dining_room_id','','intval');
        if (!empty($dining_room_id)) {
            $map['dining_room_id'] = $dining_room_id;
        }
        $start_time = strtotime(I('get.start_time'));
        $end_time = strtotime(I('get.end_time'));
        $map['create_time']  = array(array('egt',$start_time),array('elt',$end_time),'and');
        $order_no = I('get.order_no', '', 'trim');
        if (!empty($order_no)) {
            $map['order_no'] = $order_no;
        }
        $map['mp_id'] = MP_ID;
        $data = M('FoodMoneyWater')->where($map)->select();
        if($data == false){
            $this->error('根据您的检索条件暂无资金流水记录!');
        }
        import('Common.Extends.PHPExcel.PHPExcel');
        $resultPHPExcel = new \PHPExcel();
        $resultPHPExcel->getActiveSheet()->setCellValue('A1', '门店');
        $resultPHPExcel->getActiveSheet()->setCellValue('B1', '订单号');
        $resultPHPExcel->getActiveSheet()->setCellValue('C1', '金额');
        $resultPHPExcel->getActiveSheet()->setCellValue('D1', '平台帐号金额');
        $resultPHPExcel->getActiveSheet()->setCellValue('E1', '创建时间');
        $i = 2;
        foreach ($data as $item) {
            $resultPHPExcel->getActiveSheet()->setCellValue('A' . $i, \Admin\Model\DiningRoomModel::getDiningRoomName($item['dining_room_id']));
            $resultPHPExcel->getActiveSheet()->setCellValue('B' . $i, $item['order_no']);
            $resultPHPExcel->getActiveSheet()->setCellValue('C' . $i, $item['amount']);
            $resultPHPExcel->getActiveSheet()->setCellValue('D' . $i, $item['current_amount']);
            $resultPHPExcel->getActiveSheet()->setCellValue('E' . $i, date('Y-m-d H:i:s', $item['create_time']));
            $i ++;
        }
        //设置导出文件名 
        $outputFileName =  date('Y-m-d', time()) . '_' . rand().'.xls';
        $xlsWriter = new \PHPExcel_Writer_Excel5($resultPHPExcel);
        ob_start();
        ob_flush();
        header("Content-Type: application/force-download");
        header("Content-Type: application/octet-stream");
        header("Content-Type: application/download");
        header('Content-Disposition:inline;filename="' . $outputFileName . '"');
        header("Content-Transfer-Encoding: binary");
        header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
        header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Pragma: no-cache");
//            $xlsWriter->save("php://output");
//            exit;
        $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/water/';
        if (!file_exists($save_path)) {
            $mkdir_res = mkdir($save_path, 0777, true);
            if (!$mkdir_res) {
                $this->error('创建目录失败', '', true);
            }
        }
        $finalFileName = $save_path . date('Y-m-d', time()) . '_' . rand() . '.xls';
        $xlsWriter->save($finalFileName);
        echo file_get_contents($finalFileName);


//        if (IS_POST) {
//            $dining_room_id = I('post.dining_room_id');
//            if (!empty($dining_room_id)) {
//                $map['dining_room_id'] = $dining_room_id;
//            }
//            $start_time = strtotime(I('post.start_time'));
//            $end_time = strtotime(I('post.end_time'));
//            $order_no = I('post.order_no', '', 'trim');
//            if (!empty($order_no)) {
//                $map['order_no'] = $order_no;
//            }
//            $map['mp_id'] = MP_ID;
//            $data = M('FoodMoneyWater')->where($map)->select();
//            import('Common.Extends.phpexcel.PHPExcel');
//            $resultPHPExcel = new \PHPExcel();
//            $resultPHPExcel->getActiveSheet()->setCellValue('A1', '门店');
//            $resultPHPExcel->getActiveSheet()->setCellValue('B1', '订单号');
//            $resultPHPExcel->getActiveSheet()->setCellValue('C1', '金额');
//            $resultPHPExcel->getActiveSheet()->setCellValue('D1', '平台帐号金额');
//            $resultPHPExcel->getActiveSheet()->setCellValue('E1', '创建时间');
//            $i = 2;
//            foreach ($data as $item) {
//                $resultPHPExcel->getActiveSheet()->setCellValue('A' . $i, $item['dining_room_id']);
//                $resultPHPExcel->getActiveSheet()->setCellValue('B' . $i, $item['order_no']);
//                $resultPHPExcel->getActiveSheet()->setCellValue('C' . $i, $item['amount']);
//                $resultPHPExcel->getActiveSheet()->setCellValue('D' . $i, $item['current_amount']);
//                $resultPHPExcel->getActiveSheet()->setCellValue('E' . $i, $item['create_time']);
//                $i ++;
//            }
//            //设置导出文件名 
//            $outputFileName = 'total.xls';
//            $xlsWriter = new \PHPExcel_Writer_Excel5($resultPHPExcel);
//            ob_start();
//            ob_flush();
//            header("Content-Type: application/force-download");
//            header("Content-Type: application/octet-stream");
//            header("Content-Type: application/download");
//            header('Content-Disposition:inline;filename="' . $outputFileName . '"');
//            header("Content-Transfer-Encoding: binary");
//            header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
//            header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
//            header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
//            header("Pragma: no-cache");
////            $xlsWriter->save("php://output");
////            exit;
//            $save_path = C('WEBSITE_URL') . '/Uploads/Mp/' . MP_ID . '/water/';
//            if (!file_exists($save_path)) {
//                $mkdir_res = mkdir($save_path, 0777, true);
//                if (!$mkdir_res) {
//                    $this->error('创建目录失败', '', true);
//                }
//            }
//            $finalFileName = $save_path.date('Y-m-d',time()).'_'.rand().'.xls';
//            $xlsWriter->save($finalFileName);
//            echo file_get_contents($finalFileName);
//        }
//
//        $dining_rooms = \Admin\Model\DiningMemberModel::getDiningRooms();
//        if (IS_CHAIN) {
//            $dining_room_arr[0] = '所有门店';
//        }
//        foreach ($dining_rooms as $val) {
//            $dining_room_arr[$val['id']] = $val['dining_name'];
//        }
//        $this->assign('dining_room_arr', $dining_room_arr);
//        $this->meta_title = '导出资金流水EXCEL';
//        $this->display('csv');
    }

}
