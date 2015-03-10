/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50612
Source Host           : localhost:3306
Source Database       : weiapp

Target Server Type    : MYSQL
Target Server Version : 50612
File Encoding         : 65001

Date: 2015-03-10 22:51:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `weiapp_action`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_action`;
CREATE TABLE `weiapp_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of weiapp_action
-- ----------------------------
INSERT INTO `weiapp_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `weiapp_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `weiapp_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `weiapp_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `weiapp_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `weiapp_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `weiapp_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `weiapp_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `weiapp_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `weiapp_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `weiapp_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- ----------------------------
-- Table structure for `weiapp_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_action_log`;
CREATE TABLE `weiapp_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of weiapp_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_addons`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_addons`;
CREATE TABLE `weiapp_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of weiapp_addons
-- ----------------------------
INSERT INTO `weiapp_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `weiapp_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `weiapp_addons` VALUES ('3', 'DevTeam', '开发团队信息', '开发团队成员信息', '0', '{\"title\":\"\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `weiapp_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `weiapp_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `weiapp_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `weiapp_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');

-- ----------------------------
-- Table structure for `weiapp_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_attachment`;
CREATE TABLE `weiapp_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of weiapp_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_attribute`;
CREATE TABLE `weiapp_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of weiapp_attribute
-- ----------------------------
INSERT INTO `weiapp_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '1:列表推荐\r\n2:频道页推荐\r\n4:首页推荐', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for `weiapp_auth_extend`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_auth_extend`;
CREATE TABLE `weiapp_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of weiapp_auth_extend
-- ----------------------------
INSERT INTO `weiapp_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `weiapp_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `weiapp_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `weiapp_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `weiapp_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `weiapp_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `weiapp_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `weiapp_auth_extend` VALUES ('1', '37', '1');

-- ----------------------------
-- Table structure for `weiapp_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_auth_group`;
CREATE TABLE `weiapp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_auth_group
-- ----------------------------
INSERT INTO `weiapp_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '', '1', '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106');
INSERT INTO `weiapp_auth_group` VALUES ('2', 'admin', '1', '测试用户', '测试用户', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');
INSERT INTO `weiapp_auth_group` VALUES ('3', 'admin', '1', '微餐饮', 'food', '1', '1,231,232,233,236,237,238,239,240,242,243,244,245,246,247,248,249,250,251,254,255,256,259,260,261,262,263,264,265,266,267');

-- ----------------------------
-- Table structure for `weiapp_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_auth_group_access`;
CREATE TABLE `weiapp_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_auth_group_access
-- ----------------------------
INSERT INTO `weiapp_auth_group_access` VALUES ('2', '3');

-- ----------------------------
-- Table structure for `weiapp_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_auth_rule`;
CREATE TABLE `weiapp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=268 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_auth_rule
-- ----------------------------
INSERT INTO `weiapp_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '内容', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '用户信息', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('217', 'admin', '1', 'Admin/MemberInfo/apply', '试用申请管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('218', 'admin', '1', 'Admin/MicroPlatform/index', '微信公众平台列表管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('219', 'admin', '1', 'Admin/PlatformMenu/index', '微信公众平台菜单管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Dining/index', '连锁餐厅管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('221', 'admin', '1', 'Admin/DiningRoom/index', '餐厅列表管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('222', 'admin', '1', 'Admin/FoodCategory/index', '饭菜分类列表管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('223', 'admin', '1', 'Admin/Food/index', '饭菜列表管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('224', 'admin', '1', 'Admin/FoodOrder/index', '订单列表管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('225', 'admin', '2', 'Admin/Catering/index', '微餐饮后台', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('226', 'admin', '1', 'Admin/MemberInfo/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('227', 'admin', '1', 'Admin/MemberInfo/delete', '删除', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('228', 'admin', '1', 'Admin/MemberInfo/allow', '通过', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('229', 'admin', '1', 'Admin/MemberInfo/deny', '禁用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('230', 'admin', '1', 'Admin/MicroPlatform/view', '公众平台', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('231', 'admin', '1', 'Admin/MicroPlatform/add', '添加', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('232', 'admin', '1', 'Admin/MicroPlatform/modify', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('233', 'admin', '2', 'Admin/CanYin/index', '微餐饮', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('234', 'admin', '1', 'Admin/Dining/view', '连锁餐厅', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('235', 'admin', '1', 'Admin/DiningRoom/lists', '餐厅信息', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('236', 'admin', '1', 'Admin/FoodCategory/lists', '饭菜分类', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('237', 'admin', '1', 'Admin/Food/lists', '饭菜信息', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('238', 'admin', '1', 'Admin/FoodOrder/lists', '订单信息', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('239', 'admin', '1', 'Admin/FoodWater/lists', '资金流水', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('240', 'admin', '1', 'Admin/MicroPlatform/food', '公众平台', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('241', 'admin', '1', 'Admin/MemberInfo/token', '生成Token', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('242', 'admin', '1', 'Admin/WeixinMenu/food', '微信菜单', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('243', 'admin', '1', 'Admin/WeixinMenu/add', '创建一级菜单', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('244', 'admin', '1', 'Admin/WeixinMenu/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('245', 'admin', '1', 'Admin/WeixinMenu/enable', '启用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('246', 'admin', '1', 'Admin/WeixinMenu/disable', '禁用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('247', 'admin', '1', 'Admin/WeixinMenu/addsubmenu', '创建二级菜单', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('248', 'admin', '1', 'Admin/WeixinMenu/recommend', '一键创建推荐菜单', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('249', 'admin', '1', 'Admin/WeixinMenu/custom', '一键创建自定义菜单', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('250', 'admin', '1', 'Admin/WeixinCard/food', '微信卡劵', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('251', 'admin', '1', 'Admin/FoodOrder/weixinpay', '微信支付订单', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('252', 'admin', '1', 'Admin/FoodWx/warn', '微信告警', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('253', 'admin', '1', 'Admin/FoodWx/Feedback', '微信维权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('254', 'admin', '1', 'Admin/FoodOrder/wxpayview', '查看详细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('255', 'admin', '1', 'Admin/FoodOrder/confirm', '确认送餐', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('256', 'admin', '1', 'Admin/FoodOrder/finish', '确认完成', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('257', 'admin', '1', 'Admin/FoodWxWarn/lists', '微信告警', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('258', 'admin', '1', 'Admin/FoodWxFeedback/lists', '微信维权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('259', 'admin', '1', 'Admin/FoodWxWarn/show', '微信告警', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('260', 'admin', '1', 'Admin/FoodWxFeedback/show', '微信维权', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('261', 'admin', '1', 'Admin/FoodOrder/orderprint', '打印', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('262', 'admin', '1', 'Admin/ChainDining/info', '连锁餐厅', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('263', 'admin', '1', 'Admin/DiningRoom/show', '餐厅信息', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('264', 'admin', '1', 'Admin/DiningRoom/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('265', 'admin', '1', 'Admin/DiningRoom/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('266', 'admin', '1', 'Admin/DiningRoom/enable', '启用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('267', 'admin', '1', 'Admin/DiningRoom/disable', '禁用', '1', '');

-- ----------------------------
-- Table structure for `weiapp_category`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_category`;
CREATE TABLE `weiapp_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of weiapp_category
-- ----------------------------
INSERT INTO `weiapp_category` VALUES ('1', 'blog', '博客', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1382701539', '1', '0');
INSERT INTO `weiapp_category` VALUES ('2', 'default_blog', '默认分类', '1', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1386839751', '1', '31');

-- ----------------------------
-- Table structure for `weiapp_chain_dining`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_chain_dining`;
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

-- ----------------------------
-- Records of weiapp_chain_dining
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_chain_dining_info`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_chain_dining_info`;
CREATE TABLE `weiapp_chain_dining_info` (
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

-- ----------------------------
-- Records of weiapp_chain_dining_info
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_channel`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_channel`;
CREATE TABLE `weiapp_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_channel
-- ----------------------------
INSERT INTO `weiapp_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '0', '0');
INSERT INTO `weiapp_channel` VALUES ('2', '0', '博客', 'Article/index?category=blog', '2', '1379475131', '1423903108', '0', '0');
INSERT INTO `weiapp_channel` VALUES ('3', '0', '使用帮助', 'Help/index', '5', '1379475154', '1424658073', '0', '0');
INSERT INTO `weiapp_channel` VALUES ('4', '0', '联系我们', 'Contact/index', '6', '1423796784', '1423799007', '1', '0');
INSERT INTO `weiapp_channel` VALUES ('5', '0', '案例展示', 'Example/index', '3', '1423796905', '1423796905', '1', '0');
INSERT INTO `weiapp_channel` VALUES ('6', '0', '我要试用', 'Try/index', '4', '1423798986', '1423799028', '1', '0');
INSERT INTO `weiapp_channel` VALUES ('7', '0', '功能介绍', 'Introduce/index', '2', '1423903097', '1423903120', '1', '0');

-- ----------------------------
-- Table structure for `weiapp_config`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_config`;
CREATE TABLE `weiapp_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_config
-- ----------------------------
INSERT INTO `weiapp_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', '微应用', '0');
INSERT INTO `weiapp_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', '微应用,微餐饮', '1');
INSERT INTO `weiapp_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', '微信公众平台,微应用,微餐饮', '8');
INSERT INTO `weiapp_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `weiapp_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `weiapp_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '冀ICP备14009019号', '9');
INSERT INTO `weiapp_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '3');
INSERT INTO `weiapp_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `weiapp_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `weiapp_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', '4');
INSERT INTO `weiapp_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `weiapp_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `weiapp_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `weiapp_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `weiapp_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '10');
INSERT INTO `weiapp_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `weiapp_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `weiapp_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `weiapp_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `weiapp_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `weiapp_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `weiapp_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `weiapp_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `weiapp_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `weiapp_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '0');
INSERT INTO `weiapp_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `weiapp_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '1', '1');

-- ----------------------------
-- Table structure for `weiapp_dining_envelope_config`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_envelope_config`;
CREATE TABLE `weiapp_dining_envelope_config` (
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

-- ----------------------------
-- Records of weiapp_dining_envelope_config
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_dining_envelope_info`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_envelope_info`;
CREATE TABLE `weiapp_dining_envelope_info` (
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

-- ----------------------------
-- Records of weiapp_dining_envelope_info
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_dining_reserve`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_reserve`;
CREATE TABLE `weiapp_dining_reserve` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid对应member表wx_openid',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `user_name` varchar(30) NOT NULL DEFAULT '' COMMENT '联系人',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `num` smallint(6) NOT NULL DEFAULT '0' COMMENT '用餐人数',
  `use_setmenu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是套餐活动预定如年夜饭0否1是',
  `setmenu_id` int(11) NOT NULL DEFAULT '0' COMMENT '套餐id',
  `reserve_name` varchar(128) NOT NULL DEFAULT '' COMMENT '预定活动名',
  `meal_time` int(11) NOT NULL DEFAULT '0' COMMENT '用餐时间',
  `pay_deposit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否需要支付押金0否1是',
  `deposit_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '押金金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态1有效0无效',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '接受预定开始时间(套餐)',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '接受预定结束时间(套餐)',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='到店用餐预定';

-- ----------------------------
-- Records of weiapp_dining_reserve
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_dining_room`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_room`;
CREATE TABLE `weiapp_dining_room` (
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

-- ----------------------------
-- Records of weiapp_dining_room
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_dining_room_detail`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_room_detail`;
CREATE TABLE `weiapp_dining_room_detail` (
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

-- ----------------------------
-- Records of weiapp_dining_room_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_dining_setmenu`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_setmenu`;
CREATE TABLE `weiapp_dining_setmenu` (
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

-- ----------------------------
-- Records of weiapp_dining_setmenu
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_dining_setmenu_detail`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_setmenu_detail`;
CREATE TABLE `weiapp_dining_setmenu_detail` (
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

-- ----------------------------
-- Records of weiapp_dining_setmenu_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_document`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_document`;
CREATE TABLE `weiapp_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of weiapp_document
-- ----------------------------
INSERT INTO `weiapp_document` VALUES ('1', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '25', '0', '0', '0', '1387260660', '1387263112', '1');

-- ----------------------------
-- Table structure for `weiapp_document_article`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_document_article`;
CREATE TABLE `weiapp_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of weiapp_document_article
-- ----------------------------
INSERT INTO `weiapp_document_article` VALUES ('1', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');

-- ----------------------------
-- Table structure for `weiapp_document_download`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_document_download`;
CREATE TABLE `weiapp_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of weiapp_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_file`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_file`;
CREATE TABLE `weiapp_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of weiapp_file
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food`;
CREATE TABLE `weiapp_food` (
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

-- ----------------------------
-- Records of weiapp_food
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_car`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_car`;
CREATE TABLE `weiapp_food_car` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id对应member表id',
  `content` text NOT NULL COMMENT '购餐车内容存json',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐车';

-- ----------------------------
-- Records of weiapp_food_car
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_category`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_category`;
CREATE TABLE `weiapp_food_category` (
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

-- ----------------------------
-- Records of weiapp_food_category
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_detail`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_detail`;
CREATE TABLE `weiapp_food_detail` (
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

-- ----------------------------
-- Records of weiapp_food_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_money_water`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_money_water`;
CREATE TABLE `weiapp_food_money_water` (
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

-- ----------------------------
-- Records of weiapp_food_money_water
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_order`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_order`;
CREATE TABLE `weiapp_food_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '购餐用户id对应member表id',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `dining_member_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅负责人id对应member表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `order_no` varchar(32) NOT NULL DEFAULT '' COMMENT '订单编号',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '订单类型:1在餐厅下单用餐2线上订餐配送到家',
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

-- ----------------------------
-- Records of weiapp_food_order
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_order_detail`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_order_detail`;
CREATE TABLE `weiapp_food_order_detail` (
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

-- ----------------------------
-- Records of weiapp_food_order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_style`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_style`;
CREATE TABLE `weiapp_food_style` (
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

-- ----------------------------
-- Records of weiapp_food_style
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_wx_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_wx_feedback`;
CREATE TABLE `weiapp_food_wx_feedback` (
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

-- ----------------------------
-- Records of weiapp_food_wx_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_wx_notify`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_wx_notify`;
CREATE TABLE `weiapp_food_wx_notify` (
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

-- ----------------------------
-- Records of weiapp_food_wx_notify
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_wx_order`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_wx_order`;
CREATE TABLE `weiapp_food_wx_order` (
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

-- ----------------------------
-- Records of weiapp_food_wx_order
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_wx_warn`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_wx_warn`;
CREATE TABLE `weiapp_food_wx_warn` (
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

-- ----------------------------
-- Records of weiapp_food_wx_warn
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_hooks`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_hooks`;
CREATE TABLE `weiapp_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_hooks
-- ----------------------------
INSERT INTO `weiapp_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '');
INSERT INTO `weiapp_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop');
INSERT INTO `weiapp_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment');
INSERT INTO `weiapp_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment');
INSERT INTO `weiapp_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `weiapp_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment');
INSERT INTO `weiapp_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor');
INSERT INTO `weiapp_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `weiapp_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam');
INSERT INTO `weiapp_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor');
INSERT INTO `weiapp_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '');

-- ----------------------------
-- Table structure for `weiapp_member`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member`;
CREATE TABLE `weiapp_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of weiapp_member
-- ----------------------------
INSERT INTO `weiapp_member` VALUES ('1', 'admin_wangzi', '0', '0000-00-00', '', '110', '92', '0', '1423289473', '2130706433', '1425997916', '1');
INSERT INTO `weiapp_member` VALUES ('2', 'tonbochow', '0', '0000-00-00', '', '60', '70', '0', '0', '2130706433', '1425998065', '1');

-- ----------------------------
-- Table structure for `weiapp_member_address`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member_address`;
CREATE TABLE `weiapp_member_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id关联member表id',
  `real_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '手机',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固定电话',
  `province` int(11) NOT NULL DEFAULT '0' COMMENT '省id',
  `city` int(11) NOT NULL DEFAULT '0' COMMENT '市id',
  `town` int(11) NOT NULL DEFAULT '0' COMMENT '县id',
  `address` varchar(256) NOT NULL DEFAULT '' COMMENT '详细地址',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认地址1是0否',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1可用0不可用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_member_address
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_member_info`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member_info`;
CREATE TABLE `weiapp_member_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id对应member表uid',
  `real_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户真实姓名',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '用户手机号码',
  `app_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '微应用类型1餐饮2摄影3ktv等',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户申请平台类型0试用1正式使用',
  `introduce` varchar(256) NOT NULL DEFAULT '' COMMENT '用户申请简单介绍',
  `token_created` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已创建token(预先生成平台token等)0否1是',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0未通过1通过',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '微应用开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '微应用结束时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id` (`member_id`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='用户详细信息';

-- ----------------------------
-- Records of weiapp_member_info
-- ----------------------------
INSERT INTO `weiapp_member_info` VALUES ('31', '1', '周东宝', '12333453321', '1', '0', '测试微餐饮', '0', '0', '0', '0', '1424674327', '0');
INSERT INTO `weiapp_member_info` VALUES ('32', '12', '周东宝二', '12333455555', '1', '0', '测试微餐饮', '0', '0', '1424925480', '1427344680', '1424674327', '1425028005');
INSERT INTO `weiapp_member_info` VALUES ('33', '3', '周东宝3', '12333453324', '1', '0', '测试微餐饮', '0', '0', '1424839114', '1426135114', '1424674327', '1424839259');
INSERT INTO `weiapp_member_info` VALUES ('34', '4', '周东宝4', '12333453325', '1', '0', '测试微餐饮', '0', '0', '0', '0', '1424674329', '0');
INSERT INTO `weiapp_member_info` VALUES ('35', '5', '周东宝5', '12333453326', '1', '0', '测试微餐饮', '0', '0', '0', '0', '1424674323', '0');
INSERT INTO `weiapp_member_info` VALUES ('36', '6', '周东宝6', '12333453327', '1', '0', '测试微餐饮', '0', '0', '0', '0', '1424674324', '0');
INSERT INTO `weiapp_member_info` VALUES ('37', '7', '周东宝7', '12333453332', '1', '0', '测试微餐饮', '0', '0', '0', '0', '1424674232', '0');
INSERT INTO `weiapp_member_info` VALUES ('38', '8', '周东宝8', '12333453676', '1', '0', '测试微餐饮', '0', '0', '0', '0', '1424674245', '1424839225');
INSERT INTO `weiapp_member_info` VALUES ('39', '9', '周东宝9', '12333453672', '1', '0', '测试微餐饮', '0', '0', '1424839216', '1426135216', '1424674298', '1424839245');
INSERT INTO `weiapp_member_info` VALUES ('40', '10', '周东宝10', '12333453679', '1', '0', '测试微餐饮', '0', '0', '1424839216', '1426135216', '1424674299', '1424839259');
INSERT INTO `weiapp_member_info` VALUES ('41', '11', '周东宝11', '12333453670', '1', '0', '测试微餐饮', '0', '0', '1424839216', '1426135216', '1424674292', '1424936977');
INSERT INTO `weiapp_member_info` VALUES ('43', '2', '周王梓', '15133293464', '1', '0', '保定饭店', '1', '1', '1424836943', '1427256143', '1424756626', '1425029078');

-- ----------------------------
-- Table structure for `weiapp_member_weixin`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member_weixin`;
CREATE TABLE `weiapp_member_weixin` (
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

-- ----------------------------
-- Records of weiapp_member_weixin
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_member_weixin_group`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member_weixin_group`;
CREATE TABLE `weiapp_member_weixin_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `group_name` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户分组名',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信用户分组id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信用户分组创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '微信用户分组更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信用户分组';

-- ----------------------------
-- Records of weiapp_member_weixin_group
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_menu`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_menu`;
CREATE TABLE `weiapp_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_menu
-- ----------------------------
INSERT INTO `weiapp_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('2', '内容', '0', '2', 'Article/mydocument', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0');
INSERT INTO `weiapp_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0');
INSERT INTO `weiapp_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('16', '用户', '0', '3', 'User/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `weiapp_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0');
INSERT INTO `weiapp_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '0', '', '行为管理', '0');
INSERT INTO `weiapp_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `weiapp_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `weiapp_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `weiapp_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `weiapp_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `weiapp_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `weiapp_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `weiapp_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `weiapp_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `weiapp_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `weiapp_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `weiapp_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `weiapp_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `weiapp_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `weiapp_menu` VALUES ('43', '扩展', '0', '7', 'Addons/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展', '0');
INSERT INTO `weiapp_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `weiapp_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `weiapp_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `weiapp_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `weiapp_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `weiapp_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `weiapp_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `weiapp_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `weiapp_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `weiapp_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `weiapp_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `weiapp_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展', '0');
INSERT INTO `weiapp_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0');
INSERT INTO `weiapp_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0');
INSERT INTO `weiapp_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('68', '系统', '0', '4', 'Config/group', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `weiapp_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0');
INSERT INTO `weiapp_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `weiapp_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `weiapp_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `weiapp_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `weiapp_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0');
INSERT INTO `weiapp_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `weiapp_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('80', '分类管理', '68', '2', 'Category/index', '0', '', '系统设置', '0');
INSERT INTO `weiapp_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `weiapp_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `weiapp_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `weiapp_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `weiapp_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `weiapp_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `weiapp_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `weiapp_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `weiapp_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `weiapp_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `weiapp_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `weiapp_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `weiapp_menu` VALUES ('93', '其他', '0', '5', 'other', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `weiapp_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0');
INSERT INTO `weiapp_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('122', '微餐饮后台', '0', '8', 'Catering/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('123', '试用申请管理', '122', '0', 'MemberInfo/apply', '0', '', '微餐饮公众平台管理', '0');
INSERT INTO `weiapp_menu` VALUES ('124', '微信公众平台列表管理', '122', '0', 'MicroPlatform/index', '0', '', '微餐饮公众平台管理', '0');
INSERT INTO `weiapp_menu` VALUES ('125', '连锁餐厅管理', '122', '1', 'Dining/index', '0', '', '微餐厅管理', '0');
INSERT INTO `weiapp_menu` VALUES ('126', '餐厅列表管理', '122', '1', 'DiningRoom/index', '0', '', '微餐厅管理', '0');
INSERT INTO `weiapp_menu` VALUES ('127', '饭菜分类列表管理', '122', '2', 'FoodCategory/index', '0', '', '微饭菜分类管理', '0');
INSERT INTO `weiapp_menu` VALUES ('128', '饭菜列表管理', '122', '2', 'Food/index', '0', '', '微饭菜管理', '0');
INSERT INTO `weiapp_menu` VALUES ('129', '订单列表管理', '122', '2', 'FoodOrder/index', '0', '', '微餐饮订单管理', '0');
INSERT INTO `weiapp_menu` VALUES ('130', '微信公众平台菜单管理', '122', '0', 'PlatformMenu/index', '0', '', '微餐饮公众平台管理', '0');
INSERT INTO `weiapp_menu` VALUES ('131', '编辑', '123', '0', 'MemberInfo/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('132', '删除', '123', '0', 'MemberInfo/delete', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('133', '通过', '123', '0', 'MemberInfo/allow', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('134', '禁用', '123', '0', 'MemberInfo/deny', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('135', '微餐饮', '0', '9', 'CanYin/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('136', '公众平台', '135', '0', 'MicroPlatform/food', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('137', '添加', '136', '0', 'MicroPlatform/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('138', '编辑', '136', '0', 'MicroPlatform/modify', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('139', '连锁餐厅', '135', '0', 'ChainDining/info', '0', '', '微餐厅', '0');
INSERT INTO `weiapp_menu` VALUES ('140', '餐厅信息', '135', '0', 'DiningRoom/show', '0', '', '微餐厅', '0');
INSERT INTO `weiapp_menu` VALUES ('141', '饭菜分类', '135', '0', 'FoodCategory/lists', '0', '', '微饭菜分类', '0');
INSERT INTO `weiapp_menu` VALUES ('142', '饭菜信息', '135', '0', 'Food/lists', '0', '', '微饭菜', '0');
INSERT INTO `weiapp_menu` VALUES ('143', '订单信息', '135', '0', 'FoodOrder/lists', '0', '', '微餐饮订单', '0');
INSERT INTO `weiapp_menu` VALUES ('144', '资金流水', '135', '0', 'FoodWater/lists', '0', '', '微餐饮流水', '0');
INSERT INTO `weiapp_menu` VALUES ('145', '生成Token', '123', '0', 'MemberInfo/token', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('146', '微信菜单', '135', '0', 'WeixinMenu/food', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('147', '创建一级菜单', '146', '0', 'WeixinMenu/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('148', '编辑', '146', '0', 'WeixinMenu/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('149', '启用', '146', '0', 'WeixinMenu/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('150', '禁用', '146', '0', 'WeixinMenu/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('151', '创建二级菜单', '146', '0', 'WeixinMenu/addsubmenu', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('152', '一键创建推荐菜单', '146', '0', 'WeixinMenu/recommend', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('153', '一键创建自定义菜单', '146', '0', 'WeixinMenu/custom', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('154', '微信卡劵', '135', '0', 'WeixinCard/food', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('155', '微信支付订单', '135', '0', 'FoodOrder/weixinpay', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('156', '微信告警', '135', '0', 'FoodWxWarn/show', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('157', '微信维权', '135', '0', 'FoodWxFeedback/show', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('158', '查看详细', '155', '0', 'FoodOrder/wxpayview', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('159', '确认送餐', '155', '0', 'FoodOrder/confirm', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('160', '确认完成', '155', '0', 'FoodOrder/finish', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('161', '打印', '155', '0', 'FoodOrder/orderprint', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('162', '创建', '140', '0', 'DiningRoom/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('163', '编辑', '140', '0', 'DiningRoom/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('164', '启用', '140', '0', 'DiningRoom/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('165', '禁用', '140', '0', 'DiningRoom/disable', '1', '', '', '0');

-- ----------------------------
-- Table structure for `weiapp_micro_platform`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_micro_platform`;
CREATE TABLE `weiapp_micro_platform` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='微信公众平台';

-- ----------------------------
-- Records of weiapp_micro_platform
-- ----------------------------
INSERT INTO `weiapp_micro_platform` VALUES ('1', 'wx571d493fc32f0ba4', '6677a350c853729910c9481dab475570', '', '', '', 'local.weiapp.com/Mobile/Base/weixin/token/91692FB7569443A68D7C357488CB54C2', '91692FB7569443A68D7C357488CB54C2', '1', 'gh_dde71cd2712f', '邻购网', 'LINGOU5106', '/Uploads/Mp/1/info/mp_qrcode.jpg', '/Uploads/Mp/1/info/mp_img.jpg', '0', '', '1425869162', '2', '', '0', '0', '1', '1', '1', '1', '1', '0.00', '1425285691', '1534543454', '0', '1425994798');

-- ----------------------------
-- Table structure for `weiapp_model`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_model`;
CREATE TABLE `weiapp_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of weiapp_model
-- ----------------------------
INSERT INTO `weiapp_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `weiapp_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `weiapp_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');

-- ----------------------------
-- Table structure for `weiapp_picture`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_picture`;
CREATE TABLE `weiapp_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_picture
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_recharge_water`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_recharge_water`;
CREATE TABLE `weiapp_recharge_water` (
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

-- ----------------------------
-- Records of weiapp_recharge_water
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_red_envelope`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_red_envelope`;
CREATE TABLE `weiapp_red_envelope` (
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

-- ----------------------------
-- Records of weiapp_red_envelope
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_send_message`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_send_message`;
CREATE TABLE `weiapp_send_message` (
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

-- ----------------------------
-- Records of weiapp_send_message
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_ucenter_admin`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_admin`;
CREATE TABLE `weiapp_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of weiapp_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_ucenter_app`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_app`;
CREATE TABLE `weiapp_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of weiapp_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_ucenter_member`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_member`;
CREATE TABLE `weiapp_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of weiapp_ucenter_member
-- ----------------------------
INSERT INTO `weiapp_ucenter_member` VALUES ('1', 'admin_wangzi', 'e02aee9ace52823b94166d3980c70d4b', 'tonbochow@qq.com', '', '1423289473', '2130706433', '1425997916', '2130706433', '1423289473', '1');
INSERT INTO `weiapp_ucenter_member` VALUES ('2', 'tonbochow', 'e02aee9ace52823b94166d3980c70d4b', 'tonbochow@163.com', '', '1424704411', '2130706433', '1425998065', '2130706433', '1424704411', '1');

-- ----------------------------
-- Table structure for `weiapp_ucenter_setting`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_setting`;
CREATE TABLE `weiapp_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of weiapp_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_url`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_url`;
CREATE TABLE `weiapp_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of weiapp_url
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_userdata`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_userdata`;
CREATE TABLE `weiapp_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_userdata
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_weixin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_weixin_menu`;
CREATE TABLE `weiapp_weixin_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id',
  `menu_type` varchar(128) NOT NULL DEFAULT '' COMMENT '菜单类型：click  view pic_photo_or_album等',
  `menu_name` varchar(60) NOT NULL DEFAULT '' COMMENT '菜单名称(中文最多7个字)',
  `menu_key` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单key值',
  `menu_url` varchar(256) NOT NULL DEFAULT '' COMMENT '菜单url(仅view类型需要)',
  `menu_content` varchar(256) NOT NULL DEFAULT '' COMMENT 'click类型菜单自定义的回复内容',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `c_order` tinyint(2) NOT NULL DEFAULT '1' COMMENT '菜单顺序1-5',
  `p_order` tinyint(2) NOT NULL DEFAULT '1' COMMENT '父菜单顺序1-3',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '菜单状态1启用0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='微信公众平台菜单';

-- ----------------------------
-- Records of weiapp_weixin_menu
-- ----------------------------
INSERT INTO `weiapp_weixin_menu` VALUES ('20', '1', '2', 'click', '点菜*预定', '', '', '', '0', '1', '1', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('21', '1', '2', 'view', '全部菜品', '', 'http://www.52gdp.com/Mobile/food/list/token/91692FB7569443A68D7C357488CB54C2', '', '20', '1', '1', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('22', '1', '2', 'view', '热销菜品', '', 'http://www.52gdp.com/Mobile/food/hot/token/91692FB7569443A68D7C357488CB54C2', '', '20', '2', '1', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('23', '1', '2', 'view', '特色菜品', '', 'http://www.52gdp.com/Mobile/food/features/token/91692FB7569443A68D7C357488CB54C2', '', '20', '3', '1', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('24', '1', '2', 'view', '优惠套餐', '', 'http://www.52gdp.com/Mobile/food/cheap/token/91692FB7569443A68D7C357488CB54C2', '', '20', '4', '1', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('25', '1', '2', 'view', '我要预定', '', 'http://www.52gdp.com/Mobile/reserve/index/token/91692FB7569443A68D7C357488CB54C2', '', '20', '5', '1', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('26', '1', '2', 'click', '品牌|优惠券', '', '', '', '0', '1', '2', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('27', '1', '2', 'click', '关于我们', '', 'abouts', '', '26', '1', '2', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('28', '1', '2', 'click', '联系我们', '', 'contact', '', '26', '2', '2', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('29', '1', '2', 'click', '餐厅浏览', '', 'dining', '', '26', '3', '2', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('30', '1', '2', 'click', '热门活动', '', 'active', '', '26', '4', '2', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('31', '1', '2', 'view', '领取优惠券', '', 'http://www.52gdp.com/Mobile/card/index/token/91692FB7569443A68D7C357488CB54C2', '', '26', '5', '2', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('32', '1', '2', 'click', '个人中心', '', '', '', '0', '1', '3', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('33', '1', '2', 'view', '已领取的卡劵', '', 'http://www.52gdp.com/Mobile/card/list/token/91692FB7569443A68D7C357488CB54C2', '', '32', '1', '3', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('34', '1', '2', 'view', '我的预定', '', 'http://www.52gdp.com/Mobile/reserve/list/token/91692FB7569443A68D7C357488CB54C2', '', '32', '2', '3', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('35', '1', '2', 'view', '我的订单', '', 'http://www.52gdp.com/Mobile/order/list/token/91692FB7569443A68D7C357488CB54C2', '', '32', '3', '3', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('36', '1', '2', 'view', '我的会员卡', '', 'http://www.52gdp.com/Mobile/card/list/token/91692FB7569443A68D7C357488CB54C2', '', '32', '4', '3', '1', '1425625669', '1425625669');
INSERT INTO `weiapp_weixin_menu` VALUES ('37', '1', '2', 'view', '我要说说', '', 'http://www.52gdp.com/Mobile/comment/index/token/91692FB7569443A68D7C357488CB54C2', '', '32', '5', '3', '1', '1425625669', '1425625669');
