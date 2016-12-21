/*
Navicat MySQL Data Transfer

Source Server         : 192.168.77.66控制机
Source Server Version : 50621
Source Host           : 192.168.77.66:3306
Source Database       : soc_server_monitor

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-08-28 16:34:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for soc_sm_alarm
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_alarm`;
CREATE TABLE `soc_sm_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) DEFAULT NULL COMMENT '服务器id',
  `serverIp` varchar(64) DEFAULT NULL COMMENT '服务器ip',
  `level` int(11) DEFAULT NULL COMMENT '报警级别',
  `type` varchar(32) DEFAULT NULL COMMENT '报警类型',
  `limitValue` decimal(32,8) DEFAULT NULL COMMENT '阈值',
  `nowValue` decimal(32,8) DEFAULT NULL COMMENT '当前值',
  `msg` varchar(256) DEFAULT NULL COMMENT '报警消息',
  `collectTime` datetime DEFAULT NULL COMMENT '采集时间',
  `monitorTime` datetime DEFAULT NULL COMMENT '监控时间',
  `status` int(11) DEFAULT NULL COMMENT '发送状态，1待发送，2发送中，3发送成功，4发送失败，5取消发送，6恢复短信发送完毕',
  `mobiles` varchar(256) DEFAULT NULL COMMENT '发送手机号,多个以半角逗号分隔',
  `sendTime` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`),
  KEY `index_soc_sm_alarm_serverId` (`serverId`),
  KEY `index_soc_sm_alarm_serverIp` (`serverIp`),
  KEY `index_soc_sm_alarm_type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=31834 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_alarm_group
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_alarm_group`;
CREATE TABLE `soc_sm_alarm_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '用户名',
  `userIds` varchar(256) DEFAULT NULL COMMENT '用户ids，多个半角逗号分隔，首尾半角逗号',
  `remark` varchar(512) DEFAULT NULL COMMENT '描述',
  `status` int(11) NOT NULL COMMENT '状态，1可用，2不可用',
  `isDelete` int(11) NOT NULL COMMENT '是否删除，1被删除，2未删除',
  `creater` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `lastUpdater` varchar(32) NOT NULL COMMENT '最后更新人',
  `lastUpdateTime` datetime NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_server
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_server`;
CREATE TABLE `soc_sm_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `osName` varchar(128) DEFAULT NULL COMMENT '操作系统',
  `osVersion` varchar(64) DEFAULT NULL COMMENT '操作系统版本',
  `hostname` varchar(128) DEFAULT NULL COMMENT 'hostname',
  `ip` varchar(64) DEFAULT NULL COMMENT 'ip',
  `platId` varchar(16) DEFAULT NULL COMMENT '所属平台',
  `appId` varchar(16) DEFAULT NULL COMMENT '所属应用',
  `cpuCount` int(11) DEFAULT NULL COMMENT 'cpu核数',
  `memory` bigint(20) DEFAULT NULL COMMENT '内存',
  `uptime` varchar(32) DEFAULT NULL COMMENT '开机时间',
  `alarmId` int(11) DEFAULT NULL COMMENT '报警编号',
  `lastMonitorTime` datetime DEFAULT NULL COMMENT '最后监控时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '描述',
  `status` int(11) NOT NULL COMMENT '状态，1可用，2不可用',
  `isDelete` int(11) NOT NULL COMMENT '是否删除，1被删除，2未删除',
  `creater` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `lastUpdater` varchar(32) NOT NULL COMMENT '最后更新人',
  `lastUpdateTime` datetime NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_server_cpu
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_server_cpu`;
CREATE TABLE `soc_sm_server_cpu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) DEFAULT NULL COMMENT '服务器id',
  `softirq` decimal(4,2) DEFAULT NULL COMMENT 'softirq',
  `iowait` decimal(4,2) DEFAULT NULL COMMENT 'iowait',
  `system` decimal(4,2) DEFAULT NULL COMMENT 'system',
  `guest` decimal(4,2) DEFAULT NULL COMMENT 'guest',
  `idle` decimal(4,2) DEFAULT NULL COMMENT 'idle',
  `user` decimal(4,2) DEFAULT NULL COMMENT 'user',
  `irq` decimal(4,2) DEFAULT NULL COMMENT 'irq',
  `total` decimal(4,2) DEFAULT NULL COMMENT 'total',
  `steal` decimal(4,2) DEFAULT NULL COMMENT 'steal',
  `nice` decimal(4,2) DEFAULT NULL COMMENT 'nice',
  `collectTime` datetime DEFAULT NULL COMMENT '采集时间',
  `monitorTime` datetime DEFAULT NULL COMMENT '监控时间',
  PRIMARY KEY (`id`),
  KEY `index_soc_sm_server_cpu_serverId` (`serverId`),
  KEY `index_soc_sm_server_cpu_collectTime` (`collectTime`)
) ENGINE=MyISAM AUTO_INCREMENT=734876 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_server_diskio
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_server_diskio`;
CREATE TABLE `soc_sm_server_diskio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) DEFAULT NULL COMMENT '服务器id',
  `diskName` varchar(32) DEFAULT NULL COMMENT '分区名称',
  `readBytes` bigint(20) DEFAULT NULL COMMENT '读取流量',
  `writeBytes` bigint(20) DEFAULT NULL COMMENT '写入流量',
  `collectTime` datetime DEFAULT NULL COMMENT '采集时间',
  `monitorTime` datetime DEFAULT NULL COMMENT '监控时间',
  PRIMARY KEY (`id`),
  KEY `index_soc_sm_server_diskio_serverId` (`serverId`),
  KEY `index_soc_sm_server_diskio_collectTime` (`collectTime`)
) ENGINE=MyISAM AUTO_INCREMENT=3538076 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_server_limit
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_server_limit`;
CREATE TABLE `soc_sm_server_limit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) DEFAULT NULL COMMENT '服务器编号',
  `type` varchar(16) DEFAULT NULL COMMENT '监控类型',
  `warnValue` varchar(256) DEFAULT NULL,
  `criticalValue` varchar(256) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL COMMENT '描述',
  `status` int(11) NOT NULL COMMENT '状态，1可用，2不可用',
  `isDelete` int(11) NOT NULL COMMENT '是否删除，1被删除，2未删除',
  `creater` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `lastUpdater` varchar(32) NOT NULL COMMENT '最后更新人',
  `lastUpdateTime` datetime NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_server_load
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_server_load`;
CREATE TABLE `soc_sm_server_load` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) DEFAULT NULL COMMENT '服务器id',
  `min1` decimal(6,2) DEFAULT NULL COMMENT '1分钟负载',
  `min5` decimal(6,2) DEFAULT NULL COMMENT '5分钟负载',
  `min15` decimal(6,2) DEFAULT NULL COMMENT '15分钟负载',
  `collectTime` datetime DEFAULT NULL COMMENT '采集时间',
  `monitorTime` datetime DEFAULT NULL COMMENT '监控时间',
  PRIMARY KEY (`id`),
  KEY `index_soc_sm_server_load_serverId` (`serverId`),
  KEY `index_soc_sm_server_load_collectTime` (`collectTime`)
) ENGINE=MyISAM AUTO_INCREMENT=598639 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_server_mem
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_server_mem`;
CREATE TABLE `soc_sm_server_mem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) DEFAULT NULL COMMENT '服务器id',
  `available` bigint(20) DEFAULT NULL COMMENT 'available',
  `used` bigint(20) DEFAULT NULL COMMENT 'used',
  `cached` bigint(20) DEFAULT NULL COMMENT 'cached',
  `percent` decimal(5,2) DEFAULT NULL COMMENT 'percent',
  `free` bigint(20) DEFAULT NULL COMMENT 'free',
  `inactive` bigint(20) DEFAULT NULL COMMENT 'inactive',
  `active` bigint(20) DEFAULT NULL COMMENT 'active',
  `total` bigint(20) DEFAULT NULL COMMENT 'total',
  `buffers` bigint(20) DEFAULT NULL COMMENT 'buffers',
  `collectTime` datetime DEFAULT NULL COMMENT '采集时间',
  `monitorTime` datetime DEFAULT NULL COMMENT '监控时间',
  PRIMARY KEY (`id`),
  KEY `index_soc_sm_server_mem_serverId` (`serverId`),
  KEY `index_soc_sm_server_mem_collectTime` (`collectTime`)
) ENGINE=MyISAM AUTO_INCREMENT=1015710 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_server_network
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_server_network`;
CREATE TABLE `soc_sm_server_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) DEFAULT NULL COMMENT '服务器id',
  `netCard` varchar(16) DEFAULT NULL COMMENT '网卡编号，合计为all',
  `tx` bigint(20) DEFAULT NULL COMMENT '出口流量',
  `totalTx` bigint(20) DEFAULT NULL COMMENT '总出口流量',
  `rx` bigint(20) DEFAULT NULL COMMENT '入口流量',
  `totalRx` bigint(20) DEFAULT NULL COMMENT '总入口流量',
  `cx` bigint(20) DEFAULT NULL COMMENT '合计流量',
  `totalcx` bigint(20) DEFAULT NULL COMMENT '总合计流量',
  `collectTime` datetime DEFAULT NULL COMMENT '采集时间',
  `monitorTime` datetime DEFAULT NULL COMMENT '监控时间',
  PRIMARY KEY (`id`),
  KEY `index_soc_sm_server_network_serverId` (`serverId`) USING BTREE,
  KEY `index_soc_sm_server_network_collectTime` (`collectTime`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9853852 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soc_sm_user
-- ----------------------------
DROP TABLE IF EXISTS `soc_sm_user`;
CREATE TABLE `soc_sm_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '用户名',
  `realName` varchar(64) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机号',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `role` varchar(8) DEFAULT NULL COMMENT '角色',
  `team` varchar(8) DEFAULT NULL COMMENT '所属团队',
  `remark` varchar(512) DEFAULT NULL COMMENT '描述',
  `status` int(11) NOT NULL COMMENT '状态，1可用，2不可用',
  `isDelete` int(11) NOT NULL COMMENT '是否删除，1被删除，2未删除',
  `creater` varchar(32) NOT NULL COMMENT '创建人',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `lastUpdater` varchar(32) NOT NULL COMMENT '最后更新人',
  `lastUpdateTime` datetime NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
