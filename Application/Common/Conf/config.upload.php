<?php

return array(
    //微信工作平台二维码图片上传配置
    'MP_QRCODE_UPLOAD' => array(
        'mimes' => '', //允许上传的文件MiMe类型
        'maxSize' => 1 * 1024 * 1024, //上传的文件大小限制 1M
        'exts' => 'jpg,gif,png,jpeg', //允许上传的文件后缀
        'autoSub' => false, //自动子目录保存文件
        'subName' => array('date', 'Y-m-d'), //子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
        'rootPath' => './Uploads/', //保存根路径
        'savePath' => '', //保存路径
        'saveName' => 'mp_qrcode', 
        'saveExt' => '', //文件保存后缀，空则使用原后缀
        'replace' => true, //存在同名是否覆盖
        'hash' => true, //是否生成hash编码
        'callback' => false, //检测文件是否存在回调函数，如果存在返回文件信息数组
    ),
    //微信工作平台头像图片上传配置
    'MP_IMG_UPLOAD' => array(
        'mimes' => '', //允许上传的文件MiMe类型
        'maxSize' => 1 * 1024 * 1024, //上传的文件大小限制 1M
        'exts' => 'jpg,gif,png,jpeg', //允许上传的文件后缀
        'autoSub' => false, //自动子目录保存文件
        'subName' => array('date', 'Y-m-d'), //子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
        'rootPath' => './Uploads/', //保存根路径
        'savePath' => '', //保存路径
        'saveName' => 'mp_img',
        'saveExt' => '', //文件保存后缀，空则使用原后缀
        'replace' => true, //存在同名是否覆盖
        'hash' => true, //是否生成hash编码
        'callback' => false, //检测文件是否存在回调函数，如果存在返回文件信息数组
    ),
);
