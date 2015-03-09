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