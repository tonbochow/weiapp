CREATE TABLE IF NOT EXISTS `weiapp_member_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id对应member表uid',
  `real_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户真实姓名',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '用户手机号码',
  `app_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '微应用类型1餐饮2摄影3ktv等',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户申请平台类型0试用1正式使用',
  `introduce` varchar(256) NOT NULL DEFAULT '' COMMENT '用户申请简单介绍',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0未通过1通过',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '微应用开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '微应用结束时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id` (`member_id`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户详细信息';

CREATE TABLE IF NOT EXISTS  `weiapp_micro_platform` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台appid',
  `appsecret` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台appsecret',
  `partnerid` varchar(256) NOT NULL DEFAULT '' COMMENT '微信支付partnerid',
  `partnerkey` varchar(256) NOT NULL DEFAULT '' COMMENT '微信支付partnerkey',
  `paysignkey` varchar(256) NOT NULL DEFAULT '' COMMENT '微信支付paysignkey',
  `mp_url` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台接入URL',
  `mp_token` char(32) NOT NULL DEFAULT '' COMMENT '微信公众平台接入token',
  `mp_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '平台类型1服务号2订阅号3企业号',
  `mp_original_id` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台帐号id 如:gh_39d543344be5',
  `mp_name` varchar(60) NOT NULL DEFAULT '' COMMENT '微信公众平台名称',
  `mp_wxcode` varchar(128) NOT NULL DEFAULT '' COMMENT '微信公众平台微信号',
  `mp_qrcode` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台二维码',
  `mp_img` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台形象图片',
  `support_wxpay` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否支持微信支付0不支持1支持',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '微信公众号的全局唯一票据access_token',
  `token_expire` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众号access_token有效期(过期时间)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(表示微信公众平台所属用户)',
  `jsapi_ticket` varchar(256) NOT NULL DEFAULT '' COMMENT '调用微信JS接口的临时票据',
  `jsapi_expires` int(11) NOT NULL DEFAULT '0' COMMENT '微信jsapi_tiket 失效时间',
  `is_tryed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否试用过1试用过0未试用过',
  `is_chain` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否连锁(多个餐厅)0否1是',
  `is_bind` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否绑定了微信公众平台',
  `chain_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '连锁餐厅个数',
  `app_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '平台类型1餐饮2商城',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '微信公众平台状态1开启0禁用',
  `account` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '微信公众平台账户金额',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台使用开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台使用截至时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mp_token` (`mp_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信公众平台';






CREATE TABLE IF NOT EXISTS `weiapp_recharge_water` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(充值用户)',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `unit` varchar(6) NOT NULL DEFAULT 'year' COMMENT '充值单位(月month或年year)默认年year',
  `recharge_num` smallint(6) NOT NULL DEFAULT '1' COMMENT '充值期限',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值状态1成功0失败',
  `current_account` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '微信公众平台充值后账户金额(对应micro_platform.account)',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台充值后使用开始时间(对应micro_platform.end_time)',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台充值后使用截至时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '充值时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值流水';


CREATE TABLE IF NOT EXISTS `weiapp_member_weixin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id关联member表id',
  `user_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)唯一',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '微信用户昵称',
  `group_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '微信用户所在分组(微信分组)',
  `is_subscribe` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否关注用户',
  `subscribe_time` int(11) NOT NULL DEFAULT '0' COMMENT '关注时间',
  `unsubscribe_time` int(11) NOT NULL DEFAULT '0' COMMENT '取消关注时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1可用0不可用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信用户列表';

CREATE TABLE  IF NOT EXISTS `weiapp_member_weixin_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `group_name` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户分组名',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信用户分组id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信用户分组创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信用户分组更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信用户分组';

CREATE TABLE IF NOT EXISTS `weiapp_send_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `is_to_all` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否发送给所有微信用户1是0否',
  `description` varchar(128) NOT NULL DEFAULT '' COMMENT '发送(群发)消息简单描述',
  `msg_type` varchar(20) NOT NULL DEFAULT '' COMMENT '消息类型:text voice',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发送消息状态0已发送1发送成功-1失败',
  `total_count` int(11) NOT NULL DEFAULT '0' COMMENT '发送数量',
  `filter_count` int(11) NOT NULL DEFAULT '0' COMMENT '过滤后发送的粉丝数(sent_count+error_count)',
  `sent_count` int(11) NOT NULL DEFAULT '0' COMMENT '发送成功粉丝数',
  `error_count` int(11) NOT NULL DEFAULT '0' COMMENT '发送失败的粉丝数',
  `send_time` int(11) NOT NULL DEFAULT '0' COMMENT '消息发送时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='向微信用户发送消息';

CREATE TABLE IF NOT EXISTS `weiapp_weixin_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `menu_type` varchar(128) NOT NULL DEFAULT '' COMMENT '菜单类型：click  view pic_photo_or_album等',
  `menu_name` varchar(60) NOT NULL DEFAULT '' COMMENT '菜单名称(中文最多7个字)',
  `menu_key` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单key值',
  `menu_url` varchar(256) NOT NULL DEFAULT '' COMMENT '菜单url(仅view类型需要)',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `order` tinyint(2) NOT NULL DEFAULT '1' COMMENT '菜单顺序1-5',
  `p_order` tinyint(2) NOT NULL DEFAULT '1' COMMENT '父菜单顺序1-3',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '菜单状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信公众平台菜单';


CREATE TABLE IF NOT EXISTS `weiapp_chain_dining` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `chain_dining_name` varchar(60) NOT NULL DEFAULT '' COMMENT '连锁餐厅名称',
  `chain_header` varchar(20) NOT NULL DEFAULT '' COMMENT '连锁餐厅负责人',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `province` int(11) NOT NULL DEFAULT '0' COMMENT '省id',
  `city` int(11) NOT NULL DEFAULT '0' COMMENT '市id',
  `town` int(11) NOT NULL DEFAULT '0' COMMENT '县id',
  `address` varchar(256) NOT NULL DEFAULT '' COMMENT '详细地址',
  `description` text NOT NULL,
  `carousel_fir` varchar(256) NOT NULL DEFAULT '' COMMENT '轮播图片url',
  `carousel_sec` varchar(256) NOT NULL DEFAULT '' COMMENT '轮播图片url',
  `carousel_thr` varchar(256) NOT NULL DEFAULT '' COMMENT '轮播图片url',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='连锁餐厅信息';



CREATE TABLE IF NOT EXISTS `weiapp_dining_member` (
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(平台管理人员创建的用户)',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `real_name` varchar(30) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `role_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '餐厅用户角色类型1店员2经理(后续可能添加管理员添加)',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `member_id` (`member_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `weiapp_dining_room` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `is_chain_dining` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否连锁餐厅0否1是',
  `chain_dining_id` int(11) NOT NULL DEFAULT '0' COMMENT '连锁餐厅id对应chain_dining_info.id',
  `dining_name` varchar(60) NOT NULL DEFAULT '' COMMENT '餐厅名称',
  `dining_header` varchar(20) NOT NULL DEFAULT '' COMMENT '餐厅负责人',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `province` int(11) NOT NULL DEFAULT '0' COMMENT '省id',
  `city` int(11) NOT NULL DEFAULT '0' COMMENT '市id',
  `town` int(11) NOT NULL DEFAULT '0' COMMENT '县id',
  `address` varchar(256) NOT NULL DEFAULT '' COMMENT '详细地址',
  `longitude` decimal(17,14) NOT NULL DEFAULT '0.00000000000000' COMMENT '经度',
  `latitude` decimal(17,14) NOT NULL DEFAULT '0.00000000000000' COMMENT '纬度',
  `description` text NOT NULL COMMENT '连锁餐厅描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='餐厅信息';

CREATE TABLE IF NOT EXISTS  `weiapp_dining_room_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `ext_type` varchar(20) NOT NULL DEFAULT '' COMMENT '附件类型',
  `ext_fileid` char(32) NOT NULL DEFAULT '' COMMENT '图片或者微视的md5值',
  `file_name` varchar(256) NOT NULL DEFAULT '' COMMENT '图片或微视url',
  `input_name` varchar(32) NOT NULL DEFAULT '' COMMENT '表单字段名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1有效0无效',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='餐厅详细信息';

CREATE TABLE IF NOT EXISTS `weiapp_food_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `cate_name` varchar(30) NOT NULL DEFAULT '' COMMENT '分类名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级分类id',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '菜分类排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='餐厅菜分类';

CREATE TABLE IF NOT EXISTS `weiapp_food` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `dining_name` varchar(60) NOT NULL DEFAULT '' COMMENT '餐厅名(sphinx模糊搜索用)',
  `cate_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属分类id(对应food_category.id)',
  `cate_name` varchar(60) NOT NULL DEFAULT '' COMMENT '所属分类字符串(sphinx模糊搜索用)',
  `food_name` varchar(30) NOT NULL DEFAULT '' COMMENT '食物名(sphinx模糊搜索)',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '原价(销售价格)',
  `weixin_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '微信价格',
  `cost_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `unit` varchar(10) NOT NULL DEFAULT '' COMMENT '单位',
  `stock` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '库存',
  `description` text NOT NULL COMMENT '描述',
  `view_times` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `comment_times` int(11) NOT NULL DEFAULT '0' COMMENT '评论次数',
  `favorite_times` int(11) NOT NULL DEFAULT '0' COMMENT '收藏次数',
  `sell_count` int(11) NOT NULL DEFAULT '0' COMMENT '销售数量',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热销饭菜1是0否',
  `is_promotion` tinyint(1) NOT NULL DEFAULT '0' COMMENT '促销饭菜1是0否',
  `style_id` tinyint(4) NOT NULL DEFAULT '0' COMMENT '饭菜风格id',
  `style_name` varchar(20) NOT NULL DEFAULT '' COMMENT '饭菜风格(酸甜辣)sphinx模糊搜索用',
  `is_offline` tinyint(1) NOT NULL DEFAULT '0' COMMENT '餐到付款1允许0禁止',
  `use_envelope` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许用红包1允许0禁止',
  `red_envelope_percent` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用红包百分比',
  `use_card` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许使用卡卷1允许0禁止',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜';


CREATE TABLE IF NOT EXISTS `weiapp_food_detail` (
  `food_id` int(11) NOT NULL DEFAULT '0' COMMENT '饭菜id对应food表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `ext_type` varchar(20) NOT NULL DEFAULT '' COMMENT '附件类型',
  `ext_fileid` char(32) NOT NULL DEFAULT '' COMMENT '图片或者微视的md5值',
  `file_name` varchar(256) NOT NULL DEFAULT '' COMMENT '图片或微视url',
  `input_name` varchar(32) NOT NULL DEFAULT '' COMMENT '表单字段名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1有效0无效',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='饭菜详细';

CREATE TABLE IF NOT EXISTS `weiapp_food_style` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `food_id` int(11) NOT NULL DEFAULT '0' COMMENT '饭菜id对应food表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '风格描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1有效0无效',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='饭菜风格';


CREATE TABLE IF NOT EXISTS `weiapp_food_car` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id对应member表id',
  `content` text NOT NULL COMMENT '购餐车内容存json',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐车';


CREATE TABLE IF NOT EXISTS  `weiapp_food_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '购餐用户id对应member表id',
  `dining_member_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅负责人id对应member表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `order_no` varchar(32) NOT NULL DEFAULT '' COMMENT '订单编号',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单类型:0在餐厅下单用餐1线上订餐配送到家',
  `pay_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付方式:1微信2支付宝3线下付款',
  `delivery_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '送餐费用',
  `count` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '购餐数量',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '购餐总金额',
  `food_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '餐费',
  `real_pay_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际支付总金额',
  `envelope_used_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包使用金额',
  `card_used_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '卡包使用金额',
  `address_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户收货地址id对应food_address表id',
  `out_trade_no` varchar(32) NOT NULL DEFAULT '' COMMENT '微信或支付宝交易订单号',
  `is_printed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单是否已打印0未打印1已打印',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '订单备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '单据状态-1取消1已提交2待送餐已支付3送餐中4完成',
  `pay_time` int(11) NOT NULL DEFAULT '0' COMMENT '支付时间',
  `delivery_time` int(11) NOT NULL DEFAULT '0' COMMENT '送餐时间',
  `finish_time` int(11) NOT NULL DEFAULT '0' COMMENT '完成时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐订单';


CREATE TABLE IF NOT EXISTS `weiapp_food_order_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '购餐用户id对应member表id',
  `dining_member_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅负责人id对应member表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单id对应food_order表id',
  `food_id` int(11) NOT NULL DEFAULT '0' COMMENT '饭菜id对应food表id',
  `count` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `weixin_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '微信价格',
  `unit` varchar(10) NOT NULL DEFAULT '' COMMENT '单位',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额count*price',
  `real_pay_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际支付金额',
  `use_envelope` tinyint(1) NOT NULL DEFAULT '0' COMMENT '使用红包1使用0未使用',
  `red_envelope_percent` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包使用百分比',
  `envelope_used_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包使用金额',
  `use_card` tinyint(1) NOT NULL DEFAULT '0' COMMENT '使用卡卷1使用0未使用',
  `card_used_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '卡卷使用金额',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '单据明细备注',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐订单明细';


CREATE TABLE IF NOT EXISTS `weiapp_food_money_water` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '购餐用户id对应member表id',
  `dining_member_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅负责人id对应member表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `pay_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付方式1微信2支付吧',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单id对应food_order表id',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额对应food_order表real_pay_amount',
  `current_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '当前帐号金额',
  `note` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐订单流水';


CREATE TABLE IF NOT EXISTS `weiapp_food_wx_feedback` (
  `feedback_id` varchar(3) NOT NULL COMMENT '微信用户投诉单id',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid对应member表wx_openid',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '微信用户昵称对应member表nickname',
  `appid` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台appid',
  `appsignature` varchar(256) NOT NULL DEFAULT '' COMMENT '微信投诉单签名',
  `msg_type` varchar(20) NOT NULL DEFAULT '' COMMENT '类型request用户提交投诉cofirm用户确认取消投诉reject用户拒绝取消投诉',
  `feedback_time` int(11) NOT NULL DEFAULT '0' COMMENT '用户投诉时间',
  `trans_id` char(28) NOT NULL DEFAULT '' COMMENT '交易订单号',
  `reason` varchar(256) NOT NULL DEFAULT '' COMMENT '用户投诉原因',
  `solution` varchar(256) NOT NULL DEFAULT '' COMMENT '用户希望解决方案',
  `extinfo` varchar(256) NOT NULL DEFAULT '' COMMENT '备注信息+电话',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐微信维权表';


CREATE TABLE IF NOT EXISTS `weiapp_food_wx_notify` (
  `out_trade_no` varchar(32) NOT NULL DEFAULT '' COMMENT '主键商户系统订单号 和 food_order表out_trade_no一致',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid对应member表wx_openid',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `trade_mode` int(11) NOT NULL DEFAULT '0' COMMENT '交易模式 1即时到账 其他保留',
  `trade_state` int(11) NOT NULL DEFAULT '0' COMMENT '交易状态 支付结果 0成功 其他保留',
  `pay_info` char(64) NOT NULL DEFAULT '' COMMENT '支付结果信息 支付成功是为空',
  `partner` char(10) NOT NULL DEFAULT '' COMMENT '商户号 即partnerid 10位正整数',
  `bank_type` char(16) NOT NULL DEFAULT '' COMMENT '付款银行 如WX',
  `bank_billno` char(32) NOT NULL DEFAULT '' COMMENT '银行订单号',
  `total_fee` int(11) NOT NULL DEFAULT '0' COMMENT '支付金额单位为分',
  `fee_type` int(11) NOT NULL DEFAULT '1' COMMENT '现金支付币种 1人民币',
  `notify_id` char(128) NOT NULL DEFAULT '' COMMENT '支付结果通知id(据此查询交易结果)',
  `transaction_id` char(28) NOT NULL DEFAULT '' COMMENT '交易号',
  `attach` char(128) NOT NULL DEFAULT '' COMMENT '商户数据包',
  `time_end` int(11) NOT NULL DEFAULT '0' COMMENT '交易完成时间',
  `transport_fee` int(11) NOT NULL DEFAULT '0' COMMENT '物流费用单位分',
  `product_fee` int(11) NOT NULL DEFAULT '0' COMMENT '物品费用单位分',
  `discount` int(11) NOT NULL DEFAULT '0' COMMENT '折扣价格',
  `buyer_alias` char(64) NOT NULL DEFAULT '' COMMENT '买家别名',
  `appid` varchar(256) NOT NULL DEFAULT '' COMMENT '商户appid',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐微信支付通知';


CREATE TABLE IF NOT EXISTS `weiapp_food_wx_warn` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid对应member表wx_openid',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `appid` varchar(256) NOT NULL DEFAULT '' COMMENT '微餐饮客户appid',
  `appsignature` varchar(256) NOT NULL DEFAULT '' COMMENT '微信告警签名',
  `error_type` varchar(32) NOT NULL DEFAULT '' COMMENT '错误代码',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '微信告警描述',
  `alarm_content` text NOT NULL COMMENT '告警描述详情',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '告警处理状态0 未处理 1 已处理',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信告警生成时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信告警信息修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐微信告警';


CREATE TABLE IF NOT EXISTS `weiapp_food_wx_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid对应member表wx_openid',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `out_trade_no` varchar(32) NOT NULL DEFAULT '' COMMENT '微信支付订单号',
  `content` text NOT NULL COMMENT 'json形式存food_order表id',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐微信支付中间表';

CREATE TABLE IF NOT EXISTS `weiapp_dining_reserve` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid对应member表wx_openid',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `user_name` varchar(30) NOT NULL DEFAULT '' COMMENT '联系人',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `user_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '用餐人数',
  `meal_time` int(11) NOT NULL DEFAULT '0' COMMENT '用餐时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态-2已作废-1已取消1已提交2已确认3已完成',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '预定简单描述',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='到店用餐预定';


CREATE TABLE  IF NOT EXISTS `weiapp_dining_envelope_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `subscribe_has_envelope` tinyint(1) NOT NULL DEFAULT '0' COMMENT '关注送现金红包1是0否',
  `subscribe_envelope_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '关注送红包金额',
  `offset_cash` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可抵消现金(现金结账扫描减红包金额)',
  `unsubscribe_reduce_envelope` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户取消关注扣减红包1是0否',
  `reduce_envelope_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '取消关注扣减红包金额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包配置';


CREATE TABLE IF NOT EXISTS  `weiapp_red_envelope` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `envelope_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '分发红包金额',
  `receive_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '每人可领取金额',
  `current_envelope_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包剩余金额',
  `is_sended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已发送1是0否',
  `only_subscribe` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只有关注才能领取红包',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '红包活动是否结束1是0否(红包领取完自动结束)',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '分发时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '红包发完时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分发红包';

CREATE TABLE  IF NOT EXISTS `weiapp_dining_envelope_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `received_envelope_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收到红包金额',
  `use_envelope_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包消费使用金额',
  `current_envelope_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户剩余红包金额',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '红包使用0领取1消费',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '领取或消费红包时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包统计';

CREATE TABLE  IF NOT EXISTS `weiapp_dining_setmenu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `setmenu_name` varchar(30) NOT NULL DEFAULT '' COMMENT '套餐名',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '套餐描述',
  `use_red_envelope` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许使用红包0禁止1允许',
  `use_card` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许使用优惠券0禁止1允许',
  `setmenu_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '套餐总价',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '套餐状态1上架0下架',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '套餐开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '套餐截止时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='套餐';



CREATE TABLE IF NOT EXISTS `weiapp_dining_setmenu_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `setmenu_id` int(11) NOT NULL DEFAULT '0' COMMENT '套餐id',
  `food_id` int(11) NOT NULL DEFAULT '0' COMMENT '饭菜id对应food表id',
  `food_name` varchar(30) NOT NULL DEFAULT '' COMMENT '菜名',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `count` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否属于套餐1是0否',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='套餐明细';


CREATE TABLE IF NOT EXISTS `weiapp_food_setmenu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建菜品套餐用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `setmenu_name` varchar(30) NOT NULL DEFAULT '' COMMENT '套餐名',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '套餐描述',
  `use_card` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许使用优惠券0禁止1允许',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '套餐应付总价',
  `setmenu_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '套餐优惠价',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '套餐状态1上架0下架',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜品套餐';


CREATE TABLE IF NOT EXISTS `weiapp_food_setmenu_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `setmenu_id` int(11) NOT NULL DEFAULT '0' COMMENT '套餐id',
  `food_id` int(11) NOT NULL DEFAULT '0' COMMENT '饭菜id对应food表id',
  `food_name` varchar(30) NOT NULL DEFAULT '' COMMENT '菜名',
  `weixin_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `count` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否属于套餐1是0否',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜品套餐明细';




















