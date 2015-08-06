-- phpMyAdmin SQL Dump
-- version 2.6.4-pl3
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jan 09, 2007 at 01:17 PM
-- Server version: 5.0.15
-- PHP Version: 5.1.6
-- 
-- Database: `environments`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `application`
-- 

CREATE TABLE `application` (
  `APP_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(30) NOT NULL,
  PRIMARY KEY  (`APP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- 
-- Dumping data for table `application`
-- 

INSERT INTO `application` VALUES (1, 'TIERS App');
INSERT INTO `application` VALUES (2, 'Self Service Portal');
INSERT INTO `application` VALUES (3, 'State Portal');
INSERT INTO `application` VALUES (4, 'TIERS App (MRS)');
INSERT INTO `application` VALUES (5, 'TIERS Batch');
INSERT INTO `application` VALUES (6, 'MAXeIE');
INSERT INTO `application` VALUES (7, 'MAXeCHIP');

-- --------------------------------------------------------

-- 
-- Table structure for table `batch`
-- 

CREATE TABLE `batch` (
  `ENV_ID` int(11) NOT NULL,
  `BOX` varchar(10) NOT NULL,
  `PATH` varchar(15) NOT NULL,
  `MQ_ID` varchar(15) NOT NULL,
  `DB_ID` varchar(10) NOT NULL,
  `DATE_START` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `DATE_END` timestamp NULL default NULL,
  PRIMARY KEY  (`BOX`,`PATH`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `batch`
-- 

INSERT INTO `batch` VALUES (6, 'iedadu002', '/TIERS/AGING01', 'MIG_QM3', '218', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (7, 'iedadu002', '/TIERS/AGING02', 'TIERS.QM1', '219', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (4, 'iedadu002', '/TIERS/APT01', 'TIERS.QM15', '640', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (5, 'iedadu002', '/TIERS/APT02', 'TIERS.QM17', '630', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (8, 'iedadu004', '/TIERS/AGING03', 'TIERS.QM4', '229', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (1, 'iedadu004', '/TIERS/AST01', 'TIERS.QM6', '210', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (2, 'iedadu004', '/TIERS/AST02', 'TIERS.QM9', '240', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (3, 'iedadu004', '/TIERS/AST03', 'TIERS.QM10', '611', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (9, 'iedadu004', '/TIERS/MISC01', 'TIERS.QM2', '230', '2006-12-28 13:08:23', NULL);
INSERT INTO `batch` VALUES (10, 'iedadu004', '/TIERS/MISC02', 'TIERS.QM3', '220', '2006-12-28 13:08:23', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `environment`
-- 

CREATE TABLE `environment` (
  `ENV_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(30) NOT NULL,
  PRIMARY KEY  (`ENV_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

-- 
-- Dumping data for table `environment`
-- 

INSERT INTO `environment` VALUES (1, 'AST01');
INSERT INTO `environment` VALUES (2, 'AST02');
INSERT INTO `environment` VALUES (3, 'AST03');
INSERT INTO `environment` VALUES (4, 'APT01');
INSERT INTO `environment` VALUES (5, 'APT02');
INSERT INTO `environment` VALUES (6, 'AGING01');
INSERT INTO `environment` VALUES (7, 'AGING02');
INSERT INTO `environment` VALUES (8, 'AGING03');
INSERT INTO `environment` VALUES (9, 'MISC01');
INSERT INTO `environment` VALUES (10, 'MISC02');
INSERT INTO `environment` VALUES (11, 'IPT');
INSERT INTO `environment` VALUES (12, 'PROD FIX');
INSERT INTO `environment` VALUES (13, 'GENX');
INSERT INTO `environment` VALUES (15, 'CONV01');
INSERT INTO `environment` VALUES (16, 'CONV02');
INSERT INTO `environment` VALUES (17, 'COLA');
INSERT INTO `environment` VALUES (18, 'DAR');
INSERT INTO `environment` VALUES (19, 'PSR');
INSERT INTO `environment` VALUES (20, 'PERF TUNE');
INSERT INTO `environment` VALUES (21, 'PERF LAST');

-- --------------------------------------------------------

-- 
-- Table structure for table `mq`
-- 

CREATE TABLE `mq` (
  `MQ_ID` varchar(15) NOT NULL,
  `HOST` varchar(15) NOT NULL,
  `PORT` int(11) NOT NULL,
  `MGW` varchar(20) NOT NULL,
  `CHANNEL` varchar(20) NOT NULL,
  `DATE_START` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `DATE_END` timestamp NULL default NULL,
  PRIMARY KEY  (`MQ_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `mq`
-- 

INSERT INTO `mq` VALUES ('MIG_QM3', 'ietawu003', 1417, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM1', 'iedaau006', 1425, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM10', 'iedaau006', 1424, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM15', 'iedaau006', 1429, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM17', 'iedaau006', 1431, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM2', 'iedaau006', 1416, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM3', 'iedaau006', 1417, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM4 ', 'iedaau006', 1418, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM6', 'iedaau006', 1420, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);
INSERT INTO `mq` VALUES ('TIERS.QM9', 'iedaau006', 1423, 'GATEWAYS.SVRCONN.CHL', 'TIERS.SVRCONN.CHL', '2006-11-20 00:00:00', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `ws_application`
-- 

CREATE TABLE `ws_application` (
  `ENV_ID` int(11) NOT NULL,
  `APP_ID` int(11) NOT NULL,
  `WS_APP_NAME` varchar(15) NOT NULL,
  `CLUSTER` varchar(15) NOT NULL,
  `WS_CELL_NAME` varchar(20) NOT NULL,
  `DNS` varchar(15) NOT NULL,
  `MQ_ID` varchar(15) NOT NULL,
  `DB_ID` varchar(10) NOT NULL,
  `DATE_START` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `DATE_END` timestamp NULL default NULL,
  PRIMARY KEY  (`WS_APP_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `ws_application`
-- 

INSERT INTO `ws_application` VALUES (11, 0, 'stage3tiersIPT', 'ipt-cluster', 'tiers_ipt_Network', 'tiers-ipt', 'TIERS.QM2', '650', '2006-12-29 11:42:34', NULL);
INSERT INTO `ws_application` VALUES (6, 0, 'tiersaging01', 'aging01-cluster', 'tiers_aging_Network', 'tiers-aging01', 'MIG_QM3', '218', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (7, 0, 'tiersaging02', 'aging02-cluster', 'tiers_aging_Network', 'tiers-aging02', 'TIERS.QM1', '219', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (8, 0, 'tiersaging03', 'aging03-cluster', 'tiers_aging_Network', 'tiers-aging03', 'TIERS.QM4', '229', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (4, 0, 'tiersapt01', 'apt01-cluster', 'tiers_apt_Network', 'tiers-apt01', 'TIERS.QM15', '230', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (5, 0, 'tiersapt02', 'apt02-cluster', 'tiers_apt_Network', 'tiers-apt02', 'TIERS.QM17', '220', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (1, 0, 'tiersast01', 'ast01-cluster', 'tiers_ast_Network', 'tiers-ast01', 'TIERS.QM6', '210', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (2, 0, 'tiersast02', 'ast02-cluster', 'tiers_ast_Network', 'tiers-ast02', 'TIERS.QM9', '240', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (3, 0, 'tiersast03', 'ast03-cluster', 'tiers_ast_Network', 'tiers-ast03', 'TIERS.QM10', '611', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (9, 0, 'tiersmisc01', 'misc01-cluster', 'tiers_misc_Network', 'tiers-misc01', 'TIERS.QM2', '630', '2006-12-28 13:07:40', NULL);
INSERT INTO `ws_application` VALUES (10, 0, 'tiersmisc02', 'misc02-cluster', 'tiers_misc_Network', 'tiers-misc02', 'TIERS.QM3', '640', '2006-12-28 13:07:40', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `ws_appserver`
-- 

CREATE TABLE `ws_appserver` (
  `SERVER_NAME` varchar(20) NOT NULL,
  `NODE` varchar(9) NOT NULL,
  `PORT` int(11) NOT NULL,
  `WS_APP_NAME` varchar(15) NOT NULL,
  `DATE_START` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `DATE_END` timestamp NULL default NULL,
  PRIMARY KEY  (`SERVER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `ws_appserver`
-- 

INSERT INTO `ws_appserver` VALUES ('aging01-server2', 'iedaau002', 15414, 'tiersaging01', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('aging02-server2', 'iedaau002', 15428, 'tiersaging02', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('aging03-server2', 'iedaau002', 15421, 'tiersaging03', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('apt01-server2', 'iedaau002', 12514, 'tiersapt01', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('apt02-server2', 'iedaau002', 12528, 'tiersapt02', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('ast01-server2', 'iedaau002', 15514, 'tiersast01', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('ast02-server2', 'iedaau002', 15528, 'tiersast02', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('ast03-server2', 'iedaau002', 15542, 'tiersast03', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('ipt-server2', 'iedaau002', 10211, 'stage3tiersIPT', '2006-12-29 11:42:34', NULL);
INSERT INTO `ws_appserver` VALUES ('misc01-server2', 'iedaau002', 15314, 'tiersmisc01', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('misc02-server2', 'iedaau002', 15328, 'tiersmisc02', '2006-12-05 13:08:03', NULL);
INSERT INTO `ws_appserver` VALUES ('pf01-server2', 'iedaau002', 15414, 'tiersprodfix', '2007-01-02 16:02:04', NULL);
INSERT INTO `ws_appserver` VALUES ('psrserver', 'psrnode', 666, 'psrapp', '2007-01-03 13:49:37', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `ws_cell`
-- 

CREATE TABLE `ws_cell` (
  `WS_CELL_NAME` varchar(30) NOT NULL,
  `ADMIN_HTTP` varchar(50) NOT NULL,
  PRIMARY KEY  (`WS_CELL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `ws_cell`
-- 

INSERT INTO `ws_cell` VALUES ('tiers_aging_Network', 'https://iedaau018:14204/admin/');
INSERT INTO `ws_cell` VALUES ('tiers_apt_Network', 'https://iedaau018:10504/admin/logon.jsp');
INSERT INTO `ws_cell` VALUES ('tiers_ast_Network', 'http://iedaau018:14503/admin/secure/logon.do');
INSERT INTO `ws_cell` VALUES ('tiers_conv_Network', 'http://iedaau018:14003/admin');
INSERT INTO `ws_cell` VALUES ('tiers_dar_Network', 'http://iedaau018:10903/admin');
INSERT INTO `ws_cell` VALUES ('tiers_dr_Network', 'http://iedaau018:10603/admin');
INSERT INTO `ws_cell` VALUES ('tiers_genx_Network', 'http://iedaau018:10803/admin');
INSERT INTO `ws_cell` VALUES ('tiers_ipt_Network', 'http://iedaau018:10203/admin');
INSERT INTO `ws_cell` VALUES ('tiers_last_Network', 'http://iedaau018:14103/admin');
INSERT INTO `ws_cell` VALUES ('tiers_misc_Network', 'http://iedaau018:14303/admin/');
INSERT INTO `ws_cell` VALUES ('tiers_prodfix_Network', 'http://iedaau018:10703/admin');
INSERT INTO `ws_cell` VALUES ('tiers_training_Network', 'http://ietsau001:11003/admin');
INSERT INTO `ws_cell` VALUES ('tiers_trainpractice_Network', 'http://ietsau001:11103/admin');
