CREATE TABLE `weiapp_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `weiapp_auth_group_access`
ENGINE=InnoDB;

ALTER TABLE `weiapp_member_info`
ADD COLUMN `token_created`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已创建token(预先生成平台token等)0否1是' AFTER `introduce`;


ALTER TABLE `weiapp_weixin_menu`
ADD COLUMN `member_id`  int(11) NOT NULL DEFAULT 0 COMMENT '关联用户表member的主键id' AFTER `mp_id`;

ALTER TABLE `weiapp_weixin_menu`
ADD COLUMN `menu_content`  varchar(256) NOT NULL DEFAULT '' COMMENT 'click类型菜单自定义的回复内容' AFTER `menu_url`;


ALTER TABLE `weiapp_weixin_menu`
CHANGE COLUMN `order` `c_order`  tinyint(2) NOT NULL DEFAULT 1 COMMENT '菜单顺序1-5' AFTER `pid`;

ALTER TABLE `weiapp_food_order`
MODIFY COLUMN `type`  tinyint(1) NOT NULL DEFAULT 1 COMMENT '订单类型:1在餐厅下单用餐2线上订餐配送到家' AFTER `order_no`;

ALTER TABLE `weiapp_food_order`
ADD COLUMN `wx_openid`  varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid' AFTER `member_id`;


ALTER TABLE `weiapp_dining_room`
MODIFY COLUMN `chain_dining_id`  int(11) NOT NULL DEFAULT 0 COMMENT '连锁餐厅id对应chain_dining.id' AFTER `is_chain_dining`;

CREATE TABLE `weiapp_chain_dining` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `chain_dining_name` varchar(60) NOT NULL DEFAULT '' COMMENT '连锁餐厅名称',
  `chain_header` varchar(20) NOT NULL DEFAULT '' COMMENT '连锁餐厅负责人',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `description` text NOT NULL,
  `carousel_fir` varchar(256) NOT NULL DEFAULT '' COMMENT '轮播图片url',
  `carousel_sec` varchar(256) NOT NULL DEFAULT '' COMMENT '轮播图片url',
  `carousel_thr` varchar(256) NOT NULL DEFAULT '' COMMENT '轮播图片url',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id` (`member_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='连锁餐厅信息';


ALTER TABLE `weiapp_dining_room_detail`
CHANGE COLUMN `file_name` `url`  varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片或微视url' AFTER `ext_fileid`;



ALTER TABLE `weiapp_food`
ADD COLUMN `share_title`  varchar(60) NOT NULL DEFAULT '' COMMENT '微信内分享显示标题' AFTER `status`,
ADD COLUMN `share_desc`  varchar(128) NOT NULL DEFAULT '' COMMENT '微信内分享描述' AFTER `share_title`,
ADD COLUMN `share_imgurl`  varchar(255) NOT NULL DEFAULT '' COMMENT '微信内分享图片url' AFTER `share_desc`;


ALTER TABLE `weiapp_food`
MODIFY COLUMN `stock`  decimal(10,2) NOT NULL DEFAULT '-1' COMMENT '库存' AFTER `unit`,
MODIFY COLUMN `is_offline`  tinyint(1) NOT NULL DEFAULT 1 COMMENT '餐到付款1允许0禁止' AFTER `style_name`,
MODIFY COLUMN `use_card`  tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否允许使用卡卷1允许0禁止' AFTER `red_envelope_percent`;


ALTER TABLE `weiapp_food_style`
DROP COLUMN `food_id`,
DROP COLUMN `dining_room_id`,
CHANGE COLUMN `description` `name`  varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '风格名称' AFTER `member_id`,
COMMENT='菜品风格';

ALTER TABLE `weiapp_food_detail`
ADD COLUMN `id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT FIRST ,
ADD PRIMARY KEY (`id`);

ALTER TABLE `weiapp_food_detail`
ADD COLUMN `default_share`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为默认微信分享图片' AFTER `input_name`;
