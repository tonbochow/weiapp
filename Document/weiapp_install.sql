/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : weiapp

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2015-02-07 15:44:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `weiapp_action`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_action`;
CREATE TABLE `weiapp_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '����',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '��ΪΨһ��ʶ',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '��Ϊ˵��',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '��Ϊ����',
  `rule` text NOT NULL COMMENT '��Ϊ����',
  `log` text NOT NULL COMMENT '��־����',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '����',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '״̬',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '�޸�ʱ��',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ϵͳ��Ϊ��';

-- ----------------------------
-- Records of weiapp_action
-- ----------------------------
INSERT INTO `weiapp_action` VALUES ('1', 'user_login', '�û���¼', '����+10��ÿ��һ��', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]��[time|time_format]��¼�˺�̨', '1', '1', '1387181220');
INSERT INTO `weiapp_action` VALUES ('2', 'add_article', '��������', '����+5��ÿ������5��', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `weiapp_action` VALUES ('3', 'review', '����', '���ۻ���+1��������', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `weiapp_action` VALUES ('4', 'add_document', '�����ĵ�', '����+10��ÿ������5��', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]��[time|time_format]������һƪ���¡�\r\n��[model]����¼���[record]��', '2', '0', '1386139726');
INSERT INTO `weiapp_action` VALUES ('5', 'add_document_topic', '��������', '����+5��ÿ������10��', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `weiapp_action` VALUES ('6', 'update_config', '��������', '�������޸Ļ�ɾ������', '', '', '1', '1', '1383294988');
INSERT INTO `weiapp_action` VALUES ('7', 'update_model', '����ģ��', '�������޸�ģ��', '', '', '1', '1', '1383295057');
INSERT INTO `weiapp_action` VALUES ('8', 'update_attribute', '��������', '��������»�ɾ������', '', '', '1', '1', '1383295963');
INSERT INTO `weiapp_action` VALUES ('9', 'update_channel', '���µ���', '�������޸Ļ�ɾ������', '', '', '1', '1', '1383296301');
INSERT INTO `weiapp_action` VALUES ('10', 'update_menu', '���²˵�', '�������޸Ļ�ɾ���˵�', '', '', '1', '1', '1383296392');
INSERT INTO `weiapp_action` VALUES ('11', 'update_category', '���·���', '�������޸Ļ�ɾ������', '', '', '1', '1', '1383296765');

-- ----------------------------
-- Table structure for `weiapp_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_action_log`;
CREATE TABLE `weiapp_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '��Ϊid',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ִ���û�id',
  `action_ip` bigint(20) NOT NULL COMMENT 'ִ����Ϊ��ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '������Ϊ�ı�',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '������Ϊ������id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '��־��ע',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '״̬',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ִ����Ϊ��ʱ��',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='��Ϊ��־��';

-- ----------------------------
-- Records of weiapp_action_log
-- ----------------------------
INSERT INTO `weiapp_action_log` VALUES ('1', '1', '1', '2130706433', 'member', '1', 'admin��2015-02-07 15:09��¼�˺�̨', '1', '1423292959');

-- ----------------------------
-- Table structure for `weiapp_addons`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_addons`;
CREATE TABLE `weiapp_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����',
  `name` varchar(40) NOT NULL COMMENT '��������ʶ',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '������',
  `description` text COMMENT '�������',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '״̬',
  `config` text COMMENT '����',
  `author` varchar(40) DEFAULT '' COMMENT '����',
  `version` varchar(20) DEFAULT '' COMMENT '�汾��',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '��װʱ��',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '�Ƿ��к�̨�б�',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='�����';

-- ----------------------------
-- Records of weiapp_addons
-- ----------------------------
INSERT INTO `weiapp_addons` VALUES ('15', 'EditorForAdmin', '��̨�༭��', '������ǿ��վ���ı����������ʾ', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `weiapp_addons` VALUES ('2', 'SiteStat', 'վ��ͳ����Ϣ', 'ͳ��վ��Ļ�����Ϣ', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `weiapp_addons` VALUES ('3', 'DevTeam', '�����Ŷ���Ϣ', '�����Ŷӳ�Ա��Ϣ', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `weiapp_addons` VALUES ('4', 'SystemInfo', 'ϵͳ������Ϣ', '������ʾһЩ����������Ϣ', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `weiapp_addons` VALUES ('5', 'Editor', 'ǰ̨�༭��', '������ǿ��վ���ı����������ʾ', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `weiapp_addons` VALUES ('6', 'Attachment', '����', '�����ĵ�ģ���ϴ�����', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `weiapp_addons` VALUES ('9', 'SocialComment', 'ͨ���罻������', '�����˸����罻�����۲�������ɼ��ɵ�ϵͳ�С�', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');

-- ----------------------------
-- Table structure for `weiapp_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_attachment`;
CREATE TABLE `weiapp_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '������ʾ��',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '��������',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '��ԴID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '������¼ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '���ش���',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '������С',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '�ϼ�Ŀ¼ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '����',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '״̬',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='������';

-- ----------------------------
-- Records of weiapp_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_attribute`;
CREATE TABLE `weiapp_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '�ֶ���',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '�ֶ�ע��',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '�ֶζ���',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '��������',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '�ֶ�Ĭ��ֵ',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '��ע',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '�Ƿ���ʾ',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '����',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ģ��id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '�Ƿ����',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '״̬',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='ģ�����Ա�';

-- ----------------------------
-- Records of weiapp_attribute
-- ----------------------------
INSERT INTO `weiapp_attribute` VALUES ('1', 'uid', '�û�ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('2', 'name', '��ʶ', 'char(40) NOT NULL ', 'string', '', 'ͬһ���ڵ��±�ʶ���ظ�', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('3', 'title', '����', 'char(80) NOT NULL ', 'string', '', '�ĵ�����', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('4', 'category_id', '��������', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('5', 'description', '����', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('6', 'root', '���ڵ�', 'int(10) unsigned NOT NULL ', 'num', '0', '���ĵ��Ķ����ĵ����', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('7', 'pid', '����ID', 'int(10) unsigned NOT NULL ', 'num', '0', '���ĵ����', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('8', 'model_id', '����ģ��ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '���ĵ�����Ӧ��ģ��', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('9', 'type', '��������', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:Ŀ¼\r\n2:����\r\n3:����', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('10', 'position', '�Ƽ�λ', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '����Ƽ������Ƽ�ֵ���', '1', '1:�б��Ƽ�\r\n2:Ƶ��ҳ�Ƽ�\r\n4:��ҳ�Ƽ�', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('11', 'link_id', '����', 'int(10) unsigned NOT NULL ', 'num', '0', '0-������������0-����ID,��Ҫ���������������ŵ�ת��', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('12', 'cover_id', '����', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-�޷��棬����0-����ͼƬID����Ҫ��������', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('13', 'display', '�ɼ���', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:���ɼ�\r\n1:�����˿ɼ�', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('14', 'deadline', '����ʱ��', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-������Ч', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('15', 'attach', '��������', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('16', 'view', '�����', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('17', 'comment', '������', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('18', 'extend', '��չͳ���ֶ�', 'int(10) unsigned NOT NULL ', 'num', '0', '������������ʹ��', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('19', 'level', '���ȼ�', 'int(10) unsigned NOT NULL ', 'num', '0', 'Խ������Խ��ǰ', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('20', 'create_time', '����ʱ��', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('21', 'update_time', '����ʱ��', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('22', 'status', '����״̬', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:ɾ��\r\n0:����\r\n1:����\r\n2:�����\r\n3:�ݸ�', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('23', 'parse', '���ݽ�������', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('24', 'content', '��������', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('25', 'template', '����ҳ��ʾģ��', 'varchar(100) NOT NULL ', 'string', '', '����display���������Ķ���', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('26', 'bookmark', '�ղ���', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('27', 'parse', '���ݽ�������', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `weiapp_attribute` VALUES ('28', 'content', '������ϸ����', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('29', 'template', '����ҳ��ʾģ��', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('30', 'file_id', '�ļ�ID', 'int(10) unsigned NOT NULL ', 'file', '0', '��Ҫ��������', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('31', 'download', '���ش���', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `weiapp_attribute` VALUES ('32', 'size', '�ļ���С', 'bigint(20) unsigned NOT NULL ', 'num', '0', '��λbit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for `weiapp_auth_extend`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_auth_extend`;
CREATE TABLE `weiapp_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '�û�id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '��չ�������ݵ�id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '��չ���ͱ�ʶ 1:��Ŀ����Ȩ��;2:ģ��Ȩ��',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='�û��������Ķ�Ӧ��ϵ��';

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
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '�û���id,��������',
  `module` varchar(20) NOT NULL COMMENT '�û�������ģ��',
  `type` tinyint(4) NOT NULL COMMENT '������',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '�û�����������',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '������Ϣ',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '�û���״̬��Ϊ1������Ϊ0����,-1Ϊɾ��',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '�û���ӵ�еĹ���id��������� , ����',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_auth_group
-- ----------------------------
INSERT INTO `weiapp_auth_group` VALUES ('1', 'admin', '1', 'Ĭ���û���', '', '1', '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106');
INSERT INTO `weiapp_auth_group` VALUES ('2', 'admin', '1', '�����û�', '�����û�', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');

-- ----------------------------
-- Table structure for `weiapp_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_auth_group_access`;
CREATE TABLE `weiapp_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '�û�id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '�û���id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_auth_group_access
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_auth_rule`;
CREATE TABLE `weiapp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '����id,��������',
  `module` varchar(20) NOT NULL COMMENT '��������module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-���˵�',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '����ΨһӢ�ı�ʶ',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '������������',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '�Ƿ���Ч(0:��Ч,1:��Ч)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '���򸽼�����',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_auth_rule
-- ----------------------------
INSERT INTO `weiapp_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '��ҳ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '�û�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '��չ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', 'ϵͳ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '�ı�״̬', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '����ݸ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '�ƶ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', 'ճ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '��ԭ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '�ĵ��б�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '����վ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '�����û���Ϊ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '�༭�û���Ϊ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '�����û���Ϊ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '�����Ϊ״̬', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '���û�Ա', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '���û�Ա', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', 'ɾ����Ա', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '�û���Ϣ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '�û���Ϊ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', 'ɾ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '�ָ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '�����û���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '��Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '������Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '��Ա��Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '�����Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '�����Ա��Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '������Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '���������Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', 'Ȩ�޹���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '��ⴴ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', 'Ԥ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '�������ɲ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '��װ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', 'ж��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '��������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '�����̨�б�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL��ʽ���ʲ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '�������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '���ӹ���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '�ı�״̬', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '��������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', 'ģ�͹���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', 'ɾ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '��վ����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '���ù���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', 'ɾ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '��������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', 'ɾ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '�������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '�ϴ��ؼ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '�ϴ�ͼƬ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', 'ģ����Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '�������ݿ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '��ԭ���ݿ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '�Ż���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '�޸���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '�ָ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', 'ɾ��', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '�����û�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '���Թ���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '�ı�״̬', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '��������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '����ģ����Ȩ', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '�ƶ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '�ϲ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '��̨�˵�����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '�˵�����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '�༭', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '���¹���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '���ع���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '���ù���', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '��Ϊ��־', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '�޸�����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '�޸��ǳ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '�鿴��Ϊ��־', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '��������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '�ĵ��б�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '�ı�״̬', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '����ݸ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '�ƶ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', 'ճ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '����վ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '��ԭ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '�����û�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '�û���Ϊ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '�����û���Ϊ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '�༭�û���Ϊ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '�����û���Ϊ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '�����Ϊ״̬', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '���û�Ա', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '���û�Ա', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', 'ɾ����Ա', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', 'Ȩ�޹���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', 'ɾ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '�ָ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '�����û���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '��Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '������Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '��Ա��Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '�����Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '�����Ա��Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '������Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '���������Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', 'ģ����Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '����ģ����Ȩ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '��ⴴ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', 'Ԥ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '�������ɲ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '��װ', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', 'ж��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '��������', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '�����̨�б�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL��ʽ���ʲ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '���ӹ���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', 'ģ�͹���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '�ı�״̬', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '��������', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '���Թ���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '�ı�״̬', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '��������', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '���ù���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', 'ɾ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '�˵�����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '��������', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', 'ɾ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '�������', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', 'ɾ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '�ƶ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '�ϲ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '�������ݿ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '�Ż���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '�޸���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '��ԭ���ݿ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '�ָ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', 'ɾ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '�༭', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', 'Ӧ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '���ع���', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', 'Ӧ��', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '��Ϊ��־', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '�޸�����', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '�޸��ǳ�', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '�鿴��Ϊ��־', '-1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '�༭����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '��������', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '�༭����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '�ĵ�����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '����', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '�ƶ�', '1', '');
INSERT INTO `weiapp_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '�ϲ�', '1', '');

-- ----------------------------
-- Table structure for `weiapp_category`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_category`;
CREATE TABLE `weiapp_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `name` varchar(30) NOT NULL COMMENT '��־',
  `title` varchar(50) NOT NULL COMMENT '����',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ϼ�����ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ͬ����Ч��',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '�б�ÿҳ����',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO����ҳ����',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '�ؼ���',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '����',
  `template_index` varchar(100) NOT NULL COMMENT 'Ƶ��ҳģ��',
  `template_lists` varchar(100) NOT NULL COMMENT '�б�ҳģ��',
  `template_detail` varchar(100) NOT NULL COMMENT '����ҳģ��',
  `template_edit` varchar(100) NOT NULL COMMENT '�༭ҳģ��',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '����ģ��',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '����������������',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '�Ƿ�����������',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '�ɼ���',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '�Ƿ�����ظ�',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '�����������Ƿ���Ҫ���',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '��չ����',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '����״̬',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ͼ��',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='�����';

-- ----------------------------
-- Records of weiapp_category
-- ----------------------------
INSERT INTO `weiapp_category` VALUES ('1', 'blog', '����', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1382701539', '1', '0');
INSERT INTO `weiapp_category` VALUES ('2', 'default_blog', 'Ĭ�Ϸ���', '1', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1386839751', '1', '31');

-- ----------------------------
-- Table structure for `weiapp_channel`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_channel`;
CREATE TABLE `weiapp_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Ƶ��ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ϼ�Ƶ��ID',
  `title` char(30) NOT NULL COMMENT 'Ƶ������',
  `url` char(100) NOT NULL COMMENT 'Ƶ������',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '��������',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '״̬',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '�´��ڴ�',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_channel
-- ----------------------------
INSERT INTO `weiapp_channel` VALUES ('1', '0', '��ҳ', 'Index/index', '1', '1379475111', '1379923177', '1', '0');
INSERT INTO `weiapp_channel` VALUES ('2', '0', '����', 'Article/index?category=blog', '2', '1379475131', '1379483713', '1', '0');
INSERT INTO `weiapp_channel` VALUES ('3', '0', '����', 'http://www.onethink.cn', '3', '1379475154', '1387163458', '1', '0');

-- ----------------------------
-- Table structure for `weiapp_config`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_config`;
CREATE TABLE `weiapp_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '��������',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '��������',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '����˵��',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '���÷���',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '����ֵ',
  `remark` varchar(100) NOT NULL COMMENT '����˵��',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '״̬',
  `value` text NOT NULL COMMENT '����ֵ',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '����',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_config
-- ----------------------------
INSERT INTO `weiapp_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '��վ����', '1', '', '��վ����ǰ̨��ʾ����', '1378898976', '1379235274', '1', 'OneThink���ݹ�����', '0');
INSERT INTO `weiapp_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '��վ����', '1', '', '��վ������������', '1378898976', '1379235841', '1', 'OneThink���ݹ�����', '1');
INSERT INTO `weiapp_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '��վ�ؼ���', '1', '', '��վ��������ؼ���', '1378898976', '1381390100', '1', 'ThinkPHP,OneThink', '8');
INSERT INTO `weiapp_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '�ر�վ��', '1', '0:�ر�,1:����', 'վ��رպ������û����ܷ��ʣ�����Ա������������', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `weiapp_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '���������б�', '4', '', '��Ҫ�������ݽ�����ҳ���������', '1378898976', '1379235348', '1', '0:����\r\n1:�ַ�\r\n2:�ı�\r\n3:����\r\n4:ö��', '2');
INSERT INTO `weiapp_config` VALUES ('10', 'WEB_SITE_ICP', '1', '��վ������', '1', '', '��������վ�ײ���ʾ�ı����ţ��硰��ICP��12007941��-2', '1378900335', '1379235859', '1', '', '9');
INSERT INTO `weiapp_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '�ĵ��Ƽ�λ', '2', '', '�ĵ��Ƽ�λ���Ƽ������λ��KEYֵ��Ӽ���', '1379053380', '1379235329', '1', '1:�б�ҳ�Ƽ�\r\n2:Ƶ��ҳ�Ƽ�\r\n4:��վ��ҳ�Ƽ�', '3');
INSERT INTO `weiapp_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '�ĵ��ɼ���', '2', '', '���¿ɼ��Խ�Ӱ��ǰ̨��ʾ����̨����Ӱ��', '1379056370', '1379235322', '1', '0:�����˿ɼ�\r\n1:��ע���Ա�ɼ�\r\n2:������Ա�ɼ�', '4');
INSERT INTO `weiapp_config` VALUES ('13', 'COLOR_STYLE', '4', '��̨ɫϵ', '1', 'default_color:Ĭ��\r\nblue_color:������', '��̨��ɫ���', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `weiapp_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '���÷���', '4', '', '���÷���', '1379228036', '1384418383', '1', '1:����\r\n2:����\r\n3:�û�\r\n4:ϵͳ', '4');
INSERT INTO `weiapp_config` VALUES ('21', 'HOOKS_TYPE', '3', '���ӵ�����', '4', '', '���� 1-������չ��ʾ���ݣ�2-������չҵ����', '1379313397', '1379313407', '1', '1:��ͼ\r\n2:������', '6');
INSERT INTO `weiapp_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth����', '4', '', '�Զ���Auth.class.php������', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `weiapp_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '�Ƿ����ݸ幦��', '2', '0:�رղݸ幦��\r\n1:�����ݸ幦��\r\n', '��������ʱ�Ĳݸ幦������', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `weiapp_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '�Զ�����ݸ�ʱ��', '2', '', '�Զ�����ݸ��ʱ��������λ����', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `weiapp_config` VALUES ('25', 'LIST_ROWS', '0', '��̨ÿҳ��¼��', '2', '', '��̨����ÿҳ��ʾ��¼��', '1379503896', '1380427745', '1', '10', '10');
INSERT INTO `weiapp_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '�Ƿ������û�ע��', '3', '0:�ر�ע��\r\n1:����ע��', '�Ƿ񿪷��û�ע��', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `weiapp_config` VALUES ('27', 'CODEMIRROR_THEME', '4', 'Ԥ�������CodeMirror����', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '�����CodeMirror����', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `weiapp_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '���ݿⱸ�ݸ�·��', '4', '', '·�������� / ��β', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `weiapp_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '���ݿⱸ�ݾ��С', '4', '', '��ֵ��������ѹ����ķ־���󳤶ȡ���λ��B����������20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `weiapp_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '���ݿⱸ���ļ��Ƿ�����ѹ��', '4', '0:��ѹ��\r\n1:����ѹ��', 'ѹ�������ļ���ҪPHP����֧��gzopen,gzwrite����', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `weiapp_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '���ݿⱸ���ļ�ѹ������', '4', '1:��ͨ\r\n4:һ��\r\n9:���', '���ݿⱸ���ļ���ѹ�����𣬸������ڿ���ѹ��ʱ��Ч', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `weiapp_config` VALUES ('32', 'DEVELOP_MODE', '4', '����������ģʽ', '4', '0:�ر�\r\n1:����', '�Ƿ���������ģʽ', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `weiapp_config` VALUES ('33', 'ALLOW_VISIT', '3', '�����޿���������', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `weiapp_config` VALUES ('34', 'DENY_VISIT', '3', '����ר�޿���������', '0', '', '����������Ա�ɷ��ʵĿ���������', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `weiapp_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '�ظ��б�ÿҳ����', '2', '', '', '1386645376', '1387178083', '1', '10', '0');
INSERT INTO `weiapp_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '��̨�������IP', '4', '', '����ö��ŷָ�����������ñ�ʾ������IP����', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `weiapp_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '�Ƿ���ʾҳ��Trace', '4', '0:�ر�\r\n1:����', '�Ƿ���ʾҳ��Trace��Ϣ', '1387165685', '1387165685', '1', '0', '1');

-- ----------------------------
-- Table structure for `weiapp_document`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_document`;
CREATE TABLE `weiapp_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '�ĵ�ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '��ʶ',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '����',
  `category_id` int(10) unsigned NOT NULL COMMENT '��������',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '����',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '���ڵ�',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '����ģ��ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '��������',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '�Ƽ�λ',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '�ɼ���',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '��������',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�����',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '������',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '��չͳ���ֶ�',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '���ȼ�',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '����״̬',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='�ĵ�ģ�ͻ�����';

-- ----------------------------
-- Records of weiapp_document
-- ----------------------------
INSERT INTO `weiapp_document` VALUES ('1', '1', '', 'OneThink1.0��ʽ�淢��', '2', '����ڴ���OneThink��ʽ�淢��', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1387260660', '1387263112', '1');

-- ----------------------------
-- Table structure for `weiapp_document_article`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_document_article`;
CREATE TABLE `weiapp_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ĵ�ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '���ݽ�������',
  `content` text NOT NULL COMMENT '��������',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '����ҳ��ʾģ��',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ղ���',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='�ĵ�ģ�����±�';

-- ----------------------------
-- Records of weiapp_document_article
-- ----------------------------
INSERT INTO `weiapp_document_article` VALUES ('1', '0', '<h1>\r\n	OneThink1.0��ʽ�淢��&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink��һ����Դ�����ݹ����ܣ��������µ�ThinkPHP3.2�汾�������ṩ�����㡢����ȫ��WEBӦ�ÿ������飬������ȫ�µļܹ���ƺ������ռ���ƣ��ں���ģ�黯���������Ͳ���������������һ�壬�����˹���WEBӦ��ɵ��ʽ�������³�����&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	��Ҫ���ԣ�\r\n</h2>\r\n<p>\r\n	1. ����ThinkPHP����3.2�汾��\r\n</p>\r\n<p>\r\n	2. ģ�黯��ȫ�µļܹ���ģ�黯�Ŀ������ƣ����������չ�Ͷ��ο�����&nbsp;\r\n</p>\r\n<p>\r\n	3. �ĵ�ģ��/������ϵ��ͨ�����ĵ�ģ�Ͱ󶨣��Լ���ͬ���ĵ����ͣ���ͬ�������ʵ�ֲ��컯�Ĺ��ܣ�����ʵ��������Ѷ�����ء����ۺ�ͼƬ�ȹ��ܡ�\r\n</p>\r\n<p>\r\n	4. ��Դ��ѣ�OneThink��ѭApache2��ԴЭ��,����ṩʹ�á�&nbsp;\r\n</p>\r\n<p>\r\n	5. �û���Ϊ��֧���Զ����û���Ϊ�����ԶԵ����û�����Ⱥ���û�����Ϊ���м�¼������Ϊ������Ӫ�����ṩ��Ч�ο����ݡ�\r\n</p>\r\n<p>\r\n	6. �ƶ˲���ͨ�������ķ�ʽ��������֧��ƽ̨�Ĳ�����������վ�޷�Ǩ�ƣ������Ѿ�֧��SAE��BAE3.0��\r\n</p>\r\n<p>\r\n	7. �Ʒ���֧�֣���������֧���ƴ洢���ư�ȫ���ƹ��˺���ͳ�Ƶȷ��񣬸������ĵķ�����������վ�����ġ�\r\n</p>\r\n<p>\r\n	8. ��ȫ�Ƚ����ṩ�Ƚ��İ�ȫ���ԣ��������ݻָ����ݴ���ֹ���⹥����¼����ҳ���۸ĵȶ��ȫ�����ܣ���֤ϵͳ��ȫ���ɿ����ȶ������С�&nbsp;\r\n</p>\r\n<p>\r\n	9. Ӧ�òֿ⣺�ٷ�Ӧ�òֿ�ӵ�д������Ե����������Ӧ��ģ�顢ģ�����⣬���ڶ����Կ�Դ�����Ĺ��ף���������վ��One������ȱ��&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink������һ�����Ƶĺ�̨������ϵ��ǰ̨ģ���ǩϵͳ���������ɹ������ݺͽ���ǰ̨��վ�ı�ǩʽ������&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	��̨��Ҫ���ܣ�\r\n</h2>\r\n<p>\r\n	1. �û�Passportϵͳ\r\n</p>\r\n<p>\r\n	2. ���ù���ϵͳ&nbsp;\r\n</p>\r\n<p>\r\n	3. Ȩ�޿���ϵͳ\r\n</p>\r\n<p>\r\n	4. ��̨��ģϵͳ&nbsp;\r\n</p>\r\n<p>\r\n	5. �༶����ϵͳ&nbsp;\r\n</p>\r\n<p>\r\n	6. �û���Ϊϵͳ&nbsp;\r\n</p>\r\n<p>\r\n	7. ���ӺͲ��ϵͳ\r\n</p>\r\n<p>\r\n	8. ϵͳ��־ϵͳ&nbsp;\r\n</p>\r\n<p>\r\n	9. ���ݱ��ݺͻ�ԭ\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ �ٷ����أ�&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;�����ֲ᣺<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink�����Ŷ� 2013</strong> \r\n</p>', '', '0');

-- ----------------------------
-- Table structure for `weiapp_document_download`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_document_download`;
CREATE TABLE `weiapp_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ĵ�ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '���ݽ�������',
  `content` text NOT NULL COMMENT '������ϸ����',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '����ҳ��ʾģ��',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ļ�ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '���ش���',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '�ļ���С',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='�ĵ�ģ�����ر�';

-- ----------------------------
-- Records of weiapp_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_file`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_file`;
CREATE TABLE `weiapp_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '�ļ�ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT 'ԭʼ�ļ���',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '��������',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '�ļ�����·��',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '�ļ���׺',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '�ļ�mime����',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ļ���С',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '�ļ�md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '�ļ� sha1����',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '�ļ�����λ��',
  `create_time` int(10) unsigned NOT NULL COMMENT '�ϴ�ʱ��',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='�ļ���';

-- ----------------------------
-- Records of weiapp_file
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_hooks`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_hooks`;
CREATE TABLE `weiapp_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '��������',
  `description` text NOT NULL COMMENT '����',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '����',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '���ӹ��صĲ�� ''��''�ָ�',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_hooks
-- ----------------------------
INSERT INTO `weiapp_hooks` VALUES ('1', 'pageHeader', 'ҳ��header���ӣ�һ�����ڼ��ز��CSS�ļ��ʹ���', '1', '0', '');
INSERT INTO `weiapp_hooks` VALUES ('2', 'pageFooter', 'ҳ��footer���ӣ�һ�����ڼ��ز��JS�ļ���JS����', '1', '0', 'ReturnTop');
INSERT INTO `weiapp_hooks` VALUES ('3', 'documentEditForm', '��ӱ༭���� ��չ���ݹ���', '1', '0', 'Attachment');
INSERT INTO `weiapp_hooks` VALUES ('4', 'documentDetailAfter', '�ĵ�ĩβ��ʾ', '1', '0', 'Attachment,SocialComment');
INSERT INTO `weiapp_hooks` VALUES ('5', 'documentDetailBefore', 'ҳ������ǰ��ʾ�ù���', '1', '0', '');
INSERT INTO `weiapp_hooks` VALUES ('6', 'documentSaveComplete', '�����ĵ����ݺ����չ����', '2', '0', 'Attachment');
INSERT INTO `weiapp_hooks` VALUES ('7', 'documentEditFormContent', '��ӱ༭����������ʾ����', '1', '0', 'Editor');
INSERT INTO `weiapp_hooks` VALUES ('8', 'adminArticleEdit', '��̨���ݱ༭ҳ�༭��', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `weiapp_hooks` VALUES ('13', 'AdminIndex', '��ҳС���Ӹ��Ի���ʾ', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam');
INSERT INTO `weiapp_hooks` VALUES ('14', 'topicComment', '�����ύ��ʽ��չ���ӡ�', '1', '1380163518', 'Editor');
INSERT INTO `weiapp_hooks` VALUES ('16', 'app_begin', 'Ӧ�ÿ�ʼ', '2', '1384481614', '');

-- ----------------------------
-- Table structure for `weiapp_member`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_member`;
CREATE TABLE `weiapp_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '�û�ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '�ǳ�',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '�Ա�',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '����',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq��',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '�û�����',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '��¼����',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ע��IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ע��ʱ��',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '����¼IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����¼ʱ��',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '��Ա״̬',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='��Ա��';

-- ----------------------------
-- Records of weiapp_member
-- ----------------------------
INSERT INTO `weiapp_member` VALUES ('1', 'admin', '0', '0000-00-00', '', '10', '2', '0', '1423289473', '2130706433', '1423292959', '1');

-- ----------------------------
-- Table structure for `weiapp_menu`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_menu`;
CREATE TABLE `weiapp_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '�ĵ�ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '����',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�ϼ�����ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ͬ����Ч��',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '���ӵ�ַ',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '�Ƿ�����',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '��ʾ',
  `group` varchar(50) DEFAULT '' COMMENT '����',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '�Ƿ��������ģʽ�ɼ�',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_menu
-- ----------------------------
INSERT INTO `weiapp_menu` VALUES ('1', '��ҳ', '0', '1', 'Index/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('2', '����', '0', '2', 'Article/mydocument', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('3', '�ĵ��б�', '2', '0', 'article/index', '1', '', '����', '0');
INSERT INTO `weiapp_menu` VALUES ('4', '����', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('5', '�༭', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('6', '�ı�״̬', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('7', '����', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('8', '����ݸ�', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('9', '�ƶ�', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('10', '����', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('11', 'ճ��', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('12', '����', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('13', '����վ', '2', '0', 'article/recycle', '1', '', '����', '0');
INSERT INTO `weiapp_menu` VALUES ('14', '��ԭ', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('15', '���', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('16', '�û�', '0', '3', 'User/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('17', '�û���Ϣ', '16', '0', 'User/index', '0', '', '�û�����', '0');
INSERT INTO `weiapp_menu` VALUES ('18', '�����û�', '17', '0', 'User/add', '0', '������û�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('19', '�û���Ϊ', '16', '0', 'User/action', '0', '', '��Ϊ����', '0');
INSERT INTO `weiapp_menu` VALUES ('20', '�����û���Ϊ', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('21', '�༭�û���Ϊ', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('22', '�����û���Ϊ', '19', '0', 'User/saveAction', '0', '\"�û�->�û���Ϊ\"����༭���������û���Ϊ', '', '0');
INSERT INTO `weiapp_menu` VALUES ('23', '�����Ϊ״̬', '19', '0', 'User/setStatus', '0', '\"�û�->�û���Ϊ\"�е�����,���ú�ɾ��Ȩ��', '', '0');
INSERT INTO `weiapp_menu` VALUES ('24', '���û�Ա', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"�û�->�û���Ϣ\"�еĽ���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('25', '���û�Ա', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"�û�->�û���Ϣ\"�е�����', '', '0');
INSERT INTO `weiapp_menu` VALUES ('26', 'ɾ����Ա', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"�û�->�û���Ϣ\"�е�ɾ��', '', '0');
INSERT INTO `weiapp_menu` VALUES ('27', 'Ȩ�޹���', '16', '0', 'AuthManager/index', '0', '', '�û�����', '0');
INSERT INTO `weiapp_menu` VALUES ('28', 'ɾ��', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', 'ɾ���û���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('29', '����', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '�����û���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('30', '�ָ�', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '�ָ��ѽ��õ��û���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('31', '����', '27', '0', 'AuthManager/createGroup', '0', '�����µ��û���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('32', '�༭', '27', '0', 'AuthManager/editGroup', '0', '�༭�û������ƺ�����', '', '0');
INSERT INTO `weiapp_menu` VALUES ('33', '�����û���', '27', '0', 'AuthManager/writeGroup', '0', '�����ͱ༭�û����\"����\"��ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('34', '��Ȩ', '27', '0', 'AuthManager/group', '0', '\"��̨ \\ �û� \\ �û���Ϣ\"�б�ҳ��\"��Ȩ\"������ť,���������û������û���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('35', '������Ȩ', '27', '0', 'AuthManager/access', '0', '\"��̨ \\ �û� \\ Ȩ�޹���\"�б�ҳ��\"������Ȩ\"������ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('36', '��Ա��Ȩ', '27', '0', 'AuthManager/user', '0', '\"��̨ \\ �û� \\ Ȩ�޹���\"�б�ҳ��\"��Ա��Ȩ\"������ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('37', '�����Ȩ', '27', '0', 'AuthManager/removeFromGroup', '0', '\"��Ա��Ȩ\"�б�ҳ�ڵĽ����Ȩ������ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('38', '�����Ա��Ȩ', '27', '0', 'AuthManager/addToGroup', '0', '\"�û���Ϣ\"�б�ҳ\"��Ȩ\"ʱ��\"����\"��ť��\"��Ա��Ȩ\"�����Ͻǵ�\"���\"��ť)', '', '0');
INSERT INTO `weiapp_menu` VALUES ('39', '������Ȩ', '27', '0', 'AuthManager/category', '0', '\"��̨ \\ �û� \\ Ȩ�޹���\"�б�ҳ��\"������Ȩ\"������ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('40', '���������Ȩ', '27', '0', 'AuthManager/addToCategory', '0', '\"������Ȩ\"ҳ���\"����\"��ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('41', 'ģ����Ȩ', '27', '0', 'AuthManager/modelauth', '0', '\"��̨ \\ �û� \\ Ȩ�޹���\"�б�ҳ��\"ģ����Ȩ\"������ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('42', '����ģ����Ȩ', '27', '0', 'AuthManager/addToModel', '0', '\"������Ȩ\"ҳ���\"����\"��ť', '', '0');
INSERT INTO `weiapp_menu` VALUES ('43', '��չ', '0', '7', 'Addons/index', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('44', '�������', '43', '1', 'Addons/index', '0', '', '��չ', '0');
INSERT INTO `weiapp_menu` VALUES ('45', '����', '44', '0', 'Addons/create', '0', '�������ϴ�������ṹ��', '', '0');
INSERT INTO `weiapp_menu` VALUES ('46', '��ⴴ��', '44', '0', 'Addons/checkForm', '0', '������Ƿ���Դ���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('47', 'Ԥ��', '44', '0', 'Addons/preview', '0', 'Ԥ������������ļ�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('48', '�������ɲ��', '44', '0', 'Addons/build', '0', '��ʼ���ɲ���ṹ', '', '0');
INSERT INTO `weiapp_menu` VALUES ('49', '����', '44', '0', 'Addons/config', '0', '���ò������', '', '0');
INSERT INTO `weiapp_menu` VALUES ('50', '����', '44', '0', 'Addons/disable', '0', '���ò��', '', '0');
INSERT INTO `weiapp_menu` VALUES ('51', '����', '44', '0', 'Addons/enable', '0', '���ò��', '', '0');
INSERT INTO `weiapp_menu` VALUES ('52', '��װ', '44', '0', 'Addons/install', '0', '��װ���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('53', 'ж��', '44', '0', 'Addons/uninstall', '0', 'ж�ز��', '', '0');
INSERT INTO `weiapp_menu` VALUES ('54', '��������', '44', '0', 'Addons/saveconfig', '0', '���²�����ô���', '', '0');
INSERT INTO `weiapp_menu` VALUES ('55', '�����̨�б�', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('56', 'URL��ʽ���ʲ��', '44', '0', 'Addons/execute', '0', '�����Ƿ���Ȩ��ͨ��url���ʲ������������', '', '0');
INSERT INTO `weiapp_menu` VALUES ('57', '���ӹ���', '43', '2', 'Addons/hooks', '0', '', '��չ', '0');
INSERT INTO `weiapp_menu` VALUES ('58', 'ģ�͹���', '68', '3', 'Model/index', '0', '', 'ϵͳ����', '0');
INSERT INTO `weiapp_menu` VALUES ('59', '����', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('60', '�༭', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('61', '�ı�״̬', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('62', '��������', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('63', '���Թ���', '68', '0', 'Attribute/index', '1', '��վ�������á�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('64', '����', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('65', '�༭', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('66', '�ı�״̬', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('67', '��������', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('68', 'ϵͳ', '0', '4', 'Config/group', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('69', '��վ����', '68', '1', 'Config/group', '0', '', 'ϵͳ����', '0');
INSERT INTO `weiapp_menu` VALUES ('70', '���ù���', '68', '4', 'Config/index', '0', '', 'ϵͳ����', '0');
INSERT INTO `weiapp_menu` VALUES ('71', '�༭', '70', '0', 'Config/edit', '0', '�����༭�ͱ�������', '', '0');
INSERT INTO `weiapp_menu` VALUES ('72', 'ɾ��', '70', '0', 'Config/del', '0', 'ɾ������', '', '0');
INSERT INTO `weiapp_menu` VALUES ('73', '����', '70', '0', 'Config/add', '0', '��������', '', '0');
INSERT INTO `weiapp_menu` VALUES ('74', '����', '70', '0', 'Config/save', '0', '��������', '', '0');
INSERT INTO `weiapp_menu` VALUES ('75', '�˵�����', '68', '5', 'Menu/index', '0', '', 'ϵͳ����', '0');
INSERT INTO `weiapp_menu` VALUES ('76', '��������', '68', '6', 'Channel/index', '0', '', 'ϵͳ����', '0');
INSERT INTO `weiapp_menu` VALUES ('77', '����', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('78', '�༭', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('79', 'ɾ��', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('80', '�������', '68', '2', 'Category/index', '0', '', 'ϵͳ����', '0');
INSERT INTO `weiapp_menu` VALUES ('81', '�༭', '80', '0', 'Category/edit', '0', '�༭�ͱ�����Ŀ����', '', '0');
INSERT INTO `weiapp_menu` VALUES ('82', '����', '80', '0', 'Category/add', '0', '������Ŀ����', '', '0');
INSERT INTO `weiapp_menu` VALUES ('83', 'ɾ��', '80', '0', 'Category/remove', '0', 'ɾ����Ŀ����', '', '0');
INSERT INTO `weiapp_menu` VALUES ('84', '�ƶ�', '80', '0', 'Category/operate/type/move', '0', '�ƶ���Ŀ����', '', '0');
INSERT INTO `weiapp_menu` VALUES ('85', '�ϲ�', '80', '0', 'Category/operate/type/merge', '0', '�ϲ���Ŀ����', '', '0');
INSERT INTO `weiapp_menu` VALUES ('86', '�������ݿ�', '68', '0', 'Database/index?type=export', '0', '', '���ݱ���', '0');
INSERT INTO `weiapp_menu` VALUES ('87', '����', '86', '0', 'Database/export', '0', '�������ݿ�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('88', '�Ż���', '86', '0', 'Database/optimize', '0', '�Ż����ݱ�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('89', '�޸���', '86', '0', 'Database/repair', '0', '�޸����ݱ�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('90', '��ԭ���ݿ�', '68', '0', 'Database/index?type=import', '0', '', '���ݱ���', '0');
INSERT INTO `weiapp_menu` VALUES ('91', '�ָ�', '90', '0', 'Database/import', '0', '���ݿ�ָ�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('92', 'ɾ��', '90', '0', 'Database/del', '0', 'ɾ�������ļ�', '', '0');
INSERT INTO `weiapp_menu` VALUES ('93', '����', '0', '5', 'other', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('96', '����', '75', '0', 'Menu/add', '0', '', 'ϵͳ����', '0');
INSERT INTO `weiapp_menu` VALUES ('98', '�༭', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('104', '���ع���', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('105', '���ù���', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('106', '��Ϊ��־', '16', '0', 'Action/actionlog', '0', '', '��Ϊ����', '0');
INSERT INTO `weiapp_menu` VALUES ('108', '�޸�����', '16', '0', 'User/updatePassword', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('109', '�޸��ǳ�', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('110', '�鿴��Ϊ��־', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('112', '��������', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('113', '�༭����', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('114', '����', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('115', '����', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('116', '��������', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('117', '�༭����', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('118', '�ĵ�����', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('119', '����', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('120', '����', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `weiapp_menu` VALUES ('121', '����', '76', '0', 'Channel/sort', '1', '', '', '0');

-- ----------------------------
-- Table structure for `weiapp_model`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_model`;
CREATE TABLE `weiapp_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ģ��ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT 'ģ�ͱ�ʶ',
  `title` char(30) NOT NULL DEFAULT '' COMMENT 'ģ������',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '�̳е�ģ��',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '�̳��뱻�̳�ģ�͵Ĺ����ֶ�',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '�½���ʱ�Ƿ���Ҫ�����ֶ�',
  `field_sort` text NOT NULL COMMENT '���ֶ�����',
  `field_group` varchar(255) NOT NULL DEFAULT '1:����' COMMENT '�ֶη���',
  `attribute_list` text NOT NULL COMMENT '�����б�����ֶΣ�',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '�б�ģ��',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '����ģ��',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '�༭ģ��',
  `list_grid` text NOT NULL COMMENT '�б���',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '�б����ݳ���',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT 'Ĭ�������ֶ�',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '�߼��������ֶ�',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '״̬',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '���ݿ�����',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='�ĵ�ģ�ͱ�';

-- ----------------------------
-- Records of weiapp_model
-- ----------------------------
INSERT INTO `weiapp_model` VALUES ('1', 'document', '�����ĵ�', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:����', '', '', '', '', 'id:���\r\ntitle:����:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:����\r\nlevel:���ȼ�\r\nupdate_time|time_format:������\r\nstatus_text:״̬\r\nview:���\r\nid:����:[EDIT]&cate_id=[category_id]|�༭,article/setstatus?status=-1&ids=[id]|ɾ��', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `weiapp_model` VALUES ('2', 'article', '����', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:����,2:��չ', '', '', '', '', 'id:���\r\ntitle:����:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:����', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `weiapp_model` VALUES ('3', 'download', '����', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:����,2:��չ', '', '', '', '', 'id:���\r\ntitle:����', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');

-- ----------------------------
-- Table structure for `weiapp_picture`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_picture`;
CREATE TABLE `weiapp_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����id����',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '·��',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'ͼƬ����',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '�ļ�md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '�ļ� sha1����',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '״̬',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_picture
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_ucenter_admin`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_admin`;
CREATE TABLE `weiapp_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ԱID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����Ա�û�ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '����Ա״̬',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='����Ա��';

-- ----------------------------
-- Records of weiapp_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_ucenter_app`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_app`;
CREATE TABLE `weiapp_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Ӧ��ID',
  `title` varchar(30) NOT NULL COMMENT 'Ӧ������',
  `url` varchar(100) NOT NULL COMMENT 'Ӧ��URL',
  `ip` char(15) NOT NULL COMMENT 'Ӧ��IP',
  `auth_key` varchar(100) NOT NULL COMMENT '����KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'ͬ����½',
  `allow_ip` varchar(255) NOT NULL COMMENT '������ʵ�IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ӧ��״̬',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Ӧ�ñ�';

-- ----------------------------
-- Records of weiapp_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_ucenter_member`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_member`;
CREATE TABLE `weiapp_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '�û�ID',
  `username` char(16) NOT NULL COMMENT '�û���',
  `password` char(32) NOT NULL COMMENT '����',
  `email` char(32) NOT NULL COMMENT '�û�����',
  `mobile` char(15) NOT NULL COMMENT '�û��ֻ�',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ע��ʱ��',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ע��IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����¼ʱ��',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '����¼IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  `status` tinyint(4) DEFAULT '0' COMMENT '�û�״̬',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='�û���';

-- ----------------------------
-- Records of weiapp_ucenter_member
-- ----------------------------
INSERT INTO `weiapp_ucenter_member` VALUES ('1', 'admin', 'e02aee9ace52823b94166d3980c70d4b', 'tonbochow@qq.com', '', '1423289473', '2130706433', '1423292959', '2130706433', '1423289473', '1');

-- ----------------------------
-- Table structure for `weiapp_ucenter_setting`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_ucenter_setting`;
CREATE TABLE `weiapp_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '�������ͣ�1-�û����ã�',
  `value` text NOT NULL COMMENT '��������',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='���ñ�';

-- ----------------------------
-- Records of weiapp_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_url`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_url`;
CREATE TABLE `weiapp_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '����Ψһ��ʶ',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '���ӵ�ַ',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '����ַ',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '״̬',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '����ʱ��',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='���ӱ�';

-- ----------------------------
-- Records of weiapp_url
-- ----------------------------

-- ----------------------------
-- Table structure for `weiapp_userdata`
-- ----------------------------
DROP TABLE IF EXISTS `weiapp_userdata`;
CREATE TABLE `weiapp_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '�û�id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '���ͱ�ʶ',
  `target_id` int(10) unsigned NOT NULL COMMENT 'Ŀ��id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weiapp_userdata
-- ----------------------------