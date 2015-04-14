/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : weiapp

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2015-04-14 17:24:45
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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of weiapp_action_log
-- ----------------------------
INSERT INTO `weiapp_action_log` VALUES ('1', '1', '2', '2130706433', 'member', '2', 'tonbochow在2015-04-14 09:57登录了后台', '1', '1428976633');
INSERT INTO `weiapp_action_log` VALUES ('2', '1', '2', '2130706433', 'member', '2', 'tonbochow在2015-04-14 10:06登录了后台', '1', '1428977211');
INSERT INTO `weiapp_action_log` VALUES ('3', '1', '1', '2130706433', 'member', '1', 'admin_wangzi在2015-04-14 10:07登录了后台', '1', '1428977259');
INSERT INTO `weiapp_action_log` VALUES ('4', '1', '2', '2130706433', 'member', '2', 'tonbochow在2015-04-14 10:21登录了后台', '1', '1428978103');

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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_auth_group
-- ----------------------------
INSERT INTO `weiapp_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '', '1', '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106');
INSERT INTO `weiapp_auth_group` VALUES ('2', 'admin', '1', '测试用户', '测试用户', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');
INSERT INTO `weiapp_auth_group` VALUES ('3', 'admin', '1', '微餐饮', 'food', '1', '1,231,232,233,240,242,243,244,245,246,247,248,249,255,256,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,314,324,325,326,328,329,330,331,334,335,336,337');
INSERT INTO `weiapp_auth_group` VALUES ('4', 'admin', '1', '微餐饮店员', 'food_member', '1', '');

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
) ENGINE=MyISAM AUTO_INCREMENT=338 DEFAULT CHARSET=utf8;

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
INSERT INTO `weiapp_auth_rule` VALUES ('219', 'admin', '1', 'Admin/PlatformMenu/index', '微信公众平台菜单管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Dining/index', '连锁餐厅管理', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('221', 'admin', '1', 'Admin/DiningRoom/index', '餐厅列表管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('222', 'admin', '1', 'Admin/FoodCategory/index', '菜品分类列表管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('223', 'admin', '1', 'Admin/Food/index', '菜品列表管理', '1', '');
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
INSERT INTO `weiapp_auth_rule` VALUES ('236', 'admin', '1', 'Admin/FoodCategory/lists', '菜品分类', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('237', 'admin', '1', 'Admin/Food/lists', '菜品信息', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('238', 'admin', '1', 'Admin/FoodOrder/lists', '订单信息', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('239', 'admin', '1', 'Admin/FoodWater/lists', '资金流水', '-1', '');
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
INSERT INTO `weiapp_auth_rule` VALUES ('250', 'admin', '1', 'Admin/WeixinCard/food', '微信卡劵', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('251', 'admin', '1', 'Admin/FoodOrder/weixinpay', '微信支付订单', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('252', 'admin', '1', 'Admin/FoodWx/warn', '微信告警', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('253', 'admin', '1', 'Admin/FoodWx/Feedback', '微信维权', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('254', 'admin', '1', 'Admin/FoodOrder/wxpayview', '查看详细', '-1', '');
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
INSERT INTO `weiapp_auth_rule` VALUES ('268', 'admin', '1', 'Admin/DiningRoom/getRegion', '获取省市县', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('269', 'admin', '1', 'Admin/DiningRoom/detail', '设置详细(图片)', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('270', 'admin', '1', 'Admin/DiningMember/show', '餐厅员工', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('271', 'admin', '1', 'Admin/DiningMember/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('272', 'admin', '1', 'Admin/DiningMember/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('273', 'admin', '1', 'Admin/DiningMember/enable', '启用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('274', 'admin', '1', 'Admin/DiningMember/disable', '禁用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('275', 'admin', '1', 'Admin/FoodCategory/show', '菜品分类', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('276', 'admin', '1', 'Admin/Food/show', '菜品信息', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('277', 'admin', '1', 'Admin/FoodOrder/show', '订单信息', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('278', 'admin', '1', 'Admin/FoodWater/show', '资金流水', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('279', 'admin', '1', 'Admin/FoodCategory/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('280', 'admin', '1', 'Admin/FoodCategory/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('281', 'admin', '1', 'Admin/FoodCategory/enable', '启用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('282', 'admin', '1', 'Admin/FoodCategory/disable', '禁用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('283', 'admin', '1', 'Admin/Food/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('284', 'admin', '1', 'Admin/Food/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('285', 'admin', '1', 'Admin/Food/enable', '上架', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('286', 'admin', '1', 'Admin/Food/disable', '下架', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('287', 'admin', '1', 'Admin/Food/detail', '详细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('288', 'admin', '1', 'Admin/Food/cate', '获取餐厅菜品分类', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('289', 'admin', '1', 'Admin/Food/share', '设置微信分享图片', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('290', 'admin', '1', 'Admin/FoodStyle/show', '菜品风格', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('291', 'admin', '1', 'Admin/FoodStyle/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('292', 'admin', '1', 'Admin/FoodStyle/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('293', 'admin', '1', 'Admin/FoodStyle/enable', '启用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('294', 'admin', '1', 'Admin/FoodStyle/disable', '禁用', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('295', 'admin', '1', 'Admin/DiningReserve/show', '客户预定', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('296', 'admin', '1', 'Admin/FoodOrder/view', '查看详细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('297', 'admin', '1', 'Admin/DiningReserve/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('298', 'admin', '1', 'Admin/DiningReserve/confirm', '确认预定', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('299', 'admin', '1', 'Admin/DiningReserve/finish', '完成预定', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('300', 'admin', '1', 'Admin/DiningReserve/cancel', '取消预定', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('301', 'admin', '1', 'Admin/DiningReserve/drop', '作废预定', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('302', 'admin', '1', 'Admin/FoodSetmenu/show', '菜品套餐', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('303', 'admin', '1', 'Admin/FoodSetmenu/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('304', 'admin', '1', 'Admin/FoodSetmenu/edit', '编辑', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('305', 'admin', '1', 'Admin/FoodSetmenu/up', '上架', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('306', 'admin', '1', 'Admin/FoodSetmenu/down', '下架', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('307', 'admin', '1', 'Admin/FoodSetmenu/addfood', '添加明细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('308', 'admin', '1', 'Admin/FoodSetmenu/editfood', '编辑明细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('309', 'admin', '1', 'Admin/FoodSetmenu/enable', '启用明细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('310', 'admin', '1', 'Admin/FoodSetmenu/disable', '禁用明细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('311', 'admin', '1', 'Admin/FoodSetmenu/view', '查看', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('312', 'admin', '1', 'Admin/FoodWater/csv', '导出EXCEL', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('313', 'admin', '1', 'Admin/WeixinMenu/index', '微信公众平台菜单管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('314', 'admin', '1', 'Admin/WeixinCard/show', '微信卡劵', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('315', 'admin', '1', 'Admin/MicroPlatform/detail', '详细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('316', 'admin', '1', 'Admin/FoodWxWarn/index', '微餐饮告警管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('317', 'admin', '1', 'Admin/FoodWxFeedback/index', '微餐饮维权管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('318', 'admin', '1', 'Admin/FoodWater/index', '资金流水管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('319', 'admin', '1', 'Admin/ChainDining/index', '连锁餐厅管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('320', 'admin', '1', 'Admin/DiningMember/index', '餐厅员工管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('321', 'admin', '1', 'Admin/FoodStyle/index', '菜品风格管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('322', 'admin', '1', 'Admin/FoodSetmenu/index', '菜品套餐管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('323', 'admin', '1', 'Admin/DiningReserve/index', '客户预定管理', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('324', 'admin', '1', 'Admin/WeixinCard/uploadlogo', '上传卡劵logo', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('325', 'admin', '1', 'Admin/WeixinCard/add', '创建', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('326', 'admin', '1', 'Admin/WeixinCard/batchuse', '批量投放', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('327', 'admin', '1', 'Admin/WeixinCard/batchdestroy', '批量核销', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('328', 'admin', '1', 'Admin/WeixinCard/batchdelete', '批量删除', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('329', 'admin', '1', 'Admin/WeixinCard/batchdisable', '批量失效', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('330', 'admin', '1', 'Admin/WeixinCard/modifystock', '修改库存', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('331', 'admin', '1', 'Admin/WeixinCard/destroy', '核销', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('332', 'admin', '1', 'Admin/WeixinCard/qrcode', '生成推广二维码', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('333', 'admin', '1', 'Admin/WeixinCard/detail', '详细', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('334', 'admin', '1', 'Admin/FoodComment/show', '菜品套餐评论', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('335', 'admin', '1', 'Admin/FoodComment/enable', '显示', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('336', 'admin', '1', 'Admin/FoodComment/disable', '隐藏', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('337', 'admin', '1', 'Admin/FoodComment/detail', '查看', '1', '');

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
-- Table structure for `weiapp_dining_member`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_dining_member`;
CREATE TABLE `weiapp_dining_member` (
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

-- ----------------------------
-- Records of weiapp_dining_member
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
  `user_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '用餐人数',
  `meal_time` int(11) NOT NULL DEFAULT '0' COMMENT '用餐时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态-2已作废-1已取消1已提交2已确认3已完成',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '预定简单描述',
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
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型：3餐厅用餐和配送到家1餐厅用餐2配送到家',
  `pay_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付方式:1微信2支付宝3线下付款4微信支付和线下付款',
  `delivery_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '送餐费用',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `province` int(11) NOT NULL DEFAULT '0' COMMENT '省id',
  `city` int(11) NOT NULL DEFAULT '0' COMMENT '市id',
  `town` int(11) NOT NULL DEFAULT '0' COMMENT '县id',
  `address` varchar(256) NOT NULL DEFAULT '' COMMENT '详细地址',
  `longitude` decimal(17,14) NOT NULL DEFAULT '0.00000000000000' COMMENT '经度',
  `latitude` decimal(17,14) NOT NULL DEFAULT '0.00000000000000' COMMENT '纬度',
  `description` text NOT NULL COMMENT '连锁餐厅描述',
  `wechat_name` varchar(32) NOT NULL DEFAULT '' COMMENT '餐厅服务微信号',
  `service_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '餐厅服务微信号对应的opendi对应member_weixin.wx_openid',
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
  `url` varchar(256) NOT NULL DEFAULT '' COMMENT '图片或微视url',
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
  `stock` decimal(10,2) NOT NULL DEFAULT '-1.00' COMMENT '库存',
  `description` text NOT NULL COMMENT '描述',
  `view_times` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `comment_times` int(11) NOT NULL DEFAULT '0' COMMENT '评论次数',
  `favorite_times` int(11) NOT NULL DEFAULT '0' COMMENT '收藏次数',
  `sell_count` int(11) NOT NULL DEFAULT '0' COMMENT '销售数量',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热销饭菜1是0否',
  `is_promotion` tinyint(1) NOT NULL DEFAULT '0' COMMENT '促销饭菜1是0否',
  `style_id` tinyint(4) NOT NULL DEFAULT '0' COMMENT '饭菜风格id',
  `style_name` varchar(20) NOT NULL DEFAULT '' COMMENT '饭菜风格(酸甜辣)sphinx模糊搜索用',
  `is_offline` tinyint(1) NOT NULL DEFAULT '1' COMMENT '餐到付款1允许0禁止',
  `use_envelope` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许用红包1允许0禁止',
  `red_envelope_percent` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用红包百分比',
  `use_card` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否允许使用卡卷1允许0禁止',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `share_title` varchar(60) NOT NULL DEFAULT '' COMMENT '微信内分享显示标题',
  `share_desc` varchar(128) NOT NULL DEFAULT '' COMMENT '微信内分享描述',
  `share_imgurl` varchar(255) NOT NULL DEFAULT '' COMMENT '微信内分享图片url',
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
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `mp_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐车';

-- ----------------------------
-- Records of weiapp_food_car
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_car_detail`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_car_detail`;
CREATE TABLE `weiapp_food_car_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `car_id` int(10) NOT NULL DEFAULT '0' COMMENT '购餐车id',
  `mp_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信公众平台',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `dining_room_id` int(10) NOT NULL DEFAULT '0' COMMENT '菜品所属餐厅id',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型:1菜品2套餐',
  `food_setmenu_id` int(10) NOT NULL DEFAULT '0' COMMENT '菜品或套餐id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '菜品或套餐名次',
  `count` int(10) NOT NULL DEFAULT '0' COMMENT '菜品或套餐数量',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '菜品或套餐单价',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '菜品或套餐总金额',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购餐车明细表';

-- ----------------------------
-- Records of weiapp_food_car_detail
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
-- Table structure for `weiapp_food_comment`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_comment`;
CREATE TABLE `weiapp_food_comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜品评论表主键',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '评论用户id',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `mp_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信公众平台id',
  `food_setmenu_id` int(10) NOT NULL DEFAULT '0' COMMENT '评论菜品或套餐id',
  `food_setmenu_name` varchar(30) NOT NULL DEFAULT '' COMMENT '菜品或套餐名称',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型1菜品2套餐',
  `comment` text NOT NULL COMMENT '评论内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '评论状态1显示0隐藏',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '评论时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信用户购买完后菜品或套餐评论';

-- ----------------------------
-- Records of weiapp_food_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_detail`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_detail`;
CREATE TABLE `weiapp_food_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `food_id` int(11) NOT NULL DEFAULT '0' COMMENT '饭菜id对应food表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `ext_type` varchar(20) NOT NULL DEFAULT '' COMMENT '附件类型',
  `ext_fileid` char(32) NOT NULL DEFAULT '' COMMENT '图片或者微视的md5值',
  `url` varchar(256) NOT NULL DEFAULT '' COMMENT '图片或微视url',
  `input_name` varchar(32) NOT NULL DEFAULT '' COMMENT '表单字段名称',
  `default_share` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认微信分享图片',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1有效0无效',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
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
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `dining_member_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅负责人id对应member表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `pay_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付方式1微信2支付吧',
  `order_no` varchar(32) NOT NULL DEFAULT '' COMMENT '订单order_no对应food_order表order_no',
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
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `dining_member_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅负责人id对应member表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单id对应food_order表id',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型:1菜品2套餐',
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
-- Table structure for `weiapp_food_setmenu`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_setmenu`;
CREATE TABLE `weiapp_food_setmenu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建菜品套餐用户)',
  `dining_room_id` int(11) NOT NULL DEFAULT '0' COMMENT '餐厅id(对应dining_room.id)',
  `setmenu_name` varchar(30) NOT NULL DEFAULT '' COMMENT '套餐名',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '套餐描述',
  `use_card` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否允许使用优惠券0禁止1允许',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '套餐应付总价',
  `setmenu_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '套餐优惠价',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '套餐默认图片',
  `sell_count` int(10) NOT NULL DEFAULT '0' COMMENT '销售数量',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '套餐状态1上架0下架',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜品套餐';

-- ----------------------------
-- Records of weiapp_food_setmenu
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_setmenu_detail`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_setmenu_detail`;
CREATE TABLE `weiapp_food_setmenu_detail` (
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

-- ----------------------------
-- Records of weiapp_food_setmenu_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_food_style`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_food_style`;
CREATE TABLE `weiapp_food_style` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联用户表member的主键id(创建餐厅用户)',
  `name` varchar(256) NOT NULL DEFAULT '' COMMENT '风格名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1有效0无效',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜品风格';

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
INSERT INTO `weiapp_member` VALUES ('1', 'admin_wangzi', '0', '0000-00-00', '', '220', '117', '0', '1423289473', '2130706433', '1428977259', '1');
INSERT INTO `weiapp_member` VALUES ('2', 'tonbochow', '0', '0000-00-00', '', '220', '146', '0', '0', '2130706433', '1428978103', '1');

-- ----------------------------
-- Table structure for `weiapp_member_address`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member_address`;
CREATE TABLE `weiapp_member_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id关联member表id',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `real_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固定电话',
  `province` int(11) NOT NULL DEFAULT '0' COMMENT '省id',
  `province_name` varchar(30) NOT NULL DEFAULT '' COMMENT '省名',
  `city` int(11) NOT NULL DEFAULT '0' COMMENT '市id',
  `city_name` varchar(30) NOT NULL DEFAULT '' COMMENT '市名',
  `town` int(11) NOT NULL DEFAULT '0' COMMENT '县id',
  `town_name` varchar(30) NOT NULL DEFAULT '',
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户详细信息';

-- ----------------------------
-- Records of weiapp_member_info
-- ----------------------------
INSERT INTO `weiapp_member_info` VALUES ('1', '2', '周东宝', '15133293464', '1', '0', '测试微信公众平台', '1', '1', '1428977397', '1430273397', '1428977238', '1428977397');

-- ----------------------------
-- Table structure for `weiapp_member_weixin`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member_weixin`;
CREATE TABLE `weiapp_member_weixin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id关联member表id',
  `mp_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信公众平台id(对应micro_platform.id)唯一',
  `wx_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户openid',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '微信用户昵称',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别1男性2女性0未知',
  `province` varchar(32) NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(32) NOT NULL DEFAULT '' COMMENT '城市',
  `country` varchar(32) NOT NULL DEFAULT '' COMMENT '国家',
  `headimgurl` varchar(255) NOT NULL DEFAULT '' COMMENT '头像url',
  `privilege` text COMMENT '用户特权信息，json 数组，如微信沃卡用户为（chinaunicom）',
  `group_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '微信用户所在分组(微信分组)',
  `is_subscribe` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否关注用户',
  `subscribe_time` int(11) NOT NULL DEFAULT '0' COMMENT '关注时间',
  `unsubscribe_time` int(11) NOT NULL DEFAULT '0' COMMENT '取消关注时间',
  `wechat_name` varchar(32) NOT NULL DEFAULT '' COMMENT '微信用户微信号唯一',
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
) ENGINE=MyISAM AUTO_INCREMENT=227 DEFAULT CHARSET=utf8;

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
INSERT INTO `weiapp_menu` VALUES ('125', '连锁餐厅管理', '122', '1', 'ChainDining/index', '0', '', '微餐厅管理', '0');
INSERT INTO `weiapp_menu` VALUES ('126', '餐厅列表管理', '122', '1', 'DiningRoom/index', '0', '', '微餐厅管理', '0');
INSERT INTO `weiapp_menu` VALUES ('127', '菜品分类列表管理', '122', '2', 'FoodCategory/index', '0', '', '微菜品分类管理', '0');
INSERT INTO `weiapp_menu` VALUES ('128', '菜品列表管理', '122', '2', 'Food/index', '0', '', '微菜品管理', '0');
INSERT INTO `weiapp_menu` VALUES ('129', '订单列表管理', '122', '2', 'FoodOrder/index', '0', '', '微餐饮订单管理', '0');
INSERT INTO `weiapp_menu` VALUES ('130', '微信公众平台菜单管理', '122', '0', 'WeixinMenu/index', '0', '', '微餐饮公众平台管理', '0');
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
INSERT INTO `weiapp_menu` VALUES ('141', '菜品分类', '135', '0', 'FoodCategory/show', '0', '', '微菜品分类', '0');
INSERT INTO `weiapp_menu` VALUES ('142', '菜品信息', '135', '0', 'Food/show', '0', '', '微菜品', '0');
INSERT INTO `weiapp_menu` VALUES ('143', '订单信息', '135', '0', 'FoodOrder/show', '0', '', '微餐饮订单', '0');
INSERT INTO `weiapp_menu` VALUES ('144', '资金流水', '135', '0', 'FoodWater/show', '0', '', '微餐饮流水', '0');
INSERT INTO `weiapp_menu` VALUES ('145', '生成Token', '123', '0', 'MemberInfo/token', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('146', '微信菜单', '135', '0', 'WeixinMenu/food', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('147', '创建一级菜单', '146', '0', 'WeixinMenu/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('148', '编辑', '146', '0', 'WeixinMenu/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('149', '启用', '146', '0', 'WeixinMenu/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('150', '禁用', '146', '0', 'WeixinMenu/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('151', '创建二级菜单', '146', '0', 'WeixinMenu/addsubmenu', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('152', '一键创建推荐菜单', '146', '0', 'WeixinMenu/recommend', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('153', '一键创建自定义菜单', '146', '0', 'WeixinMenu/custom', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('154', '微信卡劵', '135', '0', 'WeixinCard/show', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('189', '客户预定', '135', '0', 'DiningReserve/show', '0', '', '微餐饮订单', '0');
INSERT INTO `weiapp_menu` VALUES ('156', '微信告警', '135', '0', 'FoodWxWarn/show', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('157', '微信维权', '135', '0', 'FoodWxFeedback/show', '0', '', '微餐饮公众平台', '0');
INSERT INTO `weiapp_menu` VALUES ('158', '查看详细', '143', '0', 'FoodOrder/view', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('159', '确认送餐', '143', '0', 'FoodOrder/confirm', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('160', '确认完成', '143', '0', 'FoodOrder/finish', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('161', '打印', '143', '0', 'FoodOrder/orderprint', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('162', '创建', '140', '0', 'DiningRoom/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('163', '编辑', '140', '0', 'DiningRoom/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('164', '启用', '140', '0', 'DiningRoom/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('165', '禁用', '140', '0', 'DiningRoom/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('166', '获取省市县', '140', '0', 'DiningRoom/getRegion', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('167', '设置详细(图片)', '140', '0', 'DiningRoom/detail', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('168', '餐厅员工', '135', '0', 'DiningMember/show', '0', '', '微餐厅', '0');
INSERT INTO `weiapp_menu` VALUES ('169', '创建', '168', '0', 'DiningMember/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('170', '编辑', '168', '0', 'DiningMember/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('171', '启用', '168', '0', 'DiningMember/enable', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('172', '禁用', '168', '0', 'DiningMember/disable', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('173', '创建', '141', '0', 'FoodCategory/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('174', '编辑', '141', '0', 'FoodCategory/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('175', '启用', '141', '0', 'FoodCategory/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('176', '禁用', '141', '0', 'FoodCategory/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('177', '创建', '142', '0', 'Food/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('178', '编辑', '142', '0', 'Food/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('179', '上架', '142', '0', 'Food/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('180', '下架', '142', '0', 'Food/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('181', '详细', '142', '0', 'Food/detail', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('182', '获取餐厅菜品分类', '142', '0', 'Food/cate', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('183', '设置微信分享图片', '142', '0', 'Food/share', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('184', '菜品风格', '135', '0', 'FoodStyle/show', '0', '', '微菜品分类', '0');
INSERT INTO `weiapp_menu` VALUES ('185', '创建', '184', '0', 'FoodStyle/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('186', '编辑', '184', '0', 'FoodStyle/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('187', '启用', '184', '0', 'FoodStyle/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('188', '禁用', '184', '0', 'FoodStyle/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('190', '创建', '189', '0', 'DiningReserve/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('191', '确认预定', '189', '0', 'DiningReserve/confirm', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('192', '完成预定', '189', '0', 'DiningReserve/finish', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('193', '取消预定', '189', '0', 'DiningReserve/cancel', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('194', '作废预定', '189', '0', 'DiningReserve/drop', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('195', '菜品套餐', '135', '0', 'FoodSetmenu/show', '0', '', '微菜品', '0');
INSERT INTO `weiapp_menu` VALUES ('196', '创建', '195', '0', 'FoodSetmenu/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('197', '编辑', '195', '0', 'FoodSetmenu/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('198', '上架', '195', '0', 'FoodSetmenu/up', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('199', '下架', '195', '0', 'FoodSetmenu/down', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('200', '添加明细', '195', '0', 'FoodSetmenu/addfood', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('201', '编辑明细', '195', '0', 'FoodSetmenu/editfood', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('202', '启用明细', '195', '0', 'FoodSetmenu/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('203', '禁用明细', '195', '0', 'FoodSetmenu/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('204', '查看', '195', '0', 'FoodSetmenu/view', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('205', '导出EXCEL', '144', '0', 'FoodWater/csv', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('206', '详细', '124', '0', 'MicroPlatform/detail', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('207', '微餐饮告警管理', '122', '0', 'FoodWxWarn/index', '0', '', '微餐饮公众平台管理', '0');
INSERT INTO `weiapp_menu` VALUES ('208', '微餐饮维权管理', '122', '0', 'FoodWxFeedback/index', '0', '', '微餐饮公众平台管理', '0');
INSERT INTO `weiapp_menu` VALUES ('209', '餐厅员工管理', '122', '1', 'DiningMember/index', '0', '', '微餐厅管理', '0');
INSERT INTO `weiapp_menu` VALUES ('210', '菜品风格管理', '122', '2', 'FoodStyle/index', '0', '', '微菜品分类管理', '0');
INSERT INTO `weiapp_menu` VALUES ('211', '菜品套餐管理', '122', '2', 'FoodSetmenu/index', '0', '', '微菜品管理', '0');
INSERT INTO `weiapp_menu` VALUES ('212', '客户预定管理', '122', '2', 'DiningReserve/index', '0', '', '微餐饮订单管理', '0');
INSERT INTO `weiapp_menu` VALUES ('213', '资金流水管理', '122', '0', 'FoodWater/index', '0', '', '微餐饮公众平台管理', '0');
INSERT INTO `weiapp_menu` VALUES ('214', '上传卡劵logo', '154', '0', 'WeixinCard/uploadlogo', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('215', '创建', '154', '0', 'WeixinCard/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('216', '批量投放', '154', '0', 'WeixinCard/batchuse', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('217', '核销', '154', '0', 'WeixinCard/destroy', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('218', '批量删除', '154', '0', 'WeixinCard/batchdelete', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('219', '批量失效', '154', '0', 'WeixinCard/batchdisable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('220', '修改库存', '154', '0', 'WeixinCard/modifystock', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('221', '生成推广二维码', '154', '0', 'WeixinCard/qrcode', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('222', '详细', '154', '0', 'WeixinCard/detail', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('223', '菜品套餐评论', '135', '0', 'FoodComment/show', '0', '', '微菜品', '0');
INSERT INTO `weiapp_menu` VALUES ('224', '显示', '223', '0', 'FoodComment/enable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('225', '隐藏', '223', '0', 'FoodComment/disable', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('226', '查看', '223', '0', 'FoodComment/detail', '1', '', '', '0');

-- ----------------------------
-- Table structure for `weiapp_micro_platform`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_micro_platform`;
CREATE TABLE `weiapp_micro_platform` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台appid',
  `appsecret` varchar(256) NOT NULL DEFAULT '' COMMENT '微信公众平台appsecret',
  `mchid` varchar(128) NOT NULL DEFAULT '' COMMENT '商户号 新版微信支付必须',
  `key` char(32) NOT NULL DEFAULT '' COMMENT '商户密钥 新版微信支付必须 ',
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
  `back_img` varchar(256) NOT NULL DEFAULT '' COMMENT '背景图片url',
  `card_pic_url` varchar(256) NOT NULL DEFAULT '' COMMENT '微信平台logo图片url(微信服务器上)',
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
INSERT INTO `weiapp_micro_platform` VALUES ('1', '', '', '', '20C88F5DDE9E497EB80A3FD7ECE1EF5C', '', '', '', 'local.weiapp.com/Wechat/wx/index/t/9A1425926CC04FEEAF0CA7882A2CFF5F', '9A1425926CC04FEEAF0CA7882A2CFF5F', '1', '', '', '', '', '', '', '', '0', '', '0', '2', '', '0', '0', '0', '0', '0', '1', '0', '0.00', '1428977397', '1430273397', '1428977296', '1428977397');

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
-- Table structure for `weiapp_region`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_region`;
CREATE TABLE `weiapp_region` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  `parent` int(10) NOT NULL DEFAULT '0',
  `path_id` varchar(1000) DEFAULT NULL,
  `path_name` varchar(1000) DEFAULT NULL,
  `available` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=659005 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of weiapp_region
-- ----------------------------
INSERT INTO `weiapp_region` VALUES ('320000', '江苏省', '86', '86.320000', '中国.江苏省', '1');
INSERT INTO `weiapp_region` VALUES ('350000', '福建省', '86', '86.350000', '中国.福建省', '1');
INSERT INTO `weiapp_region` VALUES ('86', '中国', '0', '86', '中国', '1');
INSERT INTO `weiapp_region` VALUES ('110000', '北京市', '86', '86.110000', '中国.北京市', '1');
INSERT INTO `weiapp_region` VALUES ('110101', '东城区', '110000', '86.110000.110101', '中国.北京市.东城区', '1');
INSERT INTO `weiapp_region` VALUES ('110102', '西城区', '110000', '86.110000.110102', '中国.北京市.西城区', '1');
INSERT INTO `weiapp_region` VALUES ('110105', '朝阳区', '110000', '86.110000.110105', '中国.北京市.朝阳区', '1');
INSERT INTO `weiapp_region` VALUES ('110106', '丰台区', '110000', '86.110000.110106', '中国.北京市.丰台区', '1');
INSERT INTO `weiapp_region` VALUES ('110107', '石景山区', '110000', '86.110000.110107', '中国.北京市.石景山区', '1');
INSERT INTO `weiapp_region` VALUES ('110108', '海淀区', '110000', '86.110000.110108', '中国.北京市.海淀区', '1');
INSERT INTO `weiapp_region` VALUES ('110109', '门头沟区', '110000', '86.110000.110109', '中国.北京市.门头沟区', '1');
INSERT INTO `weiapp_region` VALUES ('110111', '房山区', '110000', '86.110000.110111', '中国.北京市.房山区', '1');
INSERT INTO `weiapp_region` VALUES ('110112', '通州区', '110000', '86.110000.110112', '中国.北京市.通州区', '1');
INSERT INTO `weiapp_region` VALUES ('110113', '顺义区', '110000', '86.110000.110113', '中国.北京市.顺义区', '1');
INSERT INTO `weiapp_region` VALUES ('110114', '昌平区', '110000', '86.110000.110114', '中国.北京市.昌平区', '1');
INSERT INTO `weiapp_region` VALUES ('110115', '大兴区', '110000', '86.110000.110115', '中国.北京市.大兴区', '1');
INSERT INTO `weiapp_region` VALUES ('110116', '怀柔区', '110000', '86.110000.110116', '中国.北京市.怀柔区', '1');
INSERT INTO `weiapp_region` VALUES ('110117', '平谷区', '110000', '86.110000.110117', '中国.北京市.平谷区', '1');
INSERT INTO `weiapp_region` VALUES ('110228', '密云县', '110000', '86.110000.110228', '中国.北京市.密云县', '1');
INSERT INTO `weiapp_region` VALUES ('110229', '延庆县', '110000', '86.110000.110229', '中国.北京市.延庆县', '1');
INSERT INTO `weiapp_region` VALUES ('120000', '天津市', '86', '86.120000', '中国.天津市', '1');
INSERT INTO `weiapp_region` VALUES ('120101', '和平区', '120000', '86.120000.120101', '中国.天津市.和平区', '1');
INSERT INTO `weiapp_region` VALUES ('120102', '河东区', '120000', '86.120000.120102', '中国.天津市.河东区', '1');
INSERT INTO `weiapp_region` VALUES ('120103', '河西区', '120000', '86.120000.120103', '中国.天津市.河西区', '1');
INSERT INTO `weiapp_region` VALUES ('120104', '南开区', '120000', '86.120000.120104', '中国.天津市.南开区', '1');
INSERT INTO `weiapp_region` VALUES ('120105', '河北区', '120000', '86.120000.120105', '中国.天津市.河北区', '1');
INSERT INTO `weiapp_region` VALUES ('120106', '红桥区', '120000', '86.120000.120106', '中国.天津市.红桥区', '1');
INSERT INTO `weiapp_region` VALUES ('120110', '东丽区', '120000', '86.120000.120110', '中国.天津市.东丽区', '1');
INSERT INTO `weiapp_region` VALUES ('120111', '西青区', '120000', '86.120000.120111', '中国.天津市.西青区', '1');
INSERT INTO `weiapp_region` VALUES ('120112', '津南区', '120000', '86.120000.120112', '中国.天津市.津南区', '1');
INSERT INTO `weiapp_region` VALUES ('120113', '北辰区', '120000', '86.120000.120113', '中国.天津市.北辰区', '1');
INSERT INTO `weiapp_region` VALUES ('120114', '武清区', '120000', '86.120000.120114', '中国.天津市.武清区', '1');
INSERT INTO `weiapp_region` VALUES ('120115', '宝坻区', '120000', '86.120000.120115', '中国.天津市.宝坻区', '1');
INSERT INTO `weiapp_region` VALUES ('120116', '滨海新区', '120000', '86.120000.120116', '中国.天津市.滨海新区', '1');
INSERT INTO `weiapp_region` VALUES ('120221', '宁河县', '120000', '86.120000.120221', '中国.天津市.宁河县', '1');
INSERT INTO `weiapp_region` VALUES ('120223', '静海县', '120000', '86.120000.120223', '中国.天津市.静海县', '1');
INSERT INTO `weiapp_region` VALUES ('120225', '蓟县', '120000', '86.120000.120225', '中国.天津市.蓟县', '1');
INSERT INTO `weiapp_region` VALUES ('130000', '河北省', '86', '86.130000', '中国.河北省', '1');
INSERT INTO `weiapp_region` VALUES ('130100', '石家庄市', '130000', '86.130000.130100', '中国.河北省.石家庄市', '1');
INSERT INTO `weiapp_region` VALUES ('130102', '长安区', '130100', '86.130000.130100.130102', '中国.河北省.石家庄市.长安区', '1');
INSERT INTO `weiapp_region` VALUES ('130103', '桥东区', '130100', '86.130000.130100.130103', '中国.河北省.石家庄市.桥东区', '1');
INSERT INTO `weiapp_region` VALUES ('130104', '桥西区', '130100', '86.130000.130100.130104', '中国.河北省.石家庄市.桥西区', '1');
INSERT INTO `weiapp_region` VALUES ('130105', '新华区', '130100', '86.130000.130100.130105', '中国.河北省.石家庄市.新华区', '1');
INSERT INTO `weiapp_region` VALUES ('130107', '井陉矿区', '130100', '86.130000.130100.130107', '中国.河北省.石家庄市.井陉矿区', '1');
INSERT INTO `weiapp_region` VALUES ('130108', '裕华区', '130100', '86.130000.130100.130108', '中国.河北省.石家庄市.裕华区', '1');
INSERT INTO `weiapp_region` VALUES ('130121', '井陉县', '130100', '86.130000.130100.130121', '中国.河北省.石家庄市.井陉县', '1');
INSERT INTO `weiapp_region` VALUES ('130123', '正定县', '130100', '86.130000.130100.130123', '中国.河北省.石家庄市.正定县', '1');
INSERT INTO `weiapp_region` VALUES ('130124', '栾城县', '130100', '86.130000.130100.130124', '中国.河北省.石家庄市.栾城县', '1');
INSERT INTO `weiapp_region` VALUES ('130125', '行唐县', '130100', '86.130000.130100.130125', '中国.河北省.石家庄市.行唐县', '1');
INSERT INTO `weiapp_region` VALUES ('130126', '灵寿县', '130100', '86.130000.130100.130126', '中国.河北省.石家庄市.灵寿县', '1');
INSERT INTO `weiapp_region` VALUES ('130127', '高邑县', '130100', '86.130000.130100.130127', '中国.河北省.石家庄市.高邑县', '1');
INSERT INTO `weiapp_region` VALUES ('130128', '深泽县', '130100', '86.130000.130100.130128', '中国.河北省.石家庄市.深泽县', '1');
INSERT INTO `weiapp_region` VALUES ('130129', '赞皇县', '130100', '86.130000.130100.130129', '中国.河北省.石家庄市.赞皇县', '1');
INSERT INTO `weiapp_region` VALUES ('130130', '无极县', '130100', '86.130000.130100.130130', '中国.河北省.石家庄市.无极县', '1');
INSERT INTO `weiapp_region` VALUES ('130131', '平山县', '130100', '86.130000.130100.130131', '中国.河北省.石家庄市.平山县', '1');
INSERT INTO `weiapp_region` VALUES ('130132', '元氏县', '130100', '86.130000.130100.130132', '中国.河北省.石家庄市.元氏县', '1');
INSERT INTO `weiapp_region` VALUES ('130133', '赵县', '130100', '86.130000.130100.130133', '中国.河北省.石家庄市.赵县', '1');
INSERT INTO `weiapp_region` VALUES ('130181', '辛集市', '130100', '86.130000.130100.130181', '中国.河北省.石家庄市.辛集市', '1');
INSERT INTO `weiapp_region` VALUES ('130182', '藁城市', '130100', '86.130000.130100.130182', '中国.河北省.石家庄市.藁城市', '1');
INSERT INTO `weiapp_region` VALUES ('130183', '晋州市', '130100', '86.130000.130100.130183', '中国.河北省.石家庄市.晋州市', '1');
INSERT INTO `weiapp_region` VALUES ('130184', '新乐市', '130100', '86.130000.130100.130184', '中国.河北省.石家庄市.新乐市', '1');
INSERT INTO `weiapp_region` VALUES ('130185', '鹿泉市', '130100', '86.130000.130100.130185', '中国.河北省.石家庄市.鹿泉市', '1');
INSERT INTO `weiapp_region` VALUES ('130200', '唐山市', '130000', '86.130000.130200', '中国.河北省.唐山市', '1');
INSERT INTO `weiapp_region` VALUES ('130202', '路南区', '130200', '86.130000.130200.130202', '中国.河北省.唐山市.路南区', '1');
INSERT INTO `weiapp_region` VALUES ('130203', '路北区', '130200', '86.130000.130200.130203', '中国.河北省.唐山市.路北区', '1');
INSERT INTO `weiapp_region` VALUES ('130204', '古冶区', '130200', '86.130000.130200.130204', '中国.河北省.唐山市.古冶区', '1');
INSERT INTO `weiapp_region` VALUES ('130205', '开平区', '130200', '86.130000.130200.130205', '中国.河北省.唐山市.开平区', '1');
INSERT INTO `weiapp_region` VALUES ('130207', '丰南区', '130200', '86.130000.130200.130207', '中国.河北省.唐山市.丰南区', '1');
INSERT INTO `weiapp_region` VALUES ('130208', '丰润区', '130200', '86.130000.130200.130208', '中国.河北省.唐山市.丰润区', '1');
INSERT INTO `weiapp_region` VALUES ('130223', '滦县', '130200', '86.130000.130200.130223', '中国.河北省.唐山市.滦县', '1');
INSERT INTO `weiapp_region` VALUES ('130224', '滦南县', '130200', '86.130000.130200.130224', '中国.河北省.唐山市.滦南县', '1');
INSERT INTO `weiapp_region` VALUES ('130225', '乐亭县', '130200', '86.130000.130200.130225', '中国.河北省.唐山市.乐亭县', '1');
INSERT INTO `weiapp_region` VALUES ('130227', '迁西县', '130200', '86.130000.130200.130227', '中国.河北省.唐山市.迁西县', '1');
INSERT INTO `weiapp_region` VALUES ('130229', '玉田县', '130200', '86.130000.130200.130229', '中国.河北省.唐山市.玉田县', '1');
INSERT INTO `weiapp_region` VALUES ('130230', '唐海县', '130200', '86.130000.130200.130230', '中国.河北省.唐山市.唐海县', '1');
INSERT INTO `weiapp_region` VALUES ('130281', '遵化市', '130200', '86.130000.130200.130281', '中国.河北省.唐山市.遵化市', '1');
INSERT INTO `weiapp_region` VALUES ('130283', '迁安市', '130200', '86.130000.130200.130283', '中国.河北省.唐山市.迁安市', '1');
INSERT INTO `weiapp_region` VALUES ('130300', '秦皇岛市', '130000', '86.130000.130300', '中国.河北省.秦皇岛市', '1');
INSERT INTO `weiapp_region` VALUES ('130302', '海港区', '130300', '86.130000.130300.130302', '中国.河北省.秦皇岛市.海港区', '1');
INSERT INTO `weiapp_region` VALUES ('130303', '山海关区', '130300', '86.130000.130300.130303', '中国.河北省.秦皇岛市.山海关区', '1');
INSERT INTO `weiapp_region` VALUES ('130304', '北戴河区', '130300', '86.130000.130300.130304', '中国.河北省.秦皇岛市.北戴河区', '1');
INSERT INTO `weiapp_region` VALUES ('130321', '青龙满族自治县', '130300', '86.130000.130300.130321', '中国.河北省.秦皇岛市.青龙满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('130322', '昌黎县', '130300', '86.130000.130300.130322', '中国.河北省.秦皇岛市.昌黎县', '1');
INSERT INTO `weiapp_region` VALUES ('130323', '抚宁县', '130300', '86.130000.130300.130323', '中国.河北省.秦皇岛市.抚宁县', '1');
INSERT INTO `weiapp_region` VALUES ('130324', '卢龙县', '130300', '86.130000.130300.130324', '中国.河北省.秦皇岛市.卢龙县', '1');
INSERT INTO `weiapp_region` VALUES ('130400', '邯郸市', '130000', '86.130000.130400', '中国.河北省.邯郸市', '1');
INSERT INTO `weiapp_region` VALUES ('130402', '邯山区', '130400', '86.130000.130400.130402', '中国.河北省.邯郸市.邯山区', '1');
INSERT INTO `weiapp_region` VALUES ('130403', '丛台区', '130400', '86.130000.130400.130403', '中国.河北省.邯郸市.丛台区', '1');
INSERT INTO `weiapp_region` VALUES ('130404', '复兴区', '130400', '86.130000.130400.130404', '中国.河北省.邯郸市.复兴区', '1');
INSERT INTO `weiapp_region` VALUES ('130406', '峰峰矿区', '130400', '86.130000.130400.130406', '中国.河北省.邯郸市.峰峰矿区', '1');
INSERT INTO `weiapp_region` VALUES ('130421', '邯郸县', '130400', '86.130000.130400.130421', '中国.河北省.邯郸市.邯郸县', '1');
INSERT INTO `weiapp_region` VALUES ('130423', '临漳县', '130400', '86.130000.130400.130423', '中国.河北省.邯郸市.临漳县', '1');
INSERT INTO `weiapp_region` VALUES ('130424', '成安县', '130400', '86.130000.130400.130424', '中国.河北省.邯郸市.成安县', '1');
INSERT INTO `weiapp_region` VALUES ('130425', '大名县', '130400', '86.130000.130400.130425', '中国.河北省.邯郸市.大名县', '1');
INSERT INTO `weiapp_region` VALUES ('130426', '涉县', '130400', '86.130000.130400.130426', '中国.河北省.邯郸市.涉县', '1');
INSERT INTO `weiapp_region` VALUES ('130427', '磁县', '130400', '86.130000.130400.130427', '中国.河北省.邯郸市.磁县', '1');
INSERT INTO `weiapp_region` VALUES ('130428', '肥乡县', '130400', '86.130000.130400.130428', '中国.河北省.邯郸市.肥乡县', '1');
INSERT INTO `weiapp_region` VALUES ('130429', '永年县', '130400', '86.130000.130400.130429', '中国.河北省.邯郸市.永年县', '1');
INSERT INTO `weiapp_region` VALUES ('130430', '邱县', '130400', '86.130000.130400.130430', '中国.河北省.邯郸市.邱县', '1');
INSERT INTO `weiapp_region` VALUES ('130431', '鸡泽县', '130400', '86.130000.130400.130431', '中国.河北省.邯郸市.鸡泽县', '1');
INSERT INTO `weiapp_region` VALUES ('130432', '广平县', '130400', '86.130000.130400.130432', '中国.河北省.邯郸市.广平县', '1');
INSERT INTO `weiapp_region` VALUES ('130433', '馆陶县', '130400', '86.130000.130400.130433', '中国.河北省.邯郸市.馆陶县', '1');
INSERT INTO `weiapp_region` VALUES ('130434', '魏县', '130400', '86.130000.130400.130434', '中国.河北省.邯郸市.魏县', '1');
INSERT INTO `weiapp_region` VALUES ('130435', '曲周县', '130400', '86.130000.130400.130435', '中国.河北省.邯郸市.曲周县', '1');
INSERT INTO `weiapp_region` VALUES ('130481', '武安市', '130400', '86.130000.130400.130481', '中国.河北省.邯郸市.武安市', '1');
INSERT INTO `weiapp_region` VALUES ('130500', '邢台市', '130000', '86.130000.130500', '中国.河北省.邢台市', '1');
INSERT INTO `weiapp_region` VALUES ('130502', '桥东区', '130500', '86.130000.130500.130502', '中国.河北省.邢台市.桥东区', '1');
INSERT INTO `weiapp_region` VALUES ('130503', '桥西区', '130500', '86.130000.130500.130503', '中国.河北省.邢台市.桥西区', '1');
INSERT INTO `weiapp_region` VALUES ('130521', '邢台县', '130500', '86.130000.130500.130521', '中国.河北省.邢台市.邢台县', '1');
INSERT INTO `weiapp_region` VALUES ('130522', '临城县', '130500', '86.130000.130500.130522', '中国.河北省.邢台市.临城县', '1');
INSERT INTO `weiapp_region` VALUES ('130523', '内丘县', '130500', '86.130000.130500.130523', '中国.河北省.邢台市.内丘县', '1');
INSERT INTO `weiapp_region` VALUES ('130524', '柏乡县', '130500', '86.130000.130500.130524', '中国.河北省.邢台市.柏乡县', '1');
INSERT INTO `weiapp_region` VALUES ('130525', '隆尧县', '130500', '86.130000.130500.130525', '中国.河北省.邢台市.隆尧县', '1');
INSERT INTO `weiapp_region` VALUES ('130526', '任县', '130500', '86.130000.130500.130526', '中国.河北省.邢台市.任县', '1');
INSERT INTO `weiapp_region` VALUES ('130527', '南和县', '130500', '86.130000.130500.130527', '中国.河北省.邢台市.南和县', '1');
INSERT INTO `weiapp_region` VALUES ('130528', '宁晋县', '130500', '86.130000.130500.130528', '中国.河北省.邢台市.宁晋县', '1');
INSERT INTO `weiapp_region` VALUES ('130529', '巨鹿县', '130500', '86.130000.130500.130529', '中国.河北省.邢台市.巨鹿县', '1');
INSERT INTO `weiapp_region` VALUES ('130530', '新河县', '130500', '86.130000.130500.130530', '中国.河北省.邢台市.新河县', '1');
INSERT INTO `weiapp_region` VALUES ('130531', '广宗县', '130500', '86.130000.130500.130531', '中国.河北省.邢台市.广宗县', '1');
INSERT INTO `weiapp_region` VALUES ('130532', '平乡县', '130500', '86.130000.130500.130532', '中国.河北省.邢台市.平乡县', '1');
INSERT INTO `weiapp_region` VALUES ('130533', '威县', '130500', '86.130000.130500.130533', '中国.河北省.邢台市.威县', '1');
INSERT INTO `weiapp_region` VALUES ('130534', '清河县', '130500', '86.130000.130500.130534', '中国.河北省.邢台市.清河县', '1');
INSERT INTO `weiapp_region` VALUES ('130535', '临西县', '130500', '86.130000.130500.130535', '中国.河北省.邢台市.临西县', '1');
INSERT INTO `weiapp_region` VALUES ('130581', '南宫市', '130500', '86.130000.130500.130581', '中国.河北省.邢台市.南宫市', '1');
INSERT INTO `weiapp_region` VALUES ('130582', '沙河市', '130500', '86.130000.130500.130582', '中国.河北省.邢台市.沙河市', '1');
INSERT INTO `weiapp_region` VALUES ('130600', '保定市', '130000', '86.130000.130600', '中国.河北省.保定市', '1');
INSERT INTO `weiapp_region` VALUES ('130602', '新市区', '130600', '86.130000.130600.130602', '中国.河北省.保定市.新市区', '1');
INSERT INTO `weiapp_region` VALUES ('130603', '北市区', '130600', '86.130000.130600.130603', '中国.河北省.保定市.北市区', '1');
INSERT INTO `weiapp_region` VALUES ('130604', '南市区', '130600', '86.130000.130600.130604', '中国.河北省.保定市.南市区', '1');
INSERT INTO `weiapp_region` VALUES ('130621', '满城县', '130600', '86.130000.130600.130621', '中国.河北省.保定市.满城县', '1');
INSERT INTO `weiapp_region` VALUES ('130622', '清苑县', '130600', '86.130000.130600.130622', '中国.河北省.保定市.清苑县', '1');
INSERT INTO `weiapp_region` VALUES ('130623', '涞水县', '130600', '86.130000.130600.130623', '中国.河北省.保定市.涞水县', '1');
INSERT INTO `weiapp_region` VALUES ('130624', '阜平县', '130600', '86.130000.130600.130624', '中国.河北省.保定市.阜平县', '1');
INSERT INTO `weiapp_region` VALUES ('130625', '徐水县', '130600', '86.130000.130600.130625', '中国.河北省.保定市.徐水县', '1');
INSERT INTO `weiapp_region` VALUES ('130626', '定兴县', '130600', '86.130000.130600.130626', '中国.河北省.保定市.定兴县', '1');
INSERT INTO `weiapp_region` VALUES ('130627', '唐县', '130600', '86.130000.130600.130627', '中国.河北省.保定市.唐县', '1');
INSERT INTO `weiapp_region` VALUES ('130628', '高阳县', '130600', '86.130000.130600.130628', '中国.河北省.保定市.高阳县', '1');
INSERT INTO `weiapp_region` VALUES ('130629', '容城县', '130600', '86.130000.130600.130629', '中国.河北省.保定市.容城县', '1');
INSERT INTO `weiapp_region` VALUES ('130630', '涞源县', '130600', '86.130000.130600.130630', '中国.河北省.保定市.涞源县', '1');
INSERT INTO `weiapp_region` VALUES ('130631', '望都县', '130600', '86.130000.130600.130631', '中国.河北省.保定市.望都县', '1');
INSERT INTO `weiapp_region` VALUES ('130632', '安新县', '130600', '86.130000.130600.130632', '中国.河北省.保定市.安新县', '1');
INSERT INTO `weiapp_region` VALUES ('130633', '易县', '130600', '86.130000.130600.130633', '中国.河北省.保定市.易县', '1');
INSERT INTO `weiapp_region` VALUES ('130634', '曲阳县', '130600', '86.130000.130600.130634', '中国.河北省.保定市.曲阳县', '1');
INSERT INTO `weiapp_region` VALUES ('130635', '蠡县', '130600', '86.130000.130600.130635', '中国.河北省.保定市.蠡县', '1');
INSERT INTO `weiapp_region` VALUES ('130636', '顺平县', '130600', '86.130000.130600.130636', '中国.河北省.保定市.顺平县', '1');
INSERT INTO `weiapp_region` VALUES ('130637', '博野县', '130600', '86.130000.130600.130637', '中国.河北省.保定市.博野县', '1');
INSERT INTO `weiapp_region` VALUES ('130638', '雄县', '130600', '86.130000.130600.130638', '中国.河北省.保定市.雄县', '1');
INSERT INTO `weiapp_region` VALUES ('130681', '涿州市', '130600', '86.130000.130600.130681', '中国.河北省.保定市.涿州市', '1');
INSERT INTO `weiapp_region` VALUES ('130682', '定州市', '130600', '86.130000.130600.130682', '中国.河北省.保定市.定州市', '1');
INSERT INTO `weiapp_region` VALUES ('130683', '安国市', '130600', '86.130000.130600.130683', '中国.河北省.保定市.安国市', '1');
INSERT INTO `weiapp_region` VALUES ('130684', '高碑店市', '130600', '86.130000.130600.130684', '中国.河北省.保定市.高碑店市', '1');
INSERT INTO `weiapp_region` VALUES ('130700', '张家口市', '130000', '86.130000.130700', '中国.河北省.张家口市', '1');
INSERT INTO `weiapp_region` VALUES ('130702', '桥东区', '130700', '86.130000.130700.130702', '中国.河北省.张家口市.桥东区', '1');
INSERT INTO `weiapp_region` VALUES ('130703', '桥西区', '130700', '86.130000.130700.130703', '中国.河北省.张家口市.桥西区', '1');
INSERT INTO `weiapp_region` VALUES ('130705', '宣化区', '130700', '86.130000.130700.130705', '中国.河北省.张家口市.宣化区', '1');
INSERT INTO `weiapp_region` VALUES ('130706', '下花园区', '130700', '86.130000.130700.130706', '中国.河北省.张家口市.下花园区', '1');
INSERT INTO `weiapp_region` VALUES ('130721', '宣化县', '130700', '86.130000.130700.130721', '中国.河北省.张家口市.宣化县', '1');
INSERT INTO `weiapp_region` VALUES ('130722', '张北县', '130700', '86.130000.130700.130722', '中国.河北省.张家口市.张北县', '1');
INSERT INTO `weiapp_region` VALUES ('130723', '康保县', '130700', '86.130000.130700.130723', '中国.河北省.张家口市.康保县', '1');
INSERT INTO `weiapp_region` VALUES ('130724', '沽源县', '130700', '86.130000.130700.130724', '中国.河北省.张家口市.沽源县', '1');
INSERT INTO `weiapp_region` VALUES ('130725', '尚义县', '130700', '86.130000.130700.130725', '中国.河北省.张家口市.尚义县', '1');
INSERT INTO `weiapp_region` VALUES ('130726', '蔚县', '130700', '86.130000.130700.130726', '中国.河北省.张家口市.蔚县', '1');
INSERT INTO `weiapp_region` VALUES ('130727', '阳原县', '130700', '86.130000.130700.130727', '中国.河北省.张家口市.阳原县', '1');
INSERT INTO `weiapp_region` VALUES ('130728', '怀安县', '130700', '86.130000.130700.130728', '中国.河北省.张家口市.怀安县', '1');
INSERT INTO `weiapp_region` VALUES ('130729', '万全县', '130700', '86.130000.130700.130729', '中国.河北省.张家口市.万全县', '1');
INSERT INTO `weiapp_region` VALUES ('130730', '怀来县', '130700', '86.130000.130700.130730', '中国.河北省.张家口市.怀来县', '1');
INSERT INTO `weiapp_region` VALUES ('130731', '涿鹿县', '130700', '86.130000.130700.130731', '中国.河北省.张家口市.涿鹿县', '1');
INSERT INTO `weiapp_region` VALUES ('130732', '赤城县', '130700', '86.130000.130700.130732', '中国.河北省.张家口市.赤城县', '1');
INSERT INTO `weiapp_region` VALUES ('130733', '崇礼县', '130700', '86.130000.130700.130733', '中国.河北省.张家口市.崇礼县', '1');
INSERT INTO `weiapp_region` VALUES ('130800', '承德市', '130000', '86.130000.130800', '中国.河北省.承德市', '1');
INSERT INTO `weiapp_region` VALUES ('130802', '双桥区', '130800', '86.130000.130800.130802', '中国.河北省.承德市.双桥区', '1');
INSERT INTO `weiapp_region` VALUES ('130803', '双滦区', '130800', '86.130000.130800.130803', '中国.河北省.承德市.双滦区', '1');
INSERT INTO `weiapp_region` VALUES ('130804', '鹰手营子矿区', '130800', '86.130000.130800.130804', '中国.河北省.承德市.鹰手营子矿区', '1');
INSERT INTO `weiapp_region` VALUES ('130821', '承德县', '130800', '86.130000.130800.130821', '中国.河北省.承德市.承德县', '1');
INSERT INTO `weiapp_region` VALUES ('130822', '兴隆县', '130800', '86.130000.130800.130822', '中国.河北省.承德市.兴隆县', '1');
INSERT INTO `weiapp_region` VALUES ('130823', '平泉县', '130800', '86.130000.130800.130823', '中国.河北省.承德市.平泉县', '1');
INSERT INTO `weiapp_region` VALUES ('130824', '滦平县', '130800', '86.130000.130800.130824', '中国.河北省.承德市.滦平县', '1');
INSERT INTO `weiapp_region` VALUES ('130825', '隆化县', '130800', '86.130000.130800.130825', '中国.河北省.承德市.隆化县', '1');
INSERT INTO `weiapp_region` VALUES ('130826', '丰宁满族自治县', '130800', '86.130000.130800.130826', '中国.河北省.承德市.丰宁满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('130827', '宽城满族自治县', '130800', '86.130000.130800.130827', '中国.河北省.承德市.宽城满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('130828', '围场满族蒙古族自治县', '130800', '86.130000.130800.130828', '中国.河北省.承德市.围场满族蒙古族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('130900', '沧州市', '130000', '86.130000.130900', '中国.河北省.沧州市', '1');
INSERT INTO `weiapp_region` VALUES ('130902', '新华区', '130900', '86.130000.130900.130902', '中国.河北省.沧州市.新华区', '1');
INSERT INTO `weiapp_region` VALUES ('130903', '运河区', '130900', '86.130000.130900.130903', '中国.河北省.沧州市.运河区', '1');
INSERT INTO `weiapp_region` VALUES ('130921', '沧县', '130900', '86.130000.130900.130921', '中国.河北省.沧州市.沧县', '1');
INSERT INTO `weiapp_region` VALUES ('130922', '青县', '130900', '86.130000.130900.130922', '中国.河北省.沧州市.青县', '1');
INSERT INTO `weiapp_region` VALUES ('130923', '东光县', '130900', '86.130000.130900.130923', '中国.河北省.沧州市.东光县', '1');
INSERT INTO `weiapp_region` VALUES ('130924', '海兴县', '130900', '86.130000.130900.130924', '中国.河北省.沧州市.海兴县', '1');
INSERT INTO `weiapp_region` VALUES ('130925', '盐山县', '130900', '86.130000.130900.130925', '中国.河北省.沧州市.盐山县', '1');
INSERT INTO `weiapp_region` VALUES ('130926', '肃宁县', '130900', '86.130000.130900.130926', '中国.河北省.沧州市.肃宁县', '1');
INSERT INTO `weiapp_region` VALUES ('130927', '南皮县', '130900', '86.130000.130900.130927', '中国.河北省.沧州市.南皮县', '1');
INSERT INTO `weiapp_region` VALUES ('130928', '吴桥县', '130900', '86.130000.130900.130928', '中国.河北省.沧州市.吴桥县', '1');
INSERT INTO `weiapp_region` VALUES ('130929', '献县', '130900', '86.130000.130900.130929', '中国.河北省.沧州市.献县', '1');
INSERT INTO `weiapp_region` VALUES ('130930', '孟村回族自治县', '130900', '86.130000.130900.130930', '中国.河北省.沧州市.孟村回族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('130981', '泊头市', '130900', '86.130000.130900.130981', '中国.河北省.沧州市.泊头市', '1');
INSERT INTO `weiapp_region` VALUES ('130982', '任丘市', '130900', '86.130000.130900.130982', '中国.河北省.沧州市.任丘市', '1');
INSERT INTO `weiapp_region` VALUES ('130983', '黄骅市', '130900', '86.130000.130900.130983', '中国.河北省.沧州市.黄骅市', '1');
INSERT INTO `weiapp_region` VALUES ('130984', '河间市', '130900', '86.130000.130900.130984', '中国.河北省.沧州市.河间市', '1');
INSERT INTO `weiapp_region` VALUES ('131000', '廊坊市', '130000', '86.130000.131000', '中国.河北省.廊坊市', '1');
INSERT INTO `weiapp_region` VALUES ('131002', '安次区', '131000', '86.130000.131000.131002', '中国.河北省.廊坊市.安次区', '1');
INSERT INTO `weiapp_region` VALUES ('131003', '广阳区', '131000', '86.130000.131000.131003', '中国.河北省.廊坊市.广阳区', '1');
INSERT INTO `weiapp_region` VALUES ('131022', '固安县', '131000', '86.130000.131000.131022', '中国.河北省.廊坊市.固安县', '1');
INSERT INTO `weiapp_region` VALUES ('131023', '永清县', '131000', '86.130000.131000.131023', '中国.河北省.廊坊市.永清县', '1');
INSERT INTO `weiapp_region` VALUES ('131024', '香河县', '131000', '86.130000.131000.131024', '中国.河北省.廊坊市.香河县', '1');
INSERT INTO `weiapp_region` VALUES ('131025', '大城县', '131000', '86.130000.131000.131025', '中国.河北省.廊坊市.大城县', '1');
INSERT INTO `weiapp_region` VALUES ('131026', '文安县', '131000', '86.130000.131000.131026', '中国.河北省.廊坊市.文安县', '1');
INSERT INTO `weiapp_region` VALUES ('131028', '大厂回族自治县', '131000', '86.130000.131000.131028', '中国.河北省.廊坊市.大厂回族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('131081', '霸州市', '131000', '86.130000.131000.131081', '中国.河北省.廊坊市.霸州市', '1');
INSERT INTO `weiapp_region` VALUES ('131082', '三河市', '131000', '86.130000.131000.131082', '中国.河北省.廊坊市.三河市', '1');
INSERT INTO `weiapp_region` VALUES ('131100', '衡水市', '130000', '86.130000.131100', '中国.河北省.衡水市', '1');
INSERT INTO `weiapp_region` VALUES ('131102', '桃城区', '131100', '86.130000.131100.131102', '中国.河北省.衡水市.桃城区', '1');
INSERT INTO `weiapp_region` VALUES ('131121', '枣强县', '131100', '86.130000.131100.131121', '中国.河北省.衡水市.枣强县', '1');
INSERT INTO `weiapp_region` VALUES ('131122', '武邑县', '131100', '86.130000.131100.131122', '中国.河北省.衡水市.武邑县', '1');
INSERT INTO `weiapp_region` VALUES ('131123', '武强县', '131100', '86.130000.131100.131123', '中国.河北省.衡水市.武强县', '1');
INSERT INTO `weiapp_region` VALUES ('131124', '饶阳县', '131100', '86.130000.131100.131124', '中国.河北省.衡水市.饶阳县', '1');
INSERT INTO `weiapp_region` VALUES ('131125', '安平县', '131100', '86.130000.131100.131125', '中国.河北省.衡水市.安平县', '1');
INSERT INTO `weiapp_region` VALUES ('131126', '故城县', '131100', '86.130000.131100.131126', '中国.河北省.衡水市.故城县', '1');
INSERT INTO `weiapp_region` VALUES ('131127', '景县', '131100', '86.130000.131100.131127', '中国.河北省.衡水市.景县', '1');
INSERT INTO `weiapp_region` VALUES ('131128', '阜城县', '131100', '86.130000.131100.131128', '中国.河北省.衡水市.阜城县', '1');
INSERT INTO `weiapp_region` VALUES ('131181', '冀州市', '131100', '86.130000.131100.131181', '中国.河北省.衡水市.冀州市', '1');
INSERT INTO `weiapp_region` VALUES ('131182', '深州市', '131100', '86.130000.131100.131182', '中国.河北省.衡水市.深州市', '1');
INSERT INTO `weiapp_region` VALUES ('140000', '山西省', '86', '86.140000', '中国.山西省', '1');
INSERT INTO `weiapp_region` VALUES ('140100', '太原市', '140000', '86.140000.140100', '中国.山西省.太原市', '1');
INSERT INTO `weiapp_region` VALUES ('140105', '小店区', '140100', '86.140000.140100.140105', '中国.山西省.太原市.小店区', '1');
INSERT INTO `weiapp_region` VALUES ('140106', '迎泽区', '140100', '86.140000.140100.140106', '中国.山西省.太原市.迎泽区', '1');
INSERT INTO `weiapp_region` VALUES ('140107', '杏花岭区', '140100', '86.140000.140100.140107', '中国.山西省.太原市.杏花岭区', '1');
INSERT INTO `weiapp_region` VALUES ('140108', '尖草坪区', '140100', '86.140000.140100.140108', '中国.山西省.太原市.尖草坪区', '1');
INSERT INTO `weiapp_region` VALUES ('140109', '万柏林区', '140100', '86.140000.140100.140109', '中国.山西省.太原市.万柏林区', '1');
INSERT INTO `weiapp_region` VALUES ('140110', '晋源区', '140100', '86.140000.140100.140110', '中国.山西省.太原市.晋源区', '1');
INSERT INTO `weiapp_region` VALUES ('140121', '清徐县', '140100', '86.140000.140100.140121', '中国.山西省.太原市.清徐县', '1');
INSERT INTO `weiapp_region` VALUES ('140122', '阳曲县', '140100', '86.140000.140100.140122', '中国.山西省.太原市.阳曲县', '1');
INSERT INTO `weiapp_region` VALUES ('140123', '娄烦县', '140100', '86.140000.140100.140123', '中国.山西省.太原市.娄烦县', '1');
INSERT INTO `weiapp_region` VALUES ('140181', '古交市', '140100', '86.140000.140100.140181', '中国.山西省.太原市.古交市', '1');
INSERT INTO `weiapp_region` VALUES ('140200', '大同市', '140000', '86.140000.140200', '中国.山西省.大同市', '1');
INSERT INTO `weiapp_region` VALUES ('140202', '城区', '140200', '86.140000.140200.140202', '中国.山西省.大同市.城区', '1');
INSERT INTO `weiapp_region` VALUES ('140203', '矿区', '140200', '86.140000.140200.140203', '中国.山西省.大同市.矿区', '1');
INSERT INTO `weiapp_region` VALUES ('140211', '南郊区', '140200', '86.140000.140200.140211', '中国.山西省.大同市.南郊区', '1');
INSERT INTO `weiapp_region` VALUES ('140212', '新荣区', '140200', '86.140000.140200.140212', '中国.山西省.大同市.新荣区', '1');
INSERT INTO `weiapp_region` VALUES ('140221', '阳高县', '140200', '86.140000.140200.140221', '中国.山西省.大同市.阳高县', '1');
INSERT INTO `weiapp_region` VALUES ('140222', '天镇县', '140200', '86.140000.140200.140222', '中国.山西省.大同市.天镇县', '1');
INSERT INTO `weiapp_region` VALUES ('140223', '广灵县', '140200', '86.140000.140200.140223', '中国.山西省.大同市.广灵县', '1');
INSERT INTO `weiapp_region` VALUES ('140224', '灵丘县', '140200', '86.140000.140200.140224', '中国.山西省.大同市.灵丘县', '1');
INSERT INTO `weiapp_region` VALUES ('140225', '浑源县', '140200', '86.140000.140200.140225', '中国.山西省.大同市.浑源县', '1');
INSERT INTO `weiapp_region` VALUES ('140226', '左云县', '140200', '86.140000.140200.140226', '中国.山西省.大同市.左云县', '1');
INSERT INTO `weiapp_region` VALUES ('140227', '大同县', '140200', '86.140000.140200.140227', '中国.山西省.大同市.大同县', '1');
INSERT INTO `weiapp_region` VALUES ('140300', '阳泉市', '140000', '86.140000.140300', '中国.山西省.阳泉市', '1');
INSERT INTO `weiapp_region` VALUES ('140302', '城区', '140300', '86.140000.140300.140302', '中国.山西省.阳泉市.城区', '1');
INSERT INTO `weiapp_region` VALUES ('140303', '矿区', '140300', '86.140000.140300.140303', '中国.山西省.阳泉市.矿区', '1');
INSERT INTO `weiapp_region` VALUES ('140311', '郊区', '140300', '86.140000.140300.140311', '中国.山西省.阳泉市.郊区', '1');
INSERT INTO `weiapp_region` VALUES ('140321', '平定县', '140300', '86.140000.140300.140321', '中国.山西省.阳泉市.平定县', '1');
INSERT INTO `weiapp_region` VALUES ('140322', '盂县', '140300', '86.140000.140300.140322', '中国.山西省.阳泉市.盂县', '1');
INSERT INTO `weiapp_region` VALUES ('140400', '长治市', '140000', '86.140000.140400', '中国.山西省.长治市', '1');
INSERT INTO `weiapp_region` VALUES ('140402', '城区', '140400', '86.140000.140400.140402', '中国.山西省.长治市.城区', '1');
INSERT INTO `weiapp_region` VALUES ('140411', '郊区', '140400', '86.140000.140400.140411', '中国.山西省.长治市.郊区', '1');
INSERT INTO `weiapp_region` VALUES ('140421', '长治县', '140400', '86.140000.140400.140421', '中国.山西省.长治市.长治县', '1');
INSERT INTO `weiapp_region` VALUES ('140423', '襄垣县', '140400', '86.140000.140400.140423', '中国.山西省.长治市.襄垣县', '1');
INSERT INTO `weiapp_region` VALUES ('140424', '屯留县', '140400', '86.140000.140400.140424', '中国.山西省.长治市.屯留县', '1');
INSERT INTO `weiapp_region` VALUES ('140425', '平顺县', '140400', '86.140000.140400.140425', '中国.山西省.长治市.平顺县', '1');
INSERT INTO `weiapp_region` VALUES ('140426', '黎城县', '140400', '86.140000.140400.140426', '中国.山西省.长治市.黎城县', '1');
INSERT INTO `weiapp_region` VALUES ('140427', '壶关县', '140400', '86.140000.140400.140427', '中国.山西省.长治市.壶关县', '1');
INSERT INTO `weiapp_region` VALUES ('140428', '长子县', '140400', '86.140000.140400.140428', '中国.山西省.长治市.长子县', '1');
INSERT INTO `weiapp_region` VALUES ('140429', '武乡县', '140400', '86.140000.140400.140429', '中国.山西省.长治市.武乡县', '1');
INSERT INTO `weiapp_region` VALUES ('140430', '沁县', '140400', '86.140000.140400.140430', '中国.山西省.长治市.沁县', '1');
INSERT INTO `weiapp_region` VALUES ('140431', '沁源县', '140400', '86.140000.140400.140431', '中国.山西省.长治市.沁源县', '1');
INSERT INTO `weiapp_region` VALUES ('140481', '潞城市', '140400', '86.140000.140400.140481', '中国.山西省.长治市.潞城市', '1');
INSERT INTO `weiapp_region` VALUES ('140500', '晋城市', '140000', '86.140000.140500', '中国.山西省.晋城市', '1');
INSERT INTO `weiapp_region` VALUES ('140502', '城区', '140500', '86.140000.140500.140502', '中国.山西省.晋城市.城区', '1');
INSERT INTO `weiapp_region` VALUES ('140521', '沁水县', '140500', '86.140000.140500.140521', '中国.山西省.晋城市.沁水县', '1');
INSERT INTO `weiapp_region` VALUES ('140522', '阳城县', '140500', '86.140000.140500.140522', '中国.山西省.晋城市.阳城县', '1');
INSERT INTO `weiapp_region` VALUES ('140524', '陵川县', '140500', '86.140000.140500.140524', '中国.山西省.晋城市.陵川县', '1');
INSERT INTO `weiapp_region` VALUES ('140525', '泽州县', '140500', '86.140000.140500.140525', '中国.山西省.晋城市.泽州县', '1');
INSERT INTO `weiapp_region` VALUES ('140581', '高平市', '140500', '86.140000.140500.140581', '中国.山西省.晋城市.高平市', '1');
INSERT INTO `weiapp_region` VALUES ('140600', '朔州市', '140000', '86.140000.140600', '中国.山西省.朔州市', '1');
INSERT INTO `weiapp_region` VALUES ('140602', '朔城区', '140600', '86.140000.140600.140602', '中国.山西省.朔州市.朔城区', '1');
INSERT INTO `weiapp_region` VALUES ('140603', '平鲁区', '140600', '86.140000.140600.140603', '中国.山西省.朔州市.平鲁区', '1');
INSERT INTO `weiapp_region` VALUES ('140621', '山阴县', '140600', '86.140000.140600.140621', '中国.山西省.朔州市.山阴县', '1');
INSERT INTO `weiapp_region` VALUES ('140622', '应县', '140600', '86.140000.140600.140622', '中国.山西省.朔州市.应县', '1');
INSERT INTO `weiapp_region` VALUES ('140623', '右玉县', '140600', '86.140000.140600.140623', '中国.山西省.朔州市.右玉县', '1');
INSERT INTO `weiapp_region` VALUES ('140624', '怀仁县', '140600', '86.140000.140600.140624', '中国.山西省.朔州市.怀仁县', '1');
INSERT INTO `weiapp_region` VALUES ('140700', '晋中市', '140000', '86.140000.140700', '中国.山西省.晋中市', '1');
INSERT INTO `weiapp_region` VALUES ('140702', '榆次区', '140700', '86.140000.140700.140702', '中国.山西省.晋中市.榆次区', '1');
INSERT INTO `weiapp_region` VALUES ('140721', '榆社县', '140700', '86.140000.140700.140721', '中国.山西省.晋中市.榆社县', '1');
INSERT INTO `weiapp_region` VALUES ('140722', '左权县', '140700', '86.140000.140700.140722', '中国.山西省.晋中市.左权县', '1');
INSERT INTO `weiapp_region` VALUES ('140723', '和顺县', '140700', '86.140000.140700.140723', '中国.山西省.晋中市.和顺县', '1');
INSERT INTO `weiapp_region` VALUES ('140724', '昔阳县', '140700', '86.140000.140700.140724', '中国.山西省.晋中市.昔阳县', '1');
INSERT INTO `weiapp_region` VALUES ('140725', '寿阳县', '140700', '86.140000.140700.140725', '中国.山西省.晋中市.寿阳县', '1');
INSERT INTO `weiapp_region` VALUES ('140726', '太谷县', '140700', '86.140000.140700.140726', '中国.山西省.晋中市.太谷县', '1');
INSERT INTO `weiapp_region` VALUES ('140727', '祁县', '140700', '86.140000.140700.140727', '中国.山西省.晋中市.祁县', '1');
INSERT INTO `weiapp_region` VALUES ('140728', '平遥县', '140700', '86.140000.140700.140728', '中国.山西省.晋中市.平遥县', '1');
INSERT INTO `weiapp_region` VALUES ('140729', '灵石县', '140700', '86.140000.140700.140729', '中国.山西省.晋中市.灵石县', '1');
INSERT INTO `weiapp_region` VALUES ('140781', '介休市', '140700', '86.140000.140700.140781', '中国.山西省.晋中市.介休市', '1');
INSERT INTO `weiapp_region` VALUES ('140800', '运城市', '140000', '86.140000.140800', '中国.山西省.运城市', '1');
INSERT INTO `weiapp_region` VALUES ('140802', '盐湖区', '140800', '86.140000.140800.140802', '中国.山西省.运城市.盐湖区', '1');
INSERT INTO `weiapp_region` VALUES ('140821', '临猗县', '140800', '86.140000.140800.140821', '中国.山西省.运城市.临猗县', '1');
INSERT INTO `weiapp_region` VALUES ('140822', '万荣县', '140800', '86.140000.140800.140822', '中国.山西省.运城市.万荣县', '1');
INSERT INTO `weiapp_region` VALUES ('140823', '闻喜县', '140800', '86.140000.140800.140823', '中国.山西省.运城市.闻喜县', '1');
INSERT INTO `weiapp_region` VALUES ('140824', '稷山县', '140800', '86.140000.140800.140824', '中国.山西省.运城市.稷山县', '1');
INSERT INTO `weiapp_region` VALUES ('140825', '新绛县', '140800', '86.140000.140800.140825', '中国.山西省.运城市.新绛县', '1');
INSERT INTO `weiapp_region` VALUES ('140826', '绛县', '140800', '86.140000.140800.140826', '中国.山西省.运城市.绛县', '1');
INSERT INTO `weiapp_region` VALUES ('140827', '垣曲县', '140800', '86.140000.140800.140827', '中国.山西省.运城市.垣曲县', '1');
INSERT INTO `weiapp_region` VALUES ('140828', '夏县', '140800', '86.140000.140800.140828', '中国.山西省.运城市.夏县', '1');
INSERT INTO `weiapp_region` VALUES ('140829', '平陆县', '140800', '86.140000.140800.140829', '中国.山西省.运城市.平陆县', '1');
INSERT INTO `weiapp_region` VALUES ('140830', '芮城县', '140800', '86.140000.140800.140830', '中国.山西省.运城市.芮城县', '1');
INSERT INTO `weiapp_region` VALUES ('140881', '永济市', '140800', '86.140000.140800.140881', '中国.山西省.运城市.永济市', '1');
INSERT INTO `weiapp_region` VALUES ('140882', '河津市', '140800', '86.140000.140800.140882', '中国.山西省.运城市.河津市', '1');
INSERT INTO `weiapp_region` VALUES ('140900', '忻州市', '140000', '86.140000.140900', '中国.山西省.忻州市', '1');
INSERT INTO `weiapp_region` VALUES ('140902', '忻府区', '140900', '86.140000.140900.140902', '中国.山西省.忻州市.忻府区', '1');
INSERT INTO `weiapp_region` VALUES ('140921', '定襄县', '140900', '86.140000.140900.140921', '中国.山西省.忻州市.定襄县', '1');
INSERT INTO `weiapp_region` VALUES ('140922', '五台县', '140900', '86.140000.140900.140922', '中国.山西省.忻州市.五台县', '1');
INSERT INTO `weiapp_region` VALUES ('140923', '代县', '140900', '86.140000.140900.140923', '中国.山西省.忻州市.代县', '1');
INSERT INTO `weiapp_region` VALUES ('140924', '繁峙县', '140900', '86.140000.140900.140924', '中国.山西省.忻州市.繁峙县', '1');
INSERT INTO `weiapp_region` VALUES ('140925', '宁武县', '140900', '86.140000.140900.140925', '中国.山西省.忻州市.宁武县', '1');
INSERT INTO `weiapp_region` VALUES ('140926', '静乐县', '140900', '86.140000.140900.140926', '中国.山西省.忻州市.静乐县', '1');
INSERT INTO `weiapp_region` VALUES ('140927', '神池县', '140900', '86.140000.140900.140927', '中国.山西省.忻州市.神池县', '1');
INSERT INTO `weiapp_region` VALUES ('140928', '五寨县', '140900', '86.140000.140900.140928', '中国.山西省.忻州市.五寨县', '1');
INSERT INTO `weiapp_region` VALUES ('140929', '岢岚县', '140900', '86.140000.140900.140929', '中国.山西省.忻州市.岢岚县', '1');
INSERT INTO `weiapp_region` VALUES ('140930', '河曲县', '140900', '86.140000.140900.140930', '中国.山西省.忻州市.河曲县', '1');
INSERT INTO `weiapp_region` VALUES ('140931', '保德县', '140900', '86.140000.140900.140931', '中国.山西省.忻州市.保德县', '1');
INSERT INTO `weiapp_region` VALUES ('140932', '偏关县', '140900', '86.140000.140900.140932', '中国.山西省.忻州市.偏关县', '1');
INSERT INTO `weiapp_region` VALUES ('140981', '原平市', '140900', '86.140000.140900.140981', '中国.山西省.忻州市.原平市', '1');
INSERT INTO `weiapp_region` VALUES ('141000', '临汾市', '140000', '86.140000.141000', '中国.山西省.临汾市', '1');
INSERT INTO `weiapp_region` VALUES ('141002', '尧都区', '141000', '86.140000.141000.141002', '中国.山西省.临汾市.尧都区', '1');
INSERT INTO `weiapp_region` VALUES ('141021', '曲沃县', '141000', '86.140000.141000.141021', '中国.山西省.临汾市.曲沃县', '1');
INSERT INTO `weiapp_region` VALUES ('141022', '翼城县', '141000', '86.140000.141000.141022', '中国.山西省.临汾市.翼城县', '1');
INSERT INTO `weiapp_region` VALUES ('141023', '襄汾县', '141000', '86.140000.141000.141023', '中国.山西省.临汾市.襄汾县', '1');
INSERT INTO `weiapp_region` VALUES ('141024', '洪洞县', '141000', '86.140000.141000.141024', '中国.山西省.临汾市.洪洞县', '1');
INSERT INTO `weiapp_region` VALUES ('141025', '古县', '141000', '86.140000.141000.141025', '中国.山西省.临汾市.古县', '1');
INSERT INTO `weiapp_region` VALUES ('141026', '安泽县', '141000', '86.140000.141000.141026', '中国.山西省.临汾市.安泽县', '1');
INSERT INTO `weiapp_region` VALUES ('141027', '浮山县', '141000', '86.140000.141000.141027', '中国.山西省.临汾市.浮山县', '1');
INSERT INTO `weiapp_region` VALUES ('141028', '吉县', '141000', '86.140000.141000.141028', '中国.山西省.临汾市.吉县', '1');
INSERT INTO `weiapp_region` VALUES ('141029', '乡宁县', '141000', '86.140000.141000.141029', '中国.山西省.临汾市.乡宁县', '1');
INSERT INTO `weiapp_region` VALUES ('141030', '大宁县', '141000', '86.140000.141000.141030', '中国.山西省.临汾市.大宁县', '1');
INSERT INTO `weiapp_region` VALUES ('141031', '隰县', '141000', '86.140000.141000.141031', '中国.山西省.临汾市.隰县', '1');
INSERT INTO `weiapp_region` VALUES ('141032', '永和县', '141000', '86.140000.141000.141032', '中国.山西省.临汾市.永和县', '1');
INSERT INTO `weiapp_region` VALUES ('141033', '蒲县', '141000', '86.140000.141000.141033', '中国.山西省.临汾市.蒲县', '1');
INSERT INTO `weiapp_region` VALUES ('141034', '汾西县', '141000', '86.140000.141000.141034', '中国.山西省.临汾市.汾西县', '1');
INSERT INTO `weiapp_region` VALUES ('141081', '侯马市', '141000', '86.140000.141000.141081', '中国.山西省.临汾市.侯马市', '1');
INSERT INTO `weiapp_region` VALUES ('141082', '霍州市', '141000', '86.140000.141000.141082', '中国.山西省.临汾市.霍州市', '1');
INSERT INTO `weiapp_region` VALUES ('141100', '吕梁市', '140000', '86.140000.141100', '中国.山西省.吕梁市', '1');
INSERT INTO `weiapp_region` VALUES ('141102', '离石区', '141100', '86.140000.141100.141102', '中国.山西省.吕梁市.离石区', '1');
INSERT INTO `weiapp_region` VALUES ('141121', '文水县', '141100', '86.140000.141100.141121', '中国.山西省.吕梁市.文水县', '1');
INSERT INTO `weiapp_region` VALUES ('141122', '交城县', '141100', '86.140000.141100.141122', '中国.山西省.吕梁市.交城县', '1');
INSERT INTO `weiapp_region` VALUES ('141123', '兴县', '141100', '86.140000.141100.141123', '中国.山西省.吕梁市.兴县', '1');
INSERT INTO `weiapp_region` VALUES ('141124', '临县', '141100', '86.140000.141100.141124', '中国.山西省.吕梁市.临县', '1');
INSERT INTO `weiapp_region` VALUES ('141125', '柳林县', '141100', '86.140000.141100.141125', '中国.山西省.吕梁市.柳林县', '1');
INSERT INTO `weiapp_region` VALUES ('141126', '石楼县', '141100', '86.140000.141100.141126', '中国.山西省.吕梁市.石楼县', '1');
INSERT INTO `weiapp_region` VALUES ('141127', '岚县', '141100', '86.140000.141100.141127', '中国.山西省.吕梁市.岚县', '1');
INSERT INTO `weiapp_region` VALUES ('141128', '方山县', '141100', '86.140000.141100.141128', '中国.山西省.吕梁市.方山县', '1');
INSERT INTO `weiapp_region` VALUES ('141129', '中阳县', '141100', '86.140000.141100.141129', '中国.山西省.吕梁市.中阳县', '1');
INSERT INTO `weiapp_region` VALUES ('141130', '交口县', '141100', '86.140000.141100.141130', '中国.山西省.吕梁市.交口县', '1');
INSERT INTO `weiapp_region` VALUES ('141181', '孝义市', '141100', '86.140000.141100.141181', '中国.山西省.吕梁市.孝义市', '1');
INSERT INTO `weiapp_region` VALUES ('141182', '汾阳市', '141100', '86.140000.141100.141182', '中国.山西省.吕梁市.汾阳市', '1');
INSERT INTO `weiapp_region` VALUES ('150000', '内蒙古自治区', '86', '86.150000', '中国.内蒙古自治区', '1');
INSERT INTO `weiapp_region` VALUES ('150100', '呼和浩特市', '150000', '86.150000.150100', '中国.内蒙古自治区.呼和浩特市', '1');
INSERT INTO `weiapp_region` VALUES ('150102', '新城区', '150100', '86.150000.150100.150102', '中国.内蒙古自治区.呼和浩特市.新城区', '1');
INSERT INTO `weiapp_region` VALUES ('150103', '回民区', '150100', '86.150000.150100.150103', '中国.内蒙古自治区.呼和浩特市.回民区', '1');
INSERT INTO `weiapp_region` VALUES ('150104', '玉泉区', '150100', '86.150000.150100.150104', '中国.内蒙古自治区.呼和浩特市.玉泉区', '1');
INSERT INTO `weiapp_region` VALUES ('150105', '赛罕区', '150100', '86.150000.150100.150105', '中国.内蒙古自治区.呼和浩特市.赛罕区', '1');
INSERT INTO `weiapp_region` VALUES ('150121', '土默特左旗', '150100', '86.150000.150100.150121', '中国.内蒙古自治区.呼和浩特市.土默特左旗', '1');
INSERT INTO `weiapp_region` VALUES ('150122', '托克托县', '150100', '86.150000.150100.150122', '中国.内蒙古自治区.呼和浩特市.托克托县', '1');
INSERT INTO `weiapp_region` VALUES ('150123', '和林格尔县', '150100', '86.150000.150100.150123', '中国.内蒙古自治区.呼和浩特市.和林格尔县', '1');
INSERT INTO `weiapp_region` VALUES ('150124', '清水河县', '150100', '86.150000.150100.150124', '中国.内蒙古自治区.呼和浩特市.清水河县', '1');
INSERT INTO `weiapp_region` VALUES ('150125', '武川县', '150100', '86.150000.150100.150125', '中国.内蒙古自治区.呼和浩特市.武川县', '1');
INSERT INTO `weiapp_region` VALUES ('150200', '包头市', '150000', '86.150000.150200', '中国.内蒙古自治区.包头市', '1');
INSERT INTO `weiapp_region` VALUES ('150202', '东河区', '150200', '86.150000.150200.150202', '中国.内蒙古自治区.包头市.东河区', '1');
INSERT INTO `weiapp_region` VALUES ('150203', '昆都仑区', '150200', '86.150000.150200.150203', '中国.内蒙古自治区.包头市.昆都仑区', '1');
INSERT INTO `weiapp_region` VALUES ('150204', '青山区', '150200', '86.150000.150200.150204', '中国.内蒙古自治区.包头市.青山区', '1');
INSERT INTO `weiapp_region` VALUES ('150205', '石拐区', '150200', '86.150000.150200.150205', '中国.内蒙古自治区.包头市.石拐区', '1');
INSERT INTO `weiapp_region` VALUES ('150206', '白云鄂博矿区', '150200', '86.150000.150200.150206', '中国.内蒙古自治区.包头市.白云鄂博矿区', '1');
INSERT INTO `weiapp_region` VALUES ('150207', '九原区', '150200', '86.150000.150200.150207', '中国.内蒙古自治区.包头市.九原区', '1');
INSERT INTO `weiapp_region` VALUES ('150221', '土默特右旗', '150200', '86.150000.150200.150221', '中国.内蒙古自治区.包头市.土默特右旗', '1');
INSERT INTO `weiapp_region` VALUES ('150222', '固阳县', '150200', '86.150000.150200.150222', '中国.内蒙古自治区.包头市.固阳县', '1');
INSERT INTO `weiapp_region` VALUES ('150223', '达尔罕茂明安联合旗', '150200', '86.150000.150200.150223', '中国.内蒙古自治区.包头市.达尔罕茂明安联合旗', '1');
INSERT INTO `weiapp_region` VALUES ('150300', '乌海市', '150000', '86.150000.150300', '中国.内蒙古自治区.乌海市', '1');
INSERT INTO `weiapp_region` VALUES ('150302', '海勃湾区', '150300', '86.150000.150300.150302', '中国.内蒙古自治区.乌海市.海勃湾区', '1');
INSERT INTO `weiapp_region` VALUES ('150303', '海南区', '150300', '86.150000.150300.150303', '中国.内蒙古自治区.乌海市.海南区', '1');
INSERT INTO `weiapp_region` VALUES ('150304', '乌达区', '150300', '86.150000.150300.150304', '中国.内蒙古自治区.乌海市.乌达区', '1');
INSERT INTO `weiapp_region` VALUES ('150400', '赤峰市', '150000', '86.150000.150400', '中国.内蒙古自治区.赤峰市', '1');
INSERT INTO `weiapp_region` VALUES ('150402', '红山区', '150400', '86.150000.150400.150402', '中国.内蒙古自治区.赤峰市.红山区', '1');
INSERT INTO `weiapp_region` VALUES ('150403', '元宝山区', '150400', '86.150000.150400.150403', '中国.内蒙古自治区.赤峰市.元宝山区', '1');
INSERT INTO `weiapp_region` VALUES ('150404', '松山区', '150400', '86.150000.150400.150404', '中国.内蒙古自治区.赤峰市.松山区', '1');
INSERT INTO `weiapp_region` VALUES ('150421', '阿鲁科尔沁旗', '150400', '86.150000.150400.150421', '中国.内蒙古自治区.赤峰市.阿鲁科尔沁旗', '1');
INSERT INTO `weiapp_region` VALUES ('150422', '巴林左旗', '150400', '86.150000.150400.150422', '中国.内蒙古自治区.赤峰市.巴林左旗', '1');
INSERT INTO `weiapp_region` VALUES ('150423', '巴林右旗', '150400', '86.150000.150400.150423', '中国.内蒙古自治区.赤峰市.巴林右旗', '1');
INSERT INTO `weiapp_region` VALUES ('150424', '林西县', '150400', '86.150000.150400.150424', '中国.内蒙古自治区.赤峰市.林西县', '1');
INSERT INTO `weiapp_region` VALUES ('150425', '克什克腾旗', '150400', '86.150000.150400.150425', '中国.内蒙古自治区.赤峰市.克什克腾旗', '1');
INSERT INTO `weiapp_region` VALUES ('150426', '翁牛特旗', '150400', '86.150000.150400.150426', '中国.内蒙古自治区.赤峰市.翁牛特旗', '1');
INSERT INTO `weiapp_region` VALUES ('150428', '喀喇沁旗', '150400', '86.150000.150400.150428', '中国.内蒙古自治区.赤峰市.喀喇沁旗', '1');
INSERT INTO `weiapp_region` VALUES ('150429', '宁城县', '150400', '86.150000.150400.150429', '中国.内蒙古自治区.赤峰市.宁城县', '1');
INSERT INTO `weiapp_region` VALUES ('150430', '敖汉旗', '150400', '86.150000.150400.150430', '中国.内蒙古自治区.赤峰市.敖汉旗', '1');
INSERT INTO `weiapp_region` VALUES ('150500', '通辽市', '150000', '86.150000.150500', '中国.内蒙古自治区.通辽市', '1');
INSERT INTO `weiapp_region` VALUES ('150502', '科尔沁区', '150500', '86.150000.150500.150502', '中国.内蒙古自治区.通辽市.科尔沁区', '1');
INSERT INTO `weiapp_region` VALUES ('150521', '科尔沁左翼中旗', '150500', '86.150000.150500.150521', '中国.内蒙古自治区.通辽市.科尔沁左翼中旗', '1');
INSERT INTO `weiapp_region` VALUES ('150522', '科尔沁左翼后旗', '150500', '86.150000.150500.150522', '中国.内蒙古自治区.通辽市.科尔沁左翼后旗', '1');
INSERT INTO `weiapp_region` VALUES ('150523', '开鲁县', '150500', '86.150000.150500.150523', '中国.内蒙古自治区.通辽市.开鲁县', '1');
INSERT INTO `weiapp_region` VALUES ('150524', '库伦旗', '150500', '86.150000.150500.150524', '中国.内蒙古自治区.通辽市.库伦旗', '1');
INSERT INTO `weiapp_region` VALUES ('150525', '奈曼旗', '150500', '86.150000.150500.150525', '中国.内蒙古自治区.通辽市.奈曼旗', '1');
INSERT INTO `weiapp_region` VALUES ('150526', '扎鲁特旗', '150500', '86.150000.150500.150526', '中国.内蒙古自治区.通辽市.扎鲁特旗', '1');
INSERT INTO `weiapp_region` VALUES ('150581', '霍林郭勒市', '150500', '86.150000.150500.150581', '中国.内蒙古自治区.通辽市.霍林郭勒市', '1');
INSERT INTO `weiapp_region` VALUES ('150600', '鄂尔多斯市', '150000', '86.150000.150600', '中国.内蒙古自治区.鄂尔多斯市', '1');
INSERT INTO `weiapp_region` VALUES ('150602', '东胜区', '150600', '86.150000.150600.150602', '中国.内蒙古自治区.鄂尔多斯市.东胜区', '1');
INSERT INTO `weiapp_region` VALUES ('150621', '达拉特旗', '150600', '86.150000.150600.150621', '中国.内蒙古自治区.鄂尔多斯市.达拉特旗', '1');
INSERT INTO `weiapp_region` VALUES ('150622', '准格尔旗', '150600', '86.150000.150600.150622', '中国.内蒙古自治区.鄂尔多斯市.准格尔旗', '1');
INSERT INTO `weiapp_region` VALUES ('150623', '鄂托克前旗', '150600', '86.150000.150600.150623', '中国.内蒙古自治区.鄂尔多斯市.鄂托克前旗', '1');
INSERT INTO `weiapp_region` VALUES ('150624', '鄂托克旗', '150600', '86.150000.150600.150624', '中国.内蒙古自治区.鄂尔多斯市.鄂托克旗', '1');
INSERT INTO `weiapp_region` VALUES ('150625', '杭锦旗', '150600', '86.150000.150600.150625', '中国.内蒙古自治区.鄂尔多斯市.杭锦旗', '1');
INSERT INTO `weiapp_region` VALUES ('150626', '乌审旗', '150600', '86.150000.150600.150626', '中国.内蒙古自治区.鄂尔多斯市.乌审旗', '1');
INSERT INTO `weiapp_region` VALUES ('150627', '伊金霍洛旗', '150600', '86.150000.150600.150627', '中国.内蒙古自治区.鄂尔多斯市.伊金霍洛旗', '1');
INSERT INTO `weiapp_region` VALUES ('150700', '呼伦贝尔市', '150000', '86.150000.150700', '中国.内蒙古自治区.呼伦贝尔市', '1');
INSERT INTO `weiapp_region` VALUES ('150702', '海拉尔区', '150700', '86.150000.150700.150702', '中国.内蒙古自治区.呼伦贝尔市.海拉尔区', '1');
INSERT INTO `weiapp_region` VALUES ('150721', '阿荣旗', '150700', '86.150000.150700.150721', '中国.内蒙古自治区.呼伦贝尔市.阿荣旗', '1');
INSERT INTO `weiapp_region` VALUES ('150722', '莫力达瓦达斡尔族自治旗', '150700', '86.150000.150700.150722', '中国.内蒙古自治区.呼伦贝尔市.莫力达瓦达斡尔族自治旗', '1');
INSERT INTO `weiapp_region` VALUES ('150723', '鄂伦春自治旗', '150700', '86.150000.150700.150723', '中国.内蒙古自治区.呼伦贝尔市.鄂伦春自治旗', '1');
INSERT INTO `weiapp_region` VALUES ('150724', '鄂温克族自治旗', '150700', '86.150000.150700.150724', '中国.内蒙古自治区.呼伦贝尔市.鄂温克族自治旗', '1');
INSERT INTO `weiapp_region` VALUES ('150725', '陈巴尔虎旗', '150700', '86.150000.150700.150725', '中国.内蒙古自治区.呼伦贝尔市.陈巴尔虎旗', '1');
INSERT INTO `weiapp_region` VALUES ('150726', '新巴尔虎左旗', '150700', '86.150000.150700.150726', '中国.内蒙古自治区.呼伦贝尔市.新巴尔虎左旗', '1');
INSERT INTO `weiapp_region` VALUES ('150727', '新巴尔虎右旗', '150700', '86.150000.150700.150727', '中国.内蒙古自治区.呼伦贝尔市.新巴尔虎右旗', '1');
INSERT INTO `weiapp_region` VALUES ('150781', '满洲里市', '150700', '86.150000.150700.150781', '中国.内蒙古自治区.呼伦贝尔市.满洲里市', '1');
INSERT INTO `weiapp_region` VALUES ('150782', '牙克石市', '150700', '86.150000.150700.150782', '中国.内蒙古自治区.呼伦贝尔市.牙克石市', '1');
INSERT INTO `weiapp_region` VALUES ('150783', '扎兰屯市', '150700', '86.150000.150700.150783', '中国.内蒙古自治区.呼伦贝尔市.扎兰屯市', '1');
INSERT INTO `weiapp_region` VALUES ('150784', '额尔古纳市', '150700', '86.150000.150700.150784', '中国.内蒙古自治区.呼伦贝尔市.额尔古纳市', '1');
INSERT INTO `weiapp_region` VALUES ('150785', '根河市', '150700', '86.150000.150700.150785', '中国.内蒙古自治区.呼伦贝尔市.根河市', '1');
INSERT INTO `weiapp_region` VALUES ('150800', '巴彦淖尔市', '150000', '86.150000.150800', '中国.内蒙古自治区.巴彦淖尔市', '1');
INSERT INTO `weiapp_region` VALUES ('150802', '临河区', '150800', '86.150000.150800.150802', '中国.内蒙古自治区.巴彦淖尔市.临河区', '1');
INSERT INTO `weiapp_region` VALUES ('150821', '五原县', '150800', '86.150000.150800.150821', '中国.内蒙古自治区.巴彦淖尔市.五原县', '1');
INSERT INTO `weiapp_region` VALUES ('150822', '磴口县', '150800', '86.150000.150800.150822', '中国.内蒙古自治区.巴彦淖尔市.磴口县', '1');
INSERT INTO `weiapp_region` VALUES ('150823', '乌拉特前旗', '150800', '86.150000.150800.150823', '中国.内蒙古自治区.巴彦淖尔市.乌拉特前旗', '1');
INSERT INTO `weiapp_region` VALUES ('150824', '乌拉特中旗', '150800', '86.150000.150800.150824', '中国.内蒙古自治区.巴彦淖尔市.乌拉特中旗', '1');
INSERT INTO `weiapp_region` VALUES ('150825', '乌拉特后旗', '150800', '86.150000.150800.150825', '中国.内蒙古自治区.巴彦淖尔市.乌拉特后旗', '1');
INSERT INTO `weiapp_region` VALUES ('150826', '杭锦后旗', '150800', '86.150000.150800.150826', '中国.内蒙古自治区.巴彦淖尔市.杭锦后旗', '1');
INSERT INTO `weiapp_region` VALUES ('150900', '乌兰察布市', '150000', '86.150000.150900', '中国.内蒙古自治区.乌兰察布市', '1');
INSERT INTO `weiapp_region` VALUES ('150902', '集宁区', '150900', '86.150000.150900.150902', '中国.内蒙古自治区.乌兰察布市.集宁区', '1');
INSERT INTO `weiapp_region` VALUES ('150921', '卓资县', '150900', '86.150000.150900.150921', '中国.内蒙古自治区.乌兰察布市.卓资县', '1');
INSERT INTO `weiapp_region` VALUES ('150922', '化德县', '150900', '86.150000.150900.150922', '中国.内蒙古自治区.乌兰察布市.化德县', '1');
INSERT INTO `weiapp_region` VALUES ('150923', '商都县', '150900', '86.150000.150900.150923', '中国.内蒙古自治区.乌兰察布市.商都县', '1');
INSERT INTO `weiapp_region` VALUES ('150924', '兴和县', '150900', '86.150000.150900.150924', '中国.内蒙古自治区.乌兰察布市.兴和县', '1');
INSERT INTO `weiapp_region` VALUES ('150925', '凉城县', '150900', '86.150000.150900.150925', '中国.内蒙古自治区.乌兰察布市.凉城县', '1');
INSERT INTO `weiapp_region` VALUES ('150926', '察哈尔右翼前旗', '150900', '86.150000.150900.150926', '中国.内蒙古自治区.乌兰察布市.察哈尔右翼前旗', '1');
INSERT INTO `weiapp_region` VALUES ('150927', '察哈尔右翼中旗', '150900', '86.150000.150900.150927', '中国.内蒙古自治区.乌兰察布市.察哈尔右翼中旗', '1');
INSERT INTO `weiapp_region` VALUES ('150928', '察哈尔右翼后旗', '150900', '86.150000.150900.150928', '中国.内蒙古自治区.乌兰察布市.察哈尔右翼后旗', '1');
INSERT INTO `weiapp_region` VALUES ('150929', '四子王旗', '150900', '86.150000.150900.150929', '中国.内蒙古自治区.乌兰察布市.四子王旗', '1');
INSERT INTO `weiapp_region` VALUES ('150981', '丰镇市', '150900', '86.150000.150900.150981', '中国.内蒙古自治区.乌兰察布市.丰镇市', '1');
INSERT INTO `weiapp_region` VALUES ('152200', '兴安盟', '150000', '86.150000.152200', '中国.内蒙古自治区.兴安盟', '1');
INSERT INTO `weiapp_region` VALUES ('152201', '乌兰浩特市', '152200', '86.150000.152200.152201', '中国.内蒙古自治区.兴安盟.乌兰浩特市', '1');
INSERT INTO `weiapp_region` VALUES ('152202', '阿尔山市', '152200', '86.150000.152200.152202', '中国.内蒙古自治区.兴安盟.阿尔山市', '1');
INSERT INTO `weiapp_region` VALUES ('152221', '科尔沁右翼前旗', '152200', '86.150000.152200.152221', '中国.内蒙古自治区.兴安盟.科尔沁右翼前旗', '1');
INSERT INTO `weiapp_region` VALUES ('152222', '科尔沁右翼中旗', '152200', '86.150000.152200.152222', '中国.内蒙古自治区.兴安盟.科尔沁右翼中旗', '1');
INSERT INTO `weiapp_region` VALUES ('152223', '扎赉特旗', '152200', '86.150000.152200.152223', '中国.内蒙古自治区.兴安盟.扎赉特旗', '1');
INSERT INTO `weiapp_region` VALUES ('152224', '突泉县', '152200', '86.150000.152200.152224', '中国.内蒙古自治区.兴安盟.突泉县', '1');
INSERT INTO `weiapp_region` VALUES ('152500', '锡林郭勒盟', '150000', '86.150000.152500', '中国.内蒙古自治区.锡林郭勒盟', '1');
INSERT INTO `weiapp_region` VALUES ('152501', '二连浩特市', '152500', '86.150000.152500.152501', '中国.内蒙古自治区.锡林郭勒盟.二连浩特市', '1');
INSERT INTO `weiapp_region` VALUES ('152502', '锡林浩特市', '152500', '86.150000.152500.152502', '中国.内蒙古自治区.锡林郭勒盟.锡林浩特市', '1');
INSERT INTO `weiapp_region` VALUES ('152522', '阿巴嘎旗', '152500', '86.150000.152500.152522', '中国.内蒙古自治区.锡林郭勒盟.阿巴嘎旗', '1');
INSERT INTO `weiapp_region` VALUES ('152523', '苏尼特左旗', '152500', '86.150000.152500.152523', '中国.内蒙古自治区.锡林郭勒盟.苏尼特左旗', '1');
INSERT INTO `weiapp_region` VALUES ('152524', '苏尼特右旗', '152500', '86.150000.152500.152524', '中国.内蒙古自治区.锡林郭勒盟.苏尼特右旗', '1');
INSERT INTO `weiapp_region` VALUES ('152525', '东乌珠穆沁旗', '152500', '86.150000.152500.152525', '中国.内蒙古自治区.锡林郭勒盟.东乌珠穆沁旗', '1');
INSERT INTO `weiapp_region` VALUES ('152526', '西乌珠穆沁旗', '152500', '86.150000.152500.152526', '中国.内蒙古自治区.锡林郭勒盟.西乌珠穆沁旗', '1');
INSERT INTO `weiapp_region` VALUES ('152527', '太仆寺旗', '152500', '86.150000.152500.152527', '中国.内蒙古自治区.锡林郭勒盟.太仆寺旗', '1');
INSERT INTO `weiapp_region` VALUES ('152528', '镶黄旗', '152500', '86.150000.152500.152528', '中国.内蒙古自治区.锡林郭勒盟.镶黄旗', '1');
INSERT INTO `weiapp_region` VALUES ('152529', '正镶白旗', '152500', '86.150000.152500.152529', '中国.内蒙古自治区.锡林郭勒盟.正镶白旗', '1');
INSERT INTO `weiapp_region` VALUES ('152530', '正蓝旗', '152500', '86.150000.152500.152530', '中国.内蒙古自治区.锡林郭勒盟.正蓝旗', '1');
INSERT INTO `weiapp_region` VALUES ('152531', '多伦县', '152500', '86.150000.152500.152531', '中国.内蒙古自治区.锡林郭勒盟.多伦县', '1');
INSERT INTO `weiapp_region` VALUES ('152900', '阿拉善盟', '150000', '86.150000.152900', '中国.内蒙古自治区.阿拉善盟', '1');
INSERT INTO `weiapp_region` VALUES ('152921', '阿拉善左旗', '152900', '86.150000.152900.152921', '中国.内蒙古自治区.阿拉善盟.阿拉善左旗', '1');
INSERT INTO `weiapp_region` VALUES ('152922', '阿拉善右旗', '152900', '86.150000.152900.152922', '中国.内蒙古自治区.阿拉善盟.阿拉善右旗', '1');
INSERT INTO `weiapp_region` VALUES ('152923', '额济纳旗', '152900', '86.150000.152900.152923', '中国.内蒙古自治区.阿拉善盟.额济纳旗', '1');
INSERT INTO `weiapp_region` VALUES ('210000', '辽宁省', '86', '86.210000', '中国.辽宁省', '1');
INSERT INTO `weiapp_region` VALUES ('210100', '沈阳市', '210000', '86.210000.210100', '中国.辽宁省.沈阳市', '1');
INSERT INTO `weiapp_region` VALUES ('210102', '和平区', '210100', '86.210000.210100.210102', '中国.辽宁省.沈阳市.和平区', '1');
INSERT INTO `weiapp_region` VALUES ('210103', '沈河区', '210100', '86.210000.210100.210103', '中国.辽宁省.沈阳市.沈河区', '1');
INSERT INTO `weiapp_region` VALUES ('210104', '大东区', '210100', '86.210000.210100.210104', '中国.辽宁省.沈阳市.大东区', '1');
INSERT INTO `weiapp_region` VALUES ('210105', '皇姑区', '210100', '86.210000.210100.210105', '中国.辽宁省.沈阳市.皇姑区', '1');
INSERT INTO `weiapp_region` VALUES ('210106', '铁西区', '210100', '86.210000.210100.210106', '中国.辽宁省.沈阳市.铁西区', '1');
INSERT INTO `weiapp_region` VALUES ('210111', '苏家屯区', '210100', '86.210000.210100.210111', '中国.辽宁省.沈阳市.苏家屯区', '1');
INSERT INTO `weiapp_region` VALUES ('210112', '东陵区', '210100', '86.210000.210100.210112', '中国.辽宁省.沈阳市.东陵区', '1');
INSERT INTO `weiapp_region` VALUES ('210113', '沈北新区', '210100', '86.210000.210100.210113', '中国.辽宁省.沈阳市.沈北新区', '1');
INSERT INTO `weiapp_region` VALUES ('210114', '于洪区', '210100', '86.210000.210100.210114', '中国.辽宁省.沈阳市.于洪区', '1');
INSERT INTO `weiapp_region` VALUES ('210122', '辽中县', '210100', '86.210000.210100.210122', '中国.辽宁省.沈阳市.辽中县', '1');
INSERT INTO `weiapp_region` VALUES ('210123', '康平县', '210100', '86.210000.210100.210123', '中国.辽宁省.沈阳市.康平县', '1');
INSERT INTO `weiapp_region` VALUES ('210124', '法库县', '210100', '86.210000.210100.210124', '中国.辽宁省.沈阳市.法库县', '1');
INSERT INTO `weiapp_region` VALUES ('210181', '新民市', '210100', '86.210000.210100.210181', '中国.辽宁省.沈阳市.新民市', '1');
INSERT INTO `weiapp_region` VALUES ('210200', '大连市', '210000', '86.210000.210200', '中国.辽宁省.大连市', '1');
INSERT INTO `weiapp_region` VALUES ('210202', '中山区', '210200', '86.210000.210200.210202', '中国.辽宁省.大连市.中山区', '1');
INSERT INTO `weiapp_region` VALUES ('210203', '西岗区', '210200', '86.210000.210200.210203', '中国.辽宁省.大连市.西岗区', '1');
INSERT INTO `weiapp_region` VALUES ('210204', '沙河口区', '210200', '86.210000.210200.210204', '中国.辽宁省.大连市.沙河口区', '1');
INSERT INTO `weiapp_region` VALUES ('210211', '甘井子区', '210200', '86.210000.210200.210211', '中国.辽宁省.大连市.甘井子区', '1');
INSERT INTO `weiapp_region` VALUES ('210212', '旅顺口区', '210200', '86.210000.210200.210212', '中国.辽宁省.大连市.旅顺口区', '1');
INSERT INTO `weiapp_region` VALUES ('210213', '金州区', '210200', '86.210000.210200.210213', '中国.辽宁省.大连市.金州区', '1');
INSERT INTO `weiapp_region` VALUES ('210224', '长海县', '210200', '86.210000.210200.210224', '中国.辽宁省.大连市.长海县', '1');
INSERT INTO `weiapp_region` VALUES ('210281', '瓦房店市', '210200', '86.210000.210200.210281', '中国.辽宁省.大连市.瓦房店市', '1');
INSERT INTO `weiapp_region` VALUES ('210282', '普兰店市', '210200', '86.210000.210200.210282', '中国.辽宁省.大连市.普兰店市', '1');
INSERT INTO `weiapp_region` VALUES ('210283', '庄河市', '210200', '86.210000.210200.210283', '中国.辽宁省.大连市.庄河市', '1');
INSERT INTO `weiapp_region` VALUES ('210300', '鞍山市', '210000', '86.210000.210300', '中国.辽宁省.鞍山市', '1');
INSERT INTO `weiapp_region` VALUES ('210302', '铁东区', '210300', '86.210000.210300.210302', '中国.辽宁省.鞍山市.铁东区', '1');
INSERT INTO `weiapp_region` VALUES ('210303', '铁西区', '210300', '86.210000.210300.210303', '中国.辽宁省.鞍山市.铁西区', '1');
INSERT INTO `weiapp_region` VALUES ('210304', '立山区', '210300', '86.210000.210300.210304', '中国.辽宁省.鞍山市.立山区', '1');
INSERT INTO `weiapp_region` VALUES ('210311', '千山区', '210300', '86.210000.210300.210311', '中国.辽宁省.鞍山市.千山区', '1');
INSERT INTO `weiapp_region` VALUES ('210321', '台安县', '210300', '86.210000.210300.210321', '中国.辽宁省.鞍山市.台安县', '1');
INSERT INTO `weiapp_region` VALUES ('210323', '岫岩满族自治县', '210300', '86.210000.210300.210323', '中国.辽宁省.鞍山市.岫岩满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('210381', '海城市', '210300', '86.210000.210300.210381', '中国.辽宁省.鞍山市.海城市', '1');
INSERT INTO `weiapp_region` VALUES ('210400', '抚顺市', '210000', '86.210000.210400', '中国.辽宁省.抚顺市', '1');
INSERT INTO `weiapp_region` VALUES ('210402', '新抚区', '210400', '86.210000.210400.210402', '中国.辽宁省.抚顺市.新抚区', '1');
INSERT INTO `weiapp_region` VALUES ('210403', '东洲区', '210400', '86.210000.210400.210403', '中国.辽宁省.抚顺市.东洲区', '1');
INSERT INTO `weiapp_region` VALUES ('210404', '望花区', '210400', '86.210000.210400.210404', '中国.辽宁省.抚顺市.望花区', '1');
INSERT INTO `weiapp_region` VALUES ('210411', '顺城区', '210400', '86.210000.210400.210411', '中国.辽宁省.抚顺市.顺城区', '1');
INSERT INTO `weiapp_region` VALUES ('210421', '抚顺县', '210400', '86.210000.210400.210421', '中国.辽宁省.抚顺市.抚顺县', '1');
INSERT INTO `weiapp_region` VALUES ('210422', '新宾满族自治县', '210400', '86.210000.210400.210422', '中国.辽宁省.抚顺市.新宾满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('210423', '清原满族自治县', '210400', '86.210000.210400.210423', '中国.辽宁省.抚顺市.清原满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('210500', '本溪市', '210000', '86.210000.210500', '中国.辽宁省.本溪市', '1');
INSERT INTO `weiapp_region` VALUES ('210502', '平山区', '210500', '86.210000.210500.210502', '中国.辽宁省.本溪市.平山区', '1');
INSERT INTO `weiapp_region` VALUES ('210503', '溪湖区', '210500', '86.210000.210500.210503', '中国.辽宁省.本溪市.溪湖区', '1');
INSERT INTO `weiapp_region` VALUES ('210504', '明山区', '210500', '86.210000.210500.210504', '中国.辽宁省.本溪市.明山区', '1');
INSERT INTO `weiapp_region` VALUES ('210505', '南芬区', '210500', '86.210000.210500.210505', '中国.辽宁省.本溪市.南芬区', '1');
INSERT INTO `weiapp_region` VALUES ('210521', '本溪满族自治县', '210500', '86.210000.210500.210521', '中国.辽宁省.本溪市.本溪满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('210522', '桓仁满族自治县', '210500', '86.210000.210500.210522', '中国.辽宁省.本溪市.桓仁满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('210600', '丹东市', '210000', '86.210000.210600', '中国.辽宁省.丹东市', '1');
INSERT INTO `weiapp_region` VALUES ('210602', '元宝区', '210600', '86.210000.210600.210602', '中国.辽宁省.丹东市.元宝区', '1');
INSERT INTO `weiapp_region` VALUES ('210603', '振兴区', '210600', '86.210000.210600.210603', '中国.辽宁省.丹东市.振兴区', '1');
INSERT INTO `weiapp_region` VALUES ('210604', '振安区', '210600', '86.210000.210600.210604', '中国.辽宁省.丹东市.振安区', '1');
INSERT INTO `weiapp_region` VALUES ('210624', '宽甸满族自治县', '210600', '86.210000.210600.210624', '中国.辽宁省.丹东市.宽甸满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('210681', '东港市', '210600', '86.210000.210600.210681', '中国.辽宁省.丹东市.东港市', '1');
INSERT INTO `weiapp_region` VALUES ('210682', '凤城市', '210600', '86.210000.210600.210682', '中国.辽宁省.丹东市.凤城市', '1');
INSERT INTO `weiapp_region` VALUES ('210700', '锦州市', '210000', '86.210000.210700', '中国.辽宁省.锦州市', '1');
INSERT INTO `weiapp_region` VALUES ('210702', '古塔区', '210700', '86.210000.210700.210702', '中国.辽宁省.锦州市.古塔区', '1');
INSERT INTO `weiapp_region` VALUES ('210703', '凌河区', '210700', '86.210000.210700.210703', '中国.辽宁省.锦州市.凌河区', '1');
INSERT INTO `weiapp_region` VALUES ('210711', '太和区', '210700', '86.210000.210700.210711', '中国.辽宁省.锦州市.太和区', '1');
INSERT INTO `weiapp_region` VALUES ('210726', '黑山县', '210700', '86.210000.210700.210726', '中国.辽宁省.锦州市.黑山县', '1');
INSERT INTO `weiapp_region` VALUES ('210727', '义县', '210700', '86.210000.210700.210727', '中国.辽宁省.锦州市.义县', '1');
INSERT INTO `weiapp_region` VALUES ('210781', '凌海市', '210700', '86.210000.210700.210781', '中国.辽宁省.锦州市.凌海市', '1');
INSERT INTO `weiapp_region` VALUES ('210782', '北镇市', '210700', '86.210000.210700.210782', '中国.辽宁省.锦州市.北镇市', '1');
INSERT INTO `weiapp_region` VALUES ('210800', '营口市', '210000', '86.210000.210800', '中国.辽宁省.营口市', '1');
INSERT INTO `weiapp_region` VALUES ('210802', '站前区', '210800', '86.210000.210800.210802', '中国.辽宁省.营口市.站前区', '1');
INSERT INTO `weiapp_region` VALUES ('210803', '西市区', '210800', '86.210000.210800.210803', '中国.辽宁省.营口市.西市区', '1');
INSERT INTO `weiapp_region` VALUES ('210804', '鲅鱼圈区', '210800', '86.210000.210800.210804', '中国.辽宁省.营口市.鲅鱼圈区', '1');
INSERT INTO `weiapp_region` VALUES ('210811', '老边区', '210800', '86.210000.210800.210811', '中国.辽宁省.营口市.老边区', '1');
INSERT INTO `weiapp_region` VALUES ('210881', '盖州市', '210800', '86.210000.210800.210881', '中国.辽宁省.营口市.盖州市', '1');
INSERT INTO `weiapp_region` VALUES ('210882', '大石桥市', '210800', '86.210000.210800.210882', '中国.辽宁省.营口市.大石桥市', '1');
INSERT INTO `weiapp_region` VALUES ('210900', '阜新市', '210000', '86.210000.210900', '中国.辽宁省.阜新市', '1');
INSERT INTO `weiapp_region` VALUES ('210902', '海州区', '210900', '86.210000.210900.210902', '中国.辽宁省.阜新市.海州区', '1');
INSERT INTO `weiapp_region` VALUES ('210903', '新邱区', '210900', '86.210000.210900.210903', '中国.辽宁省.阜新市.新邱区', '1');
INSERT INTO `weiapp_region` VALUES ('210904', '太平区', '210900', '86.210000.210900.210904', '中国.辽宁省.阜新市.太平区', '1');
INSERT INTO `weiapp_region` VALUES ('210905', '清河门区', '210900', '86.210000.210900.210905', '中国.辽宁省.阜新市.清河门区', '1');
INSERT INTO `weiapp_region` VALUES ('210911', '细河区', '210900', '86.210000.210900.210911', '中国.辽宁省.阜新市.细河区', '1');
INSERT INTO `weiapp_region` VALUES ('210921', '阜新蒙古族自治县', '210900', '86.210000.210900.210921', '中国.辽宁省.阜新市.阜新蒙古族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('210922', '彰武县', '210900', '86.210000.210900.210922', '中国.辽宁省.阜新市.彰武县', '1');
INSERT INTO `weiapp_region` VALUES ('211000', '辽阳市', '210000', '86.210000.211000', '中国.辽宁省.辽阳市', '1');
INSERT INTO `weiapp_region` VALUES ('211002', '白塔区', '211000', '86.210000.211000.211002', '中国.辽宁省.辽阳市.白塔区', '1');
INSERT INTO `weiapp_region` VALUES ('211003', '文圣区', '211000', '86.210000.211000.211003', '中国.辽宁省.辽阳市.文圣区', '1');
INSERT INTO `weiapp_region` VALUES ('211004', '宏伟区', '211000', '86.210000.211000.211004', '中国.辽宁省.辽阳市.宏伟区', '1');
INSERT INTO `weiapp_region` VALUES ('211005', '弓长岭区', '211000', '86.210000.211000.211005', '中国.辽宁省.辽阳市.弓长岭区', '1');
INSERT INTO `weiapp_region` VALUES ('211011', '太子河区', '211000', '86.210000.211000.211011', '中国.辽宁省.辽阳市.太子河区', '1');
INSERT INTO `weiapp_region` VALUES ('211021', '辽阳县', '211000', '86.210000.211000.211021', '中国.辽宁省.辽阳市.辽阳县', '1');
INSERT INTO `weiapp_region` VALUES ('211081', '灯塔市', '211000', '86.210000.211000.211081', '中国.辽宁省.辽阳市.灯塔市', '1');
INSERT INTO `weiapp_region` VALUES ('211100', '盘锦市', '210000', '86.210000.211100', '中国.辽宁省.盘锦市', '1');
INSERT INTO `weiapp_region` VALUES ('211102', '双台子区', '211100', '86.210000.211100.211102', '中国.辽宁省.盘锦市.双台子区', '1');
INSERT INTO `weiapp_region` VALUES ('211103', '兴隆台区', '211100', '86.210000.211100.211103', '中国.辽宁省.盘锦市.兴隆台区', '1');
INSERT INTO `weiapp_region` VALUES ('211121', '大洼县', '211100', '86.210000.211100.211121', '中国.辽宁省.盘锦市.大洼县', '1');
INSERT INTO `weiapp_region` VALUES ('211122', '盘山县', '211100', '86.210000.211100.211122', '中国.辽宁省.盘锦市.盘山县', '1');
INSERT INTO `weiapp_region` VALUES ('211200', '铁岭市', '210000', '86.210000.211200', '中国.辽宁省.铁岭市', '1');
INSERT INTO `weiapp_region` VALUES ('211202', '银州区', '211200', '86.210000.211200.211202', '中国.辽宁省.铁岭市.银州区', '1');
INSERT INTO `weiapp_region` VALUES ('211204', '清河区', '211200', '86.210000.211200.211204', '中国.辽宁省.铁岭市.清河区', '1');
INSERT INTO `weiapp_region` VALUES ('211221', '铁岭县', '211200', '86.210000.211200.211221', '中国.辽宁省.铁岭市.铁岭县', '1');
INSERT INTO `weiapp_region` VALUES ('211223', '西丰县', '211200', '86.210000.211200.211223', '中国.辽宁省.铁岭市.西丰县', '1');
INSERT INTO `weiapp_region` VALUES ('211224', '昌图县', '211200', '86.210000.211200.211224', '中国.辽宁省.铁岭市.昌图县', '1');
INSERT INTO `weiapp_region` VALUES ('211281', '调兵山市', '211200', '86.210000.211200.211281', '中国.辽宁省.铁岭市.调兵山市', '1');
INSERT INTO `weiapp_region` VALUES ('211282', '开原市', '211200', '86.210000.211200.211282', '中国.辽宁省.铁岭市.开原市', '1');
INSERT INTO `weiapp_region` VALUES ('211300', '朝阳市', '210000', '86.210000.211300', '中国.辽宁省.朝阳市', '1');
INSERT INTO `weiapp_region` VALUES ('211302', '双塔区', '211300', '86.210000.211300.211302', '中国.辽宁省.朝阳市.双塔区', '1');
INSERT INTO `weiapp_region` VALUES ('211303', '龙城区', '211300', '86.210000.211300.211303', '中国.辽宁省.朝阳市.龙城区', '1');
INSERT INTO `weiapp_region` VALUES ('211321', '朝阳县', '211300', '86.210000.211300.211321', '中国.辽宁省.朝阳市.朝阳县', '1');
INSERT INTO `weiapp_region` VALUES ('211322', '建平县', '211300', '86.210000.211300.211322', '中国.辽宁省.朝阳市.建平县', '1');
INSERT INTO `weiapp_region` VALUES ('211324', '喀喇沁左翼蒙古族自治县', '211300', '86.210000.211300.211324', '中国.辽宁省.朝阳市.喀喇沁左翼蒙古族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('211381', '北票市', '211300', '86.210000.211300.211381', '中国.辽宁省.朝阳市.北票市', '1');
INSERT INTO `weiapp_region` VALUES ('211382', '凌源市', '211300', '86.210000.211300.211382', '中国.辽宁省.朝阳市.凌源市', '1');
INSERT INTO `weiapp_region` VALUES ('211400', '葫芦岛市', '210000', '86.210000.211400', '中国.辽宁省.葫芦岛市', '1');
INSERT INTO `weiapp_region` VALUES ('211402', '连山区', '211400', '86.210000.211400.211402', '中国.辽宁省.葫芦岛市.连山区', '1');
INSERT INTO `weiapp_region` VALUES ('211403', '龙港区', '211400', '86.210000.211400.211403', '中国.辽宁省.葫芦岛市.龙港区', '1');
INSERT INTO `weiapp_region` VALUES ('211404', '南票区', '211400', '86.210000.211400.211404', '中国.辽宁省.葫芦岛市.南票区', '1');
INSERT INTO `weiapp_region` VALUES ('211421', '绥中县', '211400', '86.210000.211400.211421', '中国.辽宁省.葫芦岛市.绥中县', '1');
INSERT INTO `weiapp_region` VALUES ('211422', '建昌县', '211400', '86.210000.211400.211422', '中国.辽宁省.葫芦岛市.建昌县', '1');
INSERT INTO `weiapp_region` VALUES ('211481', '兴城市', '211400', '86.210000.211400.211481', '中国.辽宁省.葫芦岛市.兴城市', '1');
INSERT INTO `weiapp_region` VALUES ('220000', '吉林省', '86', '86.220000', '中国.吉林省', '1');
INSERT INTO `weiapp_region` VALUES ('220100', '长春市', '220000', '86.220000.220100', '中国.吉林省.长春市', '1');
INSERT INTO `weiapp_region` VALUES ('220102', '南关区', '220100', '86.220000.220100.220102', '中国.吉林省.长春市.南关区', '1');
INSERT INTO `weiapp_region` VALUES ('220103', '宽城区', '220100', '86.220000.220100.220103', '中国.吉林省.长春市.宽城区', '1');
INSERT INTO `weiapp_region` VALUES ('220104', '朝阳区', '220100', '86.220000.220100.220104', '中国.吉林省.长春市.朝阳区', '1');
INSERT INTO `weiapp_region` VALUES ('220105', '二道区', '220100', '86.220000.220100.220105', '中国.吉林省.长春市.二道区', '1');
INSERT INTO `weiapp_region` VALUES ('220106', '绿园区', '220100', '86.220000.220100.220106', '中国.吉林省.长春市.绿园区', '1');
INSERT INTO `weiapp_region` VALUES ('220112', '双阳区', '220100', '86.220000.220100.220112', '中国.吉林省.长春市.双阳区', '1');
INSERT INTO `weiapp_region` VALUES ('220122', '农安县', '220100', '86.220000.220100.220122', '中国.吉林省.长春市.农安县', '1');
INSERT INTO `weiapp_region` VALUES ('220181', '九台市', '220100', '86.220000.220100.220181', '中国.吉林省.长春市.九台市', '1');
INSERT INTO `weiapp_region` VALUES ('220182', '榆树市', '220100', '86.220000.220100.220182', '中国.吉林省.长春市.榆树市', '1');
INSERT INTO `weiapp_region` VALUES ('220183', '德惠市', '220100', '86.220000.220100.220183', '中国.吉林省.长春市.德惠市', '1');
INSERT INTO `weiapp_region` VALUES ('220200', '吉林市', '220000', '86.220000.220200', '中国.吉林省.吉林市', '1');
INSERT INTO `weiapp_region` VALUES ('220202', '昌邑区', '220200', '86.220000.220200.220202', '中国.吉林省.吉林市.昌邑区', '1');
INSERT INTO `weiapp_region` VALUES ('220203', '龙潭区', '220200', '86.220000.220200.220203', '中国.吉林省.吉林市.龙潭区', '1');
INSERT INTO `weiapp_region` VALUES ('220204', '船营区', '220200', '86.220000.220200.220204', '中国.吉林省.吉林市.船营区', '1');
INSERT INTO `weiapp_region` VALUES ('220211', '丰满区', '220200', '86.220000.220200.220211', '中国.吉林省.吉林市.丰满区', '1');
INSERT INTO `weiapp_region` VALUES ('220221', '永吉县', '220200', '86.220000.220200.220221', '中国.吉林省.吉林市.永吉县', '1');
INSERT INTO `weiapp_region` VALUES ('220281', '蛟河市', '220200', '86.220000.220200.220281', '中国.吉林省.吉林市.蛟河市', '1');
INSERT INTO `weiapp_region` VALUES ('220282', '桦甸市', '220200', '86.220000.220200.220282', '中国.吉林省.吉林市.桦甸市', '1');
INSERT INTO `weiapp_region` VALUES ('220283', '舒兰市', '220200', '86.220000.220200.220283', '中国.吉林省.吉林市.舒兰市', '1');
INSERT INTO `weiapp_region` VALUES ('220284', '磐石市', '220200', '86.220000.220200.220284', '中国.吉林省.吉林市.磐石市', '1');
INSERT INTO `weiapp_region` VALUES ('220300', '四平市', '220000', '86.220000.220300', '中国.吉林省.四平市', '1');
INSERT INTO `weiapp_region` VALUES ('220302', '铁西区', '220300', '86.220000.220300.220302', '中国.吉林省.四平市.铁西区', '1');
INSERT INTO `weiapp_region` VALUES ('220303', '铁东区', '220300', '86.220000.220300.220303', '中国.吉林省.四平市.铁东区', '1');
INSERT INTO `weiapp_region` VALUES ('220322', '梨树县', '220300', '86.220000.220300.220322', '中国.吉林省.四平市.梨树县', '1');
INSERT INTO `weiapp_region` VALUES ('220323', '伊通满族自治县', '220300', '86.220000.220300.220323', '中国.吉林省.四平市.伊通满族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('220381', '公主岭市', '220300', '86.220000.220300.220381', '中国.吉林省.四平市.公主岭市', '1');
INSERT INTO `weiapp_region` VALUES ('220382', '双辽市', '220300', '86.220000.220300.220382', '中国.吉林省.四平市.双辽市', '1');
INSERT INTO `weiapp_region` VALUES ('220400', '辽源市', '220000', '86.220000.220400', '中国.吉林省.辽源市', '1');
INSERT INTO `weiapp_region` VALUES ('220402', '龙山区', '220400', '86.220000.220400.220402', '中国.吉林省.辽源市.龙山区', '1');
INSERT INTO `weiapp_region` VALUES ('220403', '西安区', '220400', '86.220000.220400.220403', '中国.吉林省.辽源市.西安区', '1');
INSERT INTO `weiapp_region` VALUES ('220421', '东丰县', '220400', '86.220000.220400.220421', '中国.吉林省.辽源市.东丰县', '1');
INSERT INTO `weiapp_region` VALUES ('220422', '东辽县', '220400', '86.220000.220400.220422', '中国.吉林省.辽源市.东辽县', '1');
INSERT INTO `weiapp_region` VALUES ('220500', '通化市', '220000', '86.220000.220500', '中国.吉林省.通化市', '1');
INSERT INTO `weiapp_region` VALUES ('220502', '东昌区', '220500', '86.220000.220500.220502', '中国.吉林省.通化市.东昌区', '1');
INSERT INTO `weiapp_region` VALUES ('220503', '二道江区', '220500', '86.220000.220500.220503', '中国.吉林省.通化市.二道江区', '1');
INSERT INTO `weiapp_region` VALUES ('220521', '通化县', '220500', '86.220000.220500.220521', '中国.吉林省.通化市.通化县', '1');
INSERT INTO `weiapp_region` VALUES ('220523', '辉南县', '220500', '86.220000.220500.220523', '中国.吉林省.通化市.辉南县', '1');
INSERT INTO `weiapp_region` VALUES ('220524', '柳河县', '220500', '86.220000.220500.220524', '中国.吉林省.通化市.柳河县', '1');
INSERT INTO `weiapp_region` VALUES ('220581', '梅河口市', '220500', '86.220000.220500.220581', '中国.吉林省.通化市.梅河口市', '1');
INSERT INTO `weiapp_region` VALUES ('220582', '集安市', '220500', '86.220000.220500.220582', '中国.吉林省.通化市.集安市', '1');
INSERT INTO `weiapp_region` VALUES ('220600', '白山市', '220000', '86.220000.220600', '中国.吉林省.白山市', '1');
INSERT INTO `weiapp_region` VALUES ('220602', '八道江区', '220600', '86.220000.220600.220602', '中国.吉林省.白山市.八道江区', '1');
INSERT INTO `weiapp_region` VALUES ('220605', '江源区', '220600', '86.220000.220600.220605', '中国.吉林省.白山市.江源区', '1');
INSERT INTO `weiapp_region` VALUES ('220621', '抚松县', '220600', '86.220000.220600.220621', '中国.吉林省.白山市.抚松县', '1');
INSERT INTO `weiapp_region` VALUES ('220622', '靖宇县', '220600', '86.220000.220600.220622', '中国.吉林省.白山市.靖宇县', '1');
INSERT INTO `weiapp_region` VALUES ('220623', '长白朝鲜族自治县', '220600', '86.220000.220600.220623', '中国.吉林省.白山市.长白朝鲜族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('220681', '临江市', '220600', '86.220000.220600.220681', '中国.吉林省.白山市.临江市', '1');
INSERT INTO `weiapp_region` VALUES ('220700', '松原市', '220000', '86.220000.220700', '中国.吉林省.松原市', '1');
INSERT INTO `weiapp_region` VALUES ('220702', '宁江区', '220700', '86.220000.220700.220702', '中国.吉林省.松原市.宁江区', '1');
INSERT INTO `weiapp_region` VALUES ('220721', '前郭尔罗斯蒙古族自治县', '220700', '86.220000.220700.220721', '中国.吉林省.松原市.前郭尔罗斯蒙古族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('220722', '长岭县', '220700', '86.220000.220700.220722', '中国.吉林省.松原市.长岭县', '1');
INSERT INTO `weiapp_region` VALUES ('220723', '乾安县', '220700', '86.220000.220700.220723', '中国.吉林省.松原市.乾安县', '1');
INSERT INTO `weiapp_region` VALUES ('220724', '扶余县', '220700', '86.220000.220700.220724', '中国.吉林省.松原市.扶余县', '1');
INSERT INTO `weiapp_region` VALUES ('220800', '白城市', '220000', '86.220000.220800', '中国.吉林省.白城市', '1');
INSERT INTO `weiapp_region` VALUES ('220802', '洮北区', '220800', '86.220000.220800.220802', '中国.吉林省.白城市.洮北区', '1');
INSERT INTO `weiapp_region` VALUES ('220821', '镇赉县', '220800', '86.220000.220800.220821', '中国.吉林省.白城市.镇赉县', '1');
INSERT INTO `weiapp_region` VALUES ('220822', '通榆县', '220800', '86.220000.220800.220822', '中国.吉林省.白城市.通榆县', '1');
INSERT INTO `weiapp_region` VALUES ('220881', '洮南市', '220800', '86.220000.220800.220881', '中国.吉林省.白城市.洮南市', '1');
INSERT INTO `weiapp_region` VALUES ('220882', '大安市', '220800', '86.220000.220800.220882', '中国.吉林省.白城市.大安市', '1');
INSERT INTO `weiapp_region` VALUES ('222400', '延边朝鲜族自治州', '220000', '86.220000.222400', '中国.吉林省.延边朝鲜族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('222401', '延吉市', '222400', '86.220000.222400.222401', '中国.吉林省.延边朝鲜族自治州.延吉市', '1');
INSERT INTO `weiapp_region` VALUES ('222402', '图们市', '222400', '86.220000.222400.222402', '中国.吉林省.延边朝鲜族自治州.图们市', '1');
INSERT INTO `weiapp_region` VALUES ('222403', '敦化市', '222400', '86.220000.222400.222403', '中国.吉林省.延边朝鲜族自治州.敦化市', '1');
INSERT INTO `weiapp_region` VALUES ('222404', '珲春市', '222400', '86.220000.222400.222404', '中国.吉林省.延边朝鲜族自治州.珲春市', '1');
INSERT INTO `weiapp_region` VALUES ('222405', '龙井市', '222400', '86.220000.222400.222405', '中国.吉林省.延边朝鲜族自治州.龙井市', '1');
INSERT INTO `weiapp_region` VALUES ('222406', '和龙市', '222400', '86.220000.222400.222406', '中国.吉林省.延边朝鲜族自治州.和龙市', '1');
INSERT INTO `weiapp_region` VALUES ('222424', '汪清县', '222400', '86.220000.222400.222424', '中国.吉林省.延边朝鲜族自治州.汪清县', '1');
INSERT INTO `weiapp_region` VALUES ('222426', '安图县', '222400', '86.220000.222400.222426', '中国.吉林省.延边朝鲜族自治州.安图县', '1');
INSERT INTO `weiapp_region` VALUES ('230000', '黑龙江省', '86', '86.230000', '中国.黑龙江省', '1');
INSERT INTO `weiapp_region` VALUES ('230100', '哈尔滨市', '230000', '86.230000.230100', '中国.黑龙江省.哈尔滨市', '1');
INSERT INTO `weiapp_region` VALUES ('230102', '道里区', '230100', '86.230000.230100.230102', '中国.黑龙江省.哈尔滨市.道里区', '1');
INSERT INTO `weiapp_region` VALUES ('230103', '南岗区', '230100', '86.230000.230100.230103', '中国.黑龙江省.哈尔滨市.南岗区', '1');
INSERT INTO `weiapp_region` VALUES ('230104', '道外区', '230100', '86.230000.230100.230104', '中国.黑龙江省.哈尔滨市.道外区', '1');
INSERT INTO `weiapp_region` VALUES ('230108', '平房区', '230100', '86.230000.230100.230108', '中国.黑龙江省.哈尔滨市.平房区', '1');
INSERT INTO `weiapp_region` VALUES ('230109', '松北区', '230100', '86.230000.230100.230109', '中国.黑龙江省.哈尔滨市.松北区', '1');
INSERT INTO `weiapp_region` VALUES ('230110', '香坊区', '230100', '86.230000.230100.230110', '中国.黑龙江省.哈尔滨市.香坊区', '1');
INSERT INTO `weiapp_region` VALUES ('230111', '呼兰区', '230100', '86.230000.230100.230111', '中国.黑龙江省.哈尔滨市.呼兰区', '1');
INSERT INTO `weiapp_region` VALUES ('230112', '阿城区', '230100', '86.230000.230100.230112', '中国.黑龙江省.哈尔滨市.阿城区', '1');
INSERT INTO `weiapp_region` VALUES ('230123', '依兰县', '230100', '86.230000.230100.230123', '中国.黑龙江省.哈尔滨市.依兰县', '1');
INSERT INTO `weiapp_region` VALUES ('230124', '方正县', '230100', '86.230000.230100.230124', '中国.黑龙江省.哈尔滨市.方正县', '1');
INSERT INTO `weiapp_region` VALUES ('230125', '宾县', '230100', '86.230000.230100.230125', '中国.黑龙江省.哈尔滨市.宾县', '1');
INSERT INTO `weiapp_region` VALUES ('230126', '巴彦县', '230100', '86.230000.230100.230126', '中国.黑龙江省.哈尔滨市.巴彦县', '1');
INSERT INTO `weiapp_region` VALUES ('230127', '木兰县', '230100', '86.230000.230100.230127', '中国.黑龙江省.哈尔滨市.木兰县', '1');
INSERT INTO `weiapp_region` VALUES ('230128', '通河县', '230100', '86.230000.230100.230128', '中国.黑龙江省.哈尔滨市.通河县', '1');
INSERT INTO `weiapp_region` VALUES ('230129', '延寿县', '230100', '86.230000.230100.230129', '中国.黑龙江省.哈尔滨市.延寿县', '1');
INSERT INTO `weiapp_region` VALUES ('230182', '双城市', '230100', '86.230000.230100.230182', '中国.黑龙江省.哈尔滨市.双城市', '1');
INSERT INTO `weiapp_region` VALUES ('230183', '尚志市', '230100', '86.230000.230100.230183', '中国.黑龙江省.哈尔滨市.尚志市', '1');
INSERT INTO `weiapp_region` VALUES ('230184', '五常市', '230100', '86.230000.230100.230184', '中国.黑龙江省.哈尔滨市.五常市', '1');
INSERT INTO `weiapp_region` VALUES ('230200', '齐齐哈尔市', '230000', '86.230000.230200', '中国.黑龙江省.齐齐哈尔市', '1');
INSERT INTO `weiapp_region` VALUES ('230202', '龙沙区', '230200', '86.230000.230200.230202', '中国.黑龙江省.齐齐哈尔市.龙沙区', '1');
INSERT INTO `weiapp_region` VALUES ('230203', '建华区', '230200', '86.230000.230200.230203', '中国.黑龙江省.齐齐哈尔市.建华区', '1');
INSERT INTO `weiapp_region` VALUES ('230204', '铁锋区', '230200', '86.230000.230200.230204', '中国.黑龙江省.齐齐哈尔市.铁锋区', '1');
INSERT INTO `weiapp_region` VALUES ('230205', '昂昂溪区', '230200', '86.230000.230200.230205', '中国.黑龙江省.齐齐哈尔市.昂昂溪区', '1');
INSERT INTO `weiapp_region` VALUES ('230206', '富拉尔基区', '230200', '86.230000.230200.230206', '中国.黑龙江省.齐齐哈尔市.富拉尔基区', '1');
INSERT INTO `weiapp_region` VALUES ('230207', '碾子山区', '230200', '86.230000.230200.230207', '中国.黑龙江省.齐齐哈尔市.碾子山区', '1');
INSERT INTO `weiapp_region` VALUES ('230208', '梅里斯达斡尔族区', '230200', '86.230000.230200.230208', '中国.黑龙江省.齐齐哈尔市.梅里斯达斡尔族区', '1');
INSERT INTO `weiapp_region` VALUES ('230221', '龙江县', '230200', '86.230000.230200.230221', '中国.黑龙江省.齐齐哈尔市.龙江县', '1');
INSERT INTO `weiapp_region` VALUES ('230223', '依安县', '230200', '86.230000.230200.230223', '中国.黑龙江省.齐齐哈尔市.依安县', '1');
INSERT INTO `weiapp_region` VALUES ('230224', '泰来县', '230200', '86.230000.230200.230224', '中国.黑龙江省.齐齐哈尔市.泰来县', '1');
INSERT INTO `weiapp_region` VALUES ('230225', '甘南县', '230200', '86.230000.230200.230225', '中国.黑龙江省.齐齐哈尔市.甘南县', '1');
INSERT INTO `weiapp_region` VALUES ('230227', '富裕县', '230200', '86.230000.230200.230227', '中国.黑龙江省.齐齐哈尔市.富裕县', '1');
INSERT INTO `weiapp_region` VALUES ('230229', '克山县', '230200', '86.230000.230200.230229', '中国.黑龙江省.齐齐哈尔市.克山县', '1');
INSERT INTO `weiapp_region` VALUES ('230230', '克东县', '230200', '86.230000.230200.230230', '中国.黑龙江省.齐齐哈尔市.克东县', '1');
INSERT INTO `weiapp_region` VALUES ('230231', '拜泉县', '230200', '86.230000.230200.230231', '中国.黑龙江省.齐齐哈尔市.拜泉县', '1');
INSERT INTO `weiapp_region` VALUES ('230281', '讷河市', '230200', '86.230000.230200.230281', '中国.黑龙江省.齐齐哈尔市.讷河市', '1');
INSERT INTO `weiapp_region` VALUES ('230300', '鸡西市', '230000', '86.230000.230300', '中国.黑龙江省.鸡西市', '1');
INSERT INTO `weiapp_region` VALUES ('230302', '鸡冠区', '230300', '86.230000.230300.230302', '中国.黑龙江省.鸡西市.鸡冠区', '1');
INSERT INTO `weiapp_region` VALUES ('230303', '恒山区', '230300', '86.230000.230300.230303', '中国.黑龙江省.鸡西市.恒山区', '1');
INSERT INTO `weiapp_region` VALUES ('230304', '滴道区', '230300', '86.230000.230300.230304', '中国.黑龙江省.鸡西市.滴道区', '1');
INSERT INTO `weiapp_region` VALUES ('230305', '梨树区', '230300', '86.230000.230300.230305', '中国.黑龙江省.鸡西市.梨树区', '1');
INSERT INTO `weiapp_region` VALUES ('230306', '城子河区', '230300', '86.230000.230300.230306', '中国.黑龙江省.鸡西市.城子河区', '1');
INSERT INTO `weiapp_region` VALUES ('230307', '麻山区', '230300', '86.230000.230300.230307', '中国.黑龙江省.鸡西市.麻山区', '1');
INSERT INTO `weiapp_region` VALUES ('230321', '鸡东县', '230300', '86.230000.230300.230321', '中国.黑龙江省.鸡西市.鸡东县', '1');
INSERT INTO `weiapp_region` VALUES ('230381', '虎林市', '230300', '86.230000.230300.230381', '中国.黑龙江省.鸡西市.虎林市', '1');
INSERT INTO `weiapp_region` VALUES ('230382', '密山市', '230300', '86.230000.230300.230382', '中国.黑龙江省.鸡西市.密山市', '1');
INSERT INTO `weiapp_region` VALUES ('230400', '鹤岗市', '230000', '86.230000.230400', '中国.黑龙江省.鹤岗市', '1');
INSERT INTO `weiapp_region` VALUES ('230402', '向阳区', '230400', '86.230000.230400.230402', '中国.黑龙江省.鹤岗市.向阳区', '1');
INSERT INTO `weiapp_region` VALUES ('230403', '工农区', '230400', '86.230000.230400.230403', '中国.黑龙江省.鹤岗市.工农区', '1');
INSERT INTO `weiapp_region` VALUES ('230404', '南山区', '230400', '86.230000.230400.230404', '中国.黑龙江省.鹤岗市.南山区', '1');
INSERT INTO `weiapp_region` VALUES ('230405', '兴安区', '230400', '86.230000.230400.230405', '中国.黑龙江省.鹤岗市.兴安区', '1');
INSERT INTO `weiapp_region` VALUES ('230406', '东山区', '230400', '86.230000.230400.230406', '中国.黑龙江省.鹤岗市.东山区', '1');
INSERT INTO `weiapp_region` VALUES ('230407', '兴山区', '230400', '86.230000.230400.230407', '中国.黑龙江省.鹤岗市.兴山区', '1');
INSERT INTO `weiapp_region` VALUES ('230421', '萝北县', '230400', '86.230000.230400.230421', '中国.黑龙江省.鹤岗市.萝北县', '1');
INSERT INTO `weiapp_region` VALUES ('230422', '绥滨县', '230400', '86.230000.230400.230422', '中国.黑龙江省.鹤岗市.绥滨县', '1');
INSERT INTO `weiapp_region` VALUES ('230500', '双鸭山市', '230000', '86.230000.230500', '中国.黑龙江省.双鸭山市', '1');
INSERT INTO `weiapp_region` VALUES ('230502', '尖山区', '230500', '86.230000.230500.230502', '中国.黑龙江省.双鸭山市.尖山区', '1');
INSERT INTO `weiapp_region` VALUES ('230503', '岭东区', '230500', '86.230000.230500.230503', '中国.黑龙江省.双鸭山市.岭东区', '1');
INSERT INTO `weiapp_region` VALUES ('230505', '四方台区', '230500', '86.230000.230500.230505', '中国.黑龙江省.双鸭山市.四方台区', '1');
INSERT INTO `weiapp_region` VALUES ('230506', '宝山区', '230500', '86.230000.230500.230506', '中国.黑龙江省.双鸭山市.宝山区', '1');
INSERT INTO `weiapp_region` VALUES ('230521', '集贤县', '230500', '86.230000.230500.230521', '中国.黑龙江省.双鸭山市.集贤县', '1');
INSERT INTO `weiapp_region` VALUES ('230522', '友谊县', '230500', '86.230000.230500.230522', '中国.黑龙江省.双鸭山市.友谊县', '1');
INSERT INTO `weiapp_region` VALUES ('230523', '宝清县', '230500', '86.230000.230500.230523', '中国.黑龙江省.双鸭山市.宝清县', '1');
INSERT INTO `weiapp_region` VALUES ('230524', '饶河县', '230500', '86.230000.230500.230524', '中国.黑龙江省.双鸭山市.饶河县', '1');
INSERT INTO `weiapp_region` VALUES ('230600', '大庆市', '230000', '86.230000.230600', '中国.黑龙江省.大庆市', '1');
INSERT INTO `weiapp_region` VALUES ('230602', '萨尔图区', '230600', '86.230000.230600.230602', '中国.黑龙江省.大庆市.萨尔图区', '1');
INSERT INTO `weiapp_region` VALUES ('230603', '龙凤区', '230600', '86.230000.230600.230603', '中国.黑龙江省.大庆市.龙凤区', '1');
INSERT INTO `weiapp_region` VALUES ('230604', '让胡路区', '230600', '86.230000.230600.230604', '中国.黑龙江省.大庆市.让胡路区', '1');
INSERT INTO `weiapp_region` VALUES ('230605', '红岗区', '230600', '86.230000.230600.230605', '中国.黑龙江省.大庆市.红岗区', '1');
INSERT INTO `weiapp_region` VALUES ('230606', '大同区', '230600', '86.230000.230600.230606', '中国.黑龙江省.大庆市.大同区', '1');
INSERT INTO `weiapp_region` VALUES ('230621', '肇州县', '230600', '86.230000.230600.230621', '中国.黑龙江省.大庆市.肇州县', '1');
INSERT INTO `weiapp_region` VALUES ('230622', '肇源县', '230600', '86.230000.230600.230622', '中国.黑龙江省.大庆市.肇源县', '1');
INSERT INTO `weiapp_region` VALUES ('230623', '林甸县', '230600', '86.230000.230600.230623', '中国.黑龙江省.大庆市.林甸县', '1');
INSERT INTO `weiapp_region` VALUES ('230624', '杜尔伯特蒙古族自治县', '230600', '86.230000.230600.230624', '中国.黑龙江省.大庆市.杜尔伯特蒙古族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('230700', '伊春市', '230000', '86.230000.230700', '中国.黑龙江省.伊春市', '1');
INSERT INTO `weiapp_region` VALUES ('230702', '伊春区', '230700', '86.230000.230700.230702', '中国.黑龙江省.伊春市.伊春区', '1');
INSERT INTO `weiapp_region` VALUES ('230703', '南岔区', '230700', '86.230000.230700.230703', '中国.黑龙江省.伊春市.南岔区', '1');
INSERT INTO `weiapp_region` VALUES ('230704', '友好区', '230700', '86.230000.230700.230704', '中国.黑龙江省.伊春市.友好区', '1');
INSERT INTO `weiapp_region` VALUES ('230705', '西林区', '230700', '86.230000.230700.230705', '中国.黑龙江省.伊春市.西林区', '1');
INSERT INTO `weiapp_region` VALUES ('230706', '翠峦区', '230700', '86.230000.230700.230706', '中国.黑龙江省.伊春市.翠峦区', '1');
INSERT INTO `weiapp_region` VALUES ('230707', '新青区', '230700', '86.230000.230700.230707', '中国.黑龙江省.伊春市.新青区', '1');
INSERT INTO `weiapp_region` VALUES ('230708', '美溪区', '230700', '86.230000.230700.230708', '中国.黑龙江省.伊春市.美溪区', '1');
INSERT INTO `weiapp_region` VALUES ('230709', '金山屯区', '230700', '86.230000.230700.230709', '中国.黑龙江省.伊春市.金山屯区', '1');
INSERT INTO `weiapp_region` VALUES ('230710', '五营区', '230700', '86.230000.230700.230710', '中国.黑龙江省.伊春市.五营区', '1');
INSERT INTO `weiapp_region` VALUES ('230711', '乌马河区', '230700', '86.230000.230700.230711', '中国.黑龙江省.伊春市.乌马河区', '1');
INSERT INTO `weiapp_region` VALUES ('230712', '汤旺河区', '230700', '86.230000.230700.230712', '中国.黑龙江省.伊春市.汤旺河区', '1');
INSERT INTO `weiapp_region` VALUES ('230713', '带岭区', '230700', '86.230000.230700.230713', '中国.黑龙江省.伊春市.带岭区', '1');
INSERT INTO `weiapp_region` VALUES ('230714', '乌伊岭区', '230700', '86.230000.230700.230714', '中国.黑龙江省.伊春市.乌伊岭区', '1');
INSERT INTO `weiapp_region` VALUES ('230715', '红星区', '230700', '86.230000.230700.230715', '中国.黑龙江省.伊春市.红星区', '1');
INSERT INTO `weiapp_region` VALUES ('230716', '上甘岭区', '230700', '86.230000.230700.230716', '中国.黑龙江省.伊春市.上甘岭区', '1');
INSERT INTO `weiapp_region` VALUES ('230722', '嘉荫县', '230700', '86.230000.230700.230722', '中国.黑龙江省.伊春市.嘉荫县', '1');
INSERT INTO `weiapp_region` VALUES ('230781', '铁力市', '230700', '86.230000.230700.230781', '中国.黑龙江省.伊春市.铁力市', '1');
INSERT INTO `weiapp_region` VALUES ('230800', '佳木斯市', '230000', '86.230000.230800', '中国.黑龙江省.佳木斯市', '1');
INSERT INTO `weiapp_region` VALUES ('230803', '向阳区', '230800', '86.230000.230800.230803', '中国.黑龙江省.佳木斯市.向阳区', '1');
INSERT INTO `weiapp_region` VALUES ('230804', '前进区', '230800', '86.230000.230800.230804', '中国.黑龙江省.佳木斯市.前进区', '1');
INSERT INTO `weiapp_region` VALUES ('230805', '东风区', '230800', '86.230000.230800.230805', '中国.黑龙江省.佳木斯市.东风区', '1');
INSERT INTO `weiapp_region` VALUES ('230811', '郊区', '230800', '86.230000.230800.230811', '中国.黑龙江省.佳木斯市.郊区', '1');
INSERT INTO `weiapp_region` VALUES ('230822', '桦南县', '230800', '86.230000.230800.230822', '中国.黑龙江省.佳木斯市.桦南县', '1');
INSERT INTO `weiapp_region` VALUES ('230826', '桦川县', '230800', '86.230000.230800.230826', '中国.黑龙江省.佳木斯市.桦川县', '1');
INSERT INTO `weiapp_region` VALUES ('230828', '汤原县', '230800', '86.230000.230800.230828', '中国.黑龙江省.佳木斯市.汤原县', '1');
INSERT INTO `weiapp_region` VALUES ('230833', '抚远县', '230800', '86.230000.230800.230833', '中国.黑龙江省.佳木斯市.抚远县', '1');
INSERT INTO `weiapp_region` VALUES ('230881', '同江市', '230800', '86.230000.230800.230881', '中国.黑龙江省.佳木斯市.同江市', '1');
INSERT INTO `weiapp_region` VALUES ('230882', '富锦市', '230800', '86.230000.230800.230882', '中国.黑龙江省.佳木斯市.富锦市', '1');
INSERT INTO `weiapp_region` VALUES ('230900', '七台河市', '230000', '86.230000.230900', '中国.黑龙江省.七台河市', '1');
INSERT INTO `weiapp_region` VALUES ('230902', '新兴区', '230900', '86.230000.230900.230902', '中国.黑龙江省.七台河市.新兴区', '1');
INSERT INTO `weiapp_region` VALUES ('230903', '桃山区', '230900', '86.230000.230900.230903', '中国.黑龙江省.七台河市.桃山区', '1');
INSERT INTO `weiapp_region` VALUES ('230904', '茄子河区', '230900', '86.230000.230900.230904', '中国.黑龙江省.七台河市.茄子河区', '1');
INSERT INTO `weiapp_region` VALUES ('230921', '勃利县', '230900', '86.230000.230900.230921', '中国.黑龙江省.七台河市.勃利县', '1');
INSERT INTO `weiapp_region` VALUES ('231000', '牡丹江市', '230000', '86.230000.231000', '中国.黑龙江省.牡丹江市', '1');
INSERT INTO `weiapp_region` VALUES ('231002', '东安区', '231000', '86.230000.231000.231002', '中国.黑龙江省.牡丹江市.东安区', '1');
INSERT INTO `weiapp_region` VALUES ('231003', '阳明区', '231000', '86.230000.231000.231003', '中国.黑龙江省.牡丹江市.阳明区', '1');
INSERT INTO `weiapp_region` VALUES ('231004', '爱民区', '231000', '86.230000.231000.231004', '中国.黑龙江省.牡丹江市.爱民区', '1');
INSERT INTO `weiapp_region` VALUES ('231005', '西安区', '231000', '86.230000.231000.231005', '中国.黑龙江省.牡丹江市.西安区', '1');
INSERT INTO `weiapp_region` VALUES ('231024', '东宁县', '231000', '86.230000.231000.231024', '中国.黑龙江省.牡丹江市.东宁县', '1');
INSERT INTO `weiapp_region` VALUES ('231025', '林口县', '231000', '86.230000.231000.231025', '中国.黑龙江省.牡丹江市.林口县', '1');
INSERT INTO `weiapp_region` VALUES ('231081', '绥芬河市', '231000', '86.230000.231000.231081', '中国.黑龙江省.牡丹江市.绥芬河市', '1');
INSERT INTO `weiapp_region` VALUES ('231083', '海林市', '231000', '86.230000.231000.231083', '中国.黑龙江省.牡丹江市.海林市', '1');
INSERT INTO `weiapp_region` VALUES ('231084', '宁安市', '231000', '86.230000.231000.231084', '中国.黑龙江省.牡丹江市.宁安市', '1');
INSERT INTO `weiapp_region` VALUES ('231085', '穆棱市', '231000', '86.230000.231000.231085', '中国.黑龙江省.牡丹江市.穆棱市', '1');
INSERT INTO `weiapp_region` VALUES ('231100', '黑河市', '230000', '86.230000.231100', '中国.黑龙江省.黑河市', '1');
INSERT INTO `weiapp_region` VALUES ('231102', '爱辉区', '231100', '86.230000.231100.231102', '中国.黑龙江省.黑河市.爱辉区', '1');
INSERT INTO `weiapp_region` VALUES ('231121', '嫩江县', '231100', '86.230000.231100.231121', '中国.黑龙江省.黑河市.嫩江县', '1');
INSERT INTO `weiapp_region` VALUES ('231123', '逊克县', '231100', '86.230000.231100.231123', '中国.黑龙江省.黑河市.逊克县', '1');
INSERT INTO `weiapp_region` VALUES ('231124', '孙吴县', '231100', '86.230000.231100.231124', '中国.黑龙江省.黑河市.孙吴县', '1');
INSERT INTO `weiapp_region` VALUES ('231181', '北安市', '231100', '86.230000.231100.231181', '中国.黑龙江省.黑河市.北安市', '1');
INSERT INTO `weiapp_region` VALUES ('231182', '五大连池市', '231100', '86.230000.231100.231182', '中国.黑龙江省.黑河市.五大连池市', '1');
INSERT INTO `weiapp_region` VALUES ('231200', '绥化市', '230000', '86.230000.231200', '中国.黑龙江省.绥化市', '1');
INSERT INTO `weiapp_region` VALUES ('231202', '北林区', '231200', '86.230000.231200.231202', '中国.黑龙江省.绥化市.北林区', '1');
INSERT INTO `weiapp_region` VALUES ('231221', '望奎县', '231200', '86.230000.231200.231221', '中国.黑龙江省.绥化市.望奎县', '1');
INSERT INTO `weiapp_region` VALUES ('231222', '兰西县', '231200', '86.230000.231200.231222', '中国.黑龙江省.绥化市.兰西县', '1');
INSERT INTO `weiapp_region` VALUES ('231223', '青冈县', '231200', '86.230000.231200.231223', '中国.黑龙江省.绥化市.青冈县', '1');
INSERT INTO `weiapp_region` VALUES ('231224', '庆安县', '231200', '86.230000.231200.231224', '中国.黑龙江省.绥化市.庆安县', '1');
INSERT INTO `weiapp_region` VALUES ('231225', '明水县', '231200', '86.230000.231200.231225', '中国.黑龙江省.绥化市.明水县', '1');
INSERT INTO `weiapp_region` VALUES ('231226', '绥棱县', '231200', '86.230000.231200.231226', '中国.黑龙江省.绥化市.绥棱县', '1');
INSERT INTO `weiapp_region` VALUES ('231281', '安达市', '231200', '86.230000.231200.231281', '中国.黑龙江省.绥化市.安达市', '1');
INSERT INTO `weiapp_region` VALUES ('231282', '肇东市', '231200', '86.230000.231200.231282', '中国.黑龙江省.绥化市.肇东市', '1');
INSERT INTO `weiapp_region` VALUES ('231283', '海伦市', '231200', '86.230000.231200.231283', '中国.黑龙江省.绥化市.海伦市', '1');
INSERT INTO `weiapp_region` VALUES ('232700', '大兴安岭地区', '230000', '86.230000.232700', '中国.黑龙江省.大兴安岭地区', '1');
INSERT INTO `weiapp_region` VALUES ('232721', '呼玛县', '232700', '86.230000.232700.232721', '中国.黑龙江省.大兴安岭地区.呼玛县', '1');
INSERT INTO `weiapp_region` VALUES ('232722', '塔河县', '232700', '86.230000.232700.232722', '中国.黑龙江省.大兴安岭地区.塔河县', '1');
INSERT INTO `weiapp_region` VALUES ('232723', '漠河县', '232700', '86.230000.232700.232723', '中国.黑龙江省.大兴安岭地区.漠河县', '1');
INSERT INTO `weiapp_region` VALUES ('310000', '上海市', '86', '86.310000', '中国.上海市', '1');
INSERT INTO `weiapp_region` VALUES ('310101', '黄浦区', '310000', '86.310000.310101', '中国.上海市.黄浦区', '1');
INSERT INTO `weiapp_region` VALUES ('310104', '徐汇区', '310000', '86.310000.310104', '中国.上海市.徐汇区', '1');
INSERT INTO `weiapp_region` VALUES ('310105', '长宁区', '310000', '86.310000.310105', '中国.上海市.长宁区', '1');
INSERT INTO `weiapp_region` VALUES ('310106', '静安区', '310000', '86.310000.310106', '中国.上海市.静安区', '1');
INSERT INTO `weiapp_region` VALUES ('310107', '普陀区', '310000', '86.310000.310107', '中国.上海市.普陀区', '1');
INSERT INTO `weiapp_region` VALUES ('310108', '闸北区', '310000', '86.310000.310108', '中国.上海市.闸北区', '1');
INSERT INTO `weiapp_region` VALUES ('310109', '虹口区', '310000', '86.310000.310109', '中国.上海市.虹口区', '1');
INSERT INTO `weiapp_region` VALUES ('310110', '杨浦区', '310000', '86.310000.310110', '中国.上海市.杨浦区', '1');
INSERT INTO `weiapp_region` VALUES ('310112', '闵行区', '310000', '86.310000.310112', '中国.上海市.闵行区', '1');
INSERT INTO `weiapp_region` VALUES ('310113', '宝山区', '310000', '86.310000.310113', '中国.上海市.宝山区', '1');
INSERT INTO `weiapp_region` VALUES ('310114', '嘉定区', '310000', '86.310000.310114', '中国.上海市.嘉定区', '1');
INSERT INTO `weiapp_region` VALUES ('310115', '浦东新区', '310000', '86.310000.310115', '中国.上海市.浦东新区', '1');
INSERT INTO `weiapp_region` VALUES ('310116', '金山区', '310000', '86.310000.310116', '中国.上海市.金山区', '1');
INSERT INTO `weiapp_region` VALUES ('310117', '松江区', '310000', '86.310000.310117', '中国.上海市.松江区', '1');
INSERT INTO `weiapp_region` VALUES ('310118', '青浦区', '310000', '86.310000.310118', '中国.上海市.青浦区', '1');
INSERT INTO `weiapp_region` VALUES ('310120', '奉贤区', '310000', '86.310000.310120', '中国.上海市.奉贤区', '1');
INSERT INTO `weiapp_region` VALUES ('310230', '崇明县', '310000', '86.310000.310230', '中国.上海市.崇明县', '1');
INSERT INTO `weiapp_region` VALUES ('320100', '南京市', '320000', '86.320000.320100', '中国.江苏省.南京市', '1');
INSERT INTO `weiapp_region` VALUES ('320102', '玄武区', '320100', '86.320000.320100.320102', '中国.江苏省.南京市.玄武区', '1');
INSERT INTO `weiapp_region` VALUES ('320103', '白下区', '320100', '86.320000.320100.320103', '中国.江苏省.南京市.白下区', '1');
INSERT INTO `weiapp_region` VALUES ('320104', '秦淮区', '320100', '86.320000.320100.320104', '中国.江苏省.南京市.秦淮区', '1');
INSERT INTO `weiapp_region` VALUES ('320105', '建邺区', '320100', '86.320000.320100.320105', '中国.江苏省.南京市.建邺区', '1');
INSERT INTO `weiapp_region` VALUES ('320106', '鼓楼区', '320100', '86.320000.320100.320106', '中国.江苏省.南京市.鼓楼区', '1');
INSERT INTO `weiapp_region` VALUES ('320107', '下关区', '320100', '86.320000.320100.320107', '中国.江苏省.南京市.下关区', '1');
INSERT INTO `weiapp_region` VALUES ('320111', '浦口区', '320100', '86.320000.320100.320111', '中国.江苏省.南京市.浦口区', '1');
INSERT INTO `weiapp_region` VALUES ('320113', '栖霞区', '320100', '86.320000.320100.320113', '中国.江苏省.南京市.栖霞区', '1');
INSERT INTO `weiapp_region` VALUES ('320114', '雨花台区', '320100', '86.320000.320100.320114', '中国.江苏省.南京市.雨花台区', '1');
INSERT INTO `weiapp_region` VALUES ('320115', '江宁区', '320100', '86.320000.320100.320115', '中国.江苏省.南京市.江宁区', '1');
INSERT INTO `weiapp_region` VALUES ('320116', '六合区', '320100', '86.320000.320100.320116', '中国.江苏省.南京市.六合区', '1');
INSERT INTO `weiapp_region` VALUES ('320124', '溧水县', '320100', '86.320000.320100.320124', '中国.江苏省.南京市.溧水县', '1');
INSERT INTO `weiapp_region` VALUES ('320125', '高淳县', '320100', '86.320000.320100.320125', '中国.江苏省.南京市.高淳县', '1');
INSERT INTO `weiapp_region` VALUES ('320200', '无锡市', '320000', '86.320000.320200', '中国.江苏省.无锡市', '1');
INSERT INTO `weiapp_region` VALUES ('320202', '崇安区', '320200', '86.320000.320200.320202', '中国.江苏省.无锡市.崇安区', '1');
INSERT INTO `weiapp_region` VALUES ('320203', '南长区', '320200', '86.320000.320200.320203', '中国.江苏省.无锡市.南长区', '1');
INSERT INTO `weiapp_region` VALUES ('320204', '北塘区', '320200', '86.320000.320200.320204', '中国.江苏省.无锡市.北塘区', '1');
INSERT INTO `weiapp_region` VALUES ('320205', '锡山区', '320200', '86.320000.320200.320205', '中国.江苏省.无锡市.锡山区', '1');
INSERT INTO `weiapp_region` VALUES ('320206', '惠山区', '320200', '86.320000.320200.320206', '中国.江苏省.无锡市.惠山区', '1');
INSERT INTO `weiapp_region` VALUES ('320211', '滨湖区', '320200', '86.320000.320200.320211', '中国.江苏省.无锡市.滨湖区', '1');
INSERT INTO `weiapp_region` VALUES ('320281', '江阴市', '320200', '86.320000.320200.320281', '中国.江苏省.无锡市.江阴市', '1');
INSERT INTO `weiapp_region` VALUES ('320282', '宜兴市', '320200', '86.320000.320200.320282', '中国.江苏省.无锡市.宜兴市', '1');
INSERT INTO `weiapp_region` VALUES ('320300', '徐州市', '320000', '86.320000.320300', '中国.江苏省.徐州市', '1');
INSERT INTO `weiapp_region` VALUES ('320302', '鼓楼区', '320300', '86.320000.320300.320302', '中国.江苏省.徐州市.鼓楼区', '1');
INSERT INTO `weiapp_region` VALUES ('320303', '云龙区', '320300', '86.320000.320300.320303', '中国.江苏省.徐州市.云龙区', '1');
INSERT INTO `weiapp_region` VALUES ('320305', '贾汪区', '320300', '86.320000.320300.320305', '中国.江苏省.徐州市.贾汪区', '1');
INSERT INTO `weiapp_region` VALUES ('320311', '泉山区', '320300', '86.320000.320300.320311', '中国.江苏省.徐州市.泉山区', '1');
INSERT INTO `weiapp_region` VALUES ('320312', '铜山区', '320300', '86.320000.320300.320312', '中国.江苏省.徐州市.铜山区', '1');
INSERT INTO `weiapp_region` VALUES ('320321', '丰县', '320300', '86.320000.320300.320321', '中国.江苏省.徐州市.丰县', '1');
INSERT INTO `weiapp_region` VALUES ('320322', '沛县', '320300', '86.320000.320300.320322', '中国.江苏省.徐州市.沛县', '1');
INSERT INTO `weiapp_region` VALUES ('320324', '睢宁县', '320300', '86.320000.320300.320324', '中国.江苏省.徐州市.睢宁县', '1');
INSERT INTO `weiapp_region` VALUES ('320381', '新沂市', '320300', '86.320000.320300.320381', '中国.江苏省.徐州市.新沂市', '1');
INSERT INTO `weiapp_region` VALUES ('320382', '邳州市', '320300', '86.320000.320300.320382', '中国.江苏省.徐州市.邳州市', '1');
INSERT INTO `weiapp_region` VALUES ('320400', '常州市', '320000', '86.320000.320400', '中国.江苏省.常州市', '1');
INSERT INTO `weiapp_region` VALUES ('320402', '天宁区', '320400', '86.320000.320400.320402', '中国.江苏省.常州市.天宁区', '1');
INSERT INTO `weiapp_region` VALUES ('320404', '钟楼区', '320400', '86.320000.320400.320404', '中国.江苏省.常州市.钟楼区', '1');
INSERT INTO `weiapp_region` VALUES ('320405', '戚墅堰区', '320400', '86.320000.320400.320405', '中国.江苏省.常州市.戚墅堰区', '1');
INSERT INTO `weiapp_region` VALUES ('320411', '新北区', '320400', '86.320000.320400.320411', '中国.江苏省.常州市.新北区', '1');
INSERT INTO `weiapp_region` VALUES ('320412', '武进区', '320400', '86.320000.320400.320412', '中国.江苏省.常州市.武进区', '1');
INSERT INTO `weiapp_region` VALUES ('320481', '溧阳市', '320400', '86.320000.320400.320481', '中国.江苏省.常州市.溧阳市', '1');
INSERT INTO `weiapp_region` VALUES ('320482', '金坛市', '320400', '86.320000.320400.320482', '中国.江苏省.常州市.金坛市', '1');
INSERT INTO `weiapp_region` VALUES ('320500', '苏州市', '320000', '86.320000.320500', '中国.江苏省.苏州市', '1');
INSERT INTO `weiapp_region` VALUES ('320502', '沧浪区', '320500', '86.320000.320500.320502', '中国.江苏省.苏州市.沧浪区', '1');
INSERT INTO `weiapp_region` VALUES ('320503', '平江区', '320500', '86.320000.320500.320503', '中国.江苏省.苏州市.平江区', '1');
INSERT INTO `weiapp_region` VALUES ('320504', '金阊区', '320500', '86.320000.320500.320504', '中国.江苏省.苏州市.金阊区', '1');
INSERT INTO `weiapp_region` VALUES ('320505', '虎丘区', '320500', '86.320000.320500.320505', '中国.江苏省.苏州市.虎丘区', '1');
INSERT INTO `weiapp_region` VALUES ('320506', '吴中区', '320500', '86.320000.320500.320506', '中国.江苏省.苏州市.吴中区', '1');
INSERT INTO `weiapp_region` VALUES ('320507', '相城区', '320500', '86.320000.320500.320507', '中国.江苏省.苏州市.相城区', '1');
INSERT INTO `weiapp_region` VALUES ('320581', '常熟市', '320500', '86.320000.320500.320581', '中国.江苏省.苏州市.常熟市', '1');
INSERT INTO `weiapp_region` VALUES ('320582', '张家港市', '320500', '86.320000.320500.320582', '中国.江苏省.苏州市.张家港市', '1');
INSERT INTO `weiapp_region` VALUES ('320583', '昆山市', '320500', '86.320000.320500.320583', '中国.江苏省.苏州市.昆山市', '1');
INSERT INTO `weiapp_region` VALUES ('320584', '吴江市', '320500', '86.320000.320500.320584', '中国.江苏省.苏州市.吴江市', '1');
INSERT INTO `weiapp_region` VALUES ('320585', '太仓市', '320500', '86.320000.320500.320585', '中国.江苏省.苏州市.太仓市', '1');
INSERT INTO `weiapp_region` VALUES ('320600', '南通市', '320000', '86.320000.320600', '中国.江苏省.南通市', '1');
INSERT INTO `weiapp_region` VALUES ('320602', '崇川区', '320600', '86.320000.320600.320602', '中国.江苏省.南通市.崇川区', '1');
INSERT INTO `weiapp_region` VALUES ('320611', '港闸区', '320600', '86.320000.320600.320611', '中国.江苏省.南通市.港闸区', '1');
INSERT INTO `weiapp_region` VALUES ('320612', '通州区', '320600', '86.320000.320600.320612', '中国.江苏省.南通市.通州区', '1');
INSERT INTO `weiapp_region` VALUES ('320621', '海安县', '320600', '86.320000.320600.320621', '中国.江苏省.南通市.海安县', '1');
INSERT INTO `weiapp_region` VALUES ('320623', '如东县', '320600', '86.320000.320600.320623', '中国.江苏省.南通市.如东县', '1');
INSERT INTO `weiapp_region` VALUES ('320681', '启东市', '320600', '86.320000.320600.320681', '中国.江苏省.南通市.启东市', '1');
INSERT INTO `weiapp_region` VALUES ('320682', '如皋市', '320600', '86.320000.320600.320682', '中国.江苏省.南通市.如皋市', '1');
INSERT INTO `weiapp_region` VALUES ('320684', '海门市', '320600', '86.320000.320600.320684', '中国.江苏省.南通市.海门市', '1');
INSERT INTO `weiapp_region` VALUES ('320700', '连云港市', '320000', '86.320000.320700', '中国.江苏省.连云港市', '1');
INSERT INTO `weiapp_region` VALUES ('320703', '连云区', '320700', '86.320000.320700.320703', '中国.江苏省.连云港市.连云区', '1');
INSERT INTO `weiapp_region` VALUES ('320705', '新浦区', '320700', '86.320000.320700.320705', '中国.江苏省.连云港市.新浦区', '1');
INSERT INTO `weiapp_region` VALUES ('320706', '海州区', '320700', '86.320000.320700.320706', '中国.江苏省.连云港市.海州区', '1');
INSERT INTO `weiapp_region` VALUES ('320721', '赣榆县', '320700', '86.320000.320700.320721', '中国.江苏省.连云港市.赣榆县', '1');
INSERT INTO `weiapp_region` VALUES ('320722', '东海县', '320700', '86.320000.320700.320722', '中国.江苏省.连云港市.东海县', '1');
INSERT INTO `weiapp_region` VALUES ('320723', '灌云县', '320700', '86.320000.320700.320723', '中国.江苏省.连云港市.灌云县', '1');
INSERT INTO `weiapp_region` VALUES ('320724', '灌南县', '320700', '86.320000.320700.320724', '中国.江苏省.连云港市.灌南县', '1');
INSERT INTO `weiapp_region` VALUES ('320800', '淮安市', '320000', '86.320000.320800', '中国.江苏省.淮安市', '1');
INSERT INTO `weiapp_region` VALUES ('320802', '清河区', '320800', '86.320000.320800.320802', '中国.江苏省.淮安市.清河区', '1');
INSERT INTO `weiapp_region` VALUES ('320803', '楚州区', '320800', '86.320000.320800.320803', '中国.江苏省.淮安市.楚州区', '1');
INSERT INTO `weiapp_region` VALUES ('320804', '淮阴区', '320800', '86.320000.320800.320804', '中国.江苏省.淮安市.淮阴区', '1');
INSERT INTO `weiapp_region` VALUES ('320811', '清浦区', '320800', '86.320000.320800.320811', '中国.江苏省.淮安市.清浦区', '1');
INSERT INTO `weiapp_region` VALUES ('320826', '涟水县', '320800', '86.320000.320800.320826', '中国.江苏省.淮安市.涟水县', '1');
INSERT INTO `weiapp_region` VALUES ('320829', '洪泽县', '320800', '86.320000.320800.320829', '中国.江苏省.淮安市.洪泽县', '1');
INSERT INTO `weiapp_region` VALUES ('320830', '盱眙县', '320800', '86.320000.320800.320830', '中国.江苏省.淮安市.盱眙县', '1');
INSERT INTO `weiapp_region` VALUES ('320831', '金湖县', '320800', '86.320000.320800.320831', '中国.江苏省.淮安市.金湖县', '1');
INSERT INTO `weiapp_region` VALUES ('320900', '盐城市', '320000', '86.320000.320900', '中国.江苏省.盐城市', '1');
INSERT INTO `weiapp_region` VALUES ('320902', '亭湖区', '320900', '86.320000.320900.320902', '中国.江苏省.盐城市.亭湖区', '1');
INSERT INTO `weiapp_region` VALUES ('320903', '盐都区', '320900', '86.320000.320900.320903', '中国.江苏省.盐城市.盐都区', '1');
INSERT INTO `weiapp_region` VALUES ('320921', '响水县', '320900', '86.320000.320900.320921', '中国.江苏省.盐城市.响水县', '1');
INSERT INTO `weiapp_region` VALUES ('320922', '滨海县', '320900', '86.320000.320900.320922', '中国.江苏省.盐城市.滨海县', '1');
INSERT INTO `weiapp_region` VALUES ('320923', '阜宁县', '320900', '86.320000.320900.320923', '中国.江苏省.盐城市.阜宁县', '1');
INSERT INTO `weiapp_region` VALUES ('320924', '射阳县', '320900', '86.320000.320900.320924', '中国.江苏省.盐城市.射阳县', '1');
INSERT INTO `weiapp_region` VALUES ('320925', '建湖县', '320900', '86.320000.320900.320925', '中国.江苏省.盐城市.建湖县', '1');
INSERT INTO `weiapp_region` VALUES ('320981', '东台市', '320900', '86.320000.320900.320981', '中国.江苏省.盐城市.东台市', '1');
INSERT INTO `weiapp_region` VALUES ('320982', '大丰市', '320900', '86.320000.320900.320982', '中国.江苏省.盐城市.大丰市', '1');
INSERT INTO `weiapp_region` VALUES ('321000', '扬州市', '320000', '86.320000.321000', '中国.江苏省.扬州市', '1');
INSERT INTO `weiapp_region` VALUES ('321002', '广陵区', '321000', '86.320000.321000.321002', '中国.江苏省.扬州市.广陵区', '1');
INSERT INTO `weiapp_region` VALUES ('321003', '邗江区', '321000', '86.320000.321000.321003', '中国.江苏省.扬州市.邗江区', '1');
INSERT INTO `weiapp_region` VALUES ('321012', '江都区', '321000', '86.320000.321000.321012', '中国.江苏省.扬州市.江都区', '1');
INSERT INTO `weiapp_region` VALUES ('321023', '宝应县', '321000', '86.320000.321000.321023', '中国.江苏省.扬州市.宝应县', '1');
INSERT INTO `weiapp_region` VALUES ('321081', '仪征市', '321000', '86.320000.321000.321081', '中国.江苏省.扬州市.仪征市', '1');
INSERT INTO `weiapp_region` VALUES ('321084', '高邮市', '321000', '86.320000.321000.321084', '中国.江苏省.扬州市.高邮市', '1');
INSERT INTO `weiapp_region` VALUES ('321100', '镇江市', '320000', '86.320000.321100', '中国.江苏省.镇江市', '1');
INSERT INTO `weiapp_region` VALUES ('321102', '京口区', '321100', '86.320000.321100.321102', '中国.江苏省.镇江市.京口区', '1');
INSERT INTO `weiapp_region` VALUES ('321111', '润州区', '321100', '86.320000.321100.321111', '中国.江苏省.镇江市.润州区', '1');
INSERT INTO `weiapp_region` VALUES ('321112', '丹徒区', '321100', '86.320000.321100.321112', '中国.江苏省.镇江市.丹徒区', '1');
INSERT INTO `weiapp_region` VALUES ('321181', '丹阳市', '321100', '86.320000.321100.321181', '中国.江苏省.镇江市.丹阳市', '1');
INSERT INTO `weiapp_region` VALUES ('321182', '扬中市', '321100', '86.320000.321100.321182', '中国.江苏省.镇江市.扬中市', '1');
INSERT INTO `weiapp_region` VALUES ('321183', '句容市', '321100', '86.320000.321100.321183', '中国.江苏省.镇江市.句容市', '1');
INSERT INTO `weiapp_region` VALUES ('321200', '泰州市', '320000', '86.320000.321200', '中国.江苏省.泰州市', '1');
INSERT INTO `weiapp_region` VALUES ('321202', '海陵区', '321200', '86.320000.321200.321202', '中国.江苏省.泰州市.海陵区', '1');
INSERT INTO `weiapp_region` VALUES ('321203', '高港区', '321200', '86.320000.321200.321203', '中国.江苏省.泰州市.高港区', '1');
INSERT INTO `weiapp_region` VALUES ('321281', '兴化市', '321200', '86.320000.321200.321281', '中国.江苏省.泰州市.兴化市', '1');
INSERT INTO `weiapp_region` VALUES ('321282', '靖江市', '321200', '86.320000.321200.321282', '中国.江苏省.泰州市.靖江市', '1');
INSERT INTO `weiapp_region` VALUES ('321283', '泰兴市', '321200', '86.320000.321200.321283', '中国.江苏省.泰州市.泰兴市', '1');
INSERT INTO `weiapp_region` VALUES ('321284', '姜堰市', '321200', '86.320000.321200.321284', '中国.江苏省.泰州市.姜堰市', '1');
INSERT INTO `weiapp_region` VALUES ('321300', '宿迁市', '320000', '86.320000.321300', '中国.江苏省.宿迁市', '1');
INSERT INTO `weiapp_region` VALUES ('321302', '宿城区', '321300', '86.320000.321300.321302', '中国.江苏省.宿迁市.宿城区', '1');
INSERT INTO `weiapp_region` VALUES ('321311', '宿豫区', '321300', '86.320000.321300.321311', '中国.江苏省.宿迁市.宿豫区', '1');
INSERT INTO `weiapp_region` VALUES ('321322', '沭阳县', '321300', '86.320000.321300.321322', '中国.江苏省.宿迁市.沭阳县', '1');
INSERT INTO `weiapp_region` VALUES ('321323', '泗阳县', '321300', '86.320000.321300.321323', '中国.江苏省.宿迁市.泗阳县', '1');
INSERT INTO `weiapp_region` VALUES ('321324', '泗洪县', '321300', '86.320000.321300.321324', '中国.江苏省.宿迁市.泗洪县', '1');
INSERT INTO `weiapp_region` VALUES ('330000', '浙江省', '86', '86.330000', '中国.浙江省', '1');
INSERT INTO `weiapp_region` VALUES ('330100', '杭州市', '330000', '86.330000.330100', '中国.浙江省.杭州市', '1');
INSERT INTO `weiapp_region` VALUES ('330102', '上城区', '330100', '86.330000.330100.330102', '中国.浙江省.杭州市.上城区', '1');
INSERT INTO `weiapp_region` VALUES ('330103', '下城区', '330100', '86.330000.330100.330103', '中国.浙江省.杭州市.下城区', '1');
INSERT INTO `weiapp_region` VALUES ('330104', '江干区', '330100', '86.330000.330100.330104', '中国.浙江省.杭州市.江干区', '1');
INSERT INTO `weiapp_region` VALUES ('330105', '拱墅区', '330100', '86.330000.330100.330105', '中国.浙江省.杭州市.拱墅区', '1');
INSERT INTO `weiapp_region` VALUES ('330106', '西湖区', '330100', '86.330000.330100.330106', '中国.浙江省.杭州市.西湖区', '1');
INSERT INTO `weiapp_region` VALUES ('330108', '滨江区', '330100', '86.330000.330100.330108', '中国.浙江省.杭州市.滨江区', '1');
INSERT INTO `weiapp_region` VALUES ('330109', '萧山区', '330100', '86.330000.330100.330109', '中国.浙江省.杭州市.萧山区', '1');
INSERT INTO `weiapp_region` VALUES ('330110', '余杭区', '330100', '86.330000.330100.330110', '中国.浙江省.杭州市.余杭区', '1');
INSERT INTO `weiapp_region` VALUES ('330122', '桐庐县', '330100', '86.330000.330100.330122', '中国.浙江省.杭州市.桐庐县', '1');
INSERT INTO `weiapp_region` VALUES ('330127', '淳安县', '330100', '86.330000.330100.330127', '中国.浙江省.杭州市.淳安县', '1');
INSERT INTO `weiapp_region` VALUES ('330182', '建德市', '330100', '86.330000.330100.330182', '中国.浙江省.杭州市.建德市', '1');
INSERT INTO `weiapp_region` VALUES ('330183', '富阳市', '330100', '86.330000.330100.330183', '中国.浙江省.杭州市.富阳市', '1');
INSERT INTO `weiapp_region` VALUES ('330185', '临安市', '330100', '86.330000.330100.330185', '中国.浙江省.杭州市.临安市', '1');
INSERT INTO `weiapp_region` VALUES ('330200', '宁波市', '330000', '86.330000.330200', '中国.浙江省.宁波市', '1');
INSERT INTO `weiapp_region` VALUES ('330203', '海曙区', '330200', '86.330000.330200.330203', '中国.浙江省.宁波市.海曙区', '1');
INSERT INTO `weiapp_region` VALUES ('330204', '江东区', '330200', '86.330000.330200.330204', '中国.浙江省.宁波市.江东区', '1');
INSERT INTO `weiapp_region` VALUES ('330205', '江北区', '330200', '86.330000.330200.330205', '中国.浙江省.宁波市.江北区', '1');
INSERT INTO `weiapp_region` VALUES ('330206', '北仑区', '330200', '86.330000.330200.330206', '中国.浙江省.宁波市.北仑区', '1');
INSERT INTO `weiapp_region` VALUES ('330211', '镇海区', '330200', '86.330000.330200.330211', '中国.浙江省.宁波市.镇海区', '1');
INSERT INTO `weiapp_region` VALUES ('330212', '鄞州区', '330200', '86.330000.330200.330212', '中国.浙江省.宁波市.鄞州区', '1');
INSERT INTO `weiapp_region` VALUES ('330225', '象山县', '330200', '86.330000.330200.330225', '中国.浙江省.宁波市.象山县', '1');
INSERT INTO `weiapp_region` VALUES ('330226', '宁海县', '330200', '86.330000.330200.330226', '中国.浙江省.宁波市.宁海县', '1');
INSERT INTO `weiapp_region` VALUES ('330281', '余姚市', '330200', '86.330000.330200.330281', '中国.浙江省.宁波市.余姚市', '1');
INSERT INTO `weiapp_region` VALUES ('330282', '慈溪市', '330200', '86.330000.330200.330282', '中国.浙江省.宁波市.慈溪市', '1');
INSERT INTO `weiapp_region` VALUES ('330283', '奉化市', '330200', '86.330000.330200.330283', '中国.浙江省.宁波市.奉化市', '1');
INSERT INTO `weiapp_region` VALUES ('330300', '温州市', '330000', '86.330000.330300', '中国.浙江省.温州市', '1');
INSERT INTO `weiapp_region` VALUES ('330302', '鹿城区', '330300', '86.330000.330300.330302', '中国.浙江省.温州市.鹿城区', '1');
INSERT INTO `weiapp_region` VALUES ('330303', '龙湾区', '330300', '86.330000.330300.330303', '中国.浙江省.温州市.龙湾区', '1');
INSERT INTO `weiapp_region` VALUES ('330304', '瓯海区', '330300', '86.330000.330300.330304', '中国.浙江省.温州市.瓯海区', '1');
INSERT INTO `weiapp_region` VALUES ('330322', '洞头县', '330300', '86.330000.330300.330322', '中国.浙江省.温州市.洞头县', '1');
INSERT INTO `weiapp_region` VALUES ('330324', '永嘉县', '330300', '86.330000.330300.330324', '中国.浙江省.温州市.永嘉县', '1');
INSERT INTO `weiapp_region` VALUES ('330326', '平阳县', '330300', '86.330000.330300.330326', '中国.浙江省.温州市.平阳县', '1');
INSERT INTO `weiapp_region` VALUES ('330327', '苍南县', '330300', '86.330000.330300.330327', '中国.浙江省.温州市.苍南县', '1');
INSERT INTO `weiapp_region` VALUES ('330328', '文成县', '330300', '86.330000.330300.330328', '中国.浙江省.温州市.文成县', '1');
INSERT INTO `weiapp_region` VALUES ('330329', '泰顺县', '330300', '86.330000.330300.330329', '中国.浙江省.温州市.泰顺县', '1');
INSERT INTO `weiapp_region` VALUES ('330381', '瑞安市', '330300', '86.330000.330300.330381', '中国.浙江省.温州市.瑞安市', '1');
INSERT INTO `weiapp_region` VALUES ('330382', '乐清市', '330300', '86.330000.330300.330382', '中国.浙江省.温州市.乐清市', '1');
INSERT INTO `weiapp_region` VALUES ('330400', '嘉兴市', '330000', '86.330000.330400', '中国.浙江省.嘉兴市', '1');
INSERT INTO `weiapp_region` VALUES ('330402', '南湖区', '330400', '86.330000.330400.330402', '中国.浙江省.嘉兴市.南湖区', '1');
INSERT INTO `weiapp_region` VALUES ('330411', '秀洲区', '330400', '86.330000.330400.330411', '中国.浙江省.嘉兴市.秀洲区', '1');
INSERT INTO `weiapp_region` VALUES ('330421', '嘉善县', '330400', '86.330000.330400.330421', '中国.浙江省.嘉兴市.嘉善县', '1');
INSERT INTO `weiapp_region` VALUES ('330424', '海盐县', '330400', '86.330000.330400.330424', '中国.浙江省.嘉兴市.海盐县', '1');
INSERT INTO `weiapp_region` VALUES ('330481', '海宁市', '330400', '86.330000.330400.330481', '中国.浙江省.嘉兴市.海宁市', '1');
INSERT INTO `weiapp_region` VALUES ('330482', '平湖市', '330400', '86.330000.330400.330482', '中国.浙江省.嘉兴市.平湖市', '1');
INSERT INTO `weiapp_region` VALUES ('330483', '桐乡市', '330400', '86.330000.330400.330483', '中国.浙江省.嘉兴市.桐乡市', '1');
INSERT INTO `weiapp_region` VALUES ('330500', '湖州市', '330000', '86.330000.330500', '中国.浙江省.湖州市', '1');
INSERT INTO `weiapp_region` VALUES ('330502', '吴兴区', '330500', '86.330000.330500.330502', '中国.浙江省.湖州市.吴兴区', '1');
INSERT INTO `weiapp_region` VALUES ('330503', '南浔区', '330500', '86.330000.330500.330503', '中国.浙江省.湖州市.南浔区', '1');
INSERT INTO `weiapp_region` VALUES ('330521', '德清县', '330500', '86.330000.330500.330521', '中国.浙江省.湖州市.德清县', '1');
INSERT INTO `weiapp_region` VALUES ('330522', '长兴县', '330500', '86.330000.330500.330522', '中国.浙江省.湖州市.长兴县', '1');
INSERT INTO `weiapp_region` VALUES ('330523', '安吉县', '330500', '86.330000.330500.330523', '中国.浙江省.湖州市.安吉县', '1');
INSERT INTO `weiapp_region` VALUES ('330600', '绍兴市', '330000', '86.330000.330600', '中国.浙江省.绍兴市', '1');
INSERT INTO `weiapp_region` VALUES ('330602', '越城区', '330600', '86.330000.330600.330602', '中国.浙江省.绍兴市.越城区', '1');
INSERT INTO `weiapp_region` VALUES ('330621', '绍兴县', '330600', '86.330000.330600.330621', '中国.浙江省.绍兴市.绍兴县', '1');
INSERT INTO `weiapp_region` VALUES ('330624', '新昌县', '330600', '86.330000.330600.330624', '中国.浙江省.绍兴市.新昌县', '1');
INSERT INTO `weiapp_region` VALUES ('330681', '诸暨市', '330600', '86.330000.330600.330681', '中国.浙江省.绍兴市.诸暨市', '1');
INSERT INTO `weiapp_region` VALUES ('330682', '上虞市', '330600', '86.330000.330600.330682', '中国.浙江省.绍兴市.上虞市', '1');
INSERT INTO `weiapp_region` VALUES ('330683', '嵊州市', '330600', '86.330000.330600.330683', '中国.浙江省.绍兴市.嵊州市', '1');
INSERT INTO `weiapp_region` VALUES ('330700', '金华市', '330000', '86.330000.330700', '中国.浙江省.金华市', '1');
INSERT INTO `weiapp_region` VALUES ('330702', '婺城区', '330700', '86.330000.330700.330702', '中国.浙江省.金华市.婺城区', '1');
INSERT INTO `weiapp_region` VALUES ('330703', '金东区', '330700', '86.330000.330700.330703', '中国.浙江省.金华市.金东区', '1');
INSERT INTO `weiapp_region` VALUES ('330723', '武义县', '330700', '86.330000.330700.330723', '中国.浙江省.金华市.武义县', '1');
INSERT INTO `weiapp_region` VALUES ('330726', '浦江县', '330700', '86.330000.330700.330726', '中国.浙江省.金华市.浦江县', '1');
INSERT INTO `weiapp_region` VALUES ('330727', '磐安县', '330700', '86.330000.330700.330727', '中国.浙江省.金华市.磐安县', '1');
INSERT INTO `weiapp_region` VALUES ('330781', '兰溪市', '330700', '86.330000.330700.330781', '中国.浙江省.金华市.兰溪市', '1');
INSERT INTO `weiapp_region` VALUES ('330782', '义乌市', '330700', '86.330000.330700.330782', '中国.浙江省.金华市.义乌市', '1');
INSERT INTO `weiapp_region` VALUES ('330783', '东阳市', '330700', '86.330000.330700.330783', '中国.浙江省.金华市.东阳市', '1');
INSERT INTO `weiapp_region` VALUES ('330784', '永康市', '330700', '86.330000.330700.330784', '中国.浙江省.金华市.永康市', '1');
INSERT INTO `weiapp_region` VALUES ('330800', '衢州市', '330000', '86.330000.330800', '中国.浙江省.衢州市', '1');
INSERT INTO `weiapp_region` VALUES ('330802', '柯城区', '330800', '86.330000.330800.330802', '中国.浙江省.衢州市.柯城区', '1');
INSERT INTO `weiapp_region` VALUES ('330803', '衢江区', '330800', '86.330000.330800.330803', '中国.浙江省.衢州市.衢江区', '1');
INSERT INTO `weiapp_region` VALUES ('330822', '常山县', '330800', '86.330000.330800.330822', '中国.浙江省.衢州市.常山县', '1');
INSERT INTO `weiapp_region` VALUES ('330824', '开化县', '330800', '86.330000.330800.330824', '中国.浙江省.衢州市.开化县', '1');
INSERT INTO `weiapp_region` VALUES ('330825', '龙游县', '330800', '86.330000.330800.330825', '中国.浙江省.衢州市.龙游县', '1');
INSERT INTO `weiapp_region` VALUES ('330881', '江山市', '330800', '86.330000.330800.330881', '中国.浙江省.衢州市.江山市', '1');
INSERT INTO `weiapp_region` VALUES ('330900', '舟山市', '330000', '86.330000.330900', '中国.浙江省.舟山市', '1');
INSERT INTO `weiapp_region` VALUES ('330902', '定海区', '330900', '86.330000.330900.330902', '中国.浙江省.舟山市.定海区', '1');
INSERT INTO `weiapp_region` VALUES ('330903', '普陀区', '330900', '86.330000.330900.330903', '中国.浙江省.舟山市.普陀区', '1');
INSERT INTO `weiapp_region` VALUES ('330921', '岱山县', '330900', '86.330000.330900.330921', '中国.浙江省.舟山市.岱山县', '1');
INSERT INTO `weiapp_region` VALUES ('330922', '嵊泗县', '330900', '86.330000.330900.330922', '中国.浙江省.舟山市.嵊泗县', '1');
INSERT INTO `weiapp_region` VALUES ('331000', '台州市', '330000', '86.330000.331000', '中国.浙江省.台州市', '1');
INSERT INTO `weiapp_region` VALUES ('331002', '椒江区', '331000', '86.330000.331000.331002', '中国.浙江省.台州市.椒江区', '1');
INSERT INTO `weiapp_region` VALUES ('331003', '黄岩区', '331000', '86.330000.331000.331003', '中国.浙江省.台州市.黄岩区', '1');
INSERT INTO `weiapp_region` VALUES ('331004', '路桥区', '331000', '86.330000.331000.331004', '中国.浙江省.台州市.路桥区', '1');
INSERT INTO `weiapp_region` VALUES ('331022', '三门县', '331000', '86.330000.331000.331022', '中国.浙江省.台州市.三门县', '1');
INSERT INTO `weiapp_region` VALUES ('331021', '玉环县', '331000', '86.330000.331000.331021', '中国.浙江省.台州市.玉环县', '1');
INSERT INTO `weiapp_region` VALUES ('331023', '天台县', '331000', '86.330000.331000.331023', '中国.浙江省.台州市.天台县', '1');
INSERT INTO `weiapp_region` VALUES ('331024', '仙居县', '331000', '86.330000.331000.331024', '中国.浙江省.台州市.仙居县', '1');
INSERT INTO `weiapp_region` VALUES ('331081', '温岭市', '331000', '86.330000.331000.331081', '中国.浙江省.台州市.温岭市', '1');
INSERT INTO `weiapp_region` VALUES ('331082', '临海市', '331000', '86.330000.331000.331082', '中国.浙江省.台州市.临海市', '1');
INSERT INTO `weiapp_region` VALUES ('331100', '丽水市', '330000', '86.330000.331100', '中国.浙江省.丽水市', '1');
INSERT INTO `weiapp_region` VALUES ('331102', '莲都区', '331100', '86.330000.331100.331102', '中国.浙江省.丽水市.莲都区', '1');
INSERT INTO `weiapp_region` VALUES ('331121', '青田县', '331100', '86.330000.331100.331121', '中国.浙江省.丽水市.青田县', '1');
INSERT INTO `weiapp_region` VALUES ('331122', '缙云县', '331100', '86.330000.331100.331122', '中国.浙江省.丽水市.缙云县', '1');
INSERT INTO `weiapp_region` VALUES ('331123', '遂昌县', '331100', '86.330000.331100.331123', '中国.浙江省.丽水市.遂昌县', '1');
INSERT INTO `weiapp_region` VALUES ('331124', '松阳县', '331100', '86.330000.331100.331124', '中国.浙江省.丽水市.松阳县', '1');
INSERT INTO `weiapp_region` VALUES ('331125', '云和县', '331100', '86.330000.331100.331125', '中国.浙江省.丽水市.云和县', '1');
INSERT INTO `weiapp_region` VALUES ('331126', '庆元县', '331100', '86.330000.331100.331126', '中国.浙江省.丽水市.庆元县', '1');
INSERT INTO `weiapp_region` VALUES ('331127', '景宁畲族自治县', '331100', '86.330000.331100.331127', '中国.浙江省.丽水市.景宁畲族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('331181', '龙泉市', '331100', '86.330000.331100.331181', '中国.浙江省.丽水市.龙泉市', '1');
INSERT INTO `weiapp_region` VALUES ('340000', '安徽省', '86', '86.340000', '中国.安徽省', '1');
INSERT INTO `weiapp_region` VALUES ('340100', '合肥市', '340000', '86.340000.340100', '中国.安徽省.合肥市', '1');
INSERT INTO `weiapp_region` VALUES ('340102', '瑶海区', '340100', '86.340000.340100.340102', '中国.安徽省.合肥市.瑶海区', '1');
INSERT INTO `weiapp_region` VALUES ('340103', '庐阳区', '340100', '86.340000.340100.340103', '中国.安徽省.合肥市.庐阳区', '1');
INSERT INTO `weiapp_region` VALUES ('340104', '蜀山区', '340100', '86.340000.340100.340104', '中国.安徽省.合肥市.蜀山区', '1');
INSERT INTO `weiapp_region` VALUES ('340111', '包河区', '340100', '86.340000.340100.340111', '中国.安徽省.合肥市.包河区', '1');
INSERT INTO `weiapp_region` VALUES ('340121', '长丰县', '340100', '86.340000.340100.340121', '中国.安徽省.合肥市.长丰县', '1');
INSERT INTO `weiapp_region` VALUES ('340122', '肥东县', '340100', '86.340000.340100.340122', '中国.安徽省.合肥市.肥东县', '1');
INSERT INTO `weiapp_region` VALUES ('340123', '肥西县', '340100', '86.340000.340100.340123', '中国.安徽省.合肥市.肥西县', '1');
INSERT INTO `weiapp_region` VALUES ('340124', '庐江县', '340100', '86.340000.340100.340124', '中国.安徽省.合肥市.庐江县', '1');
INSERT INTO `weiapp_region` VALUES ('340181', '巢湖市', '340100', '86.340000.340100.340181', '中国.安徽省.合肥市.巢湖市', '1');
INSERT INTO `weiapp_region` VALUES ('340200', '芜湖市', '340000', '86.340000.340200', '中国.安徽省.芜湖市', '1');
INSERT INTO `weiapp_region` VALUES ('340202', '镜湖区', '340200', '86.340000.340200.340202', '中国.安徽省.芜湖市.镜湖区', '1');
INSERT INTO `weiapp_region` VALUES ('340203', '弋江区', '340200', '86.340000.340200.340203', '中国.安徽省.芜湖市.弋江区', '1');
INSERT INTO `weiapp_region` VALUES ('340207', '鸠江区', '340200', '86.340000.340200.340207', '中国.安徽省.芜湖市.鸠江区', '1');
INSERT INTO `weiapp_region` VALUES ('340208', '三山区', '340200', '86.340000.340200.340208', '中国.安徽省.芜湖市.三山区', '1');
INSERT INTO `weiapp_region` VALUES ('340221', '芜湖县', '340200', '86.340000.340200.340221', '中国.安徽省.芜湖市.芜湖县', '1');
INSERT INTO `weiapp_region` VALUES ('340222', '繁昌县', '340200', '86.340000.340200.340222', '中国.安徽省.芜湖市.繁昌县', '1');
INSERT INTO `weiapp_region` VALUES ('340223', '南陵县', '340200', '86.340000.340200.340223', '中国.安徽省.芜湖市.南陵县', '1');
INSERT INTO `weiapp_region` VALUES ('340225', '无为县', '340200', '86.340000.340200.340225', '中国.安徽省.芜湖市.无为县', '1');
INSERT INTO `weiapp_region` VALUES ('340300', '蚌埠市', '340000', '86.340000.340300', '中国.安徽省.蚌埠市', '1');
INSERT INTO `weiapp_region` VALUES ('340302', '龙子湖区', '340300', '86.340000.340300.340302', '中国.安徽省.蚌埠市.龙子湖区', '1');
INSERT INTO `weiapp_region` VALUES ('340303', '蚌山区', '340300', '86.340000.340300.340303', '中国.安徽省.蚌埠市.蚌山区', '1');
INSERT INTO `weiapp_region` VALUES ('340304', '禹会区', '340300', '86.340000.340300.340304', '中国.安徽省.蚌埠市.禹会区', '1');
INSERT INTO `weiapp_region` VALUES ('340311', '淮上区', '340300', '86.340000.340300.340311', '中国.安徽省.蚌埠市.淮上区', '1');
INSERT INTO `weiapp_region` VALUES ('340321', '怀远县', '340300', '86.340000.340300.340321', '中国.安徽省.蚌埠市.怀远县', '1');
INSERT INTO `weiapp_region` VALUES ('340322', '五河县', '340300', '86.340000.340300.340322', '中国.安徽省.蚌埠市.五河县', '1');
INSERT INTO `weiapp_region` VALUES ('340323', '固镇县', '340300', '86.340000.340300.340323', '中国.安徽省.蚌埠市.固镇县', '1');
INSERT INTO `weiapp_region` VALUES ('340400', '淮南市', '340000', '86.340000.340400', '中国.安徽省.淮南市', '1');
INSERT INTO `weiapp_region` VALUES ('340402', '大通区', '340400', '86.340000.340400.340402', '中国.安徽省.淮南市.大通区', '1');
INSERT INTO `weiapp_region` VALUES ('340403', '田家庵区', '340400', '86.340000.340400.340403', '中国.安徽省.淮南市.田家庵区', '1');
INSERT INTO `weiapp_region` VALUES ('340404', '谢家集区', '340400', '86.340000.340400.340404', '中国.安徽省.淮南市.谢家集区', '1');
INSERT INTO `weiapp_region` VALUES ('340405', '八公山区', '340400', '86.340000.340400.340405', '中国.安徽省.淮南市.八公山区', '1');
INSERT INTO `weiapp_region` VALUES ('340406', '潘集区', '340400', '86.340000.340400.340406', '中国.安徽省.淮南市.潘集区', '1');
INSERT INTO `weiapp_region` VALUES ('340421', '凤台县', '340400', '86.340000.340400.340421', '中国.安徽省.淮南市.凤台县', '1');
INSERT INTO `weiapp_region` VALUES ('340500', '马鞍山市', '340000', '86.340000.340500', '中国.安徽省.马鞍山市', '1');
INSERT INTO `weiapp_region` VALUES ('340502', '金家庄区', '340500', '86.340000.340500.340502', '中国.安徽省.马鞍山市.金家庄区', '1');
INSERT INTO `weiapp_region` VALUES ('340503', '花山区', '340500', '86.340000.340500.340503', '中国.安徽省.马鞍山市.花山区', '1');
INSERT INTO `weiapp_region` VALUES ('340504', '雨山区', '340500', '86.340000.340500.340504', '中国.安徽省.马鞍山市.雨山区', '1');
INSERT INTO `weiapp_region` VALUES ('340521', '当涂县', '340500', '86.340000.340500.340521', '中国.安徽省.马鞍山市.当涂县', '1');
INSERT INTO `weiapp_region` VALUES ('340522', '含山县', '340500', '86.340000.340500.340522', '中国.安徽省.马鞍山市.含山县', '1');
INSERT INTO `weiapp_region` VALUES ('340523', '和县', '340500', '86.340000.340500.340523', '中国.安徽省.马鞍山市.和县', '1');
INSERT INTO `weiapp_region` VALUES ('340600', '淮北市', '340000', '86.340000.340600', '中国.安徽省.淮北市', '1');
INSERT INTO `weiapp_region` VALUES ('340602', '杜集区', '340600', '86.340000.340600.340602', '中国.安徽省.淮北市.杜集区', '1');
INSERT INTO `weiapp_region` VALUES ('340603', '相山区', '340600', '86.340000.340600.340603', '中国.安徽省.淮北市.相山区', '1');
INSERT INTO `weiapp_region` VALUES ('340604', '烈山区', '340600', '86.340000.340600.340604', '中国.安徽省.淮北市.烈山区', '1');
INSERT INTO `weiapp_region` VALUES ('340621', '濉溪县', '340600', '86.340000.340600.340621', '中国.安徽省.淮北市.濉溪县', '1');
INSERT INTO `weiapp_region` VALUES ('340700', '铜陵市', '340000', '86.340000.340700', '中国.安徽省.铜陵市', '1');
INSERT INTO `weiapp_region` VALUES ('340702', '铜官山区', '340700', '86.340000.340700.340702', '中国.安徽省.铜陵市.铜官山区', '1');
INSERT INTO `weiapp_region` VALUES ('340703', '狮子山区', '340700', '86.340000.340700.340703', '中国.安徽省.铜陵市.狮子山区', '1');
INSERT INTO `weiapp_region` VALUES ('340711', '郊区', '340700', '86.340000.340700.340711', '中国.安徽省.铜陵市.郊区', '1');
INSERT INTO `weiapp_region` VALUES ('340721', '铜陵县', '340700', '86.340000.340700.340721', '中国.安徽省.铜陵市.铜陵县', '1');
INSERT INTO `weiapp_region` VALUES ('340800', '安庆市', '340000', '86.340000.340800', '中国.安徽省.安庆市', '1');
INSERT INTO `weiapp_region` VALUES ('340802', '迎江区', '340800', '86.340000.340800.340802', '中国.安徽省.安庆市.迎江区', '1');
INSERT INTO `weiapp_region` VALUES ('340803', '大观区', '340800', '86.340000.340800.340803', '中国.安徽省.安庆市.大观区', '1');
INSERT INTO `weiapp_region` VALUES ('340811', '宜秀区', '340800', '86.340000.340800.340811', '中国.安徽省.安庆市.宜秀区', '1');
INSERT INTO `weiapp_region` VALUES ('340822', '怀宁县', '340800', '86.340000.340800.340822', '中国.安徽省.安庆市.怀宁县', '1');
INSERT INTO `weiapp_region` VALUES ('340823', '枞阳县', '340800', '86.340000.340800.340823', '中国.安徽省.安庆市.枞阳县', '1');
INSERT INTO `weiapp_region` VALUES ('340824', '潜山县', '340800', '86.340000.340800.340824', '中国.安徽省.安庆市.潜山县', '1');
INSERT INTO `weiapp_region` VALUES ('340825', '太湖县', '340800', '86.340000.340800.340825', '中国.安徽省.安庆市.太湖县', '1');
INSERT INTO `weiapp_region` VALUES ('340826', '宿松县', '340800', '86.340000.340800.340826', '中国.安徽省.安庆市.宿松县', '1');
INSERT INTO `weiapp_region` VALUES ('340827', '望江县', '340800', '86.340000.340800.340827', '中国.安徽省.安庆市.望江县', '1');
INSERT INTO `weiapp_region` VALUES ('340828', '岳西县', '340800', '86.340000.340800.340828', '中国.安徽省.安庆市.岳西县', '1');
INSERT INTO `weiapp_region` VALUES ('340881', '桐城市', '340800', '86.340000.340800.340881', '中国.安徽省.安庆市.桐城市', '1');
INSERT INTO `weiapp_region` VALUES ('341000', '黄山市', '340000', '86.340000.341000', '中国.安徽省.黄山市', '1');
INSERT INTO `weiapp_region` VALUES ('341002', '屯溪区', '341000', '86.340000.341000.341002', '中国.安徽省.黄山市.屯溪区', '1');
INSERT INTO `weiapp_region` VALUES ('341003', '黄山区', '341000', '86.340000.341000.341003', '中国.安徽省.黄山市.黄山区', '1');
INSERT INTO `weiapp_region` VALUES ('341004', '徽州区', '341000', '86.340000.341000.341004', '中国.安徽省.黄山市.徽州区', '1');
INSERT INTO `weiapp_region` VALUES ('341021', '歙县', '341000', '86.340000.341000.341021', '中国.安徽省.黄山市.歙县', '1');
INSERT INTO `weiapp_region` VALUES ('341022', '休宁县', '341000', '86.340000.341000.341022', '中国.安徽省.黄山市.休宁县', '1');
INSERT INTO `weiapp_region` VALUES ('341023', '黟县', '341000', '86.340000.341000.341023', '中国.安徽省.黄山市.黟县', '1');
INSERT INTO `weiapp_region` VALUES ('341024', '祁门县', '341000', '86.340000.341000.341024', '中国.安徽省.黄山市.祁门县', '1');
INSERT INTO `weiapp_region` VALUES ('341100', '滁州市', '340000', '86.340000.341100', '中国.安徽省.滁州市', '1');
INSERT INTO `weiapp_region` VALUES ('341102', '琅琊区', '341100', '86.340000.341100.341102', '中国.安徽省.滁州市.琅琊区', '1');
INSERT INTO `weiapp_region` VALUES ('341103', '南谯区', '341100', '86.340000.341100.341103', '中国.安徽省.滁州市.南谯区', '1');
INSERT INTO `weiapp_region` VALUES ('341122', '来安县', '341100', '86.340000.341100.341122', '中国.安徽省.滁州市.来安县', '1');
INSERT INTO `weiapp_region` VALUES ('341124', '全椒县', '341100', '86.340000.341100.341124', '中国.安徽省.滁州市.全椒县', '1');
INSERT INTO `weiapp_region` VALUES ('341125', '定远县', '341100', '86.340000.341100.341125', '中国.安徽省.滁州市.定远县', '1');
INSERT INTO `weiapp_region` VALUES ('341126', '凤阳县', '341100', '86.340000.341100.341126', '中国.安徽省.滁州市.凤阳县', '1');
INSERT INTO `weiapp_region` VALUES ('341200', '阜阳市', '340000', '86.340000.341200', '中国.安徽省.阜阳市', '1');
INSERT INTO `weiapp_region` VALUES ('341300', '宿州市', '340000', '86.340000.341300', '中国.安徽省.宿州市', '1');
INSERT INTO `weiapp_region` VALUES ('341500', '六安市', '340000', '86.340000.341500', '中国.安徽省.六安市', '1');
INSERT INTO `weiapp_region` VALUES ('341600', '亳州市', '340000', '86.340000.341600', '中国.安徽省.亳州市', '1');
INSERT INTO `weiapp_region` VALUES ('341700', '池州市', '340000', '86.340000.341700', '中国.安徽省.池州市', '1');
INSERT INTO `weiapp_region` VALUES ('341800', '宣城市', '340000', '86.340000.341800', '中国.安徽省.宣城市', '1');
INSERT INTO `weiapp_region` VALUES ('350100', '福州市', '350000', '86.350000.350100', '中国.福建省.福州市', '1');
INSERT INTO `weiapp_region` VALUES ('350200', '厦门市', '350000', '86.350000.350200', '中国.福建省.厦门市', '1');
INSERT INTO `weiapp_region` VALUES ('350300', '莆田市', '350000', '86.350000.350300', '中国.福建省.莆田市', '1');
INSERT INTO `weiapp_region` VALUES ('350400', '三明市', '350000', '86.350000.350400', '中国.福建省.三明市', '1');
INSERT INTO `weiapp_region` VALUES ('350500', '泉州市', '350000', '86.350000.350500', '中国.福建省.泉州市', '1');
INSERT INTO `weiapp_region` VALUES ('350600', '漳州市', '350000', '86.350000.350600', '中国.福建省.漳州市', '1');
INSERT INTO `weiapp_region` VALUES ('350700', '南平市', '350000', '86.350000.350700', '中国.福建省.南平市', '1');
INSERT INTO `weiapp_region` VALUES ('350800', '龙岩市', '350000', '86.350000.350800', '中国.福建省.龙岩市', '1');
INSERT INTO `weiapp_region` VALUES ('350900', '宁德市', '350000', '86.350000.350900', '中国.福建省.宁德市', '1');
INSERT INTO `weiapp_region` VALUES ('360000', '江西省', '86', '86.360000', '中国.江西省', '1');
INSERT INTO `weiapp_region` VALUES ('360100', '南昌市', '360000', '86.360000.360100', '中国.江西省.南昌市', '1');
INSERT INTO `weiapp_region` VALUES ('360200', '景德镇市', '360000', '86.360000.360200', '中国.江西省.景德镇市', '1');
INSERT INTO `weiapp_region` VALUES ('360300', '萍乡市', '360000', '86.360000.360300', '中国.江西省.萍乡市', '1');
INSERT INTO `weiapp_region` VALUES ('360400', '九江市', '360000', '86.360000.360400', '中国.江西省.九江市', '1');
INSERT INTO `weiapp_region` VALUES ('360500', '新余市', '360000', '86.360000.360500', '中国.江西省.新余市', '1');
INSERT INTO `weiapp_region` VALUES ('360600', '鹰潭市', '360000', '86.360000.360600', '中国.江西省.鹰潭市', '1');
INSERT INTO `weiapp_region` VALUES ('360700', '赣州市', '360000', '86.360000.360700', '中国.江西省.赣州市', '1');
INSERT INTO `weiapp_region` VALUES ('360800', '吉安市', '360000', '86.360000.360800', '中国.江西省.吉安市', '1');
INSERT INTO `weiapp_region` VALUES ('360900', '宜春市', '360000', '86.360000.360900', '中国.江西省.宜春市', '1');
INSERT INTO `weiapp_region` VALUES ('361000', '抚州市', '360000', '86.360000.361000', '中国.江西省.抚州市', '1');
INSERT INTO `weiapp_region` VALUES ('361100', '上饶市', '360000', '86.360000.361100', '中国.江西省.上饶市', '1');
INSERT INTO `weiapp_region` VALUES ('370000', '山东省', '86', '86.370000', '中国.山东省', '1');
INSERT INTO `weiapp_region` VALUES ('370100', '济南市', '370000', '86.370000.370100', '中国.山东省.济南市', '1');
INSERT INTO `weiapp_region` VALUES ('370200', '青岛市', '370000', '86.370000.370200', '中国.山东省.青岛市', '1');
INSERT INTO `weiapp_region` VALUES ('370300', '淄博市', '370000', '86.370000.370300', '中国.山东省.淄博市', '1');
INSERT INTO `weiapp_region` VALUES ('370400', '枣庄市', '370000', '86.370000.370400', '中国.山东省.枣庄市', '1');
INSERT INTO `weiapp_region` VALUES ('370500', '东营市', '370000', '86.370000.370500', '中国.山东省.东营市', '1');
INSERT INTO `weiapp_region` VALUES ('370600', '烟台市', '370000', '86.370000.370600', '中国.山东省.烟台市', '1');
INSERT INTO `weiapp_region` VALUES ('370700', '潍坊市', '370000', '86.370000.370700', '中国.山东省.潍坊市', '1');
INSERT INTO `weiapp_region` VALUES ('370800', '济宁市', '370000', '86.370000.370800', '中国.山东省.济宁市', '1');
INSERT INTO `weiapp_region` VALUES ('370900', '泰安市', '370000', '86.370000.370900', '中国.山东省.泰安市', '1');
INSERT INTO `weiapp_region` VALUES ('370902', '泰山区', '370900', '86.370000.370900.370902', '中国.山东省.泰安市.泰山区', '1');
INSERT INTO `weiapp_region` VALUES ('370911', '岱岳区', '370900', '86.370000.370900.370911', '中国.山东省.泰安市.岱岳区', '1');
INSERT INTO `weiapp_region` VALUES ('370921', '宁阳县', '370900', '86.370000.370900.370921', '中国.山东省.泰安市.宁阳县', '1');
INSERT INTO `weiapp_region` VALUES ('370923', '东平县', '370900', '86.370000.370900.370923', '中国.山东省.泰安市.东平县', '1');
INSERT INTO `weiapp_region` VALUES ('371000', '威海市', '370000', '86.370000.371000', '中国.山东省.威海市', '1');
INSERT INTO `weiapp_region` VALUES ('371100', '日照市', '370000', '86.370000.371100', '中国.山东省.日照市', '1');
INSERT INTO `weiapp_region` VALUES ('371200', '莱芜市', '370000', '86.370000.371200', '中国.山东省.莱芜市', '1');
INSERT INTO `weiapp_region` VALUES ('371300', '临沂市', '370000', '86.370000.371300', '中国.山东省.临沂市', '1');
INSERT INTO `weiapp_region` VALUES ('371400', '德州市', '370000', '86.370000.371400', '中国.山东省.德州市', '1');
INSERT INTO `weiapp_region` VALUES ('371500', '聊城市', '370000', '86.370000.371500', '中国.山东省.聊城市', '1');
INSERT INTO `weiapp_region` VALUES ('371600', '滨州市', '370000', '86.370000.371600', '中国.山东省.滨州市', '1');
INSERT INTO `weiapp_region` VALUES ('371700', '菏泽市', '370000', '86.370000.371700', '中国.山东省.菏泽市', '1');
INSERT INTO `weiapp_region` VALUES ('410000', '河南省', '86', '86.410000', '中国.河南省', '1');
INSERT INTO `weiapp_region` VALUES ('410100', '郑州市', '410000', '86.410000.410100', '中国.河南省.郑州市', '1');
INSERT INTO `weiapp_region` VALUES ('410200', '开封市', '410000', '86.410000.410200', '中国.河南省.开封市', '1');
INSERT INTO `weiapp_region` VALUES ('410300', '洛阳市', '410000', '86.410000.410300', '中国.河南省.洛阳市', '1');
INSERT INTO `weiapp_region` VALUES ('410400', '平顶山市', '410000', '86.410000.410400', '中国.河南省.平顶山市', '1');
INSERT INTO `weiapp_region` VALUES ('410500', '安阳市', '410000', '86.410000.410500', '中国.河南省.安阳市', '1');
INSERT INTO `weiapp_region` VALUES ('410600', '鹤壁市', '410000', '86.410000.410600', '中国.河南省.鹤壁市', '1');
INSERT INTO `weiapp_region` VALUES ('410700', '新乡市', '410000', '86.410000.410700', '中国.河南省.新乡市', '1');
INSERT INTO `weiapp_region` VALUES ('410800', '焦作市', '410000', '86.410000.410800', '中国.河南省.焦作市', '1');
INSERT INTO `weiapp_region` VALUES ('410900', '濮阳市', '410000', '86.410000.410900', '中国.河南省.濮阳市', '1');
INSERT INTO `weiapp_region` VALUES ('411000', '许昌市', '410000', '86.410000.411000', '中国.河南省.许昌市', '1');
INSERT INTO `weiapp_region` VALUES ('411100', '漯河市', '410000', '86.410000.411100', '中国.河南省.漯河市', '1');
INSERT INTO `weiapp_region` VALUES ('411200', '三门峡市', '410000', '86.410000.411200', '中国.河南省.三门峡市', '1');
INSERT INTO `weiapp_region` VALUES ('411300', '南阳市', '410000', '86.410000.411300', '中国.河南省.南阳市', '1');
INSERT INTO `weiapp_region` VALUES ('411400', '商丘市', '410000', '86.410000.411400', '中国.河南省.商丘市', '1');
INSERT INTO `weiapp_region` VALUES ('411500', '信阳市', '410000', '86.410000.411500', '中国.河南省.信阳市', '1');
INSERT INTO `weiapp_region` VALUES ('411600', '周口市', '410000', '86.410000.411600', '中国.河南省.周口市', '1');
INSERT INTO `weiapp_region` VALUES ('411700', '驻马店市', '410000', '86.410000.411700', '中国.河南省.驻马店市', '1');
INSERT INTO `weiapp_region` VALUES ('420000', '湖北省', '86', '86.420000', '中国.湖北省', '1');
INSERT INTO `weiapp_region` VALUES ('420100', '武汉市', '420000', '86.420000.420100', '中国.湖北省.武汉市', '1');
INSERT INTO `weiapp_region` VALUES ('420200', '黄石市', '420000', '86.420000.420200', '中国.湖北省.黄石市', '1');
INSERT INTO `weiapp_region` VALUES ('420300', '十堰市', '420000', '86.420000.420300', '中国.湖北省.十堰市', '1');
INSERT INTO `weiapp_region` VALUES ('420500', '宜昌市', '420000', '86.420000.420500', '中国.湖北省.宜昌市', '1');
INSERT INTO `weiapp_region` VALUES ('420600', '襄阳市', '420000', '86.420000.420600', '中国.湖北省.襄阳市', '1');
INSERT INTO `weiapp_region` VALUES ('420700', '鄂州市', '420000', '86.420000.420700', '中国.湖北省.鄂州市', '1');
INSERT INTO `weiapp_region` VALUES ('420800', '荆门市', '420000', '86.420000.420800', '中国.湖北省.荆门市', '1');
INSERT INTO `weiapp_region` VALUES ('420900', '孝感市', '420000', '86.420000.420900', '中国.湖北省.孝感市', '1');
INSERT INTO `weiapp_region` VALUES ('420902', '孝南区', '420900', '86.420000.420900.420902', '中国.湖北省.孝感市.孝南区', '1');
INSERT INTO `weiapp_region` VALUES ('420921', '孝昌县', '420900', '86.420000.420900.420921', '中国.湖北省.孝感市.孝昌县', '1');
INSERT INTO `weiapp_region` VALUES ('420922', '大悟县', '420900', '86.420000.420900.420922', '中国.湖北省.孝感市.大悟县', '1');
INSERT INTO `weiapp_region` VALUES ('420923', '云梦县', '420900', '86.420000.420900.420923', '中国.湖北省.孝感市.云梦县', '1');
INSERT INTO `weiapp_region` VALUES ('420981', '应城市', '420900', '86.420000.420900.420981', '中国.湖北省.孝感市.应城市', '1');
INSERT INTO `weiapp_region` VALUES ('420982', '安陆市', '420900', '86.420000.420900.420982', '中国.湖北省.孝感市.安陆市', '1');
INSERT INTO `weiapp_region` VALUES ('420984', '汉川市', '420900', '86.420000.420900.420984', '中国.湖北省.孝感市.汉川市', '1');
INSERT INTO `weiapp_region` VALUES ('421000', '荆州市', '420000', '86.420000.421000', '中国.湖北省.荆州市', '1');
INSERT INTO `weiapp_region` VALUES ('421002', '沙市区', '421000', '86.420000.421000.421002', '中国.湖北省.荆州市.沙市区', '1');
INSERT INTO `weiapp_region` VALUES ('421003', '荆州区', '421000', '86.420000.421000.421003', '中国.湖北省.荆州市.荆州区', '1');
INSERT INTO `weiapp_region` VALUES ('421022', '公安县', '421000', '86.420000.421000.421022', '中国.湖北省.荆州市.公安县', '1');
INSERT INTO `weiapp_region` VALUES ('421023', '监利县', '421000', '86.420000.421000.421023', '中国.湖北省.荆州市.监利县', '1');
INSERT INTO `weiapp_region` VALUES ('421024', '江陵县', '421000', '86.420000.421000.421024', '中国.湖北省.荆州市.江陵县', '1');
INSERT INTO `weiapp_region` VALUES ('421081', '石首市', '421000', '86.420000.421000.421081', '中国.湖北省.荆州市.石首市', '1');
INSERT INTO `weiapp_region` VALUES ('421083', '洪湖市', '421000', '86.420000.421000.421083', '中国.湖北省.荆州市.洪湖市', '1');
INSERT INTO `weiapp_region` VALUES ('421087', '松滋市', '421000', '86.420000.421000.421087', '中国.湖北省.荆州市.松滋市', '1');
INSERT INTO `weiapp_region` VALUES ('421100', '黄冈市', '420000', '86.420000.421100', '中国.湖北省.黄冈市', '1');
INSERT INTO `weiapp_region` VALUES ('421102', '黄州区', '421100', '86.420000.421100.421102', '中国.湖北省.黄冈市.黄州区', '1');
INSERT INTO `weiapp_region` VALUES ('421121', '团风县', '421100', '86.420000.421100.421121', '中国.湖北省.黄冈市.团风县', '1');
INSERT INTO `weiapp_region` VALUES ('421122', '红安县', '421100', '86.420000.421100.421122', '中国.湖北省.黄冈市.红安县', '1');
INSERT INTO `weiapp_region` VALUES ('421123', '罗田县', '421100', '86.420000.421100.421123', '中国.湖北省.黄冈市.罗田县', '1');
INSERT INTO `weiapp_region` VALUES ('421124', '英山县', '421100', '86.420000.421100.421124', '中国.湖北省.黄冈市.英山县', '1');
INSERT INTO `weiapp_region` VALUES ('421200', '咸宁市', '420000', '86.420000.421200', '中国.湖北省.咸宁市', '1');
INSERT INTO `weiapp_region` VALUES ('421300', '随州市', '420000', '86.420000.421300', '中国.湖北省.随州市', '1');
INSERT INTO `weiapp_region` VALUES ('430000', '湖南省', '86', '86.430000', '中国.湖南省', '1');
INSERT INTO `weiapp_region` VALUES ('430100', '长沙市', '430000', '86.430000.430100', '中国.湖南省.长沙市', '1');
INSERT INTO `weiapp_region` VALUES ('430200', '株洲市', '430000', '86.430000.430200', '中国.湖南省.株洲市', '1');
INSERT INTO `weiapp_region` VALUES ('430223', '攸县', '430200', '86.430000.430200.430223', '中国.湖南省.株洲市.攸县', '1');
INSERT INTO `weiapp_region` VALUES ('430300', '湘潭市', '430000', '86.430000.430300', '中国.湖南省.湘潭市', '1');
INSERT INTO `weiapp_region` VALUES ('430400', '衡阳市', '430000', '86.430000.430400', '中国.湖南省.衡阳市', '1');
INSERT INTO `weiapp_region` VALUES ('430500', '邵阳市', '430000', '86.430000.430500', '中国.湖南省.邵阳市', '1');
INSERT INTO `weiapp_region` VALUES ('430600', '岳阳市', '430000', '86.430000.430600', '中国.湖南省.岳阳市', '1');
INSERT INTO `weiapp_region` VALUES ('430700', '常德市', '430000', '86.430000.430700', '中国.湖南省.常德市', '1');
INSERT INTO `weiapp_region` VALUES ('430723', '澧县', '430700', '86.430000.430700.430723', '中国.湖南省.常德市.澧县', '1');
INSERT INTO `weiapp_region` VALUES ('430800', '张家界市', '430000', '86.430000.430800', '中国.湖南省.张家界市', '1');
INSERT INTO `weiapp_region` VALUES ('430900', '益阳市', '430000', '86.430000.430900', '中国.湖南省.益阳市', '1');
INSERT INTO `weiapp_region` VALUES ('430902', '资阳区', '430900', '86.430000.430900.430902', '中国.湖南省.益阳市.资阳区', '1');
INSERT INTO `weiapp_region` VALUES ('430921', '南县', '430900', '86.430000.430900.430921', '中国.湖南省.益阳市.南县', '1');
INSERT INTO `weiapp_region` VALUES ('431000', '郴州市', '430000', '86.430000.431000', '中国.湖南省.郴州市', '1');
INSERT INTO `weiapp_region` VALUES ('431100', '永州市', '430000', '86.430000.431100', '中国.湖南省.永州市', '1');
INSERT INTO `weiapp_region` VALUES ('431124', '道县', '431100', '86.430000.431100.431124', '中国.湖南省.永州市.道县', '1');
INSERT INTO `weiapp_region` VALUES ('431200', '怀化市', '430000', '86.430000.431200', '中国.湖南省.怀化市', '1');
INSERT INTO `weiapp_region` VALUES ('431300', '娄底市', '430000', '86.430000.431300', '中国.湖南省.娄底市', '1');
INSERT INTO `weiapp_region` VALUES ('431302', '娄星区', '431300', '86.430000.431300.431302', '中国.湖南省.娄底市.娄星区', '1');
INSERT INTO `weiapp_region` VALUES ('431321', '双峰县', '431300', '86.430000.431300.431321', '中国.湖南省.娄底市.双峰县', '1');
INSERT INTO `weiapp_region` VALUES ('431322', '新化县', '431300', '86.430000.431300.431322', '中国.湖南省.娄底市.新化县', '1');
INSERT INTO `weiapp_region` VALUES ('431381', '冷水江市', '431300', '86.430000.431300.431381', '中国.湖南省.娄底市.冷水江市', '1');
INSERT INTO `weiapp_region` VALUES ('431382', '涟源市', '431300', '86.430000.431300.431382', '中国.湖南省.娄底市.涟源市', '1');
INSERT INTO `weiapp_region` VALUES ('440000', '广东省', '86', '86.440000', '中国.广东省', '1');
INSERT INTO `weiapp_region` VALUES ('440100', '广州市', '440000', '86.440000.440100', '中国.广东省.广州市', '1');
INSERT INTO `weiapp_region` VALUES ('440200', '韶关市', '440000', '86.440000.440200', '中国.广东省.韶关市', '1');
INSERT INTO `weiapp_region` VALUES ('440300', '深圳市', '440000', '86.440000.440300', '中国.广东省.深圳市', '1');
INSERT INTO `weiapp_region` VALUES ('440303', '罗湖区', '440300', '86.440000.440300.440303', '中国.广东省.深圳市.罗湖区', '1');
INSERT INTO `weiapp_region` VALUES ('440400', '珠海市', '440000', '86.440000.440400', '中国.广东省.珠海市', '1');
INSERT INTO `weiapp_region` VALUES ('440402', '香洲区', '440400', '86.440000.440400.440402', '中国.广东省.珠海市.香洲区', '1');
INSERT INTO `weiapp_region` VALUES ('440500', '汕头市', '440000', '86.440000.440500', '中国.广东省.汕头市', '1');
INSERT INTO `weiapp_region` VALUES ('440600', '佛山市', '440000', '86.440000.440600', '中国.广东省.佛山市', '1');
INSERT INTO `weiapp_region` VALUES ('440700', '江门市', '440000', '86.440000.440700', '中国.广东省.江门市', '1');
INSERT INTO `weiapp_region` VALUES ('440800', '湛江市', '440000', '86.440000.440800', '中国.广东省.湛江市', '1');
INSERT INTO `weiapp_region` VALUES ('440802', '赤坎区', '440800', '86.440000.440800.440802', '中国.广东省.湛江市.赤坎区', '1');
INSERT INTO `weiapp_region` VALUES ('440900', '茂名市', '440000', '86.440000.440900', '中国.广东省.茂名市', '1');
INSERT INTO `weiapp_region` VALUES ('441200', '肇庆市', '440000', '86.440000.441200', '中国.广东省.肇庆市', '1');
INSERT INTO `weiapp_region` VALUES ('441300', '惠州市', '440000', '86.440000.441300', '中国.广东省.惠州市', '1');
INSERT INTO `weiapp_region` VALUES ('441400', '梅州市', '440000', '86.440000.441400', '中国.广东省.梅州市', '1');
INSERT INTO `weiapp_region` VALUES ('441421', '梅县', '441400', '86.440000.441400.441421', '中国.广东省.梅州市.梅县', '1');
INSERT INTO `weiapp_region` VALUES ('441500', '汕尾市', '440000', '86.440000.441500', '中国.广东省.汕尾市', '1');
INSERT INTO `weiapp_region` VALUES ('441502', '城区', '441500', '86.440000.441500.441502', '中国.广东省.汕尾市.城区', '1');
INSERT INTO `weiapp_region` VALUES ('441600', '河源市', '440000', '86.440000.441600', '中国.广东省.河源市', '1');
INSERT INTO `weiapp_region` VALUES ('441700', '阳江市', '440000', '86.440000.441700', '中国.广东省.阳江市', '1');
INSERT INTO `weiapp_region` VALUES ('441800', '清远市', '440000', '86.440000.441800', '中国.广东省.清远市', '1');
INSERT INTO `weiapp_region` VALUES ('441900', '东莞市', '440000', '86.440000.441900', '中国.广东省.东莞市', '1');
INSERT INTO `weiapp_region` VALUES ('442000', '中山市', '440000', '86.440000.442000', '中国.广东省.中山市', '1');
INSERT INTO `weiapp_region` VALUES ('445100', '潮州市', '440000', '86.440000.445100', '中国.广东省.潮州市', '1');
INSERT INTO `weiapp_region` VALUES ('445200', '揭阳市', '440000', '86.440000.445200', '中国.广东省.揭阳市', '1');
INSERT INTO `weiapp_region` VALUES ('445300', '云浮市', '440000', '86.440000.445300', '中国.广东省.云浮市', '1');
INSERT INTO `weiapp_region` VALUES ('450000', '广西壮族自治区', '86', '86.450000', '中国.广西壮族自治区', '1');
INSERT INTO `weiapp_region` VALUES ('450100', '南宁市', '450000', '86.450000.450100', '中国.广西壮族自治区.南宁市', '1');
INSERT INTO `weiapp_region` VALUES ('450200', '柳州市', '450000', '86.450000.450200', '中国.广西壮族自治区.柳州市', '1');
INSERT INTO `weiapp_region` VALUES ('450300', '桂林市', '450000', '86.450000.450300', '中国.广西壮族自治区.桂林市', '1');
INSERT INTO `weiapp_region` VALUES ('450400', '梧州市', '450000', '86.450000.450400', '中国.广西壮族自治区.梧州市', '1');
INSERT INTO `weiapp_region` VALUES ('450500', '北海市', '450000', '86.450000.450500', '中国.广西壮族自治区.北海市', '1');
INSERT INTO `weiapp_region` VALUES ('450700', '钦州市', '450000', '86.450000.450700', '中国.广西壮族自治区.钦州市', '1');
INSERT INTO `weiapp_region` VALUES ('450800', '贵港市', '450000', '86.450000.450800', '中国.广西壮族自治区.贵港市', '1');
INSERT INTO `weiapp_region` VALUES ('450900', '玉林市', '450000', '86.450000.450900', '中国.广西壮族自治区.玉林市', '1');
INSERT INTO `weiapp_region` VALUES ('451000', '百色市', '450000', '86.450000.451000', '中国.广西壮族自治区.百色市', '1');
INSERT INTO `weiapp_region` VALUES ('451100', '贺州市', '450000', '86.450000.451100', '中国.广西壮族自治区.贺州市', '1');
INSERT INTO `weiapp_region` VALUES ('451200', '河池市', '450000', '86.450000.451200', '中国.广西壮族自治区.河池市', '1');
INSERT INTO `weiapp_region` VALUES ('451300', '来宾市', '450000', '86.450000.451300', '中国.广西壮族自治区.来宾市', '1');
INSERT INTO `weiapp_region` VALUES ('451400', '崇左市', '450000', '86.450000.451400', '中国.广西壮族自治区.崇左市', '1');
INSERT INTO `weiapp_region` VALUES ('460000', '海南省', '86', '86.460000', '中国.海南省', '1');
INSERT INTO `weiapp_region` VALUES ('460100', '海口市', '460000', '86.460000.460100', '中国.海南省.海口市', '1');
INSERT INTO `weiapp_region` VALUES ('460200', '三亚市', '460000', '86.460000.460200', '中国.海南省.三亚市', '1');
INSERT INTO `weiapp_region` VALUES ('500000', '重庆市', '86', '86.500000', '中国.重庆市', '1');
INSERT INTO `weiapp_region` VALUES ('500101', '万州区', '500000', '86.500000.500101', '中国.重庆市.万州区', '1');
INSERT INTO `weiapp_region` VALUES ('500102', '涪陵区', '500000', '86.500000.500102', '中国.重庆市.涪陵区', '1');
INSERT INTO `weiapp_region` VALUES ('500103', '渝中区', '500000', '86.500000.500103', '中国.重庆市.渝中区', '1');
INSERT INTO `weiapp_region` VALUES ('500104', '大渡口区', '500000', '86.500000.500104', '中国.重庆市.大渡口区', '1');
INSERT INTO `weiapp_region` VALUES ('500105', '江北区', '500000', '86.500000.500105', '中国.重庆市.江北区', '1');
INSERT INTO `weiapp_region` VALUES ('500106', '沙坪坝区', '500000', '86.500000.500106', '中国.重庆市.沙坪坝区', '1');
INSERT INTO `weiapp_region` VALUES ('500107', '九龙坡区', '500000', '86.500000.500107', '中国.重庆市.九龙坡区', '1');
INSERT INTO `weiapp_region` VALUES ('500108', '南岸区', '500000', '86.500000.500108', '中国.重庆市.南岸区', '1');
INSERT INTO `weiapp_region` VALUES ('500109', '北碚区', '500000', '86.500000.500109', '中国.重庆市.北碚区', '1');
INSERT INTO `weiapp_region` VALUES ('500110', '綦江区', '500000', '86.500000.500110', '中国.重庆市.綦江区', '1');
INSERT INTO `weiapp_region` VALUES ('500111', '大足区', '500000', '86.500000.500111', '中国.重庆市.大足区', '1');
INSERT INTO `weiapp_region` VALUES ('500112', '渝北区', '500000', '86.500000.500112', '中国.重庆市.渝北区', '1');
INSERT INTO `weiapp_region` VALUES ('500113', '巴南区', '500000', '86.500000.500113', '中国.重庆市.巴南区', '1');
INSERT INTO `weiapp_region` VALUES ('500114', '黔江区', '500000', '86.500000.500114', '中国.重庆市.黔江区', '1');
INSERT INTO `weiapp_region` VALUES ('500115', '长寿区', '500000', '86.500000.500115', '中国.重庆市.长寿区', '1');
INSERT INTO `weiapp_region` VALUES ('500116', '江津区', '500000', '86.500000.500116', '中国.重庆市.江津区', '1');
INSERT INTO `weiapp_region` VALUES ('500117', '合川区', '500000', '86.500000.500117', '中国.重庆市.合川区', '1');
INSERT INTO `weiapp_region` VALUES ('500118', '永川区', '500000', '86.500000.500118', '中国.重庆市.永川区', '1');
INSERT INTO `weiapp_region` VALUES ('500119', '南川区', '500000', '86.500000.500119', '中国.重庆市.南川区', '1');
INSERT INTO `weiapp_region` VALUES ('500223', '潼南县', '500000', '86.500000.500223', '中国.重庆市.潼南县', '1');
INSERT INTO `weiapp_region` VALUES ('500224', '铜梁县', '500000', '86.500000.500224', '中国.重庆市.铜梁县', '1');
INSERT INTO `weiapp_region` VALUES ('500226', '荣昌县', '500000', '86.500000.500226', '中国.重庆市.荣昌县', '1');
INSERT INTO `weiapp_region` VALUES ('500227', '璧山县', '500000', '86.500000.500227', '中国.重庆市.璧山县', '1');
INSERT INTO `weiapp_region` VALUES ('500228', '梁平县', '500000', '86.500000.500228', '中国.重庆市.梁平县', '1');
INSERT INTO `weiapp_region` VALUES ('500229', '城口县', '500000', '86.500000.500229', '中国.重庆市.城口县', '1');
INSERT INTO `weiapp_region` VALUES ('500230', '丰都县', '500000', '86.500000.500230', '中国.重庆市.丰都县', '1');
INSERT INTO `weiapp_region` VALUES ('500231', '垫江县', '500000', '86.500000.500231', '中国.重庆市.垫江县', '1');
INSERT INTO `weiapp_region` VALUES ('500232', '武隆县', '500000', '86.500000.500232', '中国.重庆市.武隆县', '1');
INSERT INTO `weiapp_region` VALUES ('500233', '忠县', '500000', '86.500000.500233', '中国.重庆市.忠县', '1');
INSERT INTO `weiapp_region` VALUES ('500234', '开县', '500000', '86.500000.500234', '中国.重庆市.开县', '1');
INSERT INTO `weiapp_region` VALUES ('500235', '云阳县', '500000', '86.500000.500235', '中国.重庆市.云阳县', '1');
INSERT INTO `weiapp_region` VALUES ('500236', '奉节县', '500000', '86.500000.500236', '中国.重庆市.奉节县', '1');
INSERT INTO `weiapp_region` VALUES ('500237', '巫山县', '500000', '86.500000.500237', '中国.重庆市.巫山县', '1');
INSERT INTO `weiapp_region` VALUES ('500238', '巫溪县', '500000', '86.500000.500238', '中国.重庆市.巫溪县', '1');
INSERT INTO `weiapp_region` VALUES ('500240', '石柱土家族自治县', '500000', '86.500000.500240', '中国.重庆市.石柱土家族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('510000', '四川省', '86', '86.510000', '中国.四川省', '1');
INSERT INTO `weiapp_region` VALUES ('510100', '成都市', '510000', '86.510000.510100', '中国.四川省.成都市', '1');
INSERT INTO `weiapp_region` VALUES ('510104', '锦江区', '510100', '86.510000.510100.510104', '中国.四川省.成都市.锦江区', '1');
INSERT INTO `weiapp_region` VALUES ('510105', '青羊区', '510100', '86.510000.510100.510105', '中国.四川省.成都市.青羊区', '1');
INSERT INTO `weiapp_region` VALUES ('510106', '金牛区', '510100', '86.510000.510100.510106', '中国.四川省.成都市.金牛区', '1');
INSERT INTO `weiapp_region` VALUES ('510107', '武侯区', '510100', '86.510000.510100.510107', '中国.四川省.成都市.武侯区', '1');
INSERT INTO `weiapp_region` VALUES ('510108', '成华区', '510100', '86.510000.510100.510108', '中国.四川省.成都市.成华区', '1');
INSERT INTO `weiapp_region` VALUES ('510124', '郫县', '510100', '86.510000.510100.510124', '中国.四川省.成都市.郫县', '1');
INSERT INTO `weiapp_region` VALUES ('510300', '自贡市', '510000', '86.510000.510300', '中国.四川省.自贡市', '1');
INSERT INTO `weiapp_region` VALUES ('510321', '荣县', '510300', '86.510000.510300.510321', '中国.四川省.自贡市.荣县', '1');
INSERT INTO `weiapp_region` VALUES ('510400', '攀枝花市', '510000', '86.510000.510400', '中国.四川省.攀枝花市', '1');
INSERT INTO `weiapp_region` VALUES ('510500', '泸州市', '510000', '86.510000.510500', '中国.四川省.泸州市', '1');
INSERT INTO `weiapp_region` VALUES ('510521', '泸县', '510500', '86.510000.510500.510521', '中国.四川省.泸州市.泸县', '1');
INSERT INTO `weiapp_region` VALUES ('510600', '德阳市', '510000', '86.510000.510600', '中国.四川省.德阳市', '1');
INSERT INTO `weiapp_region` VALUES ('510700', '绵阳市', '510000', '86.510000.510700', '中国.四川省.绵阳市', '1');
INSERT INTO `weiapp_region` VALUES ('510724', '安县', '510700', '86.510000.510700.510724', '中国.四川省.绵阳市.安县', '1');
INSERT INTO `weiapp_region` VALUES ('510800', '广元市', '510000', '86.510000.510800', '中国.四川省.广元市', '1');
INSERT INTO `weiapp_region` VALUES ('510802', '利州区', '510800', '86.510000.510800.510802', '中国.四川省.广元市.利州区', '1');
INSERT INTO `weiapp_region` VALUES ('510900', '遂宁市', '510000', '86.510000.510900', '中国.四川省.遂宁市', '1');
INSERT INTO `weiapp_region` VALUES ('511000', '内江市', '510000', '86.510000.511000', '中国.四川省.内江市', '1');
INSERT INTO `weiapp_region` VALUES ('511100', '乐山市', '510000', '86.510000.511100', '中国.四川省.乐山市', '1');
INSERT INTO `weiapp_region` VALUES ('511300', '南充市', '510000', '86.510000.511300', '中国.四川省.南充市', '1');
INSERT INTO `weiapp_region` VALUES ('511400', '眉山市', '510000', '86.510000.511400', '中国.四川省.眉山市', '1');
INSERT INTO `weiapp_region` VALUES ('511500', '宜宾市', '510000', '86.510000.511500', '中国.四川省.宜宾市', '1');
INSERT INTO `weiapp_region` VALUES ('511525', '高县', '511500', '86.510000.511500.511525', '中国.四川省.宜宾市.高县', '1');
INSERT INTO `weiapp_region` VALUES ('511526', '珙县', '511500', '86.510000.511500.511526', '中国.四川省.宜宾市.珙县', '1');
INSERT INTO `weiapp_region` VALUES ('511600', '广安市', '510000', '86.510000.511600', '中国.四川省.广安市', '1');
INSERT INTO `weiapp_region` VALUES ('511700', '达州市', '510000', '86.510000.511700', '中国.四川省.达州市', '1');
INSERT INTO `weiapp_region` VALUES ('511721', '达县', '511700', '86.510000.511700.511721', '中国.四川省.达州市.达县', '1');
INSERT INTO `weiapp_region` VALUES ('511725', '渠县', '511700', '86.510000.511700.511725', '中国.四川省.达州市.渠县', '1');
INSERT INTO `weiapp_region` VALUES ('511800', '雅安市', '510000', '86.510000.511800', '中国.四川省.雅安市', '1');
INSERT INTO `weiapp_region` VALUES ('511900', '巴中市', '510000', '86.510000.511900', '中国.四川省.巴中市', '1');
INSERT INTO `weiapp_region` VALUES ('512000', '资阳市', '510000', '86.510000.512000', '中国.四川省.资阳市', '1');
INSERT INTO `weiapp_region` VALUES ('520000', '贵州省', '86', '86.520000', '中国.贵州省', '1');
INSERT INTO `weiapp_region` VALUES ('520100', '贵阳市', '520000', '86.520000.520100', '中国.贵州省.贵阳市', '1');
INSERT INTO `weiapp_region` VALUES ('520200', '六盘水市', '520000', '86.520000.520200', '中国.贵州省.六盘水市', '1');
INSERT INTO `weiapp_region` VALUES ('520300', '遵义市', '520000', '86.520000.520300', '中国.贵州省.遵义市', '1');
INSERT INTO `weiapp_region` VALUES ('520400', '安顺市', '520000', '86.520000.520400', '中国.贵州省.安顺市', '1');
INSERT INTO `weiapp_region` VALUES ('520500', '毕节市', '520000', '86.520000.520500', '中国.贵州省.毕节市', '1');
INSERT INTO `weiapp_region` VALUES ('520600', '铜仁市', '520000', '86.520000.520600', '中国.贵州省.铜仁市', '1');
INSERT INTO `weiapp_region` VALUES ('530000', '云南省', '86', '86.530000', '中国.云南省', '1');
INSERT INTO `weiapp_region` VALUES ('530100', '昆明市', '530000', '86.530000.530100', '中国.云南省.昆明市', '1');
INSERT INTO `weiapp_region` VALUES ('530300', '曲靖市', '530000', '86.530000.530300', '中国.云南省.曲靖市', '1');
INSERT INTO `weiapp_region` VALUES ('530400', '玉溪市', '530000', '86.530000.530400', '中国.云南省.玉溪市', '1');
INSERT INTO `weiapp_region` VALUES ('530402', '红塔区', '530400', '86.530000.530400.530402', '中国.云南省.玉溪市.红塔区', '1');
INSERT INTO `weiapp_region` VALUES ('530421', '江川县', '530400', '86.530000.530400.530421', '中国.云南省.玉溪市.江川县', '1');
INSERT INTO `weiapp_region` VALUES ('530500', '保山市', '530000', '86.530000.530500', '中国.云南省.保山市', '1');
INSERT INTO `weiapp_region` VALUES ('530600', '昭通市', '530000', '86.530000.530600', '中国.云南省.昭通市', '1');
INSERT INTO `weiapp_region` VALUES ('530700', '丽江市', '530000', '86.530000.530700', '中国.云南省.丽江市', '1');
INSERT INTO `weiapp_region` VALUES ('530800', '普洱市', '530000', '86.530000.530800', '中国.云南省.普洱市', '1');
INSERT INTO `weiapp_region` VALUES ('530900', '临沧市', '530000', '86.530000.530900', '中国.云南省.临沧市', '1');
INSERT INTO `weiapp_region` VALUES ('530922', '云县', '530900', '86.530000.530900.530922', '中国.云南省.临沧市.云县', '1');
INSERT INTO `weiapp_region` VALUES ('540000', '西藏自治区', '86', '86.540000', '中国.西藏自治区', '1');
INSERT INTO `weiapp_region` VALUES ('540100', '拉萨市', '540000', '86.540000.540100', '中国.西藏自治区.拉萨市', '1');
INSERT INTO `weiapp_region` VALUES ('542100', '昌都地区', '540000', '86.540000.542100', '中国.西藏自治区.昌都地区', '1');
INSERT INTO `weiapp_region` VALUES ('542200', '山南地区', '540000', '86.540000.542200', '中国.西藏自治区.山南地区', '1');
INSERT INTO `weiapp_region` VALUES ('610000', '陕西省', '86', '86.610000', '中国.陕西省', '1');
INSERT INTO `weiapp_region` VALUES ('610100', '西安市', '610000', '86.610000.610100', '中国.陕西省.西安市', '1');
INSERT INTO `weiapp_region` VALUES ('610200', '铜川市', '610000', '86.610000.610200', '中国.陕西省.铜川市', '1');
INSERT INTO `weiapp_region` VALUES ('610300', '宝鸡市', '610000', '86.610000.610300', '中国.陕西省.宝鸡市', '1');
INSERT INTO `weiapp_region` VALUES ('610400', '咸阳市', '610000', '86.610000.610400', '中国.陕西省.咸阳市', '1');
INSERT INTO `weiapp_region` VALUES ('610500', '渭南市', '610000', '86.610000.610500', '中国.陕西省.渭南市', '1');
INSERT INTO `weiapp_region` VALUES ('610600', '延安市', '610000', '86.610000.610600', '中国.陕西省.延安市', '1');
INSERT INTO `weiapp_region` VALUES ('610700', '汉中市', '610000', '86.610000.610700', '中国.陕西省.汉中市', '1');
INSERT INTO `weiapp_region` VALUES ('610800', '榆林市', '610000', '86.610000.610800', '中国.陕西省.榆林市', '1');
INSERT INTO `weiapp_region` VALUES ('610900', '安康市', '610000', '86.610000.610900', '中国.陕西省.安康市', '1');
INSERT INTO `weiapp_region` VALUES ('611000', '商洛市', '610000', '86.610000.611000', '中国.陕西省.商洛市', '1');
INSERT INTO `weiapp_region` VALUES ('620000', '甘肃省', '86', '86.620000', '中国.甘肃省', '1');
INSERT INTO `weiapp_region` VALUES ('620100', '兰州市', '620000', '86.620000.620100', '中国.甘肃省.兰州市', '1');
INSERT INTO `weiapp_region` VALUES ('620200', '嘉峪关市', '620000', '86.620000.620200', '中国.甘肃省.嘉峪关市', '1');
INSERT INTO `weiapp_region` VALUES ('620300', '金昌市', '620000', '86.620000.620300', '中国.甘肃省.金昌市', '1');
INSERT INTO `weiapp_region` VALUES ('620400', '白银市', '620000', '86.620000.620400', '中国.甘肃省.白银市', '1');
INSERT INTO `weiapp_region` VALUES ('620500', '天水市', '620000', '86.620000.620500', '中国.甘肃省.天水市', '1');
INSERT INTO `weiapp_region` VALUES ('620600', '武威市', '620000', '86.620000.620600', '中国.甘肃省.武威市', '1');
INSERT INTO `weiapp_region` VALUES ('620700', '张掖市', '620000', '86.620000.620700', '中国.甘肃省.张掖市', '1');
INSERT INTO `weiapp_region` VALUES ('620800', '平凉市', '620000', '86.620000.620800', '中国.甘肃省.平凉市', '1');
INSERT INTO `weiapp_region` VALUES ('620900', '酒泉市', '620000', '86.620000.620900', '中国.甘肃省.酒泉市', '1');
INSERT INTO `weiapp_region` VALUES ('621000', '庆阳市', '620000', '86.620000.621000', '中国.甘肃省.庆阳市', '1');
INSERT INTO `weiapp_region` VALUES ('621100', '定西市', '620000', '86.620000.621100', '中国.甘肃省.定西市', '1');
INSERT INTO `weiapp_region` VALUES ('621200', '陇南市', '620000', '86.620000.621200', '中国.甘肃省.陇南市', '1');
INSERT INTO `weiapp_region` VALUES ('630000', '青海省', '86', '86.630000', '中国.青海省', '1');
INSERT INTO `weiapp_region` VALUES ('630100', '西宁市', '630000', '86.630000.630100', '中国.青海省.西宁市', '1');
INSERT INTO `weiapp_region` VALUES ('341181', '天长市', '341100', '86.340000.341100.341181', '中国.安徽省.滁州市.天长市', '1');
INSERT INTO `weiapp_region` VALUES ('341182', '明光市', '341100', '86.340000.341100.341182', '中国.安徽省.滁州市.明光市', '1');
INSERT INTO `weiapp_region` VALUES ('341202', '颍州区', '341200', '86.340000.341200.341202', '中国.安徽省.阜阳市.颍州区', '1');
INSERT INTO `weiapp_region` VALUES ('341203', '颍东区', '341200', '86.340000.341200.341203', '中国.安徽省.阜阳市.颍东区', '1');
INSERT INTO `weiapp_region` VALUES ('341204', '颍泉区', '341200', '86.340000.341200.341204', '中国.安徽省.阜阳市.颍泉区', '1');
INSERT INTO `weiapp_region` VALUES ('341221', '临泉县', '341200', '86.340000.341200.341221', '中国.安徽省.阜阳市.临泉县', '1');
INSERT INTO `weiapp_region` VALUES ('341222', '太和县', '341200', '86.340000.341200.341222', '中国.安徽省.阜阳市.太和县', '1');
INSERT INTO `weiapp_region` VALUES ('341225', '阜南县', '341200', '86.340000.341200.341225', '中国.安徽省.阜阳市.阜南县', '1');
INSERT INTO `weiapp_region` VALUES ('341226', '颍上县', '341200', '86.340000.341200.341226', '中国.安徽省.阜阳市.颍上县', '1');
INSERT INTO `weiapp_region` VALUES ('341282', '界首市', '341200', '86.340000.341200.341282', '中国.安徽省.阜阳市.界首市', '1');
INSERT INTO `weiapp_region` VALUES ('341302', '埇桥区', '341300', '86.340000.341300.341302', '中国.安徽省.宿州市.埇桥区', '1');
INSERT INTO `weiapp_region` VALUES ('341321', '砀山县', '341300', '86.340000.341300.341321', '中国.安徽省.宿州市.砀山县', '1');
INSERT INTO `weiapp_region` VALUES ('341322', '萧县', '341300', '86.340000.341300.341322', '中国.安徽省.宿州市.萧县', '1');
INSERT INTO `weiapp_region` VALUES ('341323', '灵璧县', '341300', '86.340000.341300.341323', '中国.安徽省.宿州市.灵璧县', '1');
INSERT INTO `weiapp_region` VALUES ('341324', '泗县', '341300', '86.340000.341300.341324', '中国.安徽省.宿州市.泗县', '1');
INSERT INTO `weiapp_region` VALUES ('341502', '金安区', '341500', '86.340000.341500.341502', '中国.安徽省.六安市.金安区', '1');
INSERT INTO `weiapp_region` VALUES ('341503', '裕安区', '341500', '86.340000.341500.341503', '中国.安徽省.六安市.裕安区', '1');
INSERT INTO `weiapp_region` VALUES ('341521', '寿县', '341500', '86.340000.341500.341521', '中国.安徽省.六安市.寿县', '1');
INSERT INTO `weiapp_region` VALUES ('341522', '霍邱县', '341500', '86.340000.341500.341522', '中国.安徽省.六安市.霍邱县', '1');
INSERT INTO `weiapp_region` VALUES ('341523', '舒城县', '341500', '86.340000.341500.341523', '中国.安徽省.六安市.舒城县', '1');
INSERT INTO `weiapp_region` VALUES ('341524', '金寨县', '341500', '86.340000.341500.341524', '中国.安徽省.六安市.金寨县', '1');
INSERT INTO `weiapp_region` VALUES ('341525', '霍山县', '341500', '86.340000.341500.341525', '中国.安徽省.六安市.霍山县', '1');
INSERT INTO `weiapp_region` VALUES ('341602', '谯城区', '341600', '86.340000.341600.341602', '中国.安徽省.亳州市.谯城区', '1');
INSERT INTO `weiapp_region` VALUES ('341621', '涡阳县', '341600', '86.340000.341600.341621', '中国.安徽省.亳州市.涡阳县', '1');
INSERT INTO `weiapp_region` VALUES ('341622', '蒙城县', '341600', '86.340000.341600.341622', '中国.安徽省.亳州市.蒙城县', '1');
INSERT INTO `weiapp_region` VALUES ('341623', '利辛县', '341600', '86.340000.341600.341623', '中国.安徽省.亳州市.利辛县', '1');
INSERT INTO `weiapp_region` VALUES ('341702', '贵池区', '341700', '86.340000.341700.341702', '中国.安徽省.池州市.贵池区', '1');
INSERT INTO `weiapp_region` VALUES ('341721', '东至县', '341700', '86.340000.341700.341721', '中国.安徽省.池州市.东至县', '1');
INSERT INTO `weiapp_region` VALUES ('341722', '石台县', '341700', '86.340000.341700.341722', '中国.安徽省.池州市.石台县', '1');
INSERT INTO `weiapp_region` VALUES ('341723', '青阳县', '341700', '86.340000.341700.341723', '中国.安徽省.池州市.青阳县', '1');
INSERT INTO `weiapp_region` VALUES ('341802', '宣州区', '341800', '86.340000.341800.341802', '中国.安徽省.宣城市.宣州区', '1');
INSERT INTO `weiapp_region` VALUES ('341821', '郎溪县', '341800', '86.340000.341800.341821', '中国.安徽省.宣城市.郎溪县', '1');
INSERT INTO `weiapp_region` VALUES ('341822', '广德县', '341800', '86.340000.341800.341822', '中国.安徽省.宣城市.广德县', '1');
INSERT INTO `weiapp_region` VALUES ('341823', '泾县', '341800', '86.340000.341800.341823', '中国.安徽省.宣城市.泾县', '1');
INSERT INTO `weiapp_region` VALUES ('341824', '绩溪县', '341800', '86.340000.341800.341824', '中国.安徽省.宣城市.绩溪县', '1');
INSERT INTO `weiapp_region` VALUES ('341825', '旌德县', '341800', '86.340000.341800.341825', '中国.安徽省.宣城市.旌德县', '1');
INSERT INTO `weiapp_region` VALUES ('341881', '宁国市', '341800', '86.340000.341800.341881', '中国.安徽省.宣城市.宁国市', '1');
INSERT INTO `weiapp_region` VALUES ('350102', '鼓楼区', '350100', '86.350000.350100.350102', '中国.福建省.福州市.鼓楼区', '1');
INSERT INTO `weiapp_region` VALUES ('350103', '台江区', '350100', '86.350000.350100.350103', '中国.福建省.福州市.台江区', '1');
INSERT INTO `weiapp_region` VALUES ('350104', '仓山区', '350100', '86.350000.350100.350104', '中国.福建省.福州市.仓山区', '1');
INSERT INTO `weiapp_region` VALUES ('350105', '马尾区', '350100', '86.350000.350100.350105', '中国.福建省.福州市.马尾区', '1');
INSERT INTO `weiapp_region` VALUES ('350111', '晋安区', '350100', '86.350000.350100.350111', '中国.福建省.福州市.晋安区', '1');
INSERT INTO `weiapp_region` VALUES ('350121', '闽侯县', '350100', '86.350000.350100.350121', '中国.福建省.福州市.闽侯县', '1');
INSERT INTO `weiapp_region` VALUES ('350122', '连江县', '350100', '86.350000.350100.350122', '中国.福建省.福州市.连江县', '1');
INSERT INTO `weiapp_region` VALUES ('350123', '罗源县', '350100', '86.350000.350100.350123', '中国.福建省.福州市.罗源县', '1');
INSERT INTO `weiapp_region` VALUES ('350124', '闽清县', '350100', '86.350000.350100.350124', '中国.福建省.福州市.闽清县', '1');
INSERT INTO `weiapp_region` VALUES ('350125', '永泰县', '350100', '86.350000.350100.350125', '中国.福建省.福州市.永泰县', '1');
INSERT INTO `weiapp_region` VALUES ('350128', '平潭县', '350100', '86.350000.350100.350128', '中国.福建省.福州市.平潭县', '1');
INSERT INTO `weiapp_region` VALUES ('350181', '福清市', '350100', '86.350000.350100.350181', '中国.福建省.福州市.福清市', '1');
INSERT INTO `weiapp_region` VALUES ('350182', '长乐市', '350100', '86.350000.350100.350182', '中国.福建省.福州市.长乐市', '1');
INSERT INTO `weiapp_region` VALUES ('350203', '思明区', '350200', '86.350000.350200.350203', '中国.福建省.厦门市.思明区', '1');
INSERT INTO `weiapp_region` VALUES ('350205', '海沧区', '350200', '86.350000.350200.350205', '中国.福建省.厦门市.海沧区', '1');
INSERT INTO `weiapp_region` VALUES ('350206', '湖里区', '350200', '86.350000.350200.350206', '中国.福建省.厦门市.湖里区', '1');
INSERT INTO `weiapp_region` VALUES ('350211', '集美区', '350200', '86.350000.350200.350211', '中国.福建省.厦门市.集美区', '1');
INSERT INTO `weiapp_region` VALUES ('350212', '同安区', '350200', '86.350000.350200.350212', '中国.福建省.厦门市.同安区', '1');
INSERT INTO `weiapp_region` VALUES ('350213', '翔安区', '350200', '86.350000.350200.350213', '中国.福建省.厦门市.翔安区', '1');
INSERT INTO `weiapp_region` VALUES ('350302', '城厢区', '350300', '86.350000.350300.350302', '中国.福建省.莆田市.城厢区', '1');
INSERT INTO `weiapp_region` VALUES ('350303', '涵江区', '350300', '86.350000.350300.350303', '中国.福建省.莆田市.涵江区', '1');
INSERT INTO `weiapp_region` VALUES ('350304', '荔城区', '350300', '86.350000.350300.350304', '中国.福建省.莆田市.荔城区', '1');
INSERT INTO `weiapp_region` VALUES ('350305', '秀屿区', '350300', '86.350000.350300.350305', '中国.福建省.莆田市.秀屿区', '1');
INSERT INTO `weiapp_region` VALUES ('350322', '仙游县', '350300', '86.350000.350300.350322', '中国.福建省.莆田市.仙游县', '1');
INSERT INTO `weiapp_region` VALUES ('350402', '梅列区', '350400', '86.350000.350400.350402', '中国.福建省.三明市.梅列区', '1');
INSERT INTO `weiapp_region` VALUES ('350403', '三元区', '350400', '86.350000.350400.350403', '中国.福建省.三明市.三元区', '1');
INSERT INTO `weiapp_region` VALUES ('350421', '明溪县', '350400', '86.350000.350400.350421', '中国.福建省.三明市.明溪县', '1');
INSERT INTO `weiapp_region` VALUES ('350423', '清流县', '350400', '86.350000.350400.350423', '中国.福建省.三明市.清流县', '1');
INSERT INTO `weiapp_region` VALUES ('350424', '宁化县', '350400', '86.350000.350400.350424', '中国.福建省.三明市.宁化县', '1');
INSERT INTO `weiapp_region` VALUES ('350425', '大田县', '350400', '86.350000.350400.350425', '中国.福建省.三明市.大田县', '1');
INSERT INTO `weiapp_region` VALUES ('350426', '尤溪县', '350400', '86.350000.350400.350426', '中国.福建省.三明市.尤溪县', '1');
INSERT INTO `weiapp_region` VALUES ('350427', '沙县', '350400', '86.350000.350400.350427', '中国.福建省.三明市.沙县', '1');
INSERT INTO `weiapp_region` VALUES ('350428', '将乐县', '350400', '86.350000.350400.350428', '中国.福建省.三明市.将乐县', '1');
INSERT INTO `weiapp_region` VALUES ('350429', '泰宁县', '350400', '86.350000.350400.350429', '中国.福建省.三明市.泰宁县', '1');
INSERT INTO `weiapp_region` VALUES ('350430', '建宁县', '350400', '86.350000.350400.350430', '中国.福建省.三明市.建宁县', '1');
INSERT INTO `weiapp_region` VALUES ('350481', '永安市', '350400', '86.350000.350400.350481', '中国.福建省.三明市.永安市', '1');
INSERT INTO `weiapp_region` VALUES ('350502', '鲤城区', '350500', '86.350000.350500.350502', '中国.福建省.泉州市.鲤城区', '1');
INSERT INTO `weiapp_region` VALUES ('350503', '丰泽区', '350500', '86.350000.350500.350503', '中国.福建省.泉州市.丰泽区', '1');
INSERT INTO `weiapp_region` VALUES ('350504', '洛江区', '350500', '86.350000.350500.350504', '中国.福建省.泉州市.洛江区', '1');
INSERT INTO `weiapp_region` VALUES ('350505', '泉港区', '350500', '86.350000.350500.350505', '中国.福建省.泉州市.泉港区', '1');
INSERT INTO `weiapp_region` VALUES ('350521', '惠安县', '350500', '86.350000.350500.350521', '中国.福建省.泉州市.惠安县', '1');
INSERT INTO `weiapp_region` VALUES ('350524', '安溪县', '350500', '86.350000.350500.350524', '中国.福建省.泉州市.安溪县', '1');
INSERT INTO `weiapp_region` VALUES ('350525', '永春县', '350500', '86.350000.350500.350525', '中国.福建省.泉州市.永春县', '1');
INSERT INTO `weiapp_region` VALUES ('350526', '德化县', '350500', '86.350000.350500.350526', '中国.福建省.泉州市.德化县', '1');
INSERT INTO `weiapp_region` VALUES ('350527', '金门县', '350500', '86.350000.350500.350527', '中国.福建省.泉州市.金门县', '1');
INSERT INTO `weiapp_region` VALUES ('350581', '石狮市', '350500', '86.350000.350500.350581', '中国.福建省.泉州市.石狮市', '1');
INSERT INTO `weiapp_region` VALUES ('350582', '晋江市', '350500', '86.350000.350500.350582', '中国.福建省.泉州市.晋江市', '1');
INSERT INTO `weiapp_region` VALUES ('350583', '南安市', '350500', '86.350000.350500.350583', '中国.福建省.泉州市.南安市', '1');
INSERT INTO `weiapp_region` VALUES ('350602', '芗城区', '350600', '86.350000.350600.350602', '中国.福建省.漳州市.芗城区', '1');
INSERT INTO `weiapp_region` VALUES ('350603', '龙文区', '350600', '86.350000.350600.350603', '中国.福建省.漳州市.龙文区', '1');
INSERT INTO `weiapp_region` VALUES ('350622', '云霄县', '350600', '86.350000.350600.350622', '中国.福建省.漳州市.云霄县', '1');
INSERT INTO `weiapp_region` VALUES ('350623', '漳浦县', '350600', '86.350000.350600.350623', '中国.福建省.漳州市.漳浦县', '1');
INSERT INTO `weiapp_region` VALUES ('350624', '诏安县', '350600', '86.350000.350600.350624', '中国.福建省.漳州市.诏安县', '1');
INSERT INTO `weiapp_region` VALUES ('350625', '长泰县', '350600', '86.350000.350600.350625', '中国.福建省.漳州市.长泰县', '1');
INSERT INTO `weiapp_region` VALUES ('350626', '东山县', '350600', '86.350000.350600.350626', '中国.福建省.漳州市.东山县', '1');
INSERT INTO `weiapp_region` VALUES ('350627', '南靖县', '350600', '86.350000.350600.350627', '中国.福建省.漳州市.南靖县', '1');
INSERT INTO `weiapp_region` VALUES ('350628', '平和县', '350600', '86.350000.350600.350628', '中国.福建省.漳州市.平和县', '1');
INSERT INTO `weiapp_region` VALUES ('350629', '华安县', '350600', '86.350000.350600.350629', '中国.福建省.漳州市.华安县', '1');
INSERT INTO `weiapp_region` VALUES ('350681', '龙海市', '350600', '86.350000.350600.350681', '中国.福建省.漳州市.龙海市', '1');
INSERT INTO `weiapp_region` VALUES ('350702', '延平区', '350700', '86.350000.350700.350702', '中国.福建省.南平市.延平区', '1');
INSERT INTO `weiapp_region` VALUES ('350721', '顺昌县', '350700', '86.350000.350700.350721', '中国.福建省.南平市.顺昌县', '1');
INSERT INTO `weiapp_region` VALUES ('350722', '浦城县', '350700', '86.350000.350700.350722', '中国.福建省.南平市.浦城县', '1');
INSERT INTO `weiapp_region` VALUES ('350723', '光泽县', '350700', '86.350000.350700.350723', '中国.福建省.南平市.光泽县', '1');
INSERT INTO `weiapp_region` VALUES ('350724', '松溪县', '350700', '86.350000.350700.350724', '中国.福建省.南平市.松溪县', '1');
INSERT INTO `weiapp_region` VALUES ('350725', '政和县', '350700', '86.350000.350700.350725', '中国.福建省.南平市.政和县', '1');
INSERT INTO `weiapp_region` VALUES ('350781', '邵武市', '350700', '86.350000.350700.350781', '中国.福建省.南平市.邵武市', '1');
INSERT INTO `weiapp_region` VALUES ('350782', '武夷山市', '350700', '86.350000.350700.350782', '中国.福建省.南平市.武夷山市', '1');
INSERT INTO `weiapp_region` VALUES ('350783', '建瓯市', '350700', '86.350000.350700.350783', '中国.福建省.南平市.建瓯市', '1');
INSERT INTO `weiapp_region` VALUES ('350784', '建阳市', '350700', '86.350000.350700.350784', '中国.福建省.南平市.建阳市', '1');
INSERT INTO `weiapp_region` VALUES ('350802', '新罗区', '350800', '86.350000.350800.350802', '中国.福建省.龙岩市.新罗区', '1');
INSERT INTO `weiapp_region` VALUES ('350821', '长汀县', '350800', '86.350000.350800.350821', '中国.福建省.龙岩市.长汀县', '1');
INSERT INTO `weiapp_region` VALUES ('350822', '永定县', '350800', '86.350000.350800.350822', '中国.福建省.龙岩市.永定县', '1');
INSERT INTO `weiapp_region` VALUES ('350823', '上杭县', '350800', '86.350000.350800.350823', '中国.福建省.龙岩市.上杭县', '1');
INSERT INTO `weiapp_region` VALUES ('350824', '武平县', '350800', '86.350000.350800.350824', '中国.福建省.龙岩市.武平县', '1');
INSERT INTO `weiapp_region` VALUES ('350825', '连城县', '350800', '86.350000.350800.350825', '中国.福建省.龙岩市.连城县', '1');
INSERT INTO `weiapp_region` VALUES ('350881', '漳平市', '350800', '86.350000.350800.350881', '中国.福建省.龙岩市.漳平市', '1');
INSERT INTO `weiapp_region` VALUES ('350902', '蕉城区', '350900', '86.350000.350900.350902', '中国.福建省.宁德市.蕉城区', '1');
INSERT INTO `weiapp_region` VALUES ('350921', '霞浦县', '350900', '86.350000.350900.350921', '中国.福建省.宁德市.霞浦县', '1');
INSERT INTO `weiapp_region` VALUES ('350922', '古田县', '350900', '86.350000.350900.350922', '中国.福建省.宁德市.古田县', '1');
INSERT INTO `weiapp_region` VALUES ('350923', '屏南县', '350900', '86.350000.350900.350923', '中国.福建省.宁德市.屏南县', '1');
INSERT INTO `weiapp_region` VALUES ('350924', '寿宁县', '350900', '86.350000.350900.350924', '中国.福建省.宁德市.寿宁县', '1');
INSERT INTO `weiapp_region` VALUES ('350925', '周宁县', '350900', '86.350000.350900.350925', '中国.福建省.宁德市.周宁县', '1');
INSERT INTO `weiapp_region` VALUES ('350926', '柘荣县', '350900', '86.350000.350900.350926', '中国.福建省.宁德市.柘荣县', '1');
INSERT INTO `weiapp_region` VALUES ('350981', '福安市', '350900', '86.350000.350900.350981', '中国.福建省.宁德市.福安市', '1');
INSERT INTO `weiapp_region` VALUES ('350982', '福鼎市', '350900', '86.350000.350900.350982', '中国.福建省.宁德市.福鼎市', '1');
INSERT INTO `weiapp_region` VALUES ('360102', '东湖区', '360100', '86.360000.360100.360102', '中国.江西省.南昌市.东湖区', '1');
INSERT INTO `weiapp_region` VALUES ('360103', '西湖区', '360100', '86.360000.360100.360103', '中国.江西省.南昌市.西湖区', '1');
INSERT INTO `weiapp_region` VALUES ('360104', '青云谱区', '360100', '86.360000.360100.360104', '中国.江西省.南昌市.青云谱区', '1');
INSERT INTO `weiapp_region` VALUES ('360105', '湾里区', '360100', '86.360000.360100.360105', '中国.江西省.南昌市.湾里区', '1');
INSERT INTO `weiapp_region` VALUES ('360111', '青山湖区', '360100', '86.360000.360100.360111', '中国.江西省.南昌市.青山湖区', '1');
INSERT INTO `weiapp_region` VALUES ('360121', '南昌县', '360100', '86.360000.360100.360121', '中国.江西省.南昌市.南昌县', '1');
INSERT INTO `weiapp_region` VALUES ('360122', '新建县', '360100', '86.360000.360100.360122', '中国.江西省.南昌市.新建县', '1');
INSERT INTO `weiapp_region` VALUES ('360123', '安义县', '360100', '86.360000.360100.360123', '中国.江西省.南昌市.安义县', '1');
INSERT INTO `weiapp_region` VALUES ('360124', '进贤县', '360100', '86.360000.360100.360124', '中国.江西省.南昌市.进贤县', '1');
INSERT INTO `weiapp_region` VALUES ('360202', '昌江区', '360200', '86.360000.360200.360202', '中国.江西省.景德镇市.昌江区', '1');
INSERT INTO `weiapp_region` VALUES ('360203', '珠山区', '360200', '86.360000.360200.360203', '中国.江西省.景德镇市.珠山区', '1');
INSERT INTO `weiapp_region` VALUES ('360222', '浮梁县', '360200', '86.360000.360200.360222', '中国.江西省.景德镇市.浮梁县', '1');
INSERT INTO `weiapp_region` VALUES ('360281', '乐平市', '360200', '86.360000.360200.360281', '中国.江西省.景德镇市.乐平市', '1');
INSERT INTO `weiapp_region` VALUES ('360302', '安源区', '360300', '86.360000.360300.360302', '中国.江西省.萍乡市.安源区', '1');
INSERT INTO `weiapp_region` VALUES ('360313', '湘东区', '360300', '86.360000.360300.360313', '中国.江西省.萍乡市.湘东区', '1');
INSERT INTO `weiapp_region` VALUES ('360321', '莲花县', '360300', '86.360000.360300.360321', '中国.江西省.萍乡市.莲花县', '1');
INSERT INTO `weiapp_region` VALUES ('360322', '上栗县', '360300', '86.360000.360300.360322', '中国.江西省.萍乡市.上栗县', '1');
INSERT INTO `weiapp_region` VALUES ('360323', '芦溪县', '360300', '86.360000.360300.360323', '中国.江西省.萍乡市.芦溪县', '1');
INSERT INTO `weiapp_region` VALUES ('360402', '庐山区', '360400', '86.360000.360400.360402', '中国.江西省.九江市.庐山区', '1');
INSERT INTO `weiapp_region` VALUES ('360403', '浔阳区', '360400', '86.360000.360400.360403', '中国.江西省.九江市.浔阳区', '1');
INSERT INTO `weiapp_region` VALUES ('360421', '九江县', '360400', '86.360000.360400.360421', '中国.江西省.九江市.九江县', '1');
INSERT INTO `weiapp_region` VALUES ('360423', '武宁县', '360400', '86.360000.360400.360423', '中国.江西省.九江市.武宁县', '1');
INSERT INTO `weiapp_region` VALUES ('360424', '修水县', '360400', '86.360000.360400.360424', '中国.江西省.九江市.修水县', '1');
INSERT INTO `weiapp_region` VALUES ('360425', '永修县', '360400', '86.360000.360400.360425', '中国.江西省.九江市.永修县', '1');
INSERT INTO `weiapp_region` VALUES ('360426', '德安县', '360400', '86.360000.360400.360426', '中国.江西省.九江市.德安县', '1');
INSERT INTO `weiapp_region` VALUES ('360427', '星子县', '360400', '86.360000.360400.360427', '中国.江西省.九江市.星子县', '1');
INSERT INTO `weiapp_region` VALUES ('360428', '都昌县', '360400', '86.360000.360400.360428', '中国.江西省.九江市.都昌县', '1');
INSERT INTO `weiapp_region` VALUES ('360429', '湖口县', '360400', '86.360000.360400.360429', '中国.江西省.九江市.湖口县', '1');
INSERT INTO `weiapp_region` VALUES ('360430', '彭泽县', '360400', '86.360000.360400.360430', '中国.江西省.九江市.彭泽县', '1');
INSERT INTO `weiapp_region` VALUES ('360481', '瑞昌市', '360400', '86.360000.360400.360481', '中国.江西省.九江市.瑞昌市', '1');
INSERT INTO `weiapp_region` VALUES ('360482', '共青城市', '360400', '86.360000.360400.360482', '中国.江西省.九江市.共青城市', '1');
INSERT INTO `weiapp_region` VALUES ('360502', '渝水区', '360500', '86.360000.360500.360502', '中国.江西省.新余市.渝水区', '1');
INSERT INTO `weiapp_region` VALUES ('360521', '分宜县', '360500', '86.360000.360500.360521', '中国.江西省.新余市.分宜县', '1');
INSERT INTO `weiapp_region` VALUES ('360602', '月湖区', '360600', '86.360000.360600.360602', '中国.江西省.鹰潭市.月湖区', '1');
INSERT INTO `weiapp_region` VALUES ('360622', '余江县', '360600', '86.360000.360600.360622', '中国.江西省.鹰潭市.余江县', '1');
INSERT INTO `weiapp_region` VALUES ('360681', '贵溪市', '360600', '86.360000.360600.360681', '中国.江西省.鹰潭市.贵溪市', '1');
INSERT INTO `weiapp_region` VALUES ('360702', '章贡区', '360700', '86.360000.360700.360702', '中国.江西省.赣州市.章贡区', '1');
INSERT INTO `weiapp_region` VALUES ('360721', '赣县', '360700', '86.360000.360700.360721', '中国.江西省.赣州市.赣县', '1');
INSERT INTO `weiapp_region` VALUES ('360722', '信丰县', '360700', '86.360000.360700.360722', '中国.江西省.赣州市.信丰县', '1');
INSERT INTO `weiapp_region` VALUES ('360723', '大余县', '360700', '86.360000.360700.360723', '中国.江西省.赣州市.大余县', '1');
INSERT INTO `weiapp_region` VALUES ('360724', '上犹县', '360700', '86.360000.360700.360724', '中国.江西省.赣州市.上犹县', '1');
INSERT INTO `weiapp_region` VALUES ('360725', '崇义县', '360700', '86.360000.360700.360725', '中国.江西省.赣州市.崇义县', '1');
INSERT INTO `weiapp_region` VALUES ('360726', '安远县', '360700', '86.360000.360700.360726', '中国.江西省.赣州市.安远县', '1');
INSERT INTO `weiapp_region` VALUES ('360727', '龙南县', '360700', '86.360000.360700.360727', '中国.江西省.赣州市.龙南县', '1');
INSERT INTO `weiapp_region` VALUES ('360728', '定南县', '360700', '86.360000.360700.360728', '中国.江西省.赣州市.定南县', '1');
INSERT INTO `weiapp_region` VALUES ('360729', '全南县', '360700', '86.360000.360700.360729', '中国.江西省.赣州市.全南县', '1');
INSERT INTO `weiapp_region` VALUES ('360730', '宁都县', '360700', '86.360000.360700.360730', '中国.江西省.赣州市.宁都县', '1');
INSERT INTO `weiapp_region` VALUES ('360731', '于都县', '360700', '86.360000.360700.360731', '中国.江西省.赣州市.于都县', '1');
INSERT INTO `weiapp_region` VALUES ('360732', '兴国县', '360700', '86.360000.360700.360732', '中国.江西省.赣州市.兴国县', '1');
INSERT INTO `weiapp_region` VALUES ('360733', '会昌县', '360700', '86.360000.360700.360733', '中国.江西省.赣州市.会昌县', '1');
INSERT INTO `weiapp_region` VALUES ('360734', '寻乌县', '360700', '86.360000.360700.360734', '中国.江西省.赣州市.寻乌县', '1');
INSERT INTO `weiapp_region` VALUES ('360735', '石城县', '360700', '86.360000.360700.360735', '中国.江西省.赣州市.石城县', '1');
INSERT INTO `weiapp_region` VALUES ('360781', '瑞金市', '360700', '86.360000.360700.360781', '中国.江西省.赣州市.瑞金市', '1');
INSERT INTO `weiapp_region` VALUES ('360782', '南康市', '360700', '86.360000.360700.360782', '中国.江西省.赣州市.南康市', '1');
INSERT INTO `weiapp_region` VALUES ('360802', '吉州区', '360800', '86.360000.360800.360802', '中国.江西省.吉安市.吉州区', '1');
INSERT INTO `weiapp_region` VALUES ('360803', '青原区', '360800', '86.360000.360800.360803', '中国.江西省.吉安市.青原区', '1');
INSERT INTO `weiapp_region` VALUES ('360821', '吉安县', '360800', '86.360000.360800.360821', '中国.江西省.吉安市.吉安县', '1');
INSERT INTO `weiapp_region` VALUES ('360822', '吉水县', '360800', '86.360000.360800.360822', '中国.江西省.吉安市.吉水县', '1');
INSERT INTO `weiapp_region` VALUES ('360823', '峡江县', '360800', '86.360000.360800.360823', '中国.江西省.吉安市.峡江县', '1');
INSERT INTO `weiapp_region` VALUES ('360824', '新干县', '360800', '86.360000.360800.360824', '中国.江西省.吉安市.新干县', '1');
INSERT INTO `weiapp_region` VALUES ('360825', '永丰县', '360800', '86.360000.360800.360825', '中国.江西省.吉安市.永丰县', '1');
INSERT INTO `weiapp_region` VALUES ('360826', '泰和县', '360800', '86.360000.360800.360826', '中国.江西省.吉安市.泰和县', '1');
INSERT INTO `weiapp_region` VALUES ('360827', '遂川县', '360800', '86.360000.360800.360827', '中国.江西省.吉安市.遂川县', '1');
INSERT INTO `weiapp_region` VALUES ('360828', '万安县', '360800', '86.360000.360800.360828', '中国.江西省.吉安市.万安县', '1');
INSERT INTO `weiapp_region` VALUES ('360829', '安福县', '360800', '86.360000.360800.360829', '中国.江西省.吉安市.安福县', '1');
INSERT INTO `weiapp_region` VALUES ('360830', '永新县', '360800', '86.360000.360800.360830', '中国.江西省.吉安市.永新县', '1');
INSERT INTO `weiapp_region` VALUES ('360881', '井冈山市', '360800', '86.360000.360800.360881', '中国.江西省.吉安市.井冈山市', '1');
INSERT INTO `weiapp_region` VALUES ('360902', '袁州区', '360900', '86.360000.360900.360902', '中国.江西省.宜春市.袁州区', '1');
INSERT INTO `weiapp_region` VALUES ('360921', '奉新县', '360900', '86.360000.360900.360921', '中国.江西省.宜春市.奉新县', '1');
INSERT INTO `weiapp_region` VALUES ('360922', '万载县', '360900', '86.360000.360900.360922', '中国.江西省.宜春市.万载县', '1');
INSERT INTO `weiapp_region` VALUES ('360923', '上高县', '360900', '86.360000.360900.360923', '中国.江西省.宜春市.上高县', '1');
INSERT INTO `weiapp_region` VALUES ('360924', '宜丰县', '360900', '86.360000.360900.360924', '中国.江西省.宜春市.宜丰县', '1');
INSERT INTO `weiapp_region` VALUES ('360925', '靖安县', '360900', '86.360000.360900.360925', '中国.江西省.宜春市.靖安县', '1');
INSERT INTO `weiapp_region` VALUES ('360926', '铜鼓县', '360900', '86.360000.360900.360926', '中国.江西省.宜春市.铜鼓县', '1');
INSERT INTO `weiapp_region` VALUES ('360981', '丰城市', '360900', '86.360000.360900.360981', '中国.江西省.宜春市.丰城市', '1');
INSERT INTO `weiapp_region` VALUES ('360982', '樟树市', '360900', '86.360000.360900.360982', '中国.江西省.宜春市.樟树市', '1');
INSERT INTO `weiapp_region` VALUES ('360983', '高安市', '360900', '86.360000.360900.360983', '中国.江西省.宜春市.高安市', '1');
INSERT INTO `weiapp_region` VALUES ('361002', '临川区', '361000', '86.360000.361000.361002', '中国.江西省.抚州市.临川区', '1');
INSERT INTO `weiapp_region` VALUES ('361021', '南城县', '361000', '86.360000.361000.361021', '中国.江西省.抚州市.南城县', '1');
INSERT INTO `weiapp_region` VALUES ('361022', '黎川县', '361000', '86.360000.361000.361022', '中国.江西省.抚州市.黎川县', '1');
INSERT INTO `weiapp_region` VALUES ('361023', '南丰县', '361000', '86.360000.361000.361023', '中国.江西省.抚州市.南丰县', '1');
INSERT INTO `weiapp_region` VALUES ('361024', '崇仁县', '361000', '86.360000.361000.361024', '中国.江西省.抚州市.崇仁县', '1');
INSERT INTO `weiapp_region` VALUES ('361025', '乐安县', '361000', '86.360000.361000.361025', '中国.江西省.抚州市.乐安县', '1');
INSERT INTO `weiapp_region` VALUES ('361026', '宜黄县', '361000', '86.360000.361000.361026', '中国.江西省.抚州市.宜黄县', '1');
INSERT INTO `weiapp_region` VALUES ('361027', '金溪县', '361000', '86.360000.361000.361027', '中国.江西省.抚州市.金溪县', '1');
INSERT INTO `weiapp_region` VALUES ('361028', '资溪县', '361000', '86.360000.361000.361028', '中国.江西省.抚州市.资溪县', '1');
INSERT INTO `weiapp_region` VALUES ('361029', '东乡县', '361000', '86.360000.361000.361029', '中国.江西省.抚州市.东乡县', '1');
INSERT INTO `weiapp_region` VALUES ('361030', '广昌县', '361000', '86.360000.361000.361030', '中国.江西省.抚州市.广昌县', '1');
INSERT INTO `weiapp_region` VALUES ('361102', '信州区', '361100', '86.360000.361100.361102', '中国.江西省.上饶市.信州区', '1');
INSERT INTO `weiapp_region` VALUES ('361121', '上饶县', '361100', '86.360000.361100.361121', '中国.江西省.上饶市.上饶县', '1');
INSERT INTO `weiapp_region` VALUES ('361122', '广丰县', '361100', '86.360000.361100.361122', '中国.江西省.上饶市.广丰县', '1');
INSERT INTO `weiapp_region` VALUES ('361123', '玉山县', '361100', '86.360000.361100.361123', '中国.江西省.上饶市.玉山县', '1');
INSERT INTO `weiapp_region` VALUES ('361124', '铅山县', '361100', '86.360000.361100.361124', '中国.江西省.上饶市.铅山县', '1');
INSERT INTO `weiapp_region` VALUES ('361125', '横峰县', '361100', '86.360000.361100.361125', '中国.江西省.上饶市.横峰县', '1');
INSERT INTO `weiapp_region` VALUES ('361126', '弋阳县', '361100', '86.360000.361100.361126', '中国.江西省.上饶市.弋阳县', '1');
INSERT INTO `weiapp_region` VALUES ('361127', '余干县', '361100', '86.360000.361100.361127', '中国.江西省.上饶市.余干县', '1');
INSERT INTO `weiapp_region` VALUES ('361128', '鄱阳县', '361100', '86.360000.361100.361128', '中国.江西省.上饶市.鄱阳县', '1');
INSERT INTO `weiapp_region` VALUES ('361129', '万年县', '361100', '86.360000.361100.361129', '中国.江西省.上饶市.万年县', '1');
INSERT INTO `weiapp_region` VALUES ('361130', '婺源县', '361100', '86.360000.361100.361130', '中国.江西省.上饶市.婺源县', '1');
INSERT INTO `weiapp_region` VALUES ('361181', '德兴市', '361100', '86.360000.361100.361181', '中国.江西省.上饶市.德兴市', '1');
INSERT INTO `weiapp_region` VALUES ('370102', '历下区', '370100', '86.370000.370100.370102', '中国.山东省.济南市.历下区', '1');
INSERT INTO `weiapp_region` VALUES ('370103', '市中区', '370100', '86.370000.370100.370103', '中国.山东省.济南市.市中区', '1');
INSERT INTO `weiapp_region` VALUES ('370104', '槐荫区', '370100', '86.370000.370100.370104', '中国.山东省.济南市.槐荫区', '1');
INSERT INTO `weiapp_region` VALUES ('370105', '天桥区', '370100', '86.370000.370100.370105', '中国.山东省.济南市.天桥区', '1');
INSERT INTO `weiapp_region` VALUES ('370112', '历城区', '370100', '86.370000.370100.370112', '中国.山东省.济南市.历城区', '1');
INSERT INTO `weiapp_region` VALUES ('370113', '长清区', '370100', '86.370000.370100.370113', '中国.山东省.济南市.长清区', '1');
INSERT INTO `weiapp_region` VALUES ('370124', '平阴县', '370100', '86.370000.370100.370124', '中国.山东省.济南市.平阴县', '1');
INSERT INTO `weiapp_region` VALUES ('370125', '济阳县', '370100', '86.370000.370100.370125', '中国.山东省.济南市.济阳县', '1');
INSERT INTO `weiapp_region` VALUES ('370126', '商河县', '370100', '86.370000.370100.370126', '中国.山东省.济南市.商河县', '1');
INSERT INTO `weiapp_region` VALUES ('370181', '章丘市', '370100', '86.370000.370100.370181', '中国.山东省.济南市.章丘市', '1');
INSERT INTO `weiapp_region` VALUES ('370202', '市南区', '370200', '86.370000.370200.370202', '中国.山东省.青岛市.市南区', '1');
INSERT INTO `weiapp_region` VALUES ('370203', '市北区', '370200', '86.370000.370200.370203', '中国.山东省.青岛市.市北区', '1');
INSERT INTO `weiapp_region` VALUES ('370205', '四方区', '370200', '86.370000.370200.370205', '中国.山东省.青岛市.四方区', '1');
INSERT INTO `weiapp_region` VALUES ('370211', '黄岛区', '370200', '86.370000.370200.370211', '中国.山东省.青岛市.黄岛区', '1');
INSERT INTO `weiapp_region` VALUES ('370212', '崂山区', '370200', '86.370000.370200.370212', '中国.山东省.青岛市.崂山区', '1');
INSERT INTO `weiapp_region` VALUES ('370213', '李沧区', '370200', '86.370000.370200.370213', '中国.山东省.青岛市.李沧区', '1');
INSERT INTO `weiapp_region` VALUES ('370214', '城阳区', '370200', '86.370000.370200.370214', '中国.山东省.青岛市.城阳区', '1');
INSERT INTO `weiapp_region` VALUES ('370281', '胶州市', '370200', '86.370000.370200.370281', '中国.山东省.青岛市.胶州市', '1');
INSERT INTO `weiapp_region` VALUES ('370282', '即墨市', '370200', '86.370000.370200.370282', '中国.山东省.青岛市.即墨市', '1');
INSERT INTO `weiapp_region` VALUES ('370283', '平度市', '370200', '86.370000.370200.370283', '中国.山东省.青岛市.平度市', '1');
INSERT INTO `weiapp_region` VALUES ('370284', '胶南市', '370200', '86.370000.370200.370284', '中国.山东省.青岛市.胶南市', '1');
INSERT INTO `weiapp_region` VALUES ('370285', '莱西市', '370200', '86.370000.370200.370285', '中国.山东省.青岛市.莱西市', '1');
INSERT INTO `weiapp_region` VALUES ('370302', '淄川区', '370300', '86.370000.370300.370302', '中国.山东省.淄博市.淄川区', '1');
INSERT INTO `weiapp_region` VALUES ('370303', '张店区', '370300', '86.370000.370300.370303', '中国.山东省.淄博市.张店区', '1');
INSERT INTO `weiapp_region` VALUES ('370304', '博山区', '370300', '86.370000.370300.370304', '中国.山东省.淄博市.博山区', '1');
INSERT INTO `weiapp_region` VALUES ('370305', '临淄区', '370300', '86.370000.370300.370305', '中国.山东省.淄博市.临淄区', '1');
INSERT INTO `weiapp_region` VALUES ('370306', '周村区', '370300', '86.370000.370300.370306', '中国.山东省.淄博市.周村区', '1');
INSERT INTO `weiapp_region` VALUES ('370321', '桓台县', '370300', '86.370000.370300.370321', '中国.山东省.淄博市.桓台县', '1');
INSERT INTO `weiapp_region` VALUES ('370322', '高青县', '370300', '86.370000.370300.370322', '中国.山东省.淄博市.高青县', '1');
INSERT INTO `weiapp_region` VALUES ('370323', '沂源县', '370300', '86.370000.370300.370323', '中国.山东省.淄博市.沂源县', '1');
INSERT INTO `weiapp_region` VALUES ('370402', '市中区', '370400', '86.370000.370400.370402', '中国.山东省.枣庄市.市中区', '1');
INSERT INTO `weiapp_region` VALUES ('370403', '薛城区', '370400', '86.370000.370400.370403', '中国.山东省.枣庄市.薛城区', '1');
INSERT INTO `weiapp_region` VALUES ('370404', '峄城区', '370400', '86.370000.370400.370404', '中国.山东省.枣庄市.峄城区', '1');
INSERT INTO `weiapp_region` VALUES ('370405', '台儿庄区', '370400', '86.370000.370400.370405', '中国.山东省.枣庄市.台儿庄区', '1');
INSERT INTO `weiapp_region` VALUES ('370406', '山亭区', '370400', '86.370000.370400.370406', '中国.山东省.枣庄市.山亭区', '1');
INSERT INTO `weiapp_region` VALUES ('370481', '滕州市', '370400', '86.370000.370400.370481', '中国.山东省.枣庄市.滕州市', '1');
INSERT INTO `weiapp_region` VALUES ('370502', '东营区', '370500', '86.370000.370500.370502', '中国.山东省.东营市.东营区', '1');
INSERT INTO `weiapp_region` VALUES ('370503', '河口区', '370500', '86.370000.370500.370503', '中国.山东省.东营市.河口区', '1');
INSERT INTO `weiapp_region` VALUES ('370521', '垦利县', '370500', '86.370000.370500.370521', '中国.山东省.东营市.垦利县', '1');
INSERT INTO `weiapp_region` VALUES ('370522', '利津县', '370500', '86.370000.370500.370522', '中国.山东省.东营市.利津县', '1');
INSERT INTO `weiapp_region` VALUES ('370523', '广饶县', '370500', '86.370000.370500.370523', '中国.山东省.东营市.广饶县', '1');
INSERT INTO `weiapp_region` VALUES ('370602', '芝罘区', '370600', '86.370000.370600.370602', '中国.山东省.烟台市.芝罘区', '1');
INSERT INTO `weiapp_region` VALUES ('370611', '福山区', '370600', '86.370000.370600.370611', '中国.山东省.烟台市.福山区', '1');
INSERT INTO `weiapp_region` VALUES ('370612', '牟平区', '370600', '86.370000.370600.370612', '中国.山东省.烟台市.牟平区', '1');
INSERT INTO `weiapp_region` VALUES ('370613', '莱山区', '370600', '86.370000.370600.370613', '中国.山东省.烟台市.莱山区', '1');
INSERT INTO `weiapp_region` VALUES ('370634', '长岛县', '370600', '86.370000.370600.370634', '中国.山东省.烟台市.长岛县', '1');
INSERT INTO `weiapp_region` VALUES ('370681', '龙口市', '370600', '86.370000.370600.370681', '中国.山东省.烟台市.龙口市', '1');
INSERT INTO `weiapp_region` VALUES ('370682', '莱阳市', '370600', '86.370000.370600.370682', '中国.山东省.烟台市.莱阳市', '1');
INSERT INTO `weiapp_region` VALUES ('370683', '莱州市', '370600', '86.370000.370600.370683', '中国.山东省.烟台市.莱州市', '1');
INSERT INTO `weiapp_region` VALUES ('370684', '蓬莱市', '370600', '86.370000.370600.370684', '中国.山东省.烟台市.蓬莱市', '1');
INSERT INTO `weiapp_region` VALUES ('370685', '招远市', '370600', '86.370000.370600.370685', '中国.山东省.烟台市.招远市', '1');
INSERT INTO `weiapp_region` VALUES ('370686', '栖霞市', '370600', '86.370000.370600.370686', '中国.山东省.烟台市.栖霞市', '1');
INSERT INTO `weiapp_region` VALUES ('370687', '海阳市', '370600', '86.370000.370600.370687', '中国.山东省.烟台市.海阳市', '1');
INSERT INTO `weiapp_region` VALUES ('370702', '潍城区', '370700', '86.370000.370700.370702', '中国.山东省.潍坊市.潍城区', '1');
INSERT INTO `weiapp_region` VALUES ('370703', '寒亭区', '370700', '86.370000.370700.370703', '中国.山东省.潍坊市.寒亭区', '1');
INSERT INTO `weiapp_region` VALUES ('370704', '坊子区', '370700', '86.370000.370700.370704', '中国.山东省.潍坊市.坊子区', '1');
INSERT INTO `weiapp_region` VALUES ('370705', '奎文区', '370700', '86.370000.370700.370705', '中国.山东省.潍坊市.奎文区', '1');
INSERT INTO `weiapp_region` VALUES ('370724', '临朐县', '370700', '86.370000.370700.370724', '中国.山东省.潍坊市.临朐县', '1');
INSERT INTO `weiapp_region` VALUES ('370725', '昌乐县', '370700', '86.370000.370700.370725', '中国.山东省.潍坊市.昌乐县', '1');
INSERT INTO `weiapp_region` VALUES ('370781', '青州市', '370700', '86.370000.370700.370781', '中国.山东省.潍坊市.青州市', '1');
INSERT INTO `weiapp_region` VALUES ('370782', '诸城市', '370700', '86.370000.370700.370782', '中国.山东省.潍坊市.诸城市', '1');
INSERT INTO `weiapp_region` VALUES ('370783', '寿光市', '370700', '86.370000.370700.370783', '中国.山东省.潍坊市.寿光市', '1');
INSERT INTO `weiapp_region` VALUES ('370784', '安丘市', '370700', '86.370000.370700.370784', '中国.山东省.潍坊市.安丘市', '1');
INSERT INTO `weiapp_region` VALUES ('370785', '高密市', '370700', '86.370000.370700.370785', '中国.山东省.潍坊市.高密市', '1');
INSERT INTO `weiapp_region` VALUES ('370786', '昌邑市', '370700', '86.370000.370700.370786', '中国.山东省.潍坊市.昌邑市', '1');
INSERT INTO `weiapp_region` VALUES ('370802', '市中区', '370800', '86.370000.370800.370802', '中国.山东省.济宁市.市中区', '1');
INSERT INTO `weiapp_region` VALUES ('370811', '任城区', '370800', '86.370000.370800.370811', '中国.山东省.济宁市.任城区', '1');
INSERT INTO `weiapp_region` VALUES ('370826', '微山县', '370800', '86.370000.370800.370826', '中国.山东省.济宁市.微山县', '1');
INSERT INTO `weiapp_region` VALUES ('370827', '鱼台县', '370800', '86.370000.370800.370827', '中国.山东省.济宁市.鱼台县', '1');
INSERT INTO `weiapp_region` VALUES ('370828', '金乡县', '370800', '86.370000.370800.370828', '中国.山东省.济宁市.金乡县', '1');
INSERT INTO `weiapp_region` VALUES ('370829', '嘉祥县', '370800', '86.370000.370800.370829', '中国.山东省.济宁市.嘉祥县', '1');
INSERT INTO `weiapp_region` VALUES ('370830', '汶上县', '370800', '86.370000.370800.370830', '中国.山东省.济宁市.汶上县', '1');
INSERT INTO `weiapp_region` VALUES ('370831', '泗水县', '370800', '86.370000.370800.370831', '中国.山东省.济宁市.泗水县', '1');
INSERT INTO `weiapp_region` VALUES ('370832', '梁山县', '370800', '86.370000.370800.370832', '中国.山东省.济宁市.梁山县', '1');
INSERT INTO `weiapp_region` VALUES ('370881', '曲阜市', '370800', '86.370000.370800.370881', '中国.山东省.济宁市.曲阜市', '1');
INSERT INTO `weiapp_region` VALUES ('370882', '兖州市', '370800', '86.370000.370800.370882', '中国.山东省.济宁市.兖州市', '1');
INSERT INTO `weiapp_region` VALUES ('370883', '邹城市', '370800', '86.370000.370800.370883', '中国.山东省.济宁市.邹城市', '1');
INSERT INTO `weiapp_region` VALUES ('370982', '新泰市', '370900', '86.370000.370900.370982', '中国.山东省.泰安市.新泰市', '1');
INSERT INTO `weiapp_region` VALUES ('370983', '肥城市', '370900', '86.370000.370900.370983', '中国.山东省.泰安市.肥城市', '1');
INSERT INTO `weiapp_region` VALUES ('371002', '环翠区', '371000', '86.370000.371000.371002', '中国.山东省.威海市.环翠区', '1');
INSERT INTO `weiapp_region` VALUES ('371081', '文登市', '371000', '86.370000.371000.371081', '中国.山东省.威海市.文登市', '1');
INSERT INTO `weiapp_region` VALUES ('371082', '荣成市', '371000', '86.370000.371000.371082', '中国.山东省.威海市.荣成市', '1');
INSERT INTO `weiapp_region` VALUES ('371083', '乳山市', '371000', '86.370000.371000.371083', '中国.山东省.威海市.乳山市', '1');
INSERT INTO `weiapp_region` VALUES ('371102', '东港区', '371100', '86.370000.371100.371102', '中国.山东省.日照市.东港区', '1');
INSERT INTO `weiapp_region` VALUES ('371103', '岚山区', '371100', '86.370000.371100.371103', '中国.山东省.日照市.岚山区', '1');
INSERT INTO `weiapp_region` VALUES ('371121', '五莲县', '371100', '86.370000.371100.371121', '中国.山东省.日照市.五莲县', '1');
INSERT INTO `weiapp_region` VALUES ('371122', '莒县', '371100', '86.370000.371100.371122', '中国.山东省.日照市.莒县', '1');
INSERT INTO `weiapp_region` VALUES ('371202', '莱城区', '371200', '86.370000.371200.371202', '中国.山东省.莱芜市.莱城区', '1');
INSERT INTO `weiapp_region` VALUES ('371203', '钢城区', '371200', '86.370000.371200.371203', '中国.山东省.莱芜市.钢城区', '1');
INSERT INTO `weiapp_region` VALUES ('371302', '兰山区', '371300', '86.370000.371300.371302', '中国.山东省.临沂市.兰山区', '1');
INSERT INTO `weiapp_region` VALUES ('371311', '罗庄区', '371300', '86.370000.371300.371311', '中国.山东省.临沂市.罗庄区', '1');
INSERT INTO `weiapp_region` VALUES ('371312', '河东区', '371300', '86.370000.371300.371312', '中国.山东省.临沂市.河东区', '1');
INSERT INTO `weiapp_region` VALUES ('371321', '沂南县', '371300', '86.370000.371300.371321', '中国.山东省.临沂市.沂南县', '1');
INSERT INTO `weiapp_region` VALUES ('371322', '郯城县', '371300', '86.370000.371300.371322', '中国.山东省.临沂市.郯城县', '1');
INSERT INTO `weiapp_region` VALUES ('371323', '沂水县', '371300', '86.370000.371300.371323', '中国.山东省.临沂市.沂水县', '1');
INSERT INTO `weiapp_region` VALUES ('371324', '苍山县', '371300', '86.370000.371300.371324', '中国.山东省.临沂市.苍山县', '1');
INSERT INTO `weiapp_region` VALUES ('371325', '费县', '371300', '86.370000.371300.371325', '中国.山东省.临沂市.费县', '1');
INSERT INTO `weiapp_region` VALUES ('371326', '平邑县', '371300', '86.370000.371300.371326', '中国.山东省.临沂市.平邑县', '1');
INSERT INTO `weiapp_region` VALUES ('371327', '莒南县', '371300', '86.370000.371300.371327', '中国.山东省.临沂市.莒南县', '1');
INSERT INTO `weiapp_region` VALUES ('371328', '蒙阴县', '371300', '86.370000.371300.371328', '中国.山东省.临沂市.蒙阴县', '1');
INSERT INTO `weiapp_region` VALUES ('371329', '临沭县', '371300', '86.370000.371300.371329', '中国.山东省.临沂市.临沭县', '1');
INSERT INTO `weiapp_region` VALUES ('371402', '德城区', '371400', '86.370000.371400.371402', '中国.山东省.德州市.德城区', '1');
INSERT INTO `weiapp_region` VALUES ('371421', '陵县', '371400', '86.370000.371400.371421', '中国.山东省.德州市.陵县', '1');
INSERT INTO `weiapp_region` VALUES ('371422', '宁津县', '371400', '86.370000.371400.371422', '中国.山东省.德州市.宁津县', '1');
INSERT INTO `weiapp_region` VALUES ('371423', '庆云县', '371400', '86.370000.371400.371423', '中国.山东省.德州市.庆云县', '1');
INSERT INTO `weiapp_region` VALUES ('371424', '临邑县', '371400', '86.370000.371400.371424', '中国.山东省.德州市.临邑县', '1');
INSERT INTO `weiapp_region` VALUES ('371425', '齐河县', '371400', '86.370000.371400.371425', '中国.山东省.德州市.齐河县', '1');
INSERT INTO `weiapp_region` VALUES ('371426', '平原县', '371400', '86.370000.371400.371426', '中国.山东省.德州市.平原县', '1');
INSERT INTO `weiapp_region` VALUES ('371427', '夏津县', '371400', '86.370000.371400.371427', '中国.山东省.德州市.夏津县', '1');
INSERT INTO `weiapp_region` VALUES ('371428', '武城县', '371400', '86.370000.371400.371428', '中国.山东省.德州市.武城县', '1');
INSERT INTO `weiapp_region` VALUES ('371481', '乐陵市', '371400', '86.370000.371400.371481', '中国.山东省.德州市.乐陵市', '1');
INSERT INTO `weiapp_region` VALUES ('371482', '禹城市', '371400', '86.370000.371400.371482', '中国.山东省.德州市.禹城市', '1');
INSERT INTO `weiapp_region` VALUES ('371502', '东昌府区', '371500', '86.370000.371500.371502', '中国.山东省.聊城市.东昌府区', '1');
INSERT INTO `weiapp_region` VALUES ('371521', '阳谷县', '371500', '86.370000.371500.371521', '中国.山东省.聊城市.阳谷县', '1');
INSERT INTO `weiapp_region` VALUES ('371522', '莘县', '371500', '86.370000.371500.371522', '中国.山东省.聊城市.莘县', '1');
INSERT INTO `weiapp_region` VALUES ('371523', '茌平县', '371500', '86.370000.371500.371523', '中国.山东省.聊城市.茌平县', '1');
INSERT INTO `weiapp_region` VALUES ('371524', '东阿县', '371500', '86.370000.371500.371524', '中国.山东省.聊城市.东阿县', '1');
INSERT INTO `weiapp_region` VALUES ('371525', '冠县', '371500', '86.370000.371500.371525', '中国.山东省.聊城市.冠县', '1');
INSERT INTO `weiapp_region` VALUES ('371526', '高唐县', '371500', '86.370000.371500.371526', '中国.山东省.聊城市.高唐县', '1');
INSERT INTO `weiapp_region` VALUES ('371581', '临清市', '371500', '86.370000.371500.371581', '中国.山东省.聊城市.临清市', '1');
INSERT INTO `weiapp_region` VALUES ('371602', '滨城区', '371600', '86.370000.371600.371602', '中国.山东省.滨州市.滨城区', '1');
INSERT INTO `weiapp_region` VALUES ('371621', '惠民县', '371600', '86.370000.371600.371621', '中国.山东省.滨州市.惠民县', '1');
INSERT INTO `weiapp_region` VALUES ('371622', '阳信县', '371600', '86.370000.371600.371622', '中国.山东省.滨州市.阳信县', '1');
INSERT INTO `weiapp_region` VALUES ('371623', '无棣县', '371600', '86.370000.371600.371623', '中国.山东省.滨州市.无棣县', '1');
INSERT INTO `weiapp_region` VALUES ('371624', '沾化县', '371600', '86.370000.371600.371624', '中国.山东省.滨州市.沾化县', '1');
INSERT INTO `weiapp_region` VALUES ('371625', '博兴县', '371600', '86.370000.371600.371625', '中国.山东省.滨州市.博兴县', '1');
INSERT INTO `weiapp_region` VALUES ('371626', '邹平县', '371600', '86.370000.371600.371626', '中国.山东省.滨州市.邹平县', '1');
INSERT INTO `weiapp_region` VALUES ('371702', '牡丹区', '371700', '86.370000.371700.371702', '中国.山东省.菏泽市.牡丹区', '1');
INSERT INTO `weiapp_region` VALUES ('371721', '曹县', '371700', '86.370000.371700.371721', '中国.山东省.菏泽市.曹县', '1');
INSERT INTO `weiapp_region` VALUES ('371722', '单县', '371700', '86.370000.371700.371722', '中国.山东省.菏泽市.单县', '1');
INSERT INTO `weiapp_region` VALUES ('371723', '成武县', '371700', '86.370000.371700.371723', '中国.山东省.菏泽市.成武县', '1');
INSERT INTO `weiapp_region` VALUES ('371724', '巨野县', '371700', '86.370000.371700.371724', '中国.山东省.菏泽市.巨野县', '1');
INSERT INTO `weiapp_region` VALUES ('371725', '郓城县', '371700', '86.370000.371700.371725', '中国.山东省.菏泽市.郓城县', '1');
INSERT INTO `weiapp_region` VALUES ('371726', '鄄城县', '371700', '86.370000.371700.371726', '中国.山东省.菏泽市.鄄城县', '1');
INSERT INTO `weiapp_region` VALUES ('371727', '定陶县', '371700', '86.370000.371700.371727', '中国.山东省.菏泽市.定陶县', '1');
INSERT INTO `weiapp_region` VALUES ('371728', '东明县', '371700', '86.370000.371700.371728', '中国.山东省.菏泽市.东明县', '1');
INSERT INTO `weiapp_region` VALUES ('410102', '中原区', '410100', '86.410000.410100.410102', '中国.河南省.郑州市.中原区', '1');
INSERT INTO `weiapp_region` VALUES ('410103', '二七区', '410100', '86.410000.410100.410103', '中国.河南省.郑州市.二七区', '1');
INSERT INTO `weiapp_region` VALUES ('410104', '管城回族区', '410100', '86.410000.410100.410104', '中国.河南省.郑州市.管城回族区', '1');
INSERT INTO `weiapp_region` VALUES ('410105', '金水区', '410100', '86.410000.410100.410105', '中国.河南省.郑州市.金水区', '1');
INSERT INTO `weiapp_region` VALUES ('410106', '上街区', '410100', '86.410000.410100.410106', '中国.河南省.郑州市.上街区', '1');
INSERT INTO `weiapp_region` VALUES ('410108', '惠济区', '410100', '86.410000.410100.410108', '中国.河南省.郑州市.惠济区', '1');
INSERT INTO `weiapp_region` VALUES ('410122', '中牟县', '410100', '86.410000.410100.410122', '中国.河南省.郑州市.中牟县', '1');
INSERT INTO `weiapp_region` VALUES ('410181', '巩义市', '410100', '86.410000.410100.410181', '中国.河南省.郑州市.巩义市', '1');
INSERT INTO `weiapp_region` VALUES ('410182', '荥阳市', '410100', '86.410000.410100.410182', '中国.河南省.郑州市.荥阳市', '1');
INSERT INTO `weiapp_region` VALUES ('410183', '新密市', '410100', '86.410000.410100.410183', '中国.河南省.郑州市.新密市', '1');
INSERT INTO `weiapp_region` VALUES ('410184', '新郑市', '410100', '86.410000.410100.410184', '中国.河南省.郑州市.新郑市', '1');
INSERT INTO `weiapp_region` VALUES ('410185', '登封市', '410100', '86.410000.410100.410185', '中国.河南省.郑州市.登封市', '1');
INSERT INTO `weiapp_region` VALUES ('410202', '龙亭区', '410200', '86.410000.410200.410202', '中国.河南省.开封市.龙亭区', '1');
INSERT INTO `weiapp_region` VALUES ('410203', '顺河回族区', '410200', '86.410000.410200.410203', '中国.河南省.开封市.顺河回族区', '1');
INSERT INTO `weiapp_region` VALUES ('410204', '鼓楼区', '410200', '86.410000.410200.410204', '中国.河南省.开封市.鼓楼区', '1');
INSERT INTO `weiapp_region` VALUES ('410205', '禹王台区', '410200', '86.410000.410200.410205', '中国.河南省.开封市.禹王台区', '1');
INSERT INTO `weiapp_region` VALUES ('410211', '金明区', '410200', '86.410000.410200.410211', '中国.河南省.开封市.金明区', '1');
INSERT INTO `weiapp_region` VALUES ('410221', '杞县', '410200', '86.410000.410200.410221', '中国.河南省.开封市.杞县', '1');
INSERT INTO `weiapp_region` VALUES ('410222', '通许县', '410200', '86.410000.410200.410222', '中国.河南省.开封市.通许县', '1');
INSERT INTO `weiapp_region` VALUES ('410223', '尉氏县', '410200', '86.410000.410200.410223', '中国.河南省.开封市.尉氏县', '1');
INSERT INTO `weiapp_region` VALUES ('410224', '开封县', '410200', '86.410000.410200.410224', '中国.河南省.开封市.开封县', '1');
INSERT INTO `weiapp_region` VALUES ('410225', '兰考县', '410200', '86.410000.410200.410225', '中国.河南省.开封市.兰考县', '1');
INSERT INTO `weiapp_region` VALUES ('410302', '老城区', '410300', '86.410000.410300.410302', '中国.河南省.洛阳市.老城区', '1');
INSERT INTO `weiapp_region` VALUES ('410303', '西工区', '410300', '86.410000.410300.410303', '中国.河南省.洛阳市.西工区', '1');
INSERT INTO `weiapp_region` VALUES ('410304', '瀍河回族区', '410300', '86.410000.410300.410304', '中国.河南省.洛阳市.瀍河回族区', '1');
INSERT INTO `weiapp_region` VALUES ('410305', '涧西区', '410300', '86.410000.410300.410305', '中国.河南省.洛阳市.涧西区', '1');
INSERT INTO `weiapp_region` VALUES ('410306', '吉利区', '410300', '86.410000.410300.410306', '中国.河南省.洛阳市.吉利区', '1');
INSERT INTO `weiapp_region` VALUES ('410311', '洛龙区', '410300', '86.410000.410300.410311', '中国.河南省.洛阳市.洛龙区', '1');
INSERT INTO `weiapp_region` VALUES ('410322', '孟津县', '410300', '86.410000.410300.410322', '中国.河南省.洛阳市.孟津县', '1');
INSERT INTO `weiapp_region` VALUES ('410323', '新安县', '410300', '86.410000.410300.410323', '中国.河南省.洛阳市.新安县', '1');
INSERT INTO `weiapp_region` VALUES ('410324', '栾川县', '410300', '86.410000.410300.410324', '中国.河南省.洛阳市.栾川县', '1');
INSERT INTO `weiapp_region` VALUES ('410325', '嵩县', '410300', '86.410000.410300.410325', '中国.河南省.洛阳市.嵩县', '1');
INSERT INTO `weiapp_region` VALUES ('410326', '汝阳县', '410300', '86.410000.410300.410326', '中国.河南省.洛阳市.汝阳县', '1');
INSERT INTO `weiapp_region` VALUES ('410327', '宜阳县', '410300', '86.410000.410300.410327', '中国.河南省.洛阳市.宜阳县', '1');
INSERT INTO `weiapp_region` VALUES ('410328', '洛宁县', '410300', '86.410000.410300.410328', '中国.河南省.洛阳市.洛宁县', '1');
INSERT INTO `weiapp_region` VALUES ('410329', '伊川县', '410300', '86.410000.410300.410329', '中国.河南省.洛阳市.伊川县', '1');
INSERT INTO `weiapp_region` VALUES ('410381', '偃师市', '410300', '86.410000.410300.410381', '中国.河南省.洛阳市.偃师市', '1');
INSERT INTO `weiapp_region` VALUES ('410402', '新华区', '410400', '86.410000.410400.410402', '中国.河南省.平顶山市.新华区', '1');
INSERT INTO `weiapp_region` VALUES ('410403', '卫东区', '410400', '86.410000.410400.410403', '中国.河南省.平顶山市.卫东区', '1');
INSERT INTO `weiapp_region` VALUES ('410404', '石龙区', '410400', '86.410000.410400.410404', '中国.河南省.平顶山市.石龙区', '1');
INSERT INTO `weiapp_region` VALUES ('410411', '湛河区', '410400', '86.410000.410400.410411', '中国.河南省.平顶山市.湛河区', '1');
INSERT INTO `weiapp_region` VALUES ('410421', '宝丰县', '410400', '86.410000.410400.410421', '中国.河南省.平顶山市.宝丰县', '1');
INSERT INTO `weiapp_region` VALUES ('410422', '叶县', '410400', '86.410000.410400.410422', '中国.河南省.平顶山市.叶县', '1');
INSERT INTO `weiapp_region` VALUES ('410423', '鲁山县', '410400', '86.410000.410400.410423', '中国.河南省.平顶山市.鲁山县', '1');
INSERT INTO `weiapp_region` VALUES ('410425', '郏县', '410400', '86.410000.410400.410425', '中国.河南省.平顶山市.郏县', '1');
INSERT INTO `weiapp_region` VALUES ('410481', '舞钢市', '410400', '86.410000.410400.410481', '中国.河南省.平顶山市.舞钢市', '1');
INSERT INTO `weiapp_region` VALUES ('410482', '汝州市', '410400', '86.410000.410400.410482', '中国.河南省.平顶山市.汝州市', '1');
INSERT INTO `weiapp_region` VALUES ('410502', '文峰区', '410500', '86.410000.410500.410502', '中国.河南省.安阳市.文峰区', '1');
INSERT INTO `weiapp_region` VALUES ('410503', '北关区', '410500', '86.410000.410500.410503', '中国.河南省.安阳市.北关区', '1');
INSERT INTO `weiapp_region` VALUES ('410505', '殷都区', '410500', '86.410000.410500.410505', '中国.河南省.安阳市.殷都区', '1');
INSERT INTO `weiapp_region` VALUES ('410506', '龙安区', '410500', '86.410000.410500.410506', '中国.河南省.安阳市.龙安区', '1');
INSERT INTO `weiapp_region` VALUES ('410522', '安阳县', '410500', '86.410000.410500.410522', '中国.河南省.安阳市.安阳县', '1');
INSERT INTO `weiapp_region` VALUES ('410523', '汤阴县', '410500', '86.410000.410500.410523', '中国.河南省.安阳市.汤阴县', '1');
INSERT INTO `weiapp_region` VALUES ('410526', '滑县', '410500', '86.410000.410500.410526', '中国.河南省.安阳市.滑县', '1');
INSERT INTO `weiapp_region` VALUES ('410527', '内黄县', '410500', '86.410000.410500.410527', '中国.河南省.安阳市.内黄县', '1');
INSERT INTO `weiapp_region` VALUES ('410581', '林州市', '410500', '86.410000.410500.410581', '中国.河南省.安阳市.林州市', '1');
INSERT INTO `weiapp_region` VALUES ('410602', '鹤山区', '410600', '86.410000.410600.410602', '中国.河南省.鹤壁市.鹤山区', '1');
INSERT INTO `weiapp_region` VALUES ('410603', '山城区', '410600', '86.410000.410600.410603', '中国.河南省.鹤壁市.山城区', '1');
INSERT INTO `weiapp_region` VALUES ('410611', '淇滨区', '410600', '86.410000.410600.410611', '中国.河南省.鹤壁市.淇滨区', '1');
INSERT INTO `weiapp_region` VALUES ('410621', '浚县', '410600', '86.410000.410600.410621', '中国.河南省.鹤壁市.浚县', '1');
INSERT INTO `weiapp_region` VALUES ('410622', '淇县', '410600', '86.410000.410600.410622', '中国.河南省.鹤壁市.淇县', '1');
INSERT INTO `weiapp_region` VALUES ('410702', '红旗区', '410700', '86.410000.410700.410702', '中国.河南省.新乡市.红旗区', '1');
INSERT INTO `weiapp_region` VALUES ('410703', '卫滨区', '410700', '86.410000.410700.410703', '中国.河南省.新乡市.卫滨区', '1');
INSERT INTO `weiapp_region` VALUES ('410704', '凤泉区', '410700', '86.410000.410700.410704', '中国.河南省.新乡市.凤泉区', '1');
INSERT INTO `weiapp_region` VALUES ('410711', '牧野区', '410700', '86.410000.410700.410711', '中国.河南省.新乡市.牧野区', '1');
INSERT INTO `weiapp_region` VALUES ('410721', '新乡县', '410700', '86.410000.410700.410721', '中国.河南省.新乡市.新乡县', '1');
INSERT INTO `weiapp_region` VALUES ('410724', '获嘉县', '410700', '86.410000.410700.410724', '中国.河南省.新乡市.获嘉县', '1');
INSERT INTO `weiapp_region` VALUES ('410725', '原阳县', '410700', '86.410000.410700.410725', '中国.河南省.新乡市.原阳县', '1');
INSERT INTO `weiapp_region` VALUES ('410726', '延津县', '410700', '86.410000.410700.410726', '中国.河南省.新乡市.延津县', '1');
INSERT INTO `weiapp_region` VALUES ('410727', '封丘县', '410700', '86.410000.410700.410727', '中国.河南省.新乡市.封丘县', '1');
INSERT INTO `weiapp_region` VALUES ('410728', '长垣县', '410700', '86.410000.410700.410728', '中国.河南省.新乡市.长垣县', '1');
INSERT INTO `weiapp_region` VALUES ('410781', '卫辉市', '410700', '86.410000.410700.410781', '中国.河南省.新乡市.卫辉市', '1');
INSERT INTO `weiapp_region` VALUES ('410782', '辉县市', '410700', '86.410000.410700.410782', '中国.河南省.新乡市.辉县市', '1');
INSERT INTO `weiapp_region` VALUES ('410802', '解放区', '410800', '86.410000.410800.410802', '中国.河南省.焦作市.解放区', '1');
INSERT INTO `weiapp_region` VALUES ('410803', '中站区', '410800', '86.410000.410800.410803', '中国.河南省.焦作市.中站区', '1');
INSERT INTO `weiapp_region` VALUES ('410804', '马村区', '410800', '86.410000.410800.410804', '中国.河南省.焦作市.马村区', '1');
INSERT INTO `weiapp_region` VALUES ('410811', '山阳区', '410800', '86.410000.410800.410811', '中国.河南省.焦作市.山阳区', '1');
INSERT INTO `weiapp_region` VALUES ('410821', '修武县', '410800', '86.410000.410800.410821', '中国.河南省.焦作市.修武县', '1');
INSERT INTO `weiapp_region` VALUES ('410822', '博爱县', '410800', '86.410000.410800.410822', '中国.河南省.焦作市.博爱县', '1');
INSERT INTO `weiapp_region` VALUES ('410823', '武陟县', '410800', '86.410000.410800.410823', '中国.河南省.焦作市.武陟县', '1');
INSERT INTO `weiapp_region` VALUES ('410825', '温县', '410800', '86.410000.410800.410825', '中国.河南省.焦作市.温县', '1');
INSERT INTO `weiapp_region` VALUES ('410882', '沁阳市', '410800', '86.410000.410800.410882', '中国.河南省.焦作市.沁阳市', '1');
INSERT INTO `weiapp_region` VALUES ('410883', '孟州市', '410800', '86.410000.410800.410883', '中国.河南省.焦作市.孟州市', '1');
INSERT INTO `weiapp_region` VALUES ('410902', '华龙区', '410900', '86.410000.410900.410902', '中国.河南省.濮阳市.华龙区', '1');
INSERT INTO `weiapp_region` VALUES ('410922', '清丰县', '410900', '86.410000.410900.410922', '中国.河南省.濮阳市.清丰县', '1');
INSERT INTO `weiapp_region` VALUES ('410923', '南乐县', '410900', '86.410000.410900.410923', '中国.河南省.濮阳市.南乐县', '1');
INSERT INTO `weiapp_region` VALUES ('410926', '范县', '410900', '86.410000.410900.410926', '中国.河南省.濮阳市.范县', '1');
INSERT INTO `weiapp_region` VALUES ('410927', '台前县', '410900', '86.410000.410900.410927', '中国.河南省.濮阳市.台前县', '1');
INSERT INTO `weiapp_region` VALUES ('410928', '濮阳县', '410900', '86.410000.410900.410928', '中国.河南省.濮阳市.濮阳县', '1');
INSERT INTO `weiapp_region` VALUES ('411002', '魏都区', '411000', '86.410000.411000.411002', '中国.河南省.许昌市.魏都区', '1');
INSERT INTO `weiapp_region` VALUES ('411023', '许昌县', '411000', '86.410000.411000.411023', '中国.河南省.许昌市.许昌县', '1');
INSERT INTO `weiapp_region` VALUES ('411024', '鄢陵县', '411000', '86.410000.411000.411024', '中国.河南省.许昌市.鄢陵县', '1');
INSERT INTO `weiapp_region` VALUES ('411025', '襄城县', '411000', '86.410000.411000.411025', '中国.河南省.许昌市.襄城县', '1');
INSERT INTO `weiapp_region` VALUES ('411081', '禹州市', '411000', '86.410000.411000.411081', '中国.河南省.许昌市.禹州市', '1');
INSERT INTO `weiapp_region` VALUES ('411082', '长葛市', '411000', '86.410000.411000.411082', '中国.河南省.许昌市.长葛市', '1');
INSERT INTO `weiapp_region` VALUES ('411102', '源汇区', '411100', '86.410000.411100.411102', '中国.河南省.漯河市.源汇区', '1');
INSERT INTO `weiapp_region` VALUES ('411103', '郾城区', '411100', '86.410000.411100.411103', '中国.河南省.漯河市.郾城区', '1');
INSERT INTO `weiapp_region` VALUES ('411104', '召陵区', '411100', '86.410000.411100.411104', '中国.河南省.漯河市.召陵区', '1');
INSERT INTO `weiapp_region` VALUES ('411121', '舞阳县', '411100', '86.410000.411100.411121', '中国.河南省.漯河市.舞阳县', '1');
INSERT INTO `weiapp_region` VALUES ('411122', '临颍县', '411100', '86.410000.411100.411122', '中国.河南省.漯河市.临颍县', '1');
INSERT INTO `weiapp_region` VALUES ('411202', '湖滨区', '411200', '86.410000.411200.411202', '中国.河南省.三门峡市.湖滨区', '1');
INSERT INTO `weiapp_region` VALUES ('411221', '渑池县', '411200', '86.410000.411200.411221', '中国.河南省.三门峡市.渑池县', '1');
INSERT INTO `weiapp_region` VALUES ('411222', '陕县', '411200', '86.410000.411200.411222', '中国.河南省.三门峡市.陕县', '1');
INSERT INTO `weiapp_region` VALUES ('411224', '卢氏县', '411200', '86.410000.411200.411224', '中国.河南省.三门峡市.卢氏县', '1');
INSERT INTO `weiapp_region` VALUES ('411281', '义马市', '411200', '86.410000.411200.411281', '中国.河南省.三门峡市.义马市', '1');
INSERT INTO `weiapp_region` VALUES ('411282', '灵宝市', '411200', '86.410000.411200.411282', '中国.河南省.三门峡市.灵宝市', '1');
INSERT INTO `weiapp_region` VALUES ('411302', '宛城区', '411300', '86.410000.411300.411302', '中国.河南省.南阳市.宛城区', '1');
INSERT INTO `weiapp_region` VALUES ('411303', '卧龙区', '411300', '86.410000.411300.411303', '中国.河南省.南阳市.卧龙区', '1');
INSERT INTO `weiapp_region` VALUES ('411321', '南召县', '411300', '86.410000.411300.411321', '中国.河南省.南阳市.南召县', '1');
INSERT INTO `weiapp_region` VALUES ('411322', '方城县', '411300', '86.410000.411300.411322', '中国.河南省.南阳市.方城县', '1');
INSERT INTO `weiapp_region` VALUES ('411323', '西峡县', '411300', '86.410000.411300.411323', '中国.河南省.南阳市.西峡县', '1');
INSERT INTO `weiapp_region` VALUES ('411324', '镇平县', '411300', '86.410000.411300.411324', '中国.河南省.南阳市.镇平县', '1');
INSERT INTO `weiapp_region` VALUES ('411325', '内乡县', '411300', '86.410000.411300.411325', '中国.河南省.南阳市.内乡县', '1');
INSERT INTO `weiapp_region` VALUES ('411326', '淅川县', '411300', '86.410000.411300.411326', '中国.河南省.南阳市.淅川县', '1');
INSERT INTO `weiapp_region` VALUES ('411327', '社旗县', '411300', '86.410000.411300.411327', '中国.河南省.南阳市.社旗县', '1');
INSERT INTO `weiapp_region` VALUES ('411328', '唐河县', '411300', '86.410000.411300.411328', '中国.河南省.南阳市.唐河县', '1');
INSERT INTO `weiapp_region` VALUES ('411329', '新野县', '411300', '86.410000.411300.411329', '中国.河南省.南阳市.新野县', '1');
INSERT INTO `weiapp_region` VALUES ('411330', '桐柏县', '411300', '86.410000.411300.411330', '中国.河南省.南阳市.桐柏县', '1');
INSERT INTO `weiapp_region` VALUES ('411381', '邓州市', '411300', '86.410000.411300.411381', '中国.河南省.南阳市.邓州市', '1');
INSERT INTO `weiapp_region` VALUES ('411402', '梁园区', '411400', '86.410000.411400.411402', '中国.河南省.商丘市.梁园区', '1');
INSERT INTO `weiapp_region` VALUES ('411403', '睢阳区', '411400', '86.410000.411400.411403', '中国.河南省.商丘市.睢阳区', '1');
INSERT INTO `weiapp_region` VALUES ('411421', '民权县', '411400', '86.410000.411400.411421', '中国.河南省.商丘市.民权县', '1');
INSERT INTO `weiapp_region` VALUES ('411422', '睢县', '411400', '86.410000.411400.411422', '中国.河南省.商丘市.睢县', '1');
INSERT INTO `weiapp_region` VALUES ('411423', '宁陵县', '411400', '86.410000.411400.411423', '中国.河南省.商丘市.宁陵县', '1');
INSERT INTO `weiapp_region` VALUES ('411424', '柘城县', '411400', '86.410000.411400.411424', '中国.河南省.商丘市.柘城县', '1');
INSERT INTO `weiapp_region` VALUES ('411425', '虞城县', '411400', '86.410000.411400.411425', '中国.河南省.商丘市.虞城县', '1');
INSERT INTO `weiapp_region` VALUES ('411426', '夏邑县', '411400', '86.410000.411400.411426', '中国.河南省.商丘市.夏邑县', '1');
INSERT INTO `weiapp_region` VALUES ('411481', '永城市', '411400', '86.410000.411400.411481', '中国.河南省.商丘市.永城市', '1');
INSERT INTO `weiapp_region` VALUES ('411502', '浉河区', '411500', '86.410000.411500.411502', '中国.河南省.信阳市.浉河区', '1');
INSERT INTO `weiapp_region` VALUES ('411503', '平桥区', '411500', '86.410000.411500.411503', '中国.河南省.信阳市.平桥区', '1');
INSERT INTO `weiapp_region` VALUES ('411521', '罗山县', '411500', '86.410000.411500.411521', '中国.河南省.信阳市.罗山县', '1');
INSERT INTO `weiapp_region` VALUES ('411522', '光山县', '411500', '86.410000.411500.411522', '中国.河南省.信阳市.光山县', '1');
INSERT INTO `weiapp_region` VALUES ('411523', '新县', '411500', '86.410000.411500.411523', '中国.河南省.信阳市.新县', '1');
INSERT INTO `weiapp_region` VALUES ('411524', '商城县', '411500', '86.410000.411500.411524', '中国.河南省.信阳市.商城县', '1');
INSERT INTO `weiapp_region` VALUES ('411525', '固始县', '411500', '86.410000.411500.411525', '中国.河南省.信阳市.固始县', '1');
INSERT INTO `weiapp_region` VALUES ('411526', '潢川县', '411500', '86.410000.411500.411526', '中国.河南省.信阳市.潢川县', '1');
INSERT INTO `weiapp_region` VALUES ('411527', '淮滨县', '411500', '86.410000.411500.411527', '中国.河南省.信阳市.淮滨县', '1');
INSERT INTO `weiapp_region` VALUES ('411528', '息县', '411500', '86.410000.411500.411528', '中国.河南省.信阳市.息县', '1');
INSERT INTO `weiapp_region` VALUES ('411602', '川汇区', '411600', '86.410000.411600.411602', '中国.河南省.周口市.川汇区', '1');
INSERT INTO `weiapp_region` VALUES ('411621', '扶沟县', '411600', '86.410000.411600.411621', '中国.河南省.周口市.扶沟县', '1');
INSERT INTO `weiapp_region` VALUES ('411622', '西华县', '411600', '86.410000.411600.411622', '中国.河南省.周口市.西华县', '1');
INSERT INTO `weiapp_region` VALUES ('411623', '商水县', '411600', '86.410000.411600.411623', '中国.河南省.周口市.商水县', '1');
INSERT INTO `weiapp_region` VALUES ('411624', '沈丘县', '411600', '86.410000.411600.411624', '中国.河南省.周口市.沈丘县', '1');
INSERT INTO `weiapp_region` VALUES ('411625', '郸城县', '411600', '86.410000.411600.411625', '中国.河南省.周口市.郸城县', '1');
INSERT INTO `weiapp_region` VALUES ('411626', '淮阳县', '411600', '86.410000.411600.411626', '中国.河南省.周口市.淮阳县', '1');
INSERT INTO `weiapp_region` VALUES ('411627', '太康县', '411600', '86.410000.411600.411627', '中国.河南省.周口市.太康县', '1');
INSERT INTO `weiapp_region` VALUES ('411628', '鹿邑县', '411600', '86.410000.411600.411628', '中国.河南省.周口市.鹿邑县', '1');
INSERT INTO `weiapp_region` VALUES ('411681', '项城市', '411600', '86.410000.411600.411681', '中国.河南省.周口市.项城市', '1');
INSERT INTO `weiapp_region` VALUES ('411702', '驿城区', '411700', '86.410000.411700.411702', '中国.河南省.驻马店市.驿城区', '1');
INSERT INTO `weiapp_region` VALUES ('411721', '西平县', '411700', '86.410000.411700.411721', '中国.河南省.驻马店市.西平县', '1');
INSERT INTO `weiapp_region` VALUES ('411722', '上蔡县', '411700', '86.410000.411700.411722', '中国.河南省.驻马店市.上蔡县', '1');
INSERT INTO `weiapp_region` VALUES ('411723', '平舆县', '411700', '86.410000.411700.411723', '中国.河南省.驻马店市.平舆县', '1');
INSERT INTO `weiapp_region` VALUES ('411724', '正阳县', '411700', '86.410000.411700.411724', '中国.河南省.驻马店市.正阳县', '1');
INSERT INTO `weiapp_region` VALUES ('411725', '确山县', '411700', '86.410000.411700.411725', '中国.河南省.驻马店市.确山县', '1');
INSERT INTO `weiapp_region` VALUES ('411726', '泌阳县', '411700', '86.410000.411700.411726', '中国.河南省.驻马店市.泌阳县', '1');
INSERT INTO `weiapp_region` VALUES ('411727', '汝南县', '411700', '86.410000.411700.411727', '中国.河南省.驻马店市.汝南县', '1');
INSERT INTO `weiapp_region` VALUES ('411728', '遂平县', '411700', '86.410000.411700.411728', '中国.河南省.驻马店市.遂平县', '1');
INSERT INTO `weiapp_region` VALUES ('411729', '新蔡县', '411700', '86.410000.411700.411729', '中国.河南省.驻马店市.新蔡县', '1');
INSERT INTO `weiapp_region` VALUES ('419000', '省直辖县级行政区划', '410000', '86.410000.419000', '中国.河南省.省直辖县级行政区划', '1');
INSERT INTO `weiapp_region` VALUES ('419001', '济源市', '419000', '86.410000.419000.419001', '中国.河南省.省直辖县级行政区划.济源市', '1');
INSERT INTO `weiapp_region` VALUES ('420102', '江岸区', '420100', '86.420000.420100.420102', '中国.湖北省.武汉市.江岸区', '1');
INSERT INTO `weiapp_region` VALUES ('420103', '江汉区', '420100', '86.420000.420100.420103', '中国.湖北省.武汉市.江汉区', '1');
INSERT INTO `weiapp_region` VALUES ('420104', '硚口区', '420100', '86.420000.420100.420104', '中国.湖北省.武汉市.硚口区', '1');
INSERT INTO `weiapp_region` VALUES ('420105', '汉阳区', '420100', '86.420000.420100.420105', '中国.湖北省.武汉市.汉阳区', '1');
INSERT INTO `weiapp_region` VALUES ('420106', '武昌区', '420100', '86.420000.420100.420106', '中国.湖北省.武汉市.武昌区', '1');
INSERT INTO `weiapp_region` VALUES ('420107', '青山区', '420100', '86.420000.420100.420107', '中国.湖北省.武汉市.青山区', '1');
INSERT INTO `weiapp_region` VALUES ('420111', '洪山区', '420100', '86.420000.420100.420111', '中国.湖北省.武汉市.洪山区', '1');
INSERT INTO `weiapp_region` VALUES ('420112', '东西湖区', '420100', '86.420000.420100.420112', '中国.湖北省.武汉市.东西湖区', '1');
INSERT INTO `weiapp_region` VALUES ('420113', '汉南区', '420100', '86.420000.420100.420113', '中国.湖北省.武汉市.汉南区', '1');
INSERT INTO `weiapp_region` VALUES ('420114', '蔡甸区', '420100', '86.420000.420100.420114', '中国.湖北省.武汉市.蔡甸区', '1');
INSERT INTO `weiapp_region` VALUES ('420115', '江夏区', '420100', '86.420000.420100.420115', '中国.湖北省.武汉市.江夏区', '1');
INSERT INTO `weiapp_region` VALUES ('420116', '黄陂区', '420100', '86.420000.420100.420116', '中国.湖北省.武汉市.黄陂区', '1');
INSERT INTO `weiapp_region` VALUES ('420117', '新洲区', '420100', '86.420000.420100.420117', '中国.湖北省.武汉市.新洲区', '1');
INSERT INTO `weiapp_region` VALUES ('420202', '黄石港区', '420200', '86.420000.420200.420202', '中国.湖北省.黄石市.黄石港区', '1');
INSERT INTO `weiapp_region` VALUES ('420203', '西塞山区', '420200', '86.420000.420200.420203', '中国.湖北省.黄石市.西塞山区', '1');
INSERT INTO `weiapp_region` VALUES ('420204', '下陆区', '420200', '86.420000.420200.420204', '中国.湖北省.黄石市.下陆区', '1');
INSERT INTO `weiapp_region` VALUES ('420205', '铁山区', '420200', '86.420000.420200.420205', '中国.湖北省.黄石市.铁山区', '1');
INSERT INTO `weiapp_region` VALUES ('420222', '阳新县', '420200', '86.420000.420200.420222', '中国.湖北省.黄石市.阳新县', '1');
INSERT INTO `weiapp_region` VALUES ('420281', '大冶市', '420200', '86.420000.420200.420281', '中国.湖北省.黄石市.大冶市', '1');
INSERT INTO `weiapp_region` VALUES ('420302', '茅箭区', '420300', '86.420000.420300.420302', '中国.湖北省.十堰市.茅箭区', '1');
INSERT INTO `weiapp_region` VALUES ('420303', '张湾区', '420300', '86.420000.420300.420303', '中国.湖北省.十堰市.张湾区', '1');
INSERT INTO `weiapp_region` VALUES ('420321', '郧县', '420300', '86.420000.420300.420321', '中国.湖北省.十堰市.郧县', '1');
INSERT INTO `weiapp_region` VALUES ('420322', '郧西县', '420300', '86.420000.420300.420322', '中国.湖北省.十堰市.郧西县', '1');
INSERT INTO `weiapp_region` VALUES ('420323', '竹山县', '420300', '86.420000.420300.420323', '中国.湖北省.十堰市.竹山县', '1');
INSERT INTO `weiapp_region` VALUES ('420324', '竹溪县', '420300', '86.420000.420300.420324', '中国.湖北省.十堰市.竹溪县', '1');
INSERT INTO `weiapp_region` VALUES ('420325', '房县', '420300', '86.420000.420300.420325', '中国.湖北省.十堰市.房县', '1');
INSERT INTO `weiapp_region` VALUES ('420381', '丹江口市', '420300', '86.420000.420300.420381', '中国.湖北省.十堰市.丹江口市', '1');
INSERT INTO `weiapp_region` VALUES ('420502', '西陵区', '420500', '86.420000.420500.420502', '中国.湖北省.宜昌市.西陵区', '1');
INSERT INTO `weiapp_region` VALUES ('420503', '伍家岗区', '420500', '86.420000.420500.420503', '中国.湖北省.宜昌市.伍家岗区', '1');
INSERT INTO `weiapp_region` VALUES ('420504', '点军区', '420500', '86.420000.420500.420504', '中国.湖北省.宜昌市.点军区', '1');
INSERT INTO `weiapp_region` VALUES ('420505', '猇亭区', '420500', '86.420000.420500.420505', '中国.湖北省.宜昌市.猇亭区', '1');
INSERT INTO `weiapp_region` VALUES ('420506', '夷陵区', '420500', '86.420000.420500.420506', '中国.湖北省.宜昌市.夷陵区', '1');
INSERT INTO `weiapp_region` VALUES ('420525', '远安县', '420500', '86.420000.420500.420525', '中国.湖北省.宜昌市.远安县', '1');
INSERT INTO `weiapp_region` VALUES ('420526', '兴山县', '420500', '86.420000.420500.420526', '中国.湖北省.宜昌市.兴山县', '1');
INSERT INTO `weiapp_region` VALUES ('420527', '秭归县', '420500', '86.420000.420500.420527', '中国.湖北省.宜昌市.秭归县', '1');
INSERT INTO `weiapp_region` VALUES ('420528', '长阳土家族自治县', '420500', '86.420000.420500.420528', '中国.湖北省.宜昌市.长阳土家族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('420529', '五峰土家族自治县', '420500', '86.420000.420500.420529', '中国.湖北省.宜昌市.五峰土家族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('420581', '宜都市', '420500', '86.420000.420500.420581', '中国.湖北省.宜昌市.宜都市', '1');
INSERT INTO `weiapp_region` VALUES ('420582', '当阳市', '420500', '86.420000.420500.420582', '中国.湖北省.宜昌市.当阳市', '1');
INSERT INTO `weiapp_region` VALUES ('420583', '枝江市', '420500', '86.420000.420500.420583', '中国.湖北省.宜昌市.枝江市', '1');
INSERT INTO `weiapp_region` VALUES ('420602', '襄城区', '420600', '86.420000.420600.420602', '中国.湖北省.襄阳市.襄城区', '1');
INSERT INTO `weiapp_region` VALUES ('420606', '樊城区', '420600', '86.420000.420600.420606', '中国.湖北省.襄阳市.樊城区', '1');
INSERT INTO `weiapp_region` VALUES ('420607', '襄州区', '420600', '86.420000.420600.420607', '中国.湖北省.襄阳市.襄州区', '1');
INSERT INTO `weiapp_region` VALUES ('420624', '南漳县', '420600', '86.420000.420600.420624', '中国.湖北省.襄阳市.南漳县', '1');
INSERT INTO `weiapp_region` VALUES ('420625', '谷城县', '420600', '86.420000.420600.420625', '中国.湖北省.襄阳市.谷城县', '1');
INSERT INTO `weiapp_region` VALUES ('420626', '保康县', '420600', '86.420000.420600.420626', '中国.湖北省.襄阳市.保康县', '1');
INSERT INTO `weiapp_region` VALUES ('420682', '老河口市', '420600', '86.420000.420600.420682', '中国.湖北省.襄阳市.老河口市', '1');
INSERT INTO `weiapp_region` VALUES ('420683', '枣阳市', '420600', '86.420000.420600.420683', '中国.湖北省.襄阳市.枣阳市', '1');
INSERT INTO `weiapp_region` VALUES ('420684', '宜城市', '420600', '86.420000.420600.420684', '中国.湖北省.襄阳市.宜城市', '1');
INSERT INTO `weiapp_region` VALUES ('420702', '梁子湖区', '420700', '86.420000.420700.420702', '中国.湖北省.鄂州市.梁子湖区', '1');
INSERT INTO `weiapp_region` VALUES ('420703', '华容区', '420700', '86.420000.420700.420703', '中国.湖北省.鄂州市.华容区', '1');
INSERT INTO `weiapp_region` VALUES ('420704', '鄂城区', '420700', '86.420000.420700.420704', '中国.湖北省.鄂州市.鄂城区', '1');
INSERT INTO `weiapp_region` VALUES ('420802', '东宝区', '420800', '86.420000.420800.420802', '中国.湖北省.荆门市.东宝区', '1');
INSERT INTO `weiapp_region` VALUES ('420804', '掇刀区', '420800', '86.420000.420800.420804', '中国.湖北省.荆门市.掇刀区', '1');
INSERT INTO `weiapp_region` VALUES ('420821', '京山县', '420800', '86.420000.420800.420821', '中国.湖北省.荆门市.京山县', '1');
INSERT INTO `weiapp_region` VALUES ('420822', '沙洋县', '420800', '86.420000.420800.420822', '中国.湖北省.荆门市.沙洋县', '1');
INSERT INTO `weiapp_region` VALUES ('420881', '钟祥市', '420800', '86.420000.420800.420881', '中国.湖北省.荆门市.钟祥市', '1');
INSERT INTO `weiapp_region` VALUES ('421125', '浠水县', '421100', '86.420000.421100.421125', '中国.湖北省.黄冈市.浠水县', '1');
INSERT INTO `weiapp_region` VALUES ('421126', '蕲春县', '421100', '86.420000.421100.421126', '中国.湖北省.黄冈市.蕲春县', '1');
INSERT INTO `weiapp_region` VALUES ('421127', '黄梅县', '421100', '86.420000.421100.421127', '中国.湖北省.黄冈市.黄梅县', '1');
INSERT INTO `weiapp_region` VALUES ('421181', '麻城市', '421100', '86.420000.421100.421181', '中国.湖北省.黄冈市.麻城市', '1');
INSERT INTO `weiapp_region` VALUES ('421182', '武穴市', '421100', '86.420000.421100.421182', '中国.湖北省.黄冈市.武穴市', '1');
INSERT INTO `weiapp_region` VALUES ('421202', '咸安区', '421200', '86.420000.421200.421202', '中国.湖北省.咸宁市.咸安区', '1');
INSERT INTO `weiapp_region` VALUES ('421221', '嘉鱼县', '421200', '86.420000.421200.421221', '中国.湖北省.咸宁市.嘉鱼县', '1');
INSERT INTO `weiapp_region` VALUES ('421222', '通城县', '421200', '86.420000.421200.421222', '中国.湖北省.咸宁市.通城县', '1');
INSERT INTO `weiapp_region` VALUES ('421223', '崇阳县', '421200', '86.420000.421200.421223', '中国.湖北省.咸宁市.崇阳县', '1');
INSERT INTO `weiapp_region` VALUES ('421224', '通山县', '421200', '86.420000.421200.421224', '中国.湖北省.咸宁市.通山县', '1');
INSERT INTO `weiapp_region` VALUES ('421281', '赤壁市', '421200', '86.420000.421200.421281', '中国.湖北省.咸宁市.赤壁市', '1');
INSERT INTO `weiapp_region` VALUES ('421303', '曾都区', '421300', '86.420000.421300.421303', '中国.湖北省.随州市.曾都区', '1');
INSERT INTO `weiapp_region` VALUES ('421321', '随县', '421300', '86.420000.421300.421321', '中国.湖北省.随州市.随县', '1');
INSERT INTO `weiapp_region` VALUES ('421381', '广水市', '421300', '86.420000.421300.421381', '中国.湖北省.随州市.广水市', '1');
INSERT INTO `weiapp_region` VALUES ('422800', '恩施土家族苗族自治州', '420000', '86.420000.422800', '中国.湖北省.恩施土家族苗族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('422801', '恩施市', '422800', '86.420000.422800.422801', '中国.湖北省.恩施土家族苗族自治州.恩施市', '1');
INSERT INTO `weiapp_region` VALUES ('422802', '利川市', '422800', '86.420000.422800.422802', '中国.湖北省.恩施土家族苗族自治州.利川市', '1');
INSERT INTO `weiapp_region` VALUES ('422822', '建始县', '422800', '86.420000.422800.422822', '中国.湖北省.恩施土家族苗族自治州.建始县', '1');
INSERT INTO `weiapp_region` VALUES ('422823', '巴东县', '422800', '86.420000.422800.422823', '中国.湖北省.恩施土家族苗族自治州.巴东县', '1');
INSERT INTO `weiapp_region` VALUES ('422825', '宣恩县', '422800', '86.420000.422800.422825', '中国.湖北省.恩施土家族苗族自治州.宣恩县', '1');
INSERT INTO `weiapp_region` VALUES ('422826', '咸丰县', '422800', '86.420000.422800.422826', '中国.湖北省.恩施土家族苗族自治州.咸丰县', '1');
INSERT INTO `weiapp_region` VALUES ('422827', '来凤县', '422800', '86.420000.422800.422827', '中国.湖北省.恩施土家族苗族自治州.来凤县', '1');
INSERT INTO `weiapp_region` VALUES ('422828', '鹤峰县', '422800', '86.420000.422800.422828', '中国.湖北省.恩施土家族苗族自治州.鹤峰县', '1');
INSERT INTO `weiapp_region` VALUES ('429000', '省直辖县级行政区划', '420000', '86.420000.429000', '中国.湖北省.省直辖县级行政区划', '1');
INSERT INTO `weiapp_region` VALUES ('429004', '仙桃市', '429000', '86.420000.429000.429004', '中国.湖北省.省直辖县级行政区划.仙桃市', '1');
INSERT INTO `weiapp_region` VALUES ('429005', '潜江市', '429000', '86.420000.429000.429005', '中国.湖北省.省直辖县级行政区划.潜江市', '1');
INSERT INTO `weiapp_region` VALUES ('429006', '天门市', '429000', '86.420000.429000.429006', '中国.湖北省.省直辖县级行政区划.天门市', '1');
INSERT INTO `weiapp_region` VALUES ('429021', '神农架林区', '429000', '86.420000.429000.429021', '中国.湖北省.省直辖县级行政区划.神农架林区', '1');
INSERT INTO `weiapp_region` VALUES ('430102', '芙蓉区', '430100', '86.430000.430100.430102', '中国.湖南省.长沙市.芙蓉区', '1');
INSERT INTO `weiapp_region` VALUES ('430103', '天心区', '430100', '86.430000.430100.430103', '中国.湖南省.长沙市.天心区', '1');
INSERT INTO `weiapp_region` VALUES ('430104', '岳麓区', '430100', '86.430000.430100.430104', '中国.湖南省.长沙市.岳麓区', '1');
INSERT INTO `weiapp_region` VALUES ('430105', '开福区', '430100', '86.430000.430100.430105', '中国.湖南省.长沙市.开福区', '1');
INSERT INTO `weiapp_region` VALUES ('430111', '雨花区', '430100', '86.430000.430100.430111', '中国.湖南省.长沙市.雨花区', '1');
INSERT INTO `weiapp_region` VALUES ('430112', '望城区', '430100', '86.430000.430100.430112', '中国.湖南省.长沙市.望城区', '1');
INSERT INTO `weiapp_region` VALUES ('430121', '长沙县', '430100', '86.430000.430100.430121', '中国.湖南省.长沙市.长沙县', '1');
INSERT INTO `weiapp_region` VALUES ('430124', '宁乡县', '430100', '86.430000.430100.430124', '中国.湖南省.长沙市.宁乡县', '1');
INSERT INTO `weiapp_region` VALUES ('430181', '浏阳市', '430100', '86.430000.430100.430181', '中国.湖南省.长沙市.浏阳市', '1');
INSERT INTO `weiapp_region` VALUES ('430202', '荷塘区', '430200', '86.430000.430200.430202', '中国.湖南省.株洲市.荷塘区', '1');
INSERT INTO `weiapp_region` VALUES ('430203', '芦淞区', '430200', '86.430000.430200.430203', '中国.湖南省.株洲市.芦淞区', '1');
INSERT INTO `weiapp_region` VALUES ('430204', '石峰区', '430200', '86.430000.430200.430204', '中国.湖南省.株洲市.石峰区', '1');
INSERT INTO `weiapp_region` VALUES ('430211', '天元区', '430200', '86.430000.430200.430211', '中国.湖南省.株洲市.天元区', '1');
INSERT INTO `weiapp_region` VALUES ('430221', '株洲县', '430200', '86.430000.430200.430221', '中国.湖南省.株洲市.株洲县', '1');
INSERT INTO `weiapp_region` VALUES ('430224', '茶陵县', '430200', '86.430000.430200.430224', '中国.湖南省.株洲市.茶陵县', '1');
INSERT INTO `weiapp_region` VALUES ('430225', '炎陵县', '430200', '86.430000.430200.430225', '中国.湖南省.株洲市.炎陵县', '1');
INSERT INTO `weiapp_region` VALUES ('430281', '醴陵市', '430200', '86.430000.430200.430281', '中国.湖南省.株洲市.醴陵市', '1');
INSERT INTO `weiapp_region` VALUES ('430302', '雨湖区', '430300', '86.430000.430300.430302', '中国.湖南省.湘潭市.雨湖区', '1');
INSERT INTO `weiapp_region` VALUES ('430304', '岳塘区', '430300', '86.430000.430300.430304', '中国.湖南省.湘潭市.岳塘区', '1');
INSERT INTO `weiapp_region` VALUES ('430321', '湘潭县', '430300', '86.430000.430300.430321', '中国.湖南省.湘潭市.湘潭县', '1');
INSERT INTO `weiapp_region` VALUES ('430381', '湘乡市', '430300', '86.430000.430300.430381', '中国.湖南省.湘潭市.湘乡市', '1');
INSERT INTO `weiapp_region` VALUES ('430382', '韶山市', '430300', '86.430000.430300.430382', '中国.湖南省.湘潭市.韶山市', '1');
INSERT INTO `weiapp_region` VALUES ('430405', '珠晖区', '430400', '86.430000.430400.430405', '中国.湖南省.衡阳市.珠晖区', '1');
INSERT INTO `weiapp_region` VALUES ('430406', '雁峰区', '430400', '86.430000.430400.430406', '中国.湖南省.衡阳市.雁峰区', '1');
INSERT INTO `weiapp_region` VALUES ('430407', '石鼓区', '430400', '86.430000.430400.430407', '中国.湖南省.衡阳市.石鼓区', '1');
INSERT INTO `weiapp_region` VALUES ('430408', '蒸湘区', '430400', '86.430000.430400.430408', '中国.湖南省.衡阳市.蒸湘区', '1');
INSERT INTO `weiapp_region` VALUES ('430412', '南岳区', '430400', '86.430000.430400.430412', '中国.湖南省.衡阳市.南岳区', '1');
INSERT INTO `weiapp_region` VALUES ('430421', '衡阳县', '430400', '86.430000.430400.430421', '中国.湖南省.衡阳市.衡阳县', '1');
INSERT INTO `weiapp_region` VALUES ('430422', '衡南县', '430400', '86.430000.430400.430422', '中国.湖南省.衡阳市.衡南县', '1');
INSERT INTO `weiapp_region` VALUES ('430423', '衡山县', '430400', '86.430000.430400.430423', '中国.湖南省.衡阳市.衡山县', '1');
INSERT INTO `weiapp_region` VALUES ('430424', '衡东县', '430400', '86.430000.430400.430424', '中国.湖南省.衡阳市.衡东县', '1');
INSERT INTO `weiapp_region` VALUES ('430426', '祁东县', '430400', '86.430000.430400.430426', '中国.湖南省.衡阳市.祁东县', '1');
INSERT INTO `weiapp_region` VALUES ('430481', '耒阳市', '430400', '86.430000.430400.430481', '中国.湖南省.衡阳市.耒阳市', '1');
INSERT INTO `weiapp_region` VALUES ('430482', '常宁市', '430400', '86.430000.430400.430482', '中国.湖南省.衡阳市.常宁市', '1');
INSERT INTO `weiapp_region` VALUES ('430502', '双清区', '430500', '86.430000.430500.430502', '中国.湖南省.邵阳市.双清区', '1');
INSERT INTO `weiapp_region` VALUES ('430503', '大祥区', '430500', '86.430000.430500.430503', '中国.湖南省.邵阳市.大祥区', '1');
INSERT INTO `weiapp_region` VALUES ('430511', '北塔区', '430500', '86.430000.430500.430511', '中国.湖南省.邵阳市.北塔区', '1');
INSERT INTO `weiapp_region` VALUES ('430521', '邵东县', '430500', '86.430000.430500.430521', '中国.湖南省.邵阳市.邵东县', '1');
INSERT INTO `weiapp_region` VALUES ('430522', '新邵县', '430500', '86.430000.430500.430522', '中国.湖南省.邵阳市.新邵县', '1');
INSERT INTO `weiapp_region` VALUES ('430523', '邵阳县', '430500', '86.430000.430500.430523', '中国.湖南省.邵阳市.邵阳县', '1');
INSERT INTO `weiapp_region` VALUES ('430524', '隆回县', '430500', '86.430000.430500.430524', '中国.湖南省.邵阳市.隆回县', '1');
INSERT INTO `weiapp_region` VALUES ('430525', '洞口县', '430500', '86.430000.430500.430525', '中国.湖南省.邵阳市.洞口县', '1');
INSERT INTO `weiapp_region` VALUES ('430527', '绥宁县', '430500', '86.430000.430500.430527', '中国.湖南省.邵阳市.绥宁县', '1');
INSERT INTO `weiapp_region` VALUES ('430528', '新宁县', '430500', '86.430000.430500.430528', '中国.湖南省.邵阳市.新宁县', '1');
INSERT INTO `weiapp_region` VALUES ('430529', '城步苗族自治县', '430500', '86.430000.430500.430529', '中国.湖南省.邵阳市.城步苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('430581', '武冈市', '430500', '86.430000.430500.430581', '中国.湖南省.邵阳市.武冈市', '1');
INSERT INTO `weiapp_region` VALUES ('430602', '岳阳楼区', '430600', '86.430000.430600.430602', '中国.湖南省.岳阳市.岳阳楼区', '1');
INSERT INTO `weiapp_region` VALUES ('430603', '云溪区', '430600', '86.430000.430600.430603', '中国.湖南省.岳阳市.云溪区', '1');
INSERT INTO `weiapp_region` VALUES ('430611', '君山区', '430600', '86.430000.430600.430611', '中国.湖南省.岳阳市.君山区', '1');
INSERT INTO `weiapp_region` VALUES ('430621', '岳阳县', '430600', '86.430000.430600.430621', '中国.湖南省.岳阳市.岳阳县', '1');
INSERT INTO `weiapp_region` VALUES ('430623', '华容县', '430600', '86.430000.430600.430623', '中国.湖南省.岳阳市.华容县', '1');
INSERT INTO `weiapp_region` VALUES ('430624', '湘阴县', '430600', '86.430000.430600.430624', '中国.湖南省.岳阳市.湘阴县', '1');
INSERT INTO `weiapp_region` VALUES ('430626', '平江县', '430600', '86.430000.430600.430626', '中国.湖南省.岳阳市.平江县', '1');
INSERT INTO `weiapp_region` VALUES ('430681', '汨罗市', '430600', '86.430000.430600.430681', '中国.湖南省.岳阳市.汨罗市', '1');
INSERT INTO `weiapp_region` VALUES ('430682', '临湘市', '430600', '86.430000.430600.430682', '中国.湖南省.岳阳市.临湘市', '1');
INSERT INTO `weiapp_region` VALUES ('430702', '武陵区', '430700', '86.430000.430700.430702', '中国.湖南省.常德市.武陵区', '1');
INSERT INTO `weiapp_region` VALUES ('430703', '鼎城区', '430700', '86.430000.430700.430703', '中国.湖南省.常德市.鼎城区', '1');
INSERT INTO `weiapp_region` VALUES ('430721', '安乡县', '430700', '86.430000.430700.430721', '中国.湖南省.常德市.安乡县', '1');
INSERT INTO `weiapp_region` VALUES ('430722', '汉寿县', '430700', '86.430000.430700.430722', '中国.湖南省.常德市.汉寿县', '1');
INSERT INTO `weiapp_region` VALUES ('430724', '临澧县', '430700', '86.430000.430700.430724', '中国.湖南省.常德市.临澧县', '1');
INSERT INTO `weiapp_region` VALUES ('430725', '桃源县', '430700', '86.430000.430700.430725', '中国.湖南省.常德市.桃源县', '1');
INSERT INTO `weiapp_region` VALUES ('430726', '石门县', '430700', '86.430000.430700.430726', '中国.湖南省.常德市.石门县', '1');
INSERT INTO `weiapp_region` VALUES ('430781', '津市市', '430700', '86.430000.430700.430781', '中国.湖南省.常德市.津市市', '1');
INSERT INTO `weiapp_region` VALUES ('430802', '永定区', '430800', '86.430000.430800.430802', '中国.湖南省.张家界市.永定区', '1');
INSERT INTO `weiapp_region` VALUES ('430811', '武陵源区', '430800', '86.430000.430800.430811', '中国.湖南省.张家界市.武陵源区', '1');
INSERT INTO `weiapp_region` VALUES ('430821', '慈利县', '430800', '86.430000.430800.430821', '中国.湖南省.张家界市.慈利县', '1');
INSERT INTO `weiapp_region` VALUES ('430822', '桑植县', '430800', '86.430000.430800.430822', '中国.湖南省.张家界市.桑植县', '1');
INSERT INTO `weiapp_region` VALUES ('430903', '赫山区', '430900', '86.430000.430900.430903', '中国.湖南省.益阳市.赫山区', '1');
INSERT INTO `weiapp_region` VALUES ('430922', '桃江县', '430900', '86.430000.430900.430922', '中国.湖南省.益阳市.桃江县', '1');
INSERT INTO `weiapp_region` VALUES ('430923', '安化县', '430900', '86.430000.430900.430923', '中国.湖南省.益阳市.安化县', '1');
INSERT INTO `weiapp_region` VALUES ('430981', '沅江市', '430900', '86.430000.430900.430981', '中国.湖南省.益阳市.沅江市', '1');
INSERT INTO `weiapp_region` VALUES ('431002', '北湖区', '431000', '86.430000.431000.431002', '中国.湖南省.郴州市.北湖区', '1');
INSERT INTO `weiapp_region` VALUES ('431003', '苏仙区', '431000', '86.430000.431000.431003', '中国.湖南省.郴州市.苏仙区', '1');
INSERT INTO `weiapp_region` VALUES ('431021', '桂阳县', '431000', '86.430000.431000.431021', '中国.湖南省.郴州市.桂阳县', '1');
INSERT INTO `weiapp_region` VALUES ('431022', '宜章县', '431000', '86.430000.431000.431022', '中国.湖南省.郴州市.宜章县', '1');
INSERT INTO `weiapp_region` VALUES ('431023', '永兴县', '431000', '86.430000.431000.431023', '中国.湖南省.郴州市.永兴县', '1');
INSERT INTO `weiapp_region` VALUES ('431024', '嘉禾县', '431000', '86.430000.431000.431024', '中国.湖南省.郴州市.嘉禾县', '1');
INSERT INTO `weiapp_region` VALUES ('431025', '临武县', '431000', '86.430000.431000.431025', '中国.湖南省.郴州市.临武县', '1');
INSERT INTO `weiapp_region` VALUES ('431026', '汝城县', '431000', '86.430000.431000.431026', '中国.湖南省.郴州市.汝城县', '1');
INSERT INTO `weiapp_region` VALUES ('431027', '桂东县', '431000', '86.430000.431000.431027', '中国.湖南省.郴州市.桂东县', '1');
INSERT INTO `weiapp_region` VALUES ('431028', '安仁县', '431000', '86.430000.431000.431028', '中国.湖南省.郴州市.安仁县', '1');
INSERT INTO `weiapp_region` VALUES ('431081', '资兴市', '431000', '86.430000.431000.431081', '中国.湖南省.郴州市.资兴市', '1');
INSERT INTO `weiapp_region` VALUES ('431102', '零陵区', '431100', '86.430000.431100.431102', '中国.湖南省.永州市.零陵区', '1');
INSERT INTO `weiapp_region` VALUES ('431103', '冷水滩区', '431100', '86.430000.431100.431103', '中国.湖南省.永州市.冷水滩区', '1');
INSERT INTO `weiapp_region` VALUES ('431121', '祁阳县', '431100', '86.430000.431100.431121', '中国.湖南省.永州市.祁阳县', '1');
INSERT INTO `weiapp_region` VALUES ('431122', '东安县', '431100', '86.430000.431100.431122', '中国.湖南省.永州市.东安县', '1');
INSERT INTO `weiapp_region` VALUES ('431123', '双牌县', '431100', '86.430000.431100.431123', '中国.湖南省.永州市.双牌县', '1');
INSERT INTO `weiapp_region` VALUES ('431125', '江永县', '431100', '86.430000.431100.431125', '中国.湖南省.永州市.江永县', '1');
INSERT INTO `weiapp_region` VALUES ('431126', '宁远县', '431100', '86.430000.431100.431126', '中国.湖南省.永州市.宁远县', '1');
INSERT INTO `weiapp_region` VALUES ('431127', '蓝山县', '431100', '86.430000.431100.431127', '中国.湖南省.永州市.蓝山县', '1');
INSERT INTO `weiapp_region` VALUES ('431128', '新田县', '431100', '86.430000.431100.431128', '中国.湖南省.永州市.新田县', '1');
INSERT INTO `weiapp_region` VALUES ('431129', '江华瑶族自治县', '431100', '86.430000.431100.431129', '中国.湖南省.永州市.江华瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('431202', '鹤城区', '431200', '86.430000.431200.431202', '中国.湖南省.怀化市.鹤城区', '1');
INSERT INTO `weiapp_region` VALUES ('431221', '中方县', '431200', '86.430000.431200.431221', '中国.湖南省.怀化市.中方县', '1');
INSERT INTO `weiapp_region` VALUES ('431222', '沅陵县', '431200', '86.430000.431200.431222', '中国.湖南省.怀化市.沅陵县', '1');
INSERT INTO `weiapp_region` VALUES ('431223', '辰溪县', '431200', '86.430000.431200.431223', '中国.湖南省.怀化市.辰溪县', '1');
INSERT INTO `weiapp_region` VALUES ('431224', '溆浦县', '431200', '86.430000.431200.431224', '中国.湖南省.怀化市.溆浦县', '1');
INSERT INTO `weiapp_region` VALUES ('431225', '会同县', '431200', '86.430000.431200.431225', '中国.湖南省.怀化市.会同县', '1');
INSERT INTO `weiapp_region` VALUES ('431226', '麻阳苗族自治县', '431200', '86.430000.431200.431226', '中国.湖南省.怀化市.麻阳苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('431227', '新晃侗族自治县', '431200', '86.430000.431200.431227', '中国.湖南省.怀化市.新晃侗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('431228', '芷江侗族自治县', '431200', '86.430000.431200.431228', '中国.湖南省.怀化市.芷江侗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('431229', '靖州苗族侗族自治县', '431200', '86.430000.431200.431229', '中国.湖南省.怀化市.靖州苗族侗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('431230', '通道侗族自治县', '431200', '86.430000.431200.431230', '中国.湖南省.怀化市.通道侗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('431281', '洪江市', '431200', '86.430000.431200.431281', '中国.湖南省.怀化市.洪江市', '1');
INSERT INTO `weiapp_region` VALUES ('433100', '湘西土家族苗族自治州', '430000', '86.430000.433100', '中国.湖南省.湘西土家族苗族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('433101', '吉首市', '433100', '86.430000.433100.433101', '中国.湖南省.湘西土家族苗族自治州.吉首市', '1');
INSERT INTO `weiapp_region` VALUES ('433122', '泸溪县', '433100', '86.430000.433100.433122', '中国.湖南省.湘西土家族苗族自治州.泸溪县', '1');
INSERT INTO `weiapp_region` VALUES ('433123', '凤凰县', '433100', '86.430000.433100.433123', '中国.湖南省.湘西土家族苗族自治州.凤凰县', '1');
INSERT INTO `weiapp_region` VALUES ('433124', '花垣县', '433100', '86.430000.433100.433124', '中国.湖南省.湘西土家族苗族自治州.花垣县', '1');
INSERT INTO `weiapp_region` VALUES ('433125', '保靖县', '433100', '86.430000.433100.433125', '中国.湖南省.湘西土家族苗族自治州.保靖县', '1');
INSERT INTO `weiapp_region` VALUES ('433126', '古丈县', '433100', '86.430000.433100.433126', '中国.湖南省.湘西土家族苗族自治州.古丈县', '1');
INSERT INTO `weiapp_region` VALUES ('433127', '永顺县', '433100', '86.430000.433100.433127', '中国.湖南省.湘西土家族苗族自治州.永顺县', '1');
INSERT INTO `weiapp_region` VALUES ('433130', '龙山县', '433100', '86.430000.433100.433130', '中国.湖南省.湘西土家族苗族自治州.龙山县', '1');
INSERT INTO `weiapp_region` VALUES ('440103', '荔湾区', '440100', '86.440000.440100.440103', '中国.广东省.广州市.荔湾区', '1');
INSERT INTO `weiapp_region` VALUES ('440104', '越秀区', '440100', '86.440000.440100.440104', '中国.广东省.广州市.越秀区', '1');
INSERT INTO `weiapp_region` VALUES ('440105', '海珠区', '440100', '86.440000.440100.440105', '中国.广东省.广州市.海珠区', '1');
INSERT INTO `weiapp_region` VALUES ('440106', '天河区', '440100', '86.440000.440100.440106', '中国.广东省.广州市.天河区', '1');
INSERT INTO `weiapp_region` VALUES ('440111', '白云区', '440100', '86.440000.440100.440111', '中国.广东省.广州市.白云区', '1');
INSERT INTO `weiapp_region` VALUES ('440112', '黄埔区', '440100', '86.440000.440100.440112', '中国.广东省.广州市.黄埔区', '1');
INSERT INTO `weiapp_region` VALUES ('440113', '番禺区', '440100', '86.440000.440100.440113', '中国.广东省.广州市.番禺区', '1');
INSERT INTO `weiapp_region` VALUES ('440114', '花都区', '440100', '86.440000.440100.440114', '中国.广东省.广州市.花都区', '1');
INSERT INTO `weiapp_region` VALUES ('440115', '南沙区', '440100', '86.440000.440100.440115', '中国.广东省.广州市.南沙区', '1');
INSERT INTO `weiapp_region` VALUES ('440116', '萝岗区', '440100', '86.440000.440100.440116', '中国.广东省.广州市.萝岗区', '1');
INSERT INTO `weiapp_region` VALUES ('440183', '增城市', '440100', '86.440000.440100.440183', '中国.广东省.广州市.增城市', '1');
INSERT INTO `weiapp_region` VALUES ('440184', '从化市', '440100', '86.440000.440100.440184', '中国.广东省.广州市.从化市', '1');
INSERT INTO `weiapp_region` VALUES ('440203', '武江区', '440200', '86.440000.440200.440203', '中国.广东省.韶关市.武江区', '1');
INSERT INTO `weiapp_region` VALUES ('440204', '浈江区', '440200', '86.440000.440200.440204', '中国.广东省.韶关市.浈江区', '1');
INSERT INTO `weiapp_region` VALUES ('440205', '曲江区', '440200', '86.440000.440200.440205', '中国.广东省.韶关市.曲江区', '1');
INSERT INTO `weiapp_region` VALUES ('440222', '始兴县', '440200', '86.440000.440200.440222', '中国.广东省.韶关市.始兴县', '1');
INSERT INTO `weiapp_region` VALUES ('440224', '仁化县', '440200', '86.440000.440200.440224', '中国.广东省.韶关市.仁化县', '1');
INSERT INTO `weiapp_region` VALUES ('440229', '翁源县', '440200', '86.440000.440200.440229', '中国.广东省.韶关市.翁源县', '1');
INSERT INTO `weiapp_region` VALUES ('440232', '乳源瑶族自治县', '440200', '86.440000.440200.440232', '中国.广东省.韶关市.乳源瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('440233', '新丰县', '440200', '86.440000.440200.440233', '中国.广东省.韶关市.新丰县', '1');
INSERT INTO `weiapp_region` VALUES ('440281', '乐昌市', '440200', '86.440000.440200.440281', '中国.广东省.韶关市.乐昌市', '1');
INSERT INTO `weiapp_region` VALUES ('440282', '南雄市', '440200', '86.440000.440200.440282', '中国.广东省.韶关市.南雄市', '1');
INSERT INTO `weiapp_region` VALUES ('440304', '福田区', '440300', '86.440000.440300.440304', '中国.广东省.深圳市.福田区', '1');
INSERT INTO `weiapp_region` VALUES ('440305', '南山区', '440300', '86.440000.440300.440305', '中国.广东省.深圳市.南山区', '1');
INSERT INTO `weiapp_region` VALUES ('440306', '宝安区', '440300', '86.440000.440300.440306', '中国.广东省.深圳市.宝安区', '1');
INSERT INTO `weiapp_region` VALUES ('440307', '龙岗区', '440300', '86.440000.440300.440307', '中国.广东省.深圳市.龙岗区', '1');
INSERT INTO `weiapp_region` VALUES ('440308', '盐田区', '440300', '86.440000.440300.440308', '中国.广东省.深圳市.盐田区', '1');
INSERT INTO `weiapp_region` VALUES ('440403', '斗门区', '440400', '86.440000.440400.440403', '中国.广东省.珠海市.斗门区', '1');
INSERT INTO `weiapp_region` VALUES ('440404', '金湾区', '440400', '86.440000.440400.440404', '中国.广东省.珠海市.金湾区', '1');
INSERT INTO `weiapp_region` VALUES ('440507', '龙湖区', '440500', '86.440000.440500.440507', '中国.广东省.汕头市.龙湖区', '1');
INSERT INTO `weiapp_region` VALUES ('440511', '金平区', '440500', '86.440000.440500.440511', '中国.广东省.汕头市.金平区', '1');
INSERT INTO `weiapp_region` VALUES ('440512', '濠江区', '440500', '86.440000.440500.440512', '中国.广东省.汕头市.濠江区', '1');
INSERT INTO `weiapp_region` VALUES ('440513', '潮阳区', '440500', '86.440000.440500.440513', '中国.广东省.汕头市.潮阳区', '1');
INSERT INTO `weiapp_region` VALUES ('440514', '潮南区', '440500', '86.440000.440500.440514', '中国.广东省.汕头市.潮南区', '1');
INSERT INTO `weiapp_region` VALUES ('440515', '澄海区', '440500', '86.440000.440500.440515', '中国.广东省.汕头市.澄海区', '1');
INSERT INTO `weiapp_region` VALUES ('440523', '南澳县', '440500', '86.440000.440500.440523', '中国.广东省.汕头市.南澳县', '1');
INSERT INTO `weiapp_region` VALUES ('440604', '禅城区', '440600', '86.440000.440600.440604', '中国.广东省.佛山市.禅城区', '1');
INSERT INTO `weiapp_region` VALUES ('440605', '南海区', '440600', '86.440000.440600.440605', '中国.广东省.佛山市.南海区', '1');
INSERT INTO `weiapp_region` VALUES ('440606', '顺德区', '440600', '86.440000.440600.440606', '中国.广东省.佛山市.顺德区', '1');
INSERT INTO `weiapp_region` VALUES ('440607', '三水区', '440600', '86.440000.440600.440607', '中国.广东省.佛山市.三水区', '1');
INSERT INTO `weiapp_region` VALUES ('440608', '高明区', '440600', '86.440000.440600.440608', '中国.广东省.佛山市.高明区', '1');
INSERT INTO `weiapp_region` VALUES ('440703', '蓬江区', '440700', '86.440000.440700.440703', '中国.广东省.江门市.蓬江区', '1');
INSERT INTO `weiapp_region` VALUES ('440704', '江海区', '440700', '86.440000.440700.440704', '中国.广东省.江门市.江海区', '1');
INSERT INTO `weiapp_region` VALUES ('440705', '新会区', '440700', '86.440000.440700.440705', '中国.广东省.江门市.新会区', '1');
INSERT INTO `weiapp_region` VALUES ('440781', '台山市', '440700', '86.440000.440700.440781', '中国.广东省.江门市.台山市', '1');
INSERT INTO `weiapp_region` VALUES ('440783', '开平市', '440700', '86.440000.440700.440783', '中国.广东省.江门市.开平市', '1');
INSERT INTO `weiapp_region` VALUES ('440784', '鹤山市', '440700', '86.440000.440700.440784', '中国.广东省.江门市.鹤山市', '1');
INSERT INTO `weiapp_region` VALUES ('440785', '恩平市', '440700', '86.440000.440700.440785', '中国.广东省.江门市.恩平市', '1');
INSERT INTO `weiapp_region` VALUES ('440803', '霞山区', '440800', '86.440000.440800.440803', '中国.广东省.湛江市.霞山区', '1');
INSERT INTO `weiapp_region` VALUES ('440804', '坡头区', '440800', '86.440000.440800.440804', '中国.广东省.湛江市.坡头区', '1');
INSERT INTO `weiapp_region` VALUES ('440811', '麻章区', '440800', '86.440000.440800.440811', '中国.广东省.湛江市.麻章区', '1');
INSERT INTO `weiapp_region` VALUES ('440823', '遂溪县', '440800', '86.440000.440800.440823', '中国.广东省.湛江市.遂溪县', '1');
INSERT INTO `weiapp_region` VALUES ('440825', '徐闻县', '440800', '86.440000.440800.440825', '中国.广东省.湛江市.徐闻县', '1');
INSERT INTO `weiapp_region` VALUES ('440881', '廉江市', '440800', '86.440000.440800.440881', '中国.广东省.湛江市.廉江市', '1');
INSERT INTO `weiapp_region` VALUES ('440882', '雷州市', '440800', '86.440000.440800.440882', '中国.广东省.湛江市.雷州市', '1');
INSERT INTO `weiapp_region` VALUES ('440883', '吴川市', '440800', '86.440000.440800.440883', '中国.广东省.湛江市.吴川市', '1');
INSERT INTO `weiapp_region` VALUES ('440902', '茂南区', '440900', '86.440000.440900.440902', '中国.广东省.茂名市.茂南区', '1');
INSERT INTO `weiapp_region` VALUES ('440903', '茂港区', '440900', '86.440000.440900.440903', '中国.广东省.茂名市.茂港区', '1');
INSERT INTO `weiapp_region` VALUES ('440923', '电白县', '440900', '86.440000.440900.440923', '中国.广东省.茂名市.电白县', '1');
INSERT INTO `weiapp_region` VALUES ('440981', '高州市', '440900', '86.440000.440900.440981', '中国.广东省.茂名市.高州市', '1');
INSERT INTO `weiapp_region` VALUES ('440982', '化州市', '440900', '86.440000.440900.440982', '中国.广东省.茂名市.化州市', '1');
INSERT INTO `weiapp_region` VALUES ('440983', '信宜市', '440900', '86.440000.440900.440983', '中国.广东省.茂名市.信宜市', '1');
INSERT INTO `weiapp_region` VALUES ('441202', '端州区', '441200', '86.440000.441200.441202', '中国.广东省.肇庆市.端州区', '1');
INSERT INTO `weiapp_region` VALUES ('441203', '鼎湖区', '441200', '86.440000.441200.441203', '中国.广东省.肇庆市.鼎湖区', '1');
INSERT INTO `weiapp_region` VALUES ('441223', '广宁县', '441200', '86.440000.441200.441223', '中国.广东省.肇庆市.广宁县', '1');
INSERT INTO `weiapp_region` VALUES ('441224', '怀集县', '441200', '86.440000.441200.441224', '中国.广东省.肇庆市.怀集县', '1');
INSERT INTO `weiapp_region` VALUES ('441225', '封开县', '441200', '86.440000.441200.441225', '中国.广东省.肇庆市.封开县', '1');
INSERT INTO `weiapp_region` VALUES ('441226', '德庆县', '441200', '86.440000.441200.441226', '中国.广东省.肇庆市.德庆县', '1');
INSERT INTO `weiapp_region` VALUES ('441283', '高要市', '441200', '86.440000.441200.441283', '中国.广东省.肇庆市.高要市', '1');
INSERT INTO `weiapp_region` VALUES ('441284', '四会市', '441200', '86.440000.441200.441284', '中国.广东省.肇庆市.四会市', '1');
INSERT INTO `weiapp_region` VALUES ('441302', '惠城区', '441300', '86.440000.441300.441302', '中国.广东省.惠州市.惠城区', '1');
INSERT INTO `weiapp_region` VALUES ('441303', '惠阳区', '441300', '86.440000.441300.441303', '中国.广东省.惠州市.惠阳区', '1');
INSERT INTO `weiapp_region` VALUES ('441322', '博罗县', '441300', '86.440000.441300.441322', '中国.广东省.惠州市.博罗县', '1');
INSERT INTO `weiapp_region` VALUES ('441323', '惠东县', '441300', '86.440000.441300.441323', '中国.广东省.惠州市.惠东县', '1');
INSERT INTO `weiapp_region` VALUES ('441324', '龙门县', '441300', '86.440000.441300.441324', '中国.广东省.惠州市.龙门县', '1');
INSERT INTO `weiapp_region` VALUES ('441402', '梅江区', '441400', '86.440000.441400.441402', '中国.广东省.梅州市.梅江区', '1');
INSERT INTO `weiapp_region` VALUES ('441422', '大埔县', '441400', '86.440000.441400.441422', '中国.广东省.梅州市.大埔县', '1');
INSERT INTO `weiapp_region` VALUES ('441423', '丰顺县', '441400', '86.440000.441400.441423', '中国.广东省.梅州市.丰顺县', '1');
INSERT INTO `weiapp_region` VALUES ('441424', '五华县', '441400', '86.440000.441400.441424', '中国.广东省.梅州市.五华县', '1');
INSERT INTO `weiapp_region` VALUES ('441426', '平远县', '441400', '86.440000.441400.441426', '中国.广东省.梅州市.平远县', '1');
INSERT INTO `weiapp_region` VALUES ('441427', '蕉岭县', '441400', '86.440000.441400.441427', '中国.广东省.梅州市.蕉岭县', '1');
INSERT INTO `weiapp_region` VALUES ('441481', '兴宁市', '441400', '86.440000.441400.441481', '中国.广东省.梅州市.兴宁市', '1');
INSERT INTO `weiapp_region` VALUES ('441521', '海丰县', '441500', '86.440000.441500.441521', '中国.广东省.汕尾市.海丰县', '1');
INSERT INTO `weiapp_region` VALUES ('441523', '陆河县', '441500', '86.440000.441500.441523', '中国.广东省.汕尾市.陆河县', '1');
INSERT INTO `weiapp_region` VALUES ('441581', '陆丰市', '441500', '86.440000.441500.441581', '中国.广东省.汕尾市.陆丰市', '1');
INSERT INTO `weiapp_region` VALUES ('441602', '源城区', '441600', '86.440000.441600.441602', '中国.广东省.河源市.源城区', '1');
INSERT INTO `weiapp_region` VALUES ('441621', '紫金县', '441600', '86.440000.441600.441621', '中国.广东省.河源市.紫金县', '1');
INSERT INTO `weiapp_region` VALUES ('441622', '龙川县', '441600', '86.440000.441600.441622', '中国.广东省.河源市.龙川县', '1');
INSERT INTO `weiapp_region` VALUES ('441623', '连平县', '441600', '86.440000.441600.441623', '中国.广东省.河源市.连平县', '1');
INSERT INTO `weiapp_region` VALUES ('441624', '和平县', '441600', '86.440000.441600.441624', '中国.广东省.河源市.和平县', '1');
INSERT INTO `weiapp_region` VALUES ('441625', '东源县', '441600', '86.440000.441600.441625', '中国.广东省.河源市.东源县', '1');
INSERT INTO `weiapp_region` VALUES ('441702', '江城区', '441700', '86.440000.441700.441702', '中国.广东省.阳江市.江城区', '1');
INSERT INTO `weiapp_region` VALUES ('441721', '阳西县', '441700', '86.440000.441700.441721', '中国.广东省.阳江市.阳西县', '1');
INSERT INTO `weiapp_region` VALUES ('441723', '阳东县', '441700', '86.440000.441700.441723', '中国.广东省.阳江市.阳东县', '1');
INSERT INTO `weiapp_region` VALUES ('441781', '阳春市', '441700', '86.440000.441700.441781', '中国.广东省.阳江市.阳春市', '1');
INSERT INTO `weiapp_region` VALUES ('441802', '清城区', '441800', '86.440000.441800.441802', '中国.广东省.清远市.清城区', '1');
INSERT INTO `weiapp_region` VALUES ('441821', '佛冈县', '441800', '86.440000.441800.441821', '中国.广东省.清远市.佛冈县', '1');
INSERT INTO `weiapp_region` VALUES ('441823', '阳山县', '441800', '86.440000.441800.441823', '中国.广东省.清远市.阳山县', '1');
INSERT INTO `weiapp_region` VALUES ('441825', '连山壮族瑶族自治县', '441800', '86.440000.441800.441825', '中国.广东省.清远市.连山壮族瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('441826', '连南瑶族自治县', '441800', '86.440000.441800.441826', '中国.广东省.清远市.连南瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('441827', '清新县', '441800', '86.440000.441800.441827', '中国.广东省.清远市.清新县', '1');
INSERT INTO `weiapp_region` VALUES ('441881', '英德市', '441800', '86.440000.441800.441881', '中国.广东省.清远市.英德市', '1');
INSERT INTO `weiapp_region` VALUES ('441882', '连州市', '441800', '86.440000.441800.441882', '中国.广东省.清远市.连州市', '1');
INSERT INTO `weiapp_region` VALUES ('445102', '湘桥区', '445100', '86.440000.445100.445102', '中国.广东省.潮州市.湘桥区', '1');
INSERT INTO `weiapp_region` VALUES ('445121', '潮安县', '445100', '86.440000.445100.445121', '中国.广东省.潮州市.潮安县', '1');
INSERT INTO `weiapp_region` VALUES ('445122', '饶平县', '445100', '86.440000.445100.445122', '中国.广东省.潮州市.饶平县', '1');
INSERT INTO `weiapp_region` VALUES ('445202', '榕城区', '445200', '86.440000.445200.445202', '中国.广东省.揭阳市.榕城区', '1');
INSERT INTO `weiapp_region` VALUES ('445221', '揭东县', '445200', '86.440000.445200.445221', '中国.广东省.揭阳市.揭东县', '1');
INSERT INTO `weiapp_region` VALUES ('445222', '揭西县', '445200', '86.440000.445200.445222', '中国.广东省.揭阳市.揭西县', '1');
INSERT INTO `weiapp_region` VALUES ('445224', '惠来县', '445200', '86.440000.445200.445224', '中国.广东省.揭阳市.惠来县', '1');
INSERT INTO `weiapp_region` VALUES ('445281', '普宁市', '445200', '86.440000.445200.445281', '中国.广东省.揭阳市.普宁市', '1');
INSERT INTO `weiapp_region` VALUES ('445302', '云城区', '445300', '86.440000.445300.445302', '中国.广东省.云浮市.云城区', '1');
INSERT INTO `weiapp_region` VALUES ('445321', '新兴县', '445300', '86.440000.445300.445321', '中国.广东省.云浮市.新兴县', '1');
INSERT INTO `weiapp_region` VALUES ('445322', '郁南县', '445300', '86.440000.445300.445322', '中国.广东省.云浮市.郁南县', '1');
INSERT INTO `weiapp_region` VALUES ('445323', '云安县', '445300', '86.440000.445300.445323', '中国.广东省.云浮市.云安县', '1');
INSERT INTO `weiapp_region` VALUES ('445381', '罗定市', '445300', '86.440000.445300.445381', '中国.广东省.云浮市.罗定市', '1');
INSERT INTO `weiapp_region` VALUES ('450102', '兴宁区', '450100', '86.450000.450100.450102', '中国.广西壮族自治区.南宁市.兴宁区', '1');
INSERT INTO `weiapp_region` VALUES ('450103', '青秀区', '450100', '86.450000.450100.450103', '中国.广西壮族自治区.南宁市.青秀区', '1');
INSERT INTO `weiapp_region` VALUES ('450105', '江南区', '450100', '86.450000.450100.450105', '中国.广西壮族自治区.南宁市.江南区', '1');
INSERT INTO `weiapp_region` VALUES ('450107', '西乡塘区', '450100', '86.450000.450100.450107', '中国.广西壮族自治区.南宁市.西乡塘区', '1');
INSERT INTO `weiapp_region` VALUES ('450108', '良庆区', '450100', '86.450000.450100.450108', '中国.广西壮族自治区.南宁市.良庆区', '1');
INSERT INTO `weiapp_region` VALUES ('450109', '邕宁区', '450100', '86.450000.450100.450109', '中国.广西壮族自治区.南宁市.邕宁区', '1');
INSERT INTO `weiapp_region` VALUES ('450122', '武鸣县', '450100', '86.450000.450100.450122', '中国.广西壮族自治区.南宁市.武鸣县', '1');
INSERT INTO `weiapp_region` VALUES ('450123', '隆安县', '450100', '86.450000.450100.450123', '中国.广西壮族自治区.南宁市.隆安县', '1');
INSERT INTO `weiapp_region` VALUES ('450124', '马山县', '450100', '86.450000.450100.450124', '中国.广西壮族自治区.南宁市.马山县', '1');
INSERT INTO `weiapp_region` VALUES ('450125', '上林县', '450100', '86.450000.450100.450125', '中国.广西壮族自治区.南宁市.上林县', '1');
INSERT INTO `weiapp_region` VALUES ('450126', '宾阳县', '450100', '86.450000.450100.450126', '中国.广西壮族自治区.南宁市.宾阳县', '1');
INSERT INTO `weiapp_region` VALUES ('450127', '横县', '450100', '86.450000.450100.450127', '中国.广西壮族自治区.南宁市.横县', '1');
INSERT INTO `weiapp_region` VALUES ('450202', '城中区', '450200', '86.450000.450200.450202', '中国.广西壮族自治区.柳州市.城中区', '1');
INSERT INTO `weiapp_region` VALUES ('450203', '鱼峰区', '450200', '86.450000.450200.450203', '中国.广西壮族自治区.柳州市.鱼峰区', '1');
INSERT INTO `weiapp_region` VALUES ('450204', '柳南区', '450200', '86.450000.450200.450204', '中国.广西壮族自治区.柳州市.柳南区', '1');
INSERT INTO `weiapp_region` VALUES ('450205', '柳北区', '450200', '86.450000.450200.450205', '中国.广西壮族自治区.柳州市.柳北区', '1');
INSERT INTO `weiapp_region` VALUES ('450221', '柳江县', '450200', '86.450000.450200.450221', '中国.广西壮族自治区.柳州市.柳江县', '1');
INSERT INTO `weiapp_region` VALUES ('450222', '柳城县', '450200', '86.450000.450200.450222', '中国.广西壮族自治区.柳州市.柳城县', '1');
INSERT INTO `weiapp_region` VALUES ('450223', '鹿寨县', '450200', '86.450000.450200.450223', '中国.广西壮族自治区.柳州市.鹿寨县', '1');
INSERT INTO `weiapp_region` VALUES ('450224', '融安县', '450200', '86.450000.450200.450224', '中国.广西壮族自治区.柳州市.融安县', '1');
INSERT INTO `weiapp_region` VALUES ('450225', '融水苗族自治县', '450200', '86.450000.450200.450225', '中国.广西壮族自治区.柳州市.融水苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('450226', '三江侗族自治县', '450200', '86.450000.450200.450226', '中国.广西壮族自治区.柳州市.三江侗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('450302', '秀峰区', '450300', '86.450000.450300.450302', '中国.广西壮族自治区.桂林市.秀峰区', '1');
INSERT INTO `weiapp_region` VALUES ('450303', '叠彩区', '450300', '86.450000.450300.450303', '中国.广西壮族自治区.桂林市.叠彩区', '1');
INSERT INTO `weiapp_region` VALUES ('450304', '象山区', '450300', '86.450000.450300.450304', '中国.广西壮族自治区.桂林市.象山区', '1');
INSERT INTO `weiapp_region` VALUES ('450305', '七星区', '450300', '86.450000.450300.450305', '中国.广西壮族自治区.桂林市.七星区', '1');
INSERT INTO `weiapp_region` VALUES ('450311', '雁山区', '450300', '86.450000.450300.450311', '中国.广西壮族自治区.桂林市.雁山区', '1');
INSERT INTO `weiapp_region` VALUES ('450321', '阳朔县', '450300', '86.450000.450300.450321', '中国.广西壮族自治区.桂林市.阳朔县', '1');
INSERT INTO `weiapp_region` VALUES ('450322', '临桂县', '450300', '86.450000.450300.450322', '中国.广西壮族自治区.桂林市.临桂县', '1');
INSERT INTO `weiapp_region` VALUES ('450323', '灵川县', '450300', '86.450000.450300.450323', '中国.广西壮族自治区.桂林市.灵川县', '1');
INSERT INTO `weiapp_region` VALUES ('450324', '全州县', '450300', '86.450000.450300.450324', '中国.广西壮族自治区.桂林市.全州县', '1');
INSERT INTO `weiapp_region` VALUES ('450325', '兴安县', '450300', '86.450000.450300.450325', '中国.广西壮族自治区.桂林市.兴安县', '1');
INSERT INTO `weiapp_region` VALUES ('450326', '永福县', '450300', '86.450000.450300.450326', '中国.广西壮族自治区.桂林市.永福县', '1');
INSERT INTO `weiapp_region` VALUES ('450327', '灌阳县', '450300', '86.450000.450300.450327', '中国.广西壮族自治区.桂林市.灌阳县', '1');
INSERT INTO `weiapp_region` VALUES ('450328', '龙胜各族自治县', '450300', '86.450000.450300.450328', '中国.广西壮族自治区.桂林市.龙胜各族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('450329', '资源县', '450300', '86.450000.450300.450329', '中国.广西壮族自治区.桂林市.资源县', '1');
INSERT INTO `weiapp_region` VALUES ('450330', '平乐县', '450300', '86.450000.450300.450330', '中国.广西壮族自治区.桂林市.平乐县', '1');
INSERT INTO `weiapp_region` VALUES ('450331', '荔蒲县', '450300', '86.450000.450300.450331', '中国.广西壮族自治区.桂林市.荔蒲县', '1');
INSERT INTO `weiapp_region` VALUES ('450332', '恭城瑶族自治县', '450300', '86.450000.450300.450332', '中国.广西壮族自治区.桂林市.恭城瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('450403', '万秀区', '450400', '86.450000.450400.450403', '中国.广西壮族自治区.梧州市.万秀区', '1');
INSERT INTO `weiapp_region` VALUES ('450404', '蝶山区', '450400', '86.450000.450400.450404', '中国.广西壮族自治区.梧州市.蝶山区', '1');
INSERT INTO `weiapp_region` VALUES ('450405', '长洲区', '450400', '86.450000.450400.450405', '中国.广西壮族自治区.梧州市.长洲区', '1');
INSERT INTO `weiapp_region` VALUES ('450421', '苍梧县', '450400', '86.450000.450400.450421', '中国.广西壮族自治区.梧州市.苍梧县', '1');
INSERT INTO `weiapp_region` VALUES ('450422', '藤县', '450400', '86.450000.450400.450422', '中国.广西壮族自治区.梧州市.藤县', '1');
INSERT INTO `weiapp_region` VALUES ('450423', '蒙山县', '450400', '86.450000.450400.450423', '中国.广西壮族自治区.梧州市.蒙山县', '1');
INSERT INTO `weiapp_region` VALUES ('450481', '岑溪市', '450400', '86.450000.450400.450481', '中国.广西壮族自治区.梧州市.岑溪市', '1');
INSERT INTO `weiapp_region` VALUES ('450502', '海城区', '450500', '86.450000.450500.450502', '中国.广西壮族自治区.北海市.海城区', '1');
INSERT INTO `weiapp_region` VALUES ('450503', '银海区', '450500', '86.450000.450500.450503', '中国.广西壮族自治区.北海市.银海区', '1');
INSERT INTO `weiapp_region` VALUES ('450512', '铁山港区', '450500', '86.450000.450500.450512', '中国.广西壮族自治区.北海市.铁山港区', '1');
INSERT INTO `weiapp_region` VALUES ('450521', '合浦县', '450500', '86.450000.450500.450521', '中国.广西壮族自治区.北海市.合浦县', '1');
INSERT INTO `weiapp_region` VALUES ('450600', '防城港市', '450000', '86.450000.450600', '中国.广西壮族自治区.防城港市', '1');
INSERT INTO `weiapp_region` VALUES ('450602', '港口区', '450600', '86.450000.450600.450602', '中国.广西壮族自治区.防城港市.港口区', '1');
INSERT INTO `weiapp_region` VALUES ('450603', '防城区', '450600', '86.450000.450600.450603', '中国.广西壮族自治区.防城港市.防城区', '1');
INSERT INTO `weiapp_region` VALUES ('450621', '上思县', '450600', '86.450000.450600.450621', '中国.广西壮族自治区.防城港市.上思县', '1');
INSERT INTO `weiapp_region` VALUES ('450681', '东兴市', '450600', '86.450000.450600.450681', '中国.广西壮族自治区.防城港市.东兴市', '1');
INSERT INTO `weiapp_region` VALUES ('450702', '钦南区', '450700', '86.450000.450700.450702', '中国.广西壮族自治区.钦州市.钦南区', '1');
INSERT INTO `weiapp_region` VALUES ('450703', '钦北区', '450700', '86.450000.450700.450703', '中国.广西壮族自治区.钦州市.钦北区', '1');
INSERT INTO `weiapp_region` VALUES ('450721', '灵山县', '450700', '86.450000.450700.450721', '中国.广西壮族自治区.钦州市.灵山县', '1');
INSERT INTO `weiapp_region` VALUES ('450722', '浦北县', '450700', '86.450000.450700.450722', '中国.广西壮族自治区.钦州市.浦北县', '1');
INSERT INTO `weiapp_region` VALUES ('450802', '港北区', '450800', '86.450000.450800.450802', '中国.广西壮族自治区.贵港市.港北区', '1');
INSERT INTO `weiapp_region` VALUES ('450803', '港南区', '450800', '86.450000.450800.450803', '中国.广西壮族自治区.贵港市.港南区', '1');
INSERT INTO `weiapp_region` VALUES ('450804', '覃塘区', '450800', '86.450000.450800.450804', '中国.广西壮族自治区.贵港市.覃塘区', '1');
INSERT INTO `weiapp_region` VALUES ('450821', '平南县', '450800', '86.450000.450800.450821', '中国.广西壮族自治区.贵港市.平南县', '1');
INSERT INTO `weiapp_region` VALUES ('450881', '桂平市', '450800', '86.450000.450800.450881', '中国.广西壮族自治区.贵港市.桂平市', '1');
INSERT INTO `weiapp_region` VALUES ('450902', '玉州区', '450900', '86.450000.450900.450902', '中国.广西壮族自治区.玉林市.玉州区', '1');
INSERT INTO `weiapp_region` VALUES ('450921', '容县', '450900', '86.450000.450900.450921', '中国.广西壮族自治区.玉林市.容县', '1');
INSERT INTO `weiapp_region` VALUES ('450922', '陆川县', '450900', '86.450000.450900.450922', '中国.广西壮族自治区.玉林市.陆川县', '1');
INSERT INTO `weiapp_region` VALUES ('450923', '博白县', '450900', '86.450000.450900.450923', '中国.广西壮族自治区.玉林市.博白县', '1');
INSERT INTO `weiapp_region` VALUES ('450924', '兴业县', '450900', '86.450000.450900.450924', '中国.广西壮族自治区.玉林市.兴业县', '1');
INSERT INTO `weiapp_region` VALUES ('450981', '北流市', '450900', '86.450000.450900.450981', '中国.广西壮族自治区.玉林市.北流市', '1');
INSERT INTO `weiapp_region` VALUES ('451002', '右江区', '451000', '86.450000.451000.451002', '中国.广西壮族自治区.百色市.右江区', '1');
INSERT INTO `weiapp_region` VALUES ('451021', '田阳县', '451000', '86.450000.451000.451021', '中国.广西壮族自治区.百色市.田阳县', '1');
INSERT INTO `weiapp_region` VALUES ('451022', '田东县', '451000', '86.450000.451000.451022', '中国.广西壮族自治区.百色市.田东县', '1');
INSERT INTO `weiapp_region` VALUES ('451023', '平果县', '451000', '86.450000.451000.451023', '中国.广西壮族自治区.百色市.平果县', '1');
INSERT INTO `weiapp_region` VALUES ('451024', '德保县', '451000', '86.450000.451000.451024', '中国.广西壮族自治区.百色市.德保县', '1');
INSERT INTO `weiapp_region` VALUES ('451025', '靖西县', '451000', '86.450000.451000.451025', '中国.广西壮族自治区.百色市.靖西县', '1');
INSERT INTO `weiapp_region` VALUES ('451026', '那坡县', '451000', '86.450000.451000.451026', '中国.广西壮族自治区.百色市.那坡县', '1');
INSERT INTO `weiapp_region` VALUES ('451027', '凌云县', '451000', '86.450000.451000.451027', '中国.广西壮族自治区.百色市.凌云县', '1');
INSERT INTO `weiapp_region` VALUES ('451028', '乐业县', '451000', '86.450000.451000.451028', '中国.广西壮族自治区.百色市.乐业县', '1');
INSERT INTO `weiapp_region` VALUES ('451029', '田林县', '451000', '86.450000.451000.451029', '中国.广西壮族自治区.百色市.田林县', '1');
INSERT INTO `weiapp_region` VALUES ('451030', '西林县', '451000', '86.450000.451000.451030', '中国.广西壮族自治区.百色市.西林县', '1');
INSERT INTO `weiapp_region` VALUES ('451031', '隆林各族自治县', '451000', '86.450000.451000.451031', '中国.广西壮族自治区.百色市.隆林各族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451102', '八步区', '451100', '86.450000.451100.451102', '中国.广西壮族自治区.贺州市.八步区', '1');
INSERT INTO `weiapp_region` VALUES ('451121', '昭平县', '451100', '86.450000.451100.451121', '中国.广西壮族自治区.贺州市.昭平县', '1');
INSERT INTO `weiapp_region` VALUES ('451122', '钟山县', '451100', '86.450000.451100.451122', '中国.广西壮族自治区.贺州市.钟山县', '1');
INSERT INTO `weiapp_region` VALUES ('451123', '富川瑶族自治县', '451100', '86.450000.451100.451123', '中国.广西壮族自治区.贺州市.富川瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451202', '金城江区', '451200', '86.450000.451200.451202', '中国.广西壮族自治区.河池市.金城江区', '1');
INSERT INTO `weiapp_region` VALUES ('451221', '南丹县', '451200', '86.450000.451200.451221', '中国.广西壮族自治区.河池市.南丹县', '1');
INSERT INTO `weiapp_region` VALUES ('451222', '天峨县', '451200', '86.450000.451200.451222', '中国.广西壮族自治区.河池市.天峨县', '1');
INSERT INTO `weiapp_region` VALUES ('451223', '凤山县', '451200', '86.450000.451200.451223', '中国.广西壮族自治区.河池市.凤山县', '1');
INSERT INTO `weiapp_region` VALUES ('451224', '东兰县', '451200', '86.450000.451200.451224', '中国.广西壮族自治区.河池市.东兰县', '1');
INSERT INTO `weiapp_region` VALUES ('451225', '罗城仫佬族自治县', '451200', '86.450000.451200.451225', '中国.广西壮族自治区.河池市.罗城仫佬族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451226', '环江毛南族自治县', '451200', '86.450000.451200.451226', '中国.广西壮族自治区.河池市.环江毛南族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451227', '巴马瑶族自治县', '451200', '86.450000.451200.451227', '中国.广西壮族自治区.河池市.巴马瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451228', '都安瑶族自治县', '451200', '86.450000.451200.451228', '中国.广西壮族自治区.河池市.都安瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451229', '大化瑶族自治县', '451200', '86.450000.451200.451229', '中国.广西壮族自治区.河池市.大化瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451281', '宜州市', '451200', '86.450000.451200.451281', '中国.广西壮族自治区.河池市.宜州市', '1');
INSERT INTO `weiapp_region` VALUES ('451302', '兴宾区', '451300', '86.450000.451300.451302', '中国.广西壮族自治区.来宾市.兴宾区', '1');
INSERT INTO `weiapp_region` VALUES ('451321', '忻城县', '451300', '86.450000.451300.451321', '中国.广西壮族自治区.来宾市.忻城县', '1');
INSERT INTO `weiapp_region` VALUES ('451322', '象州县', '451300', '86.450000.451300.451322', '中国.广西壮族自治区.来宾市.象州县', '1');
INSERT INTO `weiapp_region` VALUES ('451323', '武宣县', '451300', '86.450000.451300.451323', '中国.广西壮族自治区.来宾市.武宣县', '1');
INSERT INTO `weiapp_region` VALUES ('451324', '金秀瑶族自治县', '451300', '86.450000.451300.451324', '中国.广西壮族自治区.来宾市.金秀瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('451381', '合山市', '451300', '86.450000.451300.451381', '中国.广西壮族自治区.来宾市.合山市', '1');
INSERT INTO `weiapp_region` VALUES ('451402', '江洲区', '451400', '86.450000.451400.451402', '中国.广西壮族自治区.崇左市.江洲区', '1');
INSERT INTO `weiapp_region` VALUES ('451421', '扶绥县', '451400', '86.450000.451400.451421', '中国.广西壮族自治区.崇左市.扶绥县', '1');
INSERT INTO `weiapp_region` VALUES ('451422', '宁明县', '451400', '86.450000.451400.451422', '中国.广西壮族自治区.崇左市.宁明县', '1');
INSERT INTO `weiapp_region` VALUES ('451423', '龙州县', '451400', '86.450000.451400.451423', '中国.广西壮族自治区.崇左市.龙州县', '1');
INSERT INTO `weiapp_region` VALUES ('451424', '大新县', '451400', '86.450000.451400.451424', '中国.广西壮族自治区.崇左市.大新县', '1');
INSERT INTO `weiapp_region` VALUES ('451425', '天等县', '451400', '86.450000.451400.451425', '中国.广西壮族自治区.崇左市.天等县', '1');
INSERT INTO `weiapp_region` VALUES ('451481', '凭祥市', '451400', '86.450000.451400.451481', '中国.广西壮族自治区.崇左市.凭祥市', '1');
INSERT INTO `weiapp_region` VALUES ('460105', '秀英区', '460100', '86.460000.460100.460105', '中国.海南省.海口市.秀英区', '1');
INSERT INTO `weiapp_region` VALUES ('460106', '龙华区', '460100', '86.460000.460100.460106', '中国.海南省.海口市.龙华区', '1');
INSERT INTO `weiapp_region` VALUES ('460107', '琼山区', '460100', '86.460000.460100.460107', '中国.海南省.海口市.琼山区', '1');
INSERT INTO `weiapp_region` VALUES ('460108', '美兰区', '460100', '86.460000.460100.460108', '中国.海南省.海口市.美兰区', '1');
INSERT INTO `weiapp_region` VALUES ('469000', '省直辖县级行政区划', '460000', '86.460000.469000', '中国.海南省.省直辖县级行政区划', '1');
INSERT INTO `weiapp_region` VALUES ('469001', '五指山市', '469000', '86.460000.469000.469001', '中国.海南省.省直辖县级行政区划.五指山市', '1');
INSERT INTO `weiapp_region` VALUES ('469002', '琼海市', '469000', '86.460000.469000.469002', '中国.海南省.省直辖县级行政区划.琼海市', '1');
INSERT INTO `weiapp_region` VALUES ('469003', '儋州市', '469000', '86.460000.469000.469003', '中国.海南省.省直辖县级行政区划.儋州市', '1');
INSERT INTO `weiapp_region` VALUES ('469005', '文昌市', '469000', '86.460000.469000.469005', '中国.海南省.省直辖县级行政区划.文昌市', '1');
INSERT INTO `weiapp_region` VALUES ('469006', '万宁市', '469000', '86.460000.469000.469006', '中国.海南省.省直辖县级行政区划.万宁市', '1');
INSERT INTO `weiapp_region` VALUES ('469007', '东方市', '469000', '86.460000.469000.469007', '中国.海南省.省直辖县级行政区划.东方市', '1');
INSERT INTO `weiapp_region` VALUES ('469021', '定安县', '469000', '86.460000.469000.469021', '中国.海南省.省直辖县级行政区划.定安县', '1');
INSERT INTO `weiapp_region` VALUES ('469022', '屯昌县', '469000', '86.460000.469000.469022', '中国.海南省.省直辖县级行政区划.屯昌县', '1');
INSERT INTO `weiapp_region` VALUES ('469023', '澄迈县', '469000', '86.460000.469000.469023', '中国.海南省.省直辖县级行政区划.澄迈县', '1');
INSERT INTO `weiapp_region` VALUES ('469024', '临高县', '469000', '86.460000.469000.469024', '中国.海南省.省直辖县级行政区划.临高县', '1');
INSERT INTO `weiapp_region` VALUES ('469025', '白沙黎族自治县', '469000', '86.460000.469000.469025', '中国.海南省.省直辖县级行政区划.白沙黎族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('469026', '昌江黎族自治县', '469000', '86.460000.469000.469026', '中国.海南省.省直辖县级行政区划.昌江黎族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('469027', '乐东黎族自治县', '469000', '86.460000.469000.469027', '中国.海南省.省直辖县级行政区划.乐东黎族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('469028', '陵水黎族自治县', '469000', '86.460000.469000.469028', '中国.海南省.省直辖县级行政区划.陵水黎族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('469029', '保亭黎族苗族自治县', '469000', '86.460000.469000.469029', '中国.海南省.省直辖县级行政区划.保亭黎族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('469030', '琼中黎族苗族自治县', '469000', '86.460000.469000.469030', '中国.海南省.省直辖县级行政区划.琼中黎族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('469031', '西沙群岛', '469000', '86.460000.469000.469031', '中国.海南省.省直辖县级行政区划.西沙群岛', '1');
INSERT INTO `weiapp_region` VALUES ('469032', '南沙群岛', '469000', '86.460000.469000.469032', '中国.海南省.省直辖县级行政区划.南沙群岛', '1');
INSERT INTO `weiapp_region` VALUES ('469033', '中沙群岛的岛礁及其海域', '469000', '86.460000.469000.469033', '中国.海南省.省直辖县级行政区划.中沙群岛的岛礁及其海域', '1');
INSERT INTO `weiapp_region` VALUES ('500241', '秀山土家族苗族自治县', '500000', '86.500000.500241', '中国.重庆市.秀山土家族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('500242', '酉阳土家族苗族自治县', '500000', '86.500000.500242', '中国.重庆市.酉阳土家族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('500243', '彭水苗族土家族自治县', '500000', '86.500000.500243', '中国.重庆市.彭水苗族土家族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('510112', '龙泉驿区', '510100', '86.510000.510100.510112', '中国.四川省.成都市.龙泉驿区', '1');
INSERT INTO `weiapp_region` VALUES ('510113', '青白江区', '510100', '86.510000.510100.510113', '中国.四川省.成都市.青白江区', '1');
INSERT INTO `weiapp_region` VALUES ('510114', '新都区', '510100', '86.510000.510100.510114', '中国.四川省.成都市.新都区', '1');
INSERT INTO `weiapp_region` VALUES ('510115', '温江区', '510100', '86.510000.510100.510115', '中国.四川省.成都市.温江区', '1');
INSERT INTO `weiapp_region` VALUES ('510121', '金堂县', '510100', '86.510000.510100.510121', '中国.四川省.成都市.金堂县', '1');
INSERT INTO `weiapp_region` VALUES ('510122', '双流县', '510100', '86.510000.510100.510122', '中国.四川省.成都市.双流县', '1');
INSERT INTO `weiapp_region` VALUES ('510129', '大邑县', '510100', '86.510000.510100.510129', '中国.四川省.成都市.大邑县', '1');
INSERT INTO `weiapp_region` VALUES ('510131', '蒲江县', '510100', '86.510000.510100.510131', '中国.四川省.成都市.蒲江县', '1');
INSERT INTO `weiapp_region` VALUES ('510181', '都江堰市', '510100', '86.510000.510100.510181', '中国.四川省.成都市.都江堰市', '1');
INSERT INTO `weiapp_region` VALUES ('510132', '新津县', '510100', '86.510000.510100.510132', '中国.四川省.成都市.新津县', '1');
INSERT INTO `weiapp_region` VALUES ('510182', '彭州市', '510100', '86.510000.510100.510182', '中国.四川省.成都市.彭州市', '1');
INSERT INTO `weiapp_region` VALUES ('510183', '邛崃市', '510100', '86.510000.510100.510183', '中国.四川省.成都市.邛崃市', '1');
INSERT INTO `weiapp_region` VALUES ('510184', '崇州市', '510100', '86.510000.510100.510184', '中国.四川省.成都市.崇州市', '1');
INSERT INTO `weiapp_region` VALUES ('510302', '自流井区', '510300', '86.510000.510300.510302', '中国.四川省.自贡市.自流井区', '1');
INSERT INTO `weiapp_region` VALUES ('510303', '贡井区', '510300', '86.510000.510300.510303', '中国.四川省.自贡市.贡井区', '1');
INSERT INTO `weiapp_region` VALUES ('510304', '大安区', '510300', '86.510000.510300.510304', '中国.四川省.自贡市.大安区', '1');
INSERT INTO `weiapp_region` VALUES ('510311', '沿滩区', '510300', '86.510000.510300.510311', '中国.四川省.自贡市.沿滩区', '1');
INSERT INTO `weiapp_region` VALUES ('510322', '富顺县', '510300', '86.510000.510300.510322', '中国.四川省.自贡市.富顺县', '1');
INSERT INTO `weiapp_region` VALUES ('510402', '东区', '510400', '86.510000.510400.510402', '中国.四川省.攀枝花市.东区', '1');
INSERT INTO `weiapp_region` VALUES ('510403', '西区', '510400', '86.510000.510400.510403', '中国.四川省.攀枝花市.西区', '1');
INSERT INTO `weiapp_region` VALUES ('510411', '仁和区', '510400', '86.510000.510400.510411', '中国.四川省.攀枝花市.仁和区', '1');
INSERT INTO `weiapp_region` VALUES ('510421', '米易县', '510400', '86.510000.510400.510421', '中国.四川省.攀枝花市.米易县', '1');
INSERT INTO `weiapp_region` VALUES ('510422', '盐边县', '510400', '86.510000.510400.510422', '中国.四川省.攀枝花市.盐边县', '1');
INSERT INTO `weiapp_region` VALUES ('510502', '江阳区', '510500', '86.510000.510500.510502', '中国.四川省.泸州市.江阳区', '1');
INSERT INTO `weiapp_region` VALUES ('510503', '纳溪区', '510500', '86.510000.510500.510503', '中国.四川省.泸州市.纳溪区', '1');
INSERT INTO `weiapp_region` VALUES ('510504', '龙马潭区', '510500', '86.510000.510500.510504', '中国.四川省.泸州市.龙马潭区', '1');
INSERT INTO `weiapp_region` VALUES ('510522', '合江县', '510500', '86.510000.510500.510522', '中国.四川省.泸州市.合江县', '1');
INSERT INTO `weiapp_region` VALUES ('510524', '叙永县', '510500', '86.510000.510500.510524', '中国.四川省.泸州市.叙永县', '1');
INSERT INTO `weiapp_region` VALUES ('510525', '古蔺县', '510500', '86.510000.510500.510525', '中国.四川省.泸州市.古蔺县', '1');
INSERT INTO `weiapp_region` VALUES ('510603', '旌阳区', '510600', '86.510000.510600.510603', '中国.四川省.德阳市.旌阳区', '1');
INSERT INTO `weiapp_region` VALUES ('510623', '中江县', '510600', '86.510000.510600.510623', '中国.四川省.德阳市.中江县', '1');
INSERT INTO `weiapp_region` VALUES ('510626', '罗江县', '510600', '86.510000.510600.510626', '中国.四川省.德阳市.罗江县', '1');
INSERT INTO `weiapp_region` VALUES ('510681', '广汉市', '510600', '86.510000.510600.510681', '中国.四川省.德阳市.广汉市', '1');
INSERT INTO `weiapp_region` VALUES ('510682', '什邡市', '510600', '86.510000.510600.510682', '中国.四川省.德阳市.什邡市', '1');
INSERT INTO `weiapp_region` VALUES ('510683', '绵竹市', '510600', '86.510000.510600.510683', '中国.四川省.德阳市.绵竹市', '1');
INSERT INTO `weiapp_region` VALUES ('510703', '涪城区', '510700', '86.510000.510700.510703', '中国.四川省.绵阳市.涪城区', '1');
INSERT INTO `weiapp_region` VALUES ('510704', '游仙区', '510700', '86.510000.510700.510704', '中国.四川省.绵阳市.游仙区', '1');
INSERT INTO `weiapp_region` VALUES ('510722', '三台县', '510700', '86.510000.510700.510722', '中国.四川省.绵阳市.三台县', '1');
INSERT INTO `weiapp_region` VALUES ('510723', '盐亭县', '510700', '86.510000.510700.510723', '中国.四川省.绵阳市.盐亭县', '1');
INSERT INTO `weiapp_region` VALUES ('510725', '梓潼县', '510700', '86.510000.510700.510725', '中国.四川省.绵阳市.梓潼县', '1');
INSERT INTO `weiapp_region` VALUES ('510726', '北川羌族自治县', '510700', '86.510000.510700.510726', '中国.四川省.绵阳市.北川羌族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('510727', '平武县', '510700', '86.510000.510700.510727', '中国.四川省.绵阳市.平武县', '1');
INSERT INTO `weiapp_region` VALUES ('510781', '江油市', '510700', '86.510000.510700.510781', '中国.四川省.绵阳市.江油市', '1');
INSERT INTO `weiapp_region` VALUES ('510811', '元坝区', '510800', '86.510000.510800.510811', '中国.四川省.广元市.元坝区', '1');
INSERT INTO `weiapp_region` VALUES ('510812', '朝天区', '510800', '86.510000.510800.510812', '中国.四川省.广元市.朝天区', '1');
INSERT INTO `weiapp_region` VALUES ('510821', '旺苍县', '510800', '86.510000.510800.510821', '中国.四川省.广元市.旺苍县', '1');
INSERT INTO `weiapp_region` VALUES ('510822', '青川县', '510800', '86.510000.510800.510822', '中国.四川省.广元市.青川县', '1');
INSERT INTO `weiapp_region` VALUES ('510823', '剑阁县', '510800', '86.510000.510800.510823', '中国.四川省.广元市.剑阁县', '1');
INSERT INTO `weiapp_region` VALUES ('510824', '苍溪县', '510800', '86.510000.510800.510824', '中国.四川省.广元市.苍溪县', '1');
INSERT INTO `weiapp_region` VALUES ('510903', '船山区', '510900', '86.510000.510900.510903', '中国.四川省.遂宁市.船山区', '1');
INSERT INTO `weiapp_region` VALUES ('510904', '安居区', '510900', '86.510000.510900.510904', '中国.四川省.遂宁市.安居区', '1');
INSERT INTO `weiapp_region` VALUES ('510921', '蓬溪县', '510900', '86.510000.510900.510921', '中国.四川省.遂宁市.蓬溪县', '1');
INSERT INTO `weiapp_region` VALUES ('510922', '射洪县', '510900', '86.510000.510900.510922', '中国.四川省.遂宁市.射洪县', '1');
INSERT INTO `weiapp_region` VALUES ('510923', '大英县', '510900', '86.510000.510900.510923', '中国.四川省.遂宁市.大英县', '1');
INSERT INTO `weiapp_region` VALUES ('511002', '市中区', '511000', '86.510000.511000.511002', '中国.四川省.内江市.市中区', '1');
INSERT INTO `weiapp_region` VALUES ('511011', '东兴区', '511000', '86.510000.511000.511011', '中国.四川省.内江市.东兴区', '1');
INSERT INTO `weiapp_region` VALUES ('511024', '威远县', '511000', '86.510000.511000.511024', '中国.四川省.内江市.威远县', '1');
INSERT INTO `weiapp_region` VALUES ('511025', '资中县', '511000', '86.510000.511000.511025', '中国.四川省.内江市.资中县', '1');
INSERT INTO `weiapp_region` VALUES ('511028', '隆昌县', '511000', '86.510000.511000.511028', '中国.四川省.内江市.隆昌县', '1');
INSERT INTO `weiapp_region` VALUES ('511102', '市中区', '511100', '86.510000.511100.511102', '中国.四川省.乐山市.市中区', '1');
INSERT INTO `weiapp_region` VALUES ('511111', '沙湾区', '511100', '86.510000.511100.511111', '中国.四川省.乐山市.沙湾区', '1');
INSERT INTO `weiapp_region` VALUES ('511112', '五通桥区', '511100', '86.510000.511100.511112', '中国.四川省.乐山市.五通桥区', '1');
INSERT INTO `weiapp_region` VALUES ('511113', '金口河区', '511100', '86.510000.511100.511113', '中国.四川省.乐山市.金口河区', '1');
INSERT INTO `weiapp_region` VALUES ('511123', '犍为县', '511100', '86.510000.511100.511123', '中国.四川省.乐山市.犍为县', '1');
INSERT INTO `weiapp_region` VALUES ('511124', '井研县', '511100', '86.510000.511100.511124', '中国.四川省.乐山市.井研县', '1');
INSERT INTO `weiapp_region` VALUES ('511126', '夹江县', '511100', '86.510000.511100.511126', '中国.四川省.乐山市.夹江县', '1');
INSERT INTO `weiapp_region` VALUES ('511129', '沐川县', '511100', '86.510000.511100.511129', '中国.四川省.乐山市.沐川县', '1');
INSERT INTO `weiapp_region` VALUES ('511132', '峨边彝族自治县', '511100', '86.510000.511100.511132', '中国.四川省.乐山市.峨边彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('511133', '马边彝族自治县', '511100', '86.510000.511100.511133', '中国.四川省.乐山市.马边彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('511181', '峨眉山市', '511100', '86.510000.511100.511181', '中国.四川省.乐山市.峨眉山市', '1');
INSERT INTO `weiapp_region` VALUES ('511302', '顺庆区', '511300', '86.510000.511300.511302', '中国.四川省.南充市.顺庆区', '1');
INSERT INTO `weiapp_region` VALUES ('511303', '高坪区', '511300', '86.510000.511300.511303', '中国.四川省.南充市.高坪区', '1');
INSERT INTO `weiapp_region` VALUES ('511304', '嘉陵区', '511300', '86.510000.511300.511304', '中国.四川省.南充市.嘉陵区', '1');
INSERT INTO `weiapp_region` VALUES ('511321', '南部县', '511300', '86.510000.511300.511321', '中国.四川省.南充市.南部县', '1');
INSERT INTO `weiapp_region` VALUES ('511322', '营山县', '511300', '86.510000.511300.511322', '中国.四川省.南充市.营山县', '1');
INSERT INTO `weiapp_region` VALUES ('511323', '蓬安县', '511300', '86.510000.511300.511323', '中国.四川省.南充市.蓬安县', '1');
INSERT INTO `weiapp_region` VALUES ('511324', '仪陇县', '511300', '86.510000.511300.511324', '中国.四川省.南充市.仪陇县', '1');
INSERT INTO `weiapp_region` VALUES ('511325', '西充县', '511300', '86.510000.511300.511325', '中国.四川省.南充市.西充县', '1');
INSERT INTO `weiapp_region` VALUES ('511381', '阆中市', '511300', '86.510000.511300.511381', '中国.四川省.南充市.阆中市', '1');
INSERT INTO `weiapp_region` VALUES ('511402', '东坡区', '511400', '86.510000.511400.511402', '中国.四川省.眉山市.东坡区', '1');
INSERT INTO `weiapp_region` VALUES ('511421', '仁寿县', '511400', '86.510000.511400.511421', '中国.四川省.眉山市.仁寿县', '1');
INSERT INTO `weiapp_region` VALUES ('511422', '彭山县', '511400', '86.510000.511400.511422', '中国.四川省.眉山市.彭山县', '1');
INSERT INTO `weiapp_region` VALUES ('511423', '洪雅县', '511400', '86.510000.511400.511423', '中国.四川省.眉山市.洪雅县', '1');
INSERT INTO `weiapp_region` VALUES ('511424', '丹棱县', '511400', '86.510000.511400.511424', '中国.四川省.眉山市.丹棱县', '1');
INSERT INTO `weiapp_region` VALUES ('511425', '青神县', '511400', '86.510000.511400.511425', '中国.四川省.眉山市.青神县', '1');
INSERT INTO `weiapp_region` VALUES ('511502', '翠屏区', '511500', '86.510000.511500.511502', '中国.四川省.宜宾市.翠屏区', '1');
INSERT INTO `weiapp_region` VALUES ('511503', '南溪区', '511500', '86.510000.511500.511503', '中国.四川省.宜宾市.南溪区', '1');
INSERT INTO `weiapp_region` VALUES ('511521', '宜宾县', '511500', '86.510000.511500.511521', '中国.四川省.宜宾市.宜宾县', '1');
INSERT INTO `weiapp_region` VALUES ('511523', '江安县', '511500', '86.510000.511500.511523', '中国.四川省.宜宾市.江安县', '1');
INSERT INTO `weiapp_region` VALUES ('511524', '长宁县', '511500', '86.510000.511500.511524', '中国.四川省.宜宾市.长宁县', '1');
INSERT INTO `weiapp_region` VALUES ('511527', '筠连县', '511500', '86.510000.511500.511527', '中国.四川省.宜宾市.筠连县', '1');
INSERT INTO `weiapp_region` VALUES ('511528', '兴文县', '511500', '86.510000.511500.511528', '中国.四川省.宜宾市.兴文县', '1');
INSERT INTO `weiapp_region` VALUES ('511529', '屏山县', '511500', '86.510000.511500.511529', '中国.四川省.宜宾市.屏山县', '1');
INSERT INTO `weiapp_region` VALUES ('511602', '广安区', '511600', '86.510000.511600.511602', '中国.四川省.广安市.广安区', '1');
INSERT INTO `weiapp_region` VALUES ('511621', '岳池县', '511600', '86.510000.511600.511621', '中国.四川省.广安市.岳池县', '1');
INSERT INTO `weiapp_region` VALUES ('511622', '武胜县', '511600', '86.510000.511600.511622', '中国.四川省.广安市.武胜县', '1');
INSERT INTO `weiapp_region` VALUES ('511623', '邻水县', '511600', '86.510000.511600.511623', '中国.四川省.广安市.邻水县', '1');
INSERT INTO `weiapp_region` VALUES ('511681', '华蓥市', '511600', '86.510000.511600.511681', '中国.四川省.广安市.华蓥市', '1');
INSERT INTO `weiapp_region` VALUES ('511702', '通川区', '511700', '86.510000.511700.511702', '中国.四川省.达州市.通川区', '1');
INSERT INTO `weiapp_region` VALUES ('511722', '宣汉县', '511700', '86.510000.511700.511722', '中国.四川省.达州市.宣汉县', '1');
INSERT INTO `weiapp_region` VALUES ('511723', '开江县', '511700', '86.510000.511700.511723', '中国.四川省.达州市.开江县', '1');
INSERT INTO `weiapp_region` VALUES ('511724', '大竹县', '511700', '86.510000.511700.511724', '中国.四川省.达州市.大竹县', '1');
INSERT INTO `weiapp_region` VALUES ('511781', '万源市', '511700', '86.510000.511700.511781', '中国.四川省.达州市.万源市', '1');
INSERT INTO `weiapp_region` VALUES ('511802', '雨城区', '511800', '86.510000.511800.511802', '中国.四川省.雅安市.雨城区', '1');
INSERT INTO `weiapp_region` VALUES ('511821', '名山县', '511800', '86.510000.511800.511821', '中国.四川省.雅安市.名山县', '1');
INSERT INTO `weiapp_region` VALUES ('511822', '荥经县', '511800', '86.510000.511800.511822', '中国.四川省.雅安市.荥经县', '1');
INSERT INTO `weiapp_region` VALUES ('511823', '汉源县', '511800', '86.510000.511800.511823', '中国.四川省.雅安市.汉源县', '1');
INSERT INTO `weiapp_region` VALUES ('511824', '石棉县', '511800', '86.510000.511800.511824', '中国.四川省.雅安市.石棉县', '1');
INSERT INTO `weiapp_region` VALUES ('511825', '天全县', '511800', '86.510000.511800.511825', '中国.四川省.雅安市.天全县', '1');
INSERT INTO `weiapp_region` VALUES ('511826', '芦山县', '511800', '86.510000.511800.511826', '中国.四川省.雅安市.芦山县', '1');
INSERT INTO `weiapp_region` VALUES ('511827', '宝兴县', '511800', '86.510000.511800.511827', '中国.四川省.雅安市.宝兴县', '1');
INSERT INTO `weiapp_region` VALUES ('511902', '巴州区', '511900', '86.510000.511900.511902', '中国.四川省.巴中市.巴州区', '1');
INSERT INTO `weiapp_region` VALUES ('511921', '通江县', '511900', '86.510000.511900.511921', '中国.四川省.巴中市.通江县', '1');
INSERT INTO `weiapp_region` VALUES ('511922', '南江县', '511900', '86.510000.511900.511922', '中国.四川省.巴中市.南江县', '1');
INSERT INTO `weiapp_region` VALUES ('511923', '平昌县', '511900', '86.510000.511900.511923', '中国.四川省.巴中市.平昌县', '1');
INSERT INTO `weiapp_region` VALUES ('512002', '雁江区', '512000', '86.510000.512000.512002', '中国.四川省.资阳市.雁江区', '1');
INSERT INTO `weiapp_region` VALUES ('512021', '安岳县', '512000', '86.510000.512000.512021', '中国.四川省.资阳市.安岳县', '1');
INSERT INTO `weiapp_region` VALUES ('512022', '乐至县', '512000', '86.510000.512000.512022', '中国.四川省.资阳市.乐至县', '1');
INSERT INTO `weiapp_region` VALUES ('512081', '简阳市', '512000', '86.510000.512000.512081', '中国.四川省.资阳市.简阳市', '1');
INSERT INTO `weiapp_region` VALUES ('513200', '阿坝藏族羌族自治州', '510000', '86.510000.513200', '中国.四川省.阿坝藏族羌族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('513221', '汶川县', '513200', '86.510000.513200.513221', '中国.四川省.阿坝藏族羌族自治州.汶川县', '1');
INSERT INTO `weiapp_region` VALUES ('513222', '理县', '513200', '86.510000.513200.513222', '中国.四川省.阿坝藏族羌族自治州.理县', '1');
INSERT INTO `weiapp_region` VALUES ('513223', '茂县', '513200', '86.510000.513200.513223', '中国.四川省.阿坝藏族羌族自治州.茂县', '1');
INSERT INTO `weiapp_region` VALUES ('513224', '松潘县', '513200', '86.510000.513200.513224', '中国.四川省.阿坝藏族羌族自治州.松潘县', '1');
INSERT INTO `weiapp_region` VALUES ('513225', '九寨沟县', '513200', '86.510000.513200.513225', '中国.四川省.阿坝藏族羌族自治州.九寨沟县', '1');
INSERT INTO `weiapp_region` VALUES ('513226', '金川县', '513200', '86.510000.513200.513226', '中国.四川省.阿坝藏族羌族自治州.金川县', '1');
INSERT INTO `weiapp_region` VALUES ('513227', '小金县', '513200', '86.510000.513200.513227', '中国.四川省.阿坝藏族羌族自治州.小金县', '1');
INSERT INTO `weiapp_region` VALUES ('513228', '黑水县', '513200', '86.510000.513200.513228', '中国.四川省.阿坝藏族羌族自治州.黑水县', '1');
INSERT INTO `weiapp_region` VALUES ('513229', '马尔康县', '513200', '86.510000.513200.513229', '中国.四川省.阿坝藏族羌族自治州.马尔康县', '1');
INSERT INTO `weiapp_region` VALUES ('513230', '壤塘县', '513200', '86.510000.513200.513230', '中国.四川省.阿坝藏族羌族自治州.壤塘县', '1');
INSERT INTO `weiapp_region` VALUES ('513231', '阿坝县', '513200', '86.510000.513200.513231', '中国.四川省.阿坝藏族羌族自治州.阿坝县', '1');
INSERT INTO `weiapp_region` VALUES ('513232', '若尔盖县', '513200', '86.510000.513200.513232', '中国.四川省.阿坝藏族羌族自治州.若尔盖县', '1');
INSERT INTO `weiapp_region` VALUES ('513233', '红原县', '513200', '86.510000.513200.513233', '中国.四川省.阿坝藏族羌族自治州.红原县', '1');
INSERT INTO `weiapp_region` VALUES ('513300', '甘孜藏族自治州', '510000', '86.510000.513300', '中国.四川省.甘孜藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('513321', '康定县', '513300', '86.510000.513300.513321', '中国.四川省.甘孜藏族自治州.康定县', '1');
INSERT INTO `weiapp_region` VALUES ('513322', '泸定县', '513300', '86.510000.513300.513322', '中国.四川省.甘孜藏族自治州.泸定县', '1');
INSERT INTO `weiapp_region` VALUES ('513323', '丹巴县', '513300', '86.510000.513300.513323', '中国.四川省.甘孜藏族自治州.丹巴县', '1');
INSERT INTO `weiapp_region` VALUES ('513324', '九龙县', '513300', '86.510000.513300.513324', '中国.四川省.甘孜藏族自治州.九龙县', '1');
INSERT INTO `weiapp_region` VALUES ('513325', '雅江县', '513300', '86.510000.513300.513325', '中国.四川省.甘孜藏族自治州.雅江县', '1');
INSERT INTO `weiapp_region` VALUES ('513326', '道孚县', '513300', '86.510000.513300.513326', '中国.四川省.甘孜藏族自治州.道孚县', '1');
INSERT INTO `weiapp_region` VALUES ('513327', '炉霍县', '513300', '86.510000.513300.513327', '中国.四川省.甘孜藏族自治州.炉霍县', '1');
INSERT INTO `weiapp_region` VALUES ('513328', '甘孜县', '513300', '86.510000.513300.513328', '中国.四川省.甘孜藏族自治州.甘孜县', '1');
INSERT INTO `weiapp_region` VALUES ('513329', '新龙县', '513300', '86.510000.513300.513329', '中国.四川省.甘孜藏族自治州.新龙县', '1');
INSERT INTO `weiapp_region` VALUES ('513330', '德格县', '513300', '86.510000.513300.513330', '中国.四川省.甘孜藏族自治州.德格县', '1');
INSERT INTO `weiapp_region` VALUES ('513331', '白玉县', '513300', '86.510000.513300.513331', '中国.四川省.甘孜藏族自治州.白玉县', '1');
INSERT INTO `weiapp_region` VALUES ('513332', '石渠县', '513300', '86.510000.513300.513332', '中国.四川省.甘孜藏族自治州.石渠县', '1');
INSERT INTO `weiapp_region` VALUES ('513333', '色达县', '513300', '86.510000.513300.513333', '中国.四川省.甘孜藏族自治州.色达县', '1');
INSERT INTO `weiapp_region` VALUES ('513334', '理塘县', '513300', '86.510000.513300.513334', '中国.四川省.甘孜藏族自治州.理塘县', '1');
INSERT INTO `weiapp_region` VALUES ('513335', '巴塘县', '513300', '86.510000.513300.513335', '中国.四川省.甘孜藏族自治州.巴塘县', '1');
INSERT INTO `weiapp_region` VALUES ('513336', '乡城县', '513300', '86.510000.513300.513336', '中国.四川省.甘孜藏族自治州.乡城县', '1');
INSERT INTO `weiapp_region` VALUES ('513337', '稻城县', '513300', '86.510000.513300.513337', '中国.四川省.甘孜藏族自治州.稻城县', '1');
INSERT INTO `weiapp_region` VALUES ('513338', '得荣县', '513300', '86.510000.513300.513338', '中国.四川省.甘孜藏族自治州.得荣县', '1');
INSERT INTO `weiapp_region` VALUES ('513400', '凉山彝族自治州', '510000', '86.510000.513400', '中国.四川省.凉山彝族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('513401', '西昌市', '513400', '86.510000.513400.513401', '中国.四川省.凉山彝族自治州.西昌市', '1');
INSERT INTO `weiapp_region` VALUES ('513422', '木里藏族自治县', '513400', '86.510000.513400.513422', '中国.四川省.凉山彝族自治州.木里藏族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('513423', '盐源县', '513400', '86.510000.513400.513423', '中国.四川省.凉山彝族自治州.盐源县', '1');
INSERT INTO `weiapp_region` VALUES ('513424', '德昌县', '513400', '86.510000.513400.513424', '中国.四川省.凉山彝族自治州.德昌县', '1');
INSERT INTO `weiapp_region` VALUES ('513425', '会理县', '513400', '86.510000.513400.513425', '中国.四川省.凉山彝族自治州.会理县', '1');
INSERT INTO `weiapp_region` VALUES ('513426', '会东县', '513400', '86.510000.513400.513426', '中国.四川省.凉山彝族自治州.会东县', '1');
INSERT INTO `weiapp_region` VALUES ('513427', '宁南县', '513400', '86.510000.513400.513427', '中国.四川省.凉山彝族自治州.宁南县', '1');
INSERT INTO `weiapp_region` VALUES ('513428', '普格县', '513400', '86.510000.513400.513428', '中国.四川省.凉山彝族自治州.普格县', '1');
INSERT INTO `weiapp_region` VALUES ('513429', '布拖县', '513400', '86.510000.513400.513429', '中国.四川省.凉山彝族自治州.布拖县', '1');
INSERT INTO `weiapp_region` VALUES ('513430', '金阳县', '513400', '86.510000.513400.513430', '中国.四川省.凉山彝族自治州.金阳县', '1');
INSERT INTO `weiapp_region` VALUES ('513431', '昭觉县', '513400', '86.510000.513400.513431', '中国.四川省.凉山彝族自治州.昭觉县', '1');
INSERT INTO `weiapp_region` VALUES ('513432', '喜德县', '513400', '86.510000.513400.513432', '中国.四川省.凉山彝族自治州.喜德县', '1');
INSERT INTO `weiapp_region` VALUES ('513433', '冕宁县', '513400', '86.510000.513400.513433', '中国.四川省.凉山彝族自治州.冕宁县', '1');
INSERT INTO `weiapp_region` VALUES ('513434', '越西县', '513400', '86.510000.513400.513434', '中国.四川省.凉山彝族自治州.越西县', '1');
INSERT INTO `weiapp_region` VALUES ('513435', '甘洛县', '513400', '86.510000.513400.513435', '中国.四川省.凉山彝族自治州.甘洛县', '1');
INSERT INTO `weiapp_region` VALUES ('513436', '美姑县', '513400', '86.510000.513400.513436', '中国.四川省.凉山彝族自治州.美姑县', '1');
INSERT INTO `weiapp_region` VALUES ('513437', '雷波县', '513400', '86.510000.513400.513437', '中国.四川省.凉山彝族自治州.雷波县', '1');
INSERT INTO `weiapp_region` VALUES ('520102', '南明区', '520100', '86.520000.520100.520102', '中国.贵州省.贵阳市.南明区', '1');
INSERT INTO `weiapp_region` VALUES ('520103', '云岩区', '520100', '86.520000.520100.520103', '中国.贵州省.贵阳市.云岩区', '1');
INSERT INTO `weiapp_region` VALUES ('520111', '花溪区', '520100', '86.520000.520100.520111', '中国.贵州省.贵阳市.花溪区', '1');
INSERT INTO `weiapp_region` VALUES ('520112', '乌当区', '520100', '86.520000.520100.520112', '中国.贵州省.贵阳市.乌当区', '1');
INSERT INTO `weiapp_region` VALUES ('520113', '白云区', '520100', '86.520000.520100.520113', '中国.贵州省.贵阳市.白云区', '1');
INSERT INTO `weiapp_region` VALUES ('520114', '小河区', '520100', '86.520000.520100.520114', '中国.贵州省.贵阳市.小河区', '1');
INSERT INTO `weiapp_region` VALUES ('520121', '开阳县', '520100', '86.520000.520100.520121', '中国.贵州省.贵阳市.开阳县', '1');
INSERT INTO `weiapp_region` VALUES ('520122', '息烽县', '520100', '86.520000.520100.520122', '中国.贵州省.贵阳市.息烽县', '1');
INSERT INTO `weiapp_region` VALUES ('520123', '修文县', '520100', '86.520000.520100.520123', '中国.贵州省.贵阳市.修文县', '1');
INSERT INTO `weiapp_region` VALUES ('520181', '清镇市', '520100', '86.520000.520100.520181', '中国.贵州省.贵阳市.清镇市', '1');
INSERT INTO `weiapp_region` VALUES ('520201', '钟山区', '520200', '86.520000.520200.520201', '中国.贵州省.六盘水市.钟山区', '1');
INSERT INTO `weiapp_region` VALUES ('520203', '六枝特区', '520200', '86.520000.520200.520203', '中国.贵州省.六盘水市.六枝特区', '1');
INSERT INTO `weiapp_region` VALUES ('520221', '水城县', '520200', '86.520000.520200.520221', '中国.贵州省.六盘水市.水城县', '1');
INSERT INTO `weiapp_region` VALUES ('520222', '盘县', '520200', '86.520000.520200.520222', '中国.贵州省.六盘水市.盘县', '1');
INSERT INTO `weiapp_region` VALUES ('520302', '红花岗区', '520300', '86.520000.520300.520302', '中国.贵州省.遵义市.红花岗区', '1');
INSERT INTO `weiapp_region` VALUES ('520303', '汇川区', '520300', '86.520000.520300.520303', '中国.贵州省.遵义市.汇川区', '1');
INSERT INTO `weiapp_region` VALUES ('520321', '遵义县', '520300', '86.520000.520300.520321', '中国.贵州省.遵义市.遵义县', '1');
INSERT INTO `weiapp_region` VALUES ('520322', '桐梓县', '520300', '86.520000.520300.520322', '中国.贵州省.遵义市.桐梓县', '1');
INSERT INTO `weiapp_region` VALUES ('520323', '绥阳县', '520300', '86.520000.520300.520323', '中国.贵州省.遵义市.绥阳县', '1');
INSERT INTO `weiapp_region` VALUES ('520324', '正安县', '520300', '86.520000.520300.520324', '中国.贵州省.遵义市.正安县', '1');
INSERT INTO `weiapp_region` VALUES ('520325', '道真仡佬族苗族自治县', '520300', '86.520000.520300.520325', '中国.贵州省.遵义市.道真仡佬族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520326', '务川仡佬族苗族自治县', '520300', '86.520000.520300.520326', '中国.贵州省.遵义市.务川仡佬族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520327', '凤冈县', '520300', '86.520000.520300.520327', '中国.贵州省.遵义市.凤冈县', '1');
INSERT INTO `weiapp_region` VALUES ('520328', '湄潭县', '520300', '86.520000.520300.520328', '中国.贵州省.遵义市.湄潭县', '1');
INSERT INTO `weiapp_region` VALUES ('520329', '余庆县', '520300', '86.520000.520300.520329', '中国.贵州省.遵义市.余庆县', '1');
INSERT INTO `weiapp_region` VALUES ('520330', '习水县', '520300', '86.520000.520300.520330', '中国.贵州省.遵义市.习水县', '1');
INSERT INTO `weiapp_region` VALUES ('520381', '赤水市', '520300', '86.520000.520300.520381', '中国.贵州省.遵义市.赤水市', '1');
INSERT INTO `weiapp_region` VALUES ('520382', '仁怀市', '520300', '86.520000.520300.520382', '中国.贵州省.遵义市.仁怀市', '1');
INSERT INTO `weiapp_region` VALUES ('520402', '西秀区', '520400', '86.520000.520400.520402', '中国.贵州省.安顺市.西秀区', '1');
INSERT INTO `weiapp_region` VALUES ('520421', '平坝县', '520400', '86.520000.520400.520421', '中国.贵州省.安顺市.平坝县', '1');
INSERT INTO `weiapp_region` VALUES ('520422', '普定县', '520400', '86.520000.520400.520422', '中国.贵州省.安顺市.普定县', '1');
INSERT INTO `weiapp_region` VALUES ('520423', '镇宁布依族苗族自治县', '520400', '86.520000.520400.520423', '中国.贵州省.安顺市.镇宁布依族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520424', '关岭布依族苗族自治县', '520400', '86.520000.520400.520424', '中国.贵州省.安顺市.关岭布依族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520425', '紫云苗族布依族自治县', '520400', '86.520000.520400.520425', '中国.贵州省.安顺市.紫云苗族布依族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520502', '七星关区', '520500', '86.520000.520500.520502', '中国.贵州省.毕节市.七星关区', '1');
INSERT INTO `weiapp_region` VALUES ('520521', '大方县', '520500', '86.520000.520500.520521', '中国.贵州省.毕节市.大方县', '1');
INSERT INTO `weiapp_region` VALUES ('520522', '黔西县', '520500', '86.520000.520500.520522', '中国.贵州省.毕节市.黔西县', '1');
INSERT INTO `weiapp_region` VALUES ('520523', '金沙县', '520500', '86.520000.520500.520523', '中国.贵州省.毕节市.金沙县', '1');
INSERT INTO `weiapp_region` VALUES ('520524', '织金县', '520500', '86.520000.520500.520524', '中国.贵州省.毕节市.织金县', '1');
INSERT INTO `weiapp_region` VALUES ('520525', '纳雍县', '520500', '86.520000.520500.520525', '中国.贵州省.毕节市.纳雍县', '1');
INSERT INTO `weiapp_region` VALUES ('520526', '威宁彝族回族苗族自治县', '520500', '86.520000.520500.520526', '中国.贵州省.毕节市.威宁彝族回族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520527', '赫章县', '520500', '86.520000.520500.520527', '中国.贵州省.毕节市.赫章县', '1');
INSERT INTO `weiapp_region` VALUES ('520601', '市辖区', '520600', '86.520000.520600.520601', '中国.贵州省.铜仁市.市辖区 ', '1');
INSERT INTO `weiapp_region` VALUES ('520602', '碧江区', '520600', '86.520000.520600.520602', '中国.贵州省.铜仁市.碧江区', '1');
INSERT INTO `weiapp_region` VALUES ('520603', '万山区', '520600', '86.520000.520600.520603', '中国.贵州省.铜仁市.万山区 ', '1');
INSERT INTO `weiapp_region` VALUES ('520621', '江口县', '520600', '86.520000.520600.520621', '中国.贵州省.铜仁市.江口县', '1');
INSERT INTO `weiapp_region` VALUES ('520622', '玉屏侗族自治县', '520600', '86.520000.520600.520622', '中国.贵州省.铜仁市.玉屏侗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520623', '石阡县', '520600', '86.520000.520600.520623', '中国.贵州省.铜仁市.石阡县', '1');
INSERT INTO `weiapp_region` VALUES ('520624', '思南县', '520600', '86.520000.520600.520624', '中国.贵州省.铜仁市.思南县', '1');
INSERT INTO `weiapp_region` VALUES ('520625', '印江土家族苗族自治县', '520600', '86.520000.520600.520625', '中国.贵州省.铜仁市.印江土家族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520626', '德江县', '520600', '86.520000.520600.520626', '中国.贵州省.铜仁市.德江县', '1');
INSERT INTO `weiapp_region` VALUES ('520627', '沿河土家族自治县', '520600', '86.520000.520600.520627', '中国.贵州省.铜仁市.沿河土家族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('520628', '松桃苗族自治县', '520600', '86.520000.520600.520628', '中国.贵州省.铜仁市.松桃苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('522300', '黔西南布依族苗族自治州', '520000', '86.520000.522300', '中国.贵州省.黔西南布依族苗族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('522301', '兴义市', '522300', '86.520000.522300.522301', '中国.贵州省.黔西南布依族苗族自治州.兴义市', '1');
INSERT INTO `weiapp_region` VALUES ('522322', '兴仁县', '522300', '86.520000.522300.522322', '中国.贵州省.黔西南布依族苗族自治州.兴仁县', '1');
INSERT INTO `weiapp_region` VALUES ('522323', '普安县', '522300', '86.520000.522300.522323', '中国.贵州省.黔西南布依族苗族自治州.普安县', '1');
INSERT INTO `weiapp_region` VALUES ('522324', '晴隆县', '522300', '86.520000.522300.522324', '中国.贵州省.黔西南布依族苗族自治州.晴隆县', '1');
INSERT INTO `weiapp_region` VALUES ('522325', '贞丰县', '522300', '86.520000.522300.522325', '中国.贵州省.黔西南布依族苗族自治州.贞丰县', '1');
INSERT INTO `weiapp_region` VALUES ('522326', '望谟县', '522300', '86.520000.522300.522326', '中国.贵州省.黔西南布依族苗族自治州.望谟县', '1');
INSERT INTO `weiapp_region` VALUES ('522327', '册亨县', '522300', '86.520000.522300.522327', '中国.贵州省.黔西南布依族苗族自治州.册亨县', '1');
INSERT INTO `weiapp_region` VALUES ('522328', '安龙县', '522300', '86.520000.522300.522328', '中国.贵州省.黔西南布依族苗族自治州.安龙县', '1');
INSERT INTO `weiapp_region` VALUES ('522600', '黔东南苗族侗族自治州', '520000', '86.520000.522600', '中国.贵州省.黔东南苗族侗族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('522601', '凯里市', '522600', '86.520000.522600.522601', '中国.贵州省.黔东南苗族侗族自治州.凯里市', '1');
INSERT INTO `weiapp_region` VALUES ('522622', '黄平县', '522600', '86.520000.522600.522622', '中国.贵州省.黔东南苗族侗族自治州.黄平县', '1');
INSERT INTO `weiapp_region` VALUES ('522623', '施秉县', '522600', '86.520000.522600.522623', '中国.贵州省.黔东南苗族侗族自治州.施秉县', '1');
INSERT INTO `weiapp_region` VALUES ('522624', '三穗县', '522600', '86.520000.522600.522624', '中国.贵州省.黔东南苗族侗族自治州.三穗县', '1');
INSERT INTO `weiapp_region` VALUES ('522625', '镇远县', '522600', '86.520000.522600.522625', '中国.贵州省.黔东南苗族侗族自治州.镇远县', '1');
INSERT INTO `weiapp_region` VALUES ('522626', '岑巩县', '522600', '86.520000.522600.522626', '中国.贵州省.黔东南苗族侗族自治州.岑巩县', '1');
INSERT INTO `weiapp_region` VALUES ('522627', '天柱县', '522600', '86.520000.522600.522627', '中国.贵州省.黔东南苗族侗族自治州.天柱县', '1');
INSERT INTO `weiapp_region` VALUES ('522628', '锦屏县', '522600', '86.520000.522600.522628', '中国.贵州省.黔东南苗族侗族自治州.锦屏县', '1');
INSERT INTO `weiapp_region` VALUES ('522629', '剑河县', '522600', '86.520000.522600.522629', '中国.贵州省.黔东南苗族侗族自治州.剑河县', '1');
INSERT INTO `weiapp_region` VALUES ('522630', '台江县', '522600', '86.520000.522600.522630', '中国.贵州省.黔东南苗族侗族自治州.台江县', '1');
INSERT INTO `weiapp_region` VALUES ('522631', '黎平县', '522600', '86.520000.522600.522631', '中国.贵州省.黔东南苗族侗族自治州.黎平县', '1');
INSERT INTO `weiapp_region` VALUES ('522632', '榕江县', '522600', '86.520000.522600.522632', '中国.贵州省.黔东南苗族侗族自治州.榕江县', '1');
INSERT INTO `weiapp_region` VALUES ('522633', '从江县', '522600', '86.520000.522600.522633', '中国.贵州省.黔东南苗族侗族自治州.从江县', '1');
INSERT INTO `weiapp_region` VALUES ('522634', '雷山县', '522600', '86.520000.522600.522634', '中国.贵州省.黔东南苗族侗族自治州.雷山县', '1');
INSERT INTO `weiapp_region` VALUES ('522635', '麻江县', '522600', '86.520000.522600.522635', '中国.贵州省.黔东南苗族侗族自治州.麻江县', '1');
INSERT INTO `weiapp_region` VALUES ('522636', '丹寨县', '522600', '86.520000.522600.522636', '中国.贵州省.黔东南苗族侗族自治州.丹寨县', '1');
INSERT INTO `weiapp_region` VALUES ('522700', '黔南布依族苗族自治州', '520000', '86.520000.522700', '中国.贵州省.黔南布依族苗族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('522701', '都匀市', '522700', '86.520000.522700.522701', '中国.贵州省.黔南布依族苗族自治州.都匀市', '1');
INSERT INTO `weiapp_region` VALUES ('522702', '福泉市', '522700', '86.520000.522700.522702', '中国.贵州省.黔南布依族苗族自治州.福泉市', '1');
INSERT INTO `weiapp_region` VALUES ('522722', '荔波县', '522700', '86.520000.522700.522722', '中国.贵州省.黔南布依族苗族自治州.荔波县', '1');
INSERT INTO `weiapp_region` VALUES ('522723', '贵定县', '522700', '86.520000.522700.522723', '中国.贵州省.黔南布依族苗族自治州.贵定县', '1');
INSERT INTO `weiapp_region` VALUES ('522725', '瓮安县', '522700', '86.520000.522700.522725', '中国.贵州省.黔南布依族苗族自治州.瓮安县', '1');
INSERT INTO `weiapp_region` VALUES ('522726', '独山县', '522700', '86.520000.522700.522726', '中国.贵州省.黔南布依族苗族自治州.独山县', '1');
INSERT INTO `weiapp_region` VALUES ('522727', '平塘县', '522700', '86.520000.522700.522727', '中国.贵州省.黔南布依族苗族自治州.平塘县', '1');
INSERT INTO `weiapp_region` VALUES ('522728', '罗甸县', '522700', '86.520000.522700.522728', '中国.贵州省.黔南布依族苗族自治州.罗甸县', '1');
INSERT INTO `weiapp_region` VALUES ('522729', '长顺县', '522700', '86.520000.522700.522729', '中国.贵州省.黔南布依族苗族自治州.长顺县', '1');
INSERT INTO `weiapp_region` VALUES ('522730', '龙里县', '522700', '86.520000.522700.522730', '中国.贵州省.黔南布依族苗族自治州.龙里县', '1');
INSERT INTO `weiapp_region` VALUES ('522731', '惠水县', '522700', '86.520000.522700.522731', '中国.贵州省.黔南布依族苗族自治州.惠水县', '1');
INSERT INTO `weiapp_region` VALUES ('522732', '三都水族自治县', '522700', '86.520000.522700.522732', '中国.贵州省.黔南布依族苗族自治州.三都水族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530102', '五华区', '530100', '86.530000.530100.530102', '中国.云南省.昆明市.五华区', '1');
INSERT INTO `weiapp_region` VALUES ('530103', '盘龙区', '530100', '86.530000.530100.530103', '中国.云南省.昆明市.盘龙区', '1');
INSERT INTO `weiapp_region` VALUES ('530111', '官渡区', '530100', '86.530000.530100.530111', '中国.云南省.昆明市.官渡区', '1');
INSERT INTO `weiapp_region` VALUES ('530112', '西山区', '530100', '86.530000.530100.530112', '中国.云南省.昆明市.西山区', '1');
INSERT INTO `weiapp_region` VALUES ('530113', '东川区', '530100', '86.530000.530100.530113', '中国.云南省.昆明市.东川区', '1');
INSERT INTO `weiapp_region` VALUES ('530114', '呈贡区', '530100', '86.530000.530100.530114', '中国.云南省.昆明市.呈贡区', '1');
INSERT INTO `weiapp_region` VALUES ('530122', '晋宁县', '530100', '86.530000.530100.530122', '中国.云南省.昆明市.晋宁县', '1');
INSERT INTO `weiapp_region` VALUES ('530124', '富民县', '530100', '86.530000.530100.530124', '中国.云南省.昆明市.富民县', '1');
INSERT INTO `weiapp_region` VALUES ('530125', '宜良县', '530100', '86.530000.530100.530125', '中国.云南省.昆明市.宜良县', '1');
INSERT INTO `weiapp_region` VALUES ('530126', '石林彝族自治县', '530100', '86.530000.530100.530126', '中国.云南省.昆明市.石林彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530127', '嵩明县', '530100', '86.530000.530100.530127', '中国.云南省.昆明市.嵩明县', '1');
INSERT INTO `weiapp_region` VALUES ('530128', '禄劝彝族苗族自治县', '530100', '86.530000.530100.530128', '中国.云南省.昆明市.禄劝彝族苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530129', '寻甸回族彝族自治县', '530100', '86.530000.530100.530129', '中国.云南省.昆明市.寻甸回族彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530181', '安宁市', '530100', '86.530000.530100.530181', '中国.云南省.昆明市.安宁市', '1');
INSERT INTO `weiapp_region` VALUES ('530302', '麒麟区', '530300', '86.530000.530300.530302', '中国.云南省.曲靖市.麒麟区', '1');
INSERT INTO `weiapp_region` VALUES ('530321', '马龙县', '530300', '86.530000.530300.530321', '中国.云南省.曲靖市.马龙县', '1');
INSERT INTO `weiapp_region` VALUES ('530322', '陆良县', '530300', '86.530000.530300.530322', '中国.云南省.曲靖市.陆良县', '1');
INSERT INTO `weiapp_region` VALUES ('530323', '师宗县', '530300', '86.530000.530300.530323', '中国.云南省.曲靖市.师宗县', '1');
INSERT INTO `weiapp_region` VALUES ('530324', '罗平县', '530300', '86.530000.530300.530324', '中国.云南省.曲靖市.罗平县', '1');
INSERT INTO `weiapp_region` VALUES ('530325', '富源县', '530300', '86.530000.530300.530325', '中国.云南省.曲靖市.富源县', '1');
INSERT INTO `weiapp_region` VALUES ('530326', '会泽县', '530300', '86.530000.530300.530326', '中国.云南省.曲靖市.会泽县', '1');
INSERT INTO `weiapp_region` VALUES ('530328', '沾益县', '530300', '86.530000.530300.530328', '中国.云南省.曲靖市.沾益县', '1');
INSERT INTO `weiapp_region` VALUES ('530381', '宣威市', '530300', '86.530000.530300.530381', '中国.云南省.曲靖市.宣威市', '1');
INSERT INTO `weiapp_region` VALUES ('530422', '澄江县', '530400', '86.530000.530400.530422', '中国.云南省.玉溪市.澄江县', '1');
INSERT INTO `weiapp_region` VALUES ('530423', '通海县', '530400', '86.530000.530400.530423', '中国.云南省.玉溪市.通海县', '1');
INSERT INTO `weiapp_region` VALUES ('530424', '华宁县', '530400', '86.530000.530400.530424', '中国.云南省.玉溪市.华宁县', '1');
INSERT INTO `weiapp_region` VALUES ('530425', '易门县', '530400', '86.530000.530400.530425', '中国.云南省.玉溪市.易门县', '1');
INSERT INTO `weiapp_region` VALUES ('530426', '峨山彝族自治县', '530400', '86.530000.530400.530426', '中国.云南省.玉溪市.峨山彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530427', '新平彝族傣族自治县', '530400', '86.530000.530400.530427', '中国.云南省.玉溪市.新平彝族傣族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530428', '元江哈尼族彝族傣族自治县', '530400', '86.530000.530400.530428', '中国.云南省.玉溪市.元江哈尼族彝族傣族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530502', '隆阳区', '530500', '86.530000.530500.530502', '中国.云南省.保山市.隆阳区', '1');
INSERT INTO `weiapp_region` VALUES ('530521', '施甸县', '530500', '86.530000.530500.530521', '中国.云南省.保山市.施甸县', '1');
INSERT INTO `weiapp_region` VALUES ('530522', '腾冲县', '530500', '86.530000.530500.530522', '中国.云南省.保山市.腾冲县', '1');
INSERT INTO `weiapp_region` VALUES ('530523', '龙陵县', '530500', '86.530000.530500.530523', '中国.云南省.保山市.龙陵县', '1');
INSERT INTO `weiapp_region` VALUES ('530524', '昌宁县', '530500', '86.530000.530500.530524', '中国.云南省.保山市.昌宁县', '1');
INSERT INTO `weiapp_region` VALUES ('530602', '昭阳区', '530600', '86.530000.530600.530602', '中国.云南省.昭通市.昭阳区', '1');
INSERT INTO `weiapp_region` VALUES ('530621', '鲁甸县', '530600', '86.530000.530600.530621', '中国.云南省.昭通市.鲁甸县', '1');
INSERT INTO `weiapp_region` VALUES ('530622', '巧家县', '530600', '86.530000.530600.530622', '中国.云南省.昭通市.巧家县', '1');
INSERT INTO `weiapp_region` VALUES ('530623', '盐津县', '530600', '86.530000.530600.530623', '中国.云南省.昭通市.盐津县', '1');
INSERT INTO `weiapp_region` VALUES ('530624', '大关县', '530600', '86.530000.530600.530624', '中国.云南省.昭通市.大关县', '1');
INSERT INTO `weiapp_region` VALUES ('530625', '永善县', '530600', '86.530000.530600.530625', '中国.云南省.昭通市.永善县', '1');
INSERT INTO `weiapp_region` VALUES ('530626', '绥江县', '530600', '86.530000.530600.530626', '中国.云南省.昭通市.绥江县', '1');
INSERT INTO `weiapp_region` VALUES ('530627', '镇雄县', '530600', '86.530000.530600.530627', '中国.云南省.昭通市.镇雄县', '1');
INSERT INTO `weiapp_region` VALUES ('530628', '彝良县', '530600', '86.530000.530600.530628', '中国.云南省.昭通市.彝良县', '1');
INSERT INTO `weiapp_region` VALUES ('530629', '威信县', '530600', '86.530000.530600.530629', '中国.云南省.昭通市.威信县', '1');
INSERT INTO `weiapp_region` VALUES ('530630', '水富县', '530600', '86.530000.530600.530630', '中国.云南省.昭通市.水富县', '1');
INSERT INTO `weiapp_region` VALUES ('530702', '古城区', '530700', '86.530000.530700.530702', '中国.云南省.丽江市.古城区', '1');
INSERT INTO `weiapp_region` VALUES ('530721', '玉龙纳西族自治县', '530700', '86.530000.530700.530721', '中国.云南省.丽江市.玉龙纳西族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530722', '永胜县', '530700', '86.530000.530700.530722', '中国.云南省.丽江市.永胜县', '1');
INSERT INTO `weiapp_region` VALUES ('530723', '华坪县', '530700', '86.530000.530700.530723', '中国.云南省.丽江市.华坪县', '1');
INSERT INTO `weiapp_region` VALUES ('530724', '宁蒗彝族自治县', '530700', '86.530000.530700.530724', '中国.云南省.丽江市.宁蒗彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530802', '思茅区', '530800', '86.530000.530800.530802', '中国.云南省.普洱市.思茅区', '1');
INSERT INTO `weiapp_region` VALUES ('530821', '宁洱哈尼族彝族自治县', '530800', '86.530000.530800.530821', '中国.云南省.普洱市.宁洱哈尼族彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530822', '墨江哈尼族自治县', '530800', '86.530000.530800.530822', '中国.云南省.普洱市.墨江哈尼族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530823', '景东彝族自治县', '530800', '86.530000.530800.530823', '中国.云南省.普洱市.景东彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530824', '景谷傣族彝族自治县', '530800', '86.530000.530800.530824', '中国.云南省.普洱市.景谷傣族彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '530800', '86.530000.530800.530825', '中国.云南省.普洱市.镇沅彝族哈尼族拉祜族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530826', '江城哈尼族彝族自治县', '530800', '86.530000.530800.530826', '中国.云南省.普洱市.江城哈尼族彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530827', '孟连傣族拉祜族佤族自治县', '530800', '86.530000.530800.530827', '中国.云南省.普洱市.孟连傣族拉祜族佤族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530828', '澜沧拉祜族自治县', '530800', '86.530000.530800.530828', '中国.云南省.普洱市.澜沧拉祜族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530829', '西盟佤族自治县', '530800', '86.530000.530800.530829', '中国.云南省.普洱市.西盟佤族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530902', '临翔区', '530900', '86.530000.530900.530902', '中国.云南省.临沧市.临翔区', '1');
INSERT INTO `weiapp_region` VALUES ('530921', '凤庆县', '530900', '86.530000.530900.530921', '中国.云南省.临沧市.凤庆县', '1');
INSERT INTO `weiapp_region` VALUES ('530923', '永德县', '530900', '86.530000.530900.530923', '中国.云南省.临沧市.永德县', '1');
INSERT INTO `weiapp_region` VALUES ('530924', '镇康县', '530900', '86.530000.530900.530924', '中国.云南省.临沧市.镇康县', '1');
INSERT INTO `weiapp_region` VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '530900', '86.530000.530900.530925', '中国.云南省.临沧市.双江拉祜族佤族布朗族傣族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530926', '耿马傣族佤族自治县', '530900', '86.530000.530900.530926', '中国.云南省.临沧市.耿马傣族佤族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('530927', '沧源佤族自治县', '530900', '86.530000.530900.530927', '中国.云南省.临沧市.沧源佤族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('532300', '楚雄彝族自治州', '530000', '86.530000.532300', '中国.云南省.楚雄彝族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('532301', '楚雄市', '532300', '86.530000.532300.532301', '中国.云南省.楚雄彝族自治州.楚雄市', '1');
INSERT INTO `weiapp_region` VALUES ('532322', '双柏县', '532300', '86.530000.532300.532322', '中国.云南省.楚雄彝族自治州.双柏县', '1');
INSERT INTO `weiapp_region` VALUES ('532323', '牟定县', '532300', '86.530000.532300.532323', '中国.云南省.楚雄彝族自治州.牟定县', '1');
INSERT INTO `weiapp_region` VALUES ('532324', '南华县', '532300', '86.530000.532300.532324', '中国.云南省.楚雄彝族自治州.南华县', '1');
INSERT INTO `weiapp_region` VALUES ('532325', '姚安县', '532300', '86.530000.532300.532325', '中国.云南省.楚雄彝族自治州.姚安县', '1');
INSERT INTO `weiapp_region` VALUES ('532326', '大姚县', '532300', '86.530000.532300.532326', '中国.云南省.楚雄彝族自治州.大姚县', '1');
INSERT INTO `weiapp_region` VALUES ('532327', '永仁县', '532300', '86.530000.532300.532327', '中国.云南省.楚雄彝族自治州.永仁县', '1');
INSERT INTO `weiapp_region` VALUES ('532328', '元谋县', '532300', '86.530000.532300.532328', '中国.云南省.楚雄彝族自治州.元谋县', '1');
INSERT INTO `weiapp_region` VALUES ('532329', '武定县', '532300', '86.530000.532300.532329', '中国.云南省.楚雄彝族自治州.武定县', '1');
INSERT INTO `weiapp_region` VALUES ('532331', '禄丰县', '532300', '86.530000.532300.532331', '中国.云南省.楚雄彝族自治州.禄丰县', '1');
INSERT INTO `weiapp_region` VALUES ('532500', '红河哈尼族彝族自治州', '530000', '86.530000.532500', '中国.云南省.红河哈尼族彝族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('532501', '个旧市', '532500', '86.530000.532500.532501', '中国.云南省.红河哈尼族彝族自治州.个旧市', '1');
INSERT INTO `weiapp_region` VALUES ('532502', '开远市', '532500', '86.530000.532500.532502', '中国.云南省.红河哈尼族彝族自治州.开远市', '1');
INSERT INTO `weiapp_region` VALUES ('532503', '蒙自市', '532500', '86.530000.532500.532503', '中国.云南省.红河哈尼族彝族自治州.蒙自市', '1');
INSERT INTO `weiapp_region` VALUES ('532523', '屏边苗族自治县', '532500', '86.530000.532500.532523', '中国.云南省.红河哈尼族彝族自治州.屏边苗族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('532524', '建水县', '532500', '86.530000.532500.532524', '中国.云南省.红河哈尼族彝族自治州.建水县', '1');
INSERT INTO `weiapp_region` VALUES ('532525', '石屏县', '532500', '86.530000.532500.532525', '中国.云南省.红河哈尼族彝族自治州.石屏县', '1');
INSERT INTO `weiapp_region` VALUES ('532526', '弥勒县', '532500', '86.530000.532500.532526', '中国.云南省.红河哈尼族彝族自治州.弥勒县', '1');
INSERT INTO `weiapp_region` VALUES ('532527', '泸西县', '532500', '86.530000.532500.532527', '中国.云南省.红河哈尼族彝族自治州.泸西县', '1');
INSERT INTO `weiapp_region` VALUES ('532528', '元阳县', '532500', '86.530000.532500.532528', '中国.云南省.红河哈尼族彝族自治州.元阳县', '1');
INSERT INTO `weiapp_region` VALUES ('532529', '红河县', '532500', '86.530000.532500.532529', '中国.云南省.红河哈尼族彝族自治州.红河县', '1');
INSERT INTO `weiapp_region` VALUES ('532530', '金平苗族瑶族傣族自治县', '532500', '86.530000.532500.532530', '中国.云南省.红河哈尼族彝族自治州.金平苗族瑶族傣族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('532531', '绿春县', '532500', '86.530000.532500.532531', '中国.云南省.红河哈尼族彝族自治州.绿春县', '1');
INSERT INTO `weiapp_region` VALUES ('532532', '河口瑶族自治县', '532500', '86.530000.532500.532532', '中国.云南省.红河哈尼族彝族自治州.河口瑶族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('532600', '文山壮族苗族自治州', '530000', '86.530000.532600', '中国.云南省.文山壮族苗族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('532601', '文山市', '532600', '86.530000.532600.532601', '中国.云南省.文山壮族苗族自治州.文山市', '1');
INSERT INTO `weiapp_region` VALUES ('532622', '砚山县', '532600', '86.530000.532600.532622', '中国.云南省.文山壮族苗族自治州.砚山县', '1');
INSERT INTO `weiapp_region` VALUES ('532623', '西畴县', '532600', '86.530000.532600.532623', '中国.云南省.文山壮族苗族自治州.西畴县', '1');
INSERT INTO `weiapp_region` VALUES ('532624', '麻栗坡县', '532600', '86.530000.532600.532624', '中国.云南省.文山壮族苗族自治州.麻栗坡县', '1');
INSERT INTO `weiapp_region` VALUES ('532625', '马关县', '532600', '86.530000.532600.532625', '中国.云南省.文山壮族苗族自治州.马关县', '1');
INSERT INTO `weiapp_region` VALUES ('532626', '丘北县', '532600', '86.530000.532600.532626', '中国.云南省.文山壮族苗族自治州.丘北县', '1');
INSERT INTO `weiapp_region` VALUES ('532627', '广南县', '532600', '86.530000.532600.532627', '中国.云南省.文山壮族苗族自治州.广南县', '1');
INSERT INTO `weiapp_region` VALUES ('532628', '富宁县', '532600', '86.530000.532600.532628', '中国.云南省.文山壮族苗族自治州.富宁县', '1');
INSERT INTO `weiapp_region` VALUES ('532800', '西双版纳傣族自治州', '530000', '86.530000.532800', '中国.云南省.西双版纳傣族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('532801', '景洪市', '532800', '86.530000.532800.532801', '中国.云南省.西双版纳傣族自治州.景洪市', '1');
INSERT INTO `weiapp_region` VALUES ('532822', '勐海县', '532800', '86.530000.532800.532822', '中国.云南省.西双版纳傣族自治州.勐海县', '1');
INSERT INTO `weiapp_region` VALUES ('532823', '勐腊县', '532800', '86.530000.532800.532823', '中国.云南省.西双版纳傣族自治州.勐腊县', '1');
INSERT INTO `weiapp_region` VALUES ('532900', '大理白族自治州', '530000', '86.530000.532900', '中国.云南省.大理白族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('532901', '大理市', '532900', '86.530000.532900.532901', '中国.云南省.大理白族自治州.大理市', '1');
INSERT INTO `weiapp_region` VALUES ('532922', '漾濞彝族自治县', '532900', '86.530000.532900.532922', '中国.云南省.大理白族自治州.漾濞彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('532923', '祥云县', '532900', '86.530000.532900.532923', '中国.云南省.大理白族自治州.祥云县', '1');
INSERT INTO `weiapp_region` VALUES ('532924', '宾川县', '532900', '86.530000.532900.532924', '中国.云南省.大理白族自治州.宾川县', '1');
INSERT INTO `weiapp_region` VALUES ('532925', '弥渡县', '532900', '86.530000.532900.532925', '中国.云南省.大理白族自治州.弥渡县', '1');
INSERT INTO `weiapp_region` VALUES ('532926', '南涧彝族自治县', '532900', '86.530000.532900.532926', '中国.云南省.大理白族自治州.南涧彝族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('532927', '巍山彝族回族自治县', '532900', '86.530000.532900.532927', '中国.云南省.大理白族自治州.巍山彝族回族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('532928', '永平县', '532900', '86.530000.532900.532928', '中国.云南省.大理白族自治州.永平县', '1');
INSERT INTO `weiapp_region` VALUES ('532929', '云龙县', '532900', '86.530000.532900.532929', '中国.云南省.大理白族自治州.云龙县', '1');
INSERT INTO `weiapp_region` VALUES ('532930', '洱源县', '532900', '86.530000.532900.532930', '中国.云南省.大理白族自治州.洱源县', '1');
INSERT INTO `weiapp_region` VALUES ('532931', '剑川县', '532900', '86.530000.532900.532931', '中国.云南省.大理白族自治州.剑川县', '1');
INSERT INTO `weiapp_region` VALUES ('532932', '鹤庆县', '532900', '86.530000.532900.532932', '中国.云南省.大理白族自治州.鹤庆县', '1');
INSERT INTO `weiapp_region` VALUES ('533100', '德宏傣族景颇族自治州', '530000', '86.530000.533100', '中国.云南省.德宏傣族景颇族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('533102', '瑞丽市', '533100', '86.530000.533100.533102', '中国.云南省.德宏傣族景颇族自治州.瑞丽市', '1');
INSERT INTO `weiapp_region` VALUES ('533103', '芒市', '533100', '86.530000.533100.533103', '中国.云南省.德宏傣族景颇族自治州.芒市', '1');
INSERT INTO `weiapp_region` VALUES ('533122', '梁河县', '533100', '86.530000.533100.533122', '中国.云南省.德宏傣族景颇族自治州.梁河县', '1');
INSERT INTO `weiapp_region` VALUES ('533123', '盈江县', '533100', '86.530000.533100.533123', '中国.云南省.德宏傣族景颇族自治州.盈江县', '1');
INSERT INTO `weiapp_region` VALUES ('533124', '陇川县', '533100', '86.530000.533100.533124', '中国.云南省.德宏傣族景颇族自治州.陇川县', '1');
INSERT INTO `weiapp_region` VALUES ('533300', '怒江傈僳族自治州', '530000', '86.530000.533300', '中国.云南省.怒江傈僳族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('533321', '泸水县', '533300', '86.530000.533300.533321', '中国.云南省.怒江傈僳族自治州.泸水县', '1');
INSERT INTO `weiapp_region` VALUES ('533323', '福贡县', '533300', '86.530000.533300.533323', '中国.云南省.怒江傈僳族自治州.福贡县', '1');
INSERT INTO `weiapp_region` VALUES ('533324', '贡山独龙族怒族自治县', '533300', '86.530000.533300.533324', '中国.云南省.怒江傈僳族自治州.贡山独龙族怒族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('533325', '兰坪白族普米族自治县', '533300', '86.530000.533300.533325', '中国.云南省.怒江傈僳族自治州.兰坪白族普米族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('533400', '迪庆藏族自治州', '530000', '86.530000.533400', '中国.云南省.迪庆藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('533421', '香格里拉县', '533400', '86.530000.533400.533421', '中国.云南省.迪庆藏族自治州.香格里拉县', '1');
INSERT INTO `weiapp_region` VALUES ('533422', '德钦县', '533400', '86.530000.533400.533422', '中国.云南省.迪庆藏族自治州.德钦县', '1');
INSERT INTO `weiapp_region` VALUES ('533423', '维西傈僳族自治县', '533400', '86.530000.533400.533423', '中国.云南省.迪庆藏族自治州.维西傈僳族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('540102', '城关区', '540100', '86.540000.540100.540102', '中国.西藏自治区.拉萨市.城关区', '1');
INSERT INTO `weiapp_region` VALUES ('540121', '林周县', '540100', '86.540000.540100.540121', '中国.西藏自治区.拉萨市.林周县', '1');
INSERT INTO `weiapp_region` VALUES ('540122', '当雄县', '540100', '86.540000.540100.540122', '中国.西藏自治区.拉萨市.当雄县', '1');
INSERT INTO `weiapp_region` VALUES ('540123', '尼木县', '540100', '86.540000.540100.540123', '中国.西藏自治区.拉萨市.尼木县', '1');
INSERT INTO `weiapp_region` VALUES ('540124', '曲水县', '540100', '86.540000.540100.540124', '中国.西藏自治区.拉萨市.曲水县', '1');
INSERT INTO `weiapp_region` VALUES ('540125', '堆龙德庆县', '540100', '86.540000.540100.540125', '中国.西藏自治区.拉萨市.堆龙德庆县', '1');
INSERT INTO `weiapp_region` VALUES ('540126', '达孜县', '540100', '86.540000.540100.540126', '中国.西藏自治区.拉萨市.达孜县', '1');
INSERT INTO `weiapp_region` VALUES ('540127', '墨竹工卡县', '540100', '86.540000.540100.540127', '中国.西藏自治区.拉萨市.墨竹工卡县', '1');
INSERT INTO `weiapp_region` VALUES ('542121', '昌都县', '542100', '86.540000.542100.542121', '中国.西藏自治区.昌都地区.昌都县', '1');
INSERT INTO `weiapp_region` VALUES ('542122', '江达县', '542100', '86.540000.542100.542122', '中国.西藏自治区.昌都地区.江达县', '1');
INSERT INTO `weiapp_region` VALUES ('542123', '贡觉县', '542100', '86.540000.542100.542123', '中国.西藏自治区.昌都地区.贡觉县', '1');
INSERT INTO `weiapp_region` VALUES ('542124', '类乌齐县', '542100', '86.540000.542100.542124', '中国.西藏自治区.昌都地区.类乌齐县', '1');
INSERT INTO `weiapp_region` VALUES ('542125', '丁青县', '542100', '86.540000.542100.542125', '中国.西藏自治区.昌都地区.丁青县', '1');
INSERT INTO `weiapp_region` VALUES ('542126', '察雅县', '542100', '86.540000.542100.542126', '中国.西藏自治区.昌都地区.察雅县', '1');
INSERT INTO `weiapp_region` VALUES ('542127', '八宿县', '542100', '86.540000.542100.542127', '中国.西藏自治区.昌都地区.八宿县', '1');
INSERT INTO `weiapp_region` VALUES ('542128', '左贡县', '542100', '86.540000.542100.542128', '中国.西藏自治区.昌都地区.左贡县', '1');
INSERT INTO `weiapp_region` VALUES ('542129', '芒康县', '542100', '86.540000.542100.542129', '中国.西藏自治区.昌都地区.芒康县', '1');
INSERT INTO `weiapp_region` VALUES ('542132', '洛隆县', '542100', '86.540000.542100.542132', '中国.西藏自治区.昌都地区.洛隆县', '1');
INSERT INTO `weiapp_region` VALUES ('542133', '边坝县', '542100', '86.540000.542100.542133', '中国.西藏自治区.昌都地区.边坝县', '1');
INSERT INTO `weiapp_region` VALUES ('542221', '乃东县', '542200', '86.540000.542200.542221', '中国.西藏自治区.山南地区.乃东县', '1');
INSERT INTO `weiapp_region` VALUES ('542222', '扎囊县', '542200', '86.540000.542200.542222', '中国.西藏自治区.山南地区.扎囊县', '1');
INSERT INTO `weiapp_region` VALUES ('542223', '贡嘎县', '542200', '86.540000.542200.542223', '中国.西藏自治区.山南地区.贡嘎县', '1');
INSERT INTO `weiapp_region` VALUES ('542224', '桑日县', '542200', '86.540000.542200.542224', '中国.西藏自治区.山南地区.桑日县', '1');
INSERT INTO `weiapp_region` VALUES ('542225', '琼结县', '542200', '86.540000.542200.542225', '中国.西藏自治区.山南地区.琼结县', '1');
INSERT INTO `weiapp_region` VALUES ('542226', '曲松县', '542200', '86.540000.542200.542226', '中国.西藏自治区.山南地区.曲松县', '1');
INSERT INTO `weiapp_region` VALUES ('542227', '措美县', '542200', '86.540000.542200.542227', '中国.西藏自治区.山南地区.措美县', '1');
INSERT INTO `weiapp_region` VALUES ('542228', '洛扎县', '542200', '86.540000.542200.542228', '中国.西藏自治区.山南地区.洛扎县', '1');
INSERT INTO `weiapp_region` VALUES ('542229', '加查县', '542200', '86.540000.542200.542229', '中国.西藏自治区.山南地区.加查县', '1');
INSERT INTO `weiapp_region` VALUES ('542231', '隆子县', '542200', '86.540000.542200.542231', '中国.西藏自治区.山南地区.隆子县', '1');
INSERT INTO `weiapp_region` VALUES ('542232', '错那县', '542200', '86.540000.542200.542232', '中国.西藏自治区.山南地区.错那县', '1');
INSERT INTO `weiapp_region` VALUES ('542233', '浪卡子县', '542200', '86.540000.542200.542233', '中国.西藏自治区.山南地区.浪卡子县', '1');
INSERT INTO `weiapp_region` VALUES ('542300', '日喀则地区', '540000', '86.540000.542300', '中国.西藏自治区.日喀则地区', '1');
INSERT INTO `weiapp_region` VALUES ('542301', '日喀则市', '542300', '86.540000.542300.542301', '中国.西藏自治区.日喀则地区.日喀则市', '1');
INSERT INTO `weiapp_region` VALUES ('542322', '南木林县', '542300', '86.540000.542300.542322', '中国.西藏自治区.日喀则地区.南木林县', '1');
INSERT INTO `weiapp_region` VALUES ('542323', '江孜县', '542300', '86.540000.542300.542323', '中国.西藏自治区.日喀则地区.江孜县', '1');
INSERT INTO `weiapp_region` VALUES ('542324', '定日县', '542300', '86.540000.542300.542324', '中国.西藏自治区.日喀则地区.定日县', '1');
INSERT INTO `weiapp_region` VALUES ('542325', '萨迦县', '542300', '86.540000.542300.542325', '中国.西藏自治区.日喀则地区.萨迦县', '1');
INSERT INTO `weiapp_region` VALUES ('542326', '拉孜县', '542300', '86.540000.542300.542326', '中国.西藏自治区.日喀则地区.拉孜县', '1');
INSERT INTO `weiapp_region` VALUES ('542327', '昂仁县', '542300', '86.540000.542300.542327', '中国.西藏自治区.日喀则地区.昂仁县', '1');
INSERT INTO `weiapp_region` VALUES ('542328', '谢通门县', '542300', '86.540000.542300.542328', '中国.西藏自治区.日喀则地区.谢通门县', '1');
INSERT INTO `weiapp_region` VALUES ('542329', '白朗县', '542300', '86.540000.542300.542329', '中国.西藏自治区.日喀则地区.白朗县', '1');
INSERT INTO `weiapp_region` VALUES ('542330', '仁布县', '542300', '86.540000.542300.542330', '中国.西藏自治区.日喀则地区.仁布县', '1');
INSERT INTO `weiapp_region` VALUES ('542331', '康马县', '542300', '86.540000.542300.542331', '中国.西藏自治区.日喀则地区.康马县', '1');
INSERT INTO `weiapp_region` VALUES ('542332', '定结县', '542300', '86.540000.542300.542332', '中国.西藏自治区.日喀则地区.定结县', '1');
INSERT INTO `weiapp_region` VALUES ('542333', '仲巴县', '542300', '86.540000.542300.542333', '中国.西藏自治区.日喀则地区.仲巴县', '1');
INSERT INTO `weiapp_region` VALUES ('542334', '亚东县', '542300', '86.540000.542300.542334', '中国.西藏自治区.日喀则地区.亚东县', '1');
INSERT INTO `weiapp_region` VALUES ('542335', '吉隆县', '542300', '86.540000.542300.542335', '中国.西藏自治区.日喀则地区.吉隆县', '1');
INSERT INTO `weiapp_region` VALUES ('542336', '聂拉木县', '542300', '86.540000.542300.542336', '中国.西藏自治区.日喀则地区.聂拉木县', '1');
INSERT INTO `weiapp_region` VALUES ('542337', '萨嘎县', '542300', '86.540000.542300.542337', '中国.西藏自治区.日喀则地区.萨嘎县', '1');
INSERT INTO `weiapp_region` VALUES ('542338', '岗巴县', '542300', '86.540000.542300.542338', '中国.西藏自治区.日喀则地区.岗巴县', '1');
INSERT INTO `weiapp_region` VALUES ('542400', '那曲地区', '540000', '86.540000.542400', '中国.西藏自治区.那曲地区', '1');
INSERT INTO `weiapp_region` VALUES ('542421', '那曲县', '542400', '86.540000.542400.542421', '中国.西藏自治区.那曲地区.那曲县', '1');
INSERT INTO `weiapp_region` VALUES ('542422', '嘉黎县', '542400', '86.540000.542400.542422', '中国.西藏自治区.那曲地区.嘉黎县', '1');
INSERT INTO `weiapp_region` VALUES ('542423', '比如县', '542400', '86.540000.542400.542423', '中国.西藏自治区.那曲地区.比如县', '1');
INSERT INTO `weiapp_region` VALUES ('542424', '聂荣县', '542400', '86.540000.542400.542424', '中国.西藏自治区.那曲地区.聂荣县', '1');
INSERT INTO `weiapp_region` VALUES ('542425', '安多县', '542400', '86.540000.542400.542425', '中国.西藏自治区.那曲地区.安多县', '1');
INSERT INTO `weiapp_region` VALUES ('542426', '申扎县', '542400', '86.540000.542400.542426', '中国.西藏自治区.那曲地区.申扎县', '1');
INSERT INTO `weiapp_region` VALUES ('542427', '索县', '542400', '86.540000.542400.542427', '中国.西藏自治区.那曲地区.索县', '1');
INSERT INTO `weiapp_region` VALUES ('542428', '班戈县', '542400', '86.540000.542400.542428', '中国.西藏自治区.那曲地区.班戈县', '1');
INSERT INTO `weiapp_region` VALUES ('542429', '巴青县', '542400', '86.540000.542400.542429', '中国.西藏自治区.那曲地区.巴青县', '1');
INSERT INTO `weiapp_region` VALUES ('542430', '尼玛县', '542400', '86.540000.542400.542430', '中国.西藏自治区.那曲地区.尼玛县', '1');
INSERT INTO `weiapp_region` VALUES ('542500', '阿里地区', '540000', '86.540000.542500', '中国.西藏自治区.阿里地区', '1');
INSERT INTO `weiapp_region` VALUES ('542521', '普兰县', '542500', '86.540000.542500.542521', '中国.西藏自治区.阿里地区.普兰县', '1');
INSERT INTO `weiapp_region` VALUES ('542522', '札达县', '542500', '86.540000.542500.542522', '中国.西藏自治区.阿里地区.札达县', '1');
INSERT INTO `weiapp_region` VALUES ('542523', '噶尔县', '542500', '86.540000.542500.542523', '中国.西藏自治区.阿里地区.噶尔县', '1');
INSERT INTO `weiapp_region` VALUES ('542524', '日土县', '542500', '86.540000.542500.542524', '中国.西藏自治区.阿里地区.日土县', '1');
INSERT INTO `weiapp_region` VALUES ('542525', '革吉县', '542500', '86.540000.542500.542525', '中国.西藏自治区.阿里地区.革吉县', '1');
INSERT INTO `weiapp_region` VALUES ('542526', '改则县', '542500', '86.540000.542500.542526', '中国.西藏自治区.阿里地区.改则县', '1');
INSERT INTO `weiapp_region` VALUES ('542527', '措勤县', '542500', '86.540000.542500.542527', '中国.西藏自治区.阿里地区.措勤县', '1');
INSERT INTO `weiapp_region` VALUES ('542600', '林芝地区', '540000', '86.540000.542600', '中国.西藏自治区.林芝地区', '1');
INSERT INTO `weiapp_region` VALUES ('542621', '林芝县', '542600', '86.540000.542600.542621', '中国.西藏自治区.林芝地区.林芝县', '1');
INSERT INTO `weiapp_region` VALUES ('542622', '工布江达县', '542600', '86.540000.542600.542622', '中国.西藏自治区.林芝地区.工布江达县', '1');
INSERT INTO `weiapp_region` VALUES ('542623', '米林县', '542600', '86.540000.542600.542623', '中国.西藏自治区.林芝地区.米林县', '1');
INSERT INTO `weiapp_region` VALUES ('542624', '墨脱县', '542600', '86.540000.542600.542624', '中国.西藏自治区.林芝地区.墨脱县', '1');
INSERT INTO `weiapp_region` VALUES ('542625', '波密县', '542600', '86.540000.542600.542625', '中国.西藏自治区.林芝地区.波密县', '1');
INSERT INTO `weiapp_region` VALUES ('542626', '察隅县', '542600', '86.540000.542600.542626', '中国.西藏自治区.林芝地区.察隅县', '1');
INSERT INTO `weiapp_region` VALUES ('542627', '朗县', '542600', '86.540000.542600.542627', '中国.西藏自治区.林芝地区.朗县', '1');
INSERT INTO `weiapp_region` VALUES ('610102', '新城区', '610100', '86.610000.610100.610102', '中国.陕西省.西安市.新城区', '1');
INSERT INTO `weiapp_region` VALUES ('610103', '碑林区', '610100', '86.610000.610100.610103', '中国.陕西省.西安市.碑林区', '1');
INSERT INTO `weiapp_region` VALUES ('610104', '莲湖区', '610100', '86.610000.610100.610104', '中国.陕西省.西安市.莲湖区', '1');
INSERT INTO `weiapp_region` VALUES ('610111', '灞桥区', '610100', '86.610000.610100.610111', '中国.陕西省.西安市.灞桥区', '1');
INSERT INTO `weiapp_region` VALUES ('610112', '未央区', '610100', '86.610000.610100.610112', '中国.陕西省.西安市.未央区', '1');
INSERT INTO `weiapp_region` VALUES ('610113', '雁塔区', '610100', '86.610000.610100.610113', '中国.陕西省.西安市.雁塔区', '1');
INSERT INTO `weiapp_region` VALUES ('610114', '阎良区', '610100', '86.610000.610100.610114', '中国.陕西省.西安市.阎良区', '1');
INSERT INTO `weiapp_region` VALUES ('610115', '临潼区', '610100', '86.610000.610100.610115', '中国.陕西省.西安市.临潼区', '1');
INSERT INTO `weiapp_region` VALUES ('610116', '长安区', '610100', '86.610000.610100.610116', '中国.陕西省.西安市.长安区', '1');
INSERT INTO `weiapp_region` VALUES ('610122', '蓝田县', '610100', '86.610000.610100.610122', '中国.陕西省.西安市.蓝田县', '1');
INSERT INTO `weiapp_region` VALUES ('610124', '周至县', '610100', '86.610000.610100.610124', '中国.陕西省.西安市.周至县', '1');
INSERT INTO `weiapp_region` VALUES ('610125', '户县', '610100', '86.610000.610100.610125', '中国.陕西省.西安市.户县', '1');
INSERT INTO `weiapp_region` VALUES ('610126', '高陵县', '610100', '86.610000.610100.610126', '中国.陕西省.西安市.高陵县', '1');
INSERT INTO `weiapp_region` VALUES ('610202', '王益区', '610200', '86.610000.610200.610202', '中国.陕西省.铜川市.王益区', '1');
INSERT INTO `weiapp_region` VALUES ('610203', '印台区', '610200', '86.610000.610200.610203', '中国.陕西省.铜川市.印台区', '1');
INSERT INTO `weiapp_region` VALUES ('610204', '耀州区', '610200', '86.610000.610200.610204', '中国.陕西省.铜川市.耀州区', '1');
INSERT INTO `weiapp_region` VALUES ('610222', '宜君县', '610200', '86.610000.610200.610222', '中国.陕西省.铜川市.宜君县', '1');
INSERT INTO `weiapp_region` VALUES ('610302', '渭滨区', '610300', '86.610000.610300.610302', '中国.陕西省.宝鸡市.渭滨区', '1');
INSERT INTO `weiapp_region` VALUES ('610303', '金台区', '610300', '86.610000.610300.610303', '中国.陕西省.宝鸡市.金台区', '1');
INSERT INTO `weiapp_region` VALUES ('610304', '陈仓区', '610300', '86.610000.610300.610304', '中国.陕西省.宝鸡市.陈仓区', '1');
INSERT INTO `weiapp_region` VALUES ('610322', '凤翔县', '610300', '86.610000.610300.610322', '中国.陕西省.宝鸡市.凤翔县', '1');
INSERT INTO `weiapp_region` VALUES ('610323', '岐山县', '610300', '86.610000.610300.610323', '中国.陕西省.宝鸡市.岐山县', '1');
INSERT INTO `weiapp_region` VALUES ('610324', '扶风县', '610300', '86.610000.610300.610324', '中国.陕西省.宝鸡市.扶风县', '1');
INSERT INTO `weiapp_region` VALUES ('610326', '眉县', '610300', '86.610000.610300.610326', '中国.陕西省.宝鸡市.眉县', '1');
INSERT INTO `weiapp_region` VALUES ('610327', '陇县', '610300', '86.610000.610300.610327', '中国.陕西省.宝鸡市.陇县', '1');
INSERT INTO `weiapp_region` VALUES ('610328', '千阳县', '610300', '86.610000.610300.610328', '中国.陕西省.宝鸡市.千阳县', '1');
INSERT INTO `weiapp_region` VALUES ('610329', '麟游县', '610300', '86.610000.610300.610329', '中国.陕西省.宝鸡市.麟游县', '1');
INSERT INTO `weiapp_region` VALUES ('610330', '凤县', '610300', '86.610000.610300.610330', '中国.陕西省.宝鸡市.凤县', '1');
INSERT INTO `weiapp_region` VALUES ('610331', '太白县', '610300', '86.610000.610300.610331', '中国.陕西省.宝鸡市.太白县', '1');
INSERT INTO `weiapp_region` VALUES ('610402', '秦都区', '610400', '86.610000.610400.610402', '中国.陕西省.咸阳市.秦都区', '1');
INSERT INTO `weiapp_region` VALUES ('610403', '杨陵区', '610400', '86.610000.610400.610403', '中国.陕西省.咸阳市.杨陵区', '1');
INSERT INTO `weiapp_region` VALUES ('610404', '渭城区', '610400', '86.610000.610400.610404', '中国.陕西省.咸阳市.渭城区', '1');
INSERT INTO `weiapp_region` VALUES ('610422', '三原县', '610400', '86.610000.610400.610422', '中国.陕西省.咸阳市.三原县', '1');
INSERT INTO `weiapp_region` VALUES ('610423', '泾阳县', '610400', '86.610000.610400.610423', '中国.陕西省.咸阳市.泾阳县', '1');
INSERT INTO `weiapp_region` VALUES ('610424', '乾县', '610400', '86.610000.610400.610424', '中国.陕西省.咸阳市.乾县', '1');
INSERT INTO `weiapp_region` VALUES ('610425', '礼泉县', '610400', '86.610000.610400.610425', '中国.陕西省.咸阳市.礼泉县', '1');
INSERT INTO `weiapp_region` VALUES ('610426', '永寿县', '610400', '86.610000.610400.610426', '中国.陕西省.咸阳市.永寿县', '1');
INSERT INTO `weiapp_region` VALUES ('610427', '彬县', '610400', '86.610000.610400.610427', '中国.陕西省.咸阳市.彬县', '1');
INSERT INTO `weiapp_region` VALUES ('610428', '长武县', '610400', '86.610000.610400.610428', '中国.陕西省.咸阳市.长武县', '1');
INSERT INTO `weiapp_region` VALUES ('610429', '旬邑县', '610400', '86.610000.610400.610429', '中国.陕西省.咸阳市.旬邑县', '1');
INSERT INTO `weiapp_region` VALUES ('610430', '淳化县', '610400', '86.610000.610400.610430', '中国.陕西省.咸阳市.淳化县', '1');
INSERT INTO `weiapp_region` VALUES ('610431', '武功县', '610400', '86.610000.610400.610431', '中国.陕西省.咸阳市.武功县', '1');
INSERT INTO `weiapp_region` VALUES ('610481', '兴平市', '610400', '86.610000.610400.610481', '中国.陕西省.咸阳市.兴平市', '1');
INSERT INTO `weiapp_region` VALUES ('610502', '临渭区', '610500', '86.610000.610500.610502', '中国.陕西省.渭南市.临渭区', '1');
INSERT INTO `weiapp_region` VALUES ('610521', '华县', '610500', '86.610000.610500.610521', '中国.陕西省.渭南市.华县', '1');
INSERT INTO `weiapp_region` VALUES ('610522', '潼关县', '610500', '86.610000.610500.610522', '中国.陕西省.渭南市.潼关县', '1');
INSERT INTO `weiapp_region` VALUES ('610523', '大荔县', '610500', '86.610000.610500.610523', '中国.陕西省.渭南市.大荔县', '1');
INSERT INTO `weiapp_region` VALUES ('610524', '合阳县', '610500', '86.610000.610500.610524', '中国.陕西省.渭南市.合阳县', '1');
INSERT INTO `weiapp_region` VALUES ('610525', '澄城县', '610500', '86.610000.610500.610525', '中国.陕西省.渭南市.澄城县', '1');
INSERT INTO `weiapp_region` VALUES ('610526', '蒲城县', '610500', '86.610000.610500.610526', '中国.陕西省.渭南市.蒲城县', '1');
INSERT INTO `weiapp_region` VALUES ('610527', '白水县', '610500', '86.610000.610500.610527', '中国.陕西省.渭南市.白水县', '1');
INSERT INTO `weiapp_region` VALUES ('610528', '富平县', '610500', '86.610000.610500.610528', '中国.陕西省.渭南市.富平县', '1');
INSERT INTO `weiapp_region` VALUES ('610581', '韩城市', '610500', '86.610000.610500.610581', '中国.陕西省.渭南市.韩城市', '1');
INSERT INTO `weiapp_region` VALUES ('610582', '华阴市', '610500', '86.610000.610500.610582', '中国.陕西省.渭南市.华阴市', '1');
INSERT INTO `weiapp_region` VALUES ('610602', '宝塔区', '610600', '86.610000.610600.610602', '中国.陕西省.延安市.宝塔区', '1');
INSERT INTO `weiapp_region` VALUES ('610621', '延长县', '610600', '86.610000.610600.610621', '中国.陕西省.延安市.延长县', '1');
INSERT INTO `weiapp_region` VALUES ('610622', '延川县', '610600', '86.610000.610600.610622', '中国.陕西省.延安市.延川县', '1');
INSERT INTO `weiapp_region` VALUES ('610623', '子长县', '610600', '86.610000.610600.610623', '中国.陕西省.延安市.子长县', '1');
INSERT INTO `weiapp_region` VALUES ('610624', '安塞县', '610600', '86.610000.610600.610624', '中国.陕西省.延安市.安塞县', '1');
INSERT INTO `weiapp_region` VALUES ('610625', '志丹县', '610600', '86.610000.610600.610625', '中国.陕西省.延安市.志丹县', '1');
INSERT INTO `weiapp_region` VALUES ('610626', '吴起县', '610600', '86.610000.610600.610626', '中国.陕西省.延安市.吴起县', '1');
INSERT INTO `weiapp_region` VALUES ('610627', '甘泉县', '610600', '86.610000.610600.610627', '中国.陕西省.延安市.甘泉县', '1');
INSERT INTO `weiapp_region` VALUES ('610628', '富县', '610600', '86.610000.610600.610628', '中国.陕西省.延安市.富县', '1');
INSERT INTO `weiapp_region` VALUES ('610629', '洛川县', '610600', '86.610000.610600.610629', '中国.陕西省.延安市.洛川县', '1');
INSERT INTO `weiapp_region` VALUES ('610630', '宜川县', '610600', '86.610000.610600.610630', '中国.陕西省.延安市.宜川县', '1');
INSERT INTO `weiapp_region` VALUES ('610631', '黄龙县', '610600', '86.610000.610600.610631', '中国.陕西省.延安市.黄龙县', '1');
INSERT INTO `weiapp_region` VALUES ('610632', '黄陵县', '610600', '86.610000.610600.610632', '中国.陕西省.延安市.黄陵县', '1');
INSERT INTO `weiapp_region` VALUES ('610702', '汉台区', '610700', '86.610000.610700.610702', '中国.陕西省.汉中市.汉台区', '1');
INSERT INTO `weiapp_region` VALUES ('610721', '南郑县', '610700', '86.610000.610700.610721', '中国.陕西省.汉中市.南郑县', '1');
INSERT INTO `weiapp_region` VALUES ('610722', '城固县', '610700', '86.610000.610700.610722', '中国.陕西省.汉中市.城固县', '1');
INSERT INTO `weiapp_region` VALUES ('610723', '洋县', '610700', '86.610000.610700.610723', '中国.陕西省.汉中市.洋县', '1');
INSERT INTO `weiapp_region` VALUES ('610724', '西乡县', '610700', '86.610000.610700.610724', '中国.陕西省.汉中市.西乡县', '1');
INSERT INTO `weiapp_region` VALUES ('610725', '勉县', '610700', '86.610000.610700.610725', '中国.陕西省.汉中市.勉县', '1');
INSERT INTO `weiapp_region` VALUES ('610726', '宁强县', '610700', '86.610000.610700.610726', '中国.陕西省.汉中市.宁强县', '1');
INSERT INTO `weiapp_region` VALUES ('610727', '略阳县', '610700', '86.610000.610700.610727', '中国.陕西省.汉中市.略阳县', '1');
INSERT INTO `weiapp_region` VALUES ('610728', '镇巴县', '610700', '86.610000.610700.610728', '中国.陕西省.汉中市.镇巴县', '1');
INSERT INTO `weiapp_region` VALUES ('610729', '留坝县', '610700', '86.610000.610700.610729', '中国.陕西省.汉中市.留坝县', '1');
INSERT INTO `weiapp_region` VALUES ('610730', '佛坪县', '610700', '86.610000.610700.610730', '中国.陕西省.汉中市.佛坪县', '1');
INSERT INTO `weiapp_region` VALUES ('610802', '榆阳区', '610800', '86.610000.610800.610802', '中国.陕西省.榆林市.榆阳区', '1');
INSERT INTO `weiapp_region` VALUES ('610821', '神木县', '610800', '86.610000.610800.610821', '中国.陕西省.榆林市.神木县', '1');
INSERT INTO `weiapp_region` VALUES ('610822', '府谷县', '610800', '86.610000.610800.610822', '中国.陕西省.榆林市.府谷县', '1');
INSERT INTO `weiapp_region` VALUES ('610823', '横山县', '610800', '86.610000.610800.610823', '中国.陕西省.榆林市.横山县', '1');
INSERT INTO `weiapp_region` VALUES ('610824', '靖边县', '610800', '86.610000.610800.610824', '中国.陕西省.榆林市.靖边县', '1');
INSERT INTO `weiapp_region` VALUES ('610825', '定边县', '610800', '86.610000.610800.610825', '中国.陕西省.榆林市.定边县', '1');
INSERT INTO `weiapp_region` VALUES ('610826', '绥德县', '610800', '86.610000.610800.610826', '中国.陕西省.榆林市.绥德县', '1');
INSERT INTO `weiapp_region` VALUES ('610827', '米脂县', '610800', '86.610000.610800.610827', '中国.陕西省.榆林市.米脂县', '1');
INSERT INTO `weiapp_region` VALUES ('610828', '佳县', '610800', '86.610000.610800.610828', '中国.陕西省.榆林市.佳县', '1');
INSERT INTO `weiapp_region` VALUES ('610829', '吴堡县', '610800', '86.610000.610800.610829', '中国.陕西省.榆林市.吴堡县', '1');
INSERT INTO `weiapp_region` VALUES ('610830', '清涧县', '610800', '86.610000.610800.610830', '中国.陕西省.榆林市.清涧县', '1');
INSERT INTO `weiapp_region` VALUES ('610831', '子洲县', '610800', '86.610000.610800.610831', '中国.陕西省.榆林市.子洲县', '1');
INSERT INTO `weiapp_region` VALUES ('610902', '汉滨区', '610900', '86.610000.610900.610902', '中国.陕西省.安康市.汉滨区', '1');
INSERT INTO `weiapp_region` VALUES ('610921', '汉阴县', '610900', '86.610000.610900.610921', '中国.陕西省.安康市.汉阴县', '1');
INSERT INTO `weiapp_region` VALUES ('610922', '石泉县', '610900', '86.610000.610900.610922', '中国.陕西省.安康市.石泉县', '1');
INSERT INTO `weiapp_region` VALUES ('610923', '宁陕县', '610900', '86.610000.610900.610923', '中国.陕西省.安康市.宁陕县', '1');
INSERT INTO `weiapp_region` VALUES ('610924', '紫阳县', '610900', '86.610000.610900.610924', '中国.陕西省.安康市.紫阳县', '1');
INSERT INTO `weiapp_region` VALUES ('610925', '岚皋县', '610900', '86.610000.610900.610925', '中国.陕西省.安康市.岚皋县', '1');
INSERT INTO `weiapp_region` VALUES ('610926', '平利县', '610900', '86.610000.610900.610926', '中国.陕西省.安康市.平利县', '1');
INSERT INTO `weiapp_region` VALUES ('610927', '镇坪县', '610900', '86.610000.610900.610927', '中国.陕西省.安康市.镇坪县', '1');
INSERT INTO `weiapp_region` VALUES ('610928', '旬阳县', '610900', '86.610000.610900.610928', '中国.陕西省.安康市.旬阳县', '1');
INSERT INTO `weiapp_region` VALUES ('610929', '白河县', '610900', '86.610000.610900.610929', '中国.陕西省.安康市.白河县', '1');
INSERT INTO `weiapp_region` VALUES ('611002', '商州区', '611000', '86.610000.611000.611002', '中国.陕西省.商洛市.商州区', '1');
INSERT INTO `weiapp_region` VALUES ('611021', '洛南县', '611000', '86.610000.611000.611021', '中国.陕西省.商洛市.洛南县', '1');
INSERT INTO `weiapp_region` VALUES ('611022', '丹凤县', '611000', '86.610000.611000.611022', '中国.陕西省.商洛市.丹凤县', '1');
INSERT INTO `weiapp_region` VALUES ('611023', '商南县', '611000', '86.610000.611000.611023', '中国.陕西省.商洛市.商南县', '1');
INSERT INTO `weiapp_region` VALUES ('611024', '山阳县', '611000', '86.610000.611000.611024', '中国.陕西省.商洛市.山阳县', '1');
INSERT INTO `weiapp_region` VALUES ('611025', '镇安县', '611000', '86.610000.611000.611025', '中国.陕西省.商洛市.镇安县', '1');
INSERT INTO `weiapp_region` VALUES ('611026', '柞水县', '611000', '86.610000.611000.611026', '中国.陕西省.商洛市.柞水县', '1');
INSERT INTO `weiapp_region` VALUES ('620102', '城关区', '620100', '86.620000.620100.620102', '中国.甘肃省.兰州市.城关区', '1');
INSERT INTO `weiapp_region` VALUES ('620103', '七里河区', '620100', '86.620000.620100.620103', '中国.甘肃省.兰州市.七里河区', '1');
INSERT INTO `weiapp_region` VALUES ('620104', '西固区', '620100', '86.620000.620100.620104', '中国.甘肃省.兰州市.西固区', '1');
INSERT INTO `weiapp_region` VALUES ('620105', '安宁区', '620100', '86.620000.620100.620105', '中国.甘肃省.兰州市.安宁区', '1');
INSERT INTO `weiapp_region` VALUES ('620111', '红古区', '620100', '86.620000.620100.620111', '中国.甘肃省.兰州市.红古区', '1');
INSERT INTO `weiapp_region` VALUES ('620121', '永登县', '620100', '86.620000.620100.620121', '中国.甘肃省.兰州市.永登县', '1');
INSERT INTO `weiapp_region` VALUES ('620122', '皋兰县', '620100', '86.620000.620100.620122', '中国.甘肃省.兰州市.皋兰县', '1');
INSERT INTO `weiapp_region` VALUES ('620123', '榆中县', '620100', '86.620000.620100.620123', '中国.甘肃省.兰州市.榆中县', '1');
INSERT INTO `weiapp_region` VALUES ('620302', '金川区', '620300', '86.620000.620300.620302', '中国.甘肃省.金昌市.金川区', '1');
INSERT INTO `weiapp_region` VALUES ('620321', '永昌县', '620300', '86.620000.620300.620321', '中国.甘肃省.金昌市.永昌县', '1');
INSERT INTO `weiapp_region` VALUES ('620402', '白银区', '620400', '86.620000.620400.620402', '中国.甘肃省.白银市.白银区', '1');
INSERT INTO `weiapp_region` VALUES ('620403', '平川区', '620400', '86.620000.620400.620403', '中国.甘肃省.白银市.平川区', '1');
INSERT INTO `weiapp_region` VALUES ('620421', '靖远县', '620400', '86.620000.620400.620421', '中国.甘肃省.白银市.靖远县', '1');
INSERT INTO `weiapp_region` VALUES ('620422', '会宁县', '620400', '86.620000.620400.620422', '中国.甘肃省.白银市.会宁县', '1');
INSERT INTO `weiapp_region` VALUES ('620423', '景泰县', '620400', '86.620000.620400.620423', '中国.甘肃省.白银市.景泰县', '1');
INSERT INTO `weiapp_region` VALUES ('620502', '秦州区', '620500', '86.620000.620500.620502', '中国.甘肃省.天水市.秦州区', '1');
INSERT INTO `weiapp_region` VALUES ('620503', '麦积区', '620500', '86.620000.620500.620503', '中国.甘肃省.天水市.麦积区', '1');
INSERT INTO `weiapp_region` VALUES ('620521', '清水县', '620500', '86.620000.620500.620521', '中国.甘肃省.天水市.清水县', '1');
INSERT INTO `weiapp_region` VALUES ('620522', '秦安县', '620500', '86.620000.620500.620522', '中国.甘肃省.天水市.秦安县', '1');
INSERT INTO `weiapp_region` VALUES ('620523', '甘谷县', '620500', '86.620000.620500.620523', '中国.甘肃省.天水市.甘谷县', '1');
INSERT INTO `weiapp_region` VALUES ('620524', '武山县', '620500', '86.620000.620500.620524', '中国.甘肃省.天水市.武山县', '1');
INSERT INTO `weiapp_region` VALUES ('620525', '张家川回族自治县', '620500', '86.620000.620500.620525', '中国.甘肃省.天水市.张家川回族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('620602', '凉州区', '620600', '86.620000.620600.620602', '中国.甘肃省.武威市.凉州区', '1');
INSERT INTO `weiapp_region` VALUES ('620621', '民勤县', '620600', '86.620000.620600.620621', '中国.甘肃省.武威市.民勤县', '1');
INSERT INTO `weiapp_region` VALUES ('620622', '古浪县', '620600', '86.620000.620600.620622', '中国.甘肃省.武威市.古浪县', '1');
INSERT INTO `weiapp_region` VALUES ('620623', '天祝藏族自治县', '620600', '86.620000.620600.620623', '中国.甘肃省.武威市.天祝藏族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('620702', '甘州区', '620700', '86.620000.620700.620702', '中国.甘肃省.张掖市.甘州区', '1');
INSERT INTO `weiapp_region` VALUES ('620721', '肃南裕固族自治县', '620700', '86.620000.620700.620721', '中国.甘肃省.张掖市.肃南裕固族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('620722', '民乐县', '620700', '86.620000.620700.620722', '中国.甘肃省.张掖市.民乐县', '1');
INSERT INTO `weiapp_region` VALUES ('620723', '临泽县', '620700', '86.620000.620700.620723', '中国.甘肃省.张掖市.临泽县', '1');
INSERT INTO `weiapp_region` VALUES ('620724', '高台县', '620700', '86.620000.620700.620724', '中国.甘肃省.张掖市.高台县', '1');
INSERT INTO `weiapp_region` VALUES ('620725', '山丹县', '620700', '86.620000.620700.620725', '中国.甘肃省.张掖市.山丹县', '1');
INSERT INTO `weiapp_region` VALUES ('620802', '崆峒区', '620800', '86.620000.620800.620802', '中国.甘肃省.平凉市.崆峒区', '1');
INSERT INTO `weiapp_region` VALUES ('620821', '泾川县', '620800', '86.620000.620800.620821', '中国.甘肃省.平凉市.泾川县', '1');
INSERT INTO `weiapp_region` VALUES ('620822', '灵台县', '620800', '86.620000.620800.620822', '中国.甘肃省.平凉市.灵台县', '1');
INSERT INTO `weiapp_region` VALUES ('620823', '崇信县', '620800', '86.620000.620800.620823', '中国.甘肃省.平凉市.崇信县', '1');
INSERT INTO `weiapp_region` VALUES ('620824', '华亭县', '620800', '86.620000.620800.620824', '中国.甘肃省.平凉市.华亭县', '1');
INSERT INTO `weiapp_region` VALUES ('620825', '庄浪县', '620800', '86.620000.620800.620825', '中国.甘肃省.平凉市.庄浪县', '1');
INSERT INTO `weiapp_region` VALUES ('620826', '静宁县', '620800', '86.620000.620800.620826', '中国.甘肃省.平凉市.静宁县', '1');
INSERT INTO `weiapp_region` VALUES ('620902', '肃州区', '620900', '86.620000.620900.620902', '中国.甘肃省.酒泉市.肃州区', '1');
INSERT INTO `weiapp_region` VALUES ('620921', '金塔县', '620900', '86.620000.620900.620921', '中国.甘肃省.酒泉市.金塔县', '1');
INSERT INTO `weiapp_region` VALUES ('620922', '瓜州县', '620900', '86.620000.620900.620922', '中国.甘肃省.酒泉市.瓜州县', '1');
INSERT INTO `weiapp_region` VALUES ('620923', '肃北蒙古族自治县', '620900', '86.620000.620900.620923', '中国.甘肃省.酒泉市.肃北蒙古族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('620924', '阿克塞哈萨克族自治县', '620900', '86.620000.620900.620924', '中国.甘肃省.酒泉市.阿克塞哈萨克族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('620981', '玉门市', '620900', '86.620000.620900.620981', '中国.甘肃省.酒泉市.玉门市', '1');
INSERT INTO `weiapp_region` VALUES ('620982', '敦煌市', '620900', '86.620000.620900.620982', '中国.甘肃省.酒泉市.敦煌市', '1');
INSERT INTO `weiapp_region` VALUES ('621002', '西峰区', '621000', '86.620000.621000.621002', '中国.甘肃省.庆阳市.西峰区', '1');
INSERT INTO `weiapp_region` VALUES ('621021', '庆城县', '621000', '86.620000.621000.621021', '中国.甘肃省.庆阳市.庆城县', '1');
INSERT INTO `weiapp_region` VALUES ('621022', '环县', '621000', '86.620000.621000.621022', '中国.甘肃省.庆阳市.环县', '1');
INSERT INTO `weiapp_region` VALUES ('621023', '华池县', '621000', '86.620000.621000.621023', '中国.甘肃省.庆阳市.华池县', '1');
INSERT INTO `weiapp_region` VALUES ('621024', '合水县', '621000', '86.620000.621000.621024', '中国.甘肃省.庆阳市.合水县', '1');
INSERT INTO `weiapp_region` VALUES ('621025', '正宁县', '621000', '86.620000.621000.621025', '中国.甘肃省.庆阳市.正宁县', '1');
INSERT INTO `weiapp_region` VALUES ('621026', '宁县', '621000', '86.620000.621000.621026', '中国.甘肃省.庆阳市.宁县', '1');
INSERT INTO `weiapp_region` VALUES ('621027', '镇原县', '621000', '86.620000.621000.621027', '中国.甘肃省.庆阳市.镇原县', '1');
INSERT INTO `weiapp_region` VALUES ('621102', '安定区', '621100', '86.620000.621100.621102', '中国.甘肃省.定西市.安定区', '1');
INSERT INTO `weiapp_region` VALUES ('621121', '通渭县', '621100', '86.620000.621100.621121', '中国.甘肃省.定西市.通渭县', '1');
INSERT INTO `weiapp_region` VALUES ('621122', '陇西县', '621100', '86.620000.621100.621122', '中国.甘肃省.定西市.陇西县', '1');
INSERT INTO `weiapp_region` VALUES ('621123', '渭源县', '621100', '86.620000.621100.621123', '中国.甘肃省.定西市.渭源县', '1');
INSERT INTO `weiapp_region` VALUES ('621124', '临洮县', '621100', '86.620000.621100.621124', '中国.甘肃省.定西市.临洮县', '1');
INSERT INTO `weiapp_region` VALUES ('621125', '漳县', '621100', '86.620000.621100.621125', '中国.甘肃省.定西市.漳县', '1');
INSERT INTO `weiapp_region` VALUES ('621126', '岷县', '621100', '86.620000.621100.621126', '中国.甘肃省.定西市.岷县', '1');
INSERT INTO `weiapp_region` VALUES ('621202', '武都区', '621200', '86.620000.621200.621202', '中国.甘肃省.陇南市.武都区', '1');
INSERT INTO `weiapp_region` VALUES ('621221', '成县', '621200', '86.620000.621200.621221', '中国.甘肃省.陇南市.成县', '1');
INSERT INTO `weiapp_region` VALUES ('621222', '文县', '621200', '86.620000.621200.621222', '中国.甘肃省.陇南市.文县', '1');
INSERT INTO `weiapp_region` VALUES ('621223', '宕昌县', '621200', '86.620000.621200.621223', '中国.甘肃省.陇南市.宕昌县', '1');
INSERT INTO `weiapp_region` VALUES ('621224', '康县', '621200', '86.620000.621200.621224', '中国.甘肃省.陇南市.康县', '1');
INSERT INTO `weiapp_region` VALUES ('621225', '西和县', '621200', '86.620000.621200.621225', '中国.甘肃省.陇南市.西和县', '1');
INSERT INTO `weiapp_region` VALUES ('621226', '礼县', '621200', '86.620000.621200.621226', '中国.甘肃省.陇南市.礼县', '1');
INSERT INTO `weiapp_region` VALUES ('621227', '徽县', '621200', '86.620000.621200.621227', '中国.甘肃省.陇南市.徽县', '1');
INSERT INTO `weiapp_region` VALUES ('621228', '两当县', '621200', '86.620000.621200.621228', '中国.甘肃省.陇南市.两当县', '1');
INSERT INTO `weiapp_region` VALUES ('622900', '临夏回族自治州', '620000', '86.620000.622900', '中国.甘肃省.临夏回族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('622901', '临夏市', '622900', '86.620000.622900.622901', '中国.甘肃省.临夏回族自治州.临夏市', '1');
INSERT INTO `weiapp_region` VALUES ('622921', '临夏县', '622900', '86.620000.622900.622921', '中国.甘肃省.临夏回族自治州.临夏县', '1');
INSERT INTO `weiapp_region` VALUES ('622922', '康乐县', '622900', '86.620000.622900.622922', '中国.甘肃省.临夏回族自治州.康乐县', '1');
INSERT INTO `weiapp_region` VALUES ('622923', '永靖县', '622900', '86.620000.622900.622923', '中国.甘肃省.临夏回族自治州.永靖县', '1');
INSERT INTO `weiapp_region` VALUES ('622924', '广河县', '622900', '86.620000.622900.622924', '中国.甘肃省.临夏回族自治州.广河县', '1');
INSERT INTO `weiapp_region` VALUES ('622925', '和政县', '622900', '86.620000.622900.622925', '中国.甘肃省.临夏回族自治州.和政县', '1');
INSERT INTO `weiapp_region` VALUES ('622926', '东乡族自治县', '622900', '86.620000.622900.622926', '中国.甘肃省.临夏回族自治州.东乡族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '622900', '86.620000.622900.622927', '中国.甘肃省.临夏回族自治州.积石山保安族东乡族撒拉族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('623000', '甘南藏族自治州', '620000', '86.620000.623000', '中国.甘肃省.甘南藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('623001', '合作市', '623000', '86.620000.623000.623001', '中国.甘肃省.甘南藏族自治州.合作市', '1');
INSERT INTO `weiapp_region` VALUES ('623021', '临潭县', '623000', '86.620000.623000.623021', '中国.甘肃省.甘南藏族自治州.临潭县', '1');
INSERT INTO `weiapp_region` VALUES ('623022', '卓尼县', '623000', '86.620000.623000.623022', '中国.甘肃省.甘南藏族自治州.卓尼县', '1');
INSERT INTO `weiapp_region` VALUES ('623023', '舟曲县', '623000', '86.620000.623000.623023', '中国.甘肃省.甘南藏族自治州.舟曲县', '1');
INSERT INTO `weiapp_region` VALUES ('623024', '迭部县', '623000', '86.620000.623000.623024', '中国.甘肃省.甘南藏族自治州.迭部县', '1');
INSERT INTO `weiapp_region` VALUES ('623025', '玛曲县', '623000', '86.620000.623000.623025', '中国.甘肃省.甘南藏族自治州.玛曲县', '1');
INSERT INTO `weiapp_region` VALUES ('623026', '碌曲县', '623000', '86.620000.623000.623026', '中国.甘肃省.甘南藏族自治州.碌曲县', '1');
INSERT INTO `weiapp_region` VALUES ('623027', '夏河县', '623000', '86.620000.623000.623027', '中国.甘肃省.甘南藏族自治州.夏河县', '1');
INSERT INTO `weiapp_region` VALUES ('630102', '城东区', '630100', '86.630000.630100.630102', '中国.青海省.西宁市.城东区', '1');
INSERT INTO `weiapp_region` VALUES ('630103', '城中区', '630100', '86.630000.630100.630103', '中国.青海省.西宁市.城中区', '1');
INSERT INTO `weiapp_region` VALUES ('630104', '城西区', '630100', '86.630000.630100.630104', '中国.青海省.西宁市.城西区', '1');
INSERT INTO `weiapp_region` VALUES ('630105', '城北区', '630100', '86.630000.630100.630105', '中国.青海省.西宁市.城北区', '1');
INSERT INTO `weiapp_region` VALUES ('630121', '大通回族土族自治县', '630100', '86.630000.630100.630121', '中国.青海省.西宁市.大通回族土族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('630122', '湟中县', '630100', '86.630000.630100.630122', '中国.青海省.西宁市.湟中县', '1');
INSERT INTO `weiapp_region` VALUES ('630123', '湟源县', '630100', '86.630000.630100.630123', '中国.青海省.西宁市.湟源县', '1');
INSERT INTO `weiapp_region` VALUES ('632100', '海东地区', '630000', '86.630000.632100', '中国.青海省.海东地区', '1');
INSERT INTO `weiapp_region` VALUES ('632121', '平安县', '632100', '86.630000.632100.632121', '中国.青海省.海东地区.平安县', '1');
INSERT INTO `weiapp_region` VALUES ('632122', '民和回族土族自治县', '632100', '86.630000.632100.632122', '中国.青海省.海东地区.民和回族土族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('632123', '乐都县', '632100', '86.630000.632100.632123', '中国.青海省.海东地区.乐都县', '1');
INSERT INTO `weiapp_region` VALUES ('632126', '互助土族自治县', '632100', '86.630000.632100.632126', '中国.青海省.海东地区.互助土族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('632127', '化隆回族自治县', '632100', '86.630000.632100.632127', '中国.青海省.海东地区.化隆回族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('632128', '循化撒拉族自治县', '632100', '86.630000.632100.632128', '中国.青海省.海东地区.循化撒拉族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('632200', '海北藏族自治州', '630000', '86.630000.632200', '中国.青海省.海北藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('632221', '门源回族自治县', '632200', '86.630000.632200.632221', '中国.青海省.海北藏族自治州.门源回族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('632222', '祁连县', '632200', '86.630000.632200.632222', '中国.青海省.海北藏族自治州.祁连县', '1');
INSERT INTO `weiapp_region` VALUES ('632223', '海晏县', '632200', '86.630000.632200.632223', '中国.青海省.海北藏族自治州.海晏县', '1');
INSERT INTO `weiapp_region` VALUES ('632224', '刚察县', '632200', '86.630000.632200.632224', '中国.青海省.海北藏族自治州.刚察县', '1');
INSERT INTO `weiapp_region` VALUES ('632300', '黄南藏族自治州', '630000', '86.630000.632300', '中国.青海省.黄南藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('632321', '同仁县', '632300', '86.630000.632300.632321', '中国.青海省.黄南藏族自治州.同仁县', '1');
INSERT INTO `weiapp_region` VALUES ('632322', '尖扎县', '632300', '86.630000.632300.632322', '中国.青海省.黄南藏族自治州.尖扎县', '1');
INSERT INTO `weiapp_region` VALUES ('632323', '泽库县', '632300', '86.630000.632300.632323', '中国.青海省.黄南藏族自治州.泽库县', '1');
INSERT INTO `weiapp_region` VALUES ('632324', '河南蒙古族自治县', '632300', '86.630000.632300.632324', '中国.青海省.黄南藏族自治州.河南蒙古族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('632500', '海南藏族自治州', '630000', '86.630000.632500', '中国.青海省.海南藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('632521', '共和县', '632500', '86.630000.632500.632521', '中国.青海省.海南藏族自治州.共和县', '1');
INSERT INTO `weiapp_region` VALUES ('632522', '同德县', '632500', '86.630000.632500.632522', '中国.青海省.海南藏族自治州.同德县', '1');
INSERT INTO `weiapp_region` VALUES ('632523', '贵德县', '632500', '86.630000.632500.632523', '中国.青海省.海南藏族自治州.贵德县', '1');
INSERT INTO `weiapp_region` VALUES ('632524', '兴海县', '632500', '86.630000.632500.632524', '中国.青海省.海南藏族自治州.兴海县', '1');
INSERT INTO `weiapp_region` VALUES ('632525', '贵南县', '632500', '86.630000.632500.632525', '中国.青海省.海南藏族自治州.贵南县', '1');
INSERT INTO `weiapp_region` VALUES ('632600', '果洛藏族自治州', '630000', '86.630000.632600', '中国.青海省.果洛藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('632621', '玛沁县', '632600', '86.630000.632600.632621', '中国.青海省.果洛藏族自治州.玛沁县', '1');
INSERT INTO `weiapp_region` VALUES ('632622', '班玛县', '632600', '86.630000.632600.632622', '中国.青海省.果洛藏族自治州.班玛县', '1');
INSERT INTO `weiapp_region` VALUES ('632623', '甘德县', '632600', '86.630000.632600.632623', '中国.青海省.果洛藏族自治州.甘德县', '1');
INSERT INTO `weiapp_region` VALUES ('632624', '达日县', '632600', '86.630000.632600.632624', '中国.青海省.果洛藏族自治州.达日县', '1');
INSERT INTO `weiapp_region` VALUES ('632625', '久治县', '632600', '86.630000.632600.632625', '中国.青海省.果洛藏族自治州.久治县', '1');
INSERT INTO `weiapp_region` VALUES ('632626', '玛多县', '632600', '86.630000.632600.632626', '中国.青海省.果洛藏族自治州.玛多县', '1');
INSERT INTO `weiapp_region` VALUES ('632700', '玉树藏族自治州', '630000', '86.630000.632700', '中国.青海省.玉树藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('632721', '玉树县', '632700', '86.630000.632700.632721', '中国.青海省.玉树藏族自治州.玉树县', '1');
INSERT INTO `weiapp_region` VALUES ('632722', '杂多县', '632700', '86.630000.632700.632722', '中国.青海省.玉树藏族自治州.杂多县', '1');
INSERT INTO `weiapp_region` VALUES ('632723', '称多县', '632700', '86.630000.632700.632723', '中国.青海省.玉树藏族自治州.称多县', '1');
INSERT INTO `weiapp_region` VALUES ('632724', '治多县', '632700', '86.630000.632700.632724', '中国.青海省.玉树藏族自治州.治多县', '1');
INSERT INTO `weiapp_region` VALUES ('632725', '囊谦县', '632700', '86.630000.632700.632725', '中国.青海省.玉树藏族自治州.囊谦县', '1');
INSERT INTO `weiapp_region` VALUES ('632726', '曲麻莱县', '632700', '86.630000.632700.632726', '中国.青海省.玉树藏族自治州.曲麻莱县', '1');
INSERT INTO `weiapp_region` VALUES ('632800', '海西蒙古族藏族自治州', '630000', '86.630000.632800', '中国.青海省.海西蒙古族藏族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('632801', '格尔木市', '632800', '86.630000.632800.632801', '中国.青海省.海西蒙古族藏族自治州.格尔木市', '1');
INSERT INTO `weiapp_region` VALUES ('632802', '德令哈市', '632800', '86.630000.632800.632802', '中国.青海省.海西蒙古族藏族自治州.德令哈市', '1');
INSERT INTO `weiapp_region` VALUES ('632821', '乌兰县', '632800', '86.630000.632800.632821', '中国.青海省.海西蒙古族藏族自治州.乌兰县', '1');
INSERT INTO `weiapp_region` VALUES ('632822', '都兰县', '632800', '86.630000.632800.632822', '中国.青海省.海西蒙古族藏族自治州.都兰县', '1');
INSERT INTO `weiapp_region` VALUES ('632823', '天峻县', '632800', '86.630000.632800.632823', '中国.青海省.海西蒙古族藏族自治州.天峻县', '1');
INSERT INTO `weiapp_region` VALUES ('640000', '宁夏回族自治区', '86', '86.640000', '中国.宁夏回族自治区', '1');
INSERT INTO `weiapp_region` VALUES ('640100', '银川市', '640000', '86.640000.640100', '中国.宁夏回族自治区.银川市', '1');
INSERT INTO `weiapp_region` VALUES ('640104', '兴庆区', '640100', '86.640000.640100.640104', '中国.宁夏回族自治区.银川市.兴庆区', '1');
INSERT INTO `weiapp_region` VALUES ('640105', '西夏区', '640100', '86.640000.640100.640105', '中国.宁夏回族自治区.银川市.西夏区', '1');
INSERT INTO `weiapp_region` VALUES ('640106', '金凤区', '640100', '86.640000.640100.640106', '中国.宁夏回族自治区.银川市.金凤区', '1');
INSERT INTO `weiapp_region` VALUES ('640121', '永宁县', '640100', '86.640000.640100.640121', '中国.宁夏回族自治区.银川市.永宁县', '1');
INSERT INTO `weiapp_region` VALUES ('640122', '贺兰县', '640100', '86.640000.640100.640122', '中国.宁夏回族自治区.银川市.贺兰县', '1');
INSERT INTO `weiapp_region` VALUES ('640181', '灵武市', '640100', '86.640000.640100.640181', '中国.宁夏回族自治区.银川市.灵武市', '1');
INSERT INTO `weiapp_region` VALUES ('640200', '石嘴山市', '640000', '86.640000.640200', '中国.宁夏回族自治区.石嘴山市', '1');
INSERT INTO `weiapp_region` VALUES ('640202', '大武口区', '640200', '86.640000.640200.640202', '中国.宁夏回族自治区.石嘴山市.大武口区', '1');
INSERT INTO `weiapp_region` VALUES ('640205', '惠农区', '640200', '86.640000.640200.640205', '中国.宁夏回族自治区.石嘴山市.惠农区', '1');
INSERT INTO `weiapp_region` VALUES ('640221', '平罗县', '640200', '86.640000.640200.640221', '中国.宁夏回族自治区.石嘴山市.平罗县', '1');
INSERT INTO `weiapp_region` VALUES ('640300', '吴忠市', '640000', '86.640000.640300', '中国.宁夏回族自治区.吴忠市', '1');
INSERT INTO `weiapp_region` VALUES ('640302', '利通区', '640300', '86.640000.640300.640302', '中国.宁夏回族自治区.吴忠市.利通区', '1');
INSERT INTO `weiapp_region` VALUES ('640303', '红寺堡区', '640300', '86.640000.640300.640303', '中国.宁夏回族自治区.吴忠市.红寺堡区', '1');
INSERT INTO `weiapp_region` VALUES ('640323', '盐池县', '640300', '86.640000.640300.640323', '中国.宁夏回族自治区.吴忠市.盐池县', '1');
INSERT INTO `weiapp_region` VALUES ('640324', '同心县', '640300', '86.640000.640300.640324', '中国.宁夏回族自治区.吴忠市.同心县', '1');
INSERT INTO `weiapp_region` VALUES ('640381', '青铜峡市', '640300', '86.640000.640300.640381', '中国.宁夏回族自治区.吴忠市.青铜峡市', '1');
INSERT INTO `weiapp_region` VALUES ('640400', '固原市', '640000', '86.640000.640400', '中国.宁夏回族自治区.固原市', '1');
INSERT INTO `weiapp_region` VALUES ('640402', '原州区', '640400', '86.640000.640400.640402', '中国.宁夏回族自治区.固原市.原州区', '1');
INSERT INTO `weiapp_region` VALUES ('640422', '西吉县', '640400', '86.640000.640400.640422', '中国.宁夏回族自治区.固原市.西吉县', '1');
INSERT INTO `weiapp_region` VALUES ('640423', '隆德县', '640400', '86.640000.640400.640423', '中国.宁夏回族自治区.固原市.隆德县', '1');
INSERT INTO `weiapp_region` VALUES ('640424', '泾源县', '640400', '86.640000.640400.640424', '中国.宁夏回族自治区.固原市.泾源县', '1');
INSERT INTO `weiapp_region` VALUES ('640425', '彭阳县', '640400', '86.640000.640400.640425', '中国.宁夏回族自治区.固原市.彭阳县', '1');
INSERT INTO `weiapp_region` VALUES ('640500', '中卫市', '640000', '86.640000.640500', '中国.宁夏回族自治区.中卫市', '1');
INSERT INTO `weiapp_region` VALUES ('640502', '沙坡头区', '640500', '86.640000.640500.640502', '中国.宁夏回族自治区.中卫市.沙坡头区', '1');
INSERT INTO `weiapp_region` VALUES ('640521', '中宁县', '640500', '86.640000.640500.640521', '中国.宁夏回族自治区.中卫市.中宁县', '1');
INSERT INTO `weiapp_region` VALUES ('640522', '海原县', '640500', '86.640000.640500.640522', '中国.宁夏回族自治区.中卫市.海原县', '1');
INSERT INTO `weiapp_region` VALUES ('650000', '新疆维吾尔自治区', '86', '86.650000', '中国.新疆维吾尔自治区', '1');
INSERT INTO `weiapp_region` VALUES ('650100', '乌鲁木齐市', '650000', '86.650000.650100', '中国.新疆维吾尔自治区.乌鲁木齐市', '1');
INSERT INTO `weiapp_region` VALUES ('650102', '天山区', '650100', '86.650000.650100.650102', '中国.新疆维吾尔自治区.乌鲁木齐市.天山区', '1');
INSERT INTO `weiapp_region` VALUES ('650103', '沙依巴克区', '650100', '86.650000.650100.650103', '中国.新疆维吾尔自治区.乌鲁木齐市.沙依巴克区', '1');
INSERT INTO `weiapp_region` VALUES ('650104', '新市区', '650100', '86.650000.650100.650104', '中国.新疆维吾尔自治区.乌鲁木齐市.新市区', '1');
INSERT INTO `weiapp_region` VALUES ('650105', '水磨沟区', '650100', '86.650000.650100.650105', '中国.新疆维吾尔自治区.乌鲁木齐市.水磨沟区', '1');
INSERT INTO `weiapp_region` VALUES ('650106', '头屯河区', '650100', '86.650000.650100.650106', '中国.新疆维吾尔自治区.乌鲁木齐市.头屯河区', '1');
INSERT INTO `weiapp_region` VALUES ('650107', '达坂城区', '650100', '86.650000.650100.650107', '中国.新疆维吾尔自治区.乌鲁木齐市.达坂城区', '1');
INSERT INTO `weiapp_region` VALUES ('650109', '米东区', '650100', '86.650000.650100.650109', '中国.新疆维吾尔自治区.乌鲁木齐市.米东区', '1');
INSERT INTO `weiapp_region` VALUES ('650121', '乌鲁木齐县', '650100', '86.650000.650100.650121', '中国.新疆维吾尔自治区.乌鲁木齐市.乌鲁木齐县', '1');
INSERT INTO `weiapp_region` VALUES ('650200', '克拉玛依市', '650000', '86.650000.650200', '中国.新疆维吾尔自治区.克拉玛依市', '1');
INSERT INTO `weiapp_region` VALUES ('650202', '独山子区', '650200', '86.650000.650200.650202', '中国.新疆维吾尔自治区.克拉玛依市.独山子区', '1');
INSERT INTO `weiapp_region` VALUES ('650203', '克拉玛依区', '650200', '86.650000.650200.650203', '中国.新疆维吾尔自治区.克拉玛依市.克拉玛依区', '1');
INSERT INTO `weiapp_region` VALUES ('650204', '白碱滩区', '650200', '86.650000.650200.650204', '中国.新疆维吾尔自治区.克拉玛依市.白碱滩区', '1');
INSERT INTO `weiapp_region` VALUES ('650205', '乌尔禾区', '650200', '86.650000.650200.650205', '中国.新疆维吾尔自治区.克拉玛依市.乌尔禾区', '1');
INSERT INTO `weiapp_region` VALUES ('652100', '吐鲁番地区', '650000', '86.650000.652100', '中国.新疆维吾尔自治区.吐鲁番地区', '1');
INSERT INTO `weiapp_region` VALUES ('652101', '吐鲁番市', '652100', '86.650000.652100.652101', '中国.新疆维吾尔自治区.吐鲁番地区.吐鲁番市', '1');
INSERT INTO `weiapp_region` VALUES ('652122', '鄯善县', '652100', '86.650000.652100.652122', '中国.新疆维吾尔自治区.吐鲁番地区.鄯善县', '1');
INSERT INTO `weiapp_region` VALUES ('652123', '托克逊县', '652100', '86.650000.652100.652123', '中国.新疆维吾尔自治区.吐鲁番地区.托克逊县', '1');
INSERT INTO `weiapp_region` VALUES ('652200', '哈密地区', '650000', '86.650000.652200', '中国.新疆维吾尔自治区.哈密地区', '1');
INSERT INTO `weiapp_region` VALUES ('652201', '哈密市', '652200', '86.650000.652200.652201', '中国.新疆维吾尔自治区.哈密地区.哈密市', '1');
INSERT INTO `weiapp_region` VALUES ('652222', '巴里坤哈萨克自治县', '652200', '86.650000.652200.652222', '中国.新疆维吾尔自治区.哈密地区.巴里坤哈萨克自治县', '1');
INSERT INTO `weiapp_region` VALUES ('652223', '伊吾县', '652200', '86.650000.652200.652223', '中国.新疆维吾尔自治区.哈密地区.伊吾县', '1');
INSERT INTO `weiapp_region` VALUES ('652300', '昌吉回族自治州', '650000', '86.650000.652300', '中国.新疆维吾尔自治区.昌吉回族自治州', '1');
INSERT INTO `weiapp_region` VALUES ('652301', '昌吉市', '652300', '86.650000.652300.652301', '中国.新疆维吾尔自治区.昌吉回族自治州.昌吉市', '1');
INSERT INTO `weiapp_region` VALUES ('652302', '阜康市', '652300', '86.650000.652300.652302', '中国.新疆维吾尔自治区.昌吉回族自治州.阜康市', '1');
INSERT INTO `weiapp_region` VALUES ('652323', '呼图壁县', '652300', '86.650000.652300.652323', '中国.新疆维吾尔自治区.昌吉回族自治州.呼图壁县', '1');
INSERT INTO `weiapp_region` VALUES ('652324', '玛纳斯县', '652300', '86.650000.652300.652324', '中国.新疆维吾尔自治区.昌吉回族自治州.玛纳斯县', '1');
INSERT INTO `weiapp_region` VALUES ('652325', '奇台县', '652300', '86.650000.652300.652325', '中国.新疆维吾尔自治区.昌吉回族自治州.奇台县', '1');
INSERT INTO `weiapp_region` VALUES ('652327', '吉木萨尔县', '652300', '86.650000.652300.652327', '中国.新疆维吾尔自治区.昌吉回族自治州.吉木萨尔县', '1');
INSERT INTO `weiapp_region` VALUES ('652328', '木垒哈萨克自治县', '652300', '86.650000.652300.652328', '中国.新疆维吾尔自治区.昌吉回族自治州.木垒哈萨克自治县', '1');
INSERT INTO `weiapp_region` VALUES ('652700', '博尔塔拉蒙古自治州', '650000', '86.650000.652700', '中国.新疆维吾尔自治区.博尔塔拉蒙古自治州', '1');
INSERT INTO `weiapp_region` VALUES ('652701', '博乐市', '652700', '86.650000.652700.652701', '中国.新疆维吾尔自治区.博尔塔拉蒙古自治州.博乐市', '1');
INSERT INTO `weiapp_region` VALUES ('652722', '精河县', '652700', '86.650000.652700.652722', '中国.新疆维吾尔自治区.博尔塔拉蒙古自治州.精河县', '1');
INSERT INTO `weiapp_region` VALUES ('652723', '温泉县', '652700', '86.650000.652700.652723', '中国.新疆维吾尔自治区.博尔塔拉蒙古自治州.温泉县', '1');
INSERT INTO `weiapp_region` VALUES ('652800', '巴音郭楞蒙古自治州', '650000', '86.650000.652800', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州', '1');
INSERT INTO `weiapp_region` VALUES ('652801', '库尔勒市', '652800', '86.650000.652800.652801', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.库尔勒市', '1');
INSERT INTO `weiapp_region` VALUES ('652822', '轮台县', '652800', '86.650000.652800.652822', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.轮台县', '1');
INSERT INTO `weiapp_region` VALUES ('652823', '尉犁县', '652800', '86.650000.652800.652823', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.尉犁县', '1');
INSERT INTO `weiapp_region` VALUES ('652824', '若羌县', '652800', '86.650000.652800.652824', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.若羌县', '1');
INSERT INTO `weiapp_region` VALUES ('652825', '且末县', '652800', '86.650000.652800.652825', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.且末县', '1');
INSERT INTO `weiapp_region` VALUES ('652826', '焉耆回族自治县', '652800', '86.650000.652800.652826', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.焉耆回族自治县', '1');
INSERT INTO `weiapp_region` VALUES ('652827', '和静县', '652800', '86.650000.652800.652827', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.和静县', '1');
INSERT INTO `weiapp_region` VALUES ('652828', '和硕县', '652800', '86.650000.652800.652828', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.和硕县', '1');
INSERT INTO `weiapp_region` VALUES ('652829', '博湖县', '652800', '86.650000.652800.652829', '中国.新疆维吾尔自治区.巴音郭楞蒙古自治州.博湖县', '1');
INSERT INTO `weiapp_region` VALUES ('652900', '阿克苏地区', '650000', '86.650000.652900', '中国.新疆维吾尔自治区.阿克苏地区', '1');
INSERT INTO `weiapp_region` VALUES ('652901', '阿克苏市', '652900', '86.650000.652900.652901', '中国.新疆维吾尔自治区.阿克苏地区.阿克苏市', '1');
INSERT INTO `weiapp_region` VALUES ('652922', '温宿县', '652900', '86.650000.652900.652922', '中国.新疆维吾尔自治区.阿克苏地区.温宿县', '1');
INSERT INTO `weiapp_region` VALUES ('652923', '库车县', '652900', '86.650000.652900.652923', '中国.新疆维吾尔自治区.阿克苏地区.库车县', '1');
INSERT INTO `weiapp_region` VALUES ('652924', '沙雅县', '652900', '86.650000.652900.652924', '中国.新疆维吾尔自治区.阿克苏地区.沙雅县', '1');
INSERT INTO `weiapp_region` VALUES ('652925', '新和县', '652900', '86.650000.652900.652925', '中国.新疆维吾尔自治区.阿克苏地区.新和县', '1');
INSERT INTO `weiapp_region` VALUES ('652926', '拜城县', '652900', '86.650000.652900.652926', '中国.新疆维吾尔自治区.阿克苏地区.拜城县', '1');
INSERT INTO `weiapp_region` VALUES ('652927', '乌什县', '652900', '86.650000.652900.652927', '中国.新疆维吾尔自治区.阿克苏地区.乌什县', '1');
INSERT INTO `weiapp_region` VALUES ('652928', '阿瓦提县', '652900', '86.650000.652900.652928', '中国.新疆维吾尔自治区.阿克苏地区.阿瓦提县', '1');
INSERT INTO `weiapp_region` VALUES ('652929', '柯坪县', '652900', '86.650000.652900.652929', '中国.新疆维吾尔自治区.阿克苏地区.柯坪县', '1');
INSERT INTO `weiapp_region` VALUES ('653000', '克孜勒苏柯尔克孜自治州', '650000', '86.650000.653000', '中国.新疆维吾尔自治区.克孜勒苏柯尔克孜自治州', '1');
INSERT INTO `weiapp_region` VALUES ('653001', '阿图什市', '653000', '86.650000.653000.653001', '中国.新疆维吾尔自治区.克孜勒苏柯尔克孜自治州.阿图什市', '1');
INSERT INTO `weiapp_region` VALUES ('653022', '阿克陶县', '653000', '86.650000.653000.653022', '中国.新疆维吾尔自治区.克孜勒苏柯尔克孜自治州.阿克陶县', '1');
INSERT INTO `weiapp_region` VALUES ('653023', '阿合奇县', '653000', '86.650000.653000.653023', '中国.新疆维吾尔自治区.克孜勒苏柯尔克孜自治州.阿合奇县', '1');
INSERT INTO `weiapp_region` VALUES ('653024', '乌恰县', '653000', '86.650000.653000.653024', '中国.新疆维吾尔自治区.克孜勒苏柯尔克孜自治州.乌恰县', '1');
INSERT INTO `weiapp_region` VALUES ('653100', '喀什地区', '650000', '86.650000.653100', '中国.新疆维吾尔自治区.喀什地区', '1');
INSERT INTO `weiapp_region` VALUES ('653101', '喀什市', '653100', '86.650000.653100.653101', '中国.新疆维吾尔自治区.喀什地区.喀什市', '1');
INSERT INTO `weiapp_region` VALUES ('653121', '疏附县', '653100', '86.650000.653100.653121', '中国.新疆维吾尔自治区.喀什地区.疏附县', '1');
INSERT INTO `weiapp_region` VALUES ('653122', '疏勒县', '653100', '86.650000.653100.653122', '中国.新疆维吾尔自治区.喀什地区.疏勒县', '1');
INSERT INTO `weiapp_region` VALUES ('653123', '英吉沙县', '653100', '86.650000.653100.653123', '中国.新疆维吾尔自治区.喀什地区.英吉沙县', '1');
INSERT INTO `weiapp_region` VALUES ('653124', '泽普县', '653100', '86.650000.653100.653124', '中国.新疆维吾尔自治区.喀什地区.泽普县', '1');
INSERT INTO `weiapp_region` VALUES ('653125', '莎车县', '653100', '86.650000.653100.653125', '中国.新疆维吾尔自治区.喀什地区.莎车县', '1');
INSERT INTO `weiapp_region` VALUES ('653126', '叶城县', '653100', '86.650000.653100.653126', '中国.新疆维吾尔自治区.喀什地区.叶城县', '1');
INSERT INTO `weiapp_region` VALUES ('653127', '麦盖提县', '653100', '86.650000.653100.653127', '中国.新疆维吾尔自治区.喀什地区.麦盖提县', '1');
INSERT INTO `weiapp_region` VALUES ('653128', '岳普湖县', '653100', '86.650000.653100.653128', '中国.新疆维吾尔自治区.喀什地区.岳普湖县', '1');
INSERT INTO `weiapp_region` VALUES ('653129', '伽师县', '653100', '86.650000.653100.653129', '中国.新疆维吾尔自治区.喀什地区.伽师县', '1');
INSERT INTO `weiapp_region` VALUES ('653130', '巴楚县', '653100', '86.650000.653100.653130', '中国.新疆维吾尔自治区.喀什地区.巴楚县', '1');
INSERT INTO `weiapp_region` VALUES ('653131', '塔什库尔干塔吉克自治县', '653100', '86.650000.653100.653131', '中国.新疆维吾尔自治区.喀什地区.塔什库尔干塔吉克自治县', '1');
INSERT INTO `weiapp_region` VALUES ('653200', '和田地区', '650000', '86.650000.653200', '中国.新疆维吾尔自治区.和田地区', '1');
INSERT INTO `weiapp_region` VALUES ('653201', '和田市', '653200', '86.650000.653200.653201', '中国.新疆维吾尔自治区.和田地区.和田市', '1');
INSERT INTO `weiapp_region` VALUES ('653221', '和田县', '653200', '86.650000.653200.653221', '中国.新疆维吾尔自治区.和田地区.和田县', '1');
INSERT INTO `weiapp_region` VALUES ('653222', '墨玉县', '653200', '86.650000.653200.653222', '中国.新疆维吾尔自治区.和田地区.墨玉县', '1');
INSERT INTO `weiapp_region` VALUES ('653223', '皮山县', '653200', '86.650000.653200.653223', '中国.新疆维吾尔自治区.和田地区.皮山县', '1');
INSERT INTO `weiapp_region` VALUES ('653224', '洛浦县', '653200', '86.650000.653200.653224', '中国.新疆维吾尔自治区.和田地区.洛浦县', '1');
INSERT INTO `weiapp_region` VALUES ('653225', '策勒县', '653200', '86.650000.653200.653225', '中国.新疆维吾尔自治区.和田地区.策勒县', '1');
INSERT INTO `weiapp_region` VALUES ('653226', '于田县', '653200', '86.650000.653200.653226', '中国.新疆维吾尔自治区.和田地区.于田县', '1');
INSERT INTO `weiapp_region` VALUES ('653227', '民丰县', '653200', '86.650000.653200.653227', '中国.新疆维吾尔自治区.和田地区.民丰县', '1');
INSERT INTO `weiapp_region` VALUES ('654000', '伊犁哈萨克自治州', '650000', '86.650000.654000', '中国.新疆维吾尔自治区.伊犁哈萨克自治州', '1');
INSERT INTO `weiapp_region` VALUES ('654002', '伊宁市', '654000', '86.650000.654000.654002', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.伊宁市', '1');
INSERT INTO `weiapp_region` VALUES ('654003', '奎屯市', '654000', '86.650000.654000.654003', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.奎屯市', '1');
INSERT INTO `weiapp_region` VALUES ('654021', '伊宁县', '654000', '86.650000.654000.654021', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.伊宁县', '1');
INSERT INTO `weiapp_region` VALUES ('654022', '察布查尔锡伯自治县', '654000', '86.650000.654000.654022', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.察布查尔锡伯自治县', '1');
INSERT INTO `weiapp_region` VALUES ('654023', '霍城县', '654000', '86.650000.654000.654023', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.霍城县', '1');
INSERT INTO `weiapp_region` VALUES ('654024', '巩留县', '654000', '86.650000.654000.654024', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.巩留县', '1');
INSERT INTO `weiapp_region` VALUES ('654025', '新源县', '654000', '86.650000.654000.654025', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.新源县', '1');
INSERT INTO `weiapp_region` VALUES ('654026', '昭苏县', '654000', '86.650000.654000.654026', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.昭苏县', '1');
INSERT INTO `weiapp_region` VALUES ('654027', '特克斯县', '654000', '86.650000.654000.654027', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.特克斯县', '1');
INSERT INTO `weiapp_region` VALUES ('654028', '尼勒克县', '654000', '86.650000.654000.654028', '中国.新疆维吾尔自治区.伊犁哈萨克自治州.尼勒克县', '1');
INSERT INTO `weiapp_region` VALUES ('654200', '塔城地区', '650000', '86.650000.654200', '中国.新疆维吾尔自治区.塔城地区', '1');
INSERT INTO `weiapp_region` VALUES ('654201', '塔城市', '654200', '86.650000.654200.654201', '中国.新疆维吾尔自治区.塔城地区.塔城市', '1');
INSERT INTO `weiapp_region` VALUES ('654202', '乌苏市', '654200', '86.650000.654200.654202', '中国.新疆维吾尔自治区.塔城地区.乌苏市', '1');
INSERT INTO `weiapp_region` VALUES ('654221', '额敏县', '654200', '86.650000.654200.654221', '中国.新疆维吾尔自治区.塔城地区.额敏县', '1');
INSERT INTO `weiapp_region` VALUES ('654223', '沙湾县', '654200', '86.650000.654200.654223', '中国.新疆维吾尔自治区.塔城地区.沙湾县', '1');
INSERT INTO `weiapp_region` VALUES ('654224', '托里县', '654200', '86.650000.654200.654224', '中国.新疆维吾尔自治区.塔城地区.托里县', '1');
INSERT INTO `weiapp_region` VALUES ('654225', '裕民县', '654200', '86.650000.654200.654225', '中国.新疆维吾尔自治区.塔城地区.裕民县', '1');
INSERT INTO `weiapp_region` VALUES ('654226', '和布克赛尔蒙古自治县', '654200', '86.650000.654200.654226', '中国.新疆维吾尔自治区.塔城地区.和布克赛尔蒙古自治县', '1');
INSERT INTO `weiapp_region` VALUES ('654300', '阿勒泰地区', '650000', '86.650000.654300', '中国.新疆维吾尔自治区.阿勒泰地区', '1');
INSERT INTO `weiapp_region` VALUES ('654301', '阿勒泰市', '654300', '86.650000.654300.654301', '中国.新疆维吾尔自治区.阿勒泰地区.阿勒泰市', '1');
INSERT INTO `weiapp_region` VALUES ('654321', '布尔津县', '654300', '86.650000.654300.654321', '中国.新疆维吾尔自治区.阿勒泰地区.布尔津县', '1');
INSERT INTO `weiapp_region` VALUES ('654322', '富蕴县', '654300', '86.650000.654300.654322', '中国.新疆维吾尔自治区.阿勒泰地区.富蕴县', '1');
INSERT INTO `weiapp_region` VALUES ('654323', '福海县', '654300', '86.650000.654300.654323', '中国.新疆维吾尔自治区.阿勒泰地区.福海县', '1');
INSERT INTO `weiapp_region` VALUES ('654324', '哈巴河县', '654300', '86.650000.654300.654324', '中国.新疆维吾尔自治区.阿勒泰地区.哈巴河县', '1');
INSERT INTO `weiapp_region` VALUES ('654325', '青河县', '654300', '86.650000.654300.654325', '中国.新疆维吾尔自治区.阿勒泰地区.青河县', '1');
INSERT INTO `weiapp_region` VALUES ('654326', '吉木乃县', '654300', '86.650000.654300.654326', '中国.新疆维吾尔自治区.阿勒泰地区.吉木乃县', '1');
INSERT INTO `weiapp_region` VALUES ('659000', '自治区直辖县级行政区划', '650000', '86.650000.659000', '中国.新疆维吾尔自治区.自治区直辖县级行政区划', '1');
INSERT INTO `weiapp_region` VALUES ('659001', '石河子市', '659000', '86.650000.659000.659001', '中国.新疆维吾尔自治区.自治区直辖县级行政区划.石河子市', '1');
INSERT INTO `weiapp_region` VALUES ('659002', '阿拉尔市', '659000', '86.650000.659000.659002', '中国.新疆维吾尔自治区.自治区直辖县级行政区划.阿拉尔市', '1');
INSERT INTO `weiapp_region` VALUES ('659003', '图木舒克市', '659000', '86.650000.659000.659003', '中国.新疆维吾尔自治区.自治区直辖县级行政区划.图木舒克市', '1');
INSERT INTO `weiapp_region` VALUES ('659004', '五家渠市', '659000', '86.650000.659000.659004', '中国.新疆维吾尔自治区.自治区直辖县级行政区划.五家渠市', '1');

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
INSERT INTO `weiapp_ucenter_member` VALUES ('1', 'admin_wangzi', '5d73a192336f4977eb6061252a35b751', 'tonbochow@qq.com', '', '1428927667', '2130706433', '1428977259', '2130706433', '1428927667', '1');
INSERT INTO `weiapp_ucenter_member` VALUES ('2', 'tonbochow', '5d73a192336f4977eb6061252a35b751', 'tonbochow@163.com', '', '1428927621', '2130706433', '1428978103', '2130706433', '1428927621', '1');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信公众平台菜单';

-- ----------------------------
-- Records of weiapp_weixin_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_wx_card`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_wx_card`;
CREATE TABLE `weiapp_wx_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信公众平台id',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建卡劵用户id',
  `card_id` varchar(255) NOT NULL DEFAULT '' COMMENT '微信服务器返回的卡劵id',
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '商户自定义的卡劵code',
  `card_type` varchar(32) NOT NULL DEFAULT '' COMMENT '卡劵类型',
  `logo_url` varchar(255) NOT NULL DEFAULT '' COMMENT '对应micro_platform.card_pic_url 卡劵logo',
  `brand_name` varchar(60) NOT NULL DEFAULT '' COMMENT '微信公众平台名称',
  `code_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'code码展示类型',
  `title` varchar(9) NOT NULL DEFAULT '' COMMENT '劵名最多9个汉字',
  `sub_title` varchar(18) NOT NULL DEFAULT '' COMMENT '券名副标题最多18个汉字',
  `color` varchar(16) NOT NULL DEFAULT '' COMMENT '劵颜色值',
  `notice` varchar(16) NOT NULL DEFAULT '' COMMENT '使用提醒最多9个汉字',
  `service_phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固话或手机号码',
  `description` text NOT NULL COMMENT '使用说明最多1000汉字',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '使用时间的类型1固定日期区间2固定时长',
  `begin_timestamp` int(10) NOT NULL DEFAULT '0' COMMENT '固定日期区间专用表示起用时间',
  `end_timestamp` int(10) NOT NULL DEFAULT '0' COMMENT '固定日期区间专用表示结束时间',
  `fixed_term` int(10) NOT NULL DEFAULT '0' COMMENT '固定时长字领取后多少天内有效默认0当天有效',
  `fixed_begin_term` int(10) NOT NULL DEFAULT '0' COMMENT '固定时长 表示自领取后多少天开始生效',
  `quantity` int(10) NOT NULL DEFAULT '0' COMMENT '卡劵库存数量不支持填写0或无限大',
  `get_limit` int(10) NOT NULL DEFAULT '1' COMMENT '每人最大领取次数默认等于quantity',
  `use_custom_code` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自定义code默认false即0',
  `bind_openid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否指定用户领取默认false即0',
  `can_share` tinyint(1) NOT NULL DEFAULT '1' COMMENT '领取卡劵原生页面是否可分享默认true即1',
  `can_give_friend` tinyint(1) NOT NULL DEFAULT '1' COMMENT '卡劵是否可转赠默认true即1',
  `location_id_list` text NOT NULL COMMENT '门店位置id(微信服务器)',
  `url_name_type` varchar(64) NOT NULL DEFAULT '' COMMENT '商户自定义cell名称',
  `custom_url` varchar(255) NOT NULL DEFAULT '' COMMENT '商户自定义cell跳转外链的地址链接',
  `source` varchar(60) NOT NULL DEFAULT '' COMMENT '同brand_name第三方来源名',
  `deal_detail` text NOT NULL COMMENT '详细内容',
  `status` varchar(32) NOT NULL COMMENT '卡劵状态',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信卡劵表';

-- ----------------------------
-- Records of weiapp_wx_card
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_wx_card_color`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_wx_card_color`;
CREATE TABLE `weiapp_wx_card_color` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信公众平台id',
  `name` varchar(16) NOT NULL DEFAULT '' COMMENT '颜色名',
  `value` char(7) NOT NULL DEFAULT '' COMMENT '颜色值',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='微信卡劵颜色表';

-- ----------------------------
-- Records of weiapp_wx_card_color
-- ----------------------------
INSERT INTO `weiapp_wx_card_color` VALUES ('1', '1', 'Color010', '#55bd47', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('2', '1', 'Color020', '#10ad61', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('3', '1', 'Color030', '#35a4de', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('4', '1', 'Color040', '#3d78da', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('5', '1', 'Color050', '#9058cb', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('6', '1', 'Color060', '#de9c33', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('7', '1', 'Color070', '#ebac16', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('8', '1', 'Color080', '#f9861f', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('9', '1', 'Color081', '#f08500', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('10', '1', 'Color090', '#e75735', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('11', '1', 'Color100', '#d54036', '0', '0');
INSERT INTO `weiapp_wx_card_color` VALUES ('12', '1', 'Color101', '#cf3e36', '0', '0');

-- ----------------------------
-- Table structure for `weiapp_wx_card_diningroom`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_wx_card_diningroom`;
CREATE TABLE `weiapp_wx_card_diningroom` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信公众平台id',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '从微信服务器拉取门店信息用户id',
  `location_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信服务器门店id',
  `business_name` varchar(60) NOT NULL DEFAULT '' COMMENT '微信公众平台名称',
  `branch_name` varchar(60) NOT NULL DEFAULT '' COMMENT '分店名',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '固话或手机',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '门店详细地址',
  `longitude` decimal(17,14) NOT NULL DEFAULT '0.00000000000000' COMMENT '经度',
  `latitude` decimal(17,14) NOT NULL DEFAULT '0.00000000000000' COMMENT '纬度',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='从微信服务器拉取门店信息表';

-- ----------------------------
-- Records of weiapp_wx_card_diningroom
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_wx_card_record`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_wx_card_record`;
CREATE TABLE `weiapp_wx_card_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mp_id` int(10) NOT NULL DEFAULT '0' COMMENT '微信公众平台id',
  `fromusername_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '领劵方openid',
  `friendusername_openid` varchar(128) NOT NULL DEFAULT '' COMMENT '赠送方openid',
  `event` varchar(32) NOT NULL DEFAULT '' COMMENT '事件类型如user_get_card',
  `card_id` varchar(255) NOT NULL DEFAULT '' COMMENT '卡劵id',
  `isgive_byfriend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否赠送0否1是',
  `usercard_code` varchar(20) NOT NULL DEFAULT '' COMMENT 'code序列号',
  `outer_id` int(10) NOT NULL DEFAULT '0' COMMENT '领取的场景值',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='卡劵领取或删除记录表';

-- ----------------------------
-- Records of weiapp_wx_card_record
-- ----------------------------
