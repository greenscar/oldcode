-- phpMyAdmin SQL Dump
-- version 2.11.9.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 01, 2009 at 09:16 PM
-- Server version: 4.1.22
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `h8ncom_tiwi1`
--
-- CREATE DATABASE `h8ncom_tiwi1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `hncom_tiwi1`;

-- --------------------------------------------------------

--
-- Table structure for table `galaxia_activities`
--

CREATE TABLE IF NOT EXISTS `galaxia_activities` (
  `activityId` int(14) NOT NULL auto_increment,
  `name` varchar(80) default NULL,
  `normalized_name` varchar(80) default NULL,
  `pId` int(14) NOT NULL default '0',
  `type` enum('start','end','split','switch','join','activity','standalone') default NULL,
  `isAutoRouted` char(1) default NULL,
  `flowNum` int(10) default NULL,
  `isInteractive` char(1) default NULL,
  `lastModif` int(14) default NULL,
  `description` text,
  `expirationTime` int(6) unsigned NOT NULL default '0',
  PRIMARY KEY  (`activityId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `galaxia_activities`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_activity_roles`
--

CREATE TABLE IF NOT EXISTS `galaxia_activity_roles` (
  `activityId` int(14) NOT NULL default '0',
  `roleId` int(14) NOT NULL default '0',
  PRIMARY KEY  (`activityId`,`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `galaxia_activity_roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_instance_activities`
--

CREATE TABLE IF NOT EXISTS `galaxia_instance_activities` (
  `instanceId` int(14) NOT NULL default '0',
  `activityId` int(14) NOT NULL default '0',
  `started` int(14) NOT NULL default '0',
  `ended` int(14) NOT NULL default '0',
  `user` varchar(40) default NULL,
  `status` enum('running','completed') default NULL,
  PRIMARY KEY  (`instanceId`,`activityId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `galaxia_instance_activities`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_instance_comments`
--

CREATE TABLE IF NOT EXISTS `galaxia_instance_comments` (
  `cId` int(14) NOT NULL auto_increment,
  `instanceId` int(14) NOT NULL default '0',
  `user` varchar(40) default NULL,
  `activityId` int(14) default NULL,
  `hash` varchar(32) default NULL,
  `title` varchar(250) default NULL,
  `comment` text,
  `activity` varchar(80) default NULL,
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`cId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `galaxia_instance_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_instances`
--

CREATE TABLE IF NOT EXISTS `galaxia_instances` (
  `instanceId` int(14) NOT NULL auto_increment,
  `pId` int(14) NOT NULL default '0',
  `started` int(14) default NULL,
  `name` varchar(200) NOT NULL default 'No Name',
  `owner` varchar(200) default NULL,
  `nextActivity` int(14) default NULL,
  `nextUser` varchar(200) default NULL,
  `ended` int(14) default NULL,
  `status` enum('active','exception','aborted','completed') default NULL,
  `properties` longblob,
  PRIMARY KEY  (`instanceId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `galaxia_instances`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_processes`
--

CREATE TABLE IF NOT EXISTS `galaxia_processes` (
  `pId` int(14) NOT NULL auto_increment,
  `name` varchar(80) default NULL,
  `isValid` char(1) default NULL,
  `isActive` char(1) default NULL,
  `version` varchar(12) default NULL,
  `description` text,
  `lastModif` int(14) default NULL,
  `normalized_name` varchar(80) default NULL,
  PRIMARY KEY  (`pId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `galaxia_processes`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_roles`
--

CREATE TABLE IF NOT EXISTS `galaxia_roles` (
  `roleId` int(14) NOT NULL auto_increment,
  `pId` int(14) NOT NULL default '0',
  `lastModif` int(14) default NULL,
  `name` varchar(80) default NULL,
  `description` text,
  PRIMARY KEY  (`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `galaxia_roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_transitions`
--

CREATE TABLE IF NOT EXISTS `galaxia_transitions` (
  `pId` int(14) NOT NULL default '0',
  `actFromId` int(14) NOT NULL default '0',
  `actToId` int(14) NOT NULL default '0',
  PRIMARY KEY  (`actFromId`,`actToId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `galaxia_transitions`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_user_roles`
--

CREATE TABLE IF NOT EXISTS `galaxia_user_roles` (
  `pId` int(14) NOT NULL default '0',
  `roleId` int(14) NOT NULL auto_increment,
  `user` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`roleId`,`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `galaxia_user_roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `galaxia_workitems`
--

CREATE TABLE IF NOT EXISTS `galaxia_workitems` (
  `itemId` int(14) NOT NULL auto_increment,
  `instanceId` int(14) NOT NULL default '0',
  `orderId` int(14) NOT NULL default '0',
  `activityId` int(14) NOT NULL default '0',
  `properties` longblob,
  `started` int(14) default NULL,
  `ended` int(14) default NULL,
  `user` varchar(40) default NULL,
  PRIMARY KEY  (`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `galaxia_workitems`
--


-- --------------------------------------------------------

--
-- Table structure for table `messu_archive`
--

CREATE TABLE IF NOT EXISTS `messu_archive` (
  `msgId` int(14) NOT NULL auto_increment,
  `user` varchar(40) NOT NULL default '',
  `user_from` varchar(40) NOT NULL default '',
  `user_to` text,
  `user_cc` text,
  `user_bcc` text,
  `subject` varchar(255) default NULL,
  `body` text,
  `hash` varchar(32) default NULL,
  `replyto_hash` varchar(32) default NULL,
  `date` int(14) default NULL,
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  `priority` int(2) default NULL,
  PRIMARY KEY  (`msgId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `messu_archive`
--


-- --------------------------------------------------------

--
-- Table structure for table `messu_messages`
--

CREATE TABLE IF NOT EXISTS `messu_messages` (
  `msgId` int(14) NOT NULL auto_increment,
  `user` varchar(40) NOT NULL default '',
  `user_from` varchar(200) NOT NULL default '',
  `user_to` text,
  `user_cc` text,
  `user_bcc` text,
  `subject` varchar(255) default NULL,
  `body` text,
  `hash` varchar(32) default NULL,
  `replyto_hash` varchar(32) default NULL,
  `date` int(14) default NULL,
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  `priority` int(2) default NULL,
  PRIMARY KEY  (`msgId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `messu_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `messu_sent`
--

CREATE TABLE IF NOT EXISTS `messu_sent` (
  `msgId` int(14) NOT NULL auto_increment,
  `user` varchar(40) NOT NULL default '',
  `user_from` varchar(40) NOT NULL default '',
  `user_to` text,
  `user_cc` text,
  `user_bcc` text,
  `subject` varchar(255) default NULL,
  `body` text,
  `hash` varchar(32) default NULL,
  `replyto_hash` varchar(32) default NULL,
  `date` int(14) default NULL,
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  `priority` int(2) default NULL,
  PRIMARY KEY  (`msgId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `messu_sent`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `sesskey` varchar(32) NOT NULL default '',
  `expiry` int(11) unsigned NOT NULL default '0',
  `expireref` varchar(64) default NULL,
  `data` text NOT NULL,
  PRIMARY KEY  (`sesskey`),
  KEY `expiry` (`expiry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_actionlog`
--

CREATE TABLE IF NOT EXISTS `tiki_actionlog` (
  `action` varchar(255) NOT NULL default '',
  `lastModif` int(14) default NULL,
  `pageName` varchar(200) default NULL,
  `user` varchar(40) default NULL,
  `ip` varchar(15) default NULL,
  `comment` varchar(200) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_actionlog`
--

INSERT INTO `tiki_actionlog` (`action`, `lastModif`, `pageName`, `user`, `ip`, `comment`) VALUES
('Updated', 1181924675, 'HomePage', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181924718, 'HomePage', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181924922, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181926432, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181927468, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181928565, 'Networking', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181928843, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181929552, 'Searching', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181929678, 'Searching', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181929717, 'Searching', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181929731, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181929797, 'Scripting', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181929810, 'Scripting', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181930005, 'Searching', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181930023, 'Searching', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181930135, 'Maintain Users', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181930165, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181930190, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181931016, 'File System', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181931171, 'File System', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181931264, 'Networking', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181931305, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181931907, 'Running Processes', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181931956, 'Linux', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181932010, 'System', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181932092, 'Maintain Users', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181932165, 'HomePage', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181932363, 'WebSphere', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181932364, 'WebSphere', 'c8h10n4o2', '168.56.37.8', ''),
('Created', 1181935287, 'Subversion', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181936154, 'Subversion', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181936328, 'Subversion', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181936402, 'Subversion', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1181936430, 'Subversion', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1182181594, 'System', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1182460789, 'Subversion', 'c8h10n4o2', '168.56.37.8', ''),
('Updated', 1182481604, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Created', 1182481617, 'Adobe Premier', 'c8h10n4o2', '66.68.76.76', ''),
('Created', 1182482350, 'PHP', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482677, 'PHP', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482879, 'PHP', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482906, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482915, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482928, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482940, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482971, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182482987, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182483015, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182483035, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182483052, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182483064, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182483084, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Created', 1182483161, 'PERL_Code', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1182483179, 'PERL_Code', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1183719368, 'HomePage', 'c8h10n4o2', '72.255.27.197', ''),
('Created', 1183719379, 'Quotes', 'c8h10n4o2', '72.255.27.197', ''),
('Updated', 1183724886, 'Linux', 'c8h10n4o2', '72.255.68.35', ''),
('Created', 1183725010, 'Samba', 'c8h10n4o2', '72.255.68.35', ''),
('Updated', 1183725037, 'Samba', 'c8h10n4o2', '72.255.68.35', ''),
('Updated', 1183725069, 'Samba', 'c8h10n4o2', '72.255.68.35', ''),
('Updated', 1184281632, 'PERL_Code', 'c8h10n4o2', '72.255.19.226', ''),
('Updated', 1184281657, 'PERL_Code', 'c8h10n4o2', '72.255.19.226', ''),
('Updated', 1185066744, 'Linux', 'c8h10n4o2', '72.255.41.15', ''),
('Created', 1185071886, 'Treo 650 setup with Ubuntu', 'c8h10n4o2', '72.255.41.15', ''),
('Updated', 1185113476, 'Linux', 'c8h10n4o2', '72.255.41.15', ''),
('Created', 1185114278, 'Gateway m675x Radeon 9700m Ubuntu Setup', 'c8h10n4o2', '72.255.41.15', ''),
('Updated', 1185223355, 'System', 'c8h10n4o2', '72.255.3.164', ''),
('Updated', 1185223380, 'System', 'c8h10n4o2', '72.255.3.164', ''),
('Updated', 1186712739, 'Subversion', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1186712775, 'Subversion', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1186714408, 'Linux', 'c8h10n4o2', '66.68.76.76', ''),
('Created', 1186714607, 'Ubuntu', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1186863610, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1186863638, 'HomePage', 'c8h10n4o2', '66.68.76.76', ''),
('Updated', 1191509962, 'File System', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1192107006, 'Networking', 'c8h10n4o2', '72.177.2.140', ''),
('Updated', 1192113583, 'Networking', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1193412738, 'System', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1193671040, 'Searching', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1193671440, 'Searching', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1194749573, 'System', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1194751852, 'System', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1195311507, 'HomePage', 'c8h10n4o2', '66.68.51.87', ''),
('Created', 1195311530, 'Adobe Photoshop', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1195311549, 'Adobe Photoshop', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1199380422, 'Linux', 'c8h10n4o2', '24.153.198.63', ''),
('Created', 1199380472, 'Send Email', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1199385409, 'Running Processes', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1199385465, 'Running Processes', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1199386573, 'Running Processes', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1199452129, 'File System', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1199555841, 'Subversion', 'c8h10n4o2', '24.153.198.63', ''),
('Updated', 1203655577, 'Linux', 'c8h10n4o2', '66.68.51.87', ''),
('Created', 1203655624, 'RocketRaid', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203655761, 'RocketRaid', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203656785, 'RocketRaid', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203736693, 'Networking', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203737019, 'RocketRaid', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203737411, 'RocketRaid', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203779646, 'RocketRaid', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203781102, 'Linux', 'c8h10n4o2', '66.68.51.87', ''),
('Created', 1203781198, 'Highpoint RocketRaid 1820A with Ubuntu', 'c8h10n4o2', '66.68.51.87', ''),
('Removed', 1203781212, 'RocketRaid', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203781493, 'Linux', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1203781630, 'Highpoint RocketRaid 1820A with Ubuntu', 'c8h10n4o2', '66.68.51.87', ''),
('Removed', 1203781704, 'Highpoint RocketRaid 1820A with Ubuntu', 'c8h10n4o2', '66.68.51.87', ''),
('Created', 1203781720, 'Highpoint RocketRAID 1820A with Ubuntu', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1204506973, 'Networking', 'c8h10n4o2', '66.68.51.87', ''),
('Updated', 1211421809, 'HomePage', 'c8h10n4o2', '66.68.52.223', ''),
('Created', 1211421893, 'OS X', 'c8h10n4o2', '66.68.52.223', ''),
('Updated', 1219773866, 'HomePage', 'c8h10n4o2', '168.40.104.46', ''),
('Created', 1219778881, 'Rational ClearCase', 'admin', '168.40.105.128', ''),
('Updated', 1219779814, 'Rational ClearCase', 'admin', '168.40.105.128', ''),
('Updated', 1219779858, 'Rational ClearCase', 'admin', '168.40.105.128', ''),
('Updated', 1219779941, 'Rational ClearCase', 'admin', '168.40.105.128', ''),
('Updated', 1219780938, 'Rational ClearCase', 'admin', '168.40.105.128', ''),
('Updated', 1219781218, 'Rational ClearCase', 'admin', '168.40.105.128', ''),
('Updated', 1221506756, 'Rational ClearCase', 'c8h10n4o2', '168.40.104.43', ''),
('Updated', 1221507142, 'Rational ClearCase', 'c8h10n4o2', '168.40.104.43', ''),
('Updated', 1221570512, 'Rational ClearCase', 'c8h10n4o2', '66.68.52.223', ''),
('Updated', 1222112990, 'Rational ClearCase', 'c8h10n4o2', '168.40.105.128', ''),
('Updated', 1222973182, 'System', 'c8h10n4o2', '168.40.106.255', '');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_article_types`
--

CREATE TABLE IF NOT EXISTS `tiki_article_types` (
  `type` varchar(50) NOT NULL default '',
  `use_ratings` char(1) default NULL,
  `show_pre_publ` char(1) default NULL,
  `show_post_expire` char(1) default 'y',
  `heading_only` char(1) default NULL,
  `allow_comments` char(1) default 'y',
  `show_image` char(1) default 'y',
  `show_avatar` char(1) default NULL,
  `show_author` char(1) default 'y',
  `show_pubdate` char(1) default 'y',
  `show_expdate` char(1) default NULL,
  `show_reads` char(1) default 'y',
  `show_size` char(1) default 'y',
  `show_topline` char(1) default 'n',
  `show_subtitle` char(1) default 'n',
  `show_linkto` char(1) default 'n',
  `show_image_caption` char(1) default 'n',
  `show_lang` char(1) default 'n',
  `creator_edit` char(1) default NULL,
  `comment_can_rate_article` char(1) default NULL,
  PRIMARY KEY  (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_article_types`
--

INSERT INTO `tiki_article_types` (`type`, `use_ratings`, `show_pre_publ`, `show_post_expire`, `heading_only`, `allow_comments`, `show_image`, `show_avatar`, `show_author`, `show_pubdate`, `show_expdate`, `show_reads`, `show_size`, `show_topline`, `show_subtitle`, `show_linkto`, `show_image_caption`, `show_lang`, `creator_edit`, `comment_can_rate_article`) VALUES
('Article', NULL, NULL, 'y', NULL, 'y', 'y', NULL, 'y', 'y', NULL, 'y', 'y', 'n', 'n', 'n', 'n', 'n', NULL, NULL),
('Review', 'y', NULL, 'y', NULL, 'y', 'y', NULL, 'y', 'y', NULL, 'y', 'y', 'n', 'n', 'n', 'n', 'n', NULL, NULL),
('Event', NULL, NULL, 'n', NULL, 'y', 'y', NULL, 'y', 'y', NULL, 'y', 'y', 'n', 'n', 'n', 'n', 'n', NULL, NULL),
('Classified', NULL, NULL, 'n', 'y', 'n', 'y', NULL, 'y', 'y', NULL, 'y', 'y', 'n', 'n', 'n', 'n', 'n', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_articles`
--

CREATE TABLE IF NOT EXISTS `tiki_articles` (
  `articleId` int(8) NOT NULL auto_increment,
  `topline` varchar(255) default NULL,
  `title` varchar(80) default NULL,
  `subtitle` varchar(255) default NULL,
  `linkto` varchar(255) default NULL,
  `lang` varchar(16) default NULL,
  `state` char(1) default 's',
  `authorName` varchar(60) default NULL,
  `topicId` int(14) default NULL,
  `topicName` varchar(40) default NULL,
  `size` int(12) default NULL,
  `useImage` char(1) default NULL,
  `image_name` varchar(80) default NULL,
  `image_caption` text,
  `image_type` varchar(80) default NULL,
  `image_size` int(14) default NULL,
  `image_x` int(4) default NULL,
  `image_y` int(4) default NULL,
  `image_data` longblob,
  `publishDate` int(14) default NULL,
  `expireDate` int(14) default NULL,
  `created` int(14) default NULL,
  `heading` text,
  `body` text,
  `hash` varchar(32) default NULL,
  `author` varchar(200) default NULL,
  `nbreads` int(14) default NULL,
  `votes` int(8) default NULL,
  `points` int(14) default NULL,
  `type` varchar(50) default NULL,
  `rating` decimal(3,2) default NULL,
  `isfloat` char(1) default NULL,
  PRIMARY KEY  (`articleId`),
  KEY `title` (`title`),
  KEY `heading` (`heading`(255)),
  KEY `body` (`body`(255)),
  KEY `author` (`author`(32)),
  KEY `nbreads` (`nbreads`),
  FULLTEXT KEY `ft` (`title`,`heading`,`body`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_articles`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_banners`
--

CREATE TABLE IF NOT EXISTS `tiki_banners` (
  `bannerId` int(12) NOT NULL auto_increment,
  `client` varchar(200) NOT NULL default '',
  `url` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `alt` varchar(250) default NULL,
  `which` varchar(50) default NULL,
  `imageData` longblob,
  `imageType` varchar(200) default NULL,
  `imageName` varchar(100) default NULL,
  `HTMLData` text,
  `fixedURLData` varchar(255) default NULL,
  `textData` text,
  `fromDate` int(14) default NULL,
  `toDate` int(14) default NULL,
  `useDates` char(1) default NULL,
  `mon` char(1) default NULL,
  `tue` char(1) default NULL,
  `wed` char(1) default NULL,
  `thu` char(1) default NULL,
  `fri` char(1) default NULL,
  `sat` char(1) default NULL,
  `sun` char(1) default NULL,
  `hourFrom` varchar(4) default NULL,
  `hourTo` varchar(4) default NULL,
  `created` int(14) default NULL,
  `maxImpressions` int(8) default NULL,
  `impressions` int(8) default NULL,
  `clicks` int(8) default NULL,
  `zone` varchar(40) default NULL,
  PRIMARY KEY  (`bannerId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_banners`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_banning`
--

CREATE TABLE IF NOT EXISTS `tiki_banning` (
  `banId` int(12) NOT NULL auto_increment,
  `mode` enum('user','ip') default NULL,
  `title` varchar(200) default NULL,
  `ip1` char(3) default NULL,
  `ip2` char(3) default NULL,
  `ip3` char(3) default NULL,
  `ip4` char(3) default NULL,
  `user` varchar(40) default NULL,
  `date_from` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `date_to` timestamp NOT NULL default '0000-00-00 00:00:00',
  `use_dates` char(1) default NULL,
  `created` int(14) default NULL,
  `message` text,
  PRIMARY KEY  (`banId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_banning`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_banning_sections`
--

CREATE TABLE IF NOT EXISTS `tiki_banning_sections` (
  `banId` int(12) NOT NULL default '0',
  `section` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`banId`,`section`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_banning_sections`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_blog_activity`
--

CREATE TABLE IF NOT EXISTS `tiki_blog_activity` (
  `blogId` int(8) NOT NULL default '0',
  `day` int(14) NOT NULL default '0',
  `posts` int(8) default NULL,
  PRIMARY KEY  (`blogId`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_blog_activity`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_blog_posts`
--

CREATE TABLE IF NOT EXISTS `tiki_blog_posts` (
  `postId` int(8) NOT NULL auto_increment,
  `blogId` int(8) NOT NULL default '0',
  `data` text,
  `data_size` int(11) unsigned NOT NULL default '0',
  `created` int(14) default NULL,
  `user` varchar(40) default NULL,
  `trackbacks_to` text,
  `trackbacks_from` text,
  `title` varchar(80) default NULL,
  `priv` char(1) default NULL,
  PRIMARY KEY  (`postId`),
  KEY `data` (`data`(255)),
  KEY `blogId` (`blogId`),
  KEY `created` (`created`),
  FULLTEXT KEY `ft` (`data`,`title`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_blog_posts`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_blog_posts_images`
--

CREATE TABLE IF NOT EXISTS `tiki_blog_posts_images` (
  `imgId` int(14) NOT NULL auto_increment,
  `postId` int(14) NOT NULL default '0',
  `filename` varchar(80) default NULL,
  `filetype` varchar(80) default NULL,
  `filesize` int(14) default NULL,
  `data` longblob,
  PRIMARY KEY  (`imgId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_blog_posts_images`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_blogs`
--

CREATE TABLE IF NOT EXISTS `tiki_blogs` (
  `blogId` int(8) NOT NULL auto_increment,
  `created` int(14) default NULL,
  `lastModif` int(14) default NULL,
  `title` varchar(200) default NULL,
  `description` text,
  `user` varchar(40) default NULL,
  `public` char(1) default NULL,
  `posts` int(8) default NULL,
  `maxPosts` int(8) default NULL,
  `hits` int(8) default NULL,
  `activity` decimal(4,2) default NULL,
  `heading` text,
  `use_find` char(1) default NULL,
  `use_title` char(1) default NULL,
  `add_date` char(1) default NULL,
  `add_poster` char(1) default NULL,
  `allow_comments` char(1) default NULL,
  `show_avatar` char(1) default NULL,
  PRIMARY KEY  (`blogId`),
  KEY `title` (`title`),
  KEY `description` (`description`(255)),
  KEY `hits` (`hits`),
  FULLTEXT KEY `ft` (`title`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_blogs`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_calendar_categories`
--

CREATE TABLE IF NOT EXISTS `tiki_calendar_categories` (
  `calcatId` int(11) NOT NULL auto_increment,
  `calendarId` int(14) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`calcatId`),
  UNIQUE KEY `catname` (`calendarId`,`name`(16))
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_calendar_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_calendar_items`
--

CREATE TABLE IF NOT EXISTS `tiki_calendar_items` (
  `calitemId` int(14) NOT NULL auto_increment,
  `calendarId` int(14) NOT NULL default '0',
  `start` int(14) NOT NULL default '0',
  `end` int(14) NOT NULL default '0',
  `locationId` int(14) default NULL,
  `categoryId` int(14) default NULL,
  `nlId` int(12) NOT NULL default '0',
  `priority` enum('1','2','3','4','5','6','7','8','9') NOT NULL default '1',
  `status` enum('0','1','2') NOT NULL default '0',
  `url` varchar(255) default NULL,
  `lang` varchar(16) NOT NULL default 'en',
  `name` varchar(255) NOT NULL default '',
  `description` blob,
  `user` varchar(40) default NULL,
  `created` int(14) NOT NULL default '0',
  `lastmodif` int(14) NOT NULL default '0',
  PRIMARY KEY  (`calitemId`),
  KEY `calendarId` (`calendarId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_calendar_items`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_calendar_locations`
--

CREATE TABLE IF NOT EXISTS `tiki_calendar_locations` (
  `callocId` int(14) NOT NULL auto_increment,
  `calendarId` int(14) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `description` blob,
  PRIMARY KEY  (`callocId`),
  UNIQUE KEY `locname` (`calendarId`,`name`(16))
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_calendar_locations`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_calendar_roles`
--

CREATE TABLE IF NOT EXISTS `tiki_calendar_roles` (
  `calitemId` int(14) NOT NULL default '0',
  `username` varchar(40) NOT NULL default '',
  `role` enum('0','1','2','3','6') NOT NULL default '0',
  PRIMARY KEY  (`calitemId`,`username`(16),`role`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_calendar_roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_calendars`
--

CREATE TABLE IF NOT EXISTS `tiki_calendars` (
  `calendarId` int(14) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL default '',
  `description` varchar(255) default NULL,
  `user` varchar(40) NOT NULL default '',
  `customlocations` enum('n','y') NOT NULL default 'n',
  `customcategories` enum('n','y') NOT NULL default 'n',
  `customlanguages` enum('n','y') NOT NULL default 'n',
  `custompriorities` enum('n','y') NOT NULL default 'n',
  `customparticipants` enum('n','y') NOT NULL default 'n',
  `customsubscription` enum('n','y') NOT NULL default 'n',
  `created` int(14) NOT NULL default '0',
  `lastmodif` int(14) NOT NULL default '0',
  `personal` enum('n','y') NOT NULL default 'n',
  PRIMARY KEY  (`calendarId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_calendars`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_categories`
--

CREATE TABLE IF NOT EXISTS `tiki_categories` (
  `categId` int(12) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `description` varchar(250) default NULL,
  `parentId` int(12) default NULL,
  `hits` int(8) default NULL,
  PRIMARY KEY  (`categId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_categorized_objects`
--

CREATE TABLE IF NOT EXISTS `tiki_categorized_objects` (
  `catObjectId` int(12) NOT NULL auto_increment,
  `type` varchar(50) default NULL,
  `objId` varchar(255) default NULL,
  `description` text,
  `created` int(14) default NULL,
  `name` varchar(200) default NULL,
  `href` varchar(200) default NULL,
  `hits` int(8) default NULL,
  PRIMARY KEY  (`catObjectId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_categorized_objects`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_category_objects`
--

CREATE TABLE IF NOT EXISTS `tiki_category_objects` (
  `catObjectId` int(12) NOT NULL default '0',
  `categId` int(12) NOT NULL default '0',
  PRIMARY KEY  (`catObjectId`,`categId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_category_objects`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_category_sites`
--

CREATE TABLE IF NOT EXISTS `tiki_category_sites` (
  `categId` int(10) NOT NULL default '0',
  `siteId` int(14) NOT NULL default '0',
  PRIMARY KEY  (`categId`,`siteId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_category_sites`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_chart_items`
--

CREATE TABLE IF NOT EXISTS `tiki_chart_items` (
  `itemId` int(14) NOT NULL auto_increment,
  `title` varchar(250) default NULL,
  `description` text,
  `chartId` int(14) NOT NULL default '0',
  `created` int(14) default NULL,
  `URL` varchar(250) default NULL,
  `votes` int(14) default NULL,
  `points` int(14) default NULL,
  `average` decimal(4,2) default NULL,
  PRIMARY KEY  (`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_chart_items`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_charts`
--

CREATE TABLE IF NOT EXISTS `tiki_charts` (
  `chartId` int(14) NOT NULL auto_increment,
  `title` varchar(250) default NULL,
  `description` text,
  `hits` int(14) default NULL,
  `singleItemVotes` char(1) default NULL,
  `singleChartVotes` char(1) default NULL,
  `suggestions` char(1) default NULL,
  `autoValidate` char(1) default NULL,
  `topN` int(6) default NULL,
  `maxVoteValue` int(4) default NULL,
  `frequency` int(14) default NULL,
  `showAverage` char(1) default NULL,
  `isActive` char(1) default NULL,
  `showVotes` char(1) default NULL,
  `useCookies` char(1) default NULL,
  `lastChart` int(14) default NULL,
  `voteAgainAfter` int(14) default NULL,
  `created` int(14) default NULL,
  PRIMARY KEY  (`chartId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_charts`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_charts_rankings`
--

CREATE TABLE IF NOT EXISTS `tiki_charts_rankings` (
  `chartId` int(14) NOT NULL default '0',
  `itemId` int(14) NOT NULL default '0',
  `position` int(14) NOT NULL default '0',
  `timestamp` int(14) NOT NULL default '0',
  `lastPosition` int(14) NOT NULL default '0',
  `period` int(14) NOT NULL default '0',
  `rvotes` int(14) NOT NULL default '0',
  `raverage` decimal(4,2) NOT NULL default '0.00',
  PRIMARY KEY  (`chartId`,`itemId`,`period`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_charts_rankings`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_charts_votes`
--

CREATE TABLE IF NOT EXISTS `tiki_charts_votes` (
  `user` varchar(40) NOT NULL default '',
  `itemId` int(14) NOT NULL default '0',
  `timestamp` int(14) default NULL,
  `chartId` int(14) default NULL,
  PRIMARY KEY  (`user`,`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_charts_votes`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_chat_channels`
--

CREATE TABLE IF NOT EXISTS `tiki_chat_channels` (
  `channelId` int(8) NOT NULL auto_increment,
  `name` varchar(30) default NULL,
  `description` varchar(250) default NULL,
  `max_users` int(8) default NULL,
  `mode` char(1) default NULL,
  `moderator` varchar(200) default NULL,
  `active` char(1) default NULL,
  `refresh` int(6) default NULL,
  PRIMARY KEY  (`channelId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_chat_channels`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_chat_messages`
--

CREATE TABLE IF NOT EXISTS `tiki_chat_messages` (
  `messageId` int(8) NOT NULL auto_increment,
  `channelId` int(8) NOT NULL default '0',
  `data` varchar(255) default NULL,
  `poster` varchar(200) NOT NULL default 'anonymous',
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`messageId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_chat_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_chat_users`
--

CREATE TABLE IF NOT EXISTS `tiki_chat_users` (
  `nickname` varchar(200) NOT NULL default '',
  `channelId` int(8) NOT NULL default '0',
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`nickname`,`channelId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_chat_users`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_comments`
--

CREATE TABLE IF NOT EXISTS `tiki_comments` (
  `threadId` int(14) NOT NULL auto_increment,
  `object` varchar(255) NOT NULL default '',
  `objectType` varchar(32) NOT NULL default '',
  `parentId` int(14) default NULL,
  `userName` varchar(40) default NULL,
  `commentDate` int(14) default NULL,
  `hits` int(8) default NULL,
  `type` char(1) default NULL,
  `points` decimal(8,2) default NULL,
  `votes` int(8) default NULL,
  `average` decimal(8,4) default NULL,
  `title` varchar(100) default NULL,
  `data` text,
  `hash` varchar(32) default NULL,
  `user_ip` varchar(15) default NULL,
  `summary` varchar(240) default NULL,
  `smiley` varchar(80) default NULL,
  `message_id` varchar(250) default NULL,
  `in_reply_to` varchar(250) default NULL,
  `comment_rating` tinyint(2) default NULL,
  PRIMARY KEY  (`threadId`),
  KEY `title` (`title`),
  KEY `data` (`data`(255)),
  KEY `object` (`object`),
  KEY `hits` (`hits`),
  KEY `tc_pi` (`parentId`),
  FULLTEXT KEY `ft` (`title`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_content`
--

CREATE TABLE IF NOT EXISTS `tiki_content` (
  `contentId` int(8) NOT NULL auto_increment,
  `description` text,
  PRIMARY KEY  (`contentId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_content`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_content_templates`
--

CREATE TABLE IF NOT EXISTS `tiki_content_templates` (
  `templateId` int(10) NOT NULL auto_increment,
  `content` longblob,
  `name` varchar(200) default NULL,
  `created` int(14) default NULL,
  PRIMARY KEY  (`templateId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_content_templates`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_content_templates_sections`
--

CREATE TABLE IF NOT EXISTS `tiki_content_templates_sections` (
  `templateId` int(10) NOT NULL default '0',
  `section` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`templateId`,`section`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_content_templates_sections`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_cookies`
--

CREATE TABLE IF NOT EXISTS `tiki_cookies` (
  `cookieId` int(10) NOT NULL auto_increment,
  `cookie` text,
  PRIMARY KEY  (`cookieId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_cookies`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_copyrights`
--

CREATE TABLE IF NOT EXISTS `tiki_copyrights` (
  `copyrightId` int(12) NOT NULL auto_increment,
  `page` varchar(200) default NULL,
  `title` varchar(200) default NULL,
  `year` int(11) default NULL,
  `authors` varchar(200) default NULL,
  `copyright_order` int(11) default NULL,
  `userName` varchar(40) default NULL,
  PRIMARY KEY  (`copyrightId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_copyrights`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_directory_categories`
--

CREATE TABLE IF NOT EXISTS `tiki_directory_categories` (
  `categId` int(10) NOT NULL auto_increment,
  `parent` int(10) default NULL,
  `name` varchar(240) default NULL,
  `description` text,
  `childrenType` char(1) default NULL,
  `sites` int(10) default NULL,
  `viewableChildren` int(4) default NULL,
  `allowSites` char(1) default NULL,
  `showCount` char(1) default NULL,
  `editorGroup` varchar(200) default NULL,
  `hits` int(12) default NULL,
  PRIMARY KEY  (`categId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_directory_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_directory_search`
--

CREATE TABLE IF NOT EXISTS `tiki_directory_search` (
  `term` varchar(250) NOT NULL default '',
  `hits` int(14) default NULL,
  PRIMARY KEY  (`term`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_directory_search`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_directory_sites`
--

CREATE TABLE IF NOT EXISTS `tiki_directory_sites` (
  `siteId` int(14) NOT NULL auto_increment,
  `name` varchar(240) default NULL,
  `description` text,
  `url` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `hits` int(12) default NULL,
  `isValid` char(1) default NULL,
  `created` int(14) default NULL,
  `lastModif` int(14) default NULL,
  `cache` longblob,
  `cache_timestamp` int(14) default NULL,
  PRIMARY KEY  (`siteId`),
  FULLTEXT KEY `ft` (`name`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_directory_sites`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_download`
--

CREATE TABLE IF NOT EXISTS `tiki_download` (
  `id` int(11) NOT NULL auto_increment,
  `object` varchar(255) NOT NULL default '',
  `userId` int(8) NOT NULL default '0',
  `type` varchar(20) NOT NULL default '',
  `date` int(14) NOT NULL default '0',
  `IP` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `object` (`object`,`userId`,`type`),
  KEY `userId` (`userId`),
  KEY `type` (`type`),
  KEY `date` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_download`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_drawings`
--

CREATE TABLE IF NOT EXISTS `tiki_drawings` (
  `drawId` int(12) NOT NULL auto_increment,
  `version` int(8) default NULL,
  `name` varchar(250) default NULL,
  `filename_draw` varchar(250) default NULL,
  `filename_pad` varchar(250) default NULL,
  `timestamp` int(14) default NULL,
  `user` varchar(40) default NULL,
  PRIMARY KEY  (`drawId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_drawings`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_dsn`
--

CREATE TABLE IF NOT EXISTS `tiki_dsn` (
  `dsnId` int(12) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL default '',
  `dsn` varchar(255) default NULL,
  PRIMARY KEY  (`dsnId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_dsn`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_dynamic_variables`
--

CREATE TABLE IF NOT EXISTS `tiki_dynamic_variables` (
  `name` varchar(40) NOT NULL default '',
  `data` text,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_dynamic_variables`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_eph`
--

CREATE TABLE IF NOT EXISTS `tiki_eph` (
  `ephId` int(12) NOT NULL auto_increment,
  `title` varchar(250) default NULL,
  `isFile` char(1) default NULL,
  `filename` varchar(250) default NULL,
  `filetype` varchar(250) default NULL,
  `filesize` varchar(250) default NULL,
  `data` longblob,
  `textdata` longblob,
  `publish` int(14) default NULL,
  `hits` int(10) default NULL,
  PRIMARY KEY  (`ephId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_eph`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_extwiki`
--

CREATE TABLE IF NOT EXISTS `tiki_extwiki` (
  `extwikiId` int(12) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL default '',
  `extwiki` varchar(255) default NULL,
  PRIMARY KEY  (`extwikiId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_extwiki`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_faq_questions`
--

CREATE TABLE IF NOT EXISTS `tiki_faq_questions` (
  `questionId` int(10) NOT NULL auto_increment,
  `faqId` int(10) default NULL,
  `position` int(4) default NULL,
  `question` text,
  `answer` text,
  PRIMARY KEY  (`questionId`),
  KEY `faqId` (`faqId`),
  KEY `question` (`question`(255)),
  KEY `answer` (`answer`(255)),
  FULLTEXT KEY `ft` (`question`,`answer`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_faq_questions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_faqs`
--

CREATE TABLE IF NOT EXISTS `tiki_faqs` (
  `faqId` int(10) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `description` text,
  `created` int(14) default NULL,
  `questions` int(5) default NULL,
  `hits` int(8) default NULL,
  `canSuggest` char(1) default NULL,
  PRIMARY KEY  (`faqId`),
  KEY `title` (`title`),
  KEY `description` (`description`(255)),
  KEY `hits` (`hits`),
  FULLTEXT KEY `ft` (`title`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_faqs`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_featured_links`
--

CREATE TABLE IF NOT EXISTS `tiki_featured_links` (
  `url` varchar(200) NOT NULL default '',
  `title` varchar(200) default NULL,
  `description` text,
  `hits` int(8) default NULL,
  `position` int(6) default NULL,
  `type` char(1) default NULL,
  PRIMARY KEY  (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_featured_links`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_file_galleries`
--

CREATE TABLE IF NOT EXISTS `tiki_file_galleries` (
  `galleryId` int(14) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL default '',
  `description` text,
  `created` int(14) default NULL,
  `visible` char(1) default NULL,
  `lastModif` int(14) default NULL,
  `user` varchar(40) default NULL,
  `hits` int(14) default NULL,
  `votes` int(8) default NULL,
  `points` decimal(8,2) default NULL,
  `maxRows` int(10) default NULL,
  `public` char(1) default NULL,
  `show_id` char(1) default NULL,
  `show_icon` char(1) default NULL,
  `show_name` char(1) default NULL,
  `show_size` char(1) default NULL,
  `show_description` char(1) default NULL,
  `max_desc` int(8) default NULL,
  `show_created` char(1) default NULL,
  `show_dl` char(1) default NULL,
  PRIMARY KEY  (`galleryId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_file_galleries`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_file_handlers`
--

CREATE TABLE IF NOT EXISTS `tiki_file_handlers` (
  `mime_type` varchar(64) default NULL,
  `cmd` varchar(238) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_file_handlers`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_files`
--

CREATE TABLE IF NOT EXISTS `tiki_files` (
  `fileId` int(14) NOT NULL auto_increment,
  `galleryId` int(14) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `description` text,
  `created` int(14) default NULL,
  `filename` varchar(80) default NULL,
  `filesize` int(14) default NULL,
  `filetype` varchar(250) default NULL,
  `data` longblob,
  `user` varchar(40) default NULL,
  `downloads` int(14) default NULL,
  `votes` int(8) default NULL,
  `points` decimal(8,2) default NULL,
  `path` varchar(255) default NULL,
  `reference_url` varchar(250) default NULL,
  `is_reference` char(1) default NULL,
  `hash` varchar(32) default NULL,
  `search_data` longtext,
  `lastModif` int(14) default NULL,
  `lastModifUser` varchar(200) default NULL,
  PRIMARY KEY  (`fileId`),
  KEY `name` (`name`),
  KEY `description` (`description`(255)),
  KEY `downloads` (`downloads`),
  FULLTEXT KEY `ft` (`name`,`description`,`search_data`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_files`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_forum_attachments`
--

CREATE TABLE IF NOT EXISTS `tiki_forum_attachments` (
  `attId` int(14) NOT NULL auto_increment,
  `threadId` int(14) NOT NULL default '0',
  `qId` int(14) NOT NULL default '0',
  `forumId` int(14) default NULL,
  `filename` varchar(250) default NULL,
  `filetype` varchar(250) default NULL,
  `filesize` int(12) default NULL,
  `data` longblob,
  `dir` varchar(200) default NULL,
  `created` int(14) default NULL,
  `path` varchar(250) default NULL,
  PRIMARY KEY  (`attId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_forum_attachments`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_forum_reads`
--

CREATE TABLE IF NOT EXISTS `tiki_forum_reads` (
  `user` varchar(40) NOT NULL default '',
  `threadId` int(14) NOT NULL default '0',
  `forumId` int(14) default NULL,
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`user`,`threadId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_forum_reads`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_forums`
--

CREATE TABLE IF NOT EXISTS `tiki_forums` (
  `forumId` int(8) NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  `description` text,
  `created` int(14) default NULL,
  `lastPost` int(14) default NULL,
  `threads` int(8) default NULL,
  `comments` int(8) default NULL,
  `controlFlood` char(1) default NULL,
  `floodInterval` int(8) default NULL,
  `moderator` varchar(200) default NULL,
  `hits` int(8) default NULL,
  `mail` varchar(200) default NULL,
  `useMail` char(1) default NULL,
  `section` varchar(200) default NULL,
  `usePruneUnreplied` char(1) default NULL,
  `pruneUnrepliedAge` int(8) default NULL,
  `usePruneOld` char(1) default NULL,
  `pruneMaxAge` int(8) default NULL,
  `topicsPerPage` int(6) default NULL,
  `topicOrdering` varchar(100) default NULL,
  `threadOrdering` varchar(100) default NULL,
  `att` varchar(80) default NULL,
  `att_store` varchar(4) default NULL,
  `att_store_dir` varchar(250) default NULL,
  `att_max_size` int(12) default NULL,
  `ui_level` char(1) default NULL,
  `forum_password` varchar(32) default NULL,
  `forum_use_password` char(1) default NULL,
  `moderator_group` varchar(200) default NULL,
  `approval_type` varchar(20) default NULL,
  `outbound_address` varchar(250) default NULL,
  `outbound_mails_for_inbound_mails` char(1) default NULL,
  `outbound_mails_reply_link` char(1) default NULL,
  `outbound_from` varchar(250) default NULL,
  `inbound_pop_server` varchar(250) default NULL,
  `inbound_pop_port` int(4) default NULL,
  `inbound_pop_user` varchar(200) default NULL,
  `inbound_pop_password` varchar(80) default NULL,
  `topic_smileys` char(1) default NULL,
  `ui_avatar` char(1) default NULL,
  `ui_flag` char(1) default NULL,
  `ui_posts` char(1) default NULL,
  `ui_email` char(1) default NULL,
  `ui_online` char(1) default NULL,
  `topic_summary` char(1) default NULL,
  `show_description` char(1) default NULL,
  `topics_list_replies` char(1) default NULL,
  `topics_list_reads` char(1) default NULL,
  `topics_list_pts` char(1) default NULL,
  `topics_list_lastpost` char(1) default NULL,
  `topics_list_author` char(1) default NULL,
  `vote_threads` char(1) default NULL,
  `forum_last_n` int(2) default '0',
  PRIMARY KEY  (`forumId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_forums`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_forums_queue`
--

CREATE TABLE IF NOT EXISTS `tiki_forums_queue` (
  `qId` int(14) NOT NULL auto_increment,
  `object` varchar(32) default NULL,
  `parentId` int(14) default NULL,
  `forumId` int(14) default NULL,
  `timestamp` int(14) default NULL,
  `user` varchar(40) default NULL,
  `title` varchar(240) default NULL,
  `data` text,
  `type` varchar(60) default NULL,
  `hash` varchar(32) default NULL,
  `topic_smiley` varchar(80) default NULL,
  `topic_title` varchar(240) default NULL,
  `summary` varchar(240) default NULL,
  PRIMARY KEY  (`qId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_forums_queue`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_forums_reported`
--

CREATE TABLE IF NOT EXISTS `tiki_forums_reported` (
  `threadId` int(12) NOT NULL default '0',
  `forumId` int(12) NOT NULL default '0',
  `parentId` int(12) NOT NULL default '0',
  `user` varchar(40) default NULL,
  `timestamp` int(14) default NULL,
  `reason` varchar(250) default NULL,
  PRIMARY KEY  (`threadId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_forums_reported`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_friends`
--

CREATE TABLE IF NOT EXISTS `tiki_friends` (
  `user` char(40) NOT NULL default '',
  `friend` char(40) NOT NULL default '',
  PRIMARY KEY  (`user`,`friend`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_friends`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_friendship_requests`
--

CREATE TABLE IF NOT EXISTS `tiki_friendship_requests` (
  `userFrom` char(40) NOT NULL default '',
  `userTo` char(40) NOT NULL default '',
  `tstamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`userFrom`,`userTo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_friendship_requests`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_galleries`
--

CREATE TABLE IF NOT EXISTS `tiki_galleries` (
  `galleryId` int(14) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL default '',
  `description` text,
  `created` int(14) default NULL,
  `lastModif` int(14) default NULL,
  `visible` char(1) default NULL,
  `geographic` char(1) default NULL,
  `theme` varchar(60) default NULL,
  `user` varchar(40) default NULL,
  `hits` int(14) default NULL,
  `maxRows` int(10) default NULL,
  `rowImages` int(10) default NULL,
  `thumbSizeX` int(10) default NULL,
  `thumbSizeY` int(10) default NULL,
  `public` char(1) default NULL,
  `sortorder` varchar(20) NOT NULL default 'created',
  `sortdirection` varchar(4) NOT NULL default 'desc',
  `galleryimage` varchar(20) NOT NULL default 'first',
  `parentgallery` int(14) NOT NULL default '-1',
  `showname` char(1) NOT NULL default 'y',
  `showimageid` char(1) NOT NULL default 'n',
  `showdescription` char(1) NOT NULL default 'n',
  `showcreated` char(1) NOT NULL default 'n',
  `showuser` char(1) NOT NULL default 'n',
  `showhits` char(1) NOT NULL default 'y',
  `showxysize` char(1) NOT NULL default 'y',
  `showfilesize` char(1) NOT NULL default 'n',
  `showfilename` char(1) NOT NULL default 'n',
  `defaultscale` varchar(10) NOT NULL default 'o',
  PRIMARY KEY  (`galleryId`),
  KEY `name` (`name`),
  KEY `description` (`description`(255)),
  KEY `hits` (`hits`),
  FULLTEXT KEY `ft` (`name`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_galleries`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_galleries_scales`
--

CREATE TABLE IF NOT EXISTS `tiki_galleries_scales` (
  `galleryId` int(14) NOT NULL default '0',
  `scale` int(11) NOT NULL default '0',
  PRIMARY KEY  (`galleryId`,`scale`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_galleries_scales`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_games`
--

CREATE TABLE IF NOT EXISTS `tiki_games` (
  `gameName` varchar(200) NOT NULL default '',
  `hits` int(8) default NULL,
  `votes` int(8) default NULL,
  `points` int(8) default NULL,
  PRIMARY KEY  (`gameName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_games`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_group_inclusion`
--

CREATE TABLE IF NOT EXISTS `tiki_group_inclusion` (
  `groupName` varchar(255) NOT NULL default '',
  `includeGroup` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`groupName`(30),`includeGroup`(30))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_group_inclusion`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_history`
--

CREATE TABLE IF NOT EXISTS `tiki_history` (
  `pageName` varchar(160) NOT NULL default '',
  `version` int(8) NOT NULL default '0',
  `version_minor` int(8) NOT NULL default '0',
  `lastModif` int(14) default NULL,
  `description` varchar(200) default NULL,
  `user` varchar(40) default NULL,
  `ip` varchar(15) default NULL,
  `comment` varchar(200) default NULL,
  `data` longblob,
  PRIMARY KEY  (`pageName`,`version`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_history`
--

INSERT INTO `tiki_history` (`pageName`, `version`, `version_minor`, `lastModif`, `description`, `user`, `ip`, `comment`, `data`) VALUES
('HomePage', 1, 0, 1181907156, '', 'admin', '0.0.0.0', 'Tiki initialization', ''),
('HomePage', 2, 0, 1181924675, '', 'c8h10n4o2', '168.56.37.8', '', 0x28284c696e75782929),
('Linux', 1, 0, 1181924922, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a),
('Linux', 2, 0, 1181926432, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a),
('Linux', 3, 0, 1181927468, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a0d0a28284e6574776f726b696e672929),
('Searching', 1, 0, 1181929552, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a0d0a2d3d43484d4f44206f6620616c6c2066696c657320696e206120646972207265637572736976656c793d2d0d0a66696e64202e202d747970652066202d657865632063686d6f6420363434207b7d205c3b200d0a0d0a2d3d46696e6420616c6c2066696c657320636f6e7461696e696e67206120737472696e673d2d0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b202d657865632067726570202671756f743b68656c6c6f2671756f743b207b7d5c3b0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b207c2078617267732067726570202671756f743b68656c6c6f2671756f743b20322667743b2f6465762f6e756c6c0d0a0d0a2d3d53656172636820666f7220706172746963756c61722066696c6520696e2061206a61723d2d0d0a666f72206920696e206066696e64202e202d6e616d65202671756f743b2a2e6a61722671756f743b202d7072696e74603b20646f20756e7a6970202d6c20236920322667743b2f6465762f6e756c6c207c2067726570202671756f743b46696c654e616d652671756f743b202667743b202f6465762f6e756c6c20322667743b26616d703b313b206966205b243f203d3d2030205d3b207468656e206563686f2023693b2066693b20646f6e65),
('Searching', 2, 0, 1181929678, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a0d0a2d3d43484d4f44206f6620616c6c2066696c657320696e206120646972207265637572736976656c793d2d0d0a66696e64202e202d747970652066202d657865632063686d6f6420363434207b7d205c3b200d0a0d0a2d3d46696e6420616c6c2066696c657320636f6e7461696e696e67206120737472696e673d2d0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b202d657865632067726570202671756f743b68656c6c6f2671756f743b207b7d5c3b0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b207c2078617267732067726570202671756f743b68656c6c6f2671756f743b20322667743b2f6465762f6e756c6c0d0a0d0a2d3d53656172636820666f7220706172746963756c61722066696c6520696e2061206a61723d2d0d0a434f444528666f72206920696e206066696e64202e202d6e616d65202671756f743b2a2e6a61722671756f743b202d7072696e74603b20646f20756e7a6970202d6c20236920322667743b2f6465762f6e756c6c207c2067726570202671756f743b46696c654e616d652671756f743b202667743b202f6465762f6e756c6c20322667743b26616d703b313b206966205b5b243f203d3d2030205d3b207468656e206563686f2023693b2066693b20646f6e6529),
('Linux', 4, 0, 1181928843, '', 'c8h10n4o2', '168.56.37.8', '', 0x2828536561726368696e6729290d0a28284d61696e7461696e20557365727329290d0a28284e6574776f726b696e672929),
('Scripting', 1, 0, 1181929797, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d464f52204c4f4f503d2d0d0a3d3d3d4352454154452070617463682044495220494e20414c4c204c4f43414c20444952533d3d3d0d0a666f72206920696e20606c73603b20646f20606d6b6469722024692f7061746368603b20646f6e6520),
('Searching', 3, 0, 1181929717, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a0d0a2d3d43484d4f44206f6620616c6c2066696c657320696e206120646972207265637572736976656c793d2d0d0a66696e64202e202d747970652066202d657865632063686d6f6420363434207b7d205c3b200d0a0d0a2d3d46696e6420616c6c2066696c657320636f6e7461696e696e67206120737472696e673d2d0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b202d657865632067726570202671756f743b68656c6c6f2671756f743b207b7d5c3b0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b207c2078617267732067726570202671756f743b68656c6c6f2671756f743b20322667743b2f6465762f6e756c6c0d0a0d0a2d3d53656172636820666f7220706172746963756c61722066696c6520696e2061206a61723d2d0d0a434f444528666f72206920696e206066696e64202e202d6e616d65202671756f743b2a2e6a61722671756f743b202d7072696e74603b20646f20756e7a6970202d6c20236920322667743b2f6465762f6e756c6c207c2067726570202671756f743b46696c654e616d652671756f743b202667743b202f6465762f6e756c6c20322667743b26616d703b313b206966205b5b20243f203d3d2030205d3b207468656e206563686f2023693b2066693b20646f6e6529),
('Searching', 4, 0, 1181930005, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a0d0a2d3d46696e6420616c6c2066696c657320636f6e7461696e696e67206120737472696e673d2d0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b202d657865632067726570202671756f743b68656c6c6f2671756f743b207b7d5c3b0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b207c2078617267732067726570202671756f743b68656c6c6f2671756f743b20322667743b2f6465762f6e756c6c0d0a0d0a0d0a2d3d537472696e67205265706c6163653d2d0d0a3d3d3d536561726368204d756c7469706c652046696c65733d3d3d0d0a66696e64202f657463202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b202d65786563207065726c202d7069202d65202671756f743b732f454e562f4147494e4730322f672671756f743b207b7d5c3b0d0a0d0a3d3d3d53696e676c652046696c653d3d3d0d0a7065726c202d7069202d65202671756f743b732f454e562f4147494e4730322f672671756f743b2070657273697374656e63652e70726f706572746965730d0a0d0a3d3d3d57696e646f7773204e6577204c696e6520436861723d3d3d0d0a66696e64202e202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b202d65786563207065726c202d7069202d65202671756f743b732f5c3031355c3031322f5c3031322f672671756f743b207b7d205c3b0d0a2d3d43484d4f44206f6620616c6c2066696c657320696e206120646972207265637572736976656c793d2d0d0a66696e64202e202d747970652066202d657865632063686d6f6420363434207b7d205c3b200d0a0d0a2d3d53656172636820666f7220706172746963756c61722066696c6520696e2061206a61723d2d0d0a434f444528666f72206920696e206066696e64202e202d6e616d65202671756f743b2a2e6a61722671756f743b202d7072696e74603b20646f20756e7a6970202d6c20236920322667743b2f6465762f6e756c6c207c2067726570202671756f743b46696c654e616d652671756f743b202667743b202f6465762f6e756c6c20322667743b26616d703b313b206966205b5b20243f203d3d2030205d3b207468656e206563686f2023693b2066693b20646f6e6529),
('Linux', 5, 0, 1181929731, '', 'c8h10n4o2', '168.56.37.8', '', 0x2828536561726368696e6729290d0a28284d61696e7461696e20557365727329290d0a28284e6574776f726b696e6729290d0a2828536372697074696e672929),
('Linux', 6, 0, 1181930165, '', 'c8h10n4o2', '168.56.37.8', '', 0x2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e672929),
('File System', 1, 0, 1181931016, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d46696c6520436f756e743d2d0d0a3d3d3d53697a65206f6620616c6c204449525320696e2063757272656e74204449523d3d3d0d0a6475202d73686b202a0d0a0d0a3d3d3d53697a65206f662063757272656e74204449523d3d3d0d0a6475202d73686b202e0d0a0d0a2d3d4e756d2046696c657320696e204449523d2d0d0a0d0a2d3d4c69737420616c6c20686172642064726976657320616e6420737061636520696e666f3d2d0d0a6466202d6c6b),
('Networking', 1, 0, 1181928565, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d476574204e756d626572206f66204f70656e20436f6e6e656374696f6e7320746f20506f72743d2d0d0a6e657473746174202d616e207c2061776b20272431207e202f5c2e266c743b504f5254204e554d2667743b242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a5f5f45583a5f5f206e657473746174202d616e207c2061776b20272431207e202f5c2e31363636242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a2d3d2053657420757020535348204b6579203d2d0d0a23204f6e20736f75726365206d616368696e652c206364207e2f2e737368200d0a232063617420636f6e74656e7473206f662069645f6473612e707562204f522069645f7273612e707562200d0a2320436f707920636f6e74656e747320616e6420706173746520696e206e6f746570616420284e4f54453a205448495320495320412053494e474c45204c494e452c204e4f54204d554c5449504c4529200d0a232073736820746f2044657374696e6174696f6e20626f782066726f6d2074686520536f7572636520426f78200d0a2320456e74657220796f75722070617373776f726420616e64206c6f67696e2e2028496620796f752063616e6e6f74206c6f6720696e2c207468656e204e47206e6565647320746f206164642074686174207573657220746f20746865206c697374206f6620757365727320666f72207468617420626f782e29200d0a232056657269667920796f752061726520696e20686f6d6520646972203d2667743b20707764200d0a2320435245415445202e73736820646972203d2667743b206d6b646972202e737368200d0a2320536574202e737368207065726d697373696f6e7320746f20373030203d2667743b2063686d6f6420373030202e737368200d0a23206364202e737368200d0a2320766920617574686f72697a65645f6b657973200d0a2320706173746520796f7572206b657920616e64206d616b65207375726520697420697320612073696e676c65206c696e652e200d0a232076657269667920796f757220636f6e6e656374696f6e7320776f726b73206279207373682062617463687461614069657461647530303120616e6420796f752073686f756c64206e6f74206765742061206c6f67696e2e0d0a2a20496620796f75206172652070726f6d7074656420666f722061206c6f67696e2c20796f752064696420736f6d657468696e672077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f722070617373776f72642c20796f752064696420736f6d65746869676e2077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f7220706173737068726173652c2077686f6576657220637265617465642074686174207075626c6963202f2070726976617465206b657920706169722077652075736564206372656174656420612070617373706872617365207769746820697420616c736f2e0d0a0d0a),
('Linux', 7, 0, 1181930190, '', 'c8h10n4o2', '168.56.37.8', '', 0x282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e672929),
('Linux', 8, 0, 1181931305, '', 'c8h10n4o2', '168.56.37.8', '', 0x282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f6365737365732929),
('Maintain Users', 1, 0, 1181930135, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d557365722026616d703b2047726f7570204c6f6f6b75703d2d0d0a0d0a797063617420706173737764207c206772657020266c743b75736572206e616d652667743b0d0a0d0a79706361742067726f7570207c206772657020266c743b67726f757020232667743b),
('HomePage', 3, 0, 1181924718, '', 'c8h10n4o2', '168.56.37.8', '', 0x28284c696e757829290d0a282853756276657273696f6e29290d0a28285045524c29290d0a282850485029290d0a),
('Subversion', 1, 0, 1181935287, '', 'c8h10n4o2', '168.56.37.8', '', 0x496e74726f64756374696f6e0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b7570),
('Subversion', 2, 0, 1181936154, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d42617369632053564e20436f6d6d616e64733d2d0d0a534f555243453a20687474703a2f2f7777772e6c696e757866726f6d736372617463682e6f72672f626c66732f656467756964652f6368617074657230332e68746d6c0d0a5f5f5f496e74726f64756374696f6e5f5f5f0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b7570),
('Subversion', 3, 0, 1181936328, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d42617369632053564e20436f6d6d616e64733d2d0d0a534f555243453a20687474703a2f2f7777772e6c696e757866726f6d736372617463682e6f72672f626c66732f656467756964652f6368617074657230332e68746d6c0d0a5f5f496e74726f64756374696f6e5f5f0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b7570);
INSERT INTO `tiki_history` (`pageName`, `version`, `version_minor`, `lastModif`, `description`, `user`, `ip`, `comment`, `data`) VALUES
('Subversion', 4, 0, 1181936402, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d42617369632053564e20436f6d6d616e64733d2d0d0a534f555243453a20687474703a2f2f7777772e6c696e757866726f6d736372617463682e6f72672f626c66732f656467756964652f6368617074657230332e68746d6c0d0a0d0a5f5f496e74726f64756374696f6e5f5f0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b7570),
('System', 1, 0, 1181932010, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d54696d652053797374656d20486173206265656e2055703d2d0d0a757074696d650d0a0d0a2d3d4e756d626572206f662043505527733d2d0d0a707372696e666f),
('Subversion', 5, 0, 1181936430, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d42617369632053564e20436f6d6d616e64733d2d0d0a534f555243453a20687474703a2f2f7777772e6c696e757866726f6d736372617463682e6f72672f626c66732f656467756964652f6368617074657230332e68746d6c0d0a0d0a5f5f496e74726f64756374696f6e5f5f0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a2d3d4261636b75703d2d0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b7570),
('HomePage', 4, 0, 1181932165, '', 'c8h10n4o2', '168.56.37.8', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a28285045524c29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a),
('PHP', 1, 0, 1182482350, '', 'c8h10n4o2', '66.68.76.76', '', 0x2d3d537472696e672047656e65726174653d2d0d0a266c743b3f7068700d0a2f2a0d0a2a20546869732069732074686520646f6d61696e636865636b2078206c656e2067656e65726174696f6e207772697474656e20696e205048500d0a2a2f0d0a24414c5048414245543d6172726179282741272c2742272c2743272c2744272c2745272c2746272c2747272c2748272c2749272c274a272c274b272c274c272c274d272c274e272c274f272c2750272c2751272c2752272c2753272c2754272c2755272c2756272c2757272c2758272c2759272c275a27293b0d0a247374726c656e203d20333b0d0a24776f72645f61727261793d24414c5048414245543b0d0a666f722824693d313b202469266c743b247374726c656e3b24692b2b290d0a7b0d0a202020666f72656163682824776f72645f6172726179206173202469643d2667743b2476616c290d0a2020207b0d0a202020202020666f72656163682824414c504841424554206173202469643d2667743b246c6574746572290d0a2020202020207b0d0a20202020202020202061727261795f707573682824776f72645f61727261792c202476616c202e20246c6574746572293b0d0a2020202020207d0d0a2020207d0d0a7d0d0a0d0a666f72656163682824776f72645f6172726179206173202469643d2667743b2476616c290d0a7b0d0a2020206563686f282476616c202e202671756f743b266c743b62722667743b2671756f743b293b0d0a7d0d0a3f2667743b),
('PHP', 2, 0, 1182482677, '', 'c8h10n4o2', '66.68.76.76', '', 0x2d3d537472696e672047656e65726174653d2d0d0a434f444528266c743b3f7068700d0a2f2a0d0a2a20546869732069732074686520646f6d61696e636865636b2078206c656e2067656e65726174696f6e207772697474656e20696e205048500d0a2a2f0d0a24414c5048414245543d6172726179282741272c2742272c2743272c2744272c2745272c2746272c2747272c2748272c2749272c274a272c274b272c274c272c274d272c274e272c274f272c2750272c2751272c2752272c2753272c2754272c2755272c2756272c2757272c2758272c2759272c275a27293b0d0a247374726c656e203d20333b0d0a24776f72645f61727261793d24414c5048414245543b0d0a666f722824693d313b202469266c743b247374726c656e3b24692b2b290d0a7b0d0a202020666f72656163682824776f72645f6172726179206173202469643d2667743b2476616c290d0a2020207b0d0a202020202020666f72656163682824414c504841424554206173202469643d2667743b246c6574746572290d0a2020202020207b0d0a20202020202020202061727261795f707573682824776f72645f61727261792c202476616c202e20246c6574746572293b0d0a2020202020207d0d0a2020207d0d0a7d0d0a0d0a666f72656163682824776f72645f6172726179206173202469643d2667743b2476616c290d0a7b0d0a2020206563686f282476616c202e202671756f743b266c743b62722667743b2671756f743b293b0d0a7d0d0a3f2667743b29),
('HomePage', 5, 0, 1182481604, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a28285045524c29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 6, 0, 1182482906, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 7, 0, 1182482915, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a28285045524c29290d0a0d0a282857656253706865726529290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 8, 0, 1182482928, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 9, 0, 1182482940, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c29290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 10, 0, 1182482971, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a2828534352495054494e4729290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 11, 0, 1182482987, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a2828536372697074696e6729290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 12, 0, 1182483015, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c2053637269707429290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 13, 0, 1182483035, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285363726970747329290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 14, 0, 1182483052, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c5363726970747329290d0a0d0a282841646f6265205072656d6965722929),
('HomePage', 15, 0, 1182483064, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c29290d0a0d0a282841646f6265205072656d6965722929),
('PERL_Code', 1, 0, 1182483161, '', 'c8h10n4o2', '66.68.76.76', '', 0x2d3d47656e657261746520416c6c204348415220436f6d62696e6174696f6e73206f662050726f7669646564204c656e6774683d2d0d0a404348415253203d20282671756f743b412671756f743b2c202671756f743b422671756f743b2c202671756f743b432671756f743b2c202671756f743b442671756f743b2c202671756f743b452671756f743b2c202671756f743b462671756f743b2c202671756f743b472671756f743b2c202671756f743b482671756f743b2c202671756f743b492671756f743b2c202671756f743b4a2671756f743b2c202671756f743b4b2671756f743b2c202671756f743b4c2671756f743b2c202671756f743b4d2671756f743b2c202671756f743b4e2671756f743b2c202671756f743b4f2671756f743b2c202671756f743b502671756f743b2c202671756f743b512671756f743b2c202671756f743b522671756f743b2c202671756f743b532671756f743b2c202671756f743b542671756f743b2c202671756f743b552671756f743b2c202671756f743b562671756f743b2c202671756f743b572671756f743b2c202671756f743b582671756f743b2c202671756f743b592671756f743b2c202671756f743b5a2671756f743b2c20302c20312c20322c20332c20342c20352c20362c20372c20382c2039293b0d0a247374726c656e203d20333b0d0a40646f6d61696e73203d2028293b0d0a0d0a0d0a666f722824636f756e746572203d20303b2024636f756e74657220266c743b20247374726c656e3b2024636f756e7465722b2b290d0a7b0d0a202020696628676574417272617953697a652840646f6d61696e7329203d3d2030290d0a2020207b0d0a202020202020666f72656163682024636861722028404348415253290d0a2020202020207b0d0a202020202020202020246e65775f646f6d61696e203d2024636861723b0d0a202020202020202020707573682840646f6d61696e732c20246e65775f646f6d61696e293b0d0a2020202020202020207072696e7428246e65775f646f6d61696e202e202671756f743b5c6e2671756f743b293b0d0a2020202020207d0d0a2020207d0d0a202020656c73650d0a2020207b0d0a202020202020406f7269675f6c697374203d2040646f6d61696e733b0d0a202020202020666f72656163682024646f6d61696e2028406f7269675f6c697374290d0a2020202020207b0d0a202020202020202020666f72656163682024636861722028404348415253290d0a2020202020202020207b0d0a202020202020202020202020246e65775f646f6d61696e203d2024646f6d61696e202e2024636861723b0d0a202020202020202020202020707573682840646f6d61696e732c20246e65775f646f6d61696e293b0d0a2020202020202020202020207072696e7428246e65775f646f6d61696e202e202671756f743b5c6e2671756f743b293b0d0a2020202020202020207d0d0a2020202020207d0d0a2020207d0d0a7d0d0a0d0a73756220676574417272617953697a650d0a7b0d0a2020206d792040696e744172726179203d20405f3b0d0a202020246c617374496e646578203d202423696e7441727261793b202320696e646578206f6620746865206c61737420656c656d656e742c20246c617374496e646578203d3d20320d0a202020246c656e677468203d20246c617374496e646578202b20313b20232073697a65206f66207468652061727261790d0a20202072657475726e28246c656e677468293b0d0a7d),
('HomePage', 16, 0, 1182483084, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c5f436f646529290d0a0d0a282841646f6265205072656d6965722929),
('Linux', 9, 0, 1181931956, '', 'c8h10n4o2', '168.56.37.8', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f6365737365732929),
('Samba', 1, 0, 1183725010, '', 'c8h10n4o2', '72.255.68.35', '', 0x2d3d4c69737420536861726573206f6620426f783d2d0d0a7375646f20736d62636c69656e74202d5520266c743b757365726e616d652667743b202d4c20266c743b626f786e616d652667743b0d0a0d0a2d3d4d6f756e742053686172653d2d0d0a7375646f206d6b646972202f6d6e742f746d700d0a7375646f206d6f756e74202d7420736d626673202d6f20757365726e616d653d496e7374727563746f72312c70617373776f72643d50617373776f726431202f2f3139322e3136382e312e3131312f466163756c74795f4d6174657269616c73202f6d6e742f746d700d0a0d0a),
('Samba', 2, 0, 1183725037, '', 'c8h10n4o2', '72.255.68.35', '', 0x2d3d4c69737420536861726573206f6620426f783d2d0d0a7375646f20736d62636c69656e74202d5520266c743b757365726e616d652667743b202d4c20266c743b626f786e616d652667743b0d0a0d0a2d3d4d6f756e742053686172653d2d0d0a7375646f206d6b646972202f6d6e742f746d700d0a7375646f206d6f756e74202d7420736d626673202d6f20757365726e616d653d266c743b757365726e616d652667743b2c70617373776f72643d266c743b70617373776f72642667743b202f2f3139322e3136382e312e3131312f466163756c74795f4d6174657269616c73202f6d6e742f746d700d0a0d0a),
('PERL_Code', 2, 0, 1182483179, '', 'c8h10n4o2', '66.68.76.76', '', 0x2d3d47656e657261746520416c6c204348415220436f6d62696e6174696f6e73206f662050726f7669646564204c656e6774683d2d0d0a7b434f444528297d0d0a404348415253203d20282671756f743b412671756f743b2c202671756f743b422671756f743b2c202671756f743b432671756f743b2c202671756f743b442671756f743b2c202671756f743b452671756f743b2c202671756f743b462671756f743b2c202671756f743b472671756f743b2c202671756f743b482671756f743b2c202671756f743b492671756f743b2c202671756f743b4a2671756f743b2c202671756f743b4b2671756f743b2c202671756f743b4c2671756f743b2c202671756f743b4d2671756f743b2c202671756f743b4e2671756f743b2c202671756f743b4f2671756f743b2c202671756f743b502671756f743b2c202671756f743b512671756f743b2c202671756f743b522671756f743b2c202671756f743b532671756f743b2c202671756f743b542671756f743b2c202671756f743b552671756f743b2c202671756f743b562671756f743b2c202671756f743b572671756f743b2c202671756f743b582671756f743b2c202671756f743b592671756f743b2c202671756f743b5a2671756f743b2c20302c20312c20322c20332c20342c20352c20362c20372c20382c2039293b0d0a247374726c656e203d20333b0d0a40646f6d61696e73203d2028293b0d0a0d0a0d0a666f722824636f756e746572203d20303b2024636f756e74657220266c743b20247374726c656e3b2024636f756e7465722b2b290d0a7b0d0a202020696628676574417272617953697a652840646f6d61696e7329203d3d2030290d0a2020207b0d0a202020202020666f72656163682024636861722028404348415253290d0a2020202020207b0d0a202020202020202020246e65775f646f6d61696e203d2024636861723b0d0a202020202020202020707573682840646f6d61696e732c20246e65775f646f6d61696e293b0d0a2020202020202020207072696e7428246e65775f646f6d61696e202e202671756f743b5c6e2671756f743b293b0d0a2020202020207d0d0a2020207d0d0a202020656c73650d0a2020207b0d0a202020202020406f7269675f6c697374203d2040646f6d61696e733b0d0a202020202020666f72656163682024646f6d61696e2028406f7269675f6c697374290d0a2020202020207b0d0a202020202020202020666f72656163682024636861722028404348415253290d0a2020202020202020207b0d0a202020202020202020202020246e65775f646f6d61696e203d2024646f6d61696e202e2024636861723b0d0a202020202020202020202020707573682840646f6d61696e732c20246e65775f646f6d61696e293b0d0a2020202020202020202020207072696e7428246e65775f646f6d61696e202e202671756f743b5c6e2671756f743b293b0d0a2020202020202020207d0d0a2020202020207d0d0a2020207d0d0a7d0d0a0d0a73756220676574417272617953697a650d0a7b0d0a2020206d792040696e744172726179203d20405f3b0d0a202020246c617374496e646578203d202423696e7441727261793b202320696e646578206f6620746865206c61737420656c656d656e742c20246c617374496e646578203d3d20320d0a202020246c656e677468203d20246c617374496e646578202b20313b20232073697a65206f66207468652061727261790d0a20202072657475726e28246c656e677468293b0d0a7d0d0a7b434f44457d),
('PERL_Code', 3, 0, 1184281632, '', 'c8h10n4o2', '72.255.19.226', '', 0x2d3d47656e657261746520416c6c204348415220436f6d62696e6174696f6e73206f662050726f7669646564204c656e6774683d2d0d0a7b434f444528297d0d0a69662821646566696e65642840415247565b305d29290d0a7b0d0a097072696e746c6e282671756f743b55534147453a2064632e706c20266c743b4c454e4754482667743b2671756f743b293b0d0a096578697428293b0d0a7d0d0a0d0a0d0a232053706563696679205065726c206d6f64756c657320746f20696e636c75646520686572650d0a7573652054696d653a3a6c6f63616c74696d653b0d0a23757365204765746f70743a3a4c6f6e673b0d0a23757365204e45543a3a534d54503b0d0a23757365204e45543a3a686f7374656e743b0d0a0d0a404348415253203d20282671756f743b412671756f743b2c202671756f743b422671756f743b2c202671756f743b432671756f743b2c202671756f743b442671756f743b2c202671756f743b452671756f743b2c202671756f743b462671756f743b2c202671756f743b472671756f743b2c202671756f743b482671756f743b2c202671756f743b492671756f743b2c202671756f743b4a2671756f743b2c202671756f743b4b2671756f743b2c202671756f743b4c2671756f743b2c202671756f743b4d2671756f743b2c202671756f743b4e2671756f743b2c202671756f743b4f2671756f743b2c202671756f743b502671756f743b2c202671756f743b512671756f743b2c202671756f743b522671756f743b2c202671756f743b532671756f743b2c202671756f743b542671756f743b2c202671756f743b552671756f743b2c202671756f743b562671756f743b2c202671756f743b572671756f743b2c202671756f743b582671756f743b2c202671756f743b592671756f743b2c202671756f743b5a2671756f743b293b232c20302c20312c20322c20332c20342c20352c20362c20372c20382c2039293b0d0a247374726c656e203d2040415247565b305d3b0d0a40646f6d61696e73203d2028293b0d0a2824594541522c20244d4f4e54482c202444415929203d2067657443757272656e744461746528293b0d0a282448522c20244d494e2c202453454329203d2067657443757272656e7454696d6528293b0d0a24444154455f535452494e47203d202459454152202e202671756f743b2d2671756f743b202e20244d4f4e5448202e202671756f743b2d2671756f743b202e2024444159202e202671756f743b5f2671756f743b202e20244852202e202671756f743b2d2671756f743b202e20244d494e202e202671756f743b2d2671756f743b202e20245345433b0d0a2444435f444952203d202671756f743b2f686f6d652f63386831306e346f322f64632f2671756f743b3b0d0a2457484f49535f444952203d202444435f444952202e202671756f743b77686f69735f726573756c74732f2671756f743b3b0d0a244e4f5f4d415443485f46494c45203d202444435f444952202e2024444154455f535452494e47202e202671756f743b5f6e6f5f6d617463682e726573756c74732671756f743b3b0d0a24455850495245535f4f4e5f46494c45203d202444435f444952202e2024444154455f535452494e47202e202671756f743b5f657870697265735f6f6e2e726573756c74732671756f743b3b0d0a24434845434b5f57484f49535f46494c45203d202444435f444952202e2024444154455f535452494e47202e202671756f743b5f636865636b5f77686f69732e726573756c74732671756f743b3b0d0a666f722824636f756e746572203d20313b2024636f756e74657220266c743b3d20247374726c656e3b2024636f756e7465722b2b290d0a7b0d0a202020696628676574417272617953697a652840646f6d61696e7329203d3d2030290d0a2020207b0d0a202020202020666f72656163682024636861722028404348415253290d0a2020202020207b0d0a202020202020202020246e65775f646f6d61696e203d2024636861723b0d0a202020202020202020707573682840646f6d61696e732c20246e65775f646f6d61696e293b0d0a202020202020202020237072696e7428246e65775f646f6d61696e202e202671756f743b5c6e2671756f743b293b0d0a2020202020207d0d0a2020207d0d0a202020656c73650d0a2020207b0d0a202020202020406f7269675f6c697374203d2040646f6d61696e733b0d0a202020202020666f72656163682024646f6d61696e2028406f7269675f6c697374290d0a2020202020207b0d0a202020202020202020666f72656163682024636861722028404348415253290d0a2020202020202020207b0d0a202020202020202020202020246e65775f646f6d61696e203d2024646f6d61696e202e2024636861723b0d0a202020202020202020202020707573682840646f6d61696e732c20246e65775f646f6d61696e293b0d0a090909096966286c656e67746828246e65775f646f6d61696e29203d3d20247374726c656e290d0a090909097b0d0a090909090924746f5f636865636b203d20246e65775f646f6d61696e202e202671756f743b2e434f4d2671756f743b3b0d0a09090909096966286469675f646e732824746f5f636865636b29203d3d2030290d0a09090909097b0d0a0909090909096765745f77686f69735f66696c652824646f6d61696e293b0d0a090909090909636865636b5f77686f69735f66696c652824646f6d61696e293b0d0a09090909097d0d0a090909097d0d0a2020202020202020207d0d0a2020202020207d0d0a2020207d0d0a7d0d0a0d0a0d0a73756220676574417272617953697a650d0a7b0d0a2020206d792040696e744172726179203d20405f3b0d0a202020246c617374496e646578203d202423696e7441727261793b202320696e646578206f6620746865206c61737420656c656d656e742c20246c617374496e646578203d3d20320d0a202020246c656e677468203d20246c617374496e646578202b20313b20232073697a65206f66207468652061727261790d0a20202072657475726e28246c656e677468293b0d0a7d0d0a0d0a0d0a73756220636865636b5f77686f69735f66696c650d0a7b0d0a096d792024646f6d61696e203d202824746f5f636865636b293b0d0a092466696c656e616d65203d202457484f49535f444952202e202671756f743b77686f69732e2671756f743b202e2024646f6d61696e202e202671756f743b2e726573756c74732671756f743b3b0d0a097072696e746c6e282671756f743b66696c656e616d65203d202671756f743b202e202466696c656e616d65293b0d0a096d792824726573756c745f666f756e6429203d20303b0d0a096f70656e2057484f495346494c452c202671756f743b2466696c656e616d652671756f743b3b0d0a0923204c6f6f6b207468726f756768206578697374696e672077686f69732066696c6520666f722064657461696c730d0a09246e6f5f6d61746368203d202671756f743b4e6f206d6174636820666f722671756f743b3b0d0a092465787069726174696f6e5f64617465203d202671756f743b45787069726174696f6e20446174653a2671756f743b3b0d0a097768696c65202820266c743b57484f495346494c452667743b20290d0a097b0d0a09096d7928246c696e6529203d20245f3b0d0a0909237072696e746c6e28246c696e65293b0d0a09096966286d7928247375626c696e6529203d206d2f28246e6f5f6d61746368292f6f290d0a09097b0d0a09090923205052494e5420444f4d41494e20544f20412046494c450d0a0909096f70656e204e4f4d4154434846494c452c202671756f743b2667743b2667743b244e4f5f4d415443485f46494c452671756f743b3b0d0a0909097072696e74204e4f4d4154434846494c452024646f6d61696e3b0d0a090909636c6f7365204e4f4d4154434846494c453b0d0a0909097072696e746c6e282671756f743b4e6f206d6174636820666f722024646f6d61696e2671756f743b293b0d0a09090924726573756c745f666f756e642b2b3b0d0a09097d0d0a0909656c736966286d7928247375626c696e6529203d206d2f282465787069726174696f6e5f64617465292f6f290d0a09097b0d0a0909096f70656e20455850495245534f4e46494c452c202671756f743b2667743b2667743b24455850495245535f4f4e5f46494c452671756f743b3b0d0a0909097072696e7420455850495245534f4e46494c452024646f6d61696e202e202671756f743b203d2667743b202671756f743b202e20246c696e653b0d0a090909636c6f736520455850495245534f4e46494c453b0d0a0909097072696e746c6e2824646f6d61696e202e202671756f743b203d2667743b202671756f743b202e20246c696e65293b0d0a09090924726573756c745f666f756e642b2b3b0d0a09097d0d0a097d0d0a09636c6f73652057484f495346494c453b0d0a0969662824726573756c745f666f756e64203d3d2030290d0a097b0d0a090923414c534f205052494e5420444f4d41494e20544f20412046494c450d0a09096f70656e20434845434b57484f495346494c452c202671756f743b2667743b2667743b24434845434b5f57484f49535f46494c452671756f743b3b0d0a09097072696e7420434845434b57484f495346494c452024646f6d61696e202e202671756f743b20436865636b2057484f49532671756f743b3b0d0a0909636c6f736520434845434b57484f495346494c453b0909090d0a09097072696e746c6e2824646f6d61696e202e202671756f743b20434845434b2057484f49532046494c452671756f743b293b0d0a097d0d0a7d0d0a737562206765745f77686f69735f66696c650d0a7b0d0a096d792024646f6d61696e203d202824746f5f636865636b293b0d0a092466696c656e616d65203d202457484f49535f444952202e202671756f743b77686f69732e2671756f743b202e2024646f6d61696e202e202671756f743b2e726573756c74732671756f743b3b0d0a097072696e746c6e282671756f743b636865636b696e67202466696c656e616d652671756f743b293b0d0a0969662821282d65202466696c656e616d6529290d0a097b0d0a09097072696e746c6e282671756f743b2466696c656e616d6520646f6573206e6f742065786973742e2e2e2e206372656174696e672069742671756f743b293b0d0a09096f70656e2057484f495346494c452c202671756f743b2667743b2466696c656e616d652671756f743b3b0d0a09092477686f6973726573756c74733d602f7573722f62696e2f77686f69732024646f6d61696e603b0d0a09097072696e746c6e282671756f743b726573756c7473203a205c6e2671756f743b202e202477686f6973726573756c7473293b0d0a09097072696e742057484f495346494c45202477686f6973726573756c7473202e202671756f743b5c6e2671756f743b3b0d0a097d0d0a7d0d0a737562206469675f646e730d0a7b0d0a096d792024646f6d61696e203d202824746f5f636865636b293b0d0a096d792040646f6d61696e203d20405f3b0d0a097072696e746c6e282671756f743b636865636b696e672024646f6d61696e2671756f743b293b0d0a0924646967726573756c74733d602f7573722f62696e2f6469672024646f6d61696e207c20677265702027414e535745522053454354494f4e27603b0d0a096966286c656e6774682024646967726573756c7473202667743b2030290d0a097b0d0a090972657475726e2831293b0d0a097d0d0a09656c73650d0a097b0d0a090972657475726e2830293b0d0a097d0d0a7d0d0a737562207072696e746c6e0d0a7b0d0a096d792040746f7072696e74203d20405f3b0d0a097072696e74282671756f743b40746f7072696e745c6e2671756f743b293b0d0a7d0d0a0d0a23204765742063757272656e7420646174652e202050726f636565642073696e676c6520646967697420646174657320776974682061203020666f7220726561646162696c6974792e0d0a7375622067657443757272656e7444617465207b0d0a20202020202020206d7920247965617220203d206c6f63616c74696d652d2667743b796561722829202b20313930303b0d0a20202020202020206d7920246d6f6e7468203d2028286c6f63616c74696d652d2667743b6d6f6e2829202b20312920266c743b20313029203f20282671756f743b302671756f743b202e20286c6f63616c74696d652d2667743b6d6f6e2829202b20312929203a20286c6f63616c74696d652d2667743b6d6f6e2829202b2031293b0d0a20202020202020206d7920246461792020203d20286c6f63616c74696d652d2667743b6d646179282920266c743b20313029203f20282671756f743b302671756f743b202e206c6f63616c74696d652d2667743b6d646179282929203a206c6f63616c74696d652d2667743b6d64617928293b0d0a202020202020202072657475726e202824796561722c20246d6f6e74682c2024646179293b0d0a7d0d0a0d0a23204765742063757272656e742074696d652e2020507265636565642073696e676c652064696769742074696d657320776974682061203020666f7220726561646162696c6974792e0d0a7375622067657443757272656e7454696d65207b0d0a20202020202020206d792024686f75722020203d20286c6f63616c74696d652d2667743b686f7572282920266c743b20313029203f20282671756f743b302671756f743b202e206c6f63616c74696d652d2667743b686f7572282929203a206c6f63616c74696d652d2667743b686f757228293b0d0a20202020202020206d7920246d696e757465203d20286c6f63616c74696d652d2667743b6d696e282920266c743b20313029203f20282671756f743b302671756f743b202e206c6f63616c74696d652d2667743b6d696e282929203a206c6f63616c74696d652d2667743b6d696e28293b0d0a20202020202020206d7920247365636f6e64203d20286c6f63616c74696d652d2667743b736563282920266c743b20313029203f20282671756f743b302671756f743b202e206c6f63616c74696d652d2667743b736563282929203a206c6f63616c74696d652d2667743b73656328293b0d0a202020202020202072657475726e202824686f75722c20246d696e7574652c20247365636f6e64293b0d0a7d0d0a0d0a7b434f44457d),
('Linux', 10, 0, 1183724886, '', 'c8h10n4o2', '72.255.68.35', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f63657373657329290d0a0d0a282853616d62612929),
('Linux', 11, 0, 1185066744, '', 'c8h10n4o2', '72.255.41.15', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f63657373657329290d0a0d0a282853616d626129290d0a0d0a28285472656f203635302073657475702077697468205562756e74752929),
('System', 2, 0, 1182181594, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d54696d652053797374656d20486173206265656e2055703d2d0d0a757074696d650d0a0d0a2d3d4e756d626572206f662043505527733d2d0d0a707372696e666f0d0a0d0a2d3d4b65726e656c2056657273696f6e3d2d0d0a756e616d65202d72),
('System', 3, 0, 1185223355, '', 'c8h10n4o2', '72.255.3.164', '', 0x2d3d54696d652053797374656d20486173206265656e2055703d2d0d0a757074696d650d0a0d0a2d3d4e756d626572206f662043505527733d2d0d0a707372696e666f0d0a0d0a2d3d4b65726e656c2056657273696f6e3d2d0d0a756e616d65202d720d0a0d0a2d3d43726561746520612053796d626f6c6963204c696e6b3d2d0d0a6c6e202d73205b544152474554204449524543544f5259204f522046494c455d202e2f5b53484f52544355545d0d0a0d0a466f72206578616d706c653a0d0a0d0a6c6e202d73202f7573722f6c6f63616c2f6170616368652f6c6f6773202e2f6c6f6773);
INSERT INTO `tiki_history` (`pageName`, `version`, `version_minor`, `lastModif`, `description`, `user`, `ip`, `comment`, `data`) VALUES
('Subversion', 6, 0, 1182460789, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d42617369632053564e20436f6d6d616e64733d2d0d0a534f555243453a20687474703a2f2f7777772e6c696e757866726f6d736372617463682e6f72672f626c66732f656467756964652f6368617074657230332e68746d6c0d0a0d0a5f5f496e74726f64756374696f6e5f5f0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a2d3d4261636b75703d2d0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b75700d0a0d0a2d3d437265617465204e65772053747265616d2026616d703b20496d706f727420436f64653d2d0d0a235f5f4372656174652073766e2070726f6a6563742063616c6c6564206361626c656372617a795f5f0d0a2b7375646f2073766e61646d696e20637265617465202f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a235f5f4d616b652064697220736f207765627365727665722063616e20636865636b206f75742026616d703b20696e5f5f0d0a2b7375646f2063686f776e202d52207777772d646174612073766e0d0a2b7375646f2063686d6f64202d5220672b7277732073766e0d0a235f5f416464207468652064697220746f206170616368655f5f0d0a2b7375646f207669202f6574632f617061636865322f617061636865322e636f6e660d0a2b266c743b4c6f636174696f6e202f73766e2f6361626c656372617a792667743b0d0a2b4441562073766e0d0a2b53564e50617468202f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a2b41757468547970652042617369630d0a2b417574684e616d65202671756f743b73756276657273696f6e207265706f7369746f72792671756f743b0d0a2b417574685573657246696c65202f6574632f73756276657273696f6e2f7061737377640d0a2b526571756972652076616c69642d757365720d0a2b266c743b2f4c6f636174696f6e2667743b0d0a235f5f426f756e6365206170616368655f5f0d0a2b7375646f202f6574632f696e69742e642f6170616368653220726573746172740d0a235f5f496e697469616c206461746120696d706f72745f5f0d0a2b7375646f2073766e20696d706f7274202d6d202671756f743b496e697469616c20496d706f72742671756f743b202f7661722f7777772f6361626c655f6372617a790d0a2b66696c653a2f2f2f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a235f5f557064617465206c6f63616c20766965775f5f0d0a2b63386831306e346f3240677265656e626f783a2f7661722f777777242073766e20636865636b6f7574207e6e707e687474703a2f2f677265656e626f782f73766e2f6361626c656372617a797e6e707e),
('Subversion', 7, 0, 1186712739, '', 'c8h10n4o2', '66.68.76.76', '', 0x2d3d42617369632053564e20436f6d6d616e64733d2d0d0a534f555243453a20687474703a2f2f7777772e6c696e757866726f6d736372617463682e6f72672f626c66732f656467756964652f6368617074657230332e68746d6c0d0a0d0a5f5f496e74726f64756374696f6e5f5f0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a45582066726f6d204c696e757820746f204c696e75783a2073766e20636865636b6f75742073766e2b7373683a2f2f63386831306e346f3240677265656e626f782f7573722f6c6f63616c2f73766e2f736372697074730d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a2d3d4261636b75703d2d0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b75700d0a0d0a2d3d437265617465204e65772053747265616d2026616d703b20496d706f727420436f64653d2d0d0a235f5f4372656174652073766e2070726f6a6563742063616c6c6564206361626c656372617a795f5f0d0a2b7375646f2073766e61646d696e20637265617465202f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a235f5f4d616b652064697220736f207765627365727665722063616e20636865636b206f75742026616d703b20696e5f5f0d0a2b7375646f2063686f776e202d52207777772d646174612073766e0d0a2b7375646f2063686d6f64202d5220672b7277732073766e0d0a235f5f416464207468652064697220746f206170616368655f5f0d0a2b7375646f207669202f6574632f617061636865322f617061636865322e636f6e660d0a2b266c743b4c6f636174696f6e202f73766e2f6361626c656372617a792667743b0d0a2b4441562073766e0d0a2b53564e50617468202f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a2b41757468547970652042617369630d0a2b417574684e616d65202671756f743b73756276657273696f6e207265706f7369746f72792671756f743b0d0a2b417574685573657246696c65202f6574632f73756276657273696f6e2f7061737377640d0a2b526571756972652076616c69642d757365720d0a2b266c743b2f4c6f636174696f6e2667743b0d0a235f5f426f756e6365206170616368655f5f0d0a2b7375646f202f6574632f696e69742e642f6170616368653220726573746172740d0a235f5f496e697469616c206461746120696d706f72745f5f0d0a2b7375646f2073766e20696d706f7274202d6d202671756f743b496e697469616c20496d706f72742671756f743b202f7661722f7777772f6361626c655f6372617a790d0a2b66696c653a2f2f2f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a235f5f557064617465206c6f63616c20766965775f5f0d0a2b63386831306e346f3240677265656e626f783a2f7661722f777777242073766e20636865636b6f7574207e6e707e687474703a2f2f677265656e626f782f73766e2f6361626c656372617a797e6e707e),
('Linux', 12, 0, 1185113476, '', 'c8h10n4o2', '72.255.41.15', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f63657373657329290d0a0d0a282853616d626129290d0a0d0a28285472656f203635302073657475702077697468205562756e747529290d0a0d0a282847617465776179206d3637357820526164656f6e20393730306d205562756e7475205365747570292920),
('HomePage', 17, 0, 1183719368, '', 'c8h10n4o2', '72.255.27.197', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c5f436f646529290d0a0d0a282841646f6265205072656d69657229290d0a0d0a282851756f7465732929),
('HomePage', 18, 0, 1186863610, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c5f436f646529290d0a0d0a282841646f6265205072656d69657229290d0a0d0a282851756f74657329290d0a0d0a282841766964656d757820322929),
('File System', 2, 0, 1181931171, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d4469736b2055736167653d2d0d0a3d3d3d53697a65206f6620616c6c204449525320696e2063757272656e74204449523d3d3d0d0a6475202d73686b202a0d0a0d0a3d3d3d53697a65206f662063757272656e74204449523d3d3d0d0a6475202d73686b202e0d0a0d0a2d3d46696c6520436f756e743d2d0d0a6c73202d6c207c207763202d6c0d0a0d0a2d3d4c69737420616c6c20686172642064726976657320616e6420737061636520696e666f3d2d0d0a6466202d6c6b),
('Networking', 2, 0, 1181931264, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d476574204e756d626572206f66204f70656e20436f6e6e656374696f6e7320746f20506f72743d2d0d0a6e657473746174202d616e207c2061776b20272431207e202f5c2e266c743b504f5254204e554d2667743b242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a5f5f45583a5f5f206e657473746174202d616e207c2061776b20272431207e202f5c2e31363636242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a2d3d446973706c6179204e6574776f726b2053706565643d2d0d0a7375646f20657468746f6f6c20657468300d0a0d0a2d3d446973706c6179205370656564206f66204e49433d2d0d0a7375646f206d69692d746f6f6c0d0a0d0a2d3d4d6f64696679204e6574776f726b20436f6e6669672053706565643d2d0d0a7375646f20657468746f6f6c202d7320657468302073706565642031303030206475706c65782066756c6c0d0a0d0a2d3d53657420757020535348204b65793d2d0d0a23204f6e20736f75726365206d616368696e652c206364207e2f2e737368200d0a232063617420636f6e74656e7473206f662069645f6473612e707562204f522069645f7273612e707562200d0a2320436f707920636f6e74656e747320616e6420706173746520696e206e6f746570616420284e4f54453a205448495320495320412053494e474c45204c494e452c204e4f54204d554c5449504c4529200d0a232073736820746f2044657374696e6174696f6e20626f782066726f6d2074686520536f7572636520426f78200d0a2320456e74657220796f75722070617373776f726420616e64206c6f67696e2e2028496620796f752063616e6e6f74206c6f6720696e2c207468656e204e47206e6565647320746f206164642074686174207573657220746f20746865206c697374206f6620757365727320666f72207468617420626f782e29200d0a232056657269667920796f752061726520696e20686f6d6520646972203d2667743b20707764200d0a2320435245415445202e73736820646972203d2667743b206d6b646972202e737368200d0a2320536574202e737368207065726d697373696f6e7320746f20373030203d2667743b2063686d6f6420373030202e737368200d0a23206364202e737368200d0a2320766920617574686f72697a65645f6b657973200d0a2320706173746520796f7572206b657920616e64206d616b65207375726520697420697320612073696e676c65206c696e652e200d0a232076657269667920796f757220636f6e6e656374696f6e7320776f726b73206279207373682062617463687461614069657461647530303120616e6420796f752073686f756c64206e6f74206765742061206c6f67696e2e0d0a2a20496620796f75206172652070726f6d7074656420666f722061206c6f67696e2c20796f752064696420736f6d657468696e672077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f722070617373776f72642c20796f752064696420736f6d65746869676e2077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f7220706173737068726173652c2077686f6576657220637265617465642074686174207075626c6963202f2070726976617465206b657920706169722077652075736564206372656174656420612070617373706872617365207769746820697420616c736f2e0d0a0d0a),
('Networking', 3, 0, 1192107006, '', 'c8h10n4o2', '72.177.2.140', '', 0x2d3d476574204e756d626572206f66204f70656e20436f6e6e656374696f6e7320746f20506f72743d2d0d0a6e657473746174202d616e207c2061776b20272431207e202f5c2e266c743b504f5254204e554d2667743b242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a5f5f45583a5f5f206e657473746174202d616e207c2061776b20272431207e202f5c2e31363636242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a2d3d446973706c61792061707020617070732026616d703b20706f727473206c697374656e696e673d2d0d0a6e657473746174202d616e207c2067726570202671756f743b4c495354454e202671756f743b0d0a0d0a2d3d446973706c6179204e6574776f726b2053706565643d2d0d0a7375646f20657468746f6f6c20657468300d0a0d0a2d3d446973706c6179205370656564206f66204e49433d2d0d0a7375646f206d69692d746f6f6c0d0a0d0a2d3d4d6f64696679204e6574776f726b20436f6e6669672053706565643d2d0d0a7375646f20657468746f6f6c202d7320657468302073706565642031303030206475706c65782066756c6c0d0a0d0a2d3d53657420757020535348204b65793d2d0d0a23204f6e20736f75726365206d616368696e652c206364207e2f2e737368200d0a232063617420636f6e74656e7473206f662069645f6473612e707562204f522069645f7273612e707562200d0a2320436f707920636f6e74656e747320616e6420706173746520696e206e6f746570616420284e4f54453a205448495320495320412053494e474c45204c494e452c204e4f54204d554c5449504c4529200d0a232073736820746f2044657374696e6174696f6e20626f782066726f6d2074686520536f7572636520426f78200d0a2320456e74657220796f75722070617373776f726420616e64206c6f67696e2e2028496620796f752063616e6e6f74206c6f6720696e2c207468656e204e47206e6565647320746f206164642074686174207573657220746f20746865206c697374206f6620757365727320666f72207468617420626f782e29200d0a232056657269667920796f752061726520696e20686f6d6520646972203d2667743b20707764200d0a2320435245415445202e73736820646972203d2667743b206d6b646972202e737368200d0a2320536574202e737368207065726d697373696f6e7320746f20373030203d2667743b2063686d6f6420373030202e737368200d0a23206364202e737368200d0a2320766920617574686f72697a65645f6b657973200d0a2320706173746520796f7572206b657920616e64206d616b65207375726520697420697320612073696e676c65206c696e652e200d0a232076657269667920796f757220636f6e6e656374696f6e7320776f726b73206279207373682062617463687461614069657461647530303120616e6420796f752073686f756c64206e6f74206765742061206c6f67696e2e0d0a2a20496620796f75206172652070726f6d7074656420666f722061206c6f67696e2c20796f752064696420736f6d657468696e672077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f722070617373776f72642c20796f752064696420736f6d65746869676e2077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f7220706173737068726173652c2077686f6576657220637265617465642074686174207075626c6963202f2070726976617465206b657920706169722077652075736564206372656174656420612070617373706872617365207769746820697420616c736f2e0d0a0d0a),
('System', 4, 0, 1185223380, '', 'c8h10n4o2', '72.255.3.164', '', 0x2d3d54696d652053797374656d20486173206265656e2055703d2d0d0a757074696d650d0a0d0a2d3d4e756d626572206f662043505527733d2d0d0a707372696e666f0d0a0d0a2d3d4b65726e656c2056657273696f6e3d2d0d0a756e616d65202d720d0a0d0a2d3d43726561746520612053796d626f6c6963204c696e6b3d2d0d0a6c6e202d7320266c743b544152474554204449524543544f5259204f522046494c452667743b202e2f266c743b53484f52544355542667743b0d0a0d0a466f72206578616d706c653a0d0a0d0a6c6e202d73202f7573722f6c6f63616c2f6170616368652f6c6f6773202e2f6c6f6773),
('Searching', 5, 0, 1181930023, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a0d0a2d3d46696e6420616c6c2066696c657320636f6e7461696e696e67206120737472696e673d2d0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b202d657865632067726570202671756f743b68656c6c6f2671756f743b207b7d5c3b0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b207c2078617267732067726570202671756f743b68656c6c6f2671756f743b20322667743b2f6465762f6e756c6c0d0a0d0a0d0a2d3d537472696e67205265706c6163653d2d0d0a3d3d3d536561726368204d756c7469706c652046696c65733d3d3d0d0a66696e64202f657463202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b202d65786563207065726c202d7069202d65202671756f743b732f454e562f4147494e4730322f672671756f743b207b7d5c3b0d0a0d0a3d3d3d53696e676c652046696c653d3d3d0d0a7065726c202d7069202d65202671756f743b732f454e562f4147494e4730322f672671756f743b2070657273697374656e63652e70726f706572746965730d0a0d0a3d3d3d57696e646f7773204e6577204c696e6520436861723d3d3d0d0a66696e64202e202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b202d65786563207065726c202d7069202d65202671756f743b732f5c3031355c3031322f5c3031322f672671756f743b207b7d205c3b0d0a0d0a2d3d43484d4f44206f6620616c6c2066696c657320696e206120646972207265637572736976656c793d2d0d0a66696e64202e202d747970652066202d657865632063686d6f6420363434207b7d205c3b200d0a0d0a2d3d53656172636820666f7220706172746963756c61722066696c6520696e2061206a61723d2d0d0a434f444528666f72206920696e206066696e64202e202d6e616d65202671756f743b2a2e6a61722671756f743b202d7072696e74603b20646f20756e7a6970202d6c20236920322667743b2f6465762f6e756c6c207c2067726570202671756f743b46696c654e616d652671756f743b202667743b202f6465762f6e756c6c20322667743b26616d703b313b206966205b5b20243f203d3d2030205d3b207468656e206563686f2023693b2066693b20646f6e6529),
('Searching', 6, 0, 1193671040, '', 'c8h10n4o2', '24.153.198.63', '', 0x2d3d53656172636820466f7220537472696e6720696e20616c6c2046696c65733d2d0d0a3d3d3d46696e6420454e563d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570202671756f743b454e562671756f743b0d0a0d0a3d3d3d46696e64205e4d3d3d3d0d0a66696e64202e2f2a202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b207c2067726570205c3031355c3031320d0a0d0a2d3d46696e6420616c6c2066696c657320636f6e7461696e696e67206120737472696e673d2d0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b202d657865632067726570202671756f743b68656c6c6f2671756f743b207b7d5c3b0d0a66696e64202f657463202d6e616d65202671756f743b2a2e6a6176612671756f743b207c2078617267732067726570202671756f743b68656c6c6f2671756f743b20322667743b2f6465762f6e756c6c0d0a0d0a0d0a2d3d537472696e67205265706c6163653d2d0d0a3d3d3d536561726368204d756c7469706c652046696c65733d3d3d0d0a66696e64202f657463202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b202d65786563207065726c202d7069202d65202671756f743b732f454e562f4147494e4730322f672671756f743b207b7d5c3b0d0a0d0a3d3d3d53696e676c652046696c653d3d3d0d0a7065726c202d7069202d65202671756f743b732f454e562f4147494e4730322f672671756f743b2070657273697374656e63652e70726f706572746965730d0a0d0a3d3d3d57696e646f7773204e6577204c696e6520436861723d3d3d0d0a66696e64202e202d747970652066202d6e616d65202671756f743b2a2e6b73682671756f743b202d65786563207065726c202d7069202d65202671756f743b732f5c3031355c3031322f5c3031322f672671756f743b207b7d205c3b0d0a0d0a2d3d43484d4f44206f6620616c6c2066696c657320696e206120646972207265637572736976656c793d2d0d0a66696e64202e202d747970652066202d657865632063686d6f6420363434207b7d205c3b200d0a0d0a2d3d53656172636820666f7220706172746963756c61722066696c6520696e2061206a61723d2d0d0a7b434f444528297d0d0a666f72206920696e206066696e64202e202d6e616d65202671756f743b2a2e6a61722671756f743b202d7072696e74603b20646f20756e7a6970202d6c20236920322667743b2f6465762f6e756c6c207c2067726570202671756f743b46696c654e616d652671756f743b202667743b202f6465762f6e756c6c20322667743b26616d703b313b206966205b5b20243f203d3d2030205d3b207468656e206563686f2023693b2066693b20646f6e650d0a7b434f44457d),
('System', 5, 0, 1193412738, '', 'c8h10n4o2', '24.153.198.63', '', 0x2d3d54696d652053797374656d20486173206265656e2055703d2d0d0a757074696d650d0a0d0a2d3d4e756d626572206f662043505527733d2d0d0a707372696e666f0d0a0d0a2d3d4b65726e656c2056657273696f6e3d2d0d0a756e616d65202d720d0a0d0a2d3d43726561746520612053796d626f6c6963204c696e6b3d2d0d0a6c6e202d7320266c743b544152474554204449524543544f5259204f522046494c452667743b202e2f266c743b53484f52544355542667743b0d0a0d0a466f72206578616d706c653a0d0a0d0a6c6e202d73202f7573722f6c6f63616c2f6170616368652f6c6f6773202e2f6c6f67730d0a0d0a2d3d476574205562756e74752056657273696f6e3d2d0d0a6d6f7265202f6574632f6c73622d72656c65617365),
('System', 6, 0, 1194749573, '', 'c8h10n4o2', '66.68.51.87', '', 0x2d3d54696d652053797374656d20486173206265656e2055703d2d0d0a757074696d650d0a0d0a2d3d4e756d626572206f662043505527733d2d0d0a707372696e666f0d0a0d0a2d3d4b65726e656c2056657273696f6e3d2d0d0a756e616d65202d720d0a0d0a2d3d43726561746520612053796d626f6c6963204c696e6b3d2d0d0a6c6e202d7320266c743b544152474554204449524543544f5259204f522046494c452667743b202e2f266c743b53484f52544355542667743b0d0a0d0a466f72206578616d706c653a0d0a0d0a6c6e202d73202f7573722f6c6f63616c2f6170616368652f6c6f6773202e2f6c6f67730d0a0d0a2d3d476574205562756e74752056657273696f6e3d2d0d0a6d6f7265202f6574632f6c73622d72656c656173650d0a0d0a2d3d53686f77206c6f636174696f6e206f662066696c653d2d0d0a63386831306e346f32406a616d65733a2f6d656469612f736462312f70686f746f6772617068732f32303037242074797065207468756e646572626972640d0a7468756e64657262697264206973202f7573722f62696e2f7468756e646572626972640d0a),
('HomePage', 19, 0, 1186863638, '', 'c8h10n4o2', '66.68.76.76', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c5f436f646529290d0a0d0a282841646f6265205072656d69657229290d0a0d0a282851756f7465732929),
('Adobe Photoshop', 1, 0, 1195311530, '', 'c8h10n4o2', '66.68.51.87', '', 0x5072696e74696e6720746f20616e204570736f6e20323230302066726f6d2050686f746f73686f700d0a507265706172696e6720616e20496d6167652046696c6520666f72207072696e74696e67207769746820746865204570736f6e2032323030202d20656974686572205374616e206f722042657474790d0a202009312920437265617465206120636f7079206f6620796f7572206f726967696e616c206f722065646974656420696d6167652066696c652e0d0a322920596f75722066696c652073686f756c6420626520696e20524742206d6f646528696e2074686520496d6167652d2d2667743b4d6f6465204d656e75292e20496465616c6c7920796f75722066696c6520776f756c64206861766520616e2041646f62655247422070726f66696c6528616c736f20696e2074686520496d6167652d2d2667743b4d6f64652d2d2667743b436f6e766572742050726f66696c65204d656e75290d0a33292055736520496d6167652053697a652028696e2074686520496d616765204d656e752920746f2061646a75737420796f757220646f63756d656e7420746f207468652073697a6520796f752077616e7420746f207072696e742069742e0d0a2020092020096129204d6178696d756d2070617065722073697a6520697320313320696e6368657320627920343420696e636865732e0d0a622920496465616c207265736f6c7574696f6e7320666f7220746865204570736f6e203232303020617265203336302c203330302c2032343020616e6420313830206470692e0d0a202009342920466c617474656e20796f757220696d6167652e20546865202671756f743b466c617474656e20496d6167652671756f743b20616374696f6e20697320666f756e642061742074686520626f74746f6d206f6620746865202671756f743b4c617965722671756f743b204d656e752e0d0a3529205361766520796f75722066696c652e0d0a4570736f6e20323230302077656220736974650d0a506170657220547970657320666f72204570736f6e20323230300d0a5072696e74696e6720796f757220496d6167650d0a2020094f6e636520796f7520686176652070726570617265642074686520696d6167652066696c6520666f72207072696e74696e672c207573652074686520666f6c6c6f77696e6720696e737472756374696f6e7320746f207072696e742074686520696d6167652066696c652e20596f752077696c6c206265206e617669676174696e672074687265652073657061726174652077696e646f777320647572696e6720746865207072696e74696e672070726f636573732e0d0a5072696e742057696e646f77202d202841646f6265290d0a20200931292046726f6d207468652046696c65204d656e752063686f6f736520e2809c5072696e7420776974682050726576696577e2809d206f72207479706520436f6d6d616e642d502e0d0a32292054686520e2809c5072696e74e2809d2077696e646f7720617070656172732e2043686f6f736520e2809c50616765205365747570e280a6e2809d0d0a506167652053657475702057696e646f770d0a20200933292054686520e2809c50616765205365747570e2809d2077696e646f7720617070656172732e0d0a202009202009612920436c69636b206f6e2074686520e2809c466f726d617420666f723ae2809d20706f702d757020627574746f6e2e2043686f6f736520e2809c5374616e2032323030e2809d206f72202671756f743b426574747920323230302671756f743b2e0d0a622920436c69636b206f6e2074686520e2809c50617065722053697a653ae2809d20706f702d757020627574746f6e2e2043686f6f736520612070617065722073697a652074686174206973206173206c61726765206f72206c6172676572207468616e20796f757220646f63756d656e742073697a652e202d2d2d20536565206368617274206f6e2077616c6c20666f722070617065722073697a657320616e6420636f72726573706f6e64696e67206e616d65732e0d0a4d61782070617065722073697a6520697320313320696e6368657320627920343420696e636865732e0d0a63292046726f6d2074686520e2809c4f7269656e746174696f6ee2809d2073656374696f6e2c2063686f6f736520506f72747261697428696d616765206d6f726520766572746963616c29206f72204c616e64736361706528696d616765206d6f726520686f72697a6f6e74616c290d0a6429204c6561766520e2809c5363616c653ae2809d20617420313030252e0d0a652920436c69636b2074686520e2809c4f4be2809d20627574746f6e2e0d0a66292054686520e2809c50616765205365747570e2809d2077696e646f7720636c6f73657320616e642074616b657320796f75206261636b20746f20746865205072696e742077696e646f772e0d0a5072696e742057696e646f77202d202841646f6265290d0a202009342920596f757220696d6167652073686f756c64206e6f77206669742077697468696e2074686520707265766965772070616e6520696e20746865207570706572206c65667420636f726e6572206f662074686520e2809c5072696e74e2809d2077696e646f772e204966206e6f7420796f7520686176652063686f73656e20612070617065722073697a65207468617420697320746f6f20736d616c6c206f7220616e20696e636f7272656374206f7269656e746174696f6e2e2052657475726e20746f2074686520e2809c50616765205365747570e2809d2077696e646f772e0d0a35292053656520436f6c6f72204d616e6167656d656e742068616e646f757420666f722064657461696c73206f6e207573696e67204943432070726f66696c65732e0d0a362920436c69636b2074686520e2809c5072696e742e2e2ee2809d20627574746f6e2e0d0a5072696e742057696e646f77202d20284170706c65290d0a2020093729205468652050686f746f73686f7020e2809c5072696e74e2809d2077696e646f7720636c6f73657320616e6420746865207374616e64617264204170706c6520e2809c5072696e74e2809d2077696e646f7720617070656172732e0d0a202009202009612920436c69636b206f6e2074686520e2809c5072696e746572e2809d20706f702d757020627574746f6e2e2043686f6f736520e2809c5374616e2032323030e2809d206f72202671756f743b426574747920323230302671756f743b2e0d0a622920436c69636b206f6e2074686520e2809c436f7069657320616e64205061676573e2809d20706f702d757020627574746f6e2e2043686f6f736520e2809c5072696e742053657474696e6773e2809d2e0d0a202009202009202009692920436c69636b2074686520e2809c4d656469612054797065e2809d20706f702d757020627574746f6e2e2043686f6f736520796f757220706170657220747970652e0d0a69692920436c69636b2074686520e2809c416476616e6365642053657474696e6773e2809d204d6f646520726164696f20627574746f6e2e0d0a69692920436c69636b206f6e2074686520e2809c5072696e74205175616c697479e2809d20706f702d757020627574746f6e2e2043686f6f736520796f757220707265666572726564207265736f6c7574696f6e2e203134343020666f722074657374207072696e747320616e64203238383020666f722066696e616c207072696e74732e0d0a202009202009632920436c69636b2074686520e2809c5072696e74e2809d20627574746f6e20617420746865206c6f7765722072696768742068616e6420636f726e6572206f66207468652077696e646f772e0d0a596f757220696d6167652073686f756c64206e6f77207072696e742e0d0a546f20636865636b20746865207072696e74696e67207374617475732c206f70656e205072696e742043656e74657228696e20746865204170706c69636174696f6e732d2d2667743b5574696c697469657320666f6c64657229616e6420646f75626c652d636c69636b206f6e2074686520436f6c6f72205374796c757320323230302e200d0a0d0a0d0a534f555243453a20687474703a2f2f7765622e6d69742e6564752f7661702f7265736f75726365732f6775696465732f6570736f6e323230302e68746d6c20200920),
('Linux', 13, 0, 1186714408, '', 'c8h10n4o2', '66.68.76.76', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f63657373657329290d0a0d0a282853616d626129290d0a0d0a28285472656f203635302073657475702077697468205562756e747529290d0a0d0a282847617465776179206d3637357820526164656f6e20393730306d205562756e74752053657475702929200d0a0d0a28285562756e74752929),
('Running Processes', 1, 0, 1181931907, '', 'c8h10n4o2', '168.56.37.8', '', 0x2d3d50726f6365737320547265653d2d0d0a707472656520266c743b50726f636573732049442667743b0d0a0d0a2d3d446973706c61792052756e6e696e672050726f6365737365733d2d0d0a707273746174202d612031300d0a0d0a746f700d0a0d0a7073202d65660d0a0d0a2d3d4b696c6c204d756c7469706c652052756e6e696e672050726f63657373657320766961204e616d653d2d0d0a7073202d6566207c206772657020266c743b555345522667743b207c206772657020266c743b50415254204f46204a4f42204e414d452667743b207c2061776b20277b7072696e742024327d27207c207861726773206b696c6c),
('Running Processes', 2, 0, 1199385409, '', 'c8h10n4o2', '24.153.198.63', '', 0x2d3d50726f6365737320547265653d2d0d0a707472656520266c743b50726f636573732049442667743b0d0a0d0a2d3d446973706c61792052756e6e696e672050726f6365737365733d2d0d0a707273746174202d612031300d0a0d0a746f700d0a0d0a7073202d65660d0a0d0a2d3d4b696c6c204d756c7469706c652052756e6e696e672050726f63657373657320766961204e616d653d2d0d0a7073202d6566207c206772657020266c743b555345522667743b207c206772657020266c743b50415254204f46204a4f42204e414d452667743b207c2061776b20277b7072696e742024327d27207c207861726773206b696c6c0d0a0d0a2d3d52756e2050726f6365737320696e204261636b67726f756e643d2d0d0a5f52756e206a6f62206173206368696c642070726f63657373206f662063757272656e74207368656c6c5f0d0a266c743b636d642667743b2026616d703b0d0a45583a206370202e2f2a202f746573742026616d703b0d0a0d0a5f466f726b20616e6f74686572207368656c6c2026616d703b2065786563757465206a6f6220696e2074686174207368656c6c5f0d0a28266c743b636d642667743b290d0a45583a20286370202e2f2a202f746573742026616d703b29),
('Running Processes', 3, 0, 1199385465, '', 'c8h10n4o2', '24.153.198.63', '', 0x2d3d50726f6365737320547265653d2d0d0a707472656520266c743b50726f636573732049442667743b0d0a0d0a2d3d446973706c61792052756e6e696e672050726f6365737365733d2d0d0a707273746174202d612031300d0a0d0a746f700d0a0d0a7073202d65660d0a0d0a2d3d4b696c6c204d756c7469706c652052756e6e696e672050726f63657373657320766961204e616d653d2d0d0a7073202d6566207c206772657020266c743b555345522667743b207c206772657020266c743b50415254204f46204a4f42204e414d452667743b207c2061776b20277b7072696e742024327d27207c207861726773206b696c6c0d0a0d0a2d3d52756e2050726f6365737320696e204261636b67726f756e643d2d0d0a5f5f52756e206a6f62206173206368696c642070726f63657373206f662063757272656e74207368656c6c5f5f0d0a266c743b636d642667743b2026616d703b0d0a45583a206370202e2f2a202f746573742026616d703b0d0a0d0a5f5f466f726b20616e6f74686572207368656c6c2026616d703b2065786563757465206a6f6220696e2074686174207368656c6c5f5f0d0a28266c743b636d642667743b290d0a45583a20286370202e2f2a202f746573742026616d703b29),
('File System', 3, 0, 1191509962, '', 'c8h10n4o2', '24.153.198.63', '', 0x2d3d4469736b2055736167653d2d0d0a3d3d3d53697a65206f6620616c6c204449525320696e2063757272656e74204449523d3d3d0d0a6475202d73686b202a0d0a0d0a3d3d3d53697a65206f662063757272656e74204449523d3d3d0d0a6475202d73686b202e0d0a0d0a2d3d46696c6520436f756e743d2d0d0a6c73202d6c207c207763202d6c0d0a0d0a2d3d4c69737420616c6c20686172642064726976657320616e6420737061636520696e666f3d2d0d0a6466202d6c6b0d0a0d0a2d3d4c69737420616c6c2068617264206472697665732026616d703b20706172746974696f6e733d2d0d0a666469736b202d6c);
INSERT INTO `tiki_history` (`pageName`, `version`, `version_minor`, `lastModif`, `description`, `user`, `ip`, `comment`, `data`) VALUES
('Subversion', 8, 0, 1186712775, '', 'c8h10n4o2', '66.68.76.76', '', 0x2d3d42617369632053564e20436f6d6d616e64733d2d0d0a534f555243453a20687474703a2f2f7777772e6c696e757866726f6d736372617463682e6f72672f626c66732f656467756964652f6368617074657230332e68746d6c0d0a0d0a5f5f496e74726f64756374696f6e5f5f0d0a0d0a5468652068656c702066756e6374696f6e206f662053756276657273696f6e202873766e2068656c70292070726f766964657320612073756d6d617279206f662074686520617661696c61626c6520636f6d6d616e64732e204d6f72652064657461696c656420696e666f726d6174696f6e20697320617661696c61626c652066726f6d207468652053756276657273696f6e206f6e2d6c696e6520626f6f6b20617661696c61626c6520617420687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f696e6465782e68746d6c2e2043686170746572203320697320657370656369616c6c792068656c7066756c2e0d0a0d0a54686520666f6c6c6f77696e67206973206120626173696320736574206f6620636f6d6d616e647320776869636820616c6c20656469746f72732077696c6c20757365206672657175656e746c792e20536f6d6520636f6d6d616e647320686176652074776f20666f726d732c20746865206c6f6e6720616e64207468652073686f72742e20426f746820617265206c697374656420696e20746865206465736372697074696f6e2e0d0a0d0a5f5f73766e20636865636b6f75742f636f5f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636865636b6f75742e68746d6c207c2073766e20636865636b6f75745d206f722073766e20636f2e205468697320636f6d6d616e64206973207573656420746f2070756c6c20616e2053564e207472656520737563682061732073766e3a2f2f6c696e757866726f6d736372617463682e6f72672f424c46532f7472756e6b2f424f4f4b202874686520424c465320446576656c6f706d656e7420626f6f6b292066726f6d20746865207365727665722e20596f752073686f756c64206f6e6c79206e65656420746f20646f2074686973206f6e63652e20496620746865206469726563746f727920737472756374757265206973206368616e6765642028617320697320736f6d6574696d6573206e6563657373617279292c20796f75206d6179206f63636173696f6e616c6c79206e65656420746f2064656c65746520796f7572206c6f63616c2073616e6420626f7820616e642072652d636865636b206974206f75742e204966207468697320697320676f696e6720746f206265206e65656465642c2069742077696c6c20757375616c6c7920626520626563617573652074686520456469746f722077696c6c2068617665206d6164652061206c61726765206368616e676520616e642069742077696c6c20626520616e6e6f756e636564206174206c65617374206f6e2074686520424c46532d426f6f6b206d61696c696e67206c6973742e0d0a0d0a5f5f73766e206164645f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6164642e68746d6c207c2073766e206164645d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f75206e65656420746f2074656c6c207468652053564e207365727665722061626f75742069742e205468697320636f6d6d616e6420646f657320746861742e204e6f74652074686174207468652066696c6520776f6e27742061707065617220696e20746865207265706f7369746f727920756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2070726f707365745f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e70726f707365742e68746d6c207c2073766e2070726f707365745d2e205768656e20796f7520617265206372656174696e672061206e65772066696c65206f72206469726563746f72792c20796f752067656e6572616c6c79206e65656420746f2074656c6c207468652053564e20746f206170706c792070726f7065727469657320746f207468652066696c6520696e20706c6163657320746861742068617665206b6579776f72647320696e2061207370656369616c20666f726d617420737563682061732024446174653a20323030372d30342d30332031343a32383a3137202d3035303020285475652c2030332041707220323030372920242e204e6f7465207468617420746865206b6579776f72642076616c756520776f6e27742061707065617220696e207468652066696c6520756e74696c20796f7520646f20616e2073766e20636f6d6d697420287365652062656c6f77292e0d0a0d0a5f5f73766e2064656c6574655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e64656c6574652e68746d6c207c2073766e2064656c6574655d2e205468697320646f65732077686174206974207361797321205768656e20796f7520646f20616e2073766e20636f6d6d6974207468652066696c652077696c6c2062652064656c657465642066726f6d20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c2061732066726f6d20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a5f5f73766e207374617475735f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7374617475732e68746d6c207c2073766e207374617475735d2e205468697320636f6d6d616e64207072696e74732074686520737461747573206f6620776f726b696e67206469726563746f7269657320616e642066696c65732e20496620796f752068617665206d616465206c6f63616c206368616e6765732c206974276c6c2073686f7720796f7572206c6f63616c6c79206d6f646966696564206974656d732e20496620796f752075736520746865202d2d766572626f7365207377697463682c2069742077696c6c2073686f77207265766973696f6e20696e666f726d6174696f6e206f6e206576657279206974656d2e205769746820746865202d2d73686f772d7570646174657320282d7529207377697463682c2069742077696c6c2073686f7720616e7920736572766572206f75742d6f662d6461746520696e666f726d6174696f6e2e0d0a0d0a596f752073686f756c6420616c7761797320646f2061206d616e75616c2073766e20737461747573202d2d73686f772d75706461746573206265666f726520747279696e6720746f20636f6d6d6974206368616e67657320696e206f7264657220746f20636865636b20746861742065766572797468696e67206973204f4b20616e6420726561647920746f20676f2e0d0a0d0a5f5f73766e207570646174652f75705f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e7570646174652e68746d6c207c2073766e207570646174655d206f722073766e2075702e205468697320636f6d6d616e642073796e637320796f7572206c6f63616c2073616e6420626f78207769746820746865207365727665722e20496620796f752068617665206d616465206c6f63616c206368616e6765732c2069742077696c6c2074727920616e64206d6572676520616e79206368616e676573206f6e2074686520736572766572207769746820796f7572206368616e676573206f6e20796f7572206d616368696e652e0d0a0d0a5f5f73766e20636f6d6d69742f63695f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e636f6d6d69742e68746d6c207c2073766e20636f6d6d69745d206f722073766e2063692e205468697320636f6d6d616e64207265637572736976656c792073656e647320796f7572206368616e67657320746f207468652053564e207365727665722e2049742077696c6c20636f6d6d6974206368616e6765642066696c65732c2061646465642066696c65732c20616e642064656c657465642066696c65732e204e6f7465207468617420796f752063616e20636f6d6d69742061206368616e676520746f20616e20696e646976696475616c2066696c65206f72206368616e67657320746f2066696c657320696e2061207370656369666963206469726563746f7279207061746820627920616464696e6720746865206e616d65206f66207468652066696c652f6469726563746f727920746f2074686520656e64206f662074686520636f6d6d616e642e20546865202d6d206f7074696f6e2073686f756c6420616c77617973206265207573656420746f20706173732061206c6f67206d65737361676520746f2074686520636f6d6d616e642e20506c6561736520646f6e27742075736520656d707479206c6f67206d657373616765732028736565206c6174657220696e207468697320646f63756d656e742074686520706f6c69637920776869636820676f7665726e7320746865206c6f67206d65737361676573292e0d0a0d0a5f5f73766e20646966665f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e646966662e68746d6c207c2073766e20646966665d2e20546869732069732075736566756c20666f722074776f20646966666572656e7420707572706f7365732e2046697273742c2074686f736520776974686f75742077726974652061636365737320746f2074686520424c46532053564e207365727665722063616e2075736520697420746f2067656e6572617465207061746368657320746f2073656e6420746f2074686520424c46532d446576206d61696c696e67206c6973742e20546f20646f20746869732c2073696d706c792065646974207468652066696c657320696e20796f7572206c6f63616c2073616e6420626f78207468656e2072756e2073766e2064696666202667743b2046494c452e70617463682066726f6d2074686520726f6f74206f6620796f757220424c4653206469726563746f72792e20596f752063616e207468656e2061747461636820746869732066696c6520746f2061206d65737361676520746f2074686520424c46532d446576206d61696c696e67206c69737420776865726520736f6d656f6e6520776974682065646974696e67207269676874732063616e207069636b20697420757020616e64206170706c7920697420746f2074686520626f6f6b2e20546865207365636f6e642075736520697320746f2066696e64206f7574207768617420686173206368616e676564206265747765656e2074776f207265766973696f6e73207573696e673a2073766e2064696666202d72207265766973696f6e313a7265766973696f6e322046494c454e414d452e20466f72206578616d706c653a2073766e2064696666202d72203136383a31363920696e6465782e786d6c2077696c6c206f7574707574206120646966662073686f77696e6720746865206368616e676573206265747765656e207265766973696f6e732031363820616e6420313639206f6620696e6465782e786d6c2e0d0a0d0a5f5f73766e206d6f76655f5f0d0a0d0a5b687474703a2f2f73766e626f6f6b2e7265642d6265616e2e636f6d2f656e2f312e322f73766e2e7265662e73766e2e632e6d6f76652e68746d6c207c2073766e206d6f76652053524320444553545d206f722073766e206d76205352432044455354206f722073766e2072656e616d65205352432044455354206f722073766e2072656e2053524320444553542e205468697320636f6d6d616e64206d6f76657320612066696c652066726f6d206f6e65206469726563746f727920746f20616e6f74686572206f722072656e616d657320612066696c652e205468652066696c652077696c6c206265206d6f766564206f6e20796f7572206c6f63616c2073616e6420626f7820696d6d6564696174656c792061732077656c6c206173206f6e20746865207265706f7369746f727920616674657220636f6d6d697474696e672e0d0a0d0a2d3d4261636b75703d2d0d0a7375646f2073766e61646d696e2064756d70202f7573722f6c6f63616c2f73766e2f6874646f6373202667743b202f746d702f6874646f63732e64756d70203b206d76202d66202f746d702f6874646f63732e64756d70202f6d6e742f6261636b75700d0a0d0a2d3d436865636b6f7574204578616d706c653d2d0d0a73766e20636865636b6f75742073766e2b7373683a2f2f63386831306e346f3240677265656e626f782f7573722f6c6f63616c2f73766e2f736372697074730d0a0d0a2d3d437265617465204e65772053747265616d2026616d703b20496d706f727420436f64653d2d0d0a235f5f4372656174652073766e2070726f6a6563742063616c6c6564206361626c656372617a795f5f0d0a2b7375646f2073766e61646d696e20637265617465202f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a235f5f4d616b652064697220736f207765627365727665722063616e20636865636b206f75742026616d703b20696e5f5f0d0a2b7375646f2063686f776e202d52207777772d646174612073766e0d0a2b7375646f2063686d6f64202d5220672b7277732073766e0d0a235f5f416464207468652064697220746f206170616368655f5f0d0a2b7375646f207669202f6574632f617061636865322f617061636865322e636f6e660d0a2b266c743b4c6f636174696f6e202f73766e2f6361626c656372617a792667743b0d0a2b4441562073766e0d0a2b53564e50617468202f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a2b41757468547970652042617369630d0a2b417574684e616d65202671756f743b73756276657273696f6e207265706f7369746f72792671756f743b0d0a2b417574685573657246696c65202f6574632f73756276657273696f6e2f7061737377640d0a2b526571756972652076616c69642d757365720d0a2b266c743b2f4c6f636174696f6e2667743b0d0a235f5f426f756e6365206170616368655f5f0d0a2b7375646f202f6574632f696e69742e642f6170616368653220726573746172740d0a235f5f496e697469616c206461746120696d706f72745f5f0d0a2b7375646f2073766e20696d706f7274202d6d202671756f743b496e697469616c20496d706f72742671756f743b202f7661722f7777772f6361626c655f6372617a790d0a2b66696c653a2f2f2f7573722f6c6f63616c2f73766e2f6361626c656372617a790d0a235f5f557064617465206c6f63616c20766965775f5f0d0a2b63386831306e346f3240677265656e626f783a2f7661722f777777242073766e20636865636b6f7574207e6e707e687474703a2f2f677265656e626f782f73766e2f6361626c656372617a797e6e707e),
('Linux', 14, 0, 1199380422, '', 'c8h10n4o2', '24.153.198.63', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f63657373657329290d0a0d0a282853616d626129290d0a0d0a28285472656f203635302073657475702077697468205562756e747529290d0a0d0a282847617465776179206d3637357820526164656f6e20393730306d205562756e74752053657475702929200d0a0d0a28285562756e747529290d0a0d0a282853656e6420456d61696c2929),
('Networking', 4, 0, 1192113583, '', 'c8h10n4o2', '24.153.198.63', '', 0x2d3d476574204e756d626572206f66204f70656e20436f6e6e656374696f6e7320746f20506f72743d2d0d0a6e657473746174202d616e207c2061776b20272431207e202f5c2e266c743b504f5254204e554d2667743b242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a5f5f45583a5f5f206e657473746174202d616e207c2061776b20272431207e202f5c2e31363636242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a2d3d446973706c61792061707020617070732026616d703b20706f727473206c697374656e696e673d2d0d0a6e657473746174202d616e207c2067726570202671756f743b4c495354454e202671756f743b0d0a0d0a2d3d446973706c6179204e6574776f726b2053706565643d2d0d0a7375646f20657468746f6f6c20657468300d0a0d0a2d3d446973706c6179205370656564206f66204e49433d2d0d0a7375646f206d69692d746f6f6c0d0a0d0a2d3d4d6f64696679204e6574776f726b20436f6e6669672053706565643d2d0d0a7375646f20657468746f6f6c202d7320657468302073706565642031303030206475706c65782066756c6c0d0a0d0a2d3d564e43204f766572205353483d2d0d0a596f75206d757374206861766520766e637365727665722026616d703b207373682072756e6e696e67206f6e20796f75722064657374696e6174696f6e20626f780d0a766e63766965776572202d76696120266c743b757365722667743b40266c743b69705f616464726573732667743b20266c743b646573745f626f782667743b3a266c743b706f72742667743b0d0a45583a0d0a496620796f7520617265207573696e672044594e444e5320616e64206861766520746573742e6765746d7969702e636f6d20617320796f757220646f6d61696e2c20616e6420796f757220626f78206e616d65206f6e20796f7572206c6f63616c206e6574776f726b20697320636f666665656375703a0d0a766e63766965776572202d766961206a6f6540746573742e6765746d7969702e636f6d20636f666665656375703a310d0a546869732077696c6c20766e6320746f20746573742e6765746d7969702e636f6d20616e64206c6f6720696e746f207468652076706e206173206a6f652e2049742077696c6c207468656e20766e632066726f6d207468652076706e2064657374696e6174696f6e20746f2074686520766e632064657374696e6174696f6e2e200d0a0d0a2d3d53657420757020535348204b65793d2d0d0a23204f6e20736f75726365206d616368696e652c206364207e2f2e737368200d0a232063617420636f6e74656e7473206f662069645f6473612e707562204f522069645f7273612e707562200d0a2320436f707920636f6e74656e747320616e6420706173746520696e206e6f746570616420284e4f54453a205448495320495320412053494e474c45204c494e452c204e4f54204d554c5449504c4529200d0a232073736820746f2044657374696e6174696f6e20626f782066726f6d2074686520536f7572636520426f78200d0a2320456e74657220796f75722070617373776f726420616e64206c6f67696e2e2028496620796f752063616e6e6f74206c6f6720696e2c207468656e204e47206e6565647320746f206164642074686174207573657220746f20746865206c697374206f6620757365727320666f72207468617420626f782e29200d0a232056657269667920796f752061726520696e20686f6d6520646972203d2667743b20707764200d0a2320435245415445202e73736820646972203d2667743b206d6b646972202e737368200d0a2320536574202e737368207065726d697373696f6e7320746f20373030203d2667743b2063686d6f6420373030202e737368200d0a23206364202e737368200d0a2320766920617574686f72697a65645f6b657973200d0a2320706173746520796f7572206b657920616e64206d616b65207375726520697420697320612073696e676c65206c696e652e200d0a232076657269667920796f757220636f6e6e656374696f6e7320776f726b73206279207373682062617463687461614069657461647530303120616e6420796f752073686f756c64206e6f74206765742061206c6f67696e2e0d0a2a20496620796f75206172652070726f6d7074656420666f722061206c6f67696e2c20796f752064696420736f6d657468696e672077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f722070617373776f72642c20796f752064696420736f6d65746869676e2077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f7220706173737068726173652c2077686f6576657220637265617465642074686174207075626c6963202f2070726976617465206b657920706169722077652075736564206372656174656420612070617373706872617365207769746820697420616c736f2e0d0a0d0a),
('Networking', 5, 0, 1203736693, '', 'c8h10n4o2', '66.68.51.87', '', 0x2d3d476574204e756d626572206f66204f70656e20436f6e6e656374696f6e7320746f20506f72743d2d0d0a6e657473746174202d616e207c2061776b20272431207e202f5c2e266c743b504f5254204e554d2667743b242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a5f5f45583a5f5f206e657473746174202d616e207c2061776b20272431207e202f5c2e31363636242f7b73756d2b3d317d454e447b7072696e742073756d7d27200d0a0d0a2d3d446973706c61792061707020617070732026616d703b20706f727473206c697374656e696e673d2d0d0a6e657473746174202d616e207c2067726570202671756f743b4c495354454e202671756f743b0d0a0d0a2d3d446973706c6179204e6574776f726b2053706565643d2d0d0a7375646f20657468746f6f6c20657468300d0a0d0a2d3d446973706c6179205370656564206f66204e49433d2d0d0a7375646f206d69692d746f6f6c0d0a0d0a2d3d4d6f64696679204e6574776f726b20436f6e6669672053706565643d2d0d0a7375646f20657468746f6f6c202d7320657468302073706565642031303030206475706c65782066756c6c0d0a0d0a2d3d564e43204f766572205353483d2d0d0a596f75206d757374206861766520766e637365727665722026616d703b207373682072756e6e696e67206f6e20796f75722064657374696e6174696f6e20626f780d0a766e63766965776572202d76696120266c743b757365722667743b40266c743b69705f616464726573732667743b20266c743b646573745f626f782667743b3a266c743b706f72742667743b0d0a45583a0d0a496620796f7520617265207573696e672044594e444e5320616e64206861766520746573742e6765746d7969702e636f6d20617320796f757220646f6d61696e2c20616e6420796f757220626f78206e616d65206f6e20796f7572206c6f63616c206e6574776f726b20697320636f666665656375703a0d0a766e63766965776572202d766961206a6f6540746573742e6765746d7969702e636f6d20636f666665656375703a310d0a546869732077696c6c20766e6320746f20746573742e6765746d7969702e636f6d20616e64206c6f6720696e746f207468652076706e206173206a6f652e2049742077696c6c207468656e20766e632066726f6d207468652076706e2064657374696e6174696f6e20746f2074686520766e632064657374696e6174696f6e2e200d0a0d0a2d3d53657420757020535348204b65793d2d0d0a23204f6e20736f75726365206d616368696e652c206364207e2f2e737368200d0a232063617420636f6e74656e7473206f662069645f6473612e707562204f522069645f7273612e707562200d0a2320436f707920636f6e74656e747320616e6420706173746520696e206e6f746570616420284e4f54453a205448495320495320412053494e474c45204c494e452c204e4f54204d554c5449504c4529200d0a232073736820746f2044657374696e6174696f6e20626f782066726f6d2074686520536f7572636520426f78200d0a2320456e74657220796f75722070617373776f726420616e64206c6f67696e2e2028496620796f752063616e6e6f74206c6f6720696e2c207468656e204e47206e6565647320746f206164642074686174207573657220746f20746865206c697374206f6620757365727320666f72207468617420626f782e29200d0a232056657269667920796f752061726520696e20686f6d6520646972203d2667743b20707764200d0a2320435245415445202e73736820646972203d2667743b206d6b646972202e737368200d0a2320536574202e737368207065726d697373696f6e7320746f20373030203d2667743b2063686d6f6420373030202e737368200d0a23206364202e737368200d0a2320766920617574686f72697a65645f6b657973200d0a2320706173746520796f7572206b657920616e64206d616b65207375726520697420697320612073696e676c65206c696e652e200d0a232076657269667920796f757220636f6e6e656374696f6e7320776f726b73206279207373682062617463687461614069657461647530303120616e6420796f752073686f756c64206e6f74206765742061206c6f67696e2e0d0a2a20496620796f75206172652070726f6d7074656420666f722061206c6f67696e2c20796f752064696420736f6d657468696e672077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f722070617373776f72642c20796f752064696420736f6d65746869676e2077726f6e672e0d0a2a20496620796f75206765742070726f6d7074656420666f7220706173737068726173652c2077686f6576657220637265617465642074686174207075626c6963202f2070726976617465206b657920706169722077652075736564206372656174656420612070617373706872617365207769746820697420616c736f2e0d0a0d0a2d3d446f6e277420776f7272792061626f7574202f6574632f686f7374733d2d0d0a546f206d6f756e7420612077696e646f7773207368617265206f6e20612044484350206e6574776f726b2c20697420697320636f6e76656e69656e7420746f2062652061626c6520746f206d6f756e74206279206e657462696f73206e616d652c20736f20796f7520646f6e2774206861766520746f206d6f6469667920746865206d6f756e7420706172616d65746572732065766572792074696d6520796f75207265626f6f7420796f7572206e6574776f726b2e20546869732063616e20626520656173696c7920656e61626c656420627920646f696e672074686520666f6c6c6f77696e673a0d0a0d0a4564697420796f7572206e737377697463682066696c650d0a5e7375646f207669202f6574632f6e737377697463682e636f6e665e0d0a736561726368207468726f756768207468652066696c6520616e64206c6f6f6b20666f7220746865206c696e652074686174206c6f6f6b7320736f6d657468696e67206c696b6520736f202671756f743b686f7374733a2066696c657320646e732671756f743b0d0a616464202671756f743b77696e732671756f743b20746f2074686520656e64206f6620746865206c696e650d0a6e6f74653a202671756f743b77696e732671756f743b204d55535420636f6d65206265666f7265202671756f743b646e732671756f743b20696620796f7520617265207573696e6720746865206f70656e444e5320736572766963652e0d0a6974206c6f6f6b7320736f6d657468696e67206c696b6520746869733a0d0a5e686f7374733a2066696c65732077696e7320646e735e0d0a53617665207468652066696c652062792068697474696e67203a77710d0a4e6f7720796f75276c6c206e65656420746f20696e7374616c6c2077696e62696e640d0a5e7375646f20617074697475646520696e7374616c6c2077696e62696e645e0d0a0d0a736f757263653a20687474703a2f2f7562756e7475666f72756d732e6f72672f73686f777468726561642e7068703f743d3238383533340d0a0d0a),
('Linux', 16, 0, 1203781102, '', 'c8h10n4o2', '66.68.51.87', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f63657373657329290d0a0d0a282853616d626129290d0a0d0a28285472656f203635302073657475702077697468205562756e747529290d0a0d0a282848696768706f696e7420526f636b6574526169642031383230412077697468205562756e747529290d0a0d0a282847617465776179206d3637357820526164656f6e20393730306d205562756e74752053657475702929200d0a0d0a28285562756e747529290d0a0d0a282853656e6420456d61696c2929),
('HomePage', 20, 0, 1195311507, '', 'c8h10n4o2', '66.68.51.87', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c5f436f646529290d0a0d0a282841646f6265205072656d69657229290d0a0d0a282841646f62652050686f746f73686f7029290d0a0d0a282851756f7465732929),
('Linux', 15, 0, 1203655577, '', 'c8h10n4o2', '66.68.51.87', '', 0x282853797374656d29290d0a0d0a282846696c652053797374656d29290d0a0d0a2828536561726368696e6729290d0a0d0a28284d61696e7461696e20557365727329290d0a0d0a28284e6574776f726b696e6729290d0a0d0a2828536372697074696e6729290d0a0d0a282852756e6e696e672050726f63657373657329290d0a0d0a282853616d626129290d0a0d0a28285472656f203635302073657475702077697468205562756e747529290d0a0d0a2828526f636b6574526169642031383230412077697468205562756e747529290d0a0d0a282847617465776179206d3637357820526164656f6e20393730306d205562756e74752053657475702929200d0a0d0a28285562756e747529290d0a0d0a282853656e6420456d61696c2929),
('HomePage', 21, 0, 1211421809, '', 'c8h10n4o2', '66.68.52.223', '', 0x28284c696e757829290d0a0d0a282853756276657273696f6e29290d0a0d0a282850485029290d0a0d0a282857656253706865726529290d0a0d0a28285045524c5f436f646529290d0a0d0a282841646f6265205072656d69657229290d0a0d0a282841646f62652050686f746f73686f7029290d0a0d0a282851756f74657329290d0a0d0a28284f5320582929),
('Rational ClearCase', 1, 0, 1219778881, '', 'admin', '168.40.105.128', '', 0x23636c656172636173652063726561746520766965770d0a434f444528290d0a5b77617361646d696e406965646161753031395d2f686f6d652f77617361646d696e2667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d205353505f444556402f44435f50726f6a65637473205353505f4445560d0a434f44450d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a636f646528290d0a5b77617361646d696e406965646161753031395d2f686f6d652f77617361646d696e2f5353505f5349542667743b20636c656172746f6f6c2063617463730d0a636f6465),
('Rational ClearCase', 2, 0, 1219779814, '', 'admin', '168.40.105.128', '', 0x23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d204e45575f56494557402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f75722076696577),
('Rational ClearCase', 3, 0, 1219779858, '', 'admin', '168.40.105.128', '', 0x2d3d4372656174652061206e657720536e617073686f7420566965773d2d0d0a23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d204e45575f56494557402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f75722076696577),
('Rational ClearCase', 4, 0, 1219779941, '', 'admin', '168.40.105.128', '', 0x2d3d4372656174652061206e657720536e617073686f7420566965773d2d0d0a23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d2053545245414d5f4e414d45402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f75722076696577),
('Rational ClearCase', 5, 0, 1219780938, '', 'admin', '168.40.105.128', '', 0x2d3d4372656174652061206e657720536e617073686f7420566965773d2d0d0a23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d2053545245414d5f4e414d45402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f757220766965770d0a0d0a2d3d566965772050726f6a6563742044657461696c733d2d0d0a7b434f444528297d0d0a5b77617361646d696e406965646161753031395d2f686f6d652f77617361646d696e2667743b20636c656172746f6f6c206465736320766f623a2f64656d6f5f70726f6a6563740d0a76657273696f6e6564206f626a6563742062617365202671756f743b2f64656d6f5f70726f6a6563742671756f743b0d0a20206372656174656420323030382d30322d30345431363a33313a31342d3036206279206361666665696e652e732e676f642e446f6d61696e20557365727340374c51313839310d0a20202671756f743b546573742043432050726f6a6563742e2671756f743b0d0a202070726f6a65637420564f420d0a2020564f422066616d696c792066656174757265206c6576656c3a20350d0a2020564f422073746f7261676520686f73743a706174686e616d65202671756f743b566f62426f783a643a5c436c656172436173655f53746f726167655c564f42735c64656d6f5f70726f6a6563742e7662732671756f743b0d0a2020564f422073746f7261676520676c6f62616c20706174686e616d65202671756f743b266c743b6e6f2d67706174682667743b2671756f743b0d0a2020646174616261736520736368656d612076657273696f6e3a2035340d0a20206d6f64696669636174696f6e2062792072656d6f74652070726976696c6567656420757365723a20616c6c6f7765640d0a2020564f42206f776e6572736869703a0d0a202020206f776e6572206e6f626f64790d0a2020202067726f7570206e6f626f64790d0a20204164646974696f6e616c2067726f7570733a0d0a2020202067726f75702074786163636573732e6e65742f636375736572730d0a202070726f6d6f74696f6e206c6576656c733a0d0a2020202052454a45435445440d0a20202020494e495449414c0d0a202020204255494c540d0a202020205445535445440d0a2020202052454c45415345440d0a202064656661756c742070726f6d6f74696f6e206c6576656c3a20494e495449414c0d0a2020417474726962757465733a0d0a20202020466561747572654c6576656c203d20350d0a202048797065726c696e6b733a0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f6363640d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f64616f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f626f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f636f6d706f736974650d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f62617463680d0a7b434f44457d),
('Rational ClearCase', 6, 0, 1219781218, '', 'admin', '168.40.105.128', '', 0x2d3d4372656174652061206e657720536e617073686f7420566965773d2d0d0a23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d2053545245414d5f4e414d45402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c20656463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f757220766965770d0a0d0a2d3d566965772050726f6a6563742044657461696c733d2d0d0a7b434f444528297d0d0a5b77617361646d696e406965646161753031395d2f686f6d652f77617361646d696e2667743b20636c656172746f6f6c206465736320766f623a2f64656d6f5f70726f6a6563740d0a76657273696f6e6564206f626a6563742062617365202671756f743b2f64656d6f5f70726f6a6563742671756f743b0d0a20206372656174656420323030382d30322d30345431363a33313a31342d3036206279206361666665696e652e732e676f642e446f6d61696e20557365727340374c51313839310d0a20202671756f743b546573742043432050726f6a6563742e2671756f743b0d0a202070726f6a65637420564f420d0a2020564f422066616d696c792066656174757265206c6576656c3a20350d0a2020564f422073746f7261676520686f73743a706174686e616d65202671756f743b566f62426f783a643a5c436c656172436173655f53746f726167655c564f42735c64656d6f5f70726f6a6563742e7662732671756f743b0d0a2020564f422073746f7261676520676c6f62616c20706174686e616d65202671756f743b266c743b6e6f2d67706174682667743b2671756f743b0d0a2020646174616261736520736368656d612076657273696f6e3a2035340d0a20206d6f64696669636174696f6e2062792072656d6f74652070726976696c6567656420757365723a20616c6c6f7765640d0a2020564f42206f776e6572736869703a0d0a202020206f776e6572206e6f626f64790d0a2020202067726f7570206e6f626f64790d0a20204164646974696f6e616c2067726f7570733a0d0a2020202067726f75702074786163636573732e6e65742f636375736572730d0a202070726f6d6f74696f6e206c6576656c733a0d0a2020202052454a45435445440d0a20202020494e495449414c0d0a202020204255494c540d0a202020205445535445440d0a2020202052454c45415345440d0a202064656661756c742070726f6d6f74696f6e206c6576656c3a20494e495449414c0d0a2020417474726962757465733a0d0a20202020466561747572654c6576656c203d20350d0a202048797065726c696e6b733a0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f6363640d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f64616f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f626f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f636f6d706f736974650d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f62617463680d0a7b434f44457d);
INSERT INTO `tiki_history` (`pageName`, `version`, `version_minor`, `lastModif`, `description`, `user`, `ip`, `comment`, `data`) VALUES
('Rational ClearCase', 7, 0, 1221506756, '', 'c8h10n4o2', '168.40.104.43', '', 0x2d3d4372656174652061206e657720536e617073686f7420566965773d2d0d0a23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d2053545245414d5f4e414d45402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c20656463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f757220766965770d0a0d0a2d3d566965772050726f6a6563742044657461696c733d2d0d0a7b434f444528297d0d0a5b7573657240626f786e616d655d2f686f6d652f757365722667743b20636c656172746f6f6c206465736320766f623a2f64656d6f5f70726f6a6563740d0a76657273696f6e6564206f626a6563742062617365202671756f743b2f64656d6f5f70726f6a6563742671756f743b0d0a20206372656174656420323030382d30322d30345431363a33313a31342d3036206279206361666665696e652e732e676f642e446f6d61696e20557365727340374c51313839310d0a20202671756f743b546573742043432050726f6a6563742e2671756f743b0d0a202070726f6a65637420564f420d0a2020564f422066616d696c792066656174757265206c6576656c3a20350d0a2020564f422073746f7261676520686f73743a706174686e616d65202671756f743b566f62426f783a643a5c436c656172436173655f53746f726167655c564f42735c64656d6f5f70726f6a6563742e7662732671756f743b0d0a2020564f422073746f7261676520676c6f62616c20706174686e616d65202671756f743b266c743b6e6f2d67706174682667743b2671756f743b0d0a2020646174616261736520736368656d612076657273696f6e3a2035340d0a20206d6f64696669636174696f6e2062792072656d6f74652070726976696c6567656420757365723a20616c6c6f7765640d0a2020564f42206f776e6572736869703a0d0a202020206f776e6572206e6f626f64790d0a2020202067726f7570206e6f626f64790d0a20204164646974696f6e616c2067726f7570733a0d0a2020202067726f757020646f6d61696e2e6e65742f636375736572730d0a202070726f6d6f74696f6e206c6576656c733a0d0a2020202052454a45435445440d0a20202020494e495449414c0d0a202020204255494c540d0a202020205445535445440d0a2020202052454c45415345440d0a202064656661756c742070726f6d6f74696f6e206c6576656c3a20494e495449414c0d0a2020417474726962757465733a0d0a20202020466561747572654c6576656c203d20350d0a202048797065726c696e6b733a0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f6363640d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f64616f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f626f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f636f6d706f736974650d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f62617463680d0a7b434f44457d0d0a0d0a2d3d4c69737420426173656c696e657320696e20612073747265616d3d2d0d0a7b434f444528297d0d0a5b7573657240626f786e616d655d2f686f6d652f757365722667743b202f6f70742f726174696f6e616c2f636c656172636173652f62696e2f636c656172746f6f6c206c73626c202d73202d73747265616d204150505f37332e322e302e305f547374402f4d795f50726f6a656374730d0a4150505f37332e322e302e305f395f345f323030382e353234340d0a323030385f30395f30385f4150505f37332e302e312e305f312e333038370d0a323030392d30392d30395f4150505f5f37332e322e305f322e383432390d0a7b434f44457d),
('Rational ClearCase', 8, 0, 1221507142, '', 'c8h10n4o2', '168.40.104.43', '', 0x2d3d4372656174652061206e657720536e617073686f7420566965773d2d0d0a23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d73747265616d2053545245414d5f4e414d45402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c20656463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f757220766965770d0a5f5f4e4f54453a20596f752063616e20616c736f2075736520636c656172746f6f6c207365746373202f564f425f31202f564f425f325f5f0d0a0d0a2d3d566965772050726f6a6563742044657461696c733d2d0d0a7b434f444528297d0d0a5b7573657240626f786e616d655d2f686f6d652f757365722667743b20636c656172746f6f6c206465736320766f623a2f64656d6f5f70726f6a6563740d0a76657273696f6e6564206f626a6563742062617365202671756f743b2f64656d6f5f70726f6a6563742671756f743b0d0a20206372656174656420323030382d30322d30345431363a33313a31342d3036206279206361666665696e652e732e676f642e446f6d61696e20557365727340374c51313839310d0a20202671756f743b546573742043432050726f6a6563742e2671756f743b0d0a202070726f6a65637420564f420d0a2020564f422066616d696c792066656174757265206c6576656c3a20350d0a2020564f422073746f7261676520686f73743a706174686e616d65202671756f743b566f62426f783a643a5c436c656172436173655f53746f726167655c564f42735c64656d6f5f70726f6a6563742e7662732671756f743b0d0a2020564f422073746f7261676520676c6f62616c20706174686e616d65202671756f743b266c743b6e6f2d67706174682667743b2671756f743b0d0a2020646174616261736520736368656d612076657273696f6e3a2035340d0a20206d6f64696669636174696f6e2062792072656d6f74652070726976696c6567656420757365723a20616c6c6f7765640d0a2020564f42206f776e6572736869703a0d0a202020206f776e6572206e6f626f64790d0a2020202067726f7570206e6f626f64790d0a20204164646974696f6e616c2067726f7570733a0d0a2020202067726f757020646f6d61696e2e6e65742f636375736572730d0a202070726f6d6f74696f6e206c6576656c733a0d0a2020202052454a45435445440d0a20202020494e495449414c0d0a202020204255494c540d0a202020205445535445440d0a2020202052454c45415345440d0a202064656661756c742070726f6d6f74696f6e206c6576656c3a20494e495449414c0d0a2020417474726962757465733a0d0a20202020466561747572654c6576656c203d20350d0a202048797065726c696e6b733a0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f6363640d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f64616f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f626f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f636f6d706f736974650d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f62617463680d0a7b434f44457d0d0a0d0a2d3d4c69737420426173656c696e657320696e20612073747265616d3d2d0d0a7b434f444528297d0d0a5b7573657240626f786e616d655d2f686f6d652f757365722667743b202f6f70742f726174696f6e616c2f636c656172636173652f62696e2f636c656172746f6f6c206c73626c202d73202d73747265616d204150505f37332e322e302e305f547374402f4d795f50726f6a656374730d0a4150505f37332e322e302e305f395f345f323030382e353234340d0a323030385f30395f30385f4150505f37332e302e312e305f312e333038370d0a323030392d30392d30395f4150505f5f37332e322e305f322e383432390d0a7b434f44457d),
('Rational ClearCase', 9, 0, 1221570512, '', 'c8h10n4o2', '66.68.52.223', '', 0x2d3d4372656174652061206e657720536e617073686f7420566965773d2d0d0a23636c656172636173652063726561746520766965770d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722667743b636c656172746f6f6c206d6b76696577202d736e6170202d7374676c6f6320636c656172636173655f686f6d655f6363737467202d73747265616d2053545245414d5f4e414d45402f44435f50726f6a65637473204e45575f564945570d0a7b434f44457d0d0a23676f20696e746f20616e6f74686572207669657720616e6420636865636b206f75742074686520636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b20636c656172746f6f6c2063617463730d0a7b434f44457d0d0a2b2a54686973206769766573206d653a0d0a2b7b434f444528297d0d0a75636d0d0a6964656e746974792055434d2e53747265616d0d0a6f69643a62373031363230632e38386536343636372e613166612e34613a36343a30613a35353a65363a633040766f62757569643a65303032336539392e35656263343237352e610d0a3063332e34333a39353a65653a64643a66313a30642031390d0a0d0a23204f4e4c592045444954205448495320434f4e464947205350454320494e2054484520494e44494341544544202671756f743b435553544f4d2671756f743b2041524541530d0a230d0a23205468697320636f6e666967207370656320776173206175746f6d61746963616c6c792067656e657261746564206279207468652055434d2073747265616d0d0a23202671756f743b4558495354494e475f564945572671756f743b20617420323030382d30382d30345431303a32323a33372d30352e0d0a230d0a0d0a0d0a0d0a232053656c65637420636865636b6564206f75742076657273696f6e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200d0a656c656d656e74202a20434845434b45444f55540d0a0d0a2320436f6d706f6e656e742073656c656374696f6e2072756c65732e2e2e0d0a0d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a2e2e2e2f4558495354494e475f564945572f4c41544553540d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b0d0a323030382d30382d30345f564f425f325f37322e322e31302e37313639202d6d6b6272616e6368204558495354494e475f564945570d0a656c656d656e74202671756f743b5b37363365346165656537373434666130626432313662316332303036363062383d5c564f425f325d2f2e2e2e2671756f743b202f6d61696e2f300d0a2d6d6b6272616e6368204558495354494e475f564945570d0a0d0a656c656d656e74202671756f743b5b65336239643832356335653134663030393230393435373664636138383231643d5c564f425f315d2f2e2e2e2671756f743b0d0a417263685f395f32305f323030375f6669785f33202d6e6f636865636b6f75740d0a0d0a0d0a656e642075636d0d0a0d0a2355434d437573746f6d456c656d426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d20454c454d454e542052554c45532041465445520d0a54484953204c494e450d0a2355434d437573746f6d456c656d456e64202d20444f204e4f542052454d4f5645202d20454e4420435553544f4d20454c454d454e542052554c45530d0a0d0a23204e6f6e2d696e636c7564656420636f6d706f6e656e74206261636b73746f702072756c653a206e6f20636865636b6f7574730d0a656c656d656e74202a202f6d61696e2f30202d75636d202d6e6f636865636b6f75740d0a0d0a2355434d437573746f6d4c6f6164426567696e202d20444f204e4f542052454d4f5645202d2041444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e450d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23436f707920746865206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a2b7b434f444528297d0d0a6c6f6164202f564f425f310d0a6c6f6164202f564f425f320d0a7b434f44457d0d0a23434420696e746f206261636b20696e746f2074686520646972206f6620746865207669657720796f7520637265617465640d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4558495354494e475f564945572667743b206364202e2e2f4e45575f564945570d0a7b434f44457d0d0a234564697420796f7572206e65772076696577277320636f6e66696720737065630d0a2b7b434f444528297d0d0a5b756e69787573657240756e6978626f785d2f686f6d652f756e6978757365722f4e45575f564945572667743b20636c656172746f6f6c20656463730d0a7b434f44457d0d0a235061737465207468652074776f20636f70696564206c696e657320756e646572205f5f41444420435553544f4d204c4f41442052554c45532041465445522054484953204c494e455f5f0d0a235361766520796f75722066696c650d0a2b7b434f444528297d0d0a3a77710d0a7b434f44457d0d0a235768656e20796f7520736176652c2069742077696c6c2075706461746520796f757220766965770d0a5f5f4e4f54453a20596f752063616e20616c736f2075736520636c656172746f6f6c207365746373202f564f425f31202f564f425f325f5f0d0a0d0a2d3d566965772050726f6a6563742044657461696c733d2d0d0a7b434f444528297d0d0a5b7573657240626f786e616d655d2f686f6d652f757365722667743b20636c656172746f6f6c206465736320766f623a2f64656d6f5f70726f6a6563740d0a76657273696f6e6564206f626a6563742062617365202671756f743b2f64656d6f5f70726f6a6563742671756f743b0d0a20206372656174656420323030382d30322d30345431363a33313a31342d3036206279206361666665696e652e732e676f642e446f6d61696e20557365727340374c51313839310d0a20202671756f743b546573742043432050726f6a6563742e2671756f743b0d0a202070726f6a65637420564f420d0a2020564f422066616d696c792066656174757265206c6576656c3a20350d0a2020564f422073746f7261676520686f73743a706174686e616d65202671756f743b566f62426f783a643a5c436c656172436173655f53746f726167655c564f42735c64656d6f5f70726f6a6563742e7662732671756f743b0d0a2020564f422073746f7261676520676c6f62616c20706174686e616d65202671756f743b266c743b6e6f2d67706174682667743b2671756f743b0d0a2020646174616261736520736368656d612076657273696f6e3a2035340d0a20206d6f64696669636174696f6e2062792072656d6f74652070726976696c6567656420757365723a20616c6c6f7765640d0a2020564f42206f776e6572736869703a0d0a202020206f776e6572206e6f626f64790d0a2020202067726f7570206e6f626f64790d0a20204164646974696f6e616c2067726f7570733a0d0a2020202067726f757020646f6d61696e2e6e65742f636375736572730d0a202070726f6d6f74696f6e206c6576656c733a0d0a2020202052454a45435445440d0a20202020494e495449414c0d0a202020204255494c540d0a202020205445535445440d0a2020202052454c45415345440d0a202064656661756c742070726f6d6f74696f6e206c6576656c3a20494e495449414c0d0a2020417474726962757465733a0d0a20202020466561747572654c6576656c203d20350d0a202048797065726c696e6b733a0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f6363640d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f64616f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f626f0d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f636f6d706f736974650d0a2020202041646d696e564f4220266c743b2d20766f623a2f64656d6f5f62617463680d0a7b434f44457d0d0a0d0a2d3d4c69737420426173656c696e657320696e20612073747265616d3d2d0d0a7b434f444528297d0d0a5b7573657240626f786e616d655d2f686f6d652f757365722667743b202f6f70742f726174696f6e616c2f636c656172636173652f62696e2f636c656172746f6f6c206c73626c202d73202d73747265616d204150505f37332e322e302e305f547374402f4d795f50726f6a656374730d0a4150505f37332e322e302e305f395f345f323030382e353234340d0a323030385f30395f30385f4150505f37332e302e312e305f312e333038370d0a323030392d30392d30395f4150505f5f37332e322e305f322e383432390d0a7b434f44457d),
('System', 7, 0, 1194751852, '', 'c8h10n4o2', '66.68.51.87', '', 0x2d3d54696d652053797374656d20486173206265656e2055703d2d0d0a757074696d650d0a0d0a2d3d4e756d626572206f662043505527733d2d0d0a707372696e666f0d0a0d0a2d3d4b65726e656c2056657273696f6e3d2d0d0a756e616d65202d720d0a0d0a2d3d43726561746520612053796d626f6c6963204c696e6b3d2d0d0a6c6e202d7320266c743b544152474554204449524543544f5259204f522046494c452667743b202e2f266c743b53484f52544355542667743b0d0a0d0a466f72206578616d706c653a0d0a0d0a6c6e202d73202f7573722f6c6f63616c2f6170616368652f6c6f6773202e2f6c6f67730d0a0d0a2d3d476574205562756e74752056657273696f6e3d2d0d0a6d6f7265202f6574632f6c73622d72656c656173650d0a0d0a2d3d53686f77206c6f636174696f6e206f662066696c653d2d0d0a63386831306e346f32406a616d65733a2f6d656469612f736462312f70686f746f6772617068732f32303037242074797065207468756e646572626972640d0a7468756e64657262697264206973202f7573722f62696e2f7468756e646572626972640d0a0d0a2d3d4c697374206f6e6c79206469726563746f72696573206f662063757272656e74206469723d2d0d0a6c73202d6c207c206772657020275e6427);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_hotwords`
--

CREATE TABLE IF NOT EXISTS `tiki_hotwords` (
  `word` varchar(40) NOT NULL default '',
  `url` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`word`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_hotwords`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_html_pages`
--

CREATE TABLE IF NOT EXISTS `tiki_html_pages` (
  `pageName` varchar(200) NOT NULL default '',
  `content` longblob,
  `refresh` int(10) default NULL,
  `type` char(1) default NULL,
  `created` int(14) default NULL,
  PRIMARY KEY  (`pageName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_html_pages`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_html_pages_dynamic_zones`
--

CREATE TABLE IF NOT EXISTS `tiki_html_pages_dynamic_zones` (
  `pageName` varchar(40) NOT NULL default '',
  `zone` varchar(80) NOT NULL default '',
  `type` char(2) default NULL,
  `content` text,
  PRIMARY KEY  (`pageName`,`zone`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_html_pages_dynamic_zones`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_images`
--

CREATE TABLE IF NOT EXISTS `tiki_images` (
  `imageId` int(14) NOT NULL auto_increment,
  `galleryId` int(14) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `description` text,
  `lon` float default NULL,
  `lat` float default NULL,
  `created` int(14) default NULL,
  `user` varchar(40) default NULL,
  `hits` int(14) default NULL,
  `path` varchar(255) default NULL,
  PRIMARY KEY  (`imageId`),
  KEY `name` (`name`),
  KEY `description` (`description`(255)),
  KEY `hits` (`hits`),
  KEY `ti_gId` (`galleryId`),
  KEY `ti_cr` (`created`),
  KEY `ti_us` (`user`),
  FULLTEXT KEY `ft` (`name`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_images`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_images_data`
--

CREATE TABLE IF NOT EXISTS `tiki_images_data` (
  `imageId` int(14) NOT NULL default '0',
  `xsize` int(8) NOT NULL default '0',
  `ysize` int(8) NOT NULL default '0',
  `type` char(1) NOT NULL default '',
  `filesize` int(14) default NULL,
  `filetype` varchar(80) default NULL,
  `filename` varchar(80) default NULL,
  `data` longblob,
  `etag` varchar(32) default NULL,
  PRIMARY KEY  (`imageId`,`xsize`,`ysize`,`type`),
  KEY `t_i_d_it` (`imageId`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_images_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_integrator_reps`
--

CREATE TABLE IF NOT EXISTS `tiki_integrator_reps` (
  `repID` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `path` varchar(255) NOT NULL default '',
  `start_page` varchar(255) NOT NULL default '',
  `css_file` varchar(255) NOT NULL default '',
  `visibility` char(1) NOT NULL default 'y',
  `cacheable` char(1) NOT NULL default 'y',
  `expiration` int(11) NOT NULL default '0',
  `description` text NOT NULL,
  PRIMARY KEY  (`repID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tiki_integrator_reps`
--

INSERT INTO `tiki_integrator_reps` (`repID`, `name`, `path`, `start_page`, `css_file`, `visibility`, `cacheable`, `expiration`, `description`) VALUES
(1, 'Doxygened (1.3.4) Documentation', '', 'index.html', 'doxygen.css', 'n', 'y', 0, 'Use this repository as rule source for all your repositories based on doxygened docs. To setup yours just add new repository and copy rules from this repository :)');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_integrator_rules`
--

CREATE TABLE IF NOT EXISTS `tiki_integrator_rules` (
  `ruleID` int(11) NOT NULL auto_increment,
  `repID` int(11) NOT NULL default '0',
  `ord` int(2) unsigned NOT NULL default '0',
  `srch` blob NOT NULL,
  `repl` blob NOT NULL,
  `type` char(1) NOT NULL default 'n',
  `casesense` char(1) NOT NULL default 'y',
  `rxmod` varchar(20) NOT NULL default '',
  `enabled` char(1) NOT NULL default 'n',
  `description` text NOT NULL,
  PRIMARY KEY  (`ruleID`),
  KEY `repID` (`repID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tiki_integrator_rules`
--

INSERT INTO `tiki_integrator_rules` (`ruleID`, `repID`, `ord`, `srch`, `repl`, `type`, `casesense`, `rxmod`, `enabled`, `description`) VALUES
(1, 1, 1, 0x2e2a3c626f64795b5e3e5d2a3f3e282e2a3f293c2f626f64792e2a, 0x31, 'y', 'n', 'i', 'y', 'Extract code between <BODY> tags'),
(2, 1, 2, 0x696d67207372633d28227c2729283f21687474703a2f2f29, 0x696d67207372633d317b706174687d2f, 'y', 'n', 'i', 'y', 'Fix images path'),
(3, 1, 3, 0x687265663d28227c2729283f2128237c28687474707c667470293a2f2f2929, 0x687265663d3174696b692d696e7465677261746f722e7068703f72657049443d7b72657049447d2666696c653d, 'y', 'n', 'i', 'y', 'Relace internal links to integrator. Dont touch an external links.');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_language`
--

CREATE TABLE IF NOT EXISTS `tiki_language` (
  `source` tinyblob NOT NULL,
  `lang` varchar(16) NOT NULL default '',
  `tran` tinyblob,
  PRIMARY KEY  (`source`(255),`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_language`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_languages`
--

CREATE TABLE IF NOT EXISTS `tiki_languages` (
  `lang` varchar(16) NOT NULL default '',
  `language` varchar(255) default NULL,
  PRIMARY KEY  (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_languages`
--

INSERT INTO `tiki_languages` (`lang`, `language`) VALUES
('en', 'English');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_link_cache`
--

CREATE TABLE IF NOT EXISTS `tiki_link_cache` (
  `cacheId` int(14) NOT NULL auto_increment,
  `url` varchar(250) default NULL,
  `data` longblob,
  `refresh` int(14) default NULL,
  PRIMARY KEY  (`cacheId`),
  KEY `urlindex` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_link_cache`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_links`
--

CREATE TABLE IF NOT EXISTS `tiki_links` (
  `fromPage` varchar(160) NOT NULL default '',
  `toPage` varchar(160) NOT NULL default '',
  PRIMARY KEY  (`fromPage`,`toPage`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_links`
--

INSERT INTO `tiki_links` (`fromPage`, `toPage`) VALUES
('Gateway m675x Radeon 9700m Ubuntu Setup', 'EndSection'),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'Ubuntu_Edgy_Installation_Guide'),
('HomePage', 'Linux'),
('HomePage', 'OS X'),
('HomePage', 'PERL_Code'),
('HomePage', 'PHP'),
('HomePage', 'Quotes'),
('HomePage', 'Rational ClearCase'),
('HomePage', 'Subversion'),
('HomePage', 'WebSphere'),
('Linux', 'File System'),
('Linux', 'Gateway m675x Radeon 9700m Ubuntu Setup'),
('Linux', 'Highpoint RocketRAID 1820A with Ubuntu'),
('Linux', 'Maintain Users'),
('Linux', 'Networking'),
('Linux', 'Running Processes'),
('Linux', 'Samba'),
('Linux', 'Scripting'),
('Linux', 'Searching'),
('Linux', 'Send Email'),
('Linux', 'System'),
('Linux', 'Treo 650 setup with Ubuntu'),
('Linux', 'Ubuntu'),
('PERL_Code', 'ArraySize'),
('PERL_Code', 'CurrentDate'),
('PERL_Code', 'CurrentTime'),
('Rational ClearCase', 'CustomElemBegin'),
('Rational ClearCase', 'CustomElemEnd'),
('Rational ClearCase', 'CustomLoadBegin'),
('Rational ClearCase', 'C_Projects'),
('Rational ClearCase', 'FeatureLevel'),
('Rational ClearCase', 'My_Projects'),
('Samba', 'Faculty_Materials'),
('Subversion', 'A-Simple-Way-to-Backup-and-Restore-a-Subversion-Repository'),
('Subversion', 'AuthName'),
('Subversion', 'AuthType'),
('Subversion', 'AuthUserFile'),
('Subversion', 'BackupFile'),
('Subversion', 'CodeFez'),
('Subversion', 'MyRepository'),
('Subversion', 'S-Book'),
('Subversion', 'S-Dev'),
('Treo 650 setup with Ubuntu', 'HotSync'),
('WebSphere', 'WebSphere');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_live_support_events`
--

CREATE TABLE IF NOT EXISTS `tiki_live_support_events` (
  `eventId` int(14) NOT NULL auto_increment,
  `reqId` varchar(32) NOT NULL default '',
  `type` varchar(40) default NULL,
  `seqId` int(14) default NULL,
  `senderId` varchar(32) default NULL,
  `data` text,
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`eventId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_live_support_events`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_live_support_message_comments`
--

CREATE TABLE IF NOT EXISTS `tiki_live_support_message_comments` (
  `cId` int(12) NOT NULL auto_increment,
  `msgId` int(12) default NULL,
  `data` text,
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`cId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_live_support_message_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_live_support_messages`
--

CREATE TABLE IF NOT EXISTS `tiki_live_support_messages` (
  `msgId` int(12) NOT NULL auto_increment,
  `data` text,
  `timestamp` int(14) default NULL,
  `user` varchar(40) default NULL,
  `username` varchar(200) default NULL,
  `priority` int(2) default NULL,
  `status` char(1) default NULL,
  `assigned_to` varchar(200) default NULL,
  `resolution` varchar(100) default NULL,
  `title` varchar(200) default NULL,
  `module` int(4) default NULL,
  `email` varchar(250) default NULL,
  PRIMARY KEY  (`msgId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_live_support_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_live_support_modules`
--

CREATE TABLE IF NOT EXISTS `tiki_live_support_modules` (
  `modId` int(4) NOT NULL auto_increment,
  `name` varchar(90) default NULL,
  PRIMARY KEY  (`modId`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `tiki_live_support_modules`
--

INSERT INTO `tiki_live_support_modules` (`modId`, `name`) VALUES
(1, 'wiki'),
(2, 'forums'),
(3, 'image galleries'),
(4, 'file galleries'),
(5, 'directory'),
(6, 'workflow'),
(7, 'charts');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_live_support_operators`
--

CREATE TABLE IF NOT EXISTS `tiki_live_support_operators` (
  `user` varchar(40) NOT NULL default '',
  `accepted_requests` int(10) default NULL,
  `status` varchar(20) default NULL,
  `longest_chat` int(10) default NULL,
  `shortest_chat` int(10) default NULL,
  `average_chat` int(10) default NULL,
  `last_chat` int(14) default NULL,
  `time_online` int(10) default NULL,
  `votes` int(10) default NULL,
  `points` int(10) default NULL,
  `status_since` int(14) default NULL,
  PRIMARY KEY  (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_live_support_operators`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_live_support_requests`
--

CREATE TABLE IF NOT EXISTS `tiki_live_support_requests` (
  `reqId` varchar(32) NOT NULL default '',
  `user` varchar(40) default NULL,
  `tiki_user` varchar(200) default NULL,
  `email` varchar(200) default NULL,
  `operator` varchar(200) default NULL,
  `operator_id` varchar(32) default NULL,
  `user_id` varchar(32) default NULL,
  `reason` text,
  `req_timestamp` int(14) default NULL,
  `timestamp` int(14) default NULL,
  `status` varchar(40) default NULL,
  `resolution` varchar(40) default NULL,
  `chat_started` int(14) default NULL,
  `chat_ended` int(14) default NULL,
  PRIMARY KEY  (`reqId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_live_support_requests`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_logs`
--

CREATE TABLE IF NOT EXISTS `tiki_logs` (
  `logId` int(8) NOT NULL auto_increment,
  `logtype` varchar(20) NOT NULL default '',
  `logmessage` text NOT NULL,
  `loguser` varchar(40) NOT NULL default '',
  `logip` varchar(200) NOT NULL default '',
  `logclient` text NOT NULL,
  `logtime` int(14) NOT NULL default '0',
  PRIMARY KEY  (`logId`),
  KEY `logtype` (`logtype`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=249 ;

--
-- Dumping data for table `tiki_logs`
--

INSERT INTO `tiki_logs` (`logId`, `logtype`, `logmessage`, `loguser`, `logip`, `logclient`, `logtime`) VALUES
(1, 'login', 'logged from /tiki-admin.php', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181916086),
(2, 'login', 'logged out', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181916599),
(3, 'login', 'logged from /tiki-index.php', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181916638),
(4, 'login', 'logged out', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917011),
(5, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917017),
(6, 'login', 'logged out', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917034),
(7, 'login', 'logged from /tiki-index.php', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917039),
(8, 'login', 'logged out', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917064),
(9, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917070),
(10, 'login', 'logged out', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917181),
(11, 'login', 'logged from /tiki-index.php', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181917187),
(12, 'login', 'logged out', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181921825),
(13, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181921830),
(14, 'login', 'logged out', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181922731),
(15, 'login', 'logged from /tiki-index.php', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181922738),
(16, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(17, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(18, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(19, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(20, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(21, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(22, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(23, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(24, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(25, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(26, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(27, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(28, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(29, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(30, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(31, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(32, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(33, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(34, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(35, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(36, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(37, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(38, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(39, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(40, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(41, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(42, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(43, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(44, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(45, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(46, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(47, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(48, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(49, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(50, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(51, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(52, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(53, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(54, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(55, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(56, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(57, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(58, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(59, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(60, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(61, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(62, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(63, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(64, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(65, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(66, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(67, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(68, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(69, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(70, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(71, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(72, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(73, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(74, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(75, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(76, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(77, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(78, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(79, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(80, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(81, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(82, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(83, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(84, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(85, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(86, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(87, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(88, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(89, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(90, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(91, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(92, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(93, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(94, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(95, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(96, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(97, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(98, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(99, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(100, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(101, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(102, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(103, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(104, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(105, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(106, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(107, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(108, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(109, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(110, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(111, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(112, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(113, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(114, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(115, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(116, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(117, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(118, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(119, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(120, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(121, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(122, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(123, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(124, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(125, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(126, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(127, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(128, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(129, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(130, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(131, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(132, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(133, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(134, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(135, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(136, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(137, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(138, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(139, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(140, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(141, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(142, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(143, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(144, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(145, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(146, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(147, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(148, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(149, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(150, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(151, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(152, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(153, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(154, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(155, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(156, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(157, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(158, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(159, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(160, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(161, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(162, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(163, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(164, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(165, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(166, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(167, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(168, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(169, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(170, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(171, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(172, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(173, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(174, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(175, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(176, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(177, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(178, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(179, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(180, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(181, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(182, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(183, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(184, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(185, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(186, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(187, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(188, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(189, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(190, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(191, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(192, 'perms', 'changed perms for group Registered', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923758),
(193, 'login', 'logged out', 'admin', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923824),
(194, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181923830),
(195, 'login', 'logged out', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1181924233),
(196, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '168.56.37.8', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)', 1181924258),
(197, 'login', 'logged out', 'c8h10n4o2', '168.56.37.8', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)', 1181936491),
(198, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1182130069),
(199, 'login', 'logged from /tiki-pagehistory.php?page=System&source=0', 'c8h10n4o2', '168.56.37.8', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070508 Firefox/1.5.0.12', 1182181560),
(200, 'login', 'logged from /tiki-pagehistory.php?page=HomePage&source=0', 'c8h10n4o2', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1182481568),
(201, 'login', 'logged out', 'c8h10n4o2', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1182482680),
(202, 'login', 'logged from /tiki-index.php', 'admin', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1182482686),
(203, 'login', 'logged out', 'admin', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1182482858),
(204, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1182482860),
(205, 'login', 'logged out', 'c8h10n4o2', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1182564689),
(206, 'login', 'logged from /tiki-index.php?page=Linux', 'c8h10n4o2', '66.68.76.76', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4', 1183346895),
(207, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '72.255.27.197', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20061201 Firefox/2.0.0.4 (Ubuntu-feisty)', 1183719353),
(208, 'login', 'logged from /tiki-index.php?page=Linux', 'c8h10n4o2', '72.255.68.35', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20061201 Firefox/2.0.0.4 (Ubuntu-feisty)', 1183724875),
(209, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '72.255.19.226', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20061201 Firefox/2.0.0.4 (Ubuntu-feisty)', 1184281544),
(210, 'login', 'logged from /tiki-index.php?page=Linux', 'c8h10n4o2', '72.255.41.15', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20061201 Firefox/2.0.0.4 (Ubuntu-feisty)', 1185066660),
(211, 'login', 'logged from /tiki-index.php?page=Linux', 'c8h10n4o2', '72.255.41.15', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20061201 Firefox/2.0.0.4 (Ubuntu-feisty)', 1185113432),
(212, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '72.255.3.164', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20061201 Firefox/2.0.0.5 (Ubuntu-feisty)', 1185223327),
(213, 'login', 'logged from /tiki-index.php?page=Subversion', 'c8h10n4o2', '66.68.76.76', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20061201 Firefox/2.0.0.5 (Ubuntu-feisty)', 1186712672),
(214, 'login', 'logged from /tiki-index.php?page=Linux', 'c8h10n4o2', '72.177.2.140', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6', 1188225116),
(215, 'login', 'logged out', 'c8h10n4o2', '72.177.2.140', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6', 1188225188),
(216, 'login', 'logged from /tiki-index.php', 'admin', '72.177.2.140', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6', 1188225205),
(217, 'adminusers', '', 'changed password for c8h10n4o2', '72.177.2.140', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6', 1188225230),
(218, 'login', 'logged out', 'admin', '72.177.2.140', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6', 1188225236),
(219, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '24.153.198.63', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20061201 Firefox/2.0.0.6 (Ubuntu-feisty)', 1191509874),
(220, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '72.177.2.140', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20061201 Firefox/2.0.0.6 (Ubuntu-feisty)', 1192106911),
(221, 'login', 'logged from /tiki-index.php?page=Networking', 'c8h10n4o2', '24.153.198.63', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20061201 Firefox/2.0.0.6 (Ubuntu-feisty)', 1192113360),
(222, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '24.153.198.63', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8) Gecko/20061201 Firefox/2.0.0.8 (Ubuntu-feisty)', 1193412712),
(223, 'login', 'logged from /tiki-pagehistory.php?page=Searching&source=0', 'c8h10n4o2', '152.216.7.5', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8', 1193669941),
(224, 'login', 'logged from /tiki-index.php?page=Searching', 'c8h10n4o2', '24.153.198.63', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8) Gecko/20071022 Ubuntu/7.10 (gutsy) Firefox/2.0.0.8', 1193670661),
(225, 'login', 'logged from /tiki-index.php?page=Linux', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8) Gecko/20071022 Ubuntu/7.10 (gutsy) Firefox/2.0.0.8', 1194749552),
(226, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.7) Gecko/20070914 Firefox/2.0.0.7', 1195311493),
(227, 'login', 'logged from /tiki-pagehistory.php?page=Linux&source=0', 'c8h10n4o2', '24.153.198.63', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071204 Ubuntu/7.10 (gutsy) Firefox/2.0.0.11', 1199380404),
(228, 'login', 'logged from /tiki-index.php?page=File+System', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071204 Ubuntu/7.10 (gutsy) Firefox/2.0.0.11', 1199452086),
(229, 'login', 'logged from /tiki-index.php?page=Subversion', 'c8h10n4o2', '24.153.198.63', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071204 Ubuntu/7.10 (gutsy) Firefox/2.0.0.11', 1199555601),
(230, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071204 Ubuntu/7.10 (gutsy) Firefox/2.0.0.11', 1202267698),
(231, 'login', 'logged from /tiki-index.php?page=Linux', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 1203655549),
(232, 'login', 'logged from /tiki-index.php?page=Networking', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 1203736296),
(233, 'login', 'logged from /tiki-editpage.php?page=RocketRaid', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 1203777387),
(234, 'login', 'logged out', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 1203781968),
(235, 'login', 'logged from /tiki-index.php', 'admin', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 1203781987),
(236, 'login', 'logged out', 'admin', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 1203782174),
(237, 'login', 'logged from /tiki-index.php?page=Networking', 'c8h10n4o2', '66.68.51.87', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 1204506861),
(238, 'login', 'logged from /tiki-index.php', 'c8h10n4o2', '66.68.52.223', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14', 1211421793),
(239, 'login', 'logged from /tiki-index.php', 'admin', '168.40.104.43', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1219767416),
(240, 'adminusers', '', 'changed password for c8h10n4o2', '168.40.104.43', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1219767469),
(241, 'adminusers', '', 'changed email for c8h10n4o2 from jsandli', '168.40.104.43', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1219767469),
(242, 'login', 'logged out', 'admin', '168.40.104.43', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1219767482),
(243, 'login', 'logged from tiki-index.php', 'c8h10n4o2', '168.40.104.46', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1219773835),
(244, 'login', 'logged from /tiki-index.php?page=HomePage', 'admin', '168.40.105.128', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1219778680),
(245, 'login', 'logged from /tiki-index.php?page=Rational+ClearCase', 'c8h10n4o2', '168.40.104.43', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1221506572),
(246, 'login', 'logged from /tiki-editpage.php?page=Rational%20ClearCase', 'c8h10n4o2', '66.68.52.223', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1221570303),
(247, 'login', 'logged from /tiki-index.php?page=Rational+ClearCase', 'c8h10n4o2', '168.40.105.128', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1222112879),
(248, 'login', 'logged from /tiki-index.php?page=System', 'c8h10n4o2', '168.40.106.255', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1', 1222973145);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_mail_events`
--

CREATE TABLE IF NOT EXISTS `tiki_mail_events` (
  `event` varchar(200) default NULL,
  `object` varchar(200) default NULL,
  `email` varchar(200) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_mail_events`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_mailin_accounts`
--

CREATE TABLE IF NOT EXISTS `tiki_mailin_accounts` (
  `accountId` int(12) NOT NULL auto_increment,
  `user` varchar(40) NOT NULL default '',
  `account` varchar(50) NOT NULL default '',
  `pop` varchar(255) default NULL,
  `port` int(4) default NULL,
  `username` varchar(100) default NULL,
  `pass` varchar(100) default NULL,
  `active` char(1) default NULL,
  `type` varchar(40) default NULL,
  `smtp` varchar(255) default NULL,
  `useAuth` char(1) default NULL,
  `smtpPort` int(4) default NULL,
  `anonymous` char(1) NOT NULL default 'y',
  `attachments` char(1) NOT NULL default 'n',
  `article_topicId` int(4) default NULL,
  `article_type` varchar(50) default NULL,
  `discard_after` varchar(255) default NULL,
  PRIMARY KEY  (`accountId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_mailin_accounts`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_menu_languages`
--

CREATE TABLE IF NOT EXISTS `tiki_menu_languages` (
  `menuId` int(8) NOT NULL auto_increment,
  `language` char(16) NOT NULL default '',
  PRIMARY KEY  (`menuId`,`language`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_menu_languages`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_menu_options`
--

CREATE TABLE IF NOT EXISTS `tiki_menu_options` (
  `optionId` int(8) NOT NULL auto_increment,
  `menuId` int(8) default NULL,
  `type` char(1) default NULL,
  `name` varchar(200) default NULL,
  `url` varchar(255) default NULL,
  `position` int(4) default NULL,
  `section` varchar(255) default NULL,
  `perm` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  PRIMARY KEY  (`optionId`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=171 ;

--
-- Dumping data for table `tiki_menu_options`
--

INSERT INTO `tiki_menu_options` (`optionId`, `menuId`, `type`, `name`, `url`, `position`, `section`, `perm`, `groupname`) VALUES
(1, 42, 'o', 'Home', 'tiki-index.php', 10, '', '', ''),
(2, 42, 'o', 'Chat', 'tiki-chat.php', 15, 'feature_chat', 'tiki_p_chat', ''),
(3, 42, 'o', 'Contact us', 'tiki-contact.php', 20, 'feature_contact', '', ''),
(4, 42, 'o', 'Stats', 'tiki-stats.php', 23, 'feature_stats', 'tiki_p_view_stats', ''),
(5, 42, 'o', 'Categories', 'tiki-browse_categories.php', 25, 'feature_categories', 'tiki_p_view_categories', ''),
(6, 42, 'o', 'Games', 'tiki-list_games.php', 30, 'feature_games', 'tiki_p_play_games', ''),
(7, 42, 'o', 'Calendar', 'tiki-calendar.php', 35, 'feature_calendar', 'tiki_p_view_calendar', ''),
(8, 42, 'o', 'Mobile', 'tiki-mobile.php', 37, 'feature_mobile', '', ''),
(9, 42, 'o', '(debug)', 'javascript:toggle("debugconsole")', 40, 'feature_debug_console', 'tiki_p_admin', ''),
(10, 42, 's', 'MyTiki', 'tiki-my_tiki.php', 50, '', '', 'Registered'),
(11, 42, 'o', 'MyTiki home', 'tiki-my_tiki.php', 51, '', '', 'Registered'),
(12, 42, 'o', 'Preferences', 'tiki-user_preferences.php', 55, 'feature_userPreferences', '', 'Registered'),
(13, 42, 'o', 'Messages', 'messu-mailbox.php', 60, 'feature_messages', 'tiki_p_messages', 'Registered'),
(14, 42, 'o', 'Tasks', 'tiki-user_tasks.php', 65, 'feature_tasks', 'tiki_p_tasks', 'Registered'),
(15, 42, 'o', 'Bookmarks', 'tiki-user_bookmarks.php', 70, 'feature_user_bookmarks', 'tiki_p_create_bookmarks', 'Registered'),
(16, 42, 'o', 'Modules', 'tiki-user_assigned_modules.php', 75, 'user_assigned_modules', 'tiki_p_configure_modules', 'Registered'),
(17, 42, 'o', 'Newsreader', 'tiki-newsreader_servers.php', 80, 'feature_newsreader', 'tiki_p_newsreader', 'Registered'),
(18, 42, 'o', 'Webmail', 'tiki-webmail.php', 85, 'feature_webmail', 'tiki_p_use_webmail', 'Registered'),
(19, 42, 'o', 'Notepad', 'tiki-notepad_list.php', 90, 'feature_notepad', 'tiki_p_notepad', 'Registered'),
(20, 42, 'o', 'My files', 'tiki-userfiles.php', 95, 'feature_userfiles', 'tiki_p_userfiles', 'Registered'),
(21, 42, 'o', 'User menu', 'tiki-usermenu.php', 100, 'feature_usermenu', '', 'Registered'),
(22, 42, 'o', 'Mini calendar', 'tiki-minical.php', 105, 'feature_minical', '', 'Registered'),
(23, 42, 'o', 'My watches', 'tiki-user_watches.php', 110, 'feature_user_watches', '', 'Registered'),
(24, 42, 's', 'Workflow', 'tiki-g-user_processes.php', 150, 'feature_workflow', 'tiki_p_use_workflow', ''),
(25, 42, 'o', 'Admin processes', 'tiki-g-admin_processes.php', 155, 'feature_workflow', 'tiki_p_admin_workflow', ''),
(26, 42, 'o', 'Monitor processes', 'tiki-g-monitor_processes.php', 160, 'feature_workflow', 'tiki_p_admin_workflow', ''),
(27, 42, 'o', 'Monitor activities', 'tiki-g-monitor_activities.php', 165, 'feature_workflow', 'tiki_p_admin_workflow', ''),
(28, 42, 'o', 'Monitor instances', 'tiki-g-monitor_instances.php', 170, 'feature_workflow', 'tiki_p_admin_workflow', ''),
(29, 42, 'o', 'User processes', 'tiki-g-user_processes.php', 175, 'feature_workflow', 'tiki_p_use_workflow', ''),
(30, 42, 'o', 'User activities', 'tiki-g-user_activities.php', 180, 'feature_workflow', 'tiki_p_use_workflow', ''),
(31, 42, 'o', 'User instances', 'tiki-g-user_instances.php', 185, 'feature_workflow', 'tiki_p_use_workflow', ''),
(32, 42, 's', 'Community', 'tiki-list_users.php', 187, 'feature_friends', 'tiki_p_list_users', ''),
(33, 42, 'o', 'User list', 'tiki-list_users.php', 188, 'feature_friends', 'tiki_p_list_users', ''),
(34, 42, 'o', 'Friendship Network', 'tiki-friends.php', 189, 'feature_friends', '', ''),
(35, 42, 's', 'Wiki', 'tiki-index.php', 200, 'feature_wiki', 'tiki_p_view', ''),
(36, 42, 'o', 'Wiki Home', 'tiki-index.php', 202, 'feature_wiki', 'tiki_p_view', ''),
(37, 42, 'o', 'Last Changes', 'tiki-lastchanges.php', 205, 'feature_wiki,feature_lastChanges', 'tiki_p_view', ''),
(38, 42, 'o', 'Dump', 'dump/new.tar', 210, 'feature_wiki,feature_dump', 'tiki_p_view', ''),
(39, 42, 'o', 'Rankings', 'tiki-wiki_rankings.php', 215, 'feature_wiki,feature_wiki_rankings', 'tiki_p_view', ''),
(40, 42, 'o', 'List pages', 'tiki-listpages.php', 220, 'feature_wiki,feature_listPages', 'tiki_p_view', ''),
(41, 42, 'o', 'Orphan pages', 'tiki-orphan_pages.php', 225, 'feature_wiki,feature_listPages', 'tiki_p_view', ''),
(42, 42, 'o', 'Sandbox', 'tiki-editpage.php?page=sandbox', 230, 'feature_wiki,feature_sandbox', 'tiki_p_view', ''),
(43, 42, 'o', 'Print', 'tiki-print_pages.php', 235, 'feature_wiki,feature_wiki_multiprint', 'tiki_p_view', ''),
(44, 42, 'o', 'Send pages', 'tiki-send_objects.php', 240, 'feature_wiki,feature_comm', 'tiki_p_view,tiki_p_send_pages', ''),
(45, 42, 'o', 'Received pages', 'tiki-received_pages.php', 245, 'feature_wiki,feature_comm', 'tiki_p_view,tiki_p_admin_received_pages', ''),
(46, 42, 'o', 'Structures', 'tiki-admin_structures.php', 250, 'feature_wiki', 'tiki_p_edit_structures', ''),
(47, 42, 's', 'Image Galleries', 'tiki-galleries.php', 300, 'feature_galleries', 'tiki_p_view_image_gallery', ''),
(48, 42, 'o', 'Galleries', 'tiki-galleries.php', 305, 'feature_galleries', 'tiki_p_view_image_gallery', ''),
(49, 42, 'o', 'Rankings', 'tiki-galleries_rankings.php', 310, 'feature_galleries,feature_gal_rankings', 'tiki_p_view_image_gallery', ''),
(50, 42, 'o', 'Upload image', 'tiki-upload_image.php', 315, 'feature_galleries', 'tiki_p_upload_images', ''),
(51, 42, 'o', 'Directory batch', 'tiki-batch_upload.php', 318, 'feature_galleries,feature_gal_batch', 'tiki_p_batch_upload', ''),
(52, 42, 'o', 'System gallery', 'tiki-list_gallery.php?galleryId=0', 320, 'feature_galleries', 'tiki_p_admin_galleries', ''),
(53, 42, 's', 'Articles', 'tiki-view_articles.php', 350, 'feature_articles', 'tiki_p_read_article', ''),
(54, 42, 'o', 'Articles home', 'tiki-view_articles.php', 355, 'feature_articles', 'tiki_p_read_article', ''),
(55, 42, 'o', 'List articles', 'tiki-list_articles.php', 360, 'feature_articles', 'tiki_p_read_article', ''),
(56, 42, 'o', 'Rankings', 'tiki-cms_rankings.php', 365, 'feature_articles,feature_cms_rankings', 'tiki_p_read_article', ''),
(57, 42, 'o', 'Submit article', 'tiki-edit_submission.php', 370, 'feature_articles,feature_submissions', 'tiki_p_read_article,tiki_p_submit_article', ''),
(58, 42, 'o', 'View submissions', 'tiki-list_submissions.php', 375, 'feature_articles,feature_submissions', 'tiki_p_read_article,tiki_p_submit_article', ''),
(59, 42, 'o', 'View submissions', 'tiki-list_submissions.php', 375, 'feature_articles,feature_submissions', 'tiki_p_read_article,tiki_p_approve_submission', ''),
(60, 42, 'o', 'View submissions', 'tiki-list_submissions.php', 375, 'feature_articles,feature_submissions', 'tiki_p_read_article,tiki_p_remove_submission', ''),
(61, 42, 'o', 'Edit article', 'tiki-edit_article.php', 380, 'feature_articles', 'tiki_p_read_article,tiki_p_edit_article', ''),
(62, 42, 'o', 'Send articles', 'tiki-send_objects.php', 385, 'feature_articles,feature_comm', 'tiki_p_read_article,tiki_p_send_articles', ''),
(63, 42, 'o', 'Received articles', 'tiki-received_articles.php', 385, 'feature_articles,feature_comm', 'tiki_p_read_article,tiki_p_admin_received_articles', ''),
(64, 42, 'o', 'Admin topics', 'tiki-admin_topics.php', 390, 'feature_articles', 'tiki_p_read_article,tiki_p_admin_cms', ''),
(65, 42, 'o', 'Admin types', 'tiki-article_types.php', 395, 'feature_articles', 'tiki_p_read_article,tiki_p_admin_cms', ''),
(66, 42, 's', 'Blogs', 'tiki-list_blogs.php', 450, 'feature_blogs', 'tiki_p_read_blog', ''),
(67, 42, 'o', 'List blogs', 'tiki-list_blogs.php', 455, 'feature_blogs', 'tiki_p_read_blog', ''),
(68, 42, 'o', 'Rankings', 'tiki-blog_rankings.php', 460, 'feature_blogs,feature_blog_rankings', 'tiki_p_read_blog', ''),
(69, 42, 'o', 'Create/Edit blog', 'tiki-edit_blog.php', 465, 'feature_blogs', 'tiki_p_read_blog,tiki_p_create_blogs', ''),
(70, 42, 'o', 'Post', 'tiki-blog_post.php', 470, 'feature_blogs', 'tiki_p_read_blog,tiki_p_blog_post', ''),
(71, 42, 'o', 'Admin posts', 'tiki-list_posts.php', 475, 'feature_blogs', 'tiki_p_read_blog,tiki_p_blog_admin', ''),
(72, 42, 's', 'Forums', 'tiki-forums.php', 500, 'feature_forums', 'tiki_p_forum_read', ''),
(73, 42, 'o', 'List forums', 'tiki-forums.php', 505, 'feature_forums', 'tiki_p_forum_read', ''),
(74, 42, 'o', 'Rankings', 'tiki-forum_rankings.php', 510, 'feature_forums,feature_forum_rankings', 'tiki_p_forum_read', ''),
(75, 42, 'o', 'Admin forums', 'tiki-admin_forums.php', 515, 'feature_forums', 'tiki_p_forum_read,tiki_p_admin_forum', ''),
(76, 42, 's', 'Directory', 'tiki-directory_browse.php', 550, 'feature_directory', 'tiki_p_view_directory', ''),
(77, 42, 'o', 'Submit a new link', 'tiki-directory_add_site.php', 555, 'feature_directory', 'tiki_p_submit_link', ''),
(78, 42, 'o', 'Browse directory', 'tiki-directory_browse.php', 560, 'feature_directory', 'tiki_p_view_directory', ''),
(79, 42, 'o', 'Admin directory', 'tiki-directory_admin.php', 565, 'feature_directory', 'tiki_p_view_directory,tiki_p_admin_directory_cats', ''),
(80, 42, 'o', 'Admin directory', 'tiki-directory_admin.php', 565, 'feature_directory', 'tiki_p_view_directory,tiki_p_admin_directory_sites', ''),
(81, 42, 'o', 'Admin directory', 'tiki-directory_admin.php', 565, 'feature_directory', 'tiki_p_view_directory,tiki_p_validate_links', ''),
(82, 42, 's', 'File Galleries', 'tiki-file_galleries.php', 600, 'feature_file_galleries', 'tiki_p_view_file_gallery', ''),
(83, 42, 'o', 'List galleries', 'tiki-file_galleries.php', 605, 'feature_file_galleries', 'tiki_p_view_file_gallery', ''),
(84, 42, 'o', 'Rankings', 'tiki-file_galleries_rankings.php', 610, 'feature_file_galleries,feature_file_galleries_rankings', 'tiki_p_view_file_gallery', ''),
(85, 42, 'o', 'Upload file', 'tiki-upload_file.php', 615, 'feature_file_galleries', 'tiki_p_view_file_gallery,tiki_p_upload_files', ''),
(86, 42, 's', 'FAQs', 'tiki-list_faqs.php', 650, 'feature_faqs', 'tiki_p_view_faqs', ''),
(87, 42, 'o', 'List FAQs', 'tiki-list_faqs.php', 665, 'feature_faqs', 'tiki_p_view_faqs', ''),
(88, 42, 'o', 'Admin FAQs', 'tiki-list_faqs.php', 660, 'feature_faqs', 'tiki_p_admin_faqs', ''),
(89, 42, 's', 'Maps', 'tiki-map.phtml', 700, 'feature_maps', 'tiki_p_map_view', ''),
(90, 42, 'o', 'Mapfiles', 'tiki-map_edit.php', 705, 'feature_maps', 'tiki_p_map_view', ''),
(91, 42, 'o', 'Layer management', 'tiki-map_upload.php', 710, 'feature_maps', 'tiki_p_map_edit', ''),
(92, 42, 's', 'Quizzes', 'tiki-list_quizzes.php', 750, 'feature_quizzes', '', ''),
(93, 42, 'o', 'List quizzes', 'tiki-list_quizzes.php', 755, 'feature_quizzes', '', ''),
(94, 42, 'o', 'Quiz stats', 'tiki-quiz_stats.php', 760, 'feature_quizzes', 'tiki_p_view_quiz_stats', ''),
(95, 42, 'o', 'Admin quiz', 'tiki-edit_quiz.php', 765, 'feature_quizzes', 'tiki_p_admin_quizzes', ''),
(96, 42, 's', 'TikiSheet', 'tiki-sheets.php', 780, 'feature_sheet', '', ''),
(97, 42, 's', 'Trackers', 'tiki-list_trackers.php', 800, 'feature_trackers', 'tiki_p_view_trackers', ''),
(98, 42, 'o', 'List trackers', 'tiki-list_trackers.php', 805, 'feature_trackers', 'tiki_p_view_trackers', ''),
(99, 42, 'o', 'Admin trackers', 'tiki-admin_trackers.php', 810, 'feature_trackers', 'tiki_p_admin_trackers', ''),
(100, 42, 's', 'Surveys', 'tiki-list_surveys.php', 850, 'feature_surveys', '', ''),
(101, 42, 'o', 'List surveys', 'tiki-list_surveys.php', 855, 'feature_surveys', '', ''),
(102, 42, 'o', 'Stats', 'tiki-survey_stats.php', 860, 'feature_surveys', 'tiki_p_view_survey_stats', ''),
(103, 42, 'o', 'Admin surveys', 'tiki-admin_surveys.php', 865, 'feature_surveys', 'tiki_p_admin_surveys', ''),
(104, 42, 's', 'Newsletters', 'tiki-newsletters.php', 900, 'feature_newsletters', 'tiki_p_subscribe_newsletters', ''),
(105, 42, 's', 'Newsletters', 'tiki-newsletters.php', 900, 'feature_newsletters', 'tiki_p_send_newsletters', ''),
(106, 42, 's', 'Newsletters', 'tiki-newsletters.php', 900, 'feature_newsletters', 'tiki_p_admin_newsletters', ''),
(107, 42, 'o', 'Send newsletters', 'tiki-send_newsletters.php', 905, 'feature_newsletters', 'tiki_p_send_newsletters', ''),
(108, 42, 'o', 'Admin newsletters', 'tiki-admin_newsletters.php', 910, 'feature_newsletters', 'tiki_p_admin_newsletters', ''),
(109, 42, 's', 'Ephemerides', 'tiki-eph.php', 950, 'feature_eph', '', ''),
(110, 42, 'o', 'Admin ephemerides', 'tiki-eph_admin.php', 955, 'feature_eph', 'tiki_p_eph_admin', ''),
(111, 42, 's', 'Charts', 'tiki-charts.php', 1000, 'feature_charts', '', ''),
(112, 42, 'o', 'Admin charts', 'tiki-admin_charts.php', 1005, 'feature_charts', 'tiki_p_admin_charts', ''),
(113, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin', ''),
(114, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin_chat', ''),
(115, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin_categories', ''),
(116, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin_banners', ''),
(117, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_edit_templates', ''),
(118, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_edit_cookies', ''),
(119, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin_dynamic', ''),
(120, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin_mailin', ''),
(121, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_edit_content_templates', ''),
(122, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_edit_html_pages', ''),
(123, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_view_referer_stats', ''),
(124, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin_drawings', ''),
(125, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_admin_shoutbox', ''),
(126, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'tiki_p_live_support_admin', ''),
(127, 42, 'r', 'Admin', 'tiki-admin.php', 1050, '', 'user_is_operator', ''),
(128, 42, 'r', 'Admin', 'tiki-admin.php', 1050, 'feature_integrator', 'tiki_p_admin_integrator', ''),
(129, 42, 'o', 'Admin home', 'tiki-admin.php', 1051, '', 'tiki_p_admin', ''),
(130, 42, 'o', 'Live support', 'tiki-live_support_admin.php', 1055, 'feature_live_support', 'tiki_p_live_support_admin', ''),
(131, 42, 'o', 'Live support', 'tiki-live_support_admin.php', 1055, 'feature_live_support', 'user_is_operator', ''),
(132, 42, 'o', 'Banning', 'tiki-admin_banning.php', 1060, 'feature_banning', 'tiki_p_admin_banning', ''),
(133, 42, 'o', 'Calendar', 'tiki-admin_calendars.php', 1065, 'feature_calendar', 'tiki_p_admin_calendar', ''),
(134, 42, 'o', 'Users', 'tiki-adminusers.php', 1070, '', 'tiki_p_admin_users', ''),
(135, 42, 'o', 'Groups', 'tiki-admingroups.php', 1075, '', 'tiki_p_admin', ''),
(136, 42, 'o', 'Cache', 'tiki-list_cache.php', 1080, '', 'tiki_p_admin', ''),
(137, 42, 'o', 'Modules', 'tiki-admin_modules.php', 1085, '', 'tiki_p_admin', ''),
(138, 42, 'o', 'Links', 'tiki-admin_links.php', 1090, 'feature_featuredLinks', 'tiki_p_admin', ''),
(139, 42, 'o', 'Hotwords', 'tiki-admin_hotwords.php', 1095, 'feature_hotwords', 'tiki_p_admin', ''),
(140, 42, 'o', 'RSS modules', 'tiki-admin_rssmodules.php', 1100, '', 'tiki_p_admin', ''),
(141, 42, 'o', 'Menus', 'tiki-admin_menus.php', 1105, '', 'tiki_p_admin', ''),
(142, 42, 'o', 'Polls', 'tiki-admin_polls.php', 1110, 'feature_polls', 'tiki_p_admin', ''),
(143, 42, 'o', 'Backups', 'tiki-backup.php', 1115, '', 'tiki_p_admin', ''),
(144, 42, 'o', 'Mail notifications', 'tiki-admin_notifications.php', 1120, '', 'tiki_p_admin', ''),
(145, 42, 'o', 'Search stats', 'tiki-search_stats.php', 1125, 'feature_search', 'tiki_p_admin', ''),
(146, 42, 'o', 'Theme control', 'tiki-theme_control.php', 1130, 'feature_theme_control', 'tiki_p_admin', ''),
(147, 42, 'o', 'QuickTags', 'tiki-admin_quicktags.php', 1135, '', 'tiki_p_admin', ''),
(148, 42, 'o', 'Chat', 'tiki-admin_chat.php', 1140, 'feature_chat', 'tiki_p_admin_chat', ''),
(149, 42, 'o', 'Categories', 'tiki-admin_categories.php', 1145, 'feature_categories', 'tiki_p_admin_categories', ''),
(150, 42, 'o', 'Banners', 'tiki-list_banners.php', 1150, 'feature_banners', 'tiki_p_admin_banners', ''),
(151, 42, 'o', 'Edit templates', 'tiki-edit_templates.php', 1155, 'feature_edit_templates', 'tiki_p_edit_templates', ''),
(152, 42, 'o', 'Drawings', 'tiki-admin_drawings.php', 1160, 'feature_drawings', 'tiki_p_admin_drawings', ''),
(153, 42, 'o', 'Dynamic content', 'tiki-list_contents.php', 1165, 'feature_dynamic_content', 'tiki_p_admin_dynamic', ''),
(154, 42, 'o', 'Cookies', 'tiki-admin_cookies.php', 1170, '', 'tiki_p_edit_cookies', ''),
(155, 42, 'o', 'Mail-in', 'tiki-admin_mailin.php', 1175, 'feature_mailin', 'tiki_p_admin_mailin', ''),
(156, 42, 'o', 'Content templates', 'tiki-admin_content_templates.php', 1180, '', 'tiki_p_edit_content_templates', ''),
(157, 42, 'o', 'HTML pages', 'tiki-admin_html_pages.php', 1185, 'feature_html_pages', 'tiki_p_edit_html_pages', ''),
(158, 42, 'o', 'Shoutbox', 'tiki-shoutbox.php', 1190, 'feature_shoutbox', 'tiki_p_admin_shoutbox', ''),
(159, 42, 'o', 'Shoutbox Words', 'tiki-admin_shoutbox_words.php', 1191, 'feature_shoutbox', 'tiki_p_admin_shoutbox', ''),
(160, 42, 'o', 'Referer stats', 'tiki-referer_stats.php', 1195, 'feature_referer_stats', 'tiki_p_view_referer_stats', ''),
(161, 42, 'o', 'Edit languages', 'tiki-edit_languages.php', 1200, '', 'tiki_p_edit_languages,lang_use_db', ''),
(162, 42, 'o', 'Integrator', 'tiki-admin_integrator.php', 1205, 'feature_integrator', 'tiki_p_admin_integrator', ''),
(163, 42, 'o', 'phpinfo', 'tiki-phpinfo.php', 1215, '', 'tiki_p_admin', ''),
(164, 42, 'o', 'DSN', 'tiki-admin_dsn.php', 1220, '', 'tiki_p_admin', ''),
(165, 42, 'o', 'External wikis', 'tiki-admin_external_wikis.php', 1225, '', 'tiki_p_admin', ''),
(166, 42, 'o', 'System Admin', 'tiki-admin_system.php', 1230, '', 'tiki_p_admin', ''),
(167, 42, 'o', 'Score', 'tiki-admin_score.php', 1235, 'feature_score', 'tiki_p_admin', ''),
(168, 42, 'o', 'Admin mods', 'tiki-mods.php', 1240, '', 'tiki_p_admin', ''),
(169, 42, 'o', 'Tiki Logs', 'tiki-syslog.php', 1245, '', 'tiki_p_admin', ''),
(170, 42, 'o', 'Security Admin', 'tiki-admin_security.php', 1250, '', 'tiki_p_admin', '');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_menus`
--

CREATE TABLE IF NOT EXISTS `tiki_menus` (
  `menuId` int(8) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL default '',
  `description` text,
  `type` char(1) default NULL,
  PRIMARY KEY  (`menuId`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `tiki_menus`
--

INSERT INTO `tiki_menus` (`menuId`, `name`, `description`, `type`) VALUES
(42, 'Application menu', 'Main extensive navigation menu', 'd');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_minical_events`
--

CREATE TABLE IF NOT EXISTS `tiki_minical_events` (
  `user` varchar(40) default NULL,
  `eventId` int(12) NOT NULL auto_increment,
  `title` varchar(250) default NULL,
  `description` text,
  `start` int(14) default NULL,
  `end` int(14) default NULL,
  `security` char(1) default NULL,
  `duration` int(3) default NULL,
  `topicId` int(12) default NULL,
  `reminded` char(1) default NULL,
  PRIMARY KEY  (`eventId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_minical_events`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_minical_topics`
--

CREATE TABLE IF NOT EXISTS `tiki_minical_topics` (
  `user` varchar(40) default NULL,
  `topicId` int(12) NOT NULL auto_increment,
  `name` varchar(250) default NULL,
  `filename` varchar(200) default NULL,
  `filetype` varchar(200) default NULL,
  `filesize` varchar(200) default NULL,
  `data` longblob,
  `path` varchar(250) default NULL,
  `isIcon` char(1) default NULL,
  PRIMARY KEY  (`topicId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_minical_topics`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_modules`
--

CREATE TABLE IF NOT EXISTS `tiki_modules` (
  `name` varchar(200) NOT NULL default '',
  `position` char(1) default NULL,
  `ord` int(4) default NULL,
  `type` char(1) default NULL,
  `title` varchar(255) default NULL,
  `cache_time` int(14) default NULL,
  `rows` int(4) default NULL,
  `params` varchar(255) default NULL,
  `groups` text,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_modules`
--

INSERT INTO `tiki_modules` (`name`, `position`, `ord`, `type`, `title`, `cache_time`, `rows`, `params`, `groups`) VALUES
('login_box', 'r', 1, NULL, NULL, 0, NULL, NULL, 'a:2:{i:0;s:10:"Registered";i:1;s:9:"Anonymous";}'),
('mnu_application_menu', 'l', 1, NULL, NULL, 0, NULL, 'flip=y', 'a:2:{i:0;s:10:"Registered";i:1;s:9:"Anonymous";}'),
('quick_edit', 'l', 2, NULL, NULL, 0, NULL, NULL, 'a:1:{i:0;s:10:"Registered";}'),
('assistant', 'l', 10, NULL, NULL, 0, NULL, NULL, 'a:2:{i:0;s:10:"Registered";i:1;s:9:"Anonymous";}');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_newsletter_groups`
--

CREATE TABLE IF NOT EXISTS `tiki_newsletter_groups` (
  `nlId` int(12) NOT NULL default '0',
  `groupName` varchar(255) NOT NULL default '',
  `code` varchar(32) default NULL,
  PRIMARY KEY  (`nlId`,`groupName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_newsletter_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_newsletter_subscriptions`
--

CREATE TABLE IF NOT EXISTS `tiki_newsletter_subscriptions` (
  `nlId` int(12) NOT NULL default '0',
  `email` varchar(255) NOT NULL default '',
  `code` varchar(32) default NULL,
  `valid` char(1) default NULL,
  `subscribed` int(14) default NULL,
  `isUser` char(1) NOT NULL default 'n',
  PRIMARY KEY  (`nlId`,`email`,`isUser`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_newsletter_subscriptions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_newsletters`
--

CREATE TABLE IF NOT EXISTS `tiki_newsletters` (
  `nlId` int(12) NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  `description` text,
  `created` int(14) default NULL,
  `lastSent` int(14) default NULL,
  `editions` int(10) default NULL,
  `users` int(10) default NULL,
  `allowUserSub` char(1) default 'y',
  `allowAnySub` char(1) default NULL,
  `unsubMsg` char(1) default 'y',
  `validateAddr` char(1) default 'y',
  `frequency` int(14) default NULL,
  PRIMARY KEY  (`nlId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_newsletters`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_newsreader_marks`
--

CREATE TABLE IF NOT EXISTS `tiki_newsreader_marks` (
  `user` varchar(40) NOT NULL default '',
  `serverId` int(12) NOT NULL default '0',
  `groupName` varchar(255) NOT NULL default '',
  `timestamp` int(14) NOT NULL default '0',
  PRIMARY KEY  (`user`,`serverId`,`groupName`(100))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_newsreader_marks`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_newsreader_servers`
--

CREATE TABLE IF NOT EXISTS `tiki_newsreader_servers` (
  `user` varchar(40) NOT NULL default '',
  `serverId` int(12) NOT NULL auto_increment,
  `server` varchar(250) default NULL,
  `port` int(4) default NULL,
  `username` varchar(200) default NULL,
  `password` varchar(200) default NULL,
  PRIMARY KEY  (`serverId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_newsreader_servers`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_object_ratings`
--

CREATE TABLE IF NOT EXISTS `tiki_object_ratings` (
  `catObjectId` int(12) NOT NULL default '0',
  `pollId` int(12) NOT NULL default '0',
  PRIMARY KEY  (`catObjectId`,`pollId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_object_ratings`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_page_footnotes`
--

CREATE TABLE IF NOT EXISTS `tiki_page_footnotes` (
  `user` varchar(40) NOT NULL default '',
  `pageName` varchar(250) NOT NULL default '',
  `data` text,
  PRIMARY KEY  (`user`,`pageName`(100))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_page_footnotes`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_pages`
--

CREATE TABLE IF NOT EXISTS `tiki_pages` (
  `page_id` int(14) NOT NULL auto_increment,
  `pageName` varchar(160) NOT NULL default '',
  `hits` int(8) default NULL,
  `data` text,
  `description` varchar(200) default NULL,
  `lastModif` int(14) default NULL,
  `comment` varchar(200) default NULL,
  `version` int(8) NOT NULL default '0',
  `user` varchar(40) default NULL,
  `ip` varchar(15) default NULL,
  `flag` char(1) default NULL,
  `points` int(8) default NULL,
  `votes` int(8) default NULL,
  `cache` text,
  `wiki_cache` int(10) default NULL,
  `cache_timestamp` int(14) default NULL,
  `pageRank` decimal(4,3) default NULL,
  `creator` varchar(200) default NULL,
  `page_size` int(10) unsigned default '0',
  `lang` varchar(16) default NULL,
  `lockedby` varchar(200) default NULL,
  `is_html` tinyint(1) default '0',
  `created` int(14) default NULL,
  PRIMARY KEY  (`page_id`),
  UNIQUE KEY `pageName` (`pageName`),
  KEY `data` (`data`(255)),
  KEY `pageRank` (`pageRank`),
  FULLTEXT KEY `ft` (`pageName`,`description`,`data`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `tiki_pages`
--

INSERT INTO `tiki_pages` (`page_id`, `pageName`, `hits`, `data`, `description`, `lastModif`, `comment`, `version`, `user`, `ip`, `flag`, `points`, `votes`, `cache`, `wiki_cache`, `cache_timestamp`, `pageRank`, `creator`, `page_size`, `lang`, `lockedby`, `is_html`, `created`) VALUES
(1, 'HomePage', 1873, '((Linux))\r\n\r\n((Subversion))\r\n\r\n((PHP))\r\n\r\n((WebSphere))\r\n\r\n((PERL_Code))\r\n\r\n((Rational ClearCase))\r\n\r\n((Quotes))\r\n\r\n((OS X))', '', 1219773866, '', 22, 'c8h10n4o2', '168.40.104.46', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'admin', 124, NULL, NULL, 0, 1181907156),
(2, 'Linux', 458, '((System))\r\n\r\n((File System))\r\n\r\n((Searching))\r\n\r\n((Maintain Users))\r\n\r\n((Networking))\r\n\r\n((Scripting))\r\n\r\n((Running Processes))\r\n\r\n((Samba))\r\n\r\n((Treo 650 setup with Ubuntu))\r\n\r\n((Highpoint RocketRAID 1820A with Ubuntu))\r\n\r\n((Gateway m675x Radeon 9700m Ubuntu Setup)) \r\n\r\n((Ubuntu))\r\n\r\n((Send Email))', '', 1203781493, '', 17, 'c8h10n4o2', '66.68.51.87', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 301, NULL, NULL, 0, 1181924922),
(4, 'Searching', 152, '-=Search For String in all Files=-\r\n===Find ENV===\r\nfind ./* -type f -name &quot;*.ksh&quot; | grep &quot;ENV&quot;\r\n\r\n===Find ^M===\r\nfind ./* -type f -name &quot;*.ksh&quot; | grep \\015\\012\r\n\r\n-=Find all files containing a string=-\r\nfind /etc -name &quot;*.java&quot; -exec grep &quot;hello&quot; {}\\;\r\nfind /etc -name &quot;*.java&quot; | xargs grep &quot;hello&quot; 2&gt;/dev/null\r\n\r\n\r\n-=String Replace=-\r\n===Search Multiple Files===\r\nfind /etc -type f -name &quot;*.ksh&quot; -exec perl -pi -e &quot;s/ENV/AGING02/g&quot; {}\\;\r\n\r\n===Single File===\r\nperl -pi -e &quot;s/ENV/AGING02/g&quot; persistence.properties\r\n\r\n===Windows New Line Char===\r\nfind . -type f -name &quot;*.ksh&quot; -exec perl -pi -e &quot;s/\\015\\012/\\012/g&quot; {} \\;\r\n\r\n-=CHMOD of all files in a dir recursively=-\r\nfind . -type f -exec chmod 644 {} \\; \r\n\r\n-=Search for particular file in a jar=-\r\n{CODE()}\r\nfor i in `find . -name &quot;*.jar&quot; -print`; \r\ndo unzip -l $i 2&gt;/dev/null | grep &quot;FileName&quot; &gt; /dev/null 2&gt;&amp;1; \r\nif [ $? == 0 ]; then echo $i; fi; \r\ndone\r\n{CODE}', '', 1193671440, '', 7, 'c8h10n4o2', '24.153.198.63', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 1070, NULL, NULL, 0, 1181929552),
(3, 'Networking', 163, '-=Get Number of Open Connections to Port=-\r\nnetstat -an | awk ''$1 ~ /\\.&lt;PORT NUM&gt;$/{sum+=1}END{print sum}'' \r\n\r\n__EX:__ netstat -an | awk ''$1 ~ /\\.1666$/{sum+=1}END{print sum}'' \r\n\r\n-=Display app apps &amp; ports listening=-\r\nnetstat -an | grep &quot;LISTEN &quot;\r\n\r\n-=Display Network Speed=-\r\nsudo ethtool eth0\r\n\r\n-=Display Speed of NIC=-\r\nsudo mii-tool\r\n\r\n-=Modify Network Config Speed=-\r\nsudo ethtool -s eth0 speed 1000 duplex full\r\n\r\n-=Query Network Card from Hardware List=-\r\nroot@server:/home/c8h10n4o2# sudo lshw -C net\r\n\r\n  *-network\r\n       description: Ethernet interface\r\n       product: RTL-8169 Gigabit Ethernet\r\n       vendor: Realtek Semiconductor Co., Ltd.\r\n       physical id: 8\r\n       bus info: pci@0000:01:08.0\r\n       logical name: eth1\r\n       version: 10\r\n       serial: 00:18:e7:16:92:cc\r\n       size: 1GB/s\r\n       capacity: 1GB/s\r\n       width: 32 bits\r\n       clock: 66MHz\r\n       capabilities: pm bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation\r\n       configuration: autonegotiation=on broadcast=yes driver=r8169 driverversion=2.2LK duplex=full ip=10.0.0.3 latency=64 link=yes maxlatency=64 mingnt=32 module=r8169 multicast=yes port=twisted pair speed=1GB/s\r\n-=VNC Over SSH=-\r\nYou must have vncserver &amp; ssh running on your destination box\r\nvncviewer -via &lt;user&gt;@&lt;ip_address&gt; &lt;dest_box&gt;:&lt;port&gt;\r\nEX:\r\nIf you are using DYNDNS and have test.getmyip.com as your domain, and your box name on your local network is coffeecup:\r\nvncviewer -via joe@test.getmyip.com coffeecup:1\r\nThis will vnc to test.getmyip.com and log into the vpn as joe. It will then vnc from the vpn destination to the vnc destination. \r\n\r\n-=Set up SSH Key=-\r\n# On source machine, cd ~/.ssh \r\n# cat contents of id_dsa.pub OR id_rsa.pub \r\n# Copy contents and paste in notepad (NOTE: THIS IS A SINGLE LINE, NOT MULTIPLE) \r\n# ssh to Destination box from the Source Box \r\n# Enter your password and login. (If you cannot log in, then NG needs to add that user to the list of users for that box.) \r\n# Verify you are in home dir =&gt; pwd \r\n# CREATE .ssh dir =&gt; mkdir .ssh \r\n# Set .ssh permissions to 700 =&gt; chmod 700 .ssh \r\n# cd .ssh \r\n# vi authorized_keys \r\n# paste your key and make sure it is a single line. \r\n# verify your connections works by ssh batchtaa@ietadu001 and you should not get a login.\r\n* If you are prompted for a login, you did something wrong.\r\n* If you get prompted for password, you did somethign wrong.\r\n* If you get prompted for passphrase, whoever created that public / private key pair we used created a passphrase with it also.\r\n\r\n-=Don''t worry about /etc/hosts=-\r\nTo mount a windows share on a DHCP network, it is convenient to be able to mount by netbios name, so you don''t have to modify the mount parameters every time you reboot your network. This can be easily enabled by doing the following:\r\n\r\nEdit your nsswitch file\r\n^sudo vi /etc/nsswitch.conf^\r\nsearch through the file and look for the line that looks something like so &quot;hosts: files dns&quot;\r\nadd &quot;wins&quot; to the end of the line\r\nnote: &quot;wins&quot; MUST come before &quot;dns&quot; if you are using the openDNS service.\r\nit looks something like this:\r\n^hosts: files wins dns^\r\nSave the file by hitting :wq\r\nNow you''ll need to install winbind\r\n^sudo aptitude install winbind^\r\n\r\nsource: http://ubuntuforums.org/showthread.php?t=288534\r\n\r\n', '', 1204506973, '', 6, 'c8h10n4o2', '66.68.51.87', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 3416, NULL, NULL, 0, 1181928565),
(5, 'Scripting', 89, '-=FOR LOOP=-\r\n===CREATE patch DIR IN ALL LOCAL DIRS===\r\n\r\nfor i in `ls`; do `mkdir $i/patch`; done ', '', 1181929810, '', 2, 'c8h10n4o2', '168.56.37.8', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 99, NULL, NULL, 0, 1181929797),
(6, 'Maintain Users', 65, '-=User &amp; Group Lookup=-\r\nypcat passwd | grep &lt;user name&gt;\r\n\r\nypcat group | grep &lt;group #&gt;\r\n\r\n-=Edit User Info=-\r\nvi ~/.profile\r\nvi ~/.bashrc\r\n\r\n-=Change Edit Mode Enabling Backspace=-\r\nstty sane\r\n', '', 1181932092, '', 2, 'c8h10n4o2', '168.56.37.8', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 211, NULL, NULL, 0, 1181930135),
(7, 'File System', 191, '-=Disk Usage=-\r\n===Size of all DIRS in current DIR===\r\ndu -shk *\r\n\r\n===Size of current DIR===\r\ndu -shk .\r\n\r\n===Disk Usage of a particular directory===\r\ndu -h --max-depth=0 /mnt/music/sorted/\r\n\r\n-=File Count=-\r\nls -l | wc -l\r\n\r\n-=List all hard drives and space info=-\r\ndf -lk\r\n\r\n-=List all hard drives &amp; partitions=-\r\nfdisk -l', '', 1199452129, '', 4, 'c8h10n4o2', '66.68.51.87', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 329, NULL, NULL, 0, 1181931016),
(8, 'Running Processes', 94, '-=Process Tree=-\r\nptree &lt;Process ID&gt;\r\n\r\n-=Display Running Processes=-\r\nprstat -a 10\r\n\r\ntop\r\n\r\nps -ef\r\n\r\n-=Kill Multiple Running Processes via Name=-\r\nps -ef | grep &lt;USER&gt; | grep &lt;PART OF JOB NAME&gt; | awk ''{print $2}'' | xargs kill\r\n\r\n-=Run Processes in Background=-\r\n__Run job as child process of current shell in the background__\r\n&lt;cmd&gt; &amp;\r\nEX: cp ./* /test &amp;\r\n\r\n\r\n__Fork another shell &amp; execute job in that shell in the background__\r\n(&lt;cmd&gt;) &amp;\r\nEX: (cp ./* /test) &amp;', '', 1199386573, '', 4, 'c8h10n4o2', '24.153.198.63', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 514, NULL, NULL, 0, 1181931907),
(9, 'System', 119, '-=Time System Has been Up=-\r\nuptime\r\n\r\n-=Number of CPU''s=-\r\npsrinfo\r\n\r\n-=Kernel Version=-\r\nuname -r\r\n\r\n-=Create a Symbolic Link=-\r\nln -s &lt;TARGET DIRECTORY OR FILE&gt; ./&lt;SHORTCUT&gt;\r\n\r\nFor example:\r\n\r\nln -s /usr/local/apache/logs ./logs\r\n\r\n-=Get Ubuntu Version=-\r\nmore /etc/lsb-release\r\n\r\n-=Show location of file=-\r\nc8h10n4o2@james:/media/sdb1/photographs/2007$ type thunderbird\r\nthunderbird is /usr/bin/thunderbird\r\n\r\n-=List only directories of current dir=-\r\nls -l | grep ''^d''\r\n\r\n-=Change Prompt type &amp; width=-\r\nexport TERM=ansi\r\nstty columns 120 ', '', 1222973182, '', 8, 'c8h10n4o2', '168.40.106.255', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 560, NULL, NULL, 0, 1181932010),
(10, 'WebSphere', 180, '-=Modify WebSphere Vars=-\r\n#Environment\r\n#Manage WebSphere Variables\r\n#Go to Cell Level\r\n#Apply\r\n\r\n-=DB Info=-\r\n#Resources\r\n#JDBC Providers\r\n#Enter Node Name or Browse for Node\r\n#Enter Server Name or Browse for Server\r\n#Click Apply\r\n#Click &quot;Oracle JDBC Driver&quot;\r\n\r\n-=Disable Security for WebSphere Admin=-\r\n#vi /export/ENV/TIERS/aging/WebSphere/DeploymentManager/config/cells/tiers_aging_Network/security.xml\r\n#In first argument, set enabled=”false” \r\n\r\n-=Bounce Node to Pick up Settings=-\r\n#Stop Cluster\r\n#Stop Node\r\n#Stop DM\r\n#Start DM\r\n#Start Node\r\n#Start Cluster\r\n', '', 1181932364, '', 2, 'c8h10n4o2', '168.56.37.8', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 581, NULL, NULL, 0, 1181932363),
(11, 'Subversion', 245, '-=Basic SVN Commands=-\r\nSOURCE: http://www.linuxfromscratch.org/blfs/edguide/chapter03.html\r\n\r\n__Introduction__\r\n\r\nThe help function of Subversion (svn help) provides a summary of the available commands. More detailed information is available from the Subversion on-line book available at http://svnbook.red-bean.com/en/1.2/index.html. Chapter 3 is especially helpful.\r\n\r\nThe following is a basic set of commands which all editors will use frequently. Some commands have two forms, the long and the short. Both are listed in the description.\r\n\r\n__svn checkout/co__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.checkout.html | svn checkout] or svn co. This command is used to pull an SVN tree such as svn://linuxfromscratch.org/BLFS/trunk/BOOK (the BLFS Development book) from the server. You should only need to do this once. If the directory structure is changed (as is sometimes necessary), you may occasionally need to delete your local sand box and re-check it out. If this is going to be needed, it will usually be because the Editor will have made a large change and it will be announced at least on the BLFS-Book mailing list.\r\n\r\n__svn add__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.add.html | svn add]. When you are creating a new file or directory, you need to tell the SVN server about it. This command does that. Note that the file won''t appear in the repository until you do an svn commit (see below).\r\n\r\n__svn propset__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.propset.html | svn propset]. When you are creating a new file or directory, you generally need to tell the SVN to apply properties to the file in places that have keywords in a special format such as $Date: 2007-04-03 14:28:17 -0500 (Tue, 03 Apr 2007) $. Note that the keyword value won''t appear in the file until you do an svn commit (see below).\r\n\r\n__svn delete__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.delete.html | svn delete]. This does what it says! When you do an svn commit the file will be deleted from your local sand box immediately as well as from the repository after committing.\r\n\r\n__svn status__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.status.html | svn status]. This command prints the status of working directories and files. If you have made local changes, it''ll show your locally modified items. If you use the --verbose switch, it will show revision information on every item. With the --show-updates (-u) switch, it will show any server out-of-date information.\r\n\r\nYou should always do a manual svn status --show-updates before trying to commit changes in order to check that everything is OK and ready to go.\r\n\r\n__svn update/up__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.update.html | svn update] or svn up. This command syncs your local sand box with the server. If you have made local changes, it will try and merge any changes on the server with your changes on your machine.\r\n\r\n__svn commit/ci__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.commit.html | svn commit] or svn ci. This command recursively sends your changes to the SVN server. It will commit changed files, added files, and deleted files. Note that you can commit a change to an individual file or changes to files in a specific directory path by adding the name of the file/directory to the end of the command. The -m option should always be used to pass a log message to the command. Please don''t use empty log messages (see later in this document the policy which governs the log messages).\r\n\r\n__svn diff__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.diff.html | svn diff]. This is useful for two different purposes. First, those without write access to the BLFS SVN server can use it to generate patches to send to the BLFS-Dev mailing list. To do this, simply edit the files in your local sand box then run svn diff &gt; FILE.patch from the root of your BLFS directory. You can then attach this file to a message to the BLFS-Dev mailing list where someone with editing rights can pick it up and apply it to the book. The second use is to find out what has changed between two revisions using: svn diff -r revision1:revision2 FILENAME. For example: svn diff -r 168:169 index.xml will output a diff showing the changes between revisions 168 and 169 of index.xml.\r\n\r\n__svn move__\r\n\r\n[http://svnbook.red-bean.com/en/1.2/svn.ref.svn.c.move.html | svn move SRC DEST] or svn mv SRC DEST or svn rename SRC DEST or svn ren SRC DEST. This command moves a file from one directory to another or renames a file. The file will be moved on your local sand box immediately as well as on the repository after committing.\r\n\r\n-=Backup=-\r\nsudo svnadmin dump /usr/local/svn/htdocs &gt; /tmp/htdocs.dump ; mv -f /tmp/htdocs.dump /mnt/backup\r\n\r\n__A Simple Way to Backup and Restore a Subversion Repository__\r\n\r\nSOURCE: [http://www.falafel.com/community/blogs/techbits/archive/2006/01/11/A-Simple-Way-to-Backup-and-Restore-a-Subversion-Repository.aspx]\r\n\r\nYou can use the subversion dump and load commands to perform simple backups and restores of your repository.\r\n\r\nTo back up a subversion repository, issue the following command:\r\n\r\nsvnadmin dump /usr/local/MyRepository &gt; /home/charlie/svnBackupFile\r\n\r\nHere you pass the dump caommd to the svnadmin utility. As a parameter, you pass in the name of the repository you want to backup. I then redirect that backup to a file.\r\n\r\nTo restore the repository from the dump file, you should first create a new repository to hold the data you want to restore:\r\n\r\nsvnadmin create /home/charlie/foo/bat\r\n\r\nTo restore the data, enter this command:\r\n\r\nsvnadmin load /home/charlie/foo/bar &lt; /home/charlie/svnBackupFile\r\n\r\nWhen the repository is restored, you can use the standard command line commands to check files out from it:\r\n\r\nsvn --username &lt;name&gt; --password &lt;pwd&gt; co svn://home/charlie/foo/bar/CodeFez \r\n\r\n-=Checkout Example=-\r\nsvn checkout svn+ssh://c8h10n4o2@greenbox/usr/local/svn/scripts\r\n\r\n-=Create New Stream &amp; Import Code=-\r\n#__Create svn project called cablecrazy__\r\n+sudo svnadmin create /usr/local/svn/cablecrazy\r\n#__Make dir so webserver can check out &amp; in__\r\n+sudo chown -R www-data svn\r\n+sudo chmod -R g+rws svn\r\n#__Add the dir to apache__\r\n+sudo vi /etc/apache2/apache2.conf\r\n+&lt;Location /svn/cablecrazy&gt;\r\n+DAV svn\r\n+SVNPath /usr/local/svn/cablecrazy\r\n+AuthType Basic\r\n+AuthName &quot;subversion repository&quot;\r\n+AuthUserFile /etc/subversion/passwd\r\n+Require valid-user\r\n+&lt;/Location&gt;\r\n#__Bounce apache__\r\n+sudo /etc/init.d/apache2 restart\r\n#__Initial data import__\r\n+sudo svn import -m &quot;Initial Import&quot; /var/www/cable_crazy\r\n+file:///usr/local/svn/cablecrazy\r\n#__Update local view__\r\n+c8h10n4o2@greenbox:/var/www$ svn checkout ~np~http://greenbox/svn/cablecrazy~np~', '', 1199555841, '', 9, 'c8h10n4o2', '24.153.198.63', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 6808, NULL, NULL, 0, 1181935287),
(12, 'Adobe Premier', 208, 'http://www.adobe.com/designcenter/premiere/articles/prp2it_trimming.html', '', 1182481617, '', 1, 'c8h10n4o2', '66.68.76.76', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 72, NULL, NULL, 0, 1182481617),
(13, 'PHP', 175, '-=String Generate=-\r\n{CODE()}\r\n&lt;?php\r\n/*\r\n* This is the domaincheck x len generation written in PHP\r\n*/\r\n$ALPHABET=array(''A'',''B'',''C'',''D'',''E'',''F'',''G'',''H'',''I'',''J'',''K'',''L'',''M'',''N'',''O'',''P'',''Q'',''R'',''S'',''T'',''U'',''V'',''W'',''X'',''Y'',''Z'');\r\n$strlen = 3;\r\n$word_array=$ALPHABET;\r\nfor($i=1; $i&lt;$strlen;$i++)\r\n{\r\n   foreach($word_array as $id=&gt;$val)\r\n   {\r\n      foreach($ALPHABET as $id=&gt;$letter)\r\n      {\r\n         array_push($word_array, $val . $letter);\r\n      }\r\n   }\r\n}\r\n\r\nforeach($word_array as $id=&gt;$val)\r\n{\r\n   echo($val . &quot;&lt;br&gt;&quot;);\r\n}\r\n?&gt;\r\n{CODE}', '', 1182482879, '', 3, 'c8h10n4o2', '66.68.76.76', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 573, NULL, NULL, 0, 1182482350),
(14, 'PERL_Code', 188, '-=Domain Check=-\r\n{CODE()}\r\nif(!defined(@ARGV[0]))\r\n{\r\n	println(&quot;USAGE: dc.pl &lt;LENGTH&gt;&quot;);\r\n	exit();\r\n}\r\n\r\n\r\n# Specify Perl modules to include here\r\nuse Time::localtime;\r\n#use Getopt::Long;\r\n#use NET::SMTP;\r\n#use NET::hostent;\r\n\r\n@CHARS = (&quot;A&quot;, &quot;B&quot;, &quot;C&quot;, &quot;D&quot;, &quot;E&quot;, &quot;F&quot;, &quot;G&quot;, &quot;H&quot;, &quot;I&quot;, &quot;J&quot;, &quot;K&quot;, &quot;L&quot;, &quot;M&quot;, &quot;N&quot;, &quot;O&quot;, &quot;P&quot;, &quot;Q&quot;, &quot;R&quot;, &quot;S&quot;, &quot;T&quot;, &quot;U&quot;, &quot;V&quot;, &quot;W&quot;, &quot;X&quot;, &quot;Y&quot;, &quot;Z&quot;);#, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9);\r\n$strlen = @ARGV[0];\r\n@domains = ();\r\n($YEAR, $MONTH, $DAY) = getCurrentDate();\r\n($HR, $MIN, $SEC) = getCurrentTime();\r\n$DATE_STRING = $YEAR . &quot;-&quot; . $MONTH . &quot;-&quot; . $DAY . &quot;_&quot; . $HR . &quot;-&quot; . $MIN . &quot;-&quot; . $SEC;\r\n$DC_DIR = &quot;/home/c8h10n4o2/dc/&quot;;\r\n$WHOIS_DIR = $DC_DIR . &quot;whois_results/&quot;;\r\n$NO_MATCH_FILE = $DC_DIR . $DATE_STRING . &quot;_no_match.results&quot;;\r\n$EXPIRES_ON_FILE = $DC_DIR . $DATE_STRING . &quot;_expires_on.results&quot;;\r\n$CHECK_WHOIS_FILE = $DC_DIR . $DATE_STRING . &quot;_check_whois.results&quot;;\r\nfor($counter = 1; $counter &lt;= $strlen; $counter++)\r\n{\r\n   if(getArraySize(@domains) == 0)\r\n   {\r\n      foreach $char (@CHARS)\r\n      {\r\n         $new_domain = $char;\r\n         push(@domains, $new_domain);\r\n         #print($new_domain . &quot;\\n&quot;);\r\n      }\r\n   }\r\n   else\r\n   {\r\n      @orig_list = @domains;\r\n      foreach $domain (@orig_list)\r\n      {\r\n         foreach $char (@CHARS)\r\n         {\r\n            $new_domain = $domain . $char;\r\n            push(@domains, $new_domain);\r\n				if(length($new_domain) == $strlen)\r\n				{\r\n					$to_check = $new_domain . &quot;.COM&quot;;\r\n					if(dig_dns($to_check) == 0)\r\n					{\r\n						get_whois_file($domain);\r\n						check_whois_file($domain);\r\n					}\r\n				}\r\n         }\r\n      }\r\n   }\r\n}\r\n\r\n\r\nsub getArraySize\r\n{\r\n   my @intArray = @_;\r\n   $lastIndex = $#intArray; # index of the last element, $lastIndex == 2\r\n   $length = $lastIndex + 1; # size of the array\r\n   return($length);\r\n}\r\n\r\n\r\nsub check_whois_file\r\n{\r\n	my $domain = ($to_check);\r\n	$filename = $WHOIS_DIR . &quot;whois.&quot; . $domain . &quot;.results&quot;;\r\n	println(&quot;filename = &quot; . $filename);\r\n	my($result_found) = 0;\r\n	open WHOISFILE, &quot;$filename&quot;;\r\n	# Look through existing whois file for details\r\n	$no_match = &quot;No match for&quot;;\r\n	$expiration_date = &quot;Expiration Date:&quot;;\r\n	while ( &lt;WHOISFILE&gt; )\r\n	{\r\n		my($line) = $_;\r\n		#println($line);\r\n		if(my($subline) = m/($no_match)/o)\r\n		{\r\n			# PRINT DOMAIN TO A FILE\r\n			open NOMATCHFILE, &quot;&gt;&gt;$NO_MATCH_FILE&quot;;\r\n			print NOMATCHFILE $domain;\r\n			close NOMATCHFILE;\r\n			println(&quot;No match for $domain&quot;);\r\n			$result_found++;\r\n		}\r\n		elsif(my($subline) = m/($expiration_date)/o)\r\n		{\r\n			open EXPIRESONFILE, &quot;&gt;&gt;$EXPIRES_ON_FILE&quot;;\r\n			print EXPIRESONFILE $domain . &quot; =&gt; &quot; . $line;\r\n			close EXPIRESONFILE;\r\n			println($domain . &quot; =&gt; &quot; . $line);\r\n			$result_found++;\r\n		}\r\n	}\r\n	close WHOISFILE;\r\n	if($result_found == 0)\r\n	{\r\n		#ALSO PRINT DOMAIN TO A FILE\r\n		open CHECKWHOISFILE, &quot;&gt;&gt;$CHECK_WHOIS_FILE&quot;;\r\n		print CHECKWHOISFILE $domain . &quot; Check WHOIS&quot;;\r\n		close CHECKWHOISFILE;			\r\n		println($domain . &quot; CHECK WHOIS FILE&quot;);\r\n	}\r\n}\r\nsub get_whois_file\r\n{\r\n	my $domain = ($to_check);\r\n	$filename = $WHOIS_DIR . &quot;whois.&quot; . $domain . &quot;.results&quot;;\r\n	println(&quot;checking $filename&quot;);\r\n	if(!(-e $filename))\r\n	{\r\n		println(&quot;$filename does not exist.... creating it&quot;);\r\n		open WHOISFILE, &quot;&gt;$filename&quot;;\r\n		$whoisresults=`/usr/bin/whois $domain`;\r\n		println(&quot;results : \\n&quot; . $whoisresults);\r\n		print WHOISFILE $whoisresults . &quot;\\n&quot;;\r\n	}\r\n}\r\nsub dig_dns\r\n{\r\n	my $domain = ($to_check);\r\n	my @domain = @_;\r\n	println(&quot;checking $domain&quot;);\r\n	$digresults=`/usr/bin/dig $domain | grep ''ANSWER SECTION''`;\r\n	if(length $digresults &gt; 0)\r\n	{\r\n		return(1);\r\n	}\r\n	else\r\n	{\r\n		return(0);\r\n	}\r\n}\r\nsub println\r\n{\r\n	my @toprint = @_;\r\n	print(&quot;@toprint\\n&quot;);\r\n}\r\n\r\n# Get current date.  Proceed single digit dates with a 0 for readability.\r\nsub getCurrentDate {\r\n        my $year  = localtime-&gt;year() + 1900;\r\n        my $month = ((localtime-&gt;mon() + 1) &lt; 10) ? (&quot;0&quot; . (localtime-&gt;mon() + 1)) : (localtime-&gt;mon() + 1);\r\n        my $day   = (localtime-&gt;mday() &lt; 10) ? (&quot;0&quot; . localtime-&gt;mday()) : localtime-&gt;mday();\r\n        return ($year, $month, $day);\r\n}\r\n\r\n# Get current time.  Preceed single digit times with a 0 for readability.\r\nsub getCurrentTime {\r\n        my $hour   = (localtime-&gt;hour() &lt; 10) ? (&quot;0&quot; . localtime-&gt;hour()) : localtime-&gt;hour();\r\n        my $minute = (localtime-&gt;min() &lt; 10) ? (&quot;0&quot; . localtime-&gt;min()) : localtime-&gt;min();\r\n        my $second = (localtime-&gt;sec() &lt; 10) ? (&quot;0&quot; . localtime-&gt;sec()) : localtime-&gt;sec();\r\n        return ($hour, $minute, $second);\r\n}\r\n\r\n{CODE}', '', 1184281657, '', 4, 'c8h10n4o2', '72.255.19.226', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 5234, NULL, NULL, 0, 1182483161),
(15, 'Quotes', 137, 'Our theories of the eternal are as valuable as are those which a chick which has not broken its way through its shell might form of the outside world. \r\n- Buddha', '', 1183719379, '', 1, 'c8h10n4o2', '72.255.27.197', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 161, NULL, NULL, 0, 1183719379),
(16, 'Samba', 82, '-=List Shares of Box=-\r\nsudo smbclient -U &lt;username&gt; -L &lt;boxname&gt;\r\n\r\n-=Mount Share=-\r\nsudo mkdir /mnt/tmp\r\nsudo mount -t smbfs -o username=&lt;username&gt;,password=&lt;password&gt; //&lt;server_ip&gt;/&lt;share_name&gt; /mnt/tmp\r\nEX: sudo mount -t smbfs -o username=Instructor1,password=Password1 //192.168.1.111/Faculty_Materials /mnt/tmp\r\n\r\n', '', 1183725069, '', 3, 'c8h10n4o2', '72.255.68.35', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 356, NULL, NULL, 0, 1183725010),
(17, 'Treo 650 setup with Ubuntu', 462, '1) Hook up Treo to computer via USB\r\n-=Check to see if the OS sees your Treo=-\r\n{CODE()}\r\ntail -f /var/log/messages\r\n{CODE}\r\n2) Click HotSync button\r\nYou should see something like the following output in __/var/log/messages__\r\n{CODE()}\r\nJul 21 08:34:43 laptop kernel: [31222.449600] usb 2-2: new full speed USB device using uhci_hcd and address 3\r\nJul 21 08:34:43 laptop kernel: [31222.623557] usb 2-2: configuration #1 chosen from 1 choice\r\nJul 21 08:34:54 laptop kernel: [31232.920043] usb 2-2: USB disconnect, address 3\r\n{CODE}\r\nThis means your computer can see the USB message but doesn''t know what it is\r\n\r\n-=Tell Ubuntu what the hardware is trying to talk to it=-\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ sudo /sbin/modprobe usbserial\r\nc8h10n4o2@laptop:~$ sudo /sbin/modprobe visor\r\n{CODE}\r\nNow when you try to sync your Treo, you should see something like the following output in __/var/log/messages__\r\n{CODE()}\r\nJul 21 08:37:27 laptop kernel: [31385.682799] usb 2-2: USB disconnect, address 5\r\nJul 21 08:37:27 laptop kernel: [31385.683606] visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0\r\nJul 21 08:37:27 laptop kernel: [31385.683751] visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1\r\n{CODE}\r\n\r\nYou can also look at your lsmod to see if Ubuntu knows what your hardware is\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ sudo /sbin/lsmod | grep visor\r\nvisor                  20364  0\r\nusbserial              32488  1 visor\r\nusbcore               134280  9 visor,usbserial,usbhid,ndiswrapper,usb_storage,libusual,ehci_hcd,uhci_hcd\r\n{CODE}\r\n\r\n-=Tell your OS what the hardware is for next time you boot=-\r\nsudo vi /etc/modprobe.d/options     \r\nAdd the following line:\r\n{CODE()}\r\noptions visor vendor=0x830 product=0x61\r\n{CODE}\r\n\r\n-=Create /dev/pilot as a symlink every time the palm mounts=-\r\nc8h10n4o2@laptop:/$ sudo vi /etc/udev/rules.d/10-custom.rules\r\n{CODE()}\r\nKERNEL=&quot;ttyUSB*&quot;, NAME=&quot;%k&quot;, SYMLINK=&quot;pilot&quot;, GROUP=&quot;uucp&quot;, MODE=&quot;0666&quot;\r\n{CODE}\r\n\r\nNow you must log out &amp; back in to pick up these changes.\r\nNow when you sync, it will create /dev/ttyUSB0 or /dev/ttyUSB1 or whatever the next number is. However, this will not be writable to world (you will not be the owner or a group member. I tried adding myself to the group __dialout__ but it did not fix things. Thus:\r\n\r\n&lt;ls /dev&gt;\r\nlrwxrwxrwx 1 root root           7 2007-07-21 08:38 pilot -&gt; ttyUSB1\r\ncrw-rw-r-- 1 root dialout 188, 1 2007-07-21 08:38 ttyUSB1\r\n\r\n-=Configure ttyUSB* to give the world RW access when they mount=-\r\n\r\nroot@laptop:/etc/udev/rules.d# vi 40-permissions.rules\r\nNeed to modify MODE of ttyUSB* from 0660 to 0666\r\n{CODE()}\r\n# Serial devices\r\nSUBSYSTEM==&quot;tty&quot;,                       GROUP=&quot;c8h10n4o2&quot;\r\nSUBSYSTEM==&quot;capi&quot;,                      GROUP=&quot;dialout&quot;\r\nSUBSYSTEM==&quot;slamr&quot;,                     GROUP=&quot;dialout&quot;\r\nSUBSYSTEM==&quot;zaptel&quot;,                    GROUP=&quot;dialout&quot;\r\nKERNEL==&quot;ttyLTM[0-9]*&quot;,                 GROUP=&quot;dialout&quot;, MODE=&quot;0666&quot;\r\n{CODE}\r\n\r\n-=When you rebooted, the drivers were lost. Thus, add the following=-\r\n\r\nvi /etc/modules\r\nc8h10n4o2@laptop:/var/log/vmware$ more /etc/modules\r\n{CODE()}\r\n# /etc/modules: kernel modules to load at boot time.\r\n#\r\n# This file contains the names of kernel modules that should be loaded\r\n# at boot time, one per line. Lines beginning with &quot;#&quot; are ignored.\r\n\r\nlp\r\nsbp2\r\nsnd-intel8x0\r\n# ADD THE NEXT 2 LINES SO YOU CAN SEE YOUR PDA\r\nusbserial\r\nvisor\r\n{CODE}', '', 1185071886, '', 1, 'c8h10n4o2', '72.255.41.15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 3606, NULL, NULL, 0, 1185071886),
(18, 'Gateway m675x Radeon 9700m Ubuntu Setup', 124, '!How to configure your graphics card in your Gateway m675x with Ubuntu\r\n\r\nSpecial thanks to http://wiki.cchtml.com/index.php/Ubuntu_Edgy_Installation_Guide\r\n\r\n-=CHECK TO MAKE SURE YOUR RADEON 9800 CARD IS NOT RECOGNIZED BY LINUX AND THE 3D ACCELLERATION IS NOT WORKING=-\r\n\r\nDISPLAY WHAT GRAPHICS CARD LINUX THINKS YOU HAVE.\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ fglrxinfo\r\ndisplay: :0.0  screen: 0\r\nOpenGL vendor string: Tungsten Graphics, Inc.\r\nOpenGL renderer string: Mesa DRI R300 20060815 AGP 8x x86/MMX/SSE2 TCL\r\nOpenGL version string: 1.3 Mesa 6.5.2\r\n{CODE}\r\n\r\nDISPLAY OF YOUR CARD HAS 3D ACCELLERATION\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ glxinfo | grep direct\r\ndirect rendering: No\r\n{CODE}\r\n\r\n---\r\n\r\n-=MODIFY /etc/X11/xorg.conf=-\r\nBack it up (never do anything without a backup):\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ sudo cp /etc/X11/xorg.conf /etc/X11/xorg.conf.orig\r\n{CODE}\r\n\r\nOpen the file to edit\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ sudo vi /etc/X11/xorg.conf\r\n{CODE}\r\n\r\nAdd the following lines:\r\n{CODE()}\r\nSection &quot;Extensions&quot;\r\n        Option  &quot;Composite&quot; &quot;Disable&quot;\r\nEndSection\r\n\r\nSection &quot;ServerFlags&quot;\r\n        Option  &quot;AIGLX&quot; &quot;off&quot;\r\nEndSection\r\n{CODE}\r\n\r\nSave &amp; Quit\r\n{CODE()}\r\n:wq\r\n{CODE}\r\n---\r\n-=Install Necessary Apps=-\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ sudo apt-get update\r\nc8h10n4o2@laptop:~$ sudo apt-get install linux-restricted-modules-$(uname -r) #Okay if it is already installed\r\nc8h10n4o2@laptop:~$ sudo apt-get install xorg-driver-fglrx\r\n{CODE}\r\n\r\n-=Configure ATI=-\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ sudo aticonfig --initial\r\n{CODE}\r\n\r\n-=Reboot=-\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ sudo shutdown -r now\r\n{CODE}\r\n\r\n---\r\n\r\n-=Now check to make sure it all works=-\r\n\r\nDISPLAY WHAT GRAPHICS CARD LINUX THINKS YOU HAVE.\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ fglrxinfo\r\ndisplay: :0.0  screen: 0\r\nOpenGL vendor string: ATI Technologies Inc.\r\nOpenGL renderer string: MOBILITY RADEON 9700\r\nOpenGL version string: 2.0.6334 (8.34.8)\r\n{CODE}\r\n\r\nDISPLAY OF YOUR CARD HAS 3D ACCELLERATION\r\n{CODE()}\r\nc8h10n4o2@laptop:~$ glxinfo | grep direct\r\ndirect rendering: Yes\r\n{CODE}\r\n\r\nYou can also click on your menu and will see the __ATI Control__ option\r\nIf you open this, it will display your graphics card name.', '', 1185114278, '', 1, 'c8h10n4o2', '72.255.41.15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 2242, NULL, NULL, 0, 1185114278),
(19, 'Ubuntu', 75, '-=Modify default editor to vi=-\r\nupdate-alternatives --config editor\r\n\r\n__EX:__\r\n{CODE()}\r\nroot@james:/etc# update-alternatives --config editor\r\n\r\nThere are 3 alternatives which provide `editor''.\r\n\r\n  Selection    Alternative\r\n-----------------------------------------------\r\n          1    /usr/bin/vim.tiny\r\n          2    /bin/ed\r\n*+        3    /bin/nano\r\n\r\nPress enter to keep the default[*], or type selection number: 1\r\nUsing `/usr/bin/vim.tiny'' to provide `editor''.\r\n\r\n{CODE}', '', 1186714607, '', 1, 'c8h10n4o2', '66.68.76.76', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 483, NULL, NULL, 0, 1186714607),
(20, 'Adobe Photoshop', 99, '-=Printing to an Epson 2200 from Photoshop=-\r\n\r\nPreparing an Image File for printing with the Epson 2200 - either Stan or Betty\r\n  	1) Create a copy of your original or edited image file.\r\n2) Your file should be in RGB mode(in the Image--&gt;Mode Menu). Ideally your file would have an AdobeRGB profile(also in the Image--&gt;Mode--&gt;Convert Profile Menu)\r\n3) Use Image Size (in the Image Menu) to adjust your document to the size you want to print it.\r\n  	  	a) Maximum paper size is 13 inches by 44 inches.\r\nb) Ideal resolutions for the Epson 2200 are 360, 300, 240 and 180 dpi.\r\n  	4) Flatten your image. The &quot;Flatten Image&quot; action is found at the bottom of the &quot;Layer&quot; Menu.\r\n5) Save your file.\r\nEpson 2200 web site\r\nPaper Types for Epson 2200\r\nPrinting your Image\r\n  	Once you have prepared the image file for printing, use the following instructions to print the image file. You will be navigating three separate windows during the printing process.\r\nPrint Window - (Adobe)\r\n  	1) From the File Menu choose “Print with Preview” or type Command-P.\r\n2) The “Print” window appears. Choose “Page Setup…”\r\nPage Setup Window\r\n  	3) The “Page Setup” window appears.\r\n  	  	a) Click on the “Format for:” pop-up button. Choose “Stan 2200” or &quot;Betty 2200&quot;.\r\nb) Click on the “Paper Size:” pop-up button. Choose a paper size that is as large or larger than your document size. --- See chart on wall for paper sizes and corresponding names.\r\nMax paper size is 13 inches by 44 inches.\r\nc) From the “Orientation” section, choose Portrait(image more vertical) or Landscape(image more horizontal)\r\nd) Leave “Scale:” at 100%.\r\ne) Click the “OK” button.\r\nf) The “Page Setup” window closes and takes you back to the Print window.\r\nPrint Window - (Adobe)\r\n  	4) Your image should now fit within the preview pane in the upper left corner of the “Print” window. If not you have chosen a paper size that is too small or an incorrect orientation. Return to the “Page Setup” window.\r\n5) See Color Management handout for details on using ICC profiles.\r\n6) Click the “Print...” button.\r\nPrint Window - (Apple)\r\n  	7) The Photoshop “Print” window closes and the standard Apple “Print” window appears.\r\n  	  	a) Click on the “Printer” pop-up button. Choose “Stan 2200” or &quot;Betty 2200&quot;.\r\nb) Click on the “Copies and Pages” pop-up button. Choose “Print Settings”.\r\n  	  	  	i) Click the “Media Type” pop-up button. Choose your paper type.\r\nii) Click the “Advanced Settings” Mode radio button.\r\nii) Click on the “Print Quality” pop-up button. Choose your preferred resolution. 1440 for test prints and 2880 for final prints.\r\n  	  	c) Click the “Print” button at the lower right hand corner of the window.\r\nYour image should now print.\r\nTo check the printing status, open Print Center(in the Applications--&gt;Utilities folder)and double-click on the Color Stylus 2200. \r\n\r\n\r\nSOURCE: http://web.mit.edu/vap/resources/guides/epson2200.html  	 ', '', 1195311549, '', 2, 'c8h10n4o2', '66.68.51.87', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'c8h10n4o2', 3055, NULL, NULL, 0, 1195311530),
(21, 'Send Email', 55, '-=Email a file from cmd line=-\r\nuuencode &lt;file name&gt; | mail &lt;address&gt; -s &lt;subject&gt;\r\n\r\nEnter your body\r\n\r\n&lt;ctrl&gt;&lt;m&gt; to send', '', 1199380472, '', 1, 'c8h10n4o2', '24.153.198.63', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 152, NULL, NULL, 0, 1199380472),
(25, 'OS X', 39, '-= CISCO VPN =-\r\n[http://www.anders.com/cms/192/CiscoVPN/Error.51:.Unable.to.communicate.with.the.VPN.subsystem|Source Document]\r\n\r\nIf you are running Cisco''s VPNClient on Mac OSX, you might be familiar with (or tormented by) &quot;Error 51: Unable to communicate with the VPN subsystem&quot;. The simple fix is to quit VPNClient, open a Terminal window, (Applications -&gt; Utilities -&gt; Terminal) and type the following:\r\n\r\nsudo /System/Library/StartupItems/CiscoVPN/CiscoVPN restart\r\n\r\nand give your password when it asks. This will stop and start the &quot;VPN Subsystem&quot;, or in other words restart the CiscoVPN.kext extension. Cisco seems to have problems when network adapters disappear and reappear, something that happens commonly in Wireless or Dial-up scenerios. Sometimes putting a system to sleep, disconnecting an Ethernet cable or simply reconnecting your wireless will cause CiscoVPN to loose track of the network adapters on the system. Considering that CiscoVPN is typically used by telecommuters, this is an astonishing oversight on Cisco''s part. The above hack should side-step all of these issues by causing the CiscoVPN to re-initialize. It makes one ask, why couldn''t Cisco have just put the restart into their client? Or a better idea would be to not reinvent the wheel and use the existing IPSec VPN support in OSX! Am I missing something?', '', 1211421893, '', 1, 'c8h10n4o2', '66.68.52.223', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 1370, NULL, NULL, 0, 1211421893),
(24, 'Highpoint RocketRAID 1820A with Ubuntu', 475, 'So I had a RocketRAID 1820A card with a RAID5 running Windows 2000. I wanted to migrate to Ubuntu server edition. After a long amount of work trying to figure out HighPoint''s horrible instructions for building &amp; installing the driver in Linux, I finally found some instructions that worked. This instruction set is for 2.6.22-14-server kernel. Use uname -r to determine what kernel version you are using &amp; replace 2.6.22-14-server with your kernel version throughout the instructions.\r\n\r\n-=Sources:=-\r\nhttp://ubuntuforums.org/showthread.php?t=543872\r\nhttp://stefan.freyr.org/?page_id=6\r\nhttp://www.skullbox.net/newsda.php\r\n\r\n-=Instructions=-\r\n#Purchase additional hard drives &amp; __~~#FF0000:BACK UP YOUR DATA~~__\r\n#Download Linux driver source @ http://www.highpoint-tech.com/\r\n#Extract to /usr/src/rraiddriver\r\n#Install linux build tools so you can build the driver%%%^apt-get install build-essential^\r\n#Build the driver\r\n##Determine your current kernel version%%%^uname -r^\r\n##Build the driver%%%^cd /usr/src/rraiddriver%%%make KERNELDIR=/usr/src/linux-headers-&lt;kernel_version&gt;2.6.22-14-server^%%%*Note: change &quot;linux-headers-2.6.xxxxxxx&quot; into your kernelversion.\r\n#Now you have 2 compiled drivers (modules?) named hptmv.o (for 2.4 kernels) and hptmv.ko (for 2.6 kernels)\r\n#Manually install driver into kernel as follows (I had 2.6 kernel):\r\n##^sudo cp ./hptmv.ko /lib/modules/2.6.22-14-server/kernel/drivers/scsi/^\r\n#Generate a module dependancy “map” to be able to use modprobe to load hptmv.ko and all modules it depends upon (such as sd_mod) automatically.%%%^sudo depmod -a^\r\n#Make your system load hptmv on startup%%%^add &quot;hptmv&quot; to /etc/modules^\r\n#Prevent your system from loading sata_mv on startup%%%^add &quot;blacklist sata_mv&quot; to /etc/modprobe.d/blacklist^\r\n#Recreate the ramfs image that is loaded @ boot time. Done because we are modifying a &quot;stock&quot; kernel%%%^add &quot;hptmv&quot; to /etc/initramfs-tools/modules^%%%^update-initramfs -k &quot;2.6.22-14-server&quot; -c^\r\n#reboot\r\n#If the system boots succesfully you can check if the new hptmv module is loaded correctly by comparing the output below against the output of your system:%%%^c8h10n4o2@server:~$ lsmod | grep hpt%%%hptmv                 204936  1%%%scsi_mod              146828  5 sbp2,sg,sd_mod,libata,hptmv^\r\n!!If you want to mount the NTFS formated drive\r\n#Add the drive to your fstab to mount%%%^vi /etc/fstab%%%/dev/sda1       /media/raid ntfs-3g  defaults,locale=en_US.utf8 0 0^\r\n#Make the RAID drive%%%^mkdir /media/raid^\r\n#Mount the RAID%%%^sudo mount /media/raid^\r\n!!If you want to mount &amp; format in ext3\r\n#Add the drive to your fstab to mount%%%^vi /etc/fstab%%%/dev/sda1       /media/raid ext3 user,auto 1 2^\r\n#Make the RAID drive%%%^mkdir /media/raid^\r\n#Mount the RAID%%%^sudo mount /media/raid^\r\n!!If you want to partition &amp; format the drive\r\nA great reference for partitioning &amp; formatting is @ http://www.skullbox.net/newsda.php\r\n\r\n\r\n ', '', 1203781720, '', 1, 'admin', '66.68.51.87', '', NULL, NULL, NULL, NULL, NULL, NULL, 'c8h10n4o2', 2998, NULL, NULL, 0, 1203781720),
(26, 'Rational ClearCase', 52, '-=Create a new Snapshot View=-\r\n#clearcase create view\r\n+{CODE()}\r\n[unixuser@unixbox]/home/unixuser&gt;cleartool mkview -snap -stgloc clearcase_home_ccstg -stream STREAM_NAME@/DC_Projects NEW_VIEW\r\n{CODE}\r\n#go into another view and check out the config spec\r\n+{CODE()}\r\n[unixuser@unixbox]/home/unixuser/EXISTING_VIEW&gt; cleartool catcs\r\n{CODE}\r\n+*This gives me:\r\n+{CODE()}\r\nucm\r\nidentity UCM.Stream\r\noid:b701620c.88e64667.a1fa.4a:64:0a:55:e6:c0@vobuuid:e0023e99.5ebc4275.a\r\n0c3.43:95:ee:dd:f1:0d 19\r\n\r\n# ONLY EDIT THIS CONFIG SPEC IN THE INDICATED &quot;CUSTOM&quot; AREAS\r\n#\r\n# This config spec was automatically generated by the UCM stream\r\n# &quot;EXISTING_VIEW&quot; at 2008-08-04T10:22:37-05.\r\n#\r\n\r\n\r\n\r\n# Select checked out versions                                                                               \r\nelement * CHECKEDOUT\r\n\r\n# Component selection rules...\r\n\r\nelement &quot;[763e4aeee7744fa0bd216b1c200660b8=\\VOB_2]/...&quot;\r\n.../EXISTING_VIEW/LATEST\r\nelement &quot;[763e4aeee7744fa0bd216b1c200660b8=\\VOB_2]/...&quot;\r\n2008-08-04_VOB_2_72.2.10.7169 -mkbranch EXISTING_VIEW\r\nelement &quot;[763e4aeee7744fa0bd216b1c200660b8=\\VOB_2]/...&quot; /main/0\r\n-mkbranch EXISTING_VIEW\r\n\r\nelement &quot;[e3b9d825c5e14f0092094576dca8821d=\\VOB_1]/...&quot;\r\nArch_9_20_2007_fix_3 -nocheckout\r\n\r\n\r\nend ucm\r\n\r\n#UCMCustomElemBegin - DO NOT REMOVE - ADD CUSTOM ELEMENT RULES AFTER\r\nTHIS LINE\r\n#UCMCustomElemEnd - DO NOT REMOVE - END CUSTOM ELEMENT RULES\r\n\r\n# Non-included component backstop rule: no checkouts\r\nelement * /main/0 -ucm -nocheckout\r\n\r\n#UCMCustomLoadBegin - DO NOT REMOVE - ADD CUSTOM LOAD RULES AFTER THIS LINE\r\nload /VOB_1\r\nload /VOB_2\r\n{CODE}\r\n#Copy the lines under __ADD CUSTOM LOAD RULES AFTER THIS LINE__\r\n+{CODE()}\r\nload /VOB_1\r\nload /VOB_2\r\n{CODE}\r\n#CD into back into the dir of the view you created\r\n+{CODE()}\r\n[unixuser@unixbox]/home/unixuser/EXISTING_VIEW&gt; cd ../NEW_VIEW\r\n{CODE}\r\n#Edit your new view''s config spec\r\n+{CODE()}\r\n[unixuser@unixbox]/home/unixuser/NEW_VIEW&gt; cleartool edcs\r\n{CODE}\r\n#Paste the two copied lines under __ADD CUSTOM LOAD RULES AFTER THIS LINE__\r\n#Save your file\r\n+{CODE()}\r\n:wq\r\n{CODE}\r\n#When you save, it will update your view\r\n\r\n-=Set Config Spec from cmd line=-\r\n{CODE()}\r\ncleartool update -add_loadrules \\VOB_1 \\VOB_2 \\VOB_3 \\VOB_4\r\n{CODE}\r\n\r\n-=View Project Details=-\r\n{CODE()}\r\n[user@boxname]/home/user&gt; cleartool desc vob:/demo_project\r\nversioned object base &quot;/demo_project&quot;\r\n  created 2008-02-04T16:31:14-06 by caffeine.s.god.Domain Users@7LQ1891\r\n  &quot;Test CC Project.&quot;\r\n  project VOB\r\n  VOB family feature level: 5\r\n  VOB storage host:pathname &quot;VobBox:d:\\ClearCase_Storage\\VOBs\\demo_project.vbs&quot;\r\n  VOB storage global pathname &quot;&lt;no-gpath&gt;&quot;\r\n  database schema version: 54\r\n  modification by remote privileged user: allowed\r\n  VOB ownership:\r\n    owner nobody\r\n    group nobody\r\n  Additional groups:\r\n    group domain.net/ccusers\r\n  promotion levels:\r\n    REJECTED\r\n    INITIAL\r\n    BUILT\r\n    TESTED\r\n    RELEASED\r\n  default promotion level: INITIAL\r\n  Attributes:\r\n    FeatureLevel = 5\r\n  Hyperlinks:\r\n    AdminVOB &lt;- vob:/demo_ccd\r\n    AdminVOB &lt;- vob:/demo_dao\r\n    AdminVOB &lt;- vob:/demo_bo\r\n    AdminVOB &lt;- vob:/demo_composite\r\n    AdminVOB &lt;- vob:/demo_batch\r\n{CODE}\r\n\r\n-=List Baselines in a stream=-\r\n{CODE()}\r\n[user@boxname]/home/user&gt; /opt/rational/clearcase/bin/cleartool lsbl -s -stream APP_73.2.0.0_Tst@/My_Projects\r\nAPP_73.2.0.0_9_4_2008.5244\r\n2008_09_08_APP_73.0.1.0_1.3087\r\n2009-09-09_APP__73.2.0_2.8429\r\n{CODE}', '', 1222112990, '', 10, 'c8h10n4o2', '168.40.105.128', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'admin', 3551, NULL, NULL, 0, 1219778881);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_pageviews`
--

CREATE TABLE IF NOT EXISTS `tiki_pageviews` (
  `day` int(14) NOT NULL default '0',
  `pageviews` int(14) default NULL,
  PRIMARY KEY  (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_pageviews`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_poll_objects`
--

CREATE TABLE IF NOT EXISTS `tiki_poll_objects` (
  `catObjectId` int(11) NOT NULL default '0',
  `pollId` int(11) NOT NULL default '0',
  `title` varchar(255) default NULL,
  PRIMARY KEY  (`catObjectId`,`pollId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_poll_objects`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_poll_options`
--

CREATE TABLE IF NOT EXISTS `tiki_poll_options` (
  `pollId` int(8) NOT NULL default '0',
  `optionId` int(8) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `position` int(4) NOT NULL default '0',
  `votes` int(8) default NULL,
  PRIMARY KEY  (`optionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_poll_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_polls`
--

CREATE TABLE IF NOT EXISTS `tiki_polls` (
  `pollId` int(8) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `votes` int(8) default NULL,
  `active` char(1) default NULL,
  `publishDate` int(14) default NULL,
  PRIMARY KEY  (`pollId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_polls`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_preferences`
--

CREATE TABLE IF NOT EXISTS `tiki_preferences` (
  `name` varchar(40) NOT NULL default '',
  `value` varchar(250) default NULL,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_preferences`
--

INSERT INTO `tiki_preferences` (`name`, `value`) VALUES
('allowRegister', 'n'),
('anonCanEdit', 'n'),
('art_list_author', 'y'),
('art_list_date', 'y'),
('art_list_expire', 'y'),
('art_list_img', 'y'),
('art_list_reads', 'y'),
('art_list_size', 'y'),
('art_list_title', 'y'),
('art_list_topic', 'y'),
('art_list_type', 'y'),
('art_list_visible', 'y'),
('article_comments_default_ordering', 'points_desc'),
('article_comments_per_page', '10'),
('auth_create_user_auth', 'n'),
('auth_create_user_tiki', 'n'),
('auth_imap_pop3_basedsn', ''),
('auth_ldap_adminpass', ''),
('auth_ldap_adminuser', ''),
('auth_ldap_basedn', ''),
('auth_ldap_groupattr', 'cn'),
('auth_ldap_groupdn', ''),
('auth_ldap_groupoc', 'groupOfUniqueNames'),
('auth_ldap_memberattr', 'uniqueMember'),
('auth_ldap_memberisdn', 'n'),
('auth_ldap_scope', 'sub'),
('auth_ldap_url', ''),
('auth_ldap_userattr', 'uid'),
('auth_ldap_userdn', ''),
('auth_ldap_useroc', 'inetOrgPerson'),
('auth_method', 'tiki'),
('auth_pear_host', 'localhost'),
('auth_pear_port', '389'),
('auth_skip_admin', 'y'),
('auth_type', 'LDAP'),
('available_languages', 'a:0:{}'),
('available_styles', 'a:0:{}'),
('blog_comments_default_ordering', 'points_desc'),
('blog_comments_per_page', '10'),
('blog_list_activity', 'y'),
('blog_list_created', 'y'),
('blog_list_description', 'y'),
('blog_list_lastmodif', 'y'),
('blog_list_order', 'created_desc'),
('blog_list_posts', 'y'),
('blog_list_title', 'y'),
('blog_list_user', 'n'),
('blog_list_visits', 'y'),
('blog_spellcheck', 'n'),
('cacheimages', 'n'),
('cachepages', 'n'),
('calendar_sticky_popup', 'n'),
('calendar_view_tab', 'n'),
('change_language', 'y'),
('change_password', 'y'),
('change_theme', 'y'),
('cms_bot_bar', 'y'),
('cms_left_column', 'y'),
('cms_right_column', 'y'),
('cms_spellcheck', 'n'),
('cms_top_bar', 'n'),
('contact_anon', 'n'),
('contact_user', 'admin'),
('count_admin_pvs', 'y'),
('default_map', 'pacific.map'),
('default_wiki_diff_style', 'minsidediff'),
('direct_pagination', 'n'),
('directory_columns', '3'),
('directory_cool_sites', 'y'),
('directory_links_per_page', '20'),
('directory_open_links', 'n'),
('directory_validate_urls', 'n'),
('display_timezone', 'EST'),
('eponymousGroups', 'n'),
('faq_comments_default_ordering', 'points_desc'),
('faq_comments_per_page', '10'),
('feature_article_comments', 'n'),
('feature_articles', 'n'),
('feature_autolinks', 'y'),
('feature_babelfish', 'n'),
('feature_babelfish_logo', 'n'),
('feature_backlinks', 'y'),
('feature_banners', 'n'),
('feature_banning', 'n'),
('feature_blog_comments', 'n'),
('feature_blog_rankings', 'y'),
('feature_blogposts_comments', 'n'),
('feature_blogposts_pings', 'y'),
('feature_blogs', 'n'),
('feature_bot_bar', 'y'),
('feature_bot_bar_debug', 'y'),
('feature_bot_bar_icons', 'y'),
('feature_calendar', 'n'),
('feature_categories', 'n'),
('feature_categoryobjects', 'n'),
('feature_categorypath', 'n'),
('feature_challenge', 'n'),
('feature_charts', 'n'),
('feature_chat', 'n'),
('feature_clear_passwords', 'n'),
('feature_cms_print', 'y'),
('feature_cms_rankings', 'y'),
('feature_cms_templates', 'n'),
('feature_comm', 'n'),
('feature_contact', 'n'),
('feature_custom_home', 'n'),
('feature_debug_console', 'n'),
('feature_debugger_console', 'n'),
('feature_detect_language', 'n'),
('feature_directory', 'n'),
('feature_drawings', 'n'),
('feature_dump', 'n'),
('feature_dynamic_content', 'n'),
('feature_edit_templates', 'n'),
('feature_editcss', 'n'),
('feature_eph', 'n'),
('feature_faq_comments', 'y'),
('feature_faqs', 'n'),
('feature_featuredLinks', 'y'),
('feature_file_galleries', 'n'),
('feature_file_galleries_comments', 'n'),
('feature_file_galleries_rankings', 'n'),
('feature_forum_parse', 'n'),
('feature_forum_quickjump', 'n'),
('feature_forum_rankings', 'y'),
('feature_forum_topicd', 'n'),
('feature_forums', 'n'),
('feature_friends', 'n'),
('feature_gal_batch', 'n'),
('feature_gal_imgcache', 'n'),
('feature_gal_rankings', 'y'),
('feature_gal_slideshow', 'y'),
('feature_galleries', 'n'),
('feature_games', 'n'),
('feature_help', 'n'),
('feature_history', 'y'),
('feature_hotwords', 'y'),
('feature_hotwords_nw', 'n'),
('feature_html_pages', 'n'),
('feature_image_galleries_comments', 'n'),
('feature_integrator', 'n'),
('feature_jscalendar', 'n'),
('feature_lastChanges', 'y'),
('feature_left_column', 'y'),
('feature_likePages', 'y'),
('feature_listPages', 'y'),
('feature_live_support', 'n'),
('feature_maps', 'n'),
('feature_menusfolderstyle', 'y'),
('feature_messages', 'n'),
('feature_minical', 'n'),
('feature_mobile', 'n'),
('feature_modulecontrols', 'n'),
('feature_multilingual', 'n'),
('feature_newsletters', 'n'),
('feature_newsreader', 'n'),
('feature_notepad', 'n'),
('feature_obzip', 'n'),
('feature_page_title', 'y'),
('feature_phplayers', 'n'),
('feature_phpopentracker', 'n'),
('feature_poll_anonymous', 'n'),
('feature_poll_comments', 'n'),
('feature_polls', 'n'),
('feature_quizzes', 'n'),
('feature_ranking', 'n'),
('feature_referer_stats', 'n'),
('feature_right_column', 'y'),
('feature_sandbox', 'y'),
('feature_score', 'n'),
('feature_search', 'y'),
('feature_search_fulltext', 'y'),
('feature_search_stats', 'n'),
('feature_sheet', 'n'),
('feature_shoutbox', 'n'),
('feature_smileys', 'y'),
('feature_stats', 'n'),
('feature_submissions', 'n'),
('feature_surveys', 'n'),
('feature_tabs', 'n'),
('feature_tasks', 'n'),
('feature_theme_control', 'n'),
('feature_ticketlib', 'n'),
('feature_ticketlib2', 'y'),
('feature_top_bar', 'y'),
('feature_trackbackpings', 'y'),
('feature_trackers', 'n'),
('feature_userPreferences', 'n'),
('feature_userVersions', 'n'),
('feature_user_bookmarks', 'n'),
('feature_user_watches', 'n'),
('feature_user_watches_translations', 'y'),
('feature_userfiles', 'n'),
('feature_usermenu', 'n'),
('feature_view_tpl', 'n'),
('feature_warn_on_edit', 'n'),
('feature_webmail', 'n'),
('feature_wiki', 'y'),
('feature_wiki_allowhtml', 'n'),
('feature_wiki_attachments', 'n'),
('feature_wiki_comments', 'n'),
('feature_wiki_description', 'n'),
('feature_wiki_discuss', 'n'),
('feature_wiki_export', 'n'),
('feature_wiki_footnotes', 'n'),
('feature_wiki_import_html', 'n'),
('feature_wiki_monosp', 'y'),
('feature_wiki_multiprint', 'n'),
('feature_wiki_notepad', 'n'),
('feature_wiki_open_as_structure', 'n'),
('feature_wiki_pdf', 'n'),
('feature_wiki_pictures', 'n'),
('feature_wiki_rankings', 'y'),
('feature_wiki_ratings', 'n'),
('feature_wiki_tables', 'old'),
('feature_wiki_templates', 'n'),
('feature_wiki_undo', 'n'),
('feature_wiki_userpage', 'y'),
('feature_wiki_userpage_prefix', 'UserPage'),
('feature_wiki_usrlock', 'n'),
('feature_wikiwords', 'y'),
('feature_workflow', 'n'),
('feature_wysiwyg', 'no'),
('feature_xmlrpc', 'n'),
('fgal_allow_duplicates', 'n'),
('fgal_list_created', 'y'),
('fgal_list_description', 'n'),
('fgal_list_files', 'y'),
('fgal_list_hits', 'y'),
('fgal_list_lastmodif', 'y'),
('fgal_list_name', 'y'),
('fgal_list_user', 'y'),
('fgal_match_regex', ''),
('fgal_nmatch_regex', ''),
('fgal_use_db', 'y'),
('fgal_use_dir', ''),
('file_galleries_comments_default_ordering', 'points_desc'),
('file_galleries_comments_per_page', '10'),
('forgotPass', 'n'),
('forum_list_desc', 'y'),
('forum_list_lastpost', 'y'),
('forum_list_posts', 'y'),
('forum_list_ppd', 'y'),
('forum_list_topics', 'y'),
('forum_list_visits', 'y'),
('forums_ordering', 'created_desc'),
('gal_batch_dir', ''),
('gal_imgcache_dir', 'temp/cache'),
('gal_list_created', 'y'),
('gal_list_description', 'y'),
('gal_list_imgs', 'y'),
('gal_list_lastmodif', 'y'),
('gal_list_name', 'y'),
('gal_list_user', 'y'),
('gal_list_visits', 'y'),
('gal_match_regex', ''),
('gal_nmatch_regex', ''),
('gal_use_db', 'y'),
('gal_use_dir', ''),
('gal_use_lib', 'gd'),
('groupTracker', 'n'),
('home_file_gallery', ''),
('http_domain', ''),
('http_port', '80'),
('http_prefix', '/'),
('https', 'auto'),
('https_domain', ''),
('https_login', 'n'),
('https_login_required', 'n'),
('https_port', '443'),
('https_prefix', '/'),
('image_galleries_comments_default_order', 'points_desc'),
('image_galleries_comments_per_page', '10'),
('keep_versions', '1'),
('lang_use_db', 'n'),
('language', 'en'),
('layout_section', 'n'),
('limitedGoGroupHome', 'y'),
('long_date_format', '%A %d of %B, %Y'),
('long_time_format', '%H:%M:%S %Z'),
('mail_crlf', 'LF'),
('map_path', '/home/h8ncom/public_html/map/'),
('maxArticles', '10'),
('maxRecords', '10'),
('maxVersions', '0'),
('max_rss_articles', '10'),
('max_rss_blog', '10'),
('max_rss_blogs', '10'),
('max_rss_directories', '10'),
('max_rss_file_galleries', '10'),
('max_rss_file_gallery', '10'),
('max_rss_forum', '10'),
('max_rss_forums', '10'),
('max_rss_image_galleries', '10'),
('max_rss_image_gallery', '10'),
('max_rss_mapfiles', '10'),
('max_rss_tracker', '10'),
('max_rss_wiki', '10'),
('min_pass_length', '1'),
('modallgroups', 'y'),
('pass_chr_num', 'n'),
('pass_due', '999'),
('poll_comments_default_ordering', 'points_desc'),
('poll_comments_per_page', '10'),
('popupLinks', 'n'),
('proxy_host', ''),
('proxy_port', ''),
('record_untranslated', 'n'),
('registerPasscode', ''),
('rememberme', 'disabled'),
('remembertime', '7200'),
('rnd_num_reg', 'n'),
('rss_articles', 'y'),
('rss_blog', 'n'),
('rss_blogs', 'y'),
('rss_directories', 'y'),
('rss_file_galleries', 'y'),
('rss_file_gallery', 'n'),
('rss_forum', 'y'),
('rss_forums', 'y'),
('rss_image_galleries', 'y'),
('rss_image_gallery', 'n'),
('rss_mapfiles', 'y'),
('rss_tracker', 'n'),
('rss_wiki', 'y'),
('rssfeed_creator', ''),
('rssfeed_css', 'y'),
('rssfeed_default_version', '2'),
('rssfeed_editor', ''),
('rssfeed_language', 'en-us'),
('rssfeed_publisher', ''),
('rssfeed_webmaster', ''),
('search_lru_length', '100'),
('search_lru_purge_rate', '5'),
('search_max_syllwords', '100'),
('search_min_wordlength', '3'),
('search_refresh_rate', '5'),
('search_syll_age', '48'),
('sender_email', ''),
('short_date_format', '%a %d of %b, %Y'),
('short_time_format', '%H:%M %Z'),
('shoutbox_autolink', 'n'),
('siteTitle', ''),
('slide_style', 'slidestyle.css'),
('style', 'tikineat.css'),
('system_os', 'unix'),
('t_use_db', 'y'),
('t_use_dir', ''),
('tikiIndex', 'tiki-index.php'),
('tmpDir', 'temp'),
('trk_with_mirror_tables', 'n'),
('uf_use_db', 'y'),
('uf_use_dir', ''),
('urlIndex', ''),
('useRegisterPasscode', 'n'),
('useUrlIndex', 'n'),
('use_proxy', 'n'),
('userTracker', 'n'),
('user_assigned_modules', 'n'),
('user_list_order', 'score_desc'),
('userfiles_quota', '30'),
('validateEmail', 'n'),
('validateRegistration', 'n'),
('validateUsers', 'n'),
('w_use_db', 'y'),
('w_use_dir', ''),
('warn_on_edit_time', '2'),
('webmail_max_attachment', '1500000'),
('webmail_view_html', 'y'),
('webserverauth', 'n'),
('wikiHomePage', 'HomePage'),
('wikiLicensePage', ''),
('wikiSubmitNotice', ''),
('wiki_bot_bar', 'n'),
('wiki_cache', '0'),
('wiki_comments_default_ordering', 'points_desc'),
('wiki_comments_per_page', '10'),
('wiki_creator_admin', 'n'),
('wiki_feature_copyrights', 'n'),
('wiki_forum', ''),
('wiki_forum_id', ''),
('wiki_left_column', 'y'),
('wiki_list_backlinks', 'y'),
('wiki_list_comment', 'y'),
('wiki_list_creator', 'y'),
('wiki_list_hits', 'y'),
('wiki_list_lastmodif', 'y'),
('wiki_list_lastver', 'y'),
('wiki_list_links', 'y'),
('wiki_list_name', 'y'),
('wiki_list_size', 'y'),
('wiki_list_status', 'y'),
('wiki_list_user', 'y'),
('wiki_list_versions', 'y'),
('wiki_page_regex', 'strict'),
('wiki_right_column', 'y'),
('wiki_spellcheck', 'n'),
('wiki_top_bar', 'n'),
('wiki_uses_slides', 'n'),
('wiki_wikisyntax_in_html', 'full'),
('messu_mailbox_size', '0'),
('messu_archive_size', '200'),
('messu_sent_size', '200'),
('case_patched', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_private_messages`
--

CREATE TABLE IF NOT EXISTS `tiki_private_messages` (
  `messageId` int(8) NOT NULL auto_increment,
  `toNickname` varchar(200) NOT NULL default '',
  `data` varchar(255) default NULL,
  `poster` varchar(200) NOT NULL default 'anonymous',
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`messageId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_private_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_programmed_content`
--

CREATE TABLE IF NOT EXISTS `tiki_programmed_content` (
  `pId` int(8) NOT NULL auto_increment,
  `contentId` int(8) NOT NULL default '0',
  `publishDate` int(14) NOT NULL default '0',
  `data` text,
  PRIMARY KEY  (`pId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_programmed_content`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_quicktags`
--

CREATE TABLE IF NOT EXISTS `tiki_quicktags` (
  `tagId` int(4) unsigned NOT NULL auto_increment,
  `taglabel` varchar(255) default NULL,
  `taginsert` text,
  `tagicon` varchar(255) default NULL,
  `tagcategory` varchar(255) default NULL,
  PRIMARY KEY  (`tagId`),
  KEY `tagcategory` (`tagcategory`),
  KEY `taglabel` (`taglabel`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

--
-- Dumping data for table `tiki_quicktags`
--

INSERT INTO `tiki_quicktags` (`tagId`, `taglabel`, `taginsert`, `tagicon`, `tagcategory`) VALUES
(1, 'bold', '__text__', 'images/ed_format_bold.gif', 'wiki'),
(2, 'italic', '''''text''''', 'images/ed_format_italic.gif', 'wiki'),
(3, 'underline', '===text===', 'images/ed_format_underline.gif', 'wiki'),
(4, 'table', '||r1c1|r1c2||r2c1|r2c2||', 'images/insert_table.gif', 'wiki'),
(5, 'table new', '||r1c1|r1c2\nr2c1|r2c2||', 'images/insert_table.gif', 'wiki'),
(6, 'external link', '[http://example.com|text]', 'images/ed_link.gif', 'wiki'),
(7, 'wiki link', '((text))', 'images/ed_copy.gif', 'wiki'),
(8, 'heading1', '!text', 'images/ed_custom.gif', 'wiki'),
(9, 'title bar', '-=text=-', 'images/fullscreen_maximize.gif', 'wiki'),
(10, 'box', '^text^', 'images/ed_about.gif', 'wiki'),
(11, 'rss feed', '{rss id= }', 'images/ico_link.gif', 'wiki'),
(12, 'dynamic content', '{content id= }', 'images/book.gif', 'wiki'),
(13, 'tagline', '{cookie}', 'images/footprint.gif', 'wiki'),
(14, 'hr', '---', 'images/ed_hr.gif', 'wiki'),
(15, 'center text', '::text::', 'images/ed_align_center.gif', 'wiki'),
(16, 'colored text', '~~#FF0000:text~~', 'images/fontfamily.gif', 'wiki'),
(17, 'dynamic variable', '%text%', 'images/book.gif', 'wiki'),
(18, 'image', '{img src= width= height= align= desc= link= }', 'images/ed_image.gif', 'wiki'),
(19, 'New wms Metadata', 'METADATA\r\n		"wms_name" "myname"\r\n 	"wms_srs" "EPSG:4326"\r\n 	"wms_server_version" " "\r\n 	"wms_layers" "mylayers"\r\n 	"wms_request" "myrequest"\r\n 	"wms_format" " "\r\n 	"wms_time" " "\r\n END', 'img/icons/admin_metatags.png', 'maps'),
(20, 'New Class', 'CLASS\r\n EXPRESSION ()\r\n SYMBOL 0\r\n OUTLINECOLOR\r\n COLOR\r\n NAME "myclass" \r\nEND #end of class', 'img/icons/mini_triangle.gif', 'maps'),
(21, 'New Projection', 'PROJECTION\r\n "init=epsg:4326"\r\nEND', 'images/ico_mode.gif', 'maps'),
(22, 'New Query', '#\r\n# Start of query definitions\r\n#\r\n QUERYMAP\r\n STATUS ON\r\n STYLE HILITE\r\nEND', 'img/icons/questions.gif', 'maps'),
(23, 'New Scalebar', '#\r\n# Start of scalebar\r\n#\r\nSCALEBAR\r\n IMAGECOLOR 255 255 255\r\n STYLE 1\r\n SIZE 400 2\r\n COLOR 0 0 0\r\n UNITS KILOMETERS\r\n INTERVALS 5\r\n STATUS ON\r\nEND', 'img/icons/desc_length.gif', 'maps'),
(24, 'New Layer', 'LAYER\r\n NAME\r\n TYPE\r\n STATUS ON\r\n DATA "mydata"\r\nEND #end of layer', 'images/ed_copy.gif', 'maps'),
(25, 'New Label', 'LABEL\r\n COLOR\r\n ANGLE\r\n FONT arial\r\n TYPE TRUETYPE\r\n POSITION\r\n PARTIALS TRUE\r\n SIZE 6\r\n BUFFER 0\r\n OUTLINECOLOR \r\nEND #end of label', 'img/icons/fontfamily.gif', 'maps'),
(26, 'New Reference', '#\r\n#start of reference\r\n#\r\n REFERENCE\r\n SIZE 120 60\r\n STATUS ON\r\n EXTENT -180 -90 182 88\r\n OUTLINECOLOR 255 0 0\r\n IMAGE "myimagedata"\r\n COLOR -1 -1 -1\r\nEND', 'images/ed_image.gif', 'maps'),
(27, 'New Legend', '#\r\n#start of Legend\r\n#\r\n LEGEND\r\n KEYSIZE 18 12\r\n POSTLABELCACHE TRUE\r\n STATUS ON\r\nEND', 'images/ed_about.gif', 'maps'),
(28, 'New Web', '#\r\n# Start of web interface definition\r\n#\r\nWEB\r\n TEMPLATE "myfile/url"\r\n MINSCALE 1000\r\n MAXSCALE 40000\r\n IMAGEPATH "myimagepath"\r\n IMAGEURL "mypath"\r\nEND', 'img/icons/ico_link.gif', 'maps'),
(29, 'New Outputformat', 'OUTPUTFORMAT\r\n NAME\r\n DRIVER " "\r\n MIMETYPE "myimagetype"\r\n IMAGEMODE RGB\r\n EXTENSION "png"\r\nEND', 'img/icons/opera.gif', 'maps'),
(30, 'New Mapfile', '#\r\n# Start of mapfile\r\n#\r\nNAME MYMAPFLE\r\n STATUS ON\r\nSIZE \r\nEXTENT\r\nUNITS \r\nSHAPEPATH " "\r\nIMAGETYPE " "\r\nFONTSET " "\r\nIMAGECOLOR -1 -1 -1\r\n\r\n#remove this text and add objects here\r\n\r\nEND # end of mapfile', 'img/icons/global.gif', 'maps'),
(31, 'bold', '__text__', 'images/ed_format_bold.gif', 'newsletters'),
(32, 'italic', '''''text''''', 'images/ed_format_italic.gif', 'newsletters'),
(33, 'underline', '===text===', 'images/ed_format_underline.gif', 'newsletters'),
(34, 'external link', '[http://example.com|text|nocache]', 'images/ed_link.gif', 'newsletters'),
(35, 'heading1', '!text', 'images/ed_custom.gif', 'newsletters'),
(36, 'hr', '---', 'images/ed_hr.gif', 'newsletters'),
(37, 'center text', '::text::', 'images/ed_align_center.gif', 'newsletters'),
(38, 'colored text', '~~#FF0000:text~~', 'images/fontfamily.gif', 'newsletters'),
(39, 'image', '{img src= width= height= align= desc= link= }', 'images/ed_image.gif', 'newsletters'),
(40, 'New wms Metadata', 'METADATA\r\n		"wms_name" "myname"\r\n		"wms_srs" "EPSG:4326"\r\n	"wms_server_version" " "\r\n	"wms_layers" "mylayers"\r\n	"wms_request" "myrequest"\r\n	"wms_format" " "\r\n	"wms_time" " "\r\n END', 'img/icons/admin_metatags.png', 'maps'),
(41, 'New Class', 'CLASS\r\n EXPRESSION ()\r\n SYMBOL 0\r\n OUTLINECOLOR\r\n COLOR\r\n  NAME "myclass"\r\nEND #end of class', 'img/icons/mini_triangle.gif', 'maps'),
(42, 'New Query', '#\r\n#Start of query definitions\r\n QUERYMAP\r\n STATUS ON\r\n STYLE HILITE\r\nEND', 'img/icons/question.gif', 'maps'),
(43, 'New Scalebar', '#\r\n#start of scalebar\r\nSCALEBAR\r\n IMAGECOLOR 255 255 255\r\n STYLE 1\r\n SIZE 400 2\r\n COLOR 0 0 0\r\n  UNITS KILOMETERS\r\n INTERVALS 5\r\n STATUS ON\r\nEND', 'img/icons/desc_lenght.gif', 'maps'),
(44, 'New Layer', 'LAYER\r\n NAME "mylayer"\r\n TYPE\r\n STATUS ON\r\n DATA "mydata"\r\nEND #end of layer', 'img/ed_copy.gif', 'maps'),
(45, 'New Label', 'LABEL\r\n  COLOR\r\n ANGLE\r\n FONT arial\r\n TYPE TRUETYPE\r\n  POSITION\r\n  PARTIALS TRUE\r\n  SIZE 6\r\n  BUFFER 0\r\n OUTLINECOLOR\r\nEND #end of label', 'img/icons/fontfamily.gif', 'maps'),
(46, 'New Reference', '#\r\n#start of reference\r\nREFERENCE\r\n SIZE 120 60\r\n STATUS ON\r\n  EXTENT -180 -90 182 88\r\n OUTLINECOLOR 255 0 0\r\n IMAGE "myimagedata"\r\nCOLOR -1 -1 -1\r\nEND', 'images/ed_image.gif', 'maps'),
(47, 'New Legend', '#\r\n#start of legend\r\n#\r\nLEGENDr\n KEYSIZE 18 12\r\n POSTLABELCACHE TRUE\r\n STATUS ON\r\nEND', 'images/ed_about.gif', 'maps'),
(48, 'New Web', '#\r\n#Start of web interface definition\r\n#\r\nWEB\r\n TEMPLATE "myfile/url"\r\n MINSCALE 1000\r\n MAXSCALE 40000\r\n IMAGEPATH "myimagepath"\r\n IMAGEURL "mypath"\r\nEND', 'img/icons/ico_link.gif', 'maps'),
(49, 'New Mapfile', '#\r\n#Start of mapfile\r\n#\r\nNAME MYMAPFILE\r\n STATUS ON\r\nSIZE \r\nEXTENT\r\n UNITS\r\nSHAPEPATH " "\r\nIMAGETYPE " "\r\nFONTSET " "\r\nIMAGECOLOR -1 -1 -1\r\n\r\n#remove this text and add objects here\r\n\r\nEND # end of mapfile', 'img/icons/global.gif', 'maps');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_quiz_question_options`
--

CREATE TABLE IF NOT EXISTS `tiki_quiz_question_options` (
  `optionId` int(10) NOT NULL auto_increment,
  `questionId` int(10) default NULL,
  `optionText` text,
  `points` int(4) default NULL,
  PRIMARY KEY  (`optionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_quiz_question_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_quiz_questions`
--

CREATE TABLE IF NOT EXISTS `tiki_quiz_questions` (
  `questionId` int(10) NOT NULL auto_increment,
  `quizId` int(10) default NULL,
  `question` text,
  `position` int(4) default NULL,
  `type` char(1) default NULL,
  `maxPoints` int(4) default NULL,
  PRIMARY KEY  (`questionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_quiz_questions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_quiz_results`
--

CREATE TABLE IF NOT EXISTS `tiki_quiz_results` (
  `resultId` int(10) NOT NULL auto_increment,
  `quizId` int(10) default NULL,
  `fromPoints` int(4) default NULL,
  `toPoints` int(4) default NULL,
  `answer` text,
  PRIMARY KEY  (`resultId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_quiz_results`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_quiz_stats`
--

CREATE TABLE IF NOT EXISTS `tiki_quiz_stats` (
  `quizId` int(10) NOT NULL default '0',
  `questionId` int(10) NOT NULL default '0',
  `optionId` int(10) NOT NULL default '0',
  `votes` int(10) default NULL,
  PRIMARY KEY  (`quizId`,`questionId`,`optionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_quiz_stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_quiz_stats_sum`
--

CREATE TABLE IF NOT EXISTS `tiki_quiz_stats_sum` (
  `quizId` int(10) NOT NULL default '0',
  `quizName` varchar(255) default NULL,
  `timesTaken` int(10) default NULL,
  `avgpoints` decimal(5,2) default NULL,
  `avgavg` decimal(5,2) default NULL,
  `avgtime` decimal(5,2) default NULL,
  PRIMARY KEY  (`quizId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_quiz_stats_sum`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_quizzes`
--

CREATE TABLE IF NOT EXISTS `tiki_quizzes` (
  `quizId` int(10) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `canRepeat` char(1) default NULL,
  `storeResults` char(1) default NULL,
  `questionsPerPage` int(4) default NULL,
  `timeLimited` char(1) default NULL,
  `timeLimit` int(14) default NULL,
  `created` int(14) default NULL,
  `taken` int(10) default NULL,
  `immediateFeedback` char(1) default NULL,
  `showAnswers` char(1) default NULL,
  `shuffleQuestions` char(1) default NULL,
  `shuffleAnswers` char(1) default NULL,
  `publishDate` int(14) default NULL,
  `expireDate` int(14) default NULL,
  `bDeleted` char(1) default NULL,
  `nVersion` int(4) NOT NULL default '0',
  `nAuthor` int(4) default NULL,
  `bOnline` char(1) default NULL,
  `bRandomQuestions` char(1) default NULL,
  `nRandomQuestions` tinyint(4) default NULL,
  `bLimitQuestionsPerPage` char(1) default NULL,
  `nLimitQuestionsPerPage` tinyint(4) default NULL,
  `bMultiSession` char(1) default NULL,
  `nCanRepeat` tinyint(4) default NULL,
  `sGradingMethod` varchar(80) default NULL,
  `sShowScore` varchar(80) default NULL,
  `sShowCorrectAnswers` varchar(80) default NULL,
  `sPublishStats` varchar(80) default NULL,
  `bAdditionalQuestions` char(1) default NULL,
  `bForum` char(1) default NULL,
  `sForum` varchar(80) default NULL,
  `sPrologue` text,
  `sData` text,
  `sEpilogue` text,
  `passingperct` int(4) default '0',
  PRIMARY KEY  (`quizId`,`nVersion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_quizzes`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_received_articles`
--

CREATE TABLE IF NOT EXISTS `tiki_received_articles` (
  `receivedArticleId` int(14) NOT NULL auto_increment,
  `receivedFromSite` varchar(200) default NULL,
  `receivedFromUser` varchar(200) default NULL,
  `receivedDate` int(14) default NULL,
  `title` varchar(80) default NULL,
  `authorName` varchar(60) default NULL,
  `size` int(12) default NULL,
  `useImage` char(1) default NULL,
  `image_name` varchar(80) default NULL,
  `image_type` varchar(80) default NULL,
  `image_size` int(14) default NULL,
  `image_x` int(4) default NULL,
  `image_y` int(4) default NULL,
  `image_data` longblob,
  `publishDate` int(14) default NULL,
  `expireDate` int(14) default NULL,
  `created` int(14) default NULL,
  `heading` text,
  `body` longblob,
  `hash` varchar(32) default NULL,
  `author` varchar(200) default NULL,
  `type` varchar(50) default NULL,
  `rating` decimal(3,2) default NULL,
  PRIMARY KEY  (`receivedArticleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_received_articles`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_received_pages`
--

CREATE TABLE IF NOT EXISTS `tiki_received_pages` (
  `receivedPageId` int(14) NOT NULL auto_increment,
  `pageName` varchar(160) NOT NULL default '',
  `data` longblob,
  `description` varchar(200) default NULL,
  `comment` varchar(200) default NULL,
  `receivedFromSite` varchar(200) default NULL,
  `receivedFromUser` varchar(200) default NULL,
  `receivedDate` int(14) default NULL,
  PRIMARY KEY  (`receivedPageId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_received_pages`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_referer_stats`
--

CREATE TABLE IF NOT EXISTS `tiki_referer_stats` (
  `referer` varchar(255) NOT NULL default '',
  `hits` int(10) default NULL,
  `last` int(14) default NULL,
  PRIMARY KEY  (`referer`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_referer_stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_related_categories`
--

CREATE TABLE IF NOT EXISTS `tiki_related_categories` (
  `categId` int(10) NOT NULL default '0',
  `relatedTo` int(10) NOT NULL default '0',
  PRIMARY KEY  (`categId`,`relatedTo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_related_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_rss_feeds`
--

CREATE TABLE IF NOT EXISTS `tiki_rss_feeds` (
  `name` varchar(30) NOT NULL default '',
  `rssVer` char(1) NOT NULL default '1',
  `refresh` int(8) default '300',
  `lastUpdated` int(14) default NULL,
  `cache` longblob,
  PRIMARY KEY  (`name`,`rssVer`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_rss_feeds`
--

INSERT INTO `tiki_rss_feeds` (`name`, `rssVer`, `refresh`, `lastUpdated`, `cache`) VALUES
('wiki', '2', 0, 1257987372, 0x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c212d2d2067656e657261746f723d2254696b6920434d532f47726f75707761726520766961204665656443726561746f7220312e372e3222202d2d3e0a3c3f786d6c2d7374796c65736865657420687265663d22687474703a2f2f7777772e48384e2e434f4d2f6c69622f7273732f7273732d7374796c652e6373732220747970653d22746578742f637373223f3e0a3c3f786d6c2d7374796c65736865657420687265663d22687474703a2f2f7777772e48384e2e434f4d2f6c69622f7273732f72737332302e78736c2220747970653d22746578742f78736c223f3e0a3c7273732076657273696f6e3d22322e30223e0a202020203c6368616e6e656c3e0a20202020202020203c7469746c653e54696b6920525353206665656420666f72207468652077696b692070616765733c2f7469746c653e0a20202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a20202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d77696b695f7273732e7068703f7665723d323c2f6c696e6b3e0a20202020202020203c6c6173744275696c64446174653e5765642c203131204e6f7620323030392031393a35363a3132202b303130303c2f6c6173744275696c64446174653e0a20202020202020203c67656e657261746f723e54696b6920434d532f47726f75707761726520766961204665656443726561746f7220312e372e323c2f67656e657261746f723e0a20202020202020203c696d6167653e0a2020202020202020202020203c75726c3e687474703a2f2f7777772e48384e2e434f4d2f696d672f74696b692e6a70673c2f75726c3e0a2020202020202020202020203c7469746c653e74696b6977696b69206c6f676f3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c215b43444154415b466565642070726f766964656420627920687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068702e20436c69636b20746f2076697369742e5d5d3e3c2f6465736372697074696f6e3e0a20202020202020203c2f696d6167653e0a20202020202020203c6c616e67756167653e656e2d75733c2f6c616e67756167653e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e53797374656d3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d53797374656d3c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5468752c203032204f637420323030382031383a34363a3232202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e526174696f6e616c20436c656172436173653c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d526174696f6e616c2b436c656172436173653c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e4d6f6e2c2032322053657020323030382031393a34393a3530202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e486f6d65506167653c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d486f6d65506167653c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5475652c2032362041756720323030382031383a30343a3236202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e4f5320583c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d4f532b583c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5468752c203232204d617920323030382030323a30343a3533202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e4e6574776f726b696e673c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d4e6574776f726b696e673c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e4d6f6e2c203033204d617220323030382030313a31363a3133202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e48696768706f696e7420526f636b6574524149442031383230412077697468205562756e74753c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d48696768706f696e742b526f636b6574524149442b31383230412b776974682b5562756e74753c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e61646d696e3c2f617574686f723e0a2020202020202020202020203c707562446174653e5361742c2032332046656220323030382031353a34383a3430202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e4c696e75783c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d4c696e75783c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5361742c2032332046656220323030382031353a34343a3533202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e53756276657273696f6e3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d53756276657273696f6e3c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5361742c203035204a616e20323030382031373a35373a3231202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e46696c652053797374656d3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d46696c652b53797374656d3c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e4672692c203034204a616e20323030382031333a30383a3439202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e52756e6e696e672050726f6365737365733c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e48384e2e434f4d2f74696b692d696e6465782e7068703f706167653d52756e6e696e672b50726f6365737365733c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5468752c203033204a616e20323030382031383a35363a3133202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a202020203c2f6368616e6e656c3e0a3c2f7273733e0a),
('wiki', 'h', 0, 1, 0x2d),
('wiki', '9', 0, 1222705793, 0x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c212d2d2067656e657261746f723d2254696b6920434d532f47726f75707761726520766961204665656443726561746f7220312e372e3222202d2d3e0a3c3f786d6c2d7374796c65736865657420687265663d22687474703a2f2f7777772e68386e2e636f6d2f6c69622f7273732f7273732d7374796c652e6373732220747970653d22746578742f637373223f3e0a3c7273732076657273696f6e3d22302e3931223e0a202020203c6368616e6e656c3e0a20202020202020203c7469746c653e54696b6920525353206665656420666f72207468652077696b692070616765733c2f7469746c653e0a20202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a20202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d77696b695f7273732e7068703c2f6c696e6b3e0a20202020202020203c6c6173744275696c64446174653e4d6f6e2c2032392053657020323030382031313a32393a3533202b303130303c2f6c6173744275696c64446174653e0a20202020202020203c67656e657261746f723e54696b6920434d532f47726f75707761726520766961204665656443726561746f7220312e372e323c2f67656e657261746f723e0a20202020202020203c696d6167653e0a2020202020202020202020203c75726c3e687474703a2f2f7777772e68386e2e636f6d2f696d672f74696b692e6a70673c2f75726c3e0a2020202020202020202020203c7469746c653e74696b6977696b69206c6f676f3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c215b43444154415b466565642070726f766964656420627920687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068702e20436c69636b20746f2076697369742e5d5d3e3c2f6465736372697074696f6e3e0a20202020202020203c2f696d6167653e0a20202020202020203c6c616e67756167653e656e2d75733c2f6c616e67756167653e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e526174696f6e616c20436c656172436173653c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d526174696f6e616c2b436c656172436173653c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e4d6f6e2c2032322053657020323030382031393a34393a3530202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e486f6d65506167653c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d486f6d65506167653c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5475652c2032362041756720323030382031383a30343a3236202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e4f5320583c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d4f532b583c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5468752c203232204d617920323030382030323a30343a3533202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e4e6574776f726b696e673c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d4e6574776f726b696e673c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e4d6f6e2c203033204d617220323030382030313a31363a3133202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e48696768706f696e7420526f636b6574524149442031383230412077697468205562756e74753c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d48696768706f696e742b526f636b6574524149442b31383230412b776974682b5562756e74753c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e61646d696e3c2f617574686f723e0a2020202020202020202020203c707562446174653e5361742c2032332046656220323030382031353a34383a3430202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e4c696e75783c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d4c696e75783c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5361742c2032332046656220323030382031353a34343a3533202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e53756276657273696f6e3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d53756276657273696f6e3c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5361742c203035204a616e20323030382031373a35373a3231202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e46696c652053797374656d3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d46696c652b53797374656d3c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e4672692c203034204a616e20323030382031333a30383a3439202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e52756e6e696e672050726f6365737365733c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d52756e6e696e672b50726f6365737365733c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5468752c203033204a616e20323030382031383a35363a3133202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a20202020202020203c6974656d3e0a2020202020202020202020203c7469746c653e53656e6420456d61696c3c2f7469746c653e0a2020202020202020202020203c6c696e6b3e687474703a2f2f7777772e68386e2e636f6d2f74696b692d696e6465782e7068703f706167653d53656e642b456d61696c3c2f6c696e6b3e0a2020202020202020202020203c6465736372697074696f6e3e3c2f6465736372697074696f6e3e0a2020202020202020202020203c617574686f723e63386831306e346f323c2f617574686f723e0a2020202020202020202020203c707562446174653e5468752c203033204a616e20323030382031373a31343a3332202b303130303c2f707562446174653e0a20202020202020203c2f6974656d3e0a202020203c2f6368616e6e656c3e0a3c2f7273733e0a);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_rss_modules`
--

CREATE TABLE IF NOT EXISTS `tiki_rss_modules` (
  `rssId` int(8) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `description` text,
  `url` varchar(255) NOT NULL default '',
  `refresh` int(8) default NULL,
  `lastUpdated` int(14) default NULL,
  `showTitle` char(1) default 'n',
  `showPubDate` char(1) default 'n',
  `content` longblob,
  PRIMARY KEY  (`rssId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_rss_modules`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_score`
--

CREATE TABLE IF NOT EXISTS `tiki_score` (
  `event` varchar(40) NOT NULL default '',
  `score` int(11) NOT NULL default '0',
  `expiration` int(11) NOT NULL default '0',
  PRIMARY KEY  (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_score`
--

INSERT INTO `tiki_score` (`event`, `score`, `expiration`) VALUES
('login', 1, 0),
('login_remain', 2, 60),
('profile_fill', 10, 0),
('profile_see', 2, 0),
('profile_is_seen', 1, 0),
('friend_new', 10, 0),
('message_receive', 1, 0),
('message_send', 2, 0),
('article_read', 2, 0),
('article_comment', 5, 0),
('article_new', 20, 0),
('article_is_read', 1, 0),
('article_is_commented', 2, 0),
('fgallery_new', 10, 0),
('fgallery_new_file', 10, 0),
('fgallery_download', 5, 0),
('fgallery_is_downloaded', 5, 0),
('igallery_new', 10, 0),
('igallery_new_img', 6, 0),
('igallery_see_img', 3, 0),
('igallery_img_seen', 1, 0),
('blog_new', 20, 0),
('blog_post', 5, 0),
('blog_read', 2, 0),
('blog_comment', 2, 0),
('blog_is_read', 3, 0),
('blog_is_commented', 3, 0),
('wiki_new', 10, 0),
('wiki_edit', 5, 0),
('wiki_attach_file', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_search_stats`
--

CREATE TABLE IF NOT EXISTS `tiki_search_stats` (
  `term` varchar(50) NOT NULL default '',
  `hits` int(10) default NULL,
  PRIMARY KEY  (`term`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_search_stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_searchindex`
--

CREATE TABLE IF NOT EXISTS `tiki_searchindex` (
  `searchword` varchar(80) NOT NULL default '',
  `location` varchar(80) NOT NULL default '',
  `page` varchar(255) NOT NULL default '',
  `count` int(11) NOT NULL default '1',
  `last_update` int(11) NOT NULL default '0',
  PRIMARY KEY  (`searchword`,`location`,`page`(80)),
  KEY `last_update` (`last_update`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_searchindex`
--

INSERT INTO `tiki_searchindex` (`searchword`, `location`, `page`, `count`, `last_update`) VALUES
('premier', 'wiki', 'Adobe Premier', 1, 1258903109),
('/etc/apache2/apache2.conf', 'wiki', 'Subversion', 1, 1258498536),
('apache', 'wiki', 'Subversion', 2, 1258498536),
('&lt;-', 'wiki', 'Rational ClearCase', 5, 1259309773),
('send', 'wiki', 'Send Email', 2, 1258884958),
('term=ansi', 'wiki', 'System', 1, 1258410605),
('image&quot;', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('&quot;q&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('adminvob', 'wiki', 'Rational ClearCase', 5, 1259309773),
('hyperlinks:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('search', 'wiki', 'Networking', 1, 1258400800),
('(localtime-&gt;min()', 'wiki', 'PERL_Code', 1, 1258410605),
('file', 'wiki', 'Networking', 3, 1258400800),
('center(in', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('attributes:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('featurelevel?', 'wiki', 'Rational ClearCase', 1, 1259309773),
('default', 'wiki', 'Rational ClearCase', 1, 1259309773),
('export', 'wiki', 'System', 1, 1258410605),
('width', 'wiki', 'System', 1, 1258410605),
('&amp;', 'wiki', 'System', 1, 1258410605),
('''^d''', 'wiki', 'System', 1, 1258410605),
('homepage', 'wiki', 'HomePage', 1, 1259671540),
('quotes', 'wiki', 'HomePage', 1, 1259671540),
('their', 'wiki', 'OS X', 1, 1259618078),
('prompt', 'wiki', 'System', 1, 1258410605),
('9700m', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('change', 'wiki', 'System', 1, 1258410605),
('grep', 'wiki', 'System', 1, 1258410605),
('directories', 'wiki', 'System', 1, 1258410605),
('scripting', 'wiki', 'Scripting', 1, 1258052737),
('done', 'wiki', 'Scripting', 1, 1258052737),
('$i/patch`;', 'wiki', 'Scripting', 1, 1258052737),
('`mkdir', 'wiki', 'Scripting', 1, 1258052737),
('`ls`;', 'wiki', 'Scripting', 1, 1258052737),
('released', 'wiki', 'Rational ClearCase', 1, 1259309773),
('tested', 'wiki', 'Rational ClearCase', 1, 1259309773),
('g+rws', 'wiki', 'Subversion', 1, 1258498536),
('chmod', 'wiki', 'Subversion', 1, 1258498536),
('www-data', 'wiki', 'Subversion', 1, 1258498536),
('webserver', 'wiki', 'Subversion', 1, 1258498536),
('chown', 'wiki', 'Subversion', 1, 1258498536),
('make', 'wiki', 'Subversion', 1, 1258498536),
('/usr/local/svn/cablecrazy', 'wiki', 'Subversion', 2, 1258498536),
('cablecrazy', 'wiki', 'Subversion', 1, 1258498536),
('code', 'wiki', 'Subversion', 1, 1258498536),
('project', 'wiki', 'Subversion', 1, 1258498536),
('users', 'wiki', 'Maintain Users', 1, 1259297843),
('samba', 'wiki', 'Samba', 1, 1259430744),
('called', 'wiki', 'Subversion', 1, 1258498536),
('import', 'wiki', 'Subversion', 3, 1258498536),
('built', 'wiki', 'Rational ClearCase', 1, 1259309773),
('initial', 'wiki', 'Rational ClearCase', 2, 1259309773),
('clearcase', 'wiki', 'HomePage', 1, 1259671540),
('&amp;', 'wiki', 'Subversion', 2, 1258498536),
('svn+ssh://c8h10n4o2@greenbox/usr/local/svn/scripts', 'wiki', 'Subversion', 1, 1258498536),
('stream', 'wiki', 'Subversion', 1, 1258498536),
('svn://home/charlie/foo/bar/codefez', 'wiki', 'Subversion', 1, 1258498536),
('example', 'wiki', 'Subversion', 1, 1258498536),
('maintain', 'wiki', 'Maintain Users', 1, 1259297843),
('sane', 'wiki', 'Maintain Users', 1, 1259297843),
('stty', 'wiki', 'Maintain Users', 1, 1259297843),
('backspace', 'wiki', 'Maintain Users', 1, 1259297843),
('enabling', 'wiki', 'Maintain Users', 1, 1259297843),
('mode', 'wiki', 'Maintain Users', 1, 1259297843),
('change', 'wiki', 'Maintain Users', 1, 1259297843),
('&lt;pwd&gt;', 'wiki', 'Subversion', 1, 1258498536),
('echo', 'wiki', 'Searching', 1, 1259317887),
('rejected', 'wiki', 'Rational ClearCase', 1, 1259309773),
('dirs', 'wiki', 'Scripting', 1, 1258052737),
('--password', 'wiki', 'Subversion', 1, 1258498536),
('&lt;name&gt;', 'wiki', 'Subversion', 1, 1258498536),
('line', 'wiki', 'Subversion', 1, 1258498536),
('quotes', 'wiki', 'Quotes', 1, 1259250659),
('buddha', 'wiki', 'Quotes', 1, 1259250659),
('world.', 'wiki', 'Quotes', 1, 1259250659),
('outside', 'wiki', 'Quotes', 1, 1259250659),
('form', 'wiki', 'Quotes', 1, 1259250659),
('might', 'wiki', 'Quotes', 1, 1259250659),
('shell', 'wiki', 'Quotes', 1, 1259250659),
('through', 'wiki', 'Quotes', 1, 1259250659),
('broken', 'wiki', 'Quotes', 1, 1259250659),
('chick', 'wiki', 'Quotes', 1, 1259250659),
('which', 'wiki', 'Quotes', 2, 1259250659),
('those', 'wiki', 'Quotes', 1, 1259250659),
('valuable', 'wiki', 'Quotes', 1, 1259250659),
('eternal', 'wiki', 'Quotes', 1, 1259250659),
('stop', 'wiki', 'WebSphere', 3, 1258781258),
('settings', 'wiki', 'WebSphere', 1, 1258781258),
('bounce', 'wiki', 'WebSphere', 1, 1258781258),
('pick', 'wiki', 'WebSphere', 1, 1258781258),
('enabled=”false”', 'wiki', 'WebSphere', 1, 1258781258),
('argument,', 'wiki', 'WebSphere', 1, 1258781258),
('first', 'wiki', 'WebSphere', 1, 1258781258),
('--username', 'wiki', 'Subversion', 1, 1258498536),
('standard', 'wiki', 'Subversion', 1, 1258498536),
('restored,', 'wiki', 'Subversion', 1, 1258498536),
('&lt;', 'wiki', 'Subversion', 1, 1258498536),
('fdisk', 'wiki', 'File System', 1, 1259504792),
('theories', 'wiki', 'Quotes', 1, 1259250659),
('//192.168.1.111/faculty_materials', 'wiki', 'Samba', 1, 1259430744),
('/export/env/tiers/aging/websphere/deploymentmanager/config/cells/tiers_aging_net', 'wiki', 'WebSphere', 1, 1258781258),
('admin', 'wiki', 'WebSphere', 1, 1258781258),
('adobe', 'wiki', 'Adobe Premier', 1, 1258903109),
('partitions', 'wiki', 'File System', 1, 1259504792),
('reference', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('/test)', 'wiki', 'Running Processes', 1, 1259319976),
('setup', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('ubuntu', 'wiki', 'Ubuntu', 1, 1259132332),
('(&lt;cmd&gt;)', 'wiki', 'Running Processes', 1, 1259319976),
('execute', 'wiki', 'Running Processes', 1, 1259319976),
('then', 'wiki', 'Searching', 1, 1259317887),
('2&gt;&amp;1;', 'wiki', 'Searching', 1, 1259317887),
('security', 'wiki', 'WebSphere', 1, 1258781258),
('disable', 'wiki', 'WebSphere', 1, 1258781258),
('driver&quot;', 'wiki', 'WebSphere', 1, 1258781258),
('/home/charlie/foo/bar', 'wiki', 'Subversion', 1, 1258498536),
('data,', 'wiki', 'Subversion', 1, 1258498536),
('enter', 'wiki', 'Subversion', 1, 1258498536),
('/home/charlie/foo/bat', 'wiki', 'Subversion', 1, 1258498536),
('$minute', 'wiki', 'PERL_Code', 1, 1258410605),
('localtime-&gt;hour();', 'wiki', 'PERL_Code', 1, 1258410605),
('localtime-&gt;hour())', 'wiki', 'PERL_Code', 1, 1258410605),
('(localtime-&gt;hour()', 'wiki', 'PERL_Code', 1, 1258410605),
('$hour', 'wiki', 'PERL_Code', 1, 1258410605),
('getcurrenttime', 'wiki', 'PERL_Code', 1, 1258410605),
('times', 'wiki', 'PERL_Code', 1, 1258410605),
('preceed', 'wiki', 'PERL_Code', 1, 1258410605),
('$day);', 'wiki', 'PERL_Code', 1, 1258410605),
('time.', 'wiki', 'PERL_Code', 1, 1258410605),
('return', 'wiki', 'PERL_Code', 2, 1258410605),
('localtime-&gt;mday();', 'wiki', 'PERL_Code', 1, 1258410605),
('localtime-&gt;mday())', 'wiki', 'PERL_Code', 1, 1258410605),
('(localtime-&gt;mon()', 'wiki', 'PERL_Code', 2, 1258410605),
('(localtime-&gt;mday()', 'wiki', 'PERL_Code', 1, 1258410605),
('(&quot;0&quot;', 'wiki', 'PERL_Code', 5, 1258410605),
('&quot;oracle', 'wiki', 'WebSphere', 1, 1258781258),
('that', 'wiki', 'Running Processes', 1, 1259319976),
('/dev/null', 'wiki', 'Searching', 1, 1259317887),
('&lt;', 'wiki', 'PERL_Code', 5, 1258410605),
('((localtime-&gt;mon()', 'wiki', 'PERL_Code', 1, 1258410605),
('1900;', 'wiki', 'PERL_Code', 1, 1258410605),
('localtime-&gt;year()', 'wiki', 'PERL_Code', 1, 1258410605),
('getcurrentdate', 'wiki', 'PERL_Code', 1, 1258410605),
('readability.', 'wiki', 'PERL_Code', 2, 1258410605),
('with', 'wiki', 'PERL_Code', 2, 1258410605),
('digit', 'wiki', 'PERL_Code', 2, 1258410605),
('dates', 'wiki', 'PERL_Code', 1, 1258410605),
('single', 'wiki', 'PERL_Code', 2, 1258410605),
('proceed', 'wiki', 'PERL_Code', 1, 1258410605),
('click', 'wiki', 'WebSphere', 2, 1258781258),
('username=instructor1,password=password1', 'wiki', 'Samba', 1, 1259430744),
('&amp;', 'wiki', 'File System', 1, 1259504792),
('info', 'wiki', 'File System', 1, 1259504792),
('space', 'wiki', 'File System', 1, 1259504792),
('server', 'wiki', 'WebSphere', 2, 1258781258),
('browse', 'wiki', 'WebSphere', 2, 1258781258),
('name', 'wiki', 'WebSphere', 2, 1258781258),
('current', 'wiki', 'System', 1, 1258410605),
('restore:', 'wiki', 'Subversion', 1, 1258498536),
('linux', 'wiki', 'Linux', 1, 1258771475),
('email', 'wiki', 'Linux', 1, 1258771475),
('send', 'wiki', 'Linux', 1, 1258771475),
('9700m', 'wiki', 'Linux', 1, 1258771475),
('echo($val', 'wiki', 'PHP', 1, 1258814906),
('&gt;', 'wiki', 'Searching', 1, 1259317887),
('data', 'wiki', 'Subversion', 2, 1258498536),
('this,', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('control', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('will', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('menu', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('click', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('also', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('(8.34.8)', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('9700', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('2.0.6334', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('mobility', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('shutdown', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('works', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('technologies', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('aticonfig', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('--initial', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('reboot', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('xorg-driver-fglrx', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('installed', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('#okay', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('already', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('linux-restricted-modules-$(uname', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('update', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('date.', 'wiki', 'PERL_Code', 1, 1258410605),
('current', 'wiki', 'PERL_Code', 2, 1258410605),
('print(&quot;@toprint\\n&quot;);', 'wiki', 'PERL_Code', 1, 1258410605),
('@toprint', 'wiki', 'PERL_Code', 1, 1258410605),
('return(1);', 'wiki', 'PERL_Code', 1, 1258410605),
('return(0);', 'wiki', 'PERL_Code', 1, 1258410605),
('radeon', 'wiki', 'Linux', 1, 1258771475),
('drives', 'wiki', 'File System', 2, 1259504792),
('node', 'wiki', 'WebSphere', 5, 1258781258),
('enter', 'wiki', 'WebSphere', 2, 1258781258),
('println', 'wiki', 'PERL_Code', 1, 1258410605),
('if(length', 'wiki', 'PERL_Code', 1, 1258410605),
('m675x', 'wiki', 'Linux', 1, 1258771475),
('apt-get', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 3, 1259470785),
('apps', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('necessary', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('into', 'wiki', 'OS X', 1, 1259618078),
('setup', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('snd-intel8x0', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('ignored.', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('sbp2', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('with', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('&quot;#&quot;', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('beginning', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('lines', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('line.', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('loaded', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('time,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('that', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('contains', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('names', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('load', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('time.', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('file', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('kernel', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('modules', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('more', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/etc/modules:', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('c8h10n4o2@laptop:/var/log/vmware$', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('list', 'wiki', 'System', 1, 1258410605),
('install', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 3, 1259470785),
('quit', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('&amp;', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('save', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('&quot;aiglx&quot;', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('&quot;off&quot;', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('/etc/modules', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('thus,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('lost.', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('were', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('drivers', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('rebooted,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('gateway', 'wiki', 'Linux', 1, 1258771475),
('&gt;', 'wiki', 'PERL_Code', 1, 1258410605),
('$digresults', 'wiki', 'PERL_Code', 1, 1258410605),
('section''`;', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;serverflags&quot;', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('create', 'wiki', 'Subversion', 5, 1258498536),
('group=&quot;dialout&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('hold', 'wiki', 'Subversion', 1, 1258498536),
('`/usr/bin/vim.tiny''', 'wiki', 'Ubuntu', 1, 1259132332),
('using', 'wiki', 'Ubuntu', 1, 1259132332),
('number:', 'wiki', 'Ubuntu', 1, 1259132332),
('type', 'wiki', 'Ubuntu', 1, 1259132332),
('default*,', 'wiki', 'Ubuntu', 1, 1259132332),
('keep', 'wiki', 'Ubuntu', 1, 1259132332),
('enter', 'wiki', 'Ubuntu', 1, 1259132332),
('press', 'wiki', 'Ubuntu', 1, 1259132332),
('/bin/nano', 'wiki', 'Ubuntu', 1, 1259132332),
('kernel==&quot;ttyltm0-9*&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('subsystem==&quot;slamr&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('subsystem==&quot;zaptel&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('group=&quot;dialout&quot;', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('group=&quot;c8h10n4o2&quot;', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('subsystem==&quot;capi&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('devices', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/etc/nsswitch.conf', 'wiki', 'Networking', 1, 1258400800),
('rational', 'wiki', 'HomePage', 1, 1259671540),
('perl_code', 'wiki', 'HomePage', 1, 1259671540),
('nsswitch', 'wiki', 'Networking', 1, 1258400800),
('edit', 'wiki', 'Networking', 1, 1258400800),
('1820a', 'wiki', 'Linux', 1, 1258771475),
('$val', 'wiki', 'PHP', 1, 1258814906),
('/bin/ed', 'wiki', 'Ubuntu', 1, 1259132332),
('/usr/bin/vim.tiny', 'wiki', 'Ubuntu', 1, 1259132332),
('''answer', 'wiki', 'PERL_Code', 1, 1258410605),
('grep', 'wiki', 'PERL_Code', 1, 1258410605),
('$digresults=`/usr/bin/dig', 'wiki', 'PERL_Code', 1, 1258410605),
('@domain', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;\\n&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('dig_dns', 'wiki', 'PERL_Code', 1, 1258410605),
('$whoisresults', 'wiki', 'PERL_Code', 1, 1258410605),
('whoisfile', 'wiki', 'PERL_Code', 1, 1258410605),
('\\n&quot;', 'wiki', 'PERL_Code', 1, 1258410605),
('$whoisresults);', 'wiki', 'PERL_Code', 1, 1258410605),
('println(&quot;results', 'wiki', 'PERL_Code', 1, 1258410605),
('$domain`;', 'wiki', 'PERL_Code', 1, 1258410605),
('it&quot;);', 'wiki', 'PERL_Code', 1, 1258410605),
('~/.bashrc', 'wiki', 'Maintain Users', 1, 1259297843),
('$whoisresults=`/usr/bin/whois', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;&gt;$filename&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('creating', 'wiki', 'PERL_Code', 1, 1258410605),
('exist....', 'wiki', 'PERL_Code', 1, 1258410605),
('does', 'wiki', 'PERL_Code', 1, 1258410605),
('println(&quot;$filename', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;disable&quot;', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('endsection?', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('&quot;composite&quot;', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('option', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 3, 1259470785),
('&quot;extensions&quot;', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('section', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('lines:', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('following', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('first', 'wiki', 'Subversion', 1, 1258498536),
('file,', 'wiki', 'Subversion', 1, 1258498536),
('backup.', 'wiki', 'Subversion', 1, 1258498536),
('redirect', 'wiki', 'Subversion', 1, 1258498536),
('want', 'wiki', 'Subversion', 2, 1258498536),
('parameter,', 'wiki', 'Subversion', 1, 1258498536),
('websphere', 'wiki', 'HomePage', 1, 1259671540),
('&quot;filename&quot;', 'wiki', 'Searching', 1, 1259317887),
('unzip', 'wiki', 'Searching', 1, 1259317887),
('&quot;*.jar&quot;', 'wiki', 'Searching', 1, 1259317887),
('subsystem==&quot;tty&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('serial', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('0666', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('mode', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('0660', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('modify', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('40-permissions.rules', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('need', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('doing', 'wiki', 'Networking', 1, 1258400800),
('$filename))', 'wiki', 'PERL_Code', 1, 1258410605),
('if(!(-e', 'wiki', 'PERL_Code', 1, 1258410605),
('$filename&quot;);', 'wiki', 'PERL_Code', 1, 1258410605),
('following:', 'wiki', 'Networking', 1, 1258400800),
('enabled', 'wiki', 'Networking', 1, 1258400800),
('easily', 'wiki', 'Networking', 1, 1258400800),
('alternative', 'wiki', 'Ubuntu', 1, 1259132332),
('subversion', 'wiki', 'HomePage', 1, 1259671540),
('utility.', 'wiki', 'Subversion', 1, 1258498536),
('caommd', 'wiki', 'Subversion', 1, 1258498536),
('here', 'wiki', 'Subversion', 1, 1258498536),
('/usr/local/myrepository', 'wiki', 'Subversion', 1, 1258498536),
('selection', 'wiki', 'Ubuntu', 2, 1259132332),
('`editor''.', 'wiki', 'Ubuntu', 2, 1259132332),
('$letter);', 'wiki', 'PHP', 1, 1258814906),
('edit', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('open', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('they', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('mount', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('root@laptop:/etc/udev/rules.d#', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('access', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('network.', 'wiki', 'Networking', 1, 1258400800),
('reboot', 'wiki', 'Networking', 1, 1258400800),
('println(&quot;checking', 'wiki', 'PERL_Code', 2, 1258410605),
('~/.profile', 'wiki', 'Maintain Users', 1, 1259297843),
('info', 'wiki', 'Maintain Users', 1, 1259297843),
('/home/charlie/svnbackupfile', 'wiki', 'Subversion', 2, 1258498536),
('command:', 'wiki', 'Subversion', 2, 1258498536),
('issue', 'wiki', 'Subversion', 1, 1258498536),
('back', 'wiki', 'Subversion', 1, 1258498536),
('only', 'wiki', 'System', 1, 1258410605),
('edit', 'wiki', 'Maintain Users', 2, 1259297843),
('-print`;', 'wiki', 'Searching', 1, 1259317887),
('time', 'wiki', 'Networking', 1, 1258400800),
('another', 'wiki', 'Running Processes', 1, 1259319976),
('#&gt;', 'wiki', 'Maintain Users', 1, 1259297843),
('give', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('ttyusb*', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('get_whois_file', 'wiki', 'PERL_Code', 1, 1258410605),
('restores', 'wiki', 'Subversion', 1, 1258498536),
('hard', 'wiki', 'File System', 2, 1259504792),
('every', 'wiki', 'Networking', 1, 1258400800),
('parameters', 'wiki', 'Networking', 1, 1258400800),
('name,', 'wiki', 'Networking', 1, 1258400800),
('netbios', 'wiki', 'Networking', 1, 1258400800),
('able', 'wiki', 'Networking', 1, 1258400800),
('convenient', 'wiki', 'Networking', 1, 1258400800),
('/test', 'wiki', 'Running Processes', 1, 1259319976),
('network,', 'wiki', 'Networking', 1, 1258400800),
('repository,', 'wiki', 'Subversion', 1, 1258498536),
('`find', 'wiki', 'Searching', 1, 1259317887),
('provide', 'wiki', 'Ubuntu', 2, 1259132332),
('/usr/bin/thunderbird', 'wiki', 'System', 1, 1258410605),
('&lt;group', 'wiki', 'Maintain Users', 1, 1259297843),
('linux', 'wiki', 'HomePage', 1, 1259671540),
('thunderbird', 'wiki', 'System', 2, 1258410605),
('code!', 'wiki', 'Searching', 1, 1259317887),
('repository.', 'wiki', 'Subversion', 1, 1258498536),
('backups', 'wiki', 'Subversion', 1, 1258498536),
('rocketraid', 'wiki', 'Linux', 1, 1258771475),
('great', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('user,auto', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('dhcp', 'wiki', 'Networking', 1, 1258400800),
('share', 'wiki', 'Networking', 1, 1258400800),
('windows', 'wiki', 'Networking', 1, 1258400800),
('mount', 'wiki', 'Networking', 3, 1258400800),
('open', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('check', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('status,', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('print.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('hand', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('right', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('lower', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('button', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('prints.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('test', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('prints', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('2880', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('resolution.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('final', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('1440', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('preferred', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('quality”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('radio', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('mode', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('settings”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“advanced', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('type.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('type”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“media', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('settings”.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“copies', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('pages”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('load', 'wiki', 'Subversion', 2, 1258498536),
('which', 'wiki', 'Ubuntu', 1, 1259132332),
('“printer”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('apple', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('standard', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“print...”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('fork', 'wiki', 'Running Processes', 1, 1259319976),
('(apple)', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('using', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('list', 'wiki', 'File System', 2, 1259504792),
('highpoint', 'wiki', 'Linux', 1, 1258771475),
('profiles.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('perform', 'wiki', 'Subversion', 1, 1258498536),
('http://www.falafel.com/community/blogs/techbits/archive/2006/01/11/a-simple-way-', 'wiki', 'Subversion', 1, 1258498536),
('restore', 'wiki', 'Subversion', 3, 1258498536),
('simple', 'wiki', 'Subversion', 2, 1258498536),
('/mnt/backup', 'wiki', 'Subversion', 1, 1258498536),
('/etc/hosts', 'wiki', 'Networking', 1, 1258400800),
('&lt;ctrl&gt;&lt;m&gt;', 'wiki', 'Send Email', 1, 1258884958),
('body', 'wiki', 'Send Email', 1, 1258884958),
('your', 'wiki', 'Send Email', 1, 1258884958),
('crw-rw-r--', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/tmp/htdocs.dump', 'wiki', 'Subversion', 2, 1258498536),
('enter', 'wiki', 'Send Email', 1, 1258884958),
('/usr/local/svn/htdocs', 'wiki', 'Subversion', 1, 1258498536),
('configure', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('188,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('-&gt;', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('pilot', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('2007-07-21', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('08:38', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('root', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('lrwxrwxrwx', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('&lt;ls', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/dev&gt;', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('things.', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('thus:', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('myself', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('dialout', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('adding', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('member.', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('tried', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('group', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('owner', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('world', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('module', 'wiki', 'Searching', 1, 1259317887),
('such', 'wiki', 'Searching', 1, 1259317887),
('warning:', 'wiki', 'Searching', 1, 1259317887),
('chmod', 'wiki', 'Searching', 2, 1259317887),
('recursively', 'wiki', 'Searching', 1, 1259317887),
('//&lt;server_ip&gt;/&lt;share_name&gt;', 'wiki', 'Samba', 1, 1259430744),
('alternatives', 'wiki', 'Ubuntu', 1, 1259132332),
('there', 'wiki', 'Ubuntu', 1, 1259132332),
('root@james:/etc#', 'wiki', 'Ubuntu', 1, 1259132332),
('code!', 'wiki', 'Ubuntu', 1, 1259132332),
('module', 'wiki', 'Ubuntu', 1, 1259132332),
('such', 'wiki', 'Ubuntu', 1, 1259132332),
('type', 'wiki', 'System', 2, 1258410605),
('c8h10n4o2@james:/media/sdb1/photographs/2007$', 'wiki', 'System', 1, 1258410605),
('file', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('backup):', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('/etc/x11/xorg.conf.orig', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('sudo', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 7, 1259470785),
('without', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('anything', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('(never', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('back', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('/etc/x11/xorg.conf', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 3, 1259470785),
('modify', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('direct', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 4, 1259470785),
('rendering:', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('grep', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('file&quot;);', 'wiki', 'PERL_Code', 1, 1258410605),
('checkwhoisfile;', 'wiki', 'PERL_Code', 1, 1258410605),
('whois&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('checkwhoisfile', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;&gt;&gt;$check_whois_file&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('checkwhoisfile,', 'wiki', 'PERL_Code', 1, 1258410605),
('#also', 'wiki', 'PERL_Code', 1, 1258410605),
('whoisfile;', 'wiki', 'PERL_Code', 1, 1258410605),
('if($result_found', 'wiki', 'PERL_Code', 1, 1258410605),
('println($domain', 'wiki', 'PERL_Code', 2, 1258410605),
('$line);', 'wiki', 'PERL_Code', 1, 1258410605),
('expiresonfile;', 'wiki', 'PERL_Code', 1, 1258410605),
('$line;', 'wiki', 'PERL_Code', 1, 1258410605),
('=&gt;', 'wiki', 'PERL_Code', 2, 1258410605),
('expiresonfile', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;&gt;&gt;$expires_on_file&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('expiresonfile,', 'wiki', 'PERL_Code', 1, 1258410605),
('m/($expiration_date)/o)', 'wiki', 'PERL_Code', 1, 1258410605),
('&lt;address&gt;', 'wiki', 'Send Email', 1, 1258884958),
('count', 'wiki', 'File System', 1, 1259504792),
('array_push($word_array,', 'wiki', 'PHP', 1, 1258814906),
('$id=&gt;$letter)', 'wiki', 'PHP', 1, 1258814906),
('$id=&gt;$val)', 'wiki', 'PHP', 2, 1258814906),
('$i&lt;$strlen;$i++)', 'wiki', 'PHP', 1, 1258814906),
('svnadmin', 'wiki', 'Subversion', 6, 1258498536),
('dump', 'wiki', 'Subversion', 5, 1258498536),
('sudo', 'wiki', 'Subversion', 7, 1258498536),
('backup', 'wiki', 'Subversion', 3, 1258498536),
('moved', 'wiki', 'Subversion', 1, 1258498536),
('renames', 'wiki', 'Subversion', 1, 1258498536),
('file.', 'wiki', 'Subversion', 2, 1258498536),
('another', 'wiki', 'Subversion', 1, 1258498536),
('dest.', 'wiki', 'Subversion', 1, 1258498536),
('moves', 'wiki', 'Subversion', 1, 1258498536),
('rename', 'wiki', 'Subversion', 1, 1258498536),
('dest', 'wiki', 'Subversion', 3, 1258498536),
('move', 'wiki', 'Subversion', 2, 1258498536),
('index.xml.', 'wiki', 'Subversion', 1, 1258498536),
('showing', 'wiki', 'Subversion', 1, 1258498536),
('output', 'wiki', 'Subversion', 1, 1258498536),
('elsif(my($subline)', 'wiki', 'PERL_Code', 1, 1258410605),
('$result_found++;', 'wiki', 'PERL_Code', 2, 1258410605),
('println(&quot;no', 'wiki', 'PERL_Code', 1, 1258410605),
('$domain&quot;);', 'wiki', 'PERL_Code', 2, 1258410605),
('nomatchfile;', 'wiki', 'PERL_Code', 1, 1258410605),
('close', 'wiki', 'PERL_Code', 4, 1258410605),
('$domain;', 'wiki', 'PERL_Code', 1, 1258410605),
('nomatchfile', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;&gt;&gt;$no_match_file&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('&amp;', 'wiki', 'Running Processes', 5, 1259319976),
('&lt;cmd&gt;', 'wiki', 'Running Processes', 1, 1259319976),
('file', 'wiki', 'System', 1, 1258410605),
('about', 'wiki', 'Networking', 1, 1258400800),
('worry', 'wiki', 'Networking', 1, 1258400800),
('don''t', 'wiki', 'Networking', 2, 1258400800),
('index.xml', 'wiki', 'Subversion', 1, 1258498536),
('168:169', 'wiki', 'Subversion', 1, 1258498536),
('example:', 'wiki', 'Subversion', 1, 1258498536),
('filename.', 'wiki', 'Subversion', 1, 1258498536),
('revision1:revision2', 'wiki', 'Subversion', 1, 1258498536),
('using:', 'wiki', 'Subversion', 1, 1258498536),
('revisions', 'wiki', 'Subversion', 2, 1258498536),
('glxinfo', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('6.5.2', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('(you', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('writable', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('number', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('however,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('whatever', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('ubuntu', 'wiki', 'Linux', 4, 1258771475),
('setup', 'wiki', 'Linux', 2, 1258771475),
('details', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('handout', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('management', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('color', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('return', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('orientation.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('incorrect', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('small', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('particular', 'wiki', 'Searching', 1, 1259317887),
('&quot;s/\\015\\012/\\012/g&quot;', 'wiki', 'Searching', 1, 1259317887),
('also.', 'wiki', 'Networking', 1, 1258400800),
('with', 'wiki', 'Networking', 1, 1258400800),
('passphrase', 'wiki', 'Networking', 1, 1258400800),
('used', 'wiki', 'Networking', 1, 1258400800),
('private', 'wiki', 'Networking', 1, 1258400800),
('public', 'wiki', 'Networking', 1, 1258400800),
('created', 'wiki', 'Networking', 2, 1258400800),
('whoever', 'wiki', 'Networking', 1, 1258400800),
('passphrase,', 'wiki', 'Networking', 1, 1258400800),
('somethign', 'wiki', 'Networking', 1, 1258400800),
('password,', 'wiki', 'Networking', 1, 1258400800),
('wrong.', 'wiki', 'Networking', 2, 1258400800),
('something', 'wiki', 'Networking', 3, 1258400800),
('login,', 'wiki', 'Networking', 1, 1258400800),
('between', 'wiki', 'Subversion', 2, 1258498536),
('find', 'wiki', 'Subversion', 1, 1258498536),
('second', 'wiki', 'Subversion', 1, 1258498536),
('book.', 'wiki', 'Subversion', 1, 1258498536),
('pick', 'wiki', 'Subversion', 1, 1258498536),
('rights', 'wiki', 'Subversion', 1, 1258498536),
('warning:', 'wiki', 'Ubuntu', 1, 1259132332),
('--config', 'wiki', 'Ubuntu', 2, 1259132332),
('nomatchfile,', 'wiki', 'PERL_Code', 1, 1258410605),
('print', 'wiki', 'PERL_Code', 6, 1258410605),
('m/($no_match)/o)', 'wiki', 'PERL_Code', 1, 1258410605),
('if(my($subline)', 'wiki', 'PERL_Code', 1, 1258410605),
('#println($line);', 'wiki', 'PERL_Code', 1, 1258410605),
('my($line)', 'wiki', 'PERL_Code', 1, 1258410605),
('&lt;whoisfile&gt;', 'wiki', 'PERL_Code', 1, 1258410605),
('while', 'wiki', 'PERL_Code', 1, 1258410605),
('&lt;subject&gt;', 'wiki', 'Send Email', 1, 1258884958),
('update-alternatives', 'wiki', 'Ubuntu', 2, 1259132332),
('editor', 'wiki', 'Ubuntu', 3, 1259132332),
('with', 'wiki', 'Linux', 2, 1258771475),
('shell', 'wiki', 'Running Processes', 3, 1259319976),
('foreach($alphabet', 'wiki', 'PHP', 1, 1258814906),
('file', 'wiki', 'File System', 2, 1259504792),
('editing', 'wiki', 'Subversion', 1, 1258498536),
('someone', 'wiki', 'Subversion', 1, 1258498536),
('list', 'wiki', 'Subversion', 1, 1258498536),
('where', 'wiki', 'Subversion', 1, 1258498536),
('chosen', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('corner', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('left', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('upper', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('pane', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('preview', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('within', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('back', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('window.', 'wiki', 'Adobe Photoshop', 4, 1258133722),
('takes', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('closes', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('“ok”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('100%.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('partition', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('ext3', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('raidsudo', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('format', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('drivemkdir', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('raid', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('ntfs-3g', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('defaults,locale=en_us.utf8', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('/media/raid', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 6, 1259563581),
('/etc/fstab/dev/sda1', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('mountvi', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('fstab', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('ntfs', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('formated', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('drive', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 4, 1259563581),
('mount', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 6, 1259563581),
('want', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 3, 1259563581),
('sbp2,sg,sd_mod,libata,hptmv', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('1scsi_mod', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('146828', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('204936', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('hpthptmv', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('lsmod', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('grep', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('system:c8h10n4o2@server:~$', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('against', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('below', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('output', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('comparing', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('correctly', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('check', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('succesfully', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('boots', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('reboot', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('&quot;2.6.22-14-server&quot;', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('/etc/initramfs-tools/modulesupdate-initramfs', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('kerneladd', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('&quot;stock&quot;', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('modifying', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('because', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('time.', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('done', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('boot', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('loaded', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('image', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('ramfs', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('/etc/modprobe.d/blacklist', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('recreate', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('sata_mv', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('&quot;blacklist', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('sata_mv&quot;', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('loading', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('from', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('prevent', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('&quot;hptmv&quot;', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('/etc/modules', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('startupadd', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('hptmv', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('system', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 3, 1259563581),
('make', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 3, 1259563581),
('depmod', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('automatically.sudo', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('sd_mod)', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('depends', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('upon', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('(such', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('modprobe', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('load', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('modules', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('“map”', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('able', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('dependancy', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('module', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('/lib/modules/2.6.22-14-server/kernel/drivers/scsi/', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('generate', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('./hptmv.ko', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('sudo', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('follows', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('kernel):', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('manually', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('kernels)', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('hptmv.ko', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('“scale:”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('char', 'wiki', 'Searching', 1, 1259317887),
('windows', 'wiki', 'Searching', 1, 1259317887),
('default', 'wiki', 'Ubuntu', 1, 1259132332),
('prompted', 'wiki', 'Networking', 3, 1258400800),
('should', 'wiki', 'Networking', 1, 1258400800),
('batchtaa@ietadu001', 'wiki', 'Networking', 1, 1258400800),
('works', 'wiki', 'Networking', 1, 1258400800),
('line.', 'wiki', 'Networking', 1, 1258400800),
('sure', 'wiki', 'Networking', 1, 1258400800),
('/dev/ttyusb0', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/dev/ttyusb1', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('(for', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('hptmv.o', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('named', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('drivers', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('(modules?)', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('kernelversion.', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('into', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('compiled', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('have', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('change', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('&quot;linux-headers-2.6.xxxxxxx&quot;', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('kerneldir=/usr/src/linux-headers-&lt;kernel_version&gt;2.6.22-14-server*note:', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('/usr/src/rraiddrivermake', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('drivercd', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('versionuname', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('current', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('build-essential', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('leave', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('line', 'wiki', 'Searching', 1, 1259317887),
('make', 'wiki', 'Networking', 1, 1258400800),
('authorized_keys', 'wiki', 'Networking', 1, 1258400800),
('chmod', 'wiki', 'Networking', 1, 1258400800),
('permissions', 'wiki', 'Networking', 1, 1258400800),
('mkdir', 'wiki', 'Networking', 1, 1258400800),
('.ssh', 'wiki', 'Networking', 5, 1258400800),
('create', 'wiki', 'Networking', 1, 1258400800),
('=&gt;', 'wiki', 'Networking', 3, 1258400800),
('home', 'wiki', 'Networking', 1, 1258400800),
('verify', 'wiki', 'Networking', 2, 1258400800),
('box.)', 'wiki', 'Networking', 1, 1258400800),
('users', 'wiki', 'Networking', 1, 1258400800),
('user', 'wiki', 'Networking', 1, 1258400800),
('that', 'wiki', 'Networking', 4, 1258400800),
('needs', 'wiki', 'Networking', 1, 1258400800),
('cannot', 'wiki', 'Networking', 1, 1258400800),
('login.', 'wiki', 'Networking', 2, 1258400800),
('password', 'wiki', 'Networking', 1, 1258400800),
('mail', 'wiki', 'Send Email', 1, 1258884958),
('enter', 'wiki', 'Networking', 1, 1258400800),
('multiple)', 'wiki', 'Networking', 1, 1258400800),
('line,', 'wiki', 'Networking', 1, 1258400800),
('single', 'wiki', 'Networking', 2, 1258400800),
('notepad', 'wiki', 'Networking', 1, 1258400800),
('(note:', 'wiki', 'Networking', 1, 1258400800),
('username=&lt;username&gt;,password=&lt;password&gt;', 'wiki', 'Samba', 1, 1259430744),
('modify', 'wiki', 'Ubuntu', 1, 1259132332),
('driverapt-get', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('install', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 3, 1259563581),
('/mnt/music/sorted/', 'wiki', 'File System', 1, 1259504792),
('paste', 'wiki', 'Networking', 2, 1258400800),
('attach', 'wiki', 'Subversion', 1, 1258498536),
('current', 'wiki', 'Running Processes', 1, 1259319976),
('horizontal)', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('location', 'wiki', 'System', 1, 1258410605),
('copy', 'wiki', 'Networking', 1, 1258400800),
('id_rsa.pub', 'wiki', 'Networking', 1, 1258400800),
('id_dsa.pub', 'wiki', 'Networking', 1, 1258400800),
('~/.ssh', 'wiki', 'Networking', 1, 1258400800),
('date:&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('contents', 'wiki', 'Networking', 2, 1258400800),
('machine,', 'wiki', 'Networking', 1, 1258400800),
('source', 'wiki', 'Networking', 2, 1258400800),
('background', 'wiki', 'Running Processes', 3, 1259319976),
('landscape(image', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('destination.', 'wiki', 'Networking', 1, 1258400800),
('then', 'wiki', 'Networking', 2, 1258400800),
('into', 'wiki', 'Networking', 1, 1258400800),
('&quot;expiration', 'wiki', 'PERL_Code', 1, 1258410605),
('$expiration_date', 'wiki', 'PERL_Code', 1, 1258410605),
('tools', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('build', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 4, 1259563581),
('for&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('joe.', 'wiki', 'Networking', 1, 1258400800),
('&quot;no', 'wiki', 'PERL_Code', 1, 1258410605),
('single', 'wiki', 'Searching', 1, 1259317887),
('version', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('20060815', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('this', 'wiki', 'Networking', 3, 1258400800),
('directory.', 'wiki', 'Subversion', 1, 1258498536),
('root', 'wiki', 'Subversion', 1, 1258498536),
('foreach($word_array', 'wiki', 'PHP', 2, 1258814906),
('will', 'wiki', 'Networking', 2, 1258400800),
('coffeecup:1', 'wiki', 'Networking', 1, 1258400800),
('joe@test.getmyip.com', 'wiki', 'Networking', 1, 1258400800),
('coffeecup:', 'wiki', 'Networking', 1, 1258400800),
('local', 'wiki', 'Networking', 1, 1258400800),
('domain,', 'wiki', 'Networking', 1, 1258400800),
('name', 'wiki', 'Networking', 1, 1258400800),
('test.getmyip.com', 'wiki', 'Networking', 2, 1258400800),
('dyndns', 'wiki', 'Networking', 1, 1258400800),
('using', 'wiki', 'Networking', 2, 1258400800),
('&lt;dest_box&gt;:&lt;port&gt;', 'wiki', 'Networking', 1, 1258400800),
('&lt;user&gt;@&lt;ip_address&gt;', 'wiki', 'Networking', 1, 1258400800),
('-via', 'wiki', 'Networking', 2, 1258400800),
('vncviewer', 'wiki', 'Networking', 2, 1258400800),
('destination', 'wiki', 'Networking', 3, 1258400800),
('your', 'wiki', 'Networking', 9, 1258400800),
('running', 'wiki', 'Networking', 1, 1258400800),
('vncserver', 'wiki', 'Networking', 1, 1258400800),
('have', 'wiki', 'Networking', 3, 1258400800),
('must', 'wiki', 'Networking', 2, 1258400800),
('show', 'wiki', 'System', 1, 1258410605),
('/etc/lsb-release', 'wiki', 'System', 1, 1258410605),
('file.patch', 'wiki', 'Subversion', 1, 1258498536),
('&gt;', 'wiki', 'Subversion', 3, 1258498536),
('then', 'wiki', 'Subversion', 3, 1258498536),
('edit', 'wiki', 'Subversion', 1, 1258498536),
('simply', 'wiki', 'Subversion', 1, 1258498536),
('blfs-dev', 'wiki', 'Subversion', 2, 1258498536),
('this,', 'wiki', 'Subversion', 1, 1258498536),
('send', 'wiki', 'Subversion', 1, 1258498536),
('patches', 'wiki', 'Subversion', 1, 1258498536),
('generate', 'wiki', 'Subversion', 1, 1258498536),
('access', 'wiki', 'Subversion', 1, 1258498536),
('write', 'wiki', 'Subversion', 1, 1258498536),
('without', 'wiki', 'Subversion', 1, 1258498536),
('first,', 'wiki', 'Subversion', 1, 1258498536),
('those', 'wiki', 'Subversion', 1, 1258498536),
('purposes.', 'wiki', 'Subversion', 1, 1258498536),
('different', 'wiki', 'Subversion', 1, 1258498536),
('useful', 'wiki', 'Subversion', 1, 1258498536),
('diff.', 'wiki', 'Subversion', 1, 1258498536),
('diff', 'wiki', 'Subversion', 5, 1258498536),
('messages).', 'wiki', 'Subversion', 1, 1258498536),
('governs', 'wiki', 'Subversion', 1, 1258498536),
('policy', 'wiki', 'Subversion', 1, 1258498536),
('name&gt;', 'wiki', 'Maintain Users', 1, 1259297843),
('&lt;user', 'wiki', 'Maintain Users', 1, 1259297843),
('grep', 'wiki', 'Maintain Users', 2, 1259297843),
('section,', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('portrait(image', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('more', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('vertical)', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“orientation”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('names.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('corresponding', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('sizes', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('wall', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('chart', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('large', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('larger', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('than', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('size.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('that', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('ubuntu', 'wiki', 'System', 1, 1258410605),
('more', 'wiki', 'System', 1, 1258410605),
('./logs', 'wiki', 'System', 1, 1258410605),
('smbfs', 'wiki', 'Samba', 2, 1259430744),
('/mnt/tmp', 'wiki', 'Samba', 3, 1259430744),
('mkdir', 'wiki', 'Samba', 1, 1259430744),
('share', 'wiki', 'Samba', 1, 1259430744),
('document', 'wiki', 'Subversion', 1, 1258498536),
('later', 'wiki', 'Subversion', 1, 1258498536),
('messages', 'wiki', 'Subversion', 1, 1258498536),
('empty', 'wiki', 'Subversion', 1, 1258498536),
('don''t', 'wiki', 'Subversion', 1, 1258498536),
('please', 'wiki', 'Subversion', 1, 1258498536),
('message', 'wiki', 'Subversion', 2, 1258498536),
('pass', 'wiki', 'Subversion', 3, 1258498536);
INSERT INTO `tiki_searchindex` (`searchword`, `location`, `page`, `count`, `last_update`) VALUES
('option', 'wiki', 'Subversion', 1, 1258498536),
('command.', 'wiki', 'Subversion', 2, 1258498536),
('file/directory', 'wiki', 'Subversion', 1, 1258498536),
('name', 'wiki', 'Subversion', 2, 1258498536),
('adding', 'wiki', 'Subversion', 1, 1258498536),
('path', 'wiki', 'Subversion', 1, 1258498536),
('specific', 'wiki', 'Subversion', 1, 1258498536),
('files', 'wiki', 'Subversion', 3, 1258498536),
('individual', 'wiki', 'Subversion', 1, 1258498536),
('added', 'wiki', 'Subversion', 1, 1258498536),
('files,', 'wiki', 'Subversion', 2, 1258498536),
('recursively', 'wiki', 'Subversion', 1, 1258498536),
('sends', 'wiki', 'Subversion', 1, 1258498536),
('commit/ci', 'wiki', 'Subversion', 1, 1258498536),
('machine.', 'wiki', 'Subversion', 1, 1258498536),
('merge', 'wiki', 'Subversion', 1, 1258498536),
('syncs', 'wiki', 'Subversion', 1, 1258498536),
('update', 'wiki', 'Subversion', 2, 1258498536),
('update/up', 'wiki', 'Subversion', 1, 1258498536),
('ready', 'wiki', 'Subversion', 1, 1258498536),
('will', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('sync,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('back', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('pick', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('these', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('changes.', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('must', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('&amp;', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('group=&quot;uucp&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('mode=&quot;0666&quot;', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('name=&quot;%k&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('symlink=&quot;pilot&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('kernel=&quot;ttyusb*&quot;,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('c8h10n4o2@laptop:/$', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/etc/udev/rules.d/10-custom.rules', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('mounts', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('symlink', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('every', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/dev/pilot', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('passwd', 'wiki', 'Maintain Users', 1, 1259297843),
('ypcat', 'wiki', 'Maintain Users', 2, 1259297843),
('lookup', 'wiki', 'Maintain Users', 1, 1259297843),
('x86/mmx/sse2', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('renderer', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('mesa', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('r300', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('inc.', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('graphics,', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('tungsten', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('string:', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 6, 1259470785),
('opengl', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 6, 1259470785),
('vendor', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('display:', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
(':0.0', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('screen:', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('&lt;file', 'wiki', 'Send Email', 1, 1258884958),
('name&gt;', 'wiki', 'Send Email', 1, 1258884958),
('everything', 'wiki', 'Subversion', 1, 1258498536),
('check', 'wiki', 'Subversion', 3, 1258498536),
('order', 'wiki', 'Subversion', 1, 1258498536),
('changes', 'wiki', 'Subversion', 6, 1258498536),
('trying', 'wiki', 'Subversion', 1, 1258498536),
('before', 'wiki', 'Subversion', 1, 1258498536),
('manual', 'wiki', 'Subversion', 1, 1258498536),
('always', 'wiki', 'Subversion', 2, 1258498536),
('information.', 'wiki', 'Subversion', 1, 1258498536),
('out-of-date', 'wiki', 'Subversion', 1, 1258498536),
('(-u)', 'wiki', 'Subversion', 1, 1258498536),
('--show-updates', 'wiki', 'Subversion', 2, 1258498536),
('with', 'wiki', 'Subversion', 4, 1258498536),
('item.', 'wiki', 'Subversion', 1, 1258498536),
('every', 'wiki', 'Subversion', 1, 1258498536),
('revision', 'wiki', 'Subversion', 1, 1258498536),
('switch,', 'wiki', 'Subversion', 2, 1258498536),
('--verbose', 'wiki', 'Subversion', 1, 1258498536),
('items.', 'wiki', 'Subversion', 1, 1258498536),
('modified', 'wiki', 'Subversion', 1, 1258498536),
('locally', 'wiki', 'Subversion', 1, 1258498536),
('show', 'wiki', 'Subversion', 3, 1258498536),
('it''ll', 'wiki', 'Subversion', 1, 1258498536),
('changes,', 'wiki', 'Subversion', 2, 1258498536),
('files.', 'wiki', 'Subversion', 2, 1258498536),
('directories', 'wiki', 'Subversion', 1, 1258498536),
('working', 'wiki', 'Subversion', 1, 1258498536),
('mount', 'wiki', 'Samba', 3, 1259430744),
('&lt;boxname&gt;', 'wiki', 'Samba', 1, 1259430744),
('&lt;username&gt;', 'wiki', 'Samba', 1, 1259430744),
('smbclient', 'wiki', 'Samba', 1, 1259430744),
('match', 'wiki', 'PERL_Code', 2, 1258410605),
('$no_match', 'wiki', 'PERL_Code', 1, 1258410605),
('details', 'wiki', 'PERL_Code', 1, 1258410605),
('file', 'wiki', 'PERL_Code', 3, 1258410605),
('whois', 'wiki', 'PERL_Code', 2, 1258410605),
('existing', 'wiki', 'PERL_Code', 1, 1258410605),
('through', 'wiki', 'PERL_Code', 1, 1258410605),
('look', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;$filename&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('whoisfile,', 'wiki', 'PERL_Code', 2, 1258410605),
('open', 'wiki', 'PERL_Code', 5, 1258410605),
('my($result_found)', 'wiki', 'PERL_Code', 1, 1258410605),
('$filename);', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;', 'wiki', 'PERL_Code', 7, 1258410605),
('println(&quot;filename', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;.results&quot;;', 'wiki', 'PERL_Code', 2, 1258410605),
('&quot;whois.&quot;', 'wiki', 'PERL_Code', 2, 1258410605),
('$filename', 'wiki', 'PERL_Code', 2, 1258410605),
('($to_check);', 'wiki', 'PERL_Code', 3, 1258410605),
('return($length);', 'wiki', 'PERL_Code', 1, 1258410605),
('check_whois_file', 'wiki', 'PERL_Code', 1, 1258410605),
('array', 'wiki', 'PERL_Code', 1, 1258410605),
('$length', 'wiki', 'PERL_Code', 1, 1258410605),
('size', 'wiki', 'PERL_Code', 1, 1258410605),
('element,', 'wiki', 'PERL_Code', 1, 1258410605),
('$#intarray;', 'wiki', 'PERL_Code', 1, 1258410605),
('last', 'wiki', 'PERL_Code', 1, 1258410605),
('for($i=1;', 'wiki', 'PHP', 1, 1258814906),
('$word_array=$alphabet;', 'wiki', 'PHP', 1, 1258814906),
('$strlen', 'wiki', 'PHP', 1, 1258814906),
('--max-depth=0', 'wiki', 'File System', 1, 1259504792),
('extract', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('/usr/src/rraiddriver', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('http://www.highpoint-tech.com/', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('source', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('linux', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('download', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('back', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('data', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('drives', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('additional', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('hard', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('purchase', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('http://www.skullbox.net/newsda.php', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('http://stefan.freyr.org/?page_id=6', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('http://ubuntuforums.org/showthread.php?t=543872', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('sources:', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('throughout', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('instructions.', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('treo', 'wiki', 'Linux', 1, 1258771475),
('samba', 'wiki', 'Linux', 1, 1258771475),
('/usr/local/apache/logs', 'wiki', 'System', 1, 1258410605),
('example:', 'wiki', 'System', 1, 1258410605),
('./&lt;shortcut&gt;', 'wiki', 'System', 1, 1258410605),
('file&gt;', 'wiki', 'System', 1, 1258410605),
('over', 'wiki', 'Networking', 1, 1258400800),
('speed=1gb/s', 'wiki', 'Networking', 1, 1258400800),
('pair', 'wiki', 'Networking', 2, 1258400800),
('port=twisted', 'wiki', 'Networking', 1, 1258400800),
('multicast=yes', 'wiki', 'Networking', 1, 1258400800),
('module=r8169', 'wiki', 'Networking', 1, 1258400800),
('mingnt=32', 'wiki', 'Networking', 1, 1258400800),
('maxlatency=64', 'wiki', 'Networking', 1, 1258400800),
('link=yes', 'wiki', 'Networking', 1, 1258400800),
('latency=64', 'wiki', 'Networking', 1, 1258400800),
('ip=10.0.0.3', 'wiki', 'Networking', 1, 1258400800),
('duplex=full', 'wiki', 'Networking', 1, 1258400800),
('driverversion=2.2lk', 'wiki', 'Networking', 1, 1258400800),
('driver=r8169', 'wiki', 'Networking', 1, 1258400800),
('broadcast=yes', 'wiki', 'Networking', 1, 1258400800),
('autonegotiation=on', 'wiki', 'Networking', 1, 1258400800),
('configuration:', 'wiki', 'Networking', 1, 1258400800),
('1000bt-fd', 'wiki', 'Networking', 1, 1258400800),
('persistence.properties', 'wiki', 'Searching', 1, 1259317887),
('file', 'wiki', 'Searching', 2, 1259317887),
('&quot;s/env/aging02/g&quot;', 'wiki', 'Searching', 2, 1259317887),
('replace', 'wiki', 'Searching', 1, 1259317887),
('size:”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“paper', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('&quot;betty', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('2200&quot;.', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('2200”', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('“stan', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('button.', 'wiki', 'Adobe Photoshop', 9, 1258133722),
('pop-up', 'wiki', 'Adobe Photoshop', 6, 1258133722),
('for:”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“format', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('click', 'wiki', 'Adobe Photoshop', 10, 1258133722),
('setup”', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('setup', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('page', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('setup…”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('prints', 'wiki', 'Subversion', 1, 1258498536),
('status.', 'wiki', 'Subversion', 1, 1258498536),
('status', 'wiki', 'Subversion', 3, 1258498536),
('committing.', 'wiki', 'Subversion', 2, 1258498536),
('after', 'wiki', 'Subversion', 2, 1258498536),
('well', 'wiki', 'Subversion', 2, 1258498536),
('immediately', 'wiki', 'Subversion', 2, 1258498536),
('says!', 'wiki', 'Subversion', 1, 1258498536),
('deleted', 'wiki', 'Subversion', 2, 1258498536),
('what', 'wiki', 'Subversion', 2, 1258498536),
('delete.', 'wiki', 'Subversion', 1, 1258498536),
('value', 'wiki', 'Subversion', 1, 1258498536),
('keyword', 'wiki', 'Subversion', 1, 1258498536),
('2007)', 'wiki', 'Subversion', 1, 1258498536),
('(tue,', 'wiki', 'Subversion', 1, 1258498536),
('-0500', 'wiki', 'Subversion', 1, 1258498536),
('$date:', 'wiki', 'Subversion', 1, 1258498536),
('2007-04-03', 'wiki', 'Subversion', 1, 1258498536),
('14:28:17', 'wiki', 'Subversion', 1, 1258498536),
('format', 'wiki', 'Subversion', 1, 1258498536),
('special', 'wiki', 'Subversion', 1, 1258498536),
('directory', 'wiki', 'File System', 1, 1259504792),
('particular', 'wiki', 'File System', 1, 1259504792),
('your', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 9, 1259563581),
('replace', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('using', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('kernel', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 4, 1259563581),
('version', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('providers', 'wiki', 'WebSphere', 1, 1258781258),
('$2}''', 'wiki', 'Running Processes', 1, 1259319976),
('product=0x61', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('create', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('vendor=0x830', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('options', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('line:', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/etc/modprobe.d/options', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('time', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('boot', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('visor,usbserial,usbhid,ndiswrapper,usb_storage,libusual,ehci_hcd,uhci_hcd', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('next', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('usbcore', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('134280', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('32488', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/sbin/lsmod', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('grep', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('20364', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('lsmod', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('knows', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('look', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('child', 'wiki', 'Running Processes', 1, 1259319976),
('xargs', 'wiki', 'Running Processes', 1, 1259319976),
('''{print', 'wiki', 'Running Processes', 1, 1259319976),
('group', 'wiki', 'Maintain Users', 2, 1259297843),
('&amp;', 'wiki', 'Maintain Users', 1, 1259297843),
('user', 'wiki', 'Maintain Users', 2, 1259297843),
('autonegotiation', 'wiki', 'Networking', 1, 1258400800),
('100bt-fd', 'wiki', 'Networking', 1, 1258400800),
('100bt', 'wiki', 'Networking', 1, 1258400800),
('10bt', 'wiki', 'Networking', 1, 1258400800),
('10bt-fd', 'wiki', 'Networking', 1, 1258400800),
('cap_list', 'wiki', 'Networking', 1, 1258400800),
('bus_master', 'wiki', 'Networking', 1, 1258400800),
('66mhz', 'wiki', 'Networking', 1, 1258400800),
('capabilities:', 'wiki', 'Networking', 1, 1258400800),
('clock:', 'wiki', 'Networking', 1, 1258400800),
('bits', 'wiki', 'Networking', 1, 1258400800),
('width:', 'wiki', 'Networking', 1, 1258400800),
('capacity:', 'wiki', 'Networking', 1, 1258400800),
('1gb/s', 'wiki', 'Networking', 2, 1258400800),
('size:', 'wiki', 'Networking', 1, 1258400800),
('directory', 'wiki', 'System', 1, 1258410605),
('&lt;target', 'wiki', 'System', 1, 1258410605),
('c8h10n4o2@laptop:~$', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 11, 1259470785),
('fglrxinfo', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('code!', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 11, 1259470785),
('such', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 11, 1259470785),
('sudo', 'wiki', 'Samba', 4, 1259430744),
('shares', 'wiki', 'Samba', 1, 1259430744),
('list', 'wiki', 'Samba', 1, 1259430744),
('index', 'wiki', 'PERL_Code', 1, 1258410605),
('$lastindex', 'wiki', 'PERL_Code', 3, 1258410605),
('getarraysize', 'wiki', 'PERL_Code', 1, 1258410605),
('@intarray', 'wiki', 'PERL_Code', 1, 1258410605),
('check_whois_file($domain);', 'wiki', 'PERL_Code', 1, 1258410605),
('if(dig_dns($to_check)', 'wiki', 'PERL_Code', 1, 1258410605),
('get_whois_file($domain);', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;.com&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('$strlen)', 'wiki', 'PERL_Code', 1, 1258410605),
('$to_check', 'wiki', 'PERL_Code', 1, 1258410605),
('if(length($new_domain)', 'wiki', 'PERL_Code', 1, 1258410605),
('(@orig_list)', 'wiki', 'PERL_Code', 1, 1258410605),
('$domain', 'wiki', 'PERL_Code', 10, 1258410605),
('@domains;', 'wiki', 'PERL_Code', 1, 1258410605),
('@orig_list', 'wiki', 'PERL_Code', 1, 1258410605),
('else', 'wiki', 'PERL_Code', 2, 1258410605),
('#print($new_domain', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;\\n&quot;);', 'wiki', 'PERL_Code', 1, 1258410605),
('processes', 'wiki', 'Linux', 1, 1258771475),
('perl', 'wiki', 'Searching', 3, 1259317887),
('multiple', 'wiki', 'Searching', 1, 1259317887),
('2&gt;/dev/null', 'wiki', 'Searching', 2, 1259317887),
('line', 'wiki', 'Send Email', 1, 1258884958),
('00:18:e7:16:92:cc', 'wiki', 'Networking', 1, 1258400800),
('serial:', 'wiki', 'Networking', 1, 1258400800),
('version:', 'wiki', 'Networking', 1, 1258400800),
('eth1', 'wiki', 'Networking', 1, 1258400800),
('name:', 'wiki', 'Networking', 1, 1258400800),
('logical', 'wiki', 'Networking', 1, 1258400800),
('pci@0000:01:08.0', 'wiki', 'Networking', 1, 1258400800),
('info:', 'wiki', 'Networking', 1, 1258400800),
('physical', 'wiki', 'Networking', 2, 1258400800),
('“page', 'wiki', 'Adobe Photoshop', 4, 1258133722),
('type', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('command-p.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('appears.', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('“print”', 'wiki', 'Adobe Photoshop', 5, 1258133722),
('preview”', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('“print', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('choose', 'wiki', 'Adobe Photoshop', 9, 1258133722),
('menu', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('(adobe)', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('window', 'wiki', 'Adobe Photoshop', 9, 1258133722),
('process.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('xargs', 'wiki', 'Searching', 1, 1259317887),
('&quot;hello&quot;', 'wiki', 'Searching', 2, 1259317887),
('keywords', 'wiki', 'Subversion', 1, 1258498536),
('places', 'wiki', 'Subversion', 1, 1258498536),
('properties', 'wiki', 'Subversion', 1, 1258498536),
('apply', 'wiki', 'Subversion', 2, 1258498536),
('generally', 'wiki', 'Subversion', 1, 1258498536),
('propset.', 'wiki', 'Subversion', 1, 1258498536),
('propset', 'wiki', 'Subversion', 1, 1258498536),
('below).', 'wiki', 'Subversion', 2, 1258498536),
('(see', 'wiki', 'Subversion', 3, 1258498536),
('commit', 'wiki', 'Subversion', 7, 1258498536),
('until', 'wiki', 'Subversion', 2, 1258498536),
('repository', 'wiki', 'Subversion', 8, 1258498536),
('-shk', 'wiki', 'File System', 2, 1259504792),
('ltd.', 'wiki', 'Networking', 1, 1258400800),
('co.,', 'wiki', 'Networking', 1, 1258400800),
('semiconductor', 'wiki', 'Networking', 1, 1258400800),
('realtek', 'wiki', 'Networking', 1, 1258400800),
('vendor:', 'wiki', 'Networking', 1, 1258400800),
('link', 'wiki', 'System', 1, 1258410605),
('$new_domain);', 'wiki', 'PERL_Code', 2, 1258410605),
('$char;', 'wiki', 'PERL_Code', 2, 1258410605),
('push(@domains,', 'wiki', 'PERL_Code', 2, 1258410605),
('(@chars)', 'wiki', 'PERL_Code', 2, 1258410605),
('$new_domain', 'wiki', 'PERL_Code', 3, 1258410605),
('$char', 'wiki', 'PERL_Code', 2, 1258410605),
('gigabit', 'wiki', 'Networking', 1, 1258400800),
('rtl-8169', 'wiki', 'Networking', 1, 1258400800),
('product:', 'wiki', 'Networking', 1, 1258400800),
('what', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('determine', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('ethernet', 'wiki', 'Networking', 3, 1258400800),
('interface', 'wiki', 'Networking', 1, 1258400800),
('description:', 'wiki', 'Networking', 1, 1258400800),
('also', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('ttyusb1', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('31385.683751', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('ttyusb1:', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('disconnected', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('ttyusb0', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('converter', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('palm', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('ttyusb0:', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('handspring', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('31385.682799', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('31385.683606', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('foreach', 'wiki', 'PERL_Code', 3, 1258410605),
('if(getarraysize(@domains)', 'wiki', 'PERL_Code', 1, 1258410605),
('$counter++)', 'wiki', 'PERL_Code', 1, 1258410605),
('just', 'wiki', 'OS X', 1, 1259618078),
('couldn''t', 'wiki', 'OS X', 1, 1259618078),
('ask,', 'wiki', 'OS X', 1, 1259618078),
('makes', 'wiki', 'OS X', 1, 1259618078),
('re-initialize.', 'wiki', 'OS X', 1, 1259618078),
('causing', 'wiki', 'OS X', 1, 1259618078),
('these', 'wiki', 'OS X', 1, 1259618078),
('issues', 'wiki', 'OS X', 1, 1259618078),
('should', 'wiki', 'OS X', 1, 1259618078),
('side-step', 'wiki', 'OS X', 1, 1259618078),
('hack', 'wiki', 'OS X', 1, 1259618078),
('above', 'wiki', 'OS X', 1, 1259618078),
('part.', 'wiki', 'OS X', 1, 1259618078),
('oversight', 'wiki', 'OS X', 1, 1259618078),
('astonishing', 'wiki', 'OS X', 1, 1259618078),
('telecommuters,', 'wiki', 'OS X', 1, 1259618078),
('used', 'wiki', 'OS X', 1, 1259618078),
('typically', 'wiki', 'OS X', 1, 1259618078),
('considering', 'wiki', 'OS X', 1, 1259618078),
('system.', 'wiki', 'OS X', 1, 1259618078),
('track', 'wiki', 'OS X', 1, 1259618078),
('loose', 'wiki', 'OS X', 1, 1259618078),
('ciscovpn', 'wiki', 'OS X', 3, 1259618078),
('cause', 'wiki', 'OS X', 1, 1259618078),
('reconnecting', 'wiki', 'OS X', 1, 1259618078),
('simply', 'wiki', 'OS X', 1, 1259618078),
('cable', 'wiki', 'OS X', 1, 1259618078),
('ethernet', 'wiki', 'OS X', 1, 1259618078),
('disconnecting', 'wiki', 'OS X', 1, 1259618078),
('sleep,', 'wiki', 'OS X', 1, 1259618078),
('system', 'wiki', 'OS X', 1, 1259618078),
('putting', 'wiki', 'OS X', 1, 1259618078),
('sometimes', 'wiki', 'OS X', 1, 1259618078),
('scenerios.', 'wiki', 'OS X', 1, 1259618078),
('dial-up', 'wiki', 'OS X', 1, 1259618078),
('wireless', 'wiki', 'OS X', 2, 1259618078),
('commonly', 'wiki', 'OS X', 1, 1259618078),
('happens', 'wiki', 'OS X', 1, 1259618078),
('that', 'wiki', 'OS X', 2, 1259618078),
('reappear,', 'wiki', 'OS X', 1, 1259618078),
('something', 'wiki', 'OS X', 1, 1259618078),
('disappear', 'wiki', 'OS X', 1, 1259618078),
('adapters', 'wiki', 'OS X', 2, 1259618078),
('network', 'wiki', 'OS X', 2, 1259618078),
('problems', 'wiki', 'OS X', 1, 1259618078),
('have', 'wiki', 'OS X', 2, 1259618078),
('seems', 'wiki', 'OS X', 1, 1259618078),
('extension.', 'wiki', 'OS X', 1, 1259618078),
('ciscovpn.kext', 'wiki', 'OS X', 1, 1259618078),
('other', 'wiki', 'OS X', 1, 1259618078),
('module', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 11, 1259470785),
('warning:', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 11, 1259470785),
('thinks', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('during', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('windows', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('separate', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('three', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('navigating', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('will', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('instructions', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('following', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('08:37:27', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('treo,', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('sync', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('when', 'wiki', 'Treo 650 setup with Ubuntu', 4, 1259588449),
('visor', 'wiki', 'Treo 650 setup with Ubuntu', 10, 1259588449),
('{}\\;', 'wiki', 'Searching', 2, 1259317887),
('-exec', 'wiki', 'Searching', 4, 1259317887),
('appear', 'wiki', 'Subversion', 2, 1258498536),
('won''t', 'wiki', 'Subversion', 2, 1258498536),
('that', 'wiki', 'Subversion', 6, 1258498536),
('note', 'wiki', 'Subversion', 3, 1258498536),
('that.', 'wiki', 'Subversion', 1, 1258498536),
('does', 'wiki', 'Subversion', 2, 1258498536),
('about', 'wiki', 'Subversion', 1, 1258498536),
('server', 'wiki', 'Subversion', 4, 1258498536),
('tell', 'wiki', 'Subversion', 2, 1258498536),
('directory,', 'wiki', 'Subversion', 2, 1258498536),
('file', 'wiki', 'Subversion', 10, 1258498536),
('creating', 'wiki', 'Subversion', 2, 1258498536),
('$alphabet=array(''a'',''b'',''c'',''d'',''e'',''f'',''g'',''h'',''i'',''j'',''k'',''l'',''m'',''n'',''o'',''p'',', 'wiki', 'PHP', 1, 1258814906),
('uname', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('kernel.', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('jdbc', 'wiki', 'WebSphere', 2, 1258781258),
('$strlen;', 'wiki', 'PERL_Code', 1, 1258410605),
('words', 'wiki', 'OS X', 1, 1259618078),
('subsystem&quot;,', 'wiki', 'OS X', 1, 1259618078),
('&quot;vpn', 'wiki', 'OS X', 1, 1259618078),
('start', 'wiki', 'OS X', 1, 1259618078),
('stop', 'wiki', 'OS X', 1, 1259618078),
('will', 'wiki', 'OS X', 2, 1259618078),
('this', 'wiki', 'OS X', 2, 1259618078),
('&lt;part', 'wiki', 'Running Processes', 1, 1259319976),
('name&gt;', 'wiki', 'Running Processes', 1, 1259319976),
('asks.', 'wiki', 'OS X', 1, 1259618078),
('when', 'wiki', 'OS X', 2, 1259618078),
('password', 'wiki', 'OS X', 1, 1259618078),
('printing,', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('prepared', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('usbserial', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('sudo', 'wiki', 'Treo 650 setup with Ubuntu', 5, 1259588449),
('when', 'wiki', 'Subversion', 4, 1258498536),
('add.', 'wiki', 'Subversion', 1, 1258498536),
('list.', 'wiki', 'Subversion', 2, 1258498536),
('mailing', 'wiki', 'Subversion', 3, 1258498536),
('blfs-book', 'wiki', 'Subversion', 1, 1258498536),
('running', 'wiki', 'Linux', 1, 1258771475),
('scripting', 'wiki', 'Linux', 1, 1258771475),
('*-network', 'wiki', 'Networking', 1, 1258400800),
('&lt;=', 'wiki', 'PERL_Code', 1, 1258410605),
('$counter', 'wiki', 'PERL_Code', 1, 1258410605),
('for($counter', 'wiki', 'PERL_Code', 1, 1258410605),
('your', 'wiki', 'OS X', 2, 1259618078),
('give', 'wiki', 'OS X', 1, 1259618078),
('restart', 'wiki', 'OS X', 3, 1259618078),
('generation', 'wiki', 'PHP', 1, 1258814906),
('types', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('/sbin/modprobe', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('c8h10n4o2@laptop:~$', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('talk', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('trying', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('least', 'wiki', 'Subversion', 1, 1258498536),
('announced', 'wiki', 'Subversion', 1, 1258498536),
('change', 'wiki', 'Subversion', 2, 1258498536),
('large', 'wiki', 'Subversion', 1, 1258498536),
('made', 'wiki', 'Subversion', 3, 1258498536),
('&quot;*.java&quot;', 'wiki', 'Searching', 2, 1259317887),
('grep', 'wiki', 'Running Processes', 2, 1259319976),
('multiple', 'wiki', 'Running Processes', 1, 1259319976),
('/system/library/startupitems/ciscovpn/ciscovpn', 'wiki', 'OS X', 1, 1259618078),
('have.', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('hardware', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('/etc', 'wiki', 'Searching', 3, 1259317887),
('containing', 'wiki', 'Searching', 1, 1259317887),
('symbolic', 'wiki', 'System', 1, 1258410605),
('resources', 'wiki', 'WebSphere', 1, 1258781258),
('&quot;_check_whois.results&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('once', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('site', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('save', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('&lt;user&gt;', 'wiki', 'Running Processes', 1, 1259319976),
('name', 'wiki', 'Running Processes', 1, 1259319976),
('menu.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('because', 'wiki', 'Subversion', 1, 1258498536),
('editor', 'wiki', 'Subversion', 1, 1258498536),
('ubuntu', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('display', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 5, 1259470785),
('promotion', 'wiki', 'Rational ClearCase', 2, 1259309773),
('levels:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('domain.net/ccusers', 'wiki', 'Rational ClearCase', 1, 1259309773),
('groups:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('additional', 'wiki', 'Rational ClearCase', 1, 1259309773),
('nobody', 'wiki', 'Rational ClearCase', 2, 1259309773),
('group', 'wiki', 'Rational ClearCase', 2, 1259309773),
('allowed', 'wiki', 'Rational ClearCase', 1, 1259309773),
('ownership:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('owner', 'wiki', 'Rational ClearCase', 1, 1259309773),
('user:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('privileged', 'wiki', 'Rational ClearCase', 1, 1259309773),
('remote', 'wiki', 'Rational ClearCase', 1, 1259309773),
('modification', 'wiki', 'Rational ClearCase', 1, 1259309773),
('schema', 'wiki', 'Rational ClearCase', 1, 1259309773),
('version:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('database', 'wiki', 'Rational ClearCase', 1, 1259309773),
('&quot;&lt;no-gpath&gt;&quot;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('pathname', 'wiki', 'Rational ClearCase', 1, 1259309773),
('global', 'wiki', 'Rational ClearCase', 1, 1259309773),
('&quot;vobbox:d:\\clearcase_storage\\vobs\\demo_project.vbs&quot;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('host:pathname', 'wiki', 'Rational ClearCase', 1, 1259309773),
('level:', 'wiki', 'Rational ClearCase', 2, 1259309773),
('storage', 'wiki', 'Rational ClearCase', 2, 1259309773),
('feature', 'wiki', 'Rational ClearCase', 1, 1259309773),
('family', 'wiki', 'Rational ClearCase', 1, 1259309773),
('project.&quot;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('&quot;test', 'wiki', 'Rational ClearCase', 1, 1259309773),
('users@7lq1891', 'wiki', 'Rational ClearCase', 1, 1259309773),
('caffeine.s.god.domain', 'wiki', 'Rational ClearCase', 1, 1259309773),
('&quot;/demo_project&quot;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('2008-02-04t16:31:14-06', 'wiki', 'Rational ClearCase', 1, 1259309773),
('base', 'wiki', 'Rational ClearCase', 1, 1259309773),
('object', 'wiki', 'Rational ClearCase', 1, 1259309773),
('versioned', 'wiki', 'Rational ClearCase', 1, 1259309773),
('vob:/demo_project', 'wiki', 'Rational ClearCase', 1, 1259309773),
('desc', 'wiki', 'Rational ClearCase', 1, 1259309773),
('details', 'wiki', 'Rational ClearCase', 1, 1259309773),
('user@boxname/home/user&gt;', 'wiki', 'Rational ClearCase', 2, 1259309773),
('project', 'wiki', 'Rational ClearCase', 2, 1259309773),
('\\vob_4', 'wiki', 'Rational ClearCase', 1, 1259309773),
('\\vob_3', 'wiki', 'Rational ClearCase', 1, 1259309773),
('\\vob_1', 'wiki', 'Rational ClearCase', 1, 1259309773),
('\\vob_2', 'wiki', 'Rational ClearCase', 1, 1259309773),
('-add_loadrules', 'wiki', 'Rational ClearCase', 1, 1259309773),
('from', 'wiki', 'Rational ClearCase', 1, 1259309773),
('update', 'wiki', 'Rational ClearCase', 2, 1259309773),
('will', 'wiki', 'Rational ClearCase', 1, 1259309773),
('save,', 'wiki', 'Rational ClearCase', 1, 1259309773),
('file', 'wiki', 'Rational ClearCase', 1, 1259309773),
('when', 'wiki', 'Rational ClearCase', 1, 1259309773),
('paste', 'wiki', 'Rational ClearCase', 1, 1259309773),
('copied', 'wiki', 'Rational ClearCase', 1, 1259309773),
('save', 'wiki', 'Rational ClearCase', 1, 1259309773),
('your', 'wiki', 'Rational ClearCase', 3, 1259309773),
('view''s', 'wiki', 'Rational ClearCase', 1, 1259309773),
('edcs', 'wiki', 'Rational ClearCase', 1, 1259309773),
('unixuser@unixbox/home/unixuser/new_view&gt;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('../new_view', 'wiki', 'Rational ClearCase', 1, 1259309773),
('created', 'wiki', 'Rational ClearCase', 2, 1259309773),
('under', 'wiki', 'Rational ClearCase', 2, 1259309773),
('back', 'wiki', 'Rational ClearCase', 1, 1259309773),
('lines', 'wiki', 'Rational ClearCase', 2, 1259309773),
('copy', 'wiki', 'Rational ClearCase', 1, 1259309773),
('/vob_2', 'wiki', 'Rational ClearCase', 2, 1259309773),
('load', 'wiki', 'Rational ClearCase', 7, 1259309773),
('/vob_1', 'wiki', 'Rational ClearCase', 2, 1259309773),
('ucmcustomloadbegin', 'wiki', 'Rational ClearCase', 1, 1259309773),
('-ucm', 'wiki', 'Rational ClearCase', 1, 1259309773),
('checkouts', 'wiki', 'Rational ClearCase', 1, 1259309773),
('backstop', 'wiki', 'Rational ClearCase', 1, 1259309773),
('rule:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('non-included', 'wiki', 'Rational ClearCase', 1, 1259309773),
('line', 'wiki', 'Rational ClearCase', 5, 1259309773),
('ucmcustomelemend', 'wiki', 'Rational ClearCase', 1, 1259309773),
('after', 'wiki', 'Rational ClearCase', 4, 1259309773),
('remove', 'wiki', 'Rational ClearCase', 3, 1259309773),
('custom', 'wiki', 'Rational ClearCase', 5, 1259309773),
('rules', 'wiki', 'Rational ClearCase', 5, 1259309773),
('arch_9_20_2007_fix_3', 'wiki', 'Rational ClearCase', 1, 1259309773),
('-nocheckout', 'wiki', 'Rational ClearCase', 2, 1259309773),
('ucmcustomelembegin', 'wiki', 'Rational ClearCase', 1, 1259309773),
('/main/0', 'wiki', 'Rational ClearCase', 2, 1259309773),
('&quot;e3b9d825c5e14f0092094576dca8821d=\\vob_1/...&quot;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('existing_view', 'wiki', 'Rational ClearCase', 2, 1259309773),
('2008-08-04_vob_2_72.2.10.7169', 'wiki', 'Rational ClearCase', 1, 1259309773),
('-mkbranch', 'wiki', 'Rational ClearCase', 2, 1259309773),
('.../existing_view/latest', 'wiki', 'Rational ClearCase', 1, 1259309773),
('&quot;763e4aeee7744fa0bd216b1c200660b8=\\vob_2/...&quot;', 'wiki', 'Rational ClearCase', 3, 1259309773),
('rules...', 'wiki', 'Rational ClearCase', 1, 1259309773),
('selection', 'wiki', 'Rational ClearCase', 1, 1259309773),
('checkedout', 'wiki', 'Rational ClearCase', 1, 1259309773),
('component', 'wiki', 'Rational ClearCase', 2, 1259309773),
('versions', 'wiki', 'Rational ClearCase', 1, 1259309773),
('element', 'wiki', 'Rational ClearCase', 8, 1259309773),
('checked', 'wiki', 'Rational ClearCase', 1, 1259309773),
('select', 'wiki', 'Rational ClearCase', 1, 1259309773),
('2008-08-04t10:22:37-05.', 'wiki', 'Rational ClearCase', 1, 1259309773),
('&quot;existing_view&quot;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('stream', 'wiki', 'Rational ClearCase', 2, 1259309773),
('generated', 'wiki', 'Rational ClearCase', 1, 1259309773),
('areas', 'wiki', 'Rational ClearCase', 1, 1259309773),
('automatically', 'wiki', 'Rational ClearCase', 1, 1259309773),
('indicated', 'wiki', 'Rational ClearCase', 1, 1259309773),
('lshw', 'wiki', 'Networking', 1, 1258400800),
('local', 'wiki', 'Scripting', 1, 1258052737),
('patch', 'wiki', 'Scripting', 1, 1258052737),
('&quot;custom&quot;', 'wiki', 'Rational ClearCase', 1, 1259309773),
('edit', 'wiki', 'Rational ClearCase', 2, 1259309773),
('this', 'wiki', 'Rational ClearCase', 6, 1259309773),
('only', 'wiki', 'Rational ClearCase', 1, 1259309773),
('0c3.43:95:ee:dd:f1:0d', 'wiki', 'Rational ClearCase', 1, 1259309773),
('oid:b701620c.88e64667.a1fa.4a:64:0a:55:e6:c0@vobuuid:e0023e99.5ebc4275.a', 'wiki', 'Rational ClearCase', 1, 1259309773),
('ucm.stream', 'wiki', 'Rational ClearCase', 1, 1259309773),
('identity', 'wiki', 'Rational ClearCase', 1, 1259309773),
('+warning:', 'wiki', 'Rational ClearCase', 1, 1259309773),
('+*this', 'wiki', 'Rational ClearCase', 1, 1259309773),
('gives', 'wiki', 'Rational ClearCase', 1, 1259309773),
('cleartool', 'wiki', 'Rational ClearCase', 4, 1259309773),
('catcs', 'wiki', 'Rational ClearCase', 1, 1259309773),
('unixuser@unixbox/home/unixuser/existing_view&gt;', 'wiki', 'Rational ClearCase', 2, 1259309773),
('config', 'wiki', 'Rational ClearCase', 5, 1259309773),
('spec', 'wiki', 'Rational ClearCase', 5, 1259309773),
('check', 'wiki', 'Rational ClearCase', 1, 1259309773),
('another', 'wiki', 'Rational ClearCase', 1, 1259309773),
('into', 'wiki', 'Rational ClearCase', 3, 1259309773),
('new_view', 'wiki', 'Rational ClearCase', 1, 1259309773),
('stream_name@/dc_projects', 'wiki', 'Rational ClearCase', 1, 1259309773),
('-stream', 'wiki', 'Rational ClearCase', 2, 1259309773),
('clearcase_home_ccstg', 'wiki', 'Rational ClearCase', 1, 1259309773),
('\\015\\012', 'wiki', 'Searching', 1, 1259317887),
('&quot;env&quot;', 'wiki', 'Searching', 1, 1259317887),
('grep', 'wiki', 'Searching', 5, 1259317887),
('&quot;*.ksh&quot;', 'wiki', 'Searching', 4, 1259317887),
('-name', 'wiki', 'Searching', 7, 1259317887),
('-type', 'wiki', 'Searching', 5, 1259317887),
('find', 'wiki', 'Searching', 10, 1259317887),
('create', 'wiki', 'System', 1, 1258410605),
('uname', 'wiki', 'System', 1, 1258410605),
('version', 'wiki', 'System', 2, 1258410605),
('kernel', 'wiki', 'System', 1, 1258410605),
('psrinfo', 'wiki', 'System', 1, 1258410605),
('cpu''s', 'wiki', 'System', 1, 1258410605),
('uuencode', 'wiki', 'Send Email', 1, 1258884958),
('from', 'wiki', 'Send Email', 1, 1258884958),
('bottom', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('&quot;layer&quot;', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('found', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('action', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('&quot;flatten', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('image.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('300,', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('flatten', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('dpi.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('360,', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('resolutions', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('ideal', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('inches.', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('paper', 'wiki', 'Adobe Photoshop', 7, 1258133722),
('inches', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('maximum', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('want', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('print', 'wiki', 'Adobe Photoshop', 7, 1258133722),
('document', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('adjust', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('size', 'wiki', 'Adobe Photoshop', 6, 1258133722),
('menu)', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('image--&gt;mode--&gt;convert', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('profile', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('kill', 'wiki', 'Running Processes', 2, 1259319976),
('prstat', 'wiki', 'Running Processes', 1, 1259319976),
('processes', 'wiki', 'Running Processes', 4, 1259319976),
('display', 'wiki', 'Running Processes', 1, 1259319976),
('create', 'wiki', 'Scripting', 1, 1258052737),
('running', 'wiki', 'Running Processes', 3, 1259319976),
('id&gt;', 'wiki', 'Running Processes', 1, 1259319976),
('&lt;process', 'wiki', 'Running Processes', 1, 1259319976),
('current', 'wiki', 'File System', 2, 1259504792),
('dirs', 'wiki', 'File System', 1, 1259504792),
('size', 'wiki', 'File System', 2, 1259504792),
('profile(also', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('adobergb', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('have', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('would', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('ideally', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('menu).', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('image--&gt;mode', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('mode(in', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('should', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('file.', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('original', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('edited', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('your', 'wiki', 'Adobe Photoshop', 12, 1258133722),
('copy', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('create', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('betty', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('what', 'wiki', 'Treo 650 setup with Ubuntu', 4, 1259588449),
('tell', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('know', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('doesn''t', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('message', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('means', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('this', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('disconnect,', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('31232.920043', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('08:34:54', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('choice', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('chosen', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('from', 'wiki', 'Treo 650 setup with Ubuntu', 4, 1259588449),
('configuration', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('31222.623557', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('uhci_hcd', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('address', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('using', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('speed', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('device', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('full', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('2-2:', 'wiki', 'Treo 650 setup with Ubuntu', 4, 1259588449),
('31222.449600', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('kernel:', 'wiki', 'Treo 650 setup with Ubuntu', 6, 1259588449),
('laptop', 'wiki', 'Treo 650 setup with Ubuntu', 6, 1259588449),
('output', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('08:34:43', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('following', 'wiki', 'Treo 650 setup with Ubuntu', 4, 1259588449),
('like', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('should', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('something', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('button', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('loop', 'wiki', 'Scripting', 1, 1258052737),
('$check_whois_file', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;_expires_on.results&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('$expires_on_file', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;_no_match.results&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('$no_match_file', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;whois_results/&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('$whois_dir', 'wiki', 'PERL_Code', 3, 1258410605),
('$dc_dir', 'wiki', 'PERL_Code', 5, 1258410605),
('&quot;/home/c8h10n4o2/dc/&quot;;', 'wiki', 'PERL_Code', 1, 1258410605),
('$sec;', 'wiki', 'PERL_Code', 1, 1258410605),
('$min', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;_&quot;', 'wiki', 'PERL_Code', 1, 1258410605),
('$day', 'wiki', 'PERL_Code', 2, 1258410605),
('$month', 'wiki', 'PERL_Code', 2, 1258410605),
('&quot;-&quot;', 'wiki', 'PERL_Code', 4, 1258410605),
('$date_string', 'wiki', 'PERL_Code', 4, 1258410605),
('$year', 'wiki', 'PERL_Code', 2, 1258410605),
('getcurrenttime();', 'wiki', 'PERL_Code', 1, 1258410605),
('$sec)', 'wiki', 'PERL_Code', 1, 1258410605),
('$min,', 'wiki', 'PERL_Code', 1, 1258410605),
('($hr,', 'wiki', 'PERL_Code', 1, 1258410605),
('getcurrentdate();', 'wiki', 'PERL_Code', 1, 1258410605),
('$day)', 'wiki', 'PERL_Code', 1, 1258410605),
('$month,', 'wiki', 'PERL_Code', 2, 1258410605),
('@domains', 'wiki', 'PERL_Code', 1, 1258410605),
('($year,', 'wiki', 'PERL_Code', 2, 1258410605),
('@argv0;', 'wiki', 'PERL_Code', 1, 1258410605),
('$strlen', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;z&quot;);#,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;y&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;x&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;w&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;v&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;u&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;t&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;s&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;p&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('usually', 'wiki', 'Subversion', 1, 1258498536),
('needed,', 'wiki', 'Subversion', 1, 1258498536),
('going', 'wiki', 'Subversion', 1, 1258498536),
('out.', 'wiki', 'Subversion', 1, 1258498536),
('re-check', 'wiki', 'Subversion', 1, 1258498536),
('sand', 'wiki', 'Subversion', 5, 1258498536),
('local', 'wiki', 'Subversion', 8, 1258498536),
('your', 'wiki', 'Subversion', 11, 1258498536),
('delete', 'wiki', 'Subversion', 2, 1258498536),
('occasionally', 'wiki', 'Subversion', 1, 1258498536),
('necessary),', 'wiki', 'Subversion', 1, 1258498536),
('sometimes', 'wiki', 'Subversion', 1, 1258498536),
('changed', 'wiki', 'Subversion', 3, 1258498536),
('structure', 'wiki', 'Subversion', 1, 1258498536),
('directory', 'wiki', 'Subversion', 3, 1258498536),
('once.', 'wiki', 'Subversion', 1, 1258498536),
('need', 'wiki', 'Subversion', 4, 1258498536),
('only', 'wiki', 'Subversion', 1, 1258498536),
('should', 'wiki', 'Subversion', 4, 1258498536),
('server.', 'wiki', 'Subversion', 3, 1258498536),
('book)', 'wiki', 'Subversion', 1, 1258498536),
('development', 'wiki', 'Subversion', 1, 1258498536),
('(the', 'wiki', 'Subversion', 1, 1258498536),
('blfs', 'wiki', 'Subversion', 3, 1258498536),
('svn://linuxfromscratch.org/blfs/trunk/book', 'wiki', 'Subversion', 1, 1258498536),
('such', 'wiki', 'Subversion', 2, 1258498536),
('tree', 'wiki', 'Subversion', 1, 1258498536),
('pull', 'wiki', 'Subversion', 1, 1258498536),
('used', 'wiki', 'Subversion', 2, 1258498536),
('command', 'wiki', 'Subversion', 7, 1258498536),
('this', 'wiki', 'Subversion', 13, 1258498536),
('checkout', 'wiki', 'Subversion', 4, 1258498536),
('checkout/co', 'wiki', 'Subversion', 1, 1258498536),
('description.', 'wiki', 'Subversion', 1, 1258498536),
('listed', 'wiki', 'Subversion', 1, 1258498536),
('both', 'wiki', 'Subversion', 1, 1258498536),
('short.', 'wiki', 'Subversion', 1, 1258498536),
('forms,', 'wiki', 'Subversion', 1, 1258498536),
('long', 'wiki', 'Subversion', 1, 1258498536),
('have', 'wiki', 'Subversion', 5, 1258498536),
('some', 'wiki', 'Subversion', 1, 1258498536),
('2.6.22-14-server', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('instruction', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('this', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('worked.', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('that', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('some', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('finally', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('found', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('linux,', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('driver', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 4, 1259563581),
('installing', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('&amp;', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 6, 1259563581),
('building', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('instructions', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 3, 1259563581),
('horrible', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('highpoint''s', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('figure', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('trying', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('work', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('amount', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('long', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('after', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('edition.', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('server', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('ubuntu', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('migrate', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('root@server:/home/c8h10n4o2#', 'wiki', 'Networking', 1, 1258400800),
('list', 'wiki', 'Networking', 2, 1258400800),
('hardware', 'wiki', 'Networking', 1, 1258400800),
('from', 'wiki', 'Networking', 3, 1258400800),
('card', 'wiki', 'Networking', 1, 1258400800),
('query', 'wiki', 'Networking', 1, 1258400800),
('full', 'wiki', 'Networking', 1, 1258400800),
('duplex', 'wiki', 'Networking', 1, 1258400800),
('1000', 'wiki', 'Networking', 1, 1258400800),
('config', 'wiki', 'Networking', 1, 1258400800),
('modify', 'wiki', 'Networking', 2, 1258400800),
('mii-tool', 'wiki', 'Networking', 1, 1258400800),
('eth0', 'wiki', 'Networking', 2, 1258400800),
('ethtool', 'wiki', 'Networking', 2, 1258400800),
('sudo', 'wiki', 'Networking', 6, 1258400800),
('speed', 'wiki', 'Networking', 4, 1258400800),
('network', 'wiki', 'Networking', 4, 1258400800),
('&quot;', 'wiki', 'Networking', 1, 1258400800),
('&quot;listen', 'wiki', 'Networking', 1, 1258400800),
('grep', 'wiki', 'Networking', 1, 1258400800),
('listening', 'wiki', 'Networking', 1, 1258400800),
('ports', 'wiki', 'Networking', 1, 1258400800),
('&amp;', 'wiki', 'Networking', 2, 1258400800),
('apps', 'wiki', 'Networking', 1, 1258400800),
('display', 'wiki', 'Networking', 3, 1258400800),
('/\\.1666$/{sum+=1}end{print', 'wiki', 'Networking', 1, 1258400800),
('sum}''', 'wiki', 'Networking', 2, 1258400800),
('num&gt;$/{sum+=1}end{print', 'wiki', 'Networking', 1, 1258400800),
('/\\.&lt;port', 'wiki', 'Networking', 1, 1258400800),
('netstat', 'wiki', 'Networking', 3, 1258400800),
('port', 'wiki', 'Networking', 1, 1258400800),
('connections', 'wiki', 'Networking', 2, 1258400800),
('open', 'wiki', 'Networking', 1, 1258400800),
('number', 'wiki', 'Networking', 1, 1258400800),
('number', 'wiki', 'System', 1, 1258410605),
('uptime', 'wiki', 'System', 1, 1258410605),
('been', 'wiki', 'System', 1, 1258410605),
('system', 'wiki', 'System', 2, 1258410605),
('time', 'wiki', 'System', 1, 1258410605),
('written', 'wiki', 'PHP', 1, 1258814906),
('domaincheck', 'wiki', 'PHP', 1, 1258814906),
('this', 'wiki', 'PHP', 1, 1258814906),
('&lt;?php', 'wiki', 'PHP', 1, 1258814906),
('code!', 'wiki', 'PHP', 1, 1258814906),
('module', 'wiki', 'PHP', 1, 1258814906),
('networking', 'wiki', 'Linux', 1, 1258771475),
('users', 'wiki', 'Linux', 1, 1258771475),
('maintain', 'wiki', 'Linux', 1, 1258771475),
('info', 'wiki', 'WebSphere', 1, 1258781258),
('apply', 'wiki', 'WebSphere', 2, 1258781258),
('level', 'wiki', 'WebSphere', 1, 1258781258),
('cell', 'wiki', 'WebSphere', 1, 1258781258),
('variables', 'wiki', 'WebSphere', 1, 1258781258),
('manage', 'wiki', 'WebSphere', 1, 1258781258),
('environment', 'wiki', 'WebSphere', 1, 1258781258),
('vars', 'wiki', 'WebSphere', 1, 1258781258),
('frequently.', 'wiki', 'Subversion', 1, 1258498536),
('will', 'wiki', 'Subversion', 11, 1258498536),
('editors', 'wiki', 'Subversion', 1, 1258498536),
('which', 'wiki', 'Subversion', 2, 1258498536),
('following', 'wiki', 'Subversion', 2, 1258498536),
('helpful.', 'wiki', 'Subversion', 1, 1258498536),
('especially', 'wiki', 'Subversion', 1, 1258498536),
('chapter', 'wiki', 'Subversion', 1, 1258498536),
('http://svnbook.red-bean.com/en/1.2/index.html.', 'wiki', 'Subversion', 1, 1258498536),
('book', 'wiki', 'Subversion', 1, 1258498536),
('on-line', 'wiki', 'Subversion', 1, 1258498536),
('from', 'wiki', 'Subversion', 8, 1258498536),
('information', 'wiki', 'Subversion', 2, 1258498536),
('detailed', 'wiki', 'Subversion', 1, 1258498536),
('more', 'wiki', 'Subversion', 1, 1258498536),
('commands.', 'wiki', 'Subversion', 1, 1258498536),
('available', 'wiki', 'Subversion', 3, 1258498536),
('summary', 'wiki', 'Subversion', 1, 1258498536),
('provides', 'wiki', 'Subversion', 1, 1258498536);
INSERT INTO `tiki_searchindex` (`searchword`, `location`, `page`, `count`, `last_update`) VALUES
('help)', 'wiki', 'Subversion', 1, 1258498536),
('(svn', 'wiki', 'Subversion', 1, 1258498536),
('subversion', 'wiki', 'Subversion', 6, 1258498536),
('function', 'wiki', 'Subversion', 1, 1258498536),
('help', 'wiki', 'Subversion', 1, 1258498536),
('introduction', 'wiki', 'Subversion', 1, 1258498536),
('http://www.linuxfromscratch.org/blfs/edguide/chapter03.html', 'wiki', 'Subversion', 1, 1258498536),
('source:', 'wiki', 'Subversion', 2, 1258498536),
('commands', 'wiki', 'Subversion', 5, 1258498536),
('basic', 'wiki', 'Subversion', 3, 1258498536),
('what', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('working', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('accelleration', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 3, 1259470785),
('linux', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 3, 1259470785),
('recognized', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('sure', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('radeon', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 3, 1259470785),
('9800', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('make', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('check', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('http://wiki.cchtml.com/index.php/ubuntu_edgy_installation_guide', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('thanks', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('ubuntu', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('special', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('with', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('m675x', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('gateway', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('card', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 7, 1259470785),
('searching', 'wiki', 'Linux', 1, 1258771475),
('file', 'wiki', 'Linux', 1, 1258771475),
('system', 'wiki', 'Linux', 2, 1258771475),
('websphere', 'wiki', 'WebSphere', 4, 1258781258),
('modify', 'wiki', 'WebSphere', 1, 1258781258),
('such', 'wiki', 'PHP', 1, 1258814906),
('http://www.adobe.com/designcenter/premiere/articles/prp2it_trimming.html', 'wiki', 'Adobe Premier', 1, 1258903109),
('warning:', 'wiki', 'PHP', 1, 1258814906),
('sudo', 'wiki', 'OS X', 1, 1259618078),
('following:', 'wiki', 'OS X', 1, 1259618078),
('type', 'wiki', 'OS X', 1, 1259618078),
('terminal)', 'wiki', 'OS X', 1, 1259618078),
('utilities', 'wiki', 'OS X', 1, 1259618078),
('-&gt;', 'wiki', 'OS X', 2, 1259618078),
('(applications', 'wiki', 'OS X', 1, 1259618078),
('window,', 'wiki', 'OS X', 1, 1259618078),
('terminal', 'wiki', 'OS X', 1, 1259618078),
('open', 'wiki', 'OS X', 1, 1259618078),
('vpnclient,', 'wiki', 'OS X', 1, 1259618078),
('quit', 'wiki', 'OS X', 1, 1259618078),
('simple', 'wiki', 'OS X', 1, 1259618078),
('subsystem&quot;.', 'wiki', 'OS X', 1, 1259618078),
('stan', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('either', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('file', 'wiki', 'Adobe Photoshop', 5, 1258133722),
('with', 'wiki', 'Adobe Photoshop', 2, 1258133722),
('image', 'wiki', 'Adobe Photoshop', 9, 1258133722),
('photoshop', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('preparing', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('-stgloc', 'wiki', 'Rational ClearCase', 1, 1259309773),
('-snap', 'wiki', 'Rational ClearCase', 1, 1259309773),
('mkview', 'wiki', 'Rational ClearCase', 1, 1259309773),
('unixuser@unixbox/home/unixuser&gt;cleartool', 'wiki', 'Rational ClearCase', 1, 1259309773),
('code!', 'wiki', 'Rational ClearCase', 10, 1259309773),
('module', 'wiki', 'Rational ClearCase', 10, 1259309773),
('such', 'wiki', 'Rational ClearCase', 10, 1259309773),
('warning:', 'wiki', 'Rational ClearCase', 9, 1259309773),
('clearcase', 'wiki', 'Rational ClearCase', 2, 1259309773),
('view', 'wiki', 'Rational ClearCase', 6, 1259309773),
('snapshot', 'wiki', 'Rational ClearCase', 1, 1259309773),
('create', 'wiki', 'Rational ClearCase', 2, 1259309773),
('files', 'wiki', 'Searching', 4, 1259317887),
('string', 'wiki', 'Searching', 3, 1259317887),
('search', 'wiki', 'Searching', 3, 1259317887),
('ptree', 'wiki', 'Running Processes', 1, 1259319976),
('tree', 'wiki', 'Running Processes', 1, 1259319976),
('process', 'wiki', 'Running Processes', 2, 1259319976),
('from', 'wiki', 'Adobe Photoshop', 3, 1258133722),
('2200', 'wiki', 'Adobe Photoshop', 5, 1258133722),
('epson', 'wiki', 'Adobe Photoshop', 5, 1258133722),
('printing', 'wiki', 'Adobe Photoshop', 5, 1258133722),
('name.', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 1, 1259470785),
('graphics', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 4, 1259470785),
('your', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 7, 1259470785),
('configure', 'wiki', 'Gateway m675x Radeon 9700m Ubuntu Setup', 2, 1259470785),
('&quot;&lt;br&gt;&quot;);', 'wiki', 'PHP', 1, 1258814906),
('generate', 'wiki', 'PHP', 1, 1258814906),
('string', 'wiki', 'PHP', 1, 1258814906),
('usage', 'wiki', 'File System', 2, 1259504792),
('disk', 'wiki', 'File System', 2, 1259504792),
('communicate', 'wiki', 'OS X', 1, 1259618078),
('unable', 'wiki', 'OS X', 1, 1259618078),
('&quot;error', 'wiki', 'OS X', 1, 1259618078),
('tormented', 'wiki', 'OS X', 1, 1259618078),
('with', 'wiki', 'OS X', 2, 1259618078),
('familiar', 'wiki', 'OS X', 1, 1259618078),
('might', 'wiki', 'OS X', 1, 1259618078),
('osx,', 'wiki', 'OS X', 1, 1259618078),
('hotsync?', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('click', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('/var/log/messages', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('tail', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('code!', 'wiki', 'Treo 650 setup with Ubuntu', 9, 1259588449),
('module', 'wiki', 'Treo 650 setup with Ubuntu', 9, 1259588449),
('such', 'wiki', 'Treo 650 setup with Ubuntu', 9, 1259588449),
('warning:', 'wiki', 'Treo 650 setup with Ubuntu', 9, 1259588449),
('your', 'wiki', 'Treo 650 setup with Ubuntu', 7, 1259588449),
('sees', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('check', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('computer', 'wiki', 'Treo 650 setup with Ubuntu', 2, 1259588449),
('treo', 'wiki', 'Treo 650 setup with Ubuntu', 3, 1259588449),
('hook', 'wiki', 'Treo 650 setup with Ubuntu', 1, 1259588449),
('&quot;r&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;o&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;n&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;m&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;l&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;k&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;j&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;i&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;h&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;g&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;f&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;e&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;d&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;c&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('&quot;b&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('@chars', 'wiki', 'PERL_Code', 1, 1258410605),
('(&quot;a&quot;,', 'wiki', 'PERL_Code', 1, 1258410605),
('net::smtp;', 'wiki', 'PERL_Code', 1, 1258410605),
('net::hostent;', 'wiki', 'PERL_Code', 1, 1258410605),
('getopt::long;', 'wiki', 'PERL_Code', 1, 1258410605),
('time::localtime;', 'wiki', 'PERL_Code', 1, 1258410605),
('here', 'wiki', 'PERL_Code', 1, 1258410605),
('include', 'wiki', 'PERL_Code', 1, 1258410605),
('modules', 'wiki', 'PERL_Code', 1, 1258410605),
('perl', 'wiki', 'PERL_Code', 1, 1258410605),
('specify', 'wiki', 'PERL_Code', 1, 1258410605),
('exit();', 'wiki', 'PERL_Code', 1, 1258410605),
('&lt;length&gt;&quot;);', 'wiki', 'PERL_Code', 1, 1258410605),
('dc.pl', 'wiki', 'PERL_Code', 1, 1258410605),
('println(&quot;usage:', 'wiki', 'PERL_Code', 1, 1258410605),
('if(!defined(@argv0))', 'wiki', 'PERL_Code', 1, 1258410605),
('code!', 'wiki', 'PERL_Code', 1, 1258410605),
('module', 'wiki', 'PERL_Code', 1, 1258410605),
('such', 'wiki', 'PERL_Code', 1, 1258410605),
('warning:', 'wiki', 'PERL_Code', 1, 1258410605),
('check', 'wiki', 'PERL_Code', 3, 1258410605),
('domain', 'wiki', 'PERL_Code', 3, 1258410605),
('applications--&gt;utilities', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('folder)and', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('double-click', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('stylus', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('2200.', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('source:', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('http://web.mit.edu/vap/resources/guides/epson2200.html', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('adobe', 'wiki', 'Adobe Photoshop', 1, 1258133722),
('wanted', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('2000.', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('windows', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('running', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('raid5', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('with', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 3, 1259563581),
('card', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('1820a', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('rocketraid', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 2, 1259563581),
('through', 'wiki', 'Networking', 1, 1258400800),
('look', 'wiki', 'Networking', 1, 1258400800),
('line', 'wiki', 'Networking', 2, 1258400800),
('looks', 'wiki', 'Networking', 2, 1258400800),
('like', 'wiki', 'Networking', 2, 1258400800),
('&quot;hosts:', 'wiki', 'Networking', 1, 1258400800),
('files', 'wiki', 'Networking', 2, 1258400800),
('dns&quot;', 'wiki', 'Networking', 1, 1258400800),
('&quot;wins&quot;', 'wiki', 'Networking', 2, 1258400800),
('note:', 'wiki', 'Networking', 1, 1258400800),
('come', 'wiki', 'Networking', 1, 1258400800),
('before', 'wiki', 'Networking', 1, 1258400800),
('&quot;dns&quot;', 'wiki', 'Networking', 1, 1258400800),
('opendns', 'wiki', 'Networking', 1, 1258400800),
('service.', 'wiki', 'Networking', 1, 1258400800),
('this:', 'wiki', 'Networking', 1, 1258400800),
('hosts:', 'wiki', 'Networking', 1, 1258400800),
('wins', 'wiki', 'Networking', 1, 1258400800),
('save', 'wiki', 'Networking', 1, 1258400800),
('hitting', 'wiki', 'Networking', 1, 1258400800),
('you''ll', 'wiki', 'Networking', 1, 1258400800),
('need', 'wiki', 'Networking', 1, 1258400800),
('install', 'wiki', 'Networking', 2, 1258400800),
('winbind', 'wiki', 'Networking', 2, 1258400800),
('aptitude', 'wiki', 'Networking', 1, 1258400800),
('source:', 'wiki', 'Networking', 1, 1258400800),
('http://ubuntuforums.org/showthread.php?t=288534', 'wiki', 'Networking', 1, 1258400800),
('networking', 'wiki', 'Networking', 1, 1258400800),
('localtime-&gt;min())', 'wiki', 'PERL_Code', 1, 1258410605),
('localtime-&gt;min();', 'wiki', 'PERL_Code', 1, 1258410605),
('$second', 'wiki', 'PERL_Code', 1, 1258410605),
('(localtime-&gt;sec()', 'wiki', 'PERL_Code', 1, 1258410605),
('localtime-&gt;sec())', 'wiki', 'PERL_Code', 1, 1258410605),
('localtime-&gt;sec();', 'wiki', 'PERL_Code', 1, 1258410605),
('($hour,', 'wiki', 'PERL_Code', 1, 1258410605),
('$minute,', 'wiki', 'PERL_Code', 1, 1258410605),
('$second);', 'wiki', 'PERL_Code', 1, 1258410605),
('perl_code', 'wiki', 'PERL_Code', 1, 1258410605),
('stty', 'wiki', 'System', 1, 1258410605),
('columns', 'wiki', 'System', 1, 1258410605),
('file', 'wiki', 'Send Email', 1, 1258884958),
('email', 'wiki', 'Send Email', 2, 1258884958),
('&lt;location', 'wiki', 'Subversion', 1, 1258498536),
('/svn/cablecrazy&gt;', 'wiki', 'Subversion', 1, 1258498536),
('svnpath', 'wiki', 'Subversion', 1, 1258498536),
('authtype', 'wiki', 'Subversion', 1, 1258498536),
('authname', 'wiki', 'Subversion', 1, 1258498536),
('&quot;subversion', 'wiki', 'Subversion', 1, 1258498536),
('repository&quot;', 'wiki', 'Subversion', 1, 1258498536),
('authuserfile', 'wiki', 'Subversion', 1, 1258498536),
('/etc/subversion/passwd', 'wiki', 'Subversion', 1, 1258498536),
('require', 'wiki', 'Subversion', 1, 1258498536),
('valid-user', 'wiki', 'Subversion', 1, 1258498536),
('&lt;/location&gt;', 'wiki', 'Subversion', 1, 1258498536),
('bounce', 'wiki', 'Subversion', 1, 1258498536),
('/etc/init.d/apache2', 'wiki', 'Subversion', 1, 1258498536),
('restart', 'wiki', 'Subversion', 1, 1258498536),
('initial', 'wiki', 'Subversion', 1, 1258498536),
('&quot;initial', 'wiki', 'Subversion', 1, 1258498536),
('import&quot;', 'wiki', 'Subversion', 1, 1258498536),
('/var/www/cable_crazy', 'wiki', 'Subversion', 1, 1258498536),
('file:///usr/local/svn/cablecrazy', 'wiki', 'Subversion', 1, 1258498536),
('view', 'wiki', 'Subversion', 1, 1258498536),
('c8h10n4o2@greenbox:/var/www$', 'wiki', 'Subversion', 1, 1258498536),
('http://greenbox/svn/cablecrazy~np~', 'wiki', 'Subversion', 1, 1258498536),
('cluster', 'wiki', 'WebSphere', 2, 1258781258),
('start', 'wiki', 'WebSphere', 3, 1258781258),
('?&gt;', 'wiki', 'PHP', 1, 1258814906),
('vob:/demo_ccd', 'wiki', 'Rational ClearCase', 1, 1259309773),
('vob:/demo_dao', 'wiki', 'Rational ClearCase', 1, 1259309773),
('vob:/demo_bo', 'wiki', 'Rational ClearCase', 1, 1259309773),
('vob:/demo_composite', 'wiki', 'Rational ClearCase', 1, 1259309773),
('vob:/demo_batch', 'wiki', 'Rational ClearCase', 1, 1259309773),
('list', 'wiki', 'Rational ClearCase', 1, 1259309773),
('baselines', 'wiki', 'Rational ClearCase', 1, 1259309773),
('/opt/rational/clearcase/bin/cleartool', 'wiki', 'Rational ClearCase', 1, 1259309773),
('lsbl', 'wiki', 'Rational ClearCase', 1, 1259309773),
('app_73.2.0.0_tst@/my_projects', 'wiki', 'Rational ClearCase', 1, 1259309773),
('app_73.2.0.0_9_4_2008.5244', 'wiki', 'Rational ClearCase', 1, 1259309773),
('2008_09_08_app_73.0.1.0_1.3087', 'wiki', 'Rational ClearCase', 1, 1259309773),
('2009-09-09_app__73.2.0_2.8429', 'wiki', 'Rational ClearCase', 1, 1259309773),
('rational', 'wiki', 'Rational ClearCase', 1, 1259309773),
('done', 'wiki', 'Searching', 1, 1259317887),
('searching', 'wiki', 'Searching', 1, 1259317887),
('system', 'wiki', 'File System', 1, 1259504792),
('partitioning', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('formatting', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('highpoint', 'wiki', 'Highpoint RocketRAID 1820A with Ubuntu', 1, 1259563581),
('vpnclient', 'wiki', 'OS X', 1, 1259618078),
('cisco''s', 'wiki', 'OS X', 2, 1259618078),
('running', 'wiki', 'OS X', 1, 1259618078),
('document', 'wiki', 'OS X', 1, 1259618078),
('source', 'wiki', 'OS X', 1, 1259618078),
('cisco', 'wiki', 'OS X', 3, 1259618078),
('client?', 'wiki', 'OS X', 1, 1259618078),
('better', 'wiki', 'OS X', 1, 1259618078),
('idea', 'wiki', 'OS X', 1, 1259618078),
('would', 'wiki', 'OS X', 1, 1259618078),
('reinvent', 'wiki', 'OS X', 1, 1259618078),
('wheel', 'wiki', 'OS X', 1, 1259618078),
('existing', 'wiki', 'OS X', 1, 1259618078),
('ipsec', 'wiki', 'OS X', 1, 1259618078),
('support', 'wiki', 'OS X', 1, 1259618078),
('osx!', 'wiki', 'OS X', 1, 1259618078),
('missing', 'wiki', 'OS X', 1, 1259618078),
('something?', 'wiki', 'OS X', 1, 1259618078);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_searchsyllable`
--

CREATE TABLE IF NOT EXISTS `tiki_searchsyllable` (
  `syllable` varchar(80) NOT NULL default '',
  `lastUsed` int(11) NOT NULL default '0',
  `lastUpdated` int(11) NOT NULL default '0',
  PRIMARY KEY  (`syllable`),
  KEY `lastUsed` (`lastUsed`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_searchsyllable`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_searchwords`
--

CREATE TABLE IF NOT EXISTS `tiki_searchwords` (
  `syllable` varchar(80) NOT NULL default '',
  `searchword` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`syllable`,`searchword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_searchwords`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_secdb`
--

CREATE TABLE IF NOT EXISTS `tiki_secdb` (
  `md5_value` varchar(32) NOT NULL default '',
  `filename` varchar(250) NOT NULL default '',
  `tiki_version` varchar(60) NOT NULL default '',
  `severity` int(4) NOT NULL default '0',
  PRIMARY KEY  (`md5_value`,`filename`(100),`tiki_version`),
  KEY `sdb_fn` (`filename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_secdb`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_semaphores`
--

CREATE TABLE IF NOT EXISTS `tiki_semaphores` (
  `semName` varchar(250) NOT NULL default '',
  `user` varchar(40) default NULL,
  `timestamp` int(14) default NULL,
  PRIMARY KEY  (`semName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_semaphores`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_sent_newsletters`
--

CREATE TABLE IF NOT EXISTS `tiki_sent_newsletters` (
  `editionId` int(12) NOT NULL auto_increment,
  `nlId` int(12) NOT NULL default '0',
  `users` int(10) default NULL,
  `sent` int(14) default NULL,
  `subject` varchar(200) default NULL,
  `data` longblob,
  PRIMARY KEY  (`editionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_sent_newsletters`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_sessions`
--

CREATE TABLE IF NOT EXISTS `tiki_sessions` (
  `sessionId` varchar(32) NOT NULL default '',
  `user` varchar(40) default NULL,
  `timestamp` int(14) default NULL,
  `tikihost` varchar(200) default NULL,
  PRIMARY KEY  (`sessionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_sessions`
--

INSERT INTO `tiki_sessions` (`sessionId`, `user`, `timestamp`, `tikihost`) VALUES
('d16d39117d843b493cde5e7c9fb01216', NULL, 1259715580, 'www.h8n.com');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_sheet_layout`
--

CREATE TABLE IF NOT EXISTS `tiki_sheet_layout` (
  `sheetId` int(8) NOT NULL default '0',
  `begin` int(10) NOT NULL default '0',
  `end` int(10) default NULL,
  `headerRow` int(4) NOT NULL default '0',
  `footerRow` int(4) NOT NULL default '0',
  `className` varchar(64) default NULL,
  UNIQUE KEY `sheetId` (`sheetId`,`begin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_sheet_layout`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_sheet_values`
--

CREATE TABLE IF NOT EXISTS `tiki_sheet_values` (
  `sheetId` int(8) NOT NULL default '0',
  `begin` int(10) NOT NULL default '0',
  `end` int(10) default NULL,
  `rowIndex` int(4) NOT NULL default '0',
  `columnIndex` int(4) NOT NULL default '0',
  `value` varchar(255) default NULL,
  `calculation` varchar(255) default NULL,
  `width` int(4) NOT NULL default '1',
  `height` int(4) NOT NULL default '1',
  `format` varchar(255) default NULL,
  UNIQUE KEY `sheetId` (`sheetId`,`begin`,`rowIndex`,`columnIndex`),
  KEY `sheetId_2` (`sheetId`,`rowIndex`,`columnIndex`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_sheet_values`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_sheets`
--

CREATE TABLE IF NOT EXISTS `tiki_sheets` (
  `sheetId` int(8) NOT NULL auto_increment,
  `title` varchar(200) NOT NULL default '',
  `description` text,
  `author` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`sheetId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_sheets`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_shoutbox`
--

CREATE TABLE IF NOT EXISTS `tiki_shoutbox` (
  `msgId` int(10) NOT NULL auto_increment,
  `message` varchar(255) default NULL,
  `timestamp` int(14) default NULL,
  `user` varchar(40) default NULL,
  `hash` varchar(32) default NULL,
  PRIMARY KEY  (`msgId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_shoutbox`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_shoutbox_words`
--

CREATE TABLE IF NOT EXISTS `tiki_shoutbox_words` (
  `word` varchar(40) NOT NULL default '',
  `qty` int(11) NOT NULL default '0',
  PRIMARY KEY  (`word`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_shoutbox_words`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_stats`
--

CREATE TABLE IF NOT EXISTS `tiki_stats` (
  `object` varchar(255) NOT NULL default '',
  `type` varchar(20) NOT NULL default '',
  `day` int(14) NOT NULL default '0',
  `hits` int(14) NOT NULL default '0',
  PRIMARY KEY  (`object`,`type`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_stats`
--

INSERT INTO `tiki_stats` (`object`, `type`, `day`, `hits`) VALUES
('HomePage', 'wiki', 1171650600, 0),
('HomePage', 'wiki', 1181880000, 43),
('Linux', 'wiki', 1181880000, 23),
('Networking', 'wiki', 1181880000, 3),
('Searching', 'wiki', 1181880000, 7),
('Scripting', 'wiki', 1181880000, 2),
('Maintain Users', 'wiki', 1181880000, 3),
('File System', 'wiki', 1181880000, 2),
('Running Processes', 'wiki', 1181880000, 3),
('System', 'wiki', 1181880000, 1),
('WebSphere', 'wiki', 1181880000, 3),
('Subversion', 'wiki', 1181880000, 6),
('HomePage', 'wiki', 1181966400, 9),
('HomePage', 'wiki', 1182052800, 6),
('Linux', 'wiki', 1182052800, 2),
('Networking', 'wiki', 1182052800, 1),
('HomePage', 'wiki', 1182139200, 8),
('Linux', 'wiki', 1182139200, 3),
('System', 'wiki', 1182139200, 4),
('HomePage', 'wiki', 1182225600, 4),
('HomePage', 'wiki', 1182312000, 2),
('HomePage', 'wiki', 1182398400, 39),
('System', 'wiki', 1182398400, 1),
('Subversion', 'wiki', 1182398400, 2),
('Adobe Premier', 'wiki', 1182398400, 1),
('PHP', 'wiki', 1182398400, 5),
('Scripting', 'wiki', 1182398400, 2),
('Linux', 'wiki', 1182398400, 1),
('PERL_Code', 'wiki', 1182398400, 2),
('HomePage', 'wiki', 1182484800, 1),
('HomePage', 'wiki', 1182571200, 2),
('PERL_Code', 'wiki', 1182571200, 1),
('WebSphere', 'wiki', 1182657600, 1),
('HomePage', 'wiki', 1182657600, 3),
('Subversion', 'wiki', 1182744000, 1),
('HomePage', 'wiki', 1182830400, 2),
('Adobe Premier', 'wiki', 1182830400, 1),
('PERL_Code', 'wiki', 1182830400, 1),
('PHP', 'wiki', 1182830400, 1),
('HomePage', 'wiki', 1182916800, 2),
('PERL_Code', 'wiki', 1182916800, 1),
('HomePage', 'wiki', 1183003200, 3),
('HomePage', 'wiki', 1183089600, 1),
('HomePage', 'wiki', 1183176000, 2),
('Subversion', 'wiki', 1183176000, 1),
('WebSphere', 'wiki', 1183262400, 1),
('Adobe Premier', 'wiki', 1183262400, 1),
('HomePage', 'wiki', 1183262400, 4),
('Linux', 'wiki', 1183262400, 4),
('File System', 'wiki', 1183262400, 2),
('System', 'wiki', 1183262400, 2),
('PHP', 'wiki', 1183348800, 1),
('Linux', 'wiki', 1183348800, 2),
('PERL_Code', 'wiki', 1183348800, 1),
('HomePage', 'wiki', 1183348800, 1),
('Networking', 'wiki', 1183348800, 2),
('HomePage', 'wiki', 1183435200, 1),
('HomePage', 'wiki', 1183521600, 5),
('PERL_Code', 'wiki', 1183521600, 2),
('PHP', 'wiki', 1183521600, 2),
('Linux', 'wiki', 1183521600, 2),
('WebSphere', 'wiki', 1183521600, 2),
('Adobe Premier', 'wiki', 1183521600, 2),
('Subversion', 'wiki', 1183521600, 2),
('System', 'wiki', 1183521600, 1),
('Searching', 'wiki', 1183521600, 1),
('Networking', 'wiki', 1183521600, 2),
('File System', 'wiki', 1183521600, 2),
('Scripting', 'wiki', 1183521600, 2),
('Maintain Users', 'wiki', 1183521600, 1),
('Running Processes', 'wiki', 1183521600, 1),
('Searching', 'wiki', 1183608000, 1),
('Networking', 'wiki', 1183608000, 1),
('File System', 'wiki', 1183608000, 2),
('System', 'wiki', 1183608000, 1),
('Running Processes', 'wiki', 1183608000, 1),
('Maintain Users', 'wiki', 1183608000, 1),
('HomePage', 'wiki', 1183608000, 4),
('Linux', 'wiki', 1183608000, 1),
('Subversion', 'wiki', 1183608000, 1),
('HomePage', 'wiki', 1183694400, 9),
('Quotes', 'wiki', 1183694400, 1),
('Linux', 'wiki', 1183694400, 3),
('Samba', 'wiki', 1183694400, 3),
('PERL_Code', 'wiki', 1183694400, 1),
('HomePage', 'wiki', 1183780800, 2),
('HomePage', 'wiki', 1183867200, 4),
('WebSphere', 'wiki', 1183867200, 1),
('Adobe Premier', 'wiki', 1183867200, 1),
('Quotes', 'wiki', 1183867200, 2),
('HomePage', 'wiki', 1183953600, 3),
('PHP', 'wiki', 1183953600, 1),
('PERL_Code', 'wiki', 1183953600, 1),
('WebSphere', 'wiki', 1183953600, 1),
('Subversion', 'wiki', 1183953600, 1),
('Adobe Premier', 'wiki', 1183953600, 1),
('Linux', 'wiki', 1183953600, 1),
('HomePage', 'wiki', 1184040000, 2),
('Quotes', 'wiki', 1184040000, 1),
('WebSphere', 'wiki', 1184126400, 3),
('HomePage', 'wiki', 1184126400, 10),
('Adobe Premier', 'wiki', 1184126400, 2),
('PHP', 'wiki', 1184126400, 2),
('Subversion', 'wiki', 1184126400, 7),
('Searching', 'wiki', 1184126400, 2),
('PERL_Code', 'wiki', 1184126400, 3),
('Networking', 'wiki', 1184126400, 2),
('Quotes', 'wiki', 1184126400, 2),
('Linux', 'wiki', 1184126400, 2),
('Running Processes', 'wiki', 1184126400, 2),
('Maintain Users', 'wiki', 1184126400, 3),
('Samba', 'wiki', 1184126400, 2),
('Scripting', 'wiki', 1184126400, 2),
('System', 'wiki', 1184126400, 2),
('File System', 'wiki', 1184126400, 5),
('HomePage', 'wiki', 1184212800, 5),
('Linux', 'wiki', 1184212800, 2),
('PERL_Code', 'wiki', 1184212800, 3),
('Samba', 'wiki', 1184212800, 1),
('HomePage', 'wiki', 1184299200, 4),
('Linux', 'wiki', 1184299200, 1),
('Subversion', 'wiki', 1184299200, 1),
('PHP', 'wiki', 1184299200, 1),
('WebSphere', 'wiki', 1184299200, 1),
('PERL_Code', 'wiki', 1184299200, 1),
('Adobe Premier', 'wiki', 1184299200, 1),
('Quotes', 'wiki', 1184299200, 1),
('WebSphere', 'wiki', 1184385600, 1),
('HomePage', 'wiki', 1184385600, 1),
('HomePage', 'wiki', 1184472000, 1),
('Maintain Users', 'wiki', 1184472000, 1),
('Samba', 'wiki', 1184472000, 1),
('HomePage', 'wiki', 1184558400, 4),
('Quotes', 'wiki', 1184558400, 2),
('Linux', 'wiki', 1184558400, 1),
('PERL_Code', 'wiki', 1184558400, 2),
('Adobe Premier', 'wiki', 1184558400, 1),
('WebSphere', 'wiki', 1184558400, 1),
('PHP', 'wiki', 1184558400, 1),
('Subversion', 'wiki', 1184558400, 1),
('Networking', 'wiki', 1184558400, 1),
('Searching', 'wiki', 1184558400, 1),
('Running Processes', 'wiki', 1184558400, 1),
('File System', 'wiki', 1184558400, 1),
('System', 'wiki', 1184558400, 1),
('Maintain Users', 'wiki', 1184558400, 2),
('Samba', 'wiki', 1184558400, 1),
('Scripting', 'wiki', 1184558400, 1),
('HomePage', 'wiki', 1184644800, 3),
('HomePage', 'wiki', 1184731200, 1),
('HomePage', 'wiki', 1184817600, 2),
('Linux', 'wiki', 1184817600, 1),
('System', 'wiki', 1184817600, 1),
('PERL_Code', 'wiki', 1184904000, 2),
('HomePage', 'wiki', 1184904000, 1),
('HomePage', 'wiki', 1184990400, 7),
('Linux', 'wiki', 1184990400, 4),
('System', 'wiki', 1184990400, 2),
('PERL_Code', 'wiki', 1184990400, 2),
('Adobe Premier', 'wiki', 1184990400, 1),
('PHP', 'wiki', 1184990400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1184990400, 1),
('HomePage', 'wiki', 1185076800, 3),
('Linux', 'wiki', 1185076800, 3),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1185076800, 1),
('HomePage', 'wiki', 1185163200, 4),
('Samba', 'wiki', 1185163200, 1),
('Linux', 'wiki', 1185163200, 1),
('System', 'wiki', 1185163200, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1185163200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1185163200, 1),
('HomePage', 'wiki', 1185249600, 1),
('Linux', 'wiki', 1185249600, 1),
('Networking', 'wiki', 1185249600, 1),
('HomePage', 'wiki', 1185336000, 3),
('Linux', 'wiki', 1185336000, 2),
('Samba', 'wiki', 1185336000, 1),
('HomePage', 'wiki', 1185422400, 2),
('WebSphere', 'wiki', 1185422400, 1),
('HomePage', 'wiki', 1185508800, 3),
('Linux', 'wiki', 1185508800, 1),
('Networking', 'wiki', 1185508800, 1),
('Maintain Users', 'wiki', 1185508800, 1),
('HomePage', 'wiki', 1185595200, 9),
('Linux', 'wiki', 1185595200, 5),
('Samba', 'wiki', 1185595200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1185595200, 2),
('Networking', 'wiki', 1185595200, 1),
('PERL_Code', 'wiki', 1185595200, 1),
('HomePage', 'wiki', 1185681600, 3),
('Samba', 'wiki', 1185681600, 2),
('Linux', 'wiki', 1185681600, 3),
('System', 'wiki', 1185681600, 1),
('File System', 'wiki', 1185681600, 3),
('HomePage', 'wiki', 1185768000, 2),
('Linux', 'wiki', 1185768000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1185768000, 1),
('HomePage', 'wiki', 1185854400, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1185854400, 1),
('HomePage', 'wiki', 1185940800, 1),
('HomePage', 'wiki', 1186027200, 3),
('HomePage', 'wiki', 1186113600, 2),
('PERL_Code', 'wiki', 1186286400, 1),
('Maintain Users', 'wiki', 1186286400, 1),
('HomePage', 'wiki', 1186286400, 2),
('HomePage', 'wiki', 1186372800, 2),
('Adobe Premier', 'wiki', 1186372800, 1),
('Quotes', 'wiki', 1186372800, 1),
('HomePage', 'wiki', 1186459200, 2),
('HomePage', 'wiki', 1186545600, 5),
('Linux', 'wiki', 1186545600, 2),
('Scripting', 'wiki', 1186545600, 1),
('Maintain Users', 'wiki', 1186545600, 1),
('System', 'wiki', 1186545600, 1),
('Subversion', 'wiki', 1186545600, 2),
('PHP', 'wiki', 1186545600, 2),
('WebSphere', 'wiki', 1186545600, 1),
('Running Processes', 'wiki', 1186545600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1186545600, 2),
('PERL_Code', 'wiki', 1186632000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1186632000, 3),
('HomePage', 'wiki', 1186632000, 10),
('Linux', 'wiki', 1186632000, 10),
('Samba', 'wiki', 1186632000, 2),
('Searching', 'wiki', 1186632000, 2),
('Networking', 'wiki', 1186632000, 1),
('Subversion', 'wiki', 1186632000, 8),
('Ubuntu', 'wiki', 1186632000, 2),
('Scripting', 'wiki', 1186632000, 1),
('HomePage', 'wiki', 1186718400, 7),
('Searching', 'wiki', 1186718400, 1),
('Subversion', 'wiki', 1186718400, 2),
('Linux', 'wiki', 1186718400, 8),
('System', 'wiki', 1186718400, 3),
('File System', 'wiki', 1186718400, 3),
('PHP', 'wiki', 1186718400, 1),
('WebSphere', 'wiki', 1186718400, 1),
('PERL_Code', 'wiki', 1186718400, 1),
('Ubuntu', 'wiki', 1186718400, 1),
('HomePage', 'wiki', 1186804800, 9),
('Linux', 'wiki', 1186804800, 1),
('Networking', 'wiki', 1186804800, 3),
('HomePage', 'wiki', 1186891200, 7),
('Linux', 'wiki', 1186891200, 3),
('System', 'wiki', 1186891200, 2),
('File System', 'wiki', 1186891200, 3),
('Adobe Premier', 'wiki', 1186891200, 1),
('PHP', 'wiki', 1186891200, 1),
('Subversion', 'wiki', 1186891200, 1),
('Searching', 'wiki', 1186891200, 1),
('Networking', 'wiki', 1186891200, 1),
('Running Processes', 'wiki', 1186891200, 1),
('Quotes', 'wiki', 1186891200, 1),
('PERL_Code', 'wiki', 1186891200, 1),
('Maintain Users', 'wiki', 1186891200, 1),
('Ubuntu', 'wiki', 1186891200, 1),
('Samba', 'wiki', 1186891200, 1),
('Scripting', 'wiki', 1186891200, 1),
('WebSphere', 'wiki', 1186891200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1186891200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1186891200, 1),
('HomePage', 'wiki', 1186977600, 9),
('Ubuntu', 'wiki', 1186977600, 2),
('PERL_Code', 'wiki', 1186977600, 2),
('Adobe Premier', 'wiki', 1186977600, 1),
('PHP', 'wiki', 1186977600, 1),
('Subversion', 'wiki', 1186977600, 1),
('Searching', 'wiki', 1186977600, 1),
('Networking', 'wiki', 1186977600, 1),
('Quotes', 'wiki', 1186977600, 1),
('WebSphere', 'wiki', 1186977600, 1),
('Linux', 'wiki', 1186977600, 1),
('Running Processes', 'wiki', 1186977600, 1),
('Maintain Users', 'wiki', 1186977600, 1),
('Samba', 'wiki', 1186977600, 1),
('Scripting', 'wiki', 1186977600, 1),
('File System', 'wiki', 1186977600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1186977600, 1),
('System', 'wiki', 1186977600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1186977600, 1),
('PERL_Code', 'wiki', 1187064000, 2),
('HomePage', 'wiki', 1187064000, 2),
('Linux', 'wiki', 1187064000, 1),
('WebSphere', 'wiki', 1187064000, 1),
('HomePage', 'wiki', 1187150400, 4),
('PHP', 'wiki', 1187150400, 1),
('Quotes', 'wiki', 1187150400, 1),
('HomePage', 'wiki', 1187236800, 5),
('PERL_Code', 'wiki', 1187236800, 1),
('Adobe Premier', 'wiki', 1187236800, 1),
('File System', 'wiki', 1187236800, 1),
('HomePage', 'wiki', 1187323200, 1),
('HomePage', 'wiki', 1187409600, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1187409600, 1),
('HomePage', 'wiki', 1187496000, 4),
('Subversion', 'wiki', 1187496000, 1),
('PHP', 'wiki', 1187496000, 1),
('Linux', 'wiki', 1187496000, 1),
('WebSphere', 'wiki', 1187496000, 1),
('PERL_Code', 'wiki', 1187496000, 2),
('Quotes', 'wiki', 1187582400, 1),
('HomePage', 'wiki', 1187582400, 2),
('WebSphere', 'wiki', 1187582400, 1),
('PHP', 'wiki', 1187668800, 1),
('HomePage', 'wiki', 1187668800, 2),
('Subversion', 'wiki', 1187668800, 1),
('WebSphere', 'wiki', 1187755200, 1),
('HomePage', 'wiki', 1187755200, 1),
('PERL_Code', 'wiki', 1187841600, 1),
('Quotes', 'wiki', 1187841600, 1),
('Adobe Premier', 'wiki', 1187841600, 1),
('HomePage', 'wiki', 1187841600, 3),
('HomePage', 'wiki', 1187928000, 14),
('PERL_Code', 'wiki', 1187928000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1187928000, 1),
('Linux', 'wiki', 1187928000, 1),
('Subversion', 'wiki', 1187928000, 1),
('PHP', 'wiki', 1187928000, 1),
('WebSphere', 'wiki', 1187928000, 1),
('HomePage', 'wiki', 1188187200, 14),
('Quotes', 'wiki', 1188187200, 1),
('Linux', 'wiki', 1188187200, 7),
('Subversion', 'wiki', 1188187200, 1),
('PHP', 'wiki', 1188187200, 1),
('WebSphere', 'wiki', 1188187200, 1),
('System', 'wiki', 1188187200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1188187200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1188187200, 1),
('Running Processes', 'wiki', 1188187200, 1),
('PERL_Code', 'wiki', 1188187200, 1),
('HomePage', 'wiki', 1188273600, 1),
('Linux', 'wiki', 1188273600, 2),
('File System', 'wiki', 1188273600, 2),
('Samba', 'wiki', 1188273600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1188360000, 1),
('HomePage', 'wiki', 1188446400, 3),
('HomePage', 'wiki', 1188532800, 2),
('Subversion', 'wiki', 1188532800, 1),
('PERL_Code', 'wiki', 1188532800, 1),
('HomePage', 'wiki', 1188619200, 2),
('HomePage', 'wiki', 1188705600, 1),
('HomePage', 'wiki', 1188792000, 3),
('Adobe Premier', 'wiki', 1188792000, 2),
('PERL_Code', 'wiki', 1188792000, 1),
('PHP', 'wiki', 1188792000, 1),
('Subversion', 'wiki', 1188792000, 1),
('Quotes', 'wiki', 1188792000, 1),
('HomePage', 'wiki', 1188878400, 1),
('HomePage', 'wiki', 1188964800, 11),
('Linux', 'wiki', 1188964800, 5),
('Subversion', 'wiki', 1188964800, 1),
('PHP', 'wiki', 1188964800, 2),
('WebSphere', 'wiki', 1188964800, 3),
('PERL_Code', 'wiki', 1188964800, 2),
('Adobe Premier', 'wiki', 1188964800, 3),
('Quotes', 'wiki', 1188964800, 2),
('Searching', 'wiki', 1188964800, 2),
('System', 'wiki', 1188964800, 1),
('File System', 'wiki', 1188964800, 1),
('HomePage', 'wiki', 1189051200, 3),
('HomePage', 'wiki', 1189137600, 1),
('PERL_Code', 'wiki', 1189137600, 1),
('Linux', 'wiki', 1189224000, 1),
('HomePage', 'wiki', 1189224000, 2),
('PHP', 'wiki', 1189224000, 1),
('HomePage', 'wiki', 1189310400, 1),
('Subversion', 'wiki', 1189310400, 1),
('HomePage', 'wiki', 1189396800, 5),
('Quotes', 'wiki', 1189396800, 1),
('PERL_Code', 'wiki', 1189396800, 2),
('Linux', 'wiki', 1189396800, 4),
('Networking', 'wiki', 1189396800, 1),
('Scripting', 'wiki', 1189396800, 1),
('Searching', 'wiki', 1189396800, 1),
('WebSphere', 'wiki', 1189483200, 1),
('HomePage', 'wiki', 1189483200, 3),
('PERL_Code', 'wiki', 1189483200, 1),
('Linux', 'wiki', 1189483200, 1),
('Searching', 'wiki', 1189483200, 1),
('HomePage', 'wiki', 1189569600, 3),
('Adobe Premier', 'wiki', 1189569600, 2),
('PHP', 'wiki', 1189569600, 1),
('Subversion', 'wiki', 1189569600, 1),
('Networking', 'wiki', 1189569600, 1),
('Quotes', 'wiki', 1189569600, 1),
('PERL_Code', 'wiki', 1189569600, 1),
('WebSphere', 'wiki', 1189569600, 1),
('Linux', 'wiki', 1189569600, 1),
('Searching', 'wiki', 1189569600, 1),
('Running Processes', 'wiki', 1189569600, 1),
('Maintain Users', 'wiki', 1189569600, 1),
('Ubuntu', 'wiki', 1189569600, 1),
('Samba', 'wiki', 1189569600, 1),
('Scripting', 'wiki', 1189569600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1189569600, 1),
('System', 'wiki', 1189569600, 1),
('File System', 'wiki', 1189569600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1189569600, 1),
('HomePage', 'wiki', 1189656000, 12),
('Linux', 'wiki', 1189656000, 5),
('Subversion', 'wiki', 1189656000, 1),
('PHP', 'wiki', 1189656000, 2),
('WebSphere', 'wiki', 1189656000, 1),
('PERL_Code', 'wiki', 1189656000, 1),
('Adobe Premier', 'wiki', 1189656000, 3),
('File System', 'wiki', 1189656000, 2),
('System', 'wiki', 1189656000, 1),
('Networking', 'wiki', 1189656000, 1),
('Running Processes', 'wiki', 1189656000, 1),
('Ubuntu', 'wiki', 1189656000, 1),
('HomePage', 'wiki', 1189742400, 4),
('Adobe Premier', 'wiki', 1189742400, 2),
('PERL_Code', 'wiki', 1189742400, 2),
('PHP', 'wiki', 1189742400, 1),
('Quotes', 'wiki', 1189742400, 1),
('Networking', 'wiki', 1189742400, 1),
('Linux', 'wiki', 1189742400, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1189742400, 1),
('Subversion', 'wiki', 1189742400, 1),
('Searching', 'wiki', 1189742400, 1),
('Running Processes', 'wiki', 1189742400, 1),
('Maintain Users', 'wiki', 1189742400, 1),
('Ubuntu', 'wiki', 1189742400, 1),
('Samba', 'wiki', 1189742400, 1),
('File System', 'wiki', 1189742400, 2),
('Scripting', 'wiki', 1189742400, 1),
('WebSphere', 'wiki', 1189742400, 1),
('System', 'wiki', 1189742400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1189742400, 1),
('HomePage', 'wiki', 1189828800, 2),
('Linux', 'wiki', 1189828800, 1),
('Adobe Premier', 'wiki', 1189828800, 1),
('PHP', 'wiki', 1189828800, 1),
('HomePage', 'wiki', 1189915200, 3),
('PERL_Code', 'wiki', 1189915200, 1),
('Linux', 'wiki', 1189915200, 2),
('Scripting', 'wiki', 1189915200, 1),
('Searching', 'wiki', 1189915200, 1),
('Quotes', 'wiki', 1190001600, 2),
('Subversion', 'wiki', 1190001600, 1),
('HomePage', 'wiki', 1190001600, 5),
('Searching', 'wiki', 1190001600, 1),
('Maintain Users', 'wiki', 1190001600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1190001600, 1),
('HomePage', 'wiki', 1190088000, 1),
('WebSphere', 'wiki', 1190088000, 1),
('Ubuntu', 'wiki', 1190088000, 2),
('PERL_Code', 'wiki', 1190088000, 1),
('HomePage', 'wiki', 1190174400, 1),
('WebSphere', 'wiki', 1190260800, 1),
('HomePage', 'wiki', 1190260800, 4),
('Searching', 'wiki', 1190260800, 3),
('HomePage', 'wiki', 1190347200, 1),
('PERL_Code', 'wiki', 1190433600, 1),
('Linux', 'wiki', 1190433600, 1),
('HomePage', 'wiki', 1190433600, 1),
('PHP', 'wiki', 1190520000, 1),
('HomePage', 'wiki', 1190520000, 7),
('PERL_Code', 'wiki', 1190520000, 1),
('HomePage', 'wiki', 1190606400, 4),
('WebSphere', 'wiki', 1190606400, 1),
('Linux', 'wiki', 1190606400, 1),
('Ubuntu', 'wiki', 1190606400, 1),
('Samba', 'wiki', 1190606400, 1),
('PHP', 'wiki', 1190606400, 1),
('Maintain Users', 'wiki', 1190606400, 1),
('Scripting', 'wiki', 1190606400, 1),
('Subversion', 'wiki', 1190606400, 2),
('Searching', 'wiki', 1190606400, 1),
('Running Processes', 'wiki', 1190606400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1190606400, 1),
('Networking', 'wiki', 1190606400, 1),
('Adobe Premier', 'wiki', 1190606400, 2),
('Quotes', 'wiki', 1190606400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1190606400, 1),
('System', 'wiki', 1190606400, 1),
('PERL_Code', 'wiki', 1190606400, 1),
('File System', 'wiki', 1190606400, 2),
('Linux', 'wiki', 1190692800, 1),
('HomePage', 'wiki', 1190692800, 2),
('WebSphere', 'wiki', 1190692800, 1),
('Subversion', 'wiki', 1190692800, 1),
('HomePage', 'wiki', 1190779200, 2),
('Linux', 'wiki', 1190779200, 2),
('System', 'wiki', 1190779200, 1),
('File System', 'wiki', 1190779200, 1),
('Maintain Users', 'wiki', 1190779200, 1),
('Networking', 'wiki', 1190865600, 1),
('Searching', 'wiki', 1190865600, 1),
('HomePage', 'wiki', 1190865600, 1),
('PERL_Code', 'wiki', 1190865600, 1),
('Quotes', 'wiki', 1190865600, 1),
('HomePage', 'wiki', 1190952000, 1),
('HomePage', 'wiki', 1191038400, 2),
('PERL_Code', 'wiki', 1191038400, 1),
('HomePage', 'wiki', 1191124800, 3),
('HomePage', 'wiki', 1191211200, 3),
('Subversion', 'wiki', 1191211200, 1),
('Subversion', 'wiki', 1191297600, 1),
('Maintain Users', 'wiki', 1191297600, 1),
('HomePage', 'wiki', 1191297600, 1),
('Subversion', 'wiki', 1191384000, 4),
('HomePage', 'wiki', 1191384000, 6),
('WebSphere', 'wiki', 1191384000, 2),
('Linux', 'wiki', 1191384000, 2),
('Ubuntu', 'wiki', 1191384000, 2),
('PHP', 'wiki', 1191384000, 3),
('Samba', 'wiki', 1191384000, 2),
('Scripting', 'wiki', 1191384000, 2),
('Searching', 'wiki', 1191384000, 2),
('Running Processes', 'wiki', 1191384000, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1191384000, 2),
('Networking', 'wiki', 1191384000, 2),
('Adobe Premier', 'wiki', 1191384000, 4),
('PERL_Code', 'wiki', 1191384000, 2),
('Maintain Users', 'wiki', 1191384000, 2),
('Quotes', 'wiki', 1191384000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1191384000, 2),
('System', 'wiki', 1191384000, 2),
('File System', 'wiki', 1191384000, 4),
('HomePage', 'wiki', 1191470400, 7),
('Quotes', 'wiki', 1191470400, 1),
('WebSphere', 'wiki', 1191470400, 2),
('Linux', 'wiki', 1191470400, 2),
('Ubuntu', 'wiki', 1191470400, 1),
('Samba', 'wiki', 1191470400, 1),
('Scripting', 'wiki', 1191470400, 1),
('Subversion', 'wiki', 1191470400, 1),
('Searching', 'wiki', 1191470400, 1),
('Running Processes', 'wiki', 1191470400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1191470400, 1),
('Networking', 'wiki', 1191470400, 1),
('Adobe Premier', 'wiki', 1191470400, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1191470400, 1),
('Maintain Users', 'wiki', 1191470400, 1),
('System', 'wiki', 1191470400, 1),
('PERL_Code', 'wiki', 1191470400, 1),
('PHP', 'wiki', 1191470400, 1),
('File System', 'wiki', 1191470400, 5),
('PERL_Code', 'wiki', 1191556800, 1),
('HomePage', 'wiki', 1191556800, 2),
('Subversion', 'wiki', 1191556800, 1),
('PHP', 'wiki', 1191556800, 1),
('HomePage', 'wiki', 1191729600, 7),
('Linux', 'wiki', 1191729600, 1),
('File System', 'wiki', 1191729600, 2),
('HomePage', 'wiki', 1191816000, 4),
('WebSphere', 'wiki', 1191816000, 1),
('HomePage', 'wiki', 1191902400, 5),
('Linux', 'wiki', 1191902400, 2),
('Subversion', 'wiki', 1191902400, 1),
('PHP', 'wiki', 1191902400, 1),
('WebSphere', 'wiki', 1191902400, 1),
('PERL_Code', 'wiki', 1191902400, 2),
('Adobe Premier', 'wiki', 1191902400, 1),
('Quotes', 'wiki', 1191902400, 1),
('File System', 'wiki', 1191902400, 2),
('File System', 'wiki', 1191988800, 1),
('HomePage', 'wiki', 1192075200, 4),
('Linux', 'wiki', 1192075200, 2),
('Networking', 'wiki', 1192075200, 6),
('File System', 'wiki', 1192075200, 2),
('WebSphere', 'wiki', 1192075200, 1),
('Adobe Premier', 'wiki', 1192075200, 1),
('Subversion', 'wiki', 1192075200, 1),
('Linux', 'wiki', 1192161600, 4),
('HomePage', 'wiki', 1192161600, 9),
('Adobe Premier', 'wiki', 1192161600, 4),
('Networking', 'wiki', 1192161600, 3),
('PHP', 'wiki', 1192161600, 2),
('Subversion', 'wiki', 1192161600, 3),
('File System', 'wiki', 1192161600, 6),
('Searching', 'wiki', 1192161600, 2),
('Running Processes', 'wiki', 1192161600, 2),
('System', 'wiki', 1192161600, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1192161600, 2),
('Quotes', 'wiki', 1192161600, 2),
('PERL_Code', 'wiki', 1192161600, 3),
('WebSphere', 'wiki', 1192161600, 2),
('Maintain Users', 'wiki', 1192161600, 2),
('Ubuntu', 'wiki', 1192161600, 2),
('Samba', 'wiki', 1192161600, 2),
('Scripting', 'wiki', 1192161600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1192161600, 2),
('HomePage', 'wiki', 1192248000, 3),
('Subversion', 'wiki', 1192248000, 1),
('Linux', 'wiki', 1192248000, 4),
('Scripting', 'wiki', 1192248000, 1),
('File System', 'wiki', 1192248000, 1),
('Searching', 'wiki', 1192248000, 2),
('PHP', 'wiki', 1192334400, 1),
('HomePage', 'wiki', 1192334400, 5),
('Adobe Premier', 'wiki', 1192334400, 1),
('Networking', 'wiki', 1192334400, 1),
('Linux', 'wiki', 1192334400, 1),
('File System', 'wiki', 1192420800, 3),
('Adobe Premier', 'wiki', 1192420800, 2),
('HomePage', 'wiki', 1192420800, 9),
('Quotes', 'wiki', 1192420800, 1),
('PERL_Code', 'wiki', 1192420800, 1),
('WebSphere', 'wiki', 1192420800, 1),
('PHP', 'wiki', 1192420800, 1),
('Subversion', 'wiki', 1192420800, 1),
('Linux', 'wiki', 1192420800, 1),
('WebSphere', 'wiki', 1192507200, 1),
('HomePage', 'wiki', 1192680000, 4),
('Quotes', 'wiki', 1192680000, 2),
('WebSphere', 'wiki', 1192680000, 1),
('HomePage', 'wiki', 1192766400, 7),
('Linux', 'wiki', 1192766400, 3),
('PERL_Code', 'wiki', 1192766400, 1),
('Quotes', 'wiki', 1192766400, 2),
('WebSphere', 'wiki', 1192766400, 2),
('PHP', 'wiki', 1192766400, 1),
('Subversion', 'wiki', 1192766400, 1),
('Adobe Premier', 'wiki', 1192766400, 1),
('PERL_Code', 'wiki', 1192852800, 1),
('Networking', 'wiki', 1192852800, 1),
('PERL_Code', 'wiki', 1192939200, 1),
('HomePage', 'wiki', 1192939200, 1),
('Subversion', 'wiki', 1192939200, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1192939200, 1),
('Ubuntu', 'wiki', 1193025600, 1),
('PHP', 'wiki', 1193025600, 1),
('HomePage', 'wiki', 1193025600, 4),
('HomePage', 'wiki', 1193112000, 3),
('PERL_Code', 'wiki', 1193112000, 1),
('PHP', 'wiki', 1193198400, 1),
('HomePage', 'wiki', 1193198400, 2),
('Linux', 'wiki', 1193198400, 1),
('Searching', 'wiki', 1193198400, 1),
('Linux', 'wiki', 1193284800, 2),
('HomePage', 'wiki', 1193284800, 2),
('Searching', 'wiki', 1193284800, 1),
('Quotes', 'wiki', 1193371200, 1),
('Searching', 'wiki', 1193371200, 1),
('HomePage', 'wiki', 1193371200, 3),
('Linux', 'wiki', 1193371200, 2),
('System', 'wiki', 1193371200, 3),
('WebSphere', 'wiki', 1193371200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1193371200, 1),
('System', 'wiki', 1193457600, 1),
('HomePage', 'wiki', 1193457600, 2),
('Linux', 'wiki', 1193457600, 2),
('File System', 'wiki', 1193457600, 2),
('PERL_Code', 'wiki', 1193457600, 1),
('Quotes', 'wiki', 1193457600, 1),
('Searching', 'wiki', 1193457600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1193457600, 1),
('HomePage', 'wiki', 1193544000, 3),
('Subversion', 'wiki', 1193544000, 2),
('File System', 'wiki', 1193544000, 1),
('Ubuntu', 'wiki', 1193544000, 1),
('HomePage', 'wiki', 1193630400, 11),
('Linux', 'wiki', 1193630400, 8),
('Searching', 'wiki', 1193630400, 9),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1193630400, 6),
('Scripting', 'wiki', 1193630400, 1),
('System', 'wiki', 1193630400, 1),
('PERL_Code', 'wiki', 1193630400, 1),
('PHP', 'wiki', 1193630400, 1),
('PHP', 'wiki', 1193716800, 1),
('Linux', 'wiki', 1193716800, 3),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1193716800, 6),
('HomePage', 'wiki', 1193716800, 3),
('PERL_Code', 'wiki', 1193716800, 2),
('Running Processes', 'wiki', 1193716800, 2),
('Networking', 'wiki', 1193716800, 1),
('HomePage', 'wiki', 1193803200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1193803200, 6),
('HomePage', 'wiki', 1193889600, 2),
('Linux', 'wiki', 1193889600, 2),
('File System', 'wiki', 1193889600, 2),
('HomePage', 'wiki', 1193976000, 2),
('File System', 'wiki', 1193976000, 1),
('Ubuntu', 'wiki', 1193976000, 1),
('HomePage', 'wiki', 1194148800, 2),
('Adobe Premier', 'wiki', 1194238800, 1),
('HomePage', 'wiki', 1194238800, 2),
('File System', 'wiki', 1194238800, 1),
('Ubuntu', 'wiki', 1194238800, 1),
('Linux', 'wiki', 1194325200, 4),
('File System', 'wiki', 1194325200, 2),
('System', 'wiki', 1194325200, 1),
('HomePage', 'wiki', 1194325200, 3),
('Subversion', 'wiki', 1194325200, 1),
('PHP', 'wiki', 1194325200, 1),
('WebSphere', 'wiki', 1194325200, 1),
('PERL_Code', 'wiki', 1194325200, 1),
('Adobe Premier', 'wiki', 1194325200, 1),
('Quotes', 'wiki', 1194325200, 1),
('HomePage', 'wiki', 1194411600, 2),
('File System', 'wiki', 1194411600, 1),
('HomePage', 'wiki', 1194584400, 1),
('Linux', 'wiki', 1194670800, 5),
('File System', 'wiki', 1194670800, 2),
('Samba', 'wiki', 1194670800, 1),
('HomePage', 'wiki', 1194670800, 2),
('Adobe Premier', 'wiki', 1194670800, 1),
('System', 'wiki', 1194670800, 3),
('System', 'wiki', 1194757200, 3),
('HomePage', 'wiki', 1194757200, 5),
('Linux', 'wiki', 1194757200, 2),
('File System', 'wiki', 1194757200, 3),
('Adobe Premier', 'wiki', 1194757200, 2),
('PHP', 'wiki', 1194757200, 1),
('Searching', 'wiki', 1194757200, 1),
('Subversion', 'wiki', 1194757200, 1),
('Running Processes', 'wiki', 1194757200, 1),
('Networking', 'wiki', 1194757200, 1),
('Quotes', 'wiki', 1194757200, 1),
('PERL_Code', 'wiki', 1194757200, 2),
('Maintain Users', 'wiki', 1194757200, 1),
('Ubuntu', 'wiki', 1194757200, 2),
('Samba', 'wiki', 1194757200, 1),
('Scripting', 'wiki', 1194757200, 1),
('WebSphere', 'wiki', 1194757200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1194757200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1194757200, 1),
('HomePage', 'wiki', 1194843600, 3),
('File System', 'wiki', 1194843600, 1),
('HomePage', 'wiki', 1194930000, 1),
('Linux', 'wiki', 1194930000, 1),
('Maintain Users', 'wiki', 1194930000, 1),
('File System', 'wiki', 1194930000, 1),
('Adobe Premier', 'wiki', 1194930000, 1),
('File System', 'wiki', 1195102800, 3),
('PHP', 'wiki', 1195102800, 2),
('Quotes', 'wiki', 1195102800, 2),
('Adobe Premier', 'wiki', 1195102800, 2),
('HomePage', 'wiki', 1195102800, 1),
('Linux', 'wiki', 1195102800, 2),
('HomePage', 'wiki', 1195189200, 1),
('WebSphere', 'wiki', 1195189200, 1),
('System', 'wiki', 1195189200, 1),
('Linux', 'wiki', 1195189200, 4),
('Networking', 'wiki', 1195189200, 1),
('File System', 'wiki', 1195189200, 2),
('Samba', 'wiki', 1195189200, 1),
('WebSphere', 'wiki', 1195275600, 1),
('Adobe Premier', 'wiki', 1195275600, 1),
('File System', 'wiki', 1195275600, 1),
('HomePage', 'wiki', 1195275600, 3),
('Adobe Photoshop', 'wiki', 1195275600, 2),
('Networking', 'wiki', 1195275600, 1),
('Searching', 'wiki', 1195275600, 1),
('HomePage', 'wiki', 1195362000, 5),
('HomePage', 'wiki', 1195448400, 2),
('Linux', 'wiki', 1195448400, 1),
('Searching', 'wiki', 1195448400, 1),
('HomePage', 'wiki', 1195534800, 1),
('Adobe Premier', 'wiki', 1195621200, 1),
('Adobe Photoshop', 'wiki', 1195621200, 1),
('HomePage', 'wiki', 1195621200, 1),
('HomePage', 'wiki', 1195707600, 1),
('PERL_Code', 'wiki', 1195707600, 1),
('Ubuntu', 'wiki', 1195707600, 1),
('HomePage', 'wiki', 1195794000, 2),
('HomePage', 'wiki', 1195880400, 2),
('Adobe Photoshop', 'wiki', 1195880400, 3),
('Quotes', 'wiki', 1195966800, 2),
('HomePage', 'wiki', 1195966800, 7),
('PHP', 'wiki', 1195966800, 1),
('Linux', 'wiki', 1195966800, 1),
('WebSphere', 'wiki', 1195966800, 1),
('HomePage', 'wiki', 1196053200, 3),
('PERL_Code', 'wiki', 1196053200, 1),
('Running Processes', 'wiki', 1196053200, 1),
('Samba', 'wiki', 1196053200, 1),
('Linux', 'wiki', 1196053200, 1),
('HomePage', 'wiki', 1196139600, 2),
('Adobe Photoshop', 'wiki', 1196139600, 4),
('PHP', 'wiki', 1196139600, 1),
('File System', 'wiki', 1196139600, 1),
('Quotes', 'wiki', 1196139600, 1),
('Searching', 'wiki', 1196139600, 1),
('Subversion', 'wiki', 1196139600, 1),
('Running Processes', 'wiki', 1196139600, 1),
('Samba', 'wiki', 1196139600, 1),
('Ubuntu', 'wiki', 1196226000, 1),
('Adobe Premier', 'wiki', 1196226000, 1),
('Quotes', 'wiki', 1196226000, 1),
('Subversion', 'wiki', 1196226000, 2),
('HomePage', 'wiki', 1196226000, 2),
('WebSphere', 'wiki', 1196226000, 1),
('Networking', 'wiki', 1196312400, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1196312400, 1),
('PHP', 'wiki', 1196312400, 1),
('HomePage', 'wiki', 1196398800, 1),
('HomePage', 'wiki', 1196485200, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1196485200, 1),
('Adobe Photoshop', 'wiki', 1196485200, 1),
('Adobe Premier', 'wiki', 1196571600, 1),
('HomePage', 'wiki', 1196571600, 4),
('Adobe Photoshop', 'wiki', 1196571600, 1),
('Linux', 'wiki', 1196571600, 1),
('File System', 'wiki', 1196571600, 2),
('WebSphere', 'wiki', 1196571600, 1),
('PERL_Code', 'wiki', 1196571600, 1),
('PERL_Code', 'wiki', 1196658000, 2),
('WebSphere', 'wiki', 1196658000, 1),
('Networking', 'wiki', 1196658000, 2),
('HomePage', 'wiki', 1196658000, 3),
('Quotes', 'wiki', 1196658000, 2),
('File System', 'wiki', 1196658000, 1),
('Adobe Premier', 'wiki', 1196744400, 1),
('HomePage', 'wiki', 1196744400, 2),
('Linux', 'wiki', 1196744400, 1),
('File System', 'wiki', 1196744400, 1),
('PERL_Code', 'wiki', 1196830800, 1),
('HomePage', 'wiki', 1196830800, 1),
('Adobe Photoshop', 'wiki', 1196830800, 1),
('HomePage', 'wiki', 1196917200, 4),
('File System', 'wiki', 1196917200, 2),
('Adobe Premier', 'wiki', 1196917200, 1),
('File System', 'wiki', 1197003600, 2),
('HomePage', 'wiki', 1197003600, 1),
('Ubuntu', 'wiki', 1197003600, 1),
('Networking', 'wiki', 1197090000, 1),
('HomePage', 'wiki', 1197090000, 3),
('Linux', 'wiki', 1197090000, 1),
('HomePage', 'wiki', 1197176400, 1),
('PHP', 'wiki', 1197176400, 1),
('Subversion', 'wiki', 1197176400, 1),
('PHP', 'wiki', 1197262800, 1),
('HomePage', 'wiki', 1197262800, 2),
('Linux', 'wiki', 1197262800, 1),
('File System', 'wiki', 1197262800, 1),
('HomePage', 'wiki', 1197349200, 2),
('Adobe Premier', 'wiki', 1197349200, 2),
('Running Processes', 'wiki', 1197349200, 1),
('Samba', 'wiki', 1197349200, 1),
('Networking', 'wiki', 1197435600, 1),
('Quotes', 'wiki', 1197435600, 1),
('File System', 'wiki', 1197435600, 1),
('HomePage', 'wiki', 1197435600, 1),
('Running Processes', 'wiki', 1197522000, 4),
('HomePage', 'wiki', 1197522000, 8),
('Linux', 'wiki', 1197522000, 3),
('Subversion', 'wiki', 1197522000, 3),
('PHP', 'wiki', 1197522000, 3),
('WebSphere', 'wiki', 1197522000, 3),
('PERL_Code', 'wiki', 1197522000, 3),
('Adobe Premier', 'wiki', 1197522000, 5),
('Adobe Photoshop', 'wiki', 1197522000, 3),
('Samba', 'wiki', 1197522000, 3),
('File System', 'wiki', 1197522000, 5),
('Ubuntu', 'wiki', 1197522000, 2),
('Scripting', 'wiki', 1197522000, 2),
('System', 'wiki', 1197522000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1197522000, 2),
('Searching', 'wiki', 1197522000, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1197522000, 2),
('Networking', 'wiki', 1197522000, 2),
('Maintain Users', 'wiki', 1197522000, 2),
('Quotes', 'wiki', 1197522000, 2),
('HomePage', 'wiki', 1197608400, 2),
('Adobe Photoshop', 'wiki', 1197694800, 2),
('HomePage', 'wiki', 1197781200, 7),
('WebSphere', 'wiki', 1197781200, 1),
('PHP', 'wiki', 1197781200, 1),
('Adobe Photoshop', 'wiki', 1197781200, 1),
('Subversion', 'wiki', 1197781200, 1),
('PERL_Code', 'wiki', 1197781200, 1),
('HomePage', 'wiki', 1197867600, 2),
('PERL_Code', 'wiki', 1197867600, 1),
('Searching', 'wiki', 1197867600, 1),
('Networking', 'wiki', 1197867600, 1),
('WebSphere', 'wiki', 1197954000, 1),
('HomePage', 'wiki', 1197954000, 4),
('Adobe Premier', 'wiki', 1197954000, 2),
('Adobe Photoshop', 'wiki', 1197954000, 1),
('Ubuntu', 'wiki', 1197954000, 1),
('Linux', 'wiki', 1197954000, 1),
('Samba', 'wiki', 1197954000, 1),
('Searching', 'wiki', 1198040400, 1),
('HomePage', 'wiki', 1198040400, 2),
('WebSphere', 'wiki', 1198040400, 1),
('HomePage', 'wiki', 1198213200, 2),
('Networking', 'wiki', 1198299600, 1),
('HomePage', 'wiki', 1198299600, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1198299600, 1),
('File System', 'wiki', 1198386000, 1),
('HomePage', 'wiki', 1198386000, 8),
('Adobe Photoshop', 'wiki', 1198386000, 1),
('HomePage', 'wiki', 1198472400, 8),
('PHP', 'wiki', 1198472400, 1),
('Subversion', 'wiki', 1198472400, 1),
('Adobe Premier', 'wiki', 1198472400, 1),
('Searching', 'wiki', 1198472400, 1),
('HomePage', 'wiki', 1198558800, 5),
('Adobe Premier', 'wiki', 1198558800, 1),
('Quotes', 'wiki', 1198558800, 1),
('HomePage', 'wiki', 1198645200, 2),
('Running Processes', 'wiki', 1198645200, 1),
('Samba', 'wiki', 1198645200, 1),
('PHP', 'wiki', 1198731600, 1),
('HomePage', 'wiki', 1198731600, 1),
('Running Processes', 'wiki', 1198818000, 1),
('Samba', 'wiki', 1198818000, 1),
('HomePage', 'wiki', 1198818000, 2),
('Linux', 'wiki', 1198818000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1198818000, 1),
('Searching', 'wiki', 1198818000, 1),
('Ubuntu', 'wiki', 1198818000, 1),
('Ubuntu', 'wiki', 1198904400, 1),
('HomePage', 'wiki', 1198904400, 1),
('PHP', 'wiki', 1198904400, 1),
('Adobe Premier', 'wiki', 1198990800, 1),
('Quotes', 'wiki', 1198990800, 1),
('HomePage', 'wiki', 1198990800, 4),
('Subversion', 'wiki', 1198990800, 1),
('WebSphere', 'wiki', 1198990800, 1),
('File System', 'wiki', 1198990800, 1),
('HomePage', 'wiki', 1199077200, 7),
('Subversion', 'wiki', 1199077200, 1),
('Linux', 'wiki', 1199077200, 1),
('Samba', 'wiki', 1199077200, 1),
('Adobe Premier', 'wiki', 1199163600, 1),
('Ubuntu', 'wiki', 1199163600, 1),
('HomePage', 'wiki', 1199163600, 1),
('PHP', 'wiki', 1199163600, 1),
('HomePage', 'wiki', 1199250000, 1),
('Adobe Photoshop', 'wiki', 1199250000, 1),
('PERL_Code', 'wiki', 1199250000, 1),
('Linux', 'wiki', 1199250000, 1),
('Quotes', 'wiki', 1199250000, 1),
('WebSphere', 'wiki', 1199250000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1199336400, 2),
('HomePage', 'wiki', 1199336400, 3),
('Linux', 'wiki', 1199336400, 5),
('Send Email', 'wiki', 1199336400, 3),
('Running Processes', 'wiki', 1199336400, 7),
('WebSphere', 'wiki', 1199336400, 2),
('Adobe Photoshop', 'wiki', 1199336400, 1),
('PERL_Code', 'wiki', 1199336400, 1),
('Adobe Premier', 'wiki', 1199336400, 2),
('Quotes', 'wiki', 1199336400, 1),
('PHP', 'wiki', 1199336400, 1),
('Subversion', 'wiki', 1199336400, 1),
('Networking', 'wiki', 1199336400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1199336400, 1),
('Searching', 'wiki', 1199336400, 1),
('File System', 'wiki', 1199336400, 2),
('System', 'wiki', 1199336400, 1),
('Ubuntu', 'wiki', 1199336400, 1),
('Maintain Users', 'wiki', 1199336400, 1),
('Samba', 'wiki', 1199336400, 1),
('Scripting', 'wiki', 1199336400, 1),
('HomePage', 'wiki', 1199422800, 6),
('Linux', 'wiki', 1199422800, 4),
('File System', 'wiki', 1199422800, 5),
('Running Processes', 'wiki', 1199422800, 2),
('Send Email', 'wiki', 1199422800, 1),
('Subversion', 'wiki', 1199422800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1199422800, 1),
('File System', 'wiki', 1199509200, 2),
('HomePage', 'wiki', 1199509200, 2),
('Subversion', 'wiki', 1199509200, 3),
('PHP', 'wiki', 1199509200, 1),
('Linux', 'wiki', 1199509200, 1),
('Adobe Premier', 'wiki', 1199595600, 1),
('HomePage', 'wiki', 1199595600, 8),
('Searching', 'wiki', 1199595600, 1),
('Ubuntu', 'wiki', 1199595600, 1),
('WebSphere', 'wiki', 1199595600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1199595600, 1),
('Send Email', 'wiki', 1199682000, 1),
('WebSphere', 'wiki', 1199682000, 1),
('Searching', 'wiki', 1199682000, 1),
('HomePage', 'wiki', 1199682000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1199682000, 2),
('Subversion', 'wiki', 1199682000, 2),
('Linux', 'wiki', 1199682000, 1),
('Samba', 'wiki', 1199682000, 2),
('Quotes', 'wiki', 1199682000, 1),
('HomePage', 'wiki', 1199768400, 3),
('Subversion', 'wiki', 1199768400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1199768400, 1),
('Adobe Photoshop', 'wiki', 1199768400, 1),
('Adobe Premier', 'wiki', 1199768400, 1),
('Samba', 'wiki', 1199768400, 2),
('PHP', 'wiki', 1199768400, 1),
('HomePage', 'wiki', 1199854800, 3),
('PERL_Code', 'wiki', 1199854800, 1),
('Send Email', 'wiki', 1199854800, 1),
('Quotes', 'wiki', 1199854800, 1),
('Linux', 'wiki', 1199854800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1199941200, 1),
('HomePage', 'wiki', 1199941200, 1),
('HomePage', 'wiki', 1200027600, 6),
('WebSphere', 'wiki', 1200027600, 2),
('Linux', 'wiki', 1200027600, 3),
('Ubuntu', 'wiki', 1200027600, 2),
('Networking', 'wiki', 1200027600, 3),
('Subversion', 'wiki', 1200027600, 1),
('Adobe Premier', 'wiki', 1200027600, 2),
('PHP', 'wiki', 1200027600, 1),
('Searching', 'wiki', 1200027600, 2),
('Quotes', 'wiki', 1200027600, 1),
('PERL_Code', 'wiki', 1200027600, 1),
('Adobe Photoshop', 'wiki', 1200027600, 1),
('Running Processes', 'wiki', 1200027600, 1),
('Maintain Users', 'wiki', 1200027600, 1),
('File System', 'wiki', 1200027600, 3),
('Samba', 'wiki', 1200027600, 1),
('Scripting', 'wiki', 1200027600, 1),
('System', 'wiki', 1200027600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1200027600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1200027600, 4),
('Send Email', 'wiki', 1200027600, 1),
('HomePage', 'wiki', 1200114000, 4),
('Send Email', 'wiki', 1200114000, 1),
('PHP', 'wiki', 1200114000, 2),
('Linux', 'wiki', 1200114000, 1),
('Subversion', 'wiki', 1200114000, 1),
('WebSphere', 'wiki', 1200114000, 1),
('PERL_Code', 'wiki', 1200114000, 1),
('Adobe Premier', 'wiki', 1200114000, 1),
('Adobe Photoshop', 'wiki', 1200114000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1200114000, 1),
('HomePage', 'wiki', 1200200400, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1200200400, 1),
('Send Email', 'wiki', 1200200400, 1),
('Linux', 'wiki', 1200200400, 1),
('HomePage', 'wiki', 1200286800, 3),
('Adobe Premier', 'wiki', 1200286800, 1),
('PERL_Code', 'wiki', 1200286800, 1),
('Networking', 'wiki', 1200286800, 1),
('WebSphere', 'wiki', 1200286800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1200286800, 1),
('Linux', 'wiki', 1200286800, 1),
('Running Processes', 'wiki', 1200286800, 2),
('Subversion', 'wiki', 1200286800, 1),
('Subversion', 'wiki', 1200373200, 1),
('HomePage', 'wiki', 1200373200, 1),
('Adobe Photoshop', 'wiki', 1200373200, 1),
('PERL_Code', 'wiki', 1200373200, 1),
('PHP', 'wiki', 1200373200, 1),
('Adobe Photoshop', 'wiki', 1200459600, 1),
('HomePage', 'wiki', 1200459600, 6),
('Linux', 'wiki', 1200459600, 5),
('Networking', 'wiki', 1200459600, 1),
('File System', 'wiki', 1200459600, 1),
('Adobe Premier', 'wiki', 1200459600, 1),
('Send Email', 'wiki', 1200459600, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1200459600, 1),
('Searching', 'wiki', 1200459600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1200459600, 1),
('WebSphere', 'wiki', 1200546000, 1),
('Adobe Premier', 'wiki', 1200546000, 1),
('PERL_Code', 'wiki', 1200546000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1200546000, 1),
('PERL_Code', 'wiki', 1200632400, 1),
('Networking', 'wiki', 1200632400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1200718800, 2),
('Linux', 'wiki', 1200718800, 1),
('Searching', 'wiki', 1200718800, 1),
('HomePage', 'wiki', 1200718800, 2),
('Adobe Premier', 'wiki', 1200805200, 1),
('HomePage', 'wiki', 1200805200, 8),
('Treo 650 setup with Ubuntu', 'wiki', 1200805200, 1),
('Quotes', 'wiki', 1200891600, 1),
('PHP', 'wiki', 1200891600, 1),
('HomePage', 'wiki', 1200891600, 6),
('WebSphere', 'wiki', 1200891600, 1),
('Networking', 'wiki', 1200891600, 1),
('Adobe Premier', 'wiki', 1200891600, 2),
('Send Email', 'wiki', 1200891600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1200978000, 2),
('HomePage', 'wiki', 1200978000, 2),
('Linux', 'wiki', 1200978000, 5),
('Networking', 'wiki', 1200978000, 2),
('System', 'wiki', 1200978000, 1),
('Adobe Premier', 'wiki', 1200978000, 1),
('PHP', 'wiki', 1201064400, 1),
('Quotes', 'wiki', 1201064400, 1),
('Ubuntu', 'wiki', 1201064400, 1),
('HomePage', 'wiki', 1201150800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1201150800, 1),
('Networking', 'wiki', 1201150800, 1),
('Adobe Premier', 'wiki', 1201150800, 1),
('Adobe Photoshop', 'wiki', 1201150800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1201237200, 1),
('HomePage', 'wiki', 1201237200, 1),
('HomePage', 'wiki', 1201323600, 4),
('Adobe Premier', 'wiki', 1201323600, 1),
('Linux', 'wiki', 1201323600, 1),
('Subversion', 'wiki', 1201323600, 1),
('Networking', 'wiki', 1201410000, 1),
('Quotes', 'wiki', 1201410000, 1),
('Searching', 'wiki', 1201410000, 1),
('HomePage', 'wiki', 1201410000, 2),
('PERL_Code', 'wiki', 1201410000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1201410000, 1),
('PHP', 'wiki', 1201410000, 1),
('Subversion', 'wiki', 1201410000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1201410000, 1),
('PHP', 'wiki', 1201496400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1201496400, 1),
('HomePage', 'wiki', 1201496400, 2),
('Adobe Premier', 'wiki', 1201496400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1201582800, 1),
('Ubuntu', 'wiki', 1201669200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1201669200, 1),
('HomePage', 'wiki', 1201669200, 1),
('System', 'wiki', 1201755600, 1),
('HomePage', 'wiki', 1201755600, 2),
('File System', 'wiki', 1201755600, 1),
('HomePage', 'wiki', 1201842000, 2),
('HomePage', 'wiki', 1201928400, 3),
('Linux', 'wiki', 1201928400, 1),
('Send Email', 'wiki', 1201928400, 1),
('Subversion', 'wiki', 1201928400, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1201928400, 1),
('HomePage', 'wiki', 1202014800, 8),
('Subversion', 'wiki', 1202014800, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1202014800, 2),
('PERL_Code', 'wiki', 1202014800, 1),
('Linux', 'wiki', 1202014800, 1),
('Scripting', 'wiki', 1202014800, 1),
('HomePage', 'wiki', 1202101200, 3),
('File System', 'wiki', 1202101200, 1),
('Subversion', 'wiki', 1202101200, 1),
('HomePage', 'wiki', 1202187600, 7),
('Subversion', 'wiki', 1202187600, 4),
('Adobe Premier', 'wiki', 1202187600, 1),
('Searching', 'wiki', 1202187600, 2),
('Linux', 'wiki', 1202187600, 2),
('System', 'wiki', 1202187600, 1),
('Samba', 'wiki', 1202187600, 2),
('Send Email', 'wiki', 1202187600, 1),
('File System', 'wiki', 1202187600, 1),
('WebSphere', 'wiki', 1202274000, 1),
('HomePage', 'wiki', 1202274000, 2),
('Linux', 'wiki', 1202274000, 4),
('System', 'wiki', 1202274000, 1),
('File System', 'wiki', 1202274000, 1),
('Networking', 'wiki', 1202274000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1202274000, 1),
('Quotes', 'wiki', 1202274000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1202360400, 1),
('HomePage', 'wiki', 1202360400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1202364000, 1),
('HomePage', 'wiki', 1202450400, 20),
('Subversion', 'wiki', 1202450400, 2),
('PERL_Code', 'wiki', 1202450400, 1),
('Linux', 'wiki', 1202450400, 6),
('Treo 650 setup with Ubuntu', 'wiki', 1202450400, 2),
('Quotes', 'wiki', 1202450400, 1),
('File System', 'wiki', 1202450400, 1),
('Maintain Users', 'wiki', 1202450400, 1),
('WebSphere', 'wiki', 1202450400, 1),
('Searching', 'wiki', 1202450400, 1),
('Running Processes', 'wiki', 1202450400, 1),
('PHP', 'wiki', 1202450400, 1),
('HomePage', 'wiki', 1202536800, 3),
('Linux', 'wiki', 1202536800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1202536800, 2),
('PHP', 'wiki', 1202536800, 1),
('Adobe Premier', 'wiki', 1202536800, 1),
('Ubuntu', 'wiki', 1202536800, 1),
('HomePage', 'wiki', 1202623200, 3),
('Linux', 'wiki', 1202623200, 1),
('Subversion', 'wiki', 1202623200, 1),
('PHP', 'wiki', 1202623200, 1),
('WebSphere', 'wiki', 1202623200, 1),
('PERL_Code', 'wiki', 1202623200, 1),
('Adobe Premier', 'wiki', 1202623200, 1),
('Adobe Photoshop', 'wiki', 1202623200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1202623200, 4),
('Send Email', 'wiki', 1202709600, 1),
('HomePage', 'wiki', 1202709600, 3),
('File System', 'wiki', 1202709600, 1),
('HomePage', 'wiki', 1202796000, 8),
('Linux', 'wiki', 1202796000, 8),
('Scripting', 'wiki', 1202796000, 1),
('Searching', 'wiki', 1202796000, 1),
('System', 'wiki', 1202796000, 1),
('File System', 'wiki', 1202796000, 2),
('PHP', 'wiki', 1202796000, 1),
('Subversion', 'wiki', 1202796000, 1),
('Running Processes', 'wiki', 1202796000, 1),
('Adobe Premier', 'wiki', 1202796000, 1),
('WebSphere', 'wiki', 1202796000, 1),
('Linux', 'wiki', 1202882400, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1202882400, 1),
('Scripting', 'wiki', 1202882400, 1),
('Running Processes', 'wiki', 1202882400, 1),
('System', 'wiki', 1202882400, 1),
('Adobe Photoshop', 'wiki', 1202968800, 1),
('PERL_Code', 'wiki', 1202968800, 1),
('HomePage', 'wiki', 1202968800, 1),
('HomePage', 'wiki', 1203055200, 1),
('HomePage', 'wiki', 1203314400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1203314400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1203400800, 1),
('Adobe Photoshop', 'wiki', 1203400800, 1),
('Adobe Premier', 'wiki', 1203400800, 1),
('Ubuntu', 'wiki', 1203400800, 1),
('Searching', 'wiki', 1203487200, 2),
('HomePage', 'wiki', 1203487200, 5),
('WebSphere', 'wiki', 1203487200, 1),
('PHP', 'wiki', 1203487200, 1),
('Send Email', 'wiki', 1203573600, 2),
('Quotes', 'wiki', 1203573600, 1),
('Linux', 'wiki', 1203573600, 10),
('HomePage', 'wiki', 1203573600, 7),
('PERL_Code', 'wiki', 1203573600, 2),
('PHP', 'wiki', 1203573600, 1),
('Searching', 'wiki', 1203573600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1203573600, 1),
('Ubuntu', 'wiki', 1203573600, 1),
('RocketRaid', 'wiki', 1203573600, 4),
('HomePage', 'wiki', 1203660000, 8),
('PERL_Code', 'wiki', 1203660000, 1),
('Adobe Premier', 'wiki', 1203660000, 1),
('Quotes', 'wiki', 1203660000, 1),
('Adobe Photoshop', 'wiki', 1203660000, 1),
('Linux', 'wiki', 1203660000, 3),
('Networking', 'wiki', 1203660000, 3),
('File System', 'wiki', 1203660000, 1),
('RocketRaid', 'wiki', 1203660000, 3),
('RocketRaid', 'wiki', 1203746400, 3),
('Linux', 'wiki', 1203746400, 13),
('HomePage', 'wiki', 1203746400, 18),
('Highpoint RocketRaid 1820A with Ubuntu', 'wiki', 1203746400, 13),
('Networking', 'wiki', 1203746400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1203746400, 1),
('WebSphere', 'wiki', 1203832800, 1),
('Subversion', 'wiki', 1203832800, 1),
('HomePage', 'wiki', 1203832800, 5),
('Linux', 'wiki', 1203832800, 4),
('System', 'wiki', 1203832800, 1),
('Send Email', 'wiki', 1203832800, 1),
('Networking', 'wiki', 1203832800, 2),
('Adobe Photoshop', 'wiki', 1203832800, 1),
('Adobe Premier', 'wiki', 1203832800, 1),
('PERL_Code', 'wiki', 1203832800, 1),
('HomePage', 'wiki', 1203919200, 2),
('PHP', 'wiki', 1203919200, 1),
('Adobe Premier', 'wiki', 1203919200, 1),
('Searching', 'wiki', 1203919200, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1203919200, 1),
('Networking', 'wiki', 1203919200, 1),
('HomePage', 'wiki', 1204005600, 2),
('Linux', 'wiki', 1204005600, 1),
('Adobe Premier', 'wiki', 1204005600, 1),
('Networking', 'wiki', 1204005600, 1),
('Subversion', 'wiki', 1204005600, 1),
('Adobe Photoshop', 'wiki', 1204092000, 1),
('WebSphere', 'wiki', 1204092000, 1),
('HomePage', 'wiki', 1204092000, 1),
('Quotes', 'wiki', 1204178400, 1),
('PHP', 'wiki', 1204178400, 1),
('Linux', 'wiki', 1204178400, 1),
('HomePage', 'wiki', 1204178400, 2),
('PERL_Code', 'wiki', 1204178400, 1),
('Adobe Premier', 'wiki', 1204264800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1204264800, 1),
('HomePage', 'wiki', 1204264800, 1),
('HomePage', 'wiki', 1204351200, 6),
('Linux', 'wiki', 1204351200, 4),
('Scripting', 'wiki', 1204351200, 1),
('File System', 'wiki', 1204351200, 1),
('Searching', 'wiki', 1204351200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1204351200, 1),
('Subversion', 'wiki', 1204351200, 1),
('Subversion', 'wiki', 1204437600, 1),
('PHP', 'wiki', 1204437600, 1),
('HomePage', 'wiki', 1204437600, 6),
('Linux', 'wiki', 1204437600, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1204437600, 1),
('Networking', 'wiki', 1204437600, 3),
('Adobe Photoshop', 'wiki', 1204437600, 1),
('Adobe Premier', 'wiki', 1204437600, 1),
('PERL_Code', 'wiki', 1204524000, 1),
('PHP', 'wiki', 1204524000, 1),
('HomePage', 'wiki', 1204524000, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1204524000, 1),
('Adobe Photoshop', 'wiki', 1204524000, 1),
('Networking', 'wiki', 1204524000, 1),
('HomePage', 'wiki', 1204610400, 2),
('System', 'wiki', 1204610400, 3),
('Networking', 'wiki', 1204610400, 1),
('Linux', 'wiki', 1204610400, 6),
('File System', 'wiki', 1204610400, 1),
('Searching', 'wiki', 1204610400, 1),
('Scripting', 'wiki', 1204610400, 1),
('Running Processes', 'wiki', 1204610400, 2),
('Subversion', 'wiki', 1204696800, 1),
('Networking', 'wiki', 1204696800, 3),
('HomePage', 'wiki', 1204696800, 3),
('Linux', 'wiki', 1204696800, 1),
('Searching', 'wiki', 1204696800, 1),
('HomePage', 'wiki', 1204783200, 3),
('Networking', 'wiki', 1204783200, 2),
('Adobe Photoshop', 'wiki', 1204783200, 1),
('HomePage', 'wiki', 1204869600, 4),
('Linux', 'wiki', 1204869600, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1204869600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1204869600, 1),
('Subversion', 'wiki', 1204869600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1204956000, 3),
('HomePage', 'wiki', 1205042400, 2),
('Adobe Premier', 'wiki', 1205042400, 1),
('WebSphere', 'wiki', 1205042400, 1),
('Scripting', 'wiki', 1205042400, 1),
('PHP', 'wiki', 1205042400, 1),
('Subversion', 'wiki', 1205042400, 1),
('Networking', 'wiki', 1205042400, 1),
('File System', 'wiki', 1205042400, 1),
('System', 'wiki', 1205042400, 1),
('Searching', 'wiki', 1205042400, 1),
('Quotes', 'wiki', 1205042400, 1),
('PERL_Code', 'wiki', 1205042400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1205042400, 1),
('Running Processes', 'wiki', 1205042400, 1),
('Send Email', 'wiki', 1205042400, 1),
('Ubuntu', 'wiki', 1205042400, 1),
('HomePage', 'wiki', 1205125200, 11),
('Treo 650 setup with Ubuntu', 'wiki', 1205125200, 1),
('Linux', 'wiki', 1205125200, 2),
('Subversion', 'wiki', 1205125200, 2),
('PHP', 'wiki', 1205125200, 1),
('WebSphere', 'wiki', 1205125200, 2),
('PERL_Code', 'wiki', 1205125200, 2),
('Adobe Premier', 'wiki', 1205125200, 1),
('Adobe Photoshop', 'wiki', 1205125200, 2),
('File System', 'wiki', 1205125200, 1),
('Ubuntu', 'wiki', 1205125200, 1),
('Searching', 'wiki', 1205125200, 1),
('Networking', 'wiki', 1205125200, 1),
('HomePage', 'wiki', 1205211600, 6),
('File System', 'wiki', 1205211600, 1),
('Adobe Photoshop', 'wiki', 1205211600, 1),
('Adobe Premier', 'wiki', 1205211600, 1),
('Scripting', 'wiki', 1205211600, 1),
('Linux', 'wiki', 1205211600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1205211600, 1),
('PERL_Code', 'wiki', 1205211600, 1);
INSERT INTO `tiki_stats` (`object`, `type`, `day`, `hits`) VALUES
('Treo 650 setup with Ubuntu', 'wiki', 1205211600, 1),
('Samba', 'wiki', 1205298000, 1),
('System', 'wiki', 1205298000, 1),
('HomePage', 'wiki', 1205298000, 2),
('Linux', 'wiki', 1205298000, 2),
('Subversion', 'wiki', 1205298000, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1205298000, 3),
('PHP', 'wiki', 1205298000, 1),
('Maintain Users', 'wiki', 1205298000, 1),
('Searching', 'wiki', 1205298000, 1),
('Scripting', 'wiki', 1205298000, 1),
('Quotes', 'wiki', 1205298000, 1),
('WebSphere', 'wiki', 1205298000, 1),
('HomePage', 'wiki', 1205384400, 5),
('Adobe Premier', 'wiki', 1205384400, 1),
('WebSphere', 'wiki', 1205384400, 1),
('Scripting', 'wiki', 1205384400, 1),
('PHP', 'wiki', 1205384400, 2),
('Subversion', 'wiki', 1205384400, 1),
('Networking', 'wiki', 1205384400, 1),
('File System', 'wiki', 1205384400, 1),
('System', 'wiki', 1205384400, 2),
('Searching', 'wiki', 1205384400, 1),
('Quotes', 'wiki', 1205384400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1205384400, 2),
('Running Processes', 'wiki', 1205384400, 2),
('Send Email', 'wiki', 1205384400, 1),
('Ubuntu', 'wiki', 1205384400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1205384400, 1),
('Scripting', 'wiki', 1205470800, 1),
('Adobe Premier', 'wiki', 1205470800, 1),
('HomePage', 'wiki', 1205470800, 1),
('File System', 'wiki', 1205470800, 1),
('HomePage', 'wiki', 1205557200, 5),
('Linux', 'wiki', 1205557200, 2),
('Send Email', 'wiki', 1205557200, 2),
('Ubuntu', 'wiki', 1205557200, 2),
('Samba', 'wiki', 1205557200, 2),
('Subversion', 'wiki', 1205557200, 1),
('Adobe Premier', 'wiki', 1205557200, 2),
('PHP', 'wiki', 1205557200, 1),
('Networking', 'wiki', 1205557200, 1),
('Searching', 'wiki', 1205557200, 1),
('Quotes', 'wiki', 1205557200, 2),
('PERL_Code', 'wiki', 1205557200, 1),
('Adobe Photoshop', 'wiki', 1205557200, 1),
('WebSphere', 'wiki', 1205557200, 1),
('Running Processes', 'wiki', 1205557200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1205557200, 1),
('Maintain Users', 'wiki', 1205557200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1205557200, 1),
('File System', 'wiki', 1205557200, 2),
('Scripting', 'wiki', 1205557200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1205557200, 1),
('System', 'wiki', 1205557200, 2),
('Adobe Premier', 'wiki', 1205643600, 1),
('HomePage', 'wiki', 1205643600, 2),
('HomePage', 'wiki', 1205730000, 5),
('Treo 650 setup with Ubuntu', 'wiki', 1205730000, 4),
('Linux', 'wiki', 1205730000, 1),
('Subversion', 'wiki', 1205730000, 1),
('Searching', 'wiki', 1205730000, 1),
('Adobe Premier', 'wiki', 1205730000, 1),
('Adobe Photoshop', 'wiki', 1205730000, 1),
('PERL_Code', 'wiki', 1205816400, 2),
('WebSphere', 'wiki', 1205816400, 1),
('Adobe Premier', 'wiki', 1205816400, 1),
('File System', 'wiki', 1205816400, 1),
('Networking', 'wiki', 1205816400, 1),
('Adobe Photoshop', 'wiki', 1205816400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1205816400, 1),
('HomePage', 'wiki', 1205816400, 2),
('Ubuntu', 'wiki', 1205816400, 1),
('Samba', 'wiki', 1205816400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1205902800, 1),
('HomePage', 'wiki', 1205902800, 1),
('Linux', 'wiki', 1205902800, 1),
('Searching', 'wiki', 1205902800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1205989200, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1205989200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206075600, 3),
('HomePage', 'wiki', 1206075600, 7),
('PHP', 'wiki', 1206075600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1206075600, 1),
('Adobe Premier', 'wiki', 1206075600, 1),
('WebSphere', 'wiki', 1206075600, 1),
('Scripting', 'wiki', 1206075600, 2),
('Subversion', 'wiki', 1206075600, 1),
('Networking', 'wiki', 1206075600, 1),
('File System', 'wiki', 1206075600, 1),
('System', 'wiki', 1206075600, 1),
('Searching', 'wiki', 1206075600, 2),
('Quotes', 'wiki', 1206075600, 1),
('Running Processes', 'wiki', 1206075600, 1),
('Send Email', 'wiki', 1206075600, 1),
('Ubuntu', 'wiki', 1206075600, 1),
('Maintain Users', 'wiki', 1206162000, 1),
('Scripting', 'wiki', 1206162000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1206162000, 1),
('HomePage', 'wiki', 1206162000, 2),
('PHP', 'wiki', 1206162000, 1),
('Running Processes', 'wiki', 1206162000, 2),
('File System', 'wiki', 1206162000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206162000, 1),
('Networking', 'wiki', 1206162000, 1),
('Adobe Premier', 'wiki', 1206162000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1206162000, 1),
('File System', 'wiki', 1206248400, 1),
('Quotes', 'wiki', 1206248400, 1),
('Samba', 'wiki', 1206248400, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1206248400, 2),
('Send Email', 'wiki', 1206248400, 1),
('System', 'wiki', 1206248400, 2),
('Adobe Premier', 'wiki', 1206248400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1206248400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206248400, 1),
('HomePage', 'wiki', 1206248400, 2),
('Running Processes', 'wiki', 1206248400, 1),
('HomePage', 'wiki', 1206334800, 2),
('Subversion', 'wiki', 1206334800, 2),
('Linux', 'wiki', 1206334800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1206334800, 1),
('Searching', 'wiki', 1206334800, 2),
('File System', 'wiki', 1206334800, 1),
('Maintain Users', 'wiki', 1206334800, 1),
('WebSphere', 'wiki', 1206334800, 1),
('Adobe Premier', 'wiki', 1206334800, 1),
('Adobe Photoshop', 'wiki', 1206334800, 1),
('PERL_Code', 'wiki', 1206421200, 1),
('WebSphere', 'wiki', 1206421200, 1),
('Send Email', 'wiki', 1206421200, 1),
('HomePage', 'wiki', 1206421200, 2),
('File System', 'wiki', 1206421200, 1),
('Networking', 'wiki', 1206421200, 1),
('Adobe Photoshop', 'wiki', 1206421200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1206421200, 5),
('Ubuntu', 'wiki', 1206421200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206421200, 1),
('Adobe Premier', 'wiki', 1206421200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1206507600, 7),
('HomePage', 'wiki', 1206507600, 3),
('Linux', 'wiki', 1206507600, 2),
('WebSphere', 'wiki', 1206507600, 1),
('PERL_Code', 'wiki', 1206507600, 2),
('Quotes', 'wiki', 1206507600, 1),
('Ubuntu', 'wiki', 1206507600, 1),
('HomePage', 'wiki', 1206594000, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1206594000, 1),
('HomePage', 'wiki', 1206680400, 3),
('PHP', 'wiki', 1206680400, 1),
('Quotes', 'wiki', 1206680400, 1),
('Networking', 'wiki', 1206680400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1206680400, 6),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206680400, 1),
('Searching', 'wiki', 1206680400, 1),
('Scripting', 'wiki', 1206766800, 2),
('Running Processes', 'wiki', 1206766800, 1),
('HomePage', 'wiki', 1206766800, 2),
('Networking', 'wiki', 1206766800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206766800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1206766800, 3),
('PHP', 'wiki', 1206766800, 1),
('File System', 'wiki', 1206853200, 1),
('Quotes', 'wiki', 1206853200, 1),
('Adobe Premier', 'wiki', 1206853200, 4),
('System', 'wiki', 1206853200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1206853200, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1206853200, 1),
('Samba', 'wiki', 1206853200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206853200, 1),
('HomePage', 'wiki', 1206853200, 1),
('HomePage', 'wiki', 1206939600, 1),
('Subversion', 'wiki', 1206939600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1206939600, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1206939600, 2),
('Searching', 'wiki', 1206939600, 1),
('Adobe Photoshop', 'wiki', 1206939600, 1),
('Adobe Premier', 'wiki', 1207026000, 3),
('Send Email', 'wiki', 1207026000, 3),
('WebSphere', 'wiki', 1207026000, 2),
('PERL_Code', 'wiki', 1207026000, 2),
('HomePage', 'wiki', 1207026000, 6),
('File System', 'wiki', 1207026000, 3),
('Scripting', 'wiki', 1207026000, 2),
('PHP', 'wiki', 1207026000, 1),
('Subversion', 'wiki', 1207026000, 1),
('Networking', 'wiki', 1207026000, 2),
('System', 'wiki', 1207026000, 1),
('Quotes', 'wiki', 1207026000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207026000, 7),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1207026000, 5),
('Ubuntu', 'wiki', 1207026000, 2),
('Samba', 'wiki', 1207026000, 1),
('Maintain Users', 'wiki', 1207026000, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1207026000, 1),
('Searching', 'wiki', 1207026000, 1),
('Running Processes', 'wiki', 1207026000, 1),
('Linux', 'wiki', 1207026000, 2),
('Adobe Photoshop', 'wiki', 1207026000, 2),
('HomePage', 'wiki', 1207112400, 2),
('Adobe Premier', 'wiki', 1207112400, 1),
('WebSphere', 'wiki', 1207112400, 1),
('Linux', 'wiki', 1207112400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1207112400, 1),
('Quotes', 'wiki', 1207112400, 1),
('PERL_Code', 'wiki', 1207112400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1207112400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207112400, 1),
('HomePage', 'wiki', 1207198800, 5),
('Adobe Premier', 'wiki', 1207198800, 1),
('WebSphere', 'wiki', 1207198800, 3),
('Scripting', 'wiki', 1207198800, 2),
('PHP', 'wiki', 1207198800, 1),
('Subversion', 'wiki', 1207198800, 1),
('Networking', 'wiki', 1207198800, 1),
('File System', 'wiki', 1207198800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207198800, 1),
('Searching', 'wiki', 1207198800, 1),
('PERL_Code', 'wiki', 1207198800, 1),
('HomePage', 'wiki', 1207285200, 9),
('PHP', 'wiki', 1207285200, 1),
('Adobe Photoshop', 'wiki', 1207285200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1207285200, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1207285200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1207371600, 1),
('Linux', 'wiki', 1207371600, 1),
('Scripting', 'wiki', 1207371600, 1),
('Searching', 'wiki', 1207371600, 1),
('Networking', 'wiki', 1207371600, 1),
('HomePage', 'wiki', 1207371600, 1),
('PHP', 'wiki', 1207371600, 1),
('Ubuntu', 'wiki', 1207371600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207371600, 1),
('System', 'wiki', 1207458000, 1),
('Quotes', 'wiki', 1207458000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207458000, 1),
('PHP', 'wiki', 1207458000, 2),
('HomePage', 'wiki', 1207458000, 4),
('Searching', 'wiki', 1207458000, 1),
('Linux', 'wiki', 1207458000, 1),
('Subversion', 'wiki', 1207458000, 1),
('WebSphere', 'wiki', 1207458000, 1),
('PERL_Code', 'wiki', 1207458000, 1),
('Adobe Premier', 'wiki', 1207458000, 2),
('Adobe Photoshop', 'wiki', 1207458000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207544400, 3),
('HomePage', 'wiki', 1207544400, 1),
('Subversion', 'wiki', 1207544400, 2),
('Adobe Premier', 'wiki', 1207630800, 2),
('WebSphere', 'wiki', 1207630800, 2),
('HomePage', 'wiki', 1207630800, 4),
('Adobe Photoshop', 'wiki', 1207630800, 2),
('Networking', 'wiki', 1207630800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207717200, 2),
('File System', 'wiki', 1207717200, 1),
('Networking', 'wiki', 1207717200, 3),
('HomePage', 'wiki', 1207717200, 5),
('PERL_Code', 'wiki', 1207717200, 2),
('Linux', 'wiki', 1207717200, 2),
('Subversion', 'wiki', 1207717200, 1),
('PHP', 'wiki', 1207717200, 1),
('WebSphere', 'wiki', 1207717200, 1),
('Adobe Premier', 'wiki', 1207717200, 1),
('Adobe Photoshop', 'wiki', 1207717200, 1),
('Quotes', 'wiki', 1207717200, 1),
('HomePage', 'wiki', 1207803600, 1),
('Quotes', 'wiki', 1207803600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207803600, 1),
('HomePage', 'wiki', 1207890000, 20),
('Linux', 'wiki', 1207890000, 1),
('Searching', 'wiki', 1207890000, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1207890000, 1),
('PERL_Code', 'wiki', 1207890000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1207890000, 2),
('Maintain Users', 'wiki', 1207890000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1207890000, 1),
('Quotes', 'wiki', 1207890000, 1),
('PHP', 'wiki', 1207976400, 1),
('Samba', 'wiki', 1207976400, 1),
('Adobe Premier', 'wiki', 1207976400, 2),
('HomePage', 'wiki', 1207976400, 3),
('Scripting', 'wiki', 1207976400, 1),
('PHP', 'wiki', 1208062800, 1),
('Samba', 'wiki', 1208062800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208062800, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1208062800, 2),
('HomePage', 'wiki', 1208062800, 1),
('HomePage', 'wiki', 1208149200, 4),
('Running Processes', 'wiki', 1208149200, 1),
('Linux', 'wiki', 1208149200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208149200, 2),
('Subversion', 'wiki', 1208149200, 2),
('Adobe Premier', 'wiki', 1208149200, 1),
('Quotes', 'wiki', 1208149200, 1),
('PHP', 'wiki', 1208149200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1208149200, 2),
('System', 'wiki', 1208149200, 1),
('PERL_Code', 'wiki', 1208149200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208235600, 3),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1208235600, 1),
('Networking', 'wiki', 1208235600, 1),
('WebSphere', 'wiki', 1208235600, 2),
('HomePage', 'wiki', 1208235600, 7),
('Subversion', 'wiki', 1208235600, 1),
('Adobe Premier', 'wiki', 1208235600, 1),
('Linux', 'wiki', 1208235600, 2),
('Searching', 'wiki', 1208235600, 1),
('Quotes', 'wiki', 1208235600, 1),
('Adobe Photoshop', 'wiki', 1208322000, 3),
('HomePage', 'wiki', 1208322000, 5),
('PERL_Code', 'wiki', 1208322000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1208322000, 1),
('PHP', 'wiki', 1208322000, 2),
('WebSphere', 'wiki', 1208322000, 1),
('Adobe Premier', 'wiki', 1208322000, 2),
('Subversion', 'wiki', 1208322000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1208408400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208408400, 1),
('HomePage', 'wiki', 1208408400, 4),
('Maintain Users', 'wiki', 1208408400, 1),
('Linux', 'wiki', 1208408400, 1),
('Adobe Premier', 'wiki', 1208408400, 1),
('HomePage', 'wiki', 1208494800, 2),
('Networking', 'wiki', 1208581200, 1),
('PERL_Code', 'wiki', 1208581200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1208581200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208581200, 1),
('HomePage', 'wiki', 1208581200, 1),
('File System', 'wiki', 1208667600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1208667600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208667600, 4),
('HomePage', 'wiki', 1208667600, 5),
('PHP', 'wiki', 1208667600, 1),
('Maintain Users', 'wiki', 1208754000, 1),
('HomePage', 'wiki', 1208754000, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208754000, 5),
('Subversion', 'wiki', 1208754000, 1),
('Quotes', 'wiki', 1208754000, 1),
('WebSphere', 'wiki', 1208840400, 1),
('Adobe Premier', 'wiki', 1208840400, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1208840400, 1),
('HomePage', 'wiki', 1208840400, 6),
('Subversion', 'wiki', 1208840400, 1),
('Adobe Photoshop', 'wiki', 1208926800, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1208926800, 1),
('HomePage', 'wiki', 1208926800, 3),
('PERL_Code', 'wiki', 1208926800, 1),
('Quotes', 'wiki', 1208926800, 1),
('HomePage', 'wiki', 1209013200, 3),
('Adobe Premier', 'wiki', 1209013200, 1),
('WebSphere', 'wiki', 1209013200, 1),
('Scripting', 'wiki', 1209013200, 2),
('PHP', 'wiki', 1209013200, 1),
('Subversion', 'wiki', 1209013200, 1),
('Networking', 'wiki', 1209013200, 1),
('File System', 'wiki', 1209013200, 1),
('System', 'wiki', 1209013200, 1),
('Quotes', 'wiki', 1209013200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1209013200, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209013200, 2),
('Ubuntu', 'wiki', 1209013200, 1),
('Send Email', 'wiki', 1209013200, 1),
('Samba', 'wiki', 1209013200, 1),
('Maintain Users', 'wiki', 1209013200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1209013200, 1),
('Searching', 'wiki', 1209013200, 1),
('Running Processes', 'wiki', 1209013200, 1),
('PERL_Code', 'wiki', 1209013200, 1),
('Linux', 'wiki', 1209013200, 1),
('Adobe Photoshop', 'wiki', 1209013200, 1),
('Scripting', 'wiki', 1209186000, 3),
('Linux', 'wiki', 1209186000, 10),
('Adobe Photoshop', 'wiki', 1209186000, 2),
('HomePage', 'wiki', 1209186000, 3),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1209186000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209186000, 3),
('Running Processes', 'wiki', 1209186000, 3),
('Searching', 'wiki', 1209186000, 2),
('System', 'wiki', 1209186000, 1),
('Maintain Users', 'wiki', 1209186000, 1),
('HomePage', 'wiki', 1209272400, 4),
('Subversion', 'wiki', 1209272400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209272400, 1),
('Send Email', 'wiki', 1209272400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209358800, 2),
('Linux', 'wiki', 1209358800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1209358800, 3),
('Subversion', 'wiki', 1209358800, 1),
('HomePage', 'wiki', 1209358800, 1),
('Networking', 'wiki', 1209358800, 1),
('PERL_Code', 'wiki', 1209358800, 1),
('File System', 'wiki', 1209445200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209445200, 3),
('Scripting', 'wiki', 1209445200, 1),
('Maintain Users', 'wiki', 1209445200, 1),
('Linux', 'wiki', 1209445200, 1),
('HomePage', 'wiki', 1209445200, 1),
('Subversion', 'wiki', 1209445200, 1),
('PHP', 'wiki', 1209445200, 1),
('Adobe Premier', 'wiki', 1209445200, 1),
('Searching', 'wiki', 1209445200, 1),
('Adobe Photoshop', 'wiki', 1209445200, 1),
('HomePage', 'wiki', 1209531600, 4),
('Searching', 'wiki', 1209531600, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209531600, 5),
('PERL_Code', 'wiki', 1209531600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1209531600, 1),
('System', 'wiki', 1209531600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1209531600, 1),
('Send Email', 'wiki', 1209618000, 1),
('HomePage', 'wiki', 1209618000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209618000, 6),
('Treo 650 setup with Ubuntu', 'wiki', 1209618000, 1),
('Adobe Photoshop', 'wiki', 1209704400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1209704400, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209704400, 2),
('WebSphere', 'wiki', 1209704400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1209790800, 4),
('HomePage', 'wiki', 1209790800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209790800, 1),
('Adobe Photoshop', 'wiki', 1209790800, 1),
('Networking', 'wiki', 1209790800, 1),
('Networking', 'wiki', 1209877200, 1),
('Running Processes', 'wiki', 1209877200, 1),
('Searching', 'wiki', 1209877200, 1),
('Samba', 'wiki', 1209877200, 1),
('HomePage', 'wiki', 1209877200, 1),
('Quotes', 'wiki', 1209877200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209877200, 2),
('WebSphere', 'wiki', 1209877200, 1),
('HomePage', 'wiki', 1209963600, 3),
('Adobe Premier', 'wiki', 1209963600, 1),
('Subversion', 'wiki', 1209963600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1209963600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210050000, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1210050000, 2),
('HomePage', 'wiki', 1210050000, 2),
('Subversion', 'wiki', 1210050000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1210050000, 1),
('System', 'wiki', 1210050000, 1),
('Adobe Premier', 'wiki', 1210050000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1210136400, 3),
('PHP', 'wiki', 1210136400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210136400, 5),
('HomePage', 'wiki', 1210136400, 8),
('Linux', 'wiki', 1210136400, 2),
('Subversion', 'wiki', 1210136400, 1),
('WebSphere', 'wiki', 1210136400, 1),
('PERL_Code', 'wiki', 1210136400, 2),
('HomePage', 'wiki', 1210222800, 7),
('Treo 650 setup with Ubuntu', 'wiki', 1210222800, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210222800, 8),
('Linux', 'wiki', 1210222800, 2),
('Subversion', 'wiki', 1210222800, 1),
('PHP', 'wiki', 1210222800, 1),
('PERL_Code', 'wiki', 1210222800, 1),
('Adobe Premier', 'wiki', 1210222800, 1),
('Adobe Photoshop', 'wiki', 1210222800, 1),
('Quotes', 'wiki', 1210222800, 1),
('Maintain Users', 'wiki', 1210222800, 1),
('File System', 'wiki', 1210309200, 1),
('HomePage', 'wiki', 1210309200, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210309200, 2),
('PHP', 'wiki', 1210309200, 1),
('Running Processes', 'wiki', 1210309200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1210309200, 1),
('HomePage', 'wiki', 1210395600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1210395600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210395600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1210395600, 1),
('Adobe Photoshop', 'wiki', 1210395600, 1),
('Subversion', 'wiki', 1210395600, 1),
('Networking', 'wiki', 1210395600, 1),
('HomePage', 'wiki', 1210482000, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1210482000, 2),
('Adobe Premier', 'wiki', 1210482000, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210482000, 2),
('Quotes', 'wiki', 1210482000, 1),
('File System', 'wiki', 1210482000, 1),
('Maintain Users', 'wiki', 1210482000, 1),
('Scripting', 'wiki', 1210482000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210568400, 2),
('System', 'wiki', 1210568400, 1),
('HomePage', 'wiki', 1210568400, 4),
('Subversion', 'wiki', 1210568400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1210568400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210654800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1210654800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1210654800, 2),
('HomePage', 'wiki', 1210654800, 3),
('WebSphere', 'wiki', 1210654800, 1),
('Adobe Photoshop', 'wiki', 1210654800, 1),
('Linux', 'wiki', 1210654800, 1),
('Ubuntu', 'wiki', 1210654800, 1),
('Adobe Premier', 'wiki', 1210654800, 2),
('PHP', 'wiki', 1210654800, 1),
('Subversion', 'wiki', 1210654800, 2),
('PERL_Code', 'wiki', 1210654800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210741200, 7),
('HomePage', 'wiki', 1210741200, 4),
('Adobe Photoshop', 'wiki', 1210741200, 1),
('PHP', 'wiki', 1210741200, 1),
('Linux', 'wiki', 1210741200, 1),
('Searching', 'wiki', 1210741200, 1),
('Adobe Premier', 'wiki', 1210741200, 1),
('PERL_Code', 'wiki', 1210741200, 1),
('WebSphere', 'wiki', 1210827600, 1),
('File System', 'wiki', 1210827600, 1),
('HomePage', 'wiki', 1210827600, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210827600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1210827600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1210914000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1210914000, 3),
('HomePage', 'wiki', 1210914000, 1),
('Linux', 'wiki', 1210914000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1211000400, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211000400, 5),
('HomePage', 'wiki', 1211000400, 6),
('Adobe Premier', 'wiki', 1211000400, 1),
('WebSphere', 'wiki', 1211000400, 1),
('Scripting', 'wiki', 1211000400, 1),
('PHP', 'wiki', 1211000400, 1),
('Subversion', 'wiki', 1211000400, 1),
('File System', 'wiki', 1211000400, 1),
('Send Email', 'wiki', 1211000400, 1),
('Ubuntu', 'wiki', 1211000400, 1),
('Samba', 'wiki', 1211000400, 1),
('Maintain Users', 'wiki', 1211000400, 1),
('System', 'wiki', 1211000400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1211000400, 2),
('Searching', 'wiki', 1211000400, 1),
('Quotes', 'wiki', 1211000400, 1),
('Running Processes', 'wiki', 1211000400, 1),
('Networking', 'wiki', 1211000400, 1),
('HomePage', 'wiki', 1211086800, 7),
('Adobe Photoshop', 'wiki', 1211086800, 2),
('Quotes', 'wiki', 1211086800, 1),
('PHP', 'wiki', 1211086800, 2),
('Linux', 'wiki', 1211086800, 1),
('WebSphere', 'wiki', 1211086800, 2),
('PERL_Code', 'wiki', 1211086800, 1),
('Subversion', 'wiki', 1211086800, 1),
('Adobe Premier', 'wiki', 1211086800, 2),
('Networking', 'wiki', 1211086800, 1),
('File System', 'wiki', 1211086800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211173200, 4),
('HomePage', 'wiki', 1211173200, 2),
('HomePage', 'wiki', 1211259600, 4),
('System', 'wiki', 1211259600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1211259600, 5),
('Quotes', 'wiki', 1211259600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211259600, 1),
('HomePage', 'wiki', 1211346000, 8),
('Linux', 'wiki', 1211346000, 1),
('WebSphere', 'wiki', 1211346000, 1),
('Subversion', 'wiki', 1211346000, 1),
('Adobe Photoshop', 'wiki', 1211346000, 1),
('PHP', 'wiki', 1211346000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1211346000, 1),
('Quotes', 'wiki', 1211346000, 1),
('OS X', 'wiki', 1211346000, 1),
('Adobe Premier', 'wiki', 1211346000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211432400, 5),
('PERL_Code', 'wiki', 1211432400, 2),
('Adobe Photoshop', 'wiki', 1211432400, 1),
('HomePage', 'wiki', 1211432400, 2),
('OS X', 'wiki', 1211432400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1211432400, 1),
('Networking', 'wiki', 1211432400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1211432400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211518800, 2),
('HomePage', 'wiki', 1211518800, 1),
('Quotes', 'wiki', 1211605200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211605200, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1211605200, 3),
('Adobe Premier', 'wiki', 1211605200, 1),
('HomePage', 'wiki', 1211605200, 2),
('WebSphere', 'wiki', 1211605200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211691600, 1),
('File System', 'wiki', 1211691600, 2),
('HomePage', 'wiki', 1211691600, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1211691600, 3),
('Linux', 'wiki', 1211691600, 1),
('Subversion', 'wiki', 1211691600, 1),
('Adobe Photoshop', 'wiki', 1211691600, 1),
('Adobe Premier', 'wiki', 1211691600, 1),
('HomePage', 'wiki', 1211778000, 3),
('PHP', 'wiki', 1211778000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1211778000, 2),
('Searching', 'wiki', 1211778000, 1),
('OS X', 'wiki', 1211778000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211778000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1211778000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1211864400, 5),
('HomePage', 'wiki', 1211864400, 4),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1211864400, 1),
('Linux', 'wiki', 1211864400, 1),
('Searching', 'wiki', 1211864400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211864400, 2),
('HomePage', 'wiki', 1211950800, 6),
('Quotes', 'wiki', 1211950800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1211950800, 1),
('Running Processes', 'wiki', 1211950800, 1),
('Linux', 'wiki', 1211950800, 1),
('Searching', 'wiki', 1211950800, 1),
('PERL_Code', 'wiki', 1211950800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1212037200, 2),
('PERL_Code', 'wiki', 1212037200, 1),
('Adobe Premier', 'wiki', 1212037200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212037200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1212123600, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212123600, 3),
('HomePage', 'wiki', 1212123600, 4),
('Scripting', 'wiki', 1212123600, 1),
('Send Email', 'wiki', 1212210000, 1),
('HomePage', 'wiki', 1212210000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212210000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1212210000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1212296400, 5),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212296400, 1),
('Searching', 'wiki', 1212296400, 1),
('HomePage', 'wiki', 1212296400, 2),
('OS X', 'wiki', 1212296400, 1),
('File System', 'wiki', 1212382800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212382800, 5),
('HomePage', 'wiki', 1212382800, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1212382800, 1),
('Adobe Photoshop', 'wiki', 1212382800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212469200, 2),
('Scripting', 'wiki', 1212469200, 1),
('OS X', 'wiki', 1212469200, 1),
('HomePage', 'wiki', 1212469200, 7),
('Subversion', 'wiki', 1212469200, 1),
('WebSphere', 'wiki', 1212469200, 1),
('Linux', 'wiki', 1212469200, 3),
('System', 'wiki', 1212469200, 1),
('Searching', 'wiki', 1212469200, 1),
('Networking', 'wiki', 1212469200, 1),
('HomePage', 'wiki', 1212555600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1212555600, 3),
('Networking', 'wiki', 1212555600, 1),
('WebSphere', 'wiki', 1212555600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212555600, 1),
('HomePage', 'wiki', 1212642000, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212642000, 5),
('OS X', 'wiki', 1212642000, 1),
('Adobe Premier', 'wiki', 1212642000, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1212642000, 1),
('Networking', 'wiki', 1212728400, 1),
('PERL_Code', 'wiki', 1212728400, 1),
('HomePage', 'wiki', 1212728400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1212728400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212814800, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1212814800, 2),
('HomePage', 'wiki', 1212814800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1212814800, 1),
('HomePage', 'wiki', 1212901200, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212901200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1212987600, 2),
('HomePage', 'wiki', 1212987600, 7),
('Linux', 'wiki', 1212987600, 2),
('Quotes', 'wiki', 1212987600, 1),
('Subversion', 'wiki', 1212987600, 2),
('PHP', 'wiki', 1212987600, 1),
('WebSphere', 'wiki', 1212987600, 1),
('PERL_Code', 'wiki', 1212987600, 1),
('Adobe Premier', 'wiki', 1212987600, 1),
('Adobe Photoshop', 'wiki', 1212987600, 2),
('File System', 'wiki', 1212987600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213074000, 2),
('Searching', 'wiki', 1213074000, 1),
('HomePage', 'wiki', 1213074000, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1213074000, 1),
('OS X', 'wiki', 1213074000, 1),
('File System', 'wiki', 1213160400, 2),
('Searching', 'wiki', 1213160400, 2),
('HomePage', 'wiki', 1213160400, 5),
('Adobe Photoshop', 'wiki', 1213160400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213160400, 6),
('Networking', 'wiki', 1213160400, 2),
('Adobe Premier', 'wiki', 1213160400, 1),
('WebSphere', 'wiki', 1213160400, 1),
('Scripting', 'wiki', 1213160400, 2),
('OS X', 'wiki', 1213160400, 1),
('PHP', 'wiki', 1213160400, 1),
('Subversion', 'wiki', 1213160400, 1),
('Send Email', 'wiki', 1213160400, 1),
('Ubuntu', 'wiki', 1213160400, 1),
('Samba', 'wiki', 1213160400, 1),
('Maintain Users', 'wiki', 1213160400, 1),
('System', 'wiki', 1213160400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1213160400, 1),
('Quotes', 'wiki', 1213160400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1213160400, 1),
('Running Processes', 'wiki', 1213160400, 1),
('PERL_Code', 'wiki', 1213160400, 1),
('Linux', 'wiki', 1213160400, 1),
('HomePage', 'wiki', 1213246800, 5),
('OS X', 'wiki', 1213246800, 1),
('Adobe Premier', 'wiki', 1213333200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213333200, 1),
('PERL_Code', 'wiki', 1213333200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1213333200, 1),
('HomePage', 'wiki', 1213419600, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213419600, 1),
('Linux', 'wiki', 1213419600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1213419600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1213506000, 2),
('Networking', 'wiki', 1213506000, 1),
('Linux', 'wiki', 1213506000, 1),
('Adobe Photoshop', 'wiki', 1213506000, 1),
('Running Processes', 'wiki', 1213506000, 2),
('File System', 'wiki', 1213506000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213506000, 2),
('HomePage', 'wiki', 1213506000, 1),
('Subversion', 'wiki', 1213506000, 1),
('File System', 'wiki', 1213592400, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1213592400, 7),
('HomePage', 'wiki', 1213592400, 6),
('Ubuntu', 'wiki', 1213592400, 2),
('System', 'wiki', 1213592400, 2),
('Samba', 'wiki', 1213592400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213592400, 4),
('Linux', 'wiki', 1213592400, 1),
('OS X', 'wiki', 1213592400, 1),
('Adobe Photoshop', 'wiki', 1213592400, 1),
('PERL_Code', 'wiki', 1213592400, 1),
('Adobe Premier', 'wiki', 1213592400, 2),
('Quotes', 'wiki', 1213592400, 2),
('WebSphere', 'wiki', 1213592400, 1),
('PHP', 'wiki', 1213592400, 1),
('Subversion', 'wiki', 1213592400, 1),
('Networking', 'wiki', 1213592400, 1),
('Send Email', 'wiki', 1213592400, 1),
('Searching', 'wiki', 1213592400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1213592400, 2),
('Running Processes', 'wiki', 1213592400, 1),
('Maintain Users', 'wiki', 1213592400, 1),
('Scripting', 'wiki', 1213592400, 1),
('Adobe Photoshop', 'wiki', 1213678800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1213678800, 5),
('HomePage', 'wiki', 1213678800, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1213678800, 2),
('Adobe Premier', 'wiki', 1213678800, 1),
('WebSphere', 'wiki', 1213678800, 1),
('HomePage', 'wiki', 1213765200, 4),
('Subversion', 'wiki', 1213765200, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1213765200, 1),
('Adobe Photoshop', 'wiki', 1213765200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213851600, 2),
('HomePage', 'wiki', 1213851600, 1),
('WebSphere', 'wiki', 1213938000, 2),
('HomePage', 'wiki', 1213938000, 2),
('Linux', 'wiki', 1213938000, 1),
('PHP', 'wiki', 1213938000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1213938000, 6),
('Adobe Premier', 'wiki', 1213938000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214024400, 5),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214024400, 4),
('PERL_Code', 'wiki', 1214024400, 1),
('HomePage', 'wiki', 1214024400, 7),
('Networking', 'wiki', 1214024400, 1),
('Linux', 'wiki', 1214024400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214110800, 4),
('HomePage', 'wiki', 1214110800, 3),
('Networking', 'wiki', 1214110800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214110800, 10),
('Networking', 'wiki', 1214197200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214197200, 2),
('HomePage', 'wiki', 1214197200, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1214197200, 1),
('Adobe Premier', 'wiki', 1214197200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214283600, 2),
('HomePage', 'wiki', 1214283600, 2),
('Linux', 'wiki', 1214283600, 7),
('Networking', 'wiki', 1214283600, 1),
('Maintain Users', 'wiki', 1214283600, 1),
('Searching', 'wiki', 1214283600, 1),
('File System', 'wiki', 1214283600, 1),
('System', 'wiki', 1214283600, 2),
('Running Processes', 'wiki', 1214283600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214283600, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214370000, 6),
('HomePage', 'wiki', 1214370000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214370000, 2),
('PHP', 'wiki', 1214370000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214456400, 6),
('HomePage', 'wiki', 1214456400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214542800, 4),
('Ubuntu', 'wiki', 1214542800, 1),
('HomePage', 'wiki', 1214542800, 2),
('Scripting', 'wiki', 1214542800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214542800, 1),
('Quotes', 'wiki', 1214542800, 1),
('PERL_Code', 'wiki', 1214629200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214629200, 1),
('HomePage', 'wiki', 1214629200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214715600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214715600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214802000, 1),
('HomePage', 'wiki', 1214802000, 3),
('OS X', 'wiki', 1214802000, 1),
('Searching', 'wiki', 1214802000, 1),
('Adobe Photoshop', 'wiki', 1214802000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1214888400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214888400, 2),
('PERL_Code', 'wiki', 1214888400, 1),
('HomePage', 'wiki', 1214888400, 2),
('Send Email', 'wiki', 1214974800, 1),
('HomePage', 'wiki', 1214974800, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1214974800, 3),
('Running Processes', 'wiki', 1214974800, 1),
('Subversion', 'wiki', 1214974800, 1),
('Networking', 'wiki', 1215061200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215061200, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1215061200, 2),
('OS X', 'wiki', 1215061200, 1),
('HomePage', 'wiki', 1215147600, 5),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215147600, 10),
('Networking', 'wiki', 1215147600, 1),
('WebSphere', 'wiki', 1215147600, 2),
('Adobe Photoshop', 'wiki', 1215147600, 1),
('OS X', 'wiki', 1215147600, 1),
('PERL_Code', 'wiki', 1215147600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1215147600, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215234000, 10),
('Networking', 'wiki', 1215234000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1215234000, 1),
('HomePage', 'wiki', 1215234000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1215234000, 1),
('HomePage', 'wiki', 1215320400, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215320400, 1),
('HomePage', 'wiki', 1215406800, 7),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215406800, 7),
('Linux', 'wiki', 1215406800, 1),
('Subversion', 'wiki', 1215406800, 1),
('PHP', 'wiki', 1215406800, 1),
('WebSphere', 'wiki', 1215406800, 1),
('PERL_Code', 'wiki', 1215406800, 1),
('Adobe Premier', 'wiki', 1215406800, 1),
('Adobe Photoshop', 'wiki', 1215406800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1215493200, 2),
('Networking', 'wiki', 1215493200, 1),
('Scripting', 'wiki', 1215493200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215493200, 4),
('HomePage', 'wiki', 1215579600, 4),
('PHP', 'wiki', 1215579600, 1),
('Running Processes', 'wiki', 1215579600, 1),
('Adobe Photoshop', 'wiki', 1215579600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215579600, 4),
('Linux', 'wiki', 1215579600, 1),
('PERL_Code', 'wiki', 1215666000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215666000, 5),
('Searching', 'wiki', 1215666000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1215666000, 2),
('HomePage', 'wiki', 1215666000, 5),
('Send Email', 'wiki', 1215666000, 1),
('File System', 'wiki', 1215666000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215752400, 6),
('HomePage', 'wiki', 1215752400, 3),
('File System', 'wiki', 1215752400, 1),
('Adobe Premier', 'wiki', 1215752400, 1),
('OS X', 'wiki', 1215752400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1215838800, 1),
('Scripting', 'wiki', 1215838800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215838800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1215925200, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1215925200, 1),
('HomePage', 'wiki', 1215925200, 1),
('Networking', 'wiki', 1216011600, 1),
('WebSphere', 'wiki', 1216011600, 1),
('HomePage', 'wiki', 1216011600, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216011600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216098000, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1216098000, 1),
('PERL_Code', 'wiki', 1216098000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216184400, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1216184400, 7),
('HomePage', 'wiki', 1216184400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1216270800, 2),
('Quotes', 'wiki', 1216270800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216270800, 2),
('HomePage', 'wiki', 1216270800, 2),
('Adobe Premier', 'wiki', 1216270800, 1),
('WebSphere', 'wiki', 1216270800, 1),
('Samba', 'wiki', 1216270800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216357200, 2),
('Subversion', 'wiki', 1216357200, 2),
('HomePage', 'wiki', 1216357200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216443600, 7),
('Treo 650 setup with Ubuntu', 'wiki', 1216443600, 3),
('HomePage', 'wiki', 1216443600, 1),
('Subversion', 'wiki', 1216443600, 2),
('Linux', 'wiki', 1216530000, 1),
('WebSphere', 'wiki', 1216530000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1216530000, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216530000, 3),
('Searching', 'wiki', 1216530000, 1),
('HomePage', 'wiki', 1216530000, 3),
('Adobe Premier', 'wiki', 1216530000, 1),
('Adobe Premier', 'wiki', 1216616400, 1),
('HomePage', 'wiki', 1216616400, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216616400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1216616400, 2),
('WebSphere', 'wiki', 1216616400, 1),
('Running Processes', 'wiki', 1216616400, 1),
('HomePage', 'wiki', 1216702800, 5),
('Treo 650 setup with Ubuntu', 'wiki', 1216702800, 6),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216702800, 5),
('Networking', 'wiki', 1216702800, 1),
('OS X', 'wiki', 1216702800, 1),
('PHP', 'wiki', 1216702800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1216789200, 13),
('HomePage', 'wiki', 1216789200, 11),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216789200, 3),
('Searching', 'wiki', 1216789200, 2),
('Maintain Users', 'wiki', 1216789200, 1),
('Quotes', 'wiki', 1216789200, 1),
('Linux', 'wiki', 1216789200, 1),
('Adobe Photoshop', 'wiki', 1216789200, 1),
('PERL_Code', 'wiki', 1216789200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1216875600, 6),
('HomePage', 'wiki', 1216875600, 2),
('Running Processes', 'wiki', 1216875600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1216875600, 1),
('Adobe Premier', 'wiki', 1216962000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1216962000, 7),
('HomePage', 'wiki', 1216962000, 3),
('WebSphere', 'wiki', 1216962000, 2),
('Linux', 'wiki', 1216962000, 2),
('Searching', 'wiki', 1216962000, 2),
('PHP', 'wiki', 1216962000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1217048400, 4),
('Quotes', 'wiki', 1217048400, 1),
('Subversion', 'wiki', 1217048400, 1),
('HomePage', 'wiki', 1217048400, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1217134800, 5),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217134800, 3),
('Linux', 'wiki', 1217134800, 1),
('OS X', 'wiki', 1217134800, 1),
('PHP', 'wiki', 1217134800, 1),
('Quotes', 'wiki', 1217134800, 2),
('HomePage', 'wiki', 1217134800, 5),
('WebSphere', 'wiki', 1217134800, 1),
('PERL_Code', 'wiki', 1217134800, 1),
('Subversion', 'wiki', 1217134800, 1),
('Adobe Premier', 'wiki', 1217134800, 1),
('Adobe Photoshop', 'wiki', 1217134800, 1),
('Networking', 'wiki', 1217134800, 1),
('Scripting', 'wiki', 1217134800, 1),
('Linux', 'wiki', 1217221200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1217221200, 3),
('PERL_Code', 'wiki', 1217221200, 1),
('Networking', 'wiki', 1217221200, 1),
('Searching', 'wiki', 1217221200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1217221200, 1),
('HomePage', 'wiki', 1217307600, 2),
('WebSphere', 'wiki', 1217307600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1217394000, 2),
('Adobe Photoshop', 'wiki', 1217394000, 2),
('Adobe Premier', 'wiki', 1217394000, 1),
('HomePage', 'wiki', 1217394000, 2),
('Linux', 'wiki', 1217394000, 2),
('PERL_Code', 'wiki', 1217394000, 1),
('PHP', 'wiki', 1217394000, 1),
('Quotes', 'wiki', 1217394000, 1),
('Subversion', 'wiki', 1217394000, 2),
('WebSphere', 'wiki', 1217394000, 1),
('OS X', 'wiki', 1217394000, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217394000, 3),
('HomePage', 'wiki', 1217480400, 5),
('Adobe Photoshop', 'wiki', 1217480400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1217480400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217480400, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1217566800, 5),
('PHP', 'wiki', 1217566800, 2),
('HomePage', 'wiki', 1217566800, 11),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217566800, 1),
('Linux', 'wiki', 1217566800, 13),
('System', 'wiki', 1217566800, 1),
('File System', 'wiki', 1217566800, 1),
('Searching', 'wiki', 1217566800, 1),
('Maintain Users', 'wiki', 1217566800, 3),
('Networking', 'wiki', 1217566800, 1),
('Scripting', 'wiki', 1217566800, 2),
('Running Processes', 'wiki', 1217566800, 1),
('Samba', 'wiki', 1217566800, 1),
('Send Email', 'wiki', 1217566800, 1),
('Subversion', 'wiki', 1217566800, 1),
('WebSphere', 'wiki', 1217566800, 2),
('PERL_Code', 'wiki', 1217566800, 1),
('OS X', 'wiki', 1217566800, 1),
('Quotes', 'wiki', 1217566800, 1),
('Adobe Premier', 'wiki', 1217653200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1217653200, 2),
('HomePage', 'wiki', 1217653200, 9),
('Linux', 'wiki', 1217653200, 1),
('Samba', 'wiki', 1217653200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217653200, 3),
('HomePage', 'wiki', 1217739600, 6),
('Treo 650 setup with Ubuntu', 'wiki', 1217739600, 6),
('Subversion', 'wiki', 1217739600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1217826000, 1),
('HomePage', 'wiki', 1217826000, 2),
('Networking', 'wiki', 1217826000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217826000, 2),
('Linux', 'wiki', 1217826000, 1),
('Searching', 'wiki', 1217826000, 1),
('PERL_Code', 'wiki', 1217826000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217912400, 1),
('HomePage', 'wiki', 1217912400, 5),
('Adobe Premier', 'wiki', 1217912400, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1217912400, 1),
('Quotes', 'wiki', 1217912400, 1),
('PHP', 'wiki', 1217912400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1217998800, 7),
('HomePage', 'wiki', 1217998800, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1217998800, 2),
('Linux', 'wiki', 1217998800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1218085200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1218085200, 4),
('Running Processes', 'wiki', 1218085200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1218085200, 1),
('HomePage', 'wiki', 1218085200, 1),
('Linux', 'wiki', 1218171600, 2),
('Adobe Premier', 'wiki', 1218171600, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1218258000, 5),
('Treo 650 setup with Ubuntu', 'wiki', 1218258000, 3),
('Send Email', 'wiki', 1218258000, 1),
('Searching', 'wiki', 1218258000, 1),
('Subversion', 'wiki', 1218344400, 2),
('HomePage', 'wiki', 1218344400, 6),
('Linux', 'wiki', 1218344400, 1),
('PHP', 'wiki', 1218344400, 1),
('WebSphere', 'wiki', 1218344400, 1),
('PERL_Code', 'wiki', 1218344400, 1),
('Adobe Premier', 'wiki', 1218344400, 1),
('Adobe Photoshop', 'wiki', 1218344400, 1),
('File System', 'wiki', 1218344400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1218344400, 3),
('File System', 'wiki', 1218430800, 1),
('HomePage', 'wiki', 1218430800, 6),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1218430800, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1218517200, 3),
('HomePage', 'wiki', 1218517200, 5),
('Subversion', 'wiki', 1218517200, 1),
('Networking', 'wiki', 1218517200, 1),
('Linux', 'wiki', 1218517200, 1),
('System', 'wiki', 1218517200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1218517200, 1),
('OS X', 'wiki', 1218517200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1218603600, 1),
('Searching', 'wiki', 1218603600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1218603600, 1),
('HomePage', 'wiki', 1218603600, 4),
('HomePage', 'wiki', 1218690000, 2),
('PERL_Code', 'wiki', 1218690000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1218690000, 1),
('HomePage', 'wiki', 1218776400, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1218776400, 1),
('Networking', 'wiki', 1218776400, 1),
('Scripting', 'wiki', 1218776400, 1),
('PHP', 'wiki', 1218862800, 1),
('Adobe Premier', 'wiki', 1218862800, 1),
('Adobe Photoshop', 'wiki', 1218862800, 1),
('OS X', 'wiki', 1218862800, 1),
('WebSphere', 'wiki', 1218862800, 1),
('PERL_Code', 'wiki', 1218862800, 1),
('HomePage', 'wiki', 1218862800, 1),
('Subversion', 'wiki', 1218862800, 1),
('Quotes', 'wiki', 1218862800, 1),
('Linux', 'wiki', 1218862800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1218949200, 1),
('HomePage', 'wiki', 1218949200, 2),
('HomePage', 'wiki', 1219035600, 1),
('WebSphere', 'wiki', 1219035600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1219035600, 5),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1219035600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1219122000, 1),
('HomePage', 'wiki', 1219122000, 2),
('WebSphere', 'wiki', 1219122000, 1),
('HomePage', 'wiki', 1219208400, 5),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1219208400, 1),
('OS X', 'wiki', 1219208400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1219208400, 2),
('HomePage', 'wiki', 1219294800, 5),
('WebSphere', 'wiki', 1219294800, 1),
('Linux', 'wiki', 1219294800, 2),
('Ubuntu', 'wiki', 1219294800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1219294800, 1),
('Adobe Premier', 'wiki', 1219294800, 2),
('PHP', 'wiki', 1219294800, 1),
('Subversion', 'wiki', 1219294800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1219294800, 4),
('Searching', 'wiki', 1219294800, 1),
('PERL_Code', 'wiki', 1219381200, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1219381200, 1),
('Subversion', 'wiki', 1219381200, 1),
('HomePage', 'wiki', 1219467600, 6),
('Running Processes', 'wiki', 1219467600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1219467600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1219467600, 3),
('HomePage', 'wiki', 1219554000, 5),
('Subversion', 'wiki', 1219554000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1219554000, 1),
('Adobe Premier', 'wiki', 1219640400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1219640400, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1219640400, 3),
('HomePage', 'wiki', 1219640400, 2),
('Subversion', 'wiki', 1219640400, 1),
('HomePage', 'wiki', 1219726800, 20),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1219726800, 3),
('WebSphere', 'wiki', 1219726800, 1),
('Quotes', 'wiki', 1219726800, 1),
('Subversion', 'wiki', 1219726800, 1),
('Rational ClearCase', 'wiki', 1219726800, 8),
('PERL_Code', 'wiki', 1219726800, 1),
('Subversion', 'wiki', 1219813200, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1219813200, 1),
('HomePage', 'wiki', 1219813200, 5),
('OS X', 'wiki', 1219813200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1219813200, 3),
('HomePage', 'wiki', 1219899600, 3),
('WebSphere', 'wiki', 1219899600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1219899600, 1),
('Linux', 'wiki', 1219899600, 1),
('Searching', 'wiki', 1219899600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1219986000, 5),
('HomePage', 'wiki', 1219986000, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1219986000, 1),
('PERL_Code', 'wiki', 1219986000, 2),
('Adobe Photoshop', 'wiki', 1219986000, 1),
('OS X', 'wiki', 1219986000, 1),
('Linux', 'wiki', 1219986000, 1),
('Adobe Photoshop', 'wiki', 1220072400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1220072400, 1),
('Adobe Premier', 'wiki', 1220072400, 1),
('HomePage', 'wiki', 1220072400, 10),
('Subversion', 'wiki', 1220072400, 1),
('HomePage', 'wiki', 1220158800, 5),
('PHP', 'wiki', 1220158800, 1),
('Rational ClearCase', 'wiki', 1220158800, 1),
('HomePage', 'wiki', 1220245200, 4),
('Networking', 'wiki', 1220245200, 1),
('Adobe Premier', 'wiki', 1220245200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1220245200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1220331600, 5),
('HomePage', 'wiki', 1220331600, 3),
('Rational ClearCase', 'wiki', 1220331600, 2),
('WebSphere', 'wiki', 1220331600, 1),
('HomePage', 'wiki', 1220418000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1220418000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1220418000, 3),
('Networking', 'wiki', 1220418000, 1),
('Rational ClearCase', 'wiki', 1220418000, 1),
('HomePage', 'wiki', 1220504400, 6),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1220504400, 1),
('Adobe Premier', 'wiki', 1220504400, 1),
('Quotes', 'wiki', 1220504400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1220504400, 2),
('PHP', 'wiki', 1220504400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1220590800, 2),
('HomePage', 'wiki', 1220590800, 2),
('Rational ClearCase', 'wiki', 1220590800, 1),
('PERL_Code', 'wiki', 1220677200, 1),
('Subversion', 'wiki', 1220677200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1220677200, 3),
('HomePage', 'wiki', 1220677200, 1),
('OS X', 'wiki', 1220677200, 1),
('Linux', 'wiki', 1220763600, 2),
('HomePage', 'wiki', 1220763600, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1220850000, 1),
('HomePage', 'wiki', 1220850000, 3),
('Subversion', 'wiki', 1220850000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1220850000, 1),
('Rational ClearCase', 'wiki', 1220936400, 1),
('HomePage', 'wiki', 1220936400, 3),
('Adobe Premier', 'wiki', 1220936400, 2),
('Samba', 'wiki', 1220936400, 1),
('PHP', 'wiki', 1220936400, 1),
('Subversion', 'wiki', 1220936400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1220936400, 1),
('Adobe Premier', 'wiki', 1221022800, 1),
('HomePage', 'wiki', 1221022800, 6),
('WebSphere', 'wiki', 1221022800, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221022800, 1),
('Linux', 'wiki', 1221022800, 1);
INSERT INTO `tiki_stats` (`object`, `type`, `day`, `hits`) VALUES
('Subversion', 'wiki', 1221022800, 1),
('PHP', 'wiki', 1221022800, 1),
('PERL_Code', 'wiki', 1221022800, 1),
('Rational ClearCase', 'wiki', 1221022800, 1),
('Quotes', 'wiki', 1221022800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1221022800, 2),
('Send Email', 'wiki', 1221022800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221109200, 5),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1221109200, 1),
('HomePage', 'wiki', 1221109200, 2),
('Rational ClearCase', 'wiki', 1221109200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221195600, 1),
('PHP', 'wiki', 1221195600, 1),
('HomePage', 'wiki', 1221195600, 1),
('Networking', 'wiki', 1221195600, 1),
('System', 'wiki', 1221195600, 1),
('Quotes', 'wiki', 1221195600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1221195600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221282000, 2),
('Quotes', 'wiki', 1221282000, 1),
('HomePage', 'wiki', 1221282000, 1),
('Searching', 'wiki', 1221368400, 2),
('Networking', 'wiki', 1221368400, 1),
('Linux', 'wiki', 1221368400, 1),
('System', 'wiki', 1221368400, 1),
('Samba', 'wiki', 1221454800, 1),
('HomePage', 'wiki', 1221454800, 1),
('Rational ClearCase', 'wiki', 1221454800, 4),
('Scripting', 'wiki', 1221454800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221541200, 2),
('Rational ClearCase', 'wiki', 1221541200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1221627600, 2),
('Networking', 'wiki', 1221627600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221714000, 2),
('HomePage', 'wiki', 1221714000, 2),
('Linux', 'wiki', 1221714000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1221714000, 1),
('HomePage', 'wiki', 1221800400, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221800400, 1),
('Subversion', 'wiki', 1221800400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1221800400, 3),
('OS X', 'wiki', 1221800400, 1),
('Linux', 'wiki', 1221800400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1221886800, 1),
('HomePage', 'wiki', 1221886800, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221886800, 1),
('Ubuntu', 'wiki', 1221886800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1221973200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1221973200, 1),
('HomePage', 'wiki', 1221973200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1221973200, 1),
('HomePage', 'wiki', 1222059600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1222059600, 1),
('Rational ClearCase', 'wiki', 1222059600, 3),
('Subversion', 'wiki', 1222059600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1222059600, 3),
('Adobe Premier', 'wiki', 1222146000, 1),
('HomePage', 'wiki', 1222146000, 7),
('File System', 'wiki', 1222146000, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1222146000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1222146000, 1),
('Maintain Users', 'wiki', 1222146000, 1),
('Networking', 'wiki', 1222146000, 1),
('OS X', 'wiki', 1222146000, 1),
('Running Processes', 'wiki', 1222146000, 1),
('Samba', 'wiki', 1222146000, 1),
('Scripting', 'wiki', 1222146000, 1),
('Searching', 'wiki', 1222146000, 1),
('Send Email', 'wiki', 1222146000, 1),
('System', 'wiki', 1222146000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1222146000, 2),
('Ubuntu', 'wiki', 1222146000, 1),
('Quotes', 'wiki', 1222146000, 1),
('Subversion', 'wiki', 1222232400, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1222232400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1222318800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1222318800, 2),
('HomePage', 'wiki', 1222318800, 1),
('HomePage', 'wiki', 1222405200, 7),
('Treo 650 setup with Ubuntu', 'wiki', 1222405200, 2),
('Rational ClearCase', 'wiki', 1222405200, 2),
('Subversion', 'wiki', 1222405200, 2),
('HomePage', 'wiki', 1222491600, 1),
('WebSphere', 'wiki', 1222491600, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1222491600, 1),
('Rational ClearCase', 'wiki', 1222491600, 1),
('HomePage', 'wiki', 1222578000, 9),
('Quotes', 'wiki', 1222578000, 1),
('Linux', 'wiki', 1222578000, 2),
('WebSphere', 'wiki', 1222578000, 1),
('System', 'wiki', 1222578000, 1),
('Subversion', 'wiki', 1222578000, 3),
('PHP', 'wiki', 1222578000, 1),
('Rational ClearCase', 'wiki', 1222578000, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1222578000, 1),
('PERL_Code', 'wiki', 1222578000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1222578000, 2),
('Send Email', 'wiki', 1222664400, 1),
('Samba', 'wiki', 1222664400, 1),
('Maintain Users', 'wiki', 1222664400, 1),
('HomePage', 'wiki', 1222664400, 2),
('Networking', 'wiki', 1222664400, 2),
('Adobe Premier', 'wiki', 1222664400, 1),
('Linux', 'wiki', 1222664400, 7),
('Searching', 'wiki', 1222664400, 1),
('File System', 'wiki', 1222664400, 1),
('System', 'wiki', 1222664400, 1),
('Scripting', 'wiki', 1222664400, 2),
('Running Processes', 'wiki', 1222664400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1222664400, 1),
('Subversion', 'wiki', 1222664400, 1),
('Scripting', 'wiki', 1222750800, 1),
('HomePage', 'wiki', 1222750800, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1222750800, 4),
('HomePage', 'wiki', 1222837200, 2),
('Quotes', 'wiki', 1222837200, 1),
('Networking', 'wiki', 1222837200, 1),
('Linux', 'wiki', 1222837200, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1222837200, 1),
('Running Processes', 'wiki', 1222837200, 1),
('File System', 'wiki', 1222837200, 1),
('Subversion', 'wiki', 1222837200, 2),
('Rational ClearCase', 'wiki', 1222837200, 1),
('OS X', 'wiki', 1222837200, 1),
('Send Email', 'wiki', 1222837200, 1),
('Adobe Premier', 'wiki', 1222837200, 1),
('PHP', 'wiki', 1222837200, 1),
('WebSphere', 'wiki', 1222837200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1222923600, 3),
('System', 'wiki', 1222923600, 4),
('Ubuntu', 'wiki', 1222923600, 1),
('Samba', 'wiki', 1222923600, 1),
('Searching', 'wiki', 1222923600, 1),
('HomePage', 'wiki', 1222923600, 4),
('Linux', 'wiki', 1222923600, 2),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1222923600, 1),
('Scripting', 'wiki', 1222923600, 1),
('Maintain Users', 'wiki', 1222923600, 1),
('Adobe Premier', 'wiki', 1222923600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1222923600, 9),
('HomePage', 'wiki', 1223010000, 5),
('Send Email', 'wiki', 1223010000, 1),
('HomePage', 'wiki', 1223096400, 3),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1223096400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1223096400, 1),
('PHP', 'wiki', 1223182800, 1),
('Linux', 'wiki', 1223182800, 1),
('HomePage', 'wiki', 1223182800, 5),
('PERL_Code', 'wiki', 1223182800, 1),
('Subversion', 'wiki', 1223182800, 1),
('Scripting', 'wiki', 1223182800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1223269200, 3),
('HomePage', 'wiki', 1223269200, 10),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1223269200, 4),
('Maintain Users', 'wiki', 1223269200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1223269200, 4),
('Linux', 'wiki', 1223269200, 6),
('File System', 'wiki', 1223269200, 1),
('Send Email', 'wiki', 1223269200, 1),
('Ubuntu', 'wiki', 1223269200, 1),
('Networking', 'wiki', 1223269200, 1),
('System', 'wiki', 1223269200, 2),
('OS X', 'wiki', 1223269200, 1),
('Subversion', 'wiki', 1223269200, 1),
('PHP', 'wiki', 1223269200, 1),
('WebSphere', 'wiki', 1223269200, 1),
('PERL_Code', 'wiki', 1223269200, 1),
('Rational ClearCase', 'wiki', 1223269200, 1),
('Quotes', 'wiki', 1223269200, 1),
('PERL_Code', 'wiki', 1223355600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1223355600, 4),
('Adobe Premier', 'wiki', 1223355600, 1),
('WebSphere', 'wiki', 1223355600, 1),
('HomePage', 'wiki', 1223355600, 1),
('Linux', 'wiki', 1223355600, 1),
('Send Email', 'wiki', 1223355600, 1),
('File System', 'wiki', 1223355600, 1),
('WebSphere', 'wiki', 1223442000, 1),
('HomePage', 'wiki', 1223442000, 13),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1223442000, 2),
('Linux', 'wiki', 1223442000, 1),
('Subversion', 'wiki', 1223442000, 1),
('HomePage', 'wiki', 1223528400, 5),
('Rational ClearCase', 'wiki', 1223528400, 1),
('Searching', 'wiki', 1223528400, 1),
('System', 'wiki', 1223528400, 1),
('Linux', 'wiki', 1223528400, 1),
('Scripting', 'wiki', 1223528400, 1),
('Quotes', 'wiki', 1223528400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1223528400, 2),
('Networking', 'wiki', 1223528400, 1),
('OS X', 'wiki', 1223528400, 1),
('Subversion', 'wiki', 1223614800, 1),
('PHP', 'wiki', 1223614800, 1),
('Rational ClearCase', 'wiki', 1223614800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1223614800, 1),
('Adobe Premier', 'wiki', 1223614800, 1),
('WebSphere', 'wiki', 1223614800, 1),
('HomePage', 'wiki', 1223701200, 2),
('Rational ClearCase', 'wiki', 1223701200, 1),
('Searching', 'wiki', 1223701200, 1),
('Running Processes', 'wiki', 1223701200, 2),
('Linux', 'wiki', 1223787600, 1),
('Subversion', 'wiki', 1223787600, 1),
('HomePage', 'wiki', 1223787600, 1),
('Ubuntu', 'wiki', 1223787600, 1),
('Adobe Premier', 'wiki', 1223787600, 3),
('Samba', 'wiki', 1223787600, 1),
('PHP', 'wiki', 1223787600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1223874000, 2),
('HomePage', 'wiki', 1223874000, 7),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1223874000, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1223960400, 4),
('HomePage', 'wiki', 1223960400, 5),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1223960400, 1),
('HomePage', 'wiki', 1224046800, 11),
('Treo 650 setup with Ubuntu', 'wiki', 1224046800, 2),
('Linux', 'wiki', 1224046800, 4),
('File System', 'wiki', 1224046800, 1),
('Samba', 'wiki', 1224046800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1224046800, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1224046800, 2),
('Rational ClearCase', 'wiki', 1224046800, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1224133200, 1),
('Adobe Premier', 'wiki', 1224133200, 1),
('Rational ClearCase', 'wiki', 1224133200, 1),
('HomePage', 'wiki', 1224133200, 2),
('PHP', 'wiki', 1224133200, 1),
('PHP', 'wiki', 1226815200, 1),
('OS X', 'wiki', 1226815200, 1),
('Linux', 'wiki', 1226815200, 1),
('Quotes', 'wiki', 1226815200, 1),
('HomePage', 'wiki', 1226815200, 1),
('PERL_Code', 'wiki', 1226815200, 1),
('WebSphere', 'wiki', 1226815200, 1),
('Subversion', 'wiki', 1226815200, 1),
('Rational ClearCase', 'wiki', 1226815200, 1),
('HomePage', 'wiki', 1256097600, 5),
('Rational ClearCase', 'wiki', 1256097600, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1256097600, 1),
('OS X', 'wiki', 1256097600, 1),
('HomePage', 'wiki', 1256184000, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1256184000, 1),
('Networking', 'wiki', 1256184000, 1),
('System', 'wiki', 1256184000, 1),
('HomePage', 'wiki', 1256270400, 3),
('Subversion', 'wiki', 1256270400, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1256356800, 1),
('HomePage', 'wiki', 1256356800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1256443200, 1),
('Linux', 'wiki', 1256529600, 1),
('HomePage', 'wiki', 1256529600, 3),
('WebSphere', 'wiki', 1256529600, 1),
('Subversion', 'wiki', 1256529600, 1),
('Rational ClearCase', 'wiki', 1256529600, 1),
('Quotes', 'wiki', 1256529600, 1),
('PHP', 'wiki', 1256529600, 1),
('PERL_Code', 'wiki', 1256529600, 1),
('HomePage', 'wiki', 1256616000, 3),
('HomePage', 'wiki', 1256702400, 5),
('Rational ClearCase', 'wiki', 1256702400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1256702400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1256702400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1256788800, 2),
('Subversion', 'wiki', 1256788800, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1256788800, 1),
('HomePage', 'wiki', 1256788800, 2),
('Rational ClearCase', 'wiki', 1256788800, 3),
('HomePage', 'wiki', 1256875200, 8),
('Treo 650 setup with Ubuntu', 'wiki', 1256875200, 1),
('HomePage', 'wiki', 1256961600, 3),
('Linux', 'wiki', 1256961600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1256961600, 6),
('HomePage', 'wiki', 1257048000, 5),
('Rational ClearCase', 'wiki', 1257048000, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1257048000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1257048000, 1),
('HomePage', 'wiki', 1257138000, 3),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1257138000, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1257138000, 1),
('HomePage', 'wiki', 1257224400, 2),
('OS X', 'wiki', 1257224400, 1),
('Subversion', 'wiki', 1257224400, 1),
('PHP', 'wiki', 1257224400, 2),
('PERL_Code', 'wiki', 1257224400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1257310800, 4),
('PHP', 'wiki', 1257310800, 2),
('HomePage', 'wiki', 1257310800, 6),
('OS X', 'wiki', 1257310800, 1),
('HomePage', 'wiki', 1257397200, 4),
('Searching', 'wiki', 1257397200, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1257397200, 2),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1257397200, 4),
('Subversion', 'wiki', 1257397200, 2),
('System', 'wiki', 1257397200, 1),
('PERL_Code', 'wiki', 1257397200, 1),
('Quotes', 'wiki', 1257397200, 1),
('OS X', 'wiki', 1257397200, 1),
('Running Processes', 'wiki', 1257397200, 4),
('Rational ClearCase', 'wiki', 1257397200, 1),
('HomePage', 'wiki', 1257483600, 5),
('File System', 'wiki', 1257483600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1257483600, 1),
('Quotes', 'wiki', 1257483600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1257570000, 1),
('HomePage', 'wiki', 1257570000, 4),
('Treo 650 setup with Ubuntu', 'wiki', 1257656400, 1),
('PERL_Code', 'wiki', 1257656400, 1),
('OS X', 'wiki', 1257656400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1257656400, 1),
('Rational ClearCase', 'wiki', 1257656400, 1),
('Subversion', 'wiki', 1257656400, 1),
('System', 'wiki', 1257656400, 1),
('Quotes', 'wiki', 1257656400, 1),
('File System', 'wiki', 1257656400, 1),
('Linux', 'wiki', 1257656400, 1),
('HomePage', 'wiki', 1257656400, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1257742800, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1257742800, 1),
('HomePage', 'wiki', 1257742800, 1),
('Send Email', 'wiki', 1257829200, 1),
('Ubuntu', 'wiki', 1257829200, 1),
('HomePage', 'wiki', 1257829200, 2),
('HomePage', 'wiki', 1257915600, 8),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1257915600, 3),
('Rational ClearCase', 'wiki', 1257915600, 1),
('PERL_Code', 'wiki', 1257915600, 1),
('OS X', 'wiki', 1257915600, 1),
('File System', 'wiki', 1257915600, 1),
('Subversion', 'wiki', 1257915600, 1),
('Ubuntu', 'wiki', 1257915600, 1),
('Adobe Premier', 'wiki', 1257915600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1257915600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1258002000, 1),
('HomePage', 'wiki', 1258002000, 8),
('Treo 650 setup with Ubuntu', 'wiki', 1258002000, 1),
('Adobe Premier', 'wiki', 1258002000, 1),
('Networking', 'wiki', 1258002000, 3),
('Quotes', 'wiki', 1258002000, 1),
('System', 'wiki', 1258002000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1258088400, 3),
('PERL_Code', 'wiki', 1258088400, 1),
('OS X', 'wiki', 1258088400, 1),
('File System', 'wiki', 1258088400, 1),
('Subversion', 'wiki', 1258088400, 1),
('HomePage', 'wiki', 1258088400, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1258088400, 1),
('Rational ClearCase', 'wiki', 1258088400, 1),
('Subversion', 'wiki', 1258174800, 1),
('HomePage', 'wiki', 1258174800, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1258174800, 1),
('WebSphere', 'wiki', 1258174800, 1),
('Maintain Users', 'wiki', 1258261200, 1),
('HomePage', 'wiki', 1258261200, 6),
('HomePage', 'wiki', 1258347600, 5),
('Networking', 'wiki', 1258347600, 1),
('Send Email', 'wiki', 1258347600, 1),
('Samba', 'wiki', 1258347600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1258347600, 1),
('Rational ClearCase', 'wiki', 1258347600, 1),
('Quotes', 'wiki', 1258347600, 1),
('WebSphere', 'wiki', 1258434000, 1),
('Rational ClearCase', 'wiki', 1258434000, 1),
('HomePage', 'wiki', 1258434000, 5),
('Searching', 'wiki', 1258434000, 1),
('WebSphere', 'wiki', 1258520400, 1),
('HomePage', 'wiki', 1258606800, 4),
('WebSphere', 'wiki', 1258606800, 2),
('Treo 650 setup with Ubuntu', 'wiki', 1258606800, 2),
('HomePage', 'wiki', 1258693200, 1),
('Searching', 'wiki', 1258779600, 1),
('Networking', 'wiki', 1258779600, 1),
('Samba', 'wiki', 1258779600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1258779600, 1),
('HomePage', 'wiki', 1258779600, 2),
('Send Email', 'wiki', 1258779600, 1),
('System', 'wiki', 1258779600, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1258779600, 1),
('HomePage', 'wiki', 1258866000, 4),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1258866000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1258866000, 1),
('Quotes', 'wiki', 1258866000, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1258952400, 1),
('HomePage', 'wiki', 1258952400, 1),
('Gateway m675x Radeon 9700m Ubuntu Setup', 'wiki', 1258952400, 1),
('HomePage', 'wiki', 1259038800, 2),
('Subversion', 'wiki', 1259125200, 1),
('Searching', 'wiki', 1259125200, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1259125200, 1),
('HomePage', 'wiki', 1259125200, 2),
('Subversion', 'wiki', 1259211600, 2),
('Scripting', 'wiki', 1259211600, 1),
('Linux', 'wiki', 1259211600, 1),
('File System', 'wiki', 1259211600, 1),
('Highpoint RocketRAID 1820A with Ubuntu', 'wiki', 1259211600, 1),
('Networking', 'wiki', 1259211600, 1),
('Samba', 'wiki', 1259211600, 1),
('System', 'wiki', 1259211600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1259211600, 1),
('HomePage', 'wiki', 1259211600, 1),
('HomePage', 'wiki', 1259298000, 2),
('WebSphere', 'wiki', 1259298000, 1),
('Subversion', 'wiki', 1259298000, 1),
('Rational ClearCase', 'wiki', 1259298000, 1),
('Quotes', 'wiki', 1259298000, 1),
('PHP', 'wiki', 1259298000, 2),
('PERL_Code', 'wiki', 1259298000, 1),
('PHP', 'wiki', 1259384400, 3),
('HomePage', 'wiki', 1259384400, 3),
('Subversion', 'wiki', 1259384400, 2),
('PHP', 'wiki', 1259470800, 1),
('HomePage', 'wiki', 1259470800, 4),
('Linux', 'wiki', 1259470800, 1),
('File System', 'wiki', 1259470800, 1),
('Samba', 'wiki', 1259470800, 1),
('HomePage', 'wiki', 1259557200, 3),
('Treo 650 setup with Ubuntu', 'wiki', 1259557200, 1),
('File System', 'wiki', 1259557200, 1),
('HomePage', 'wiki', 1259643600, 1),
('Treo 650 setup with Ubuntu', 'wiki', 1259643600, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tiki_structure_versions`
--

CREATE TABLE IF NOT EXISTS `tiki_structure_versions` (
  `structure_id` int(14) NOT NULL auto_increment,
  `version` int(14) default NULL,
  PRIMARY KEY  (`structure_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_structure_versions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_structures`
--

CREATE TABLE IF NOT EXISTS `tiki_structures` (
  `page_ref_id` int(14) NOT NULL auto_increment,
  `structure_id` int(14) NOT NULL default '0',
  `parent_id` int(14) default NULL,
  `page_id` int(14) NOT NULL default '0',
  `page_version` int(8) default NULL,
  `page_alias` varchar(240) NOT NULL default '',
  `pos` int(4) default NULL,
  PRIMARY KEY  (`page_ref_id`),
  KEY `pidpaid` (`page_id`,`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_structures`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_submissions`
--

CREATE TABLE IF NOT EXISTS `tiki_submissions` (
  `subId` int(8) NOT NULL auto_increment,
  `topline` varchar(255) default NULL,
  `title` varchar(80) default NULL,
  `subtitle` varchar(255) default NULL,
  `linkto` varchar(255) default NULL,
  `lang` varchar(16) default NULL,
  `authorName` varchar(60) default NULL,
  `topicId` int(14) default NULL,
  `topicName` varchar(40) default NULL,
  `size` int(12) default NULL,
  `useImage` char(1) default NULL,
  `image_name` varchar(80) default NULL,
  `image_caption` text,
  `image_type` varchar(80) default NULL,
  `image_size` int(14) default NULL,
  `image_x` int(4) default NULL,
  `image_y` int(4) default NULL,
  `image_data` longblob,
  `publishDate` int(14) default NULL,
  `expireDate` int(14) default NULL,
  `created` int(14) default NULL,
  `bibliographical_references` text,
  `resume` text,
  `heading` text,
  `body` text,
  `hash` varchar(32) default NULL,
  `author` varchar(200) default NULL,
  `nbreads` int(14) default NULL,
  `votes` int(8) default NULL,
  `points` int(14) default NULL,
  `type` varchar(50) default NULL,
  `rating` decimal(3,2) default NULL,
  `isfloat` char(1) default NULL,
  PRIMARY KEY  (`subId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_submissions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_suggested_faq_questions`
--

CREATE TABLE IF NOT EXISTS `tiki_suggested_faq_questions` (
  `sfqId` int(10) NOT NULL auto_increment,
  `faqId` int(10) NOT NULL default '0',
  `question` text,
  `answer` text,
  `created` int(14) default NULL,
  `user` varchar(40) default NULL,
  PRIMARY KEY  (`sfqId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_suggested_faq_questions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_survey_question_options`
--

CREATE TABLE IF NOT EXISTS `tiki_survey_question_options` (
  `optionId` int(12) NOT NULL auto_increment,
  `questionId` int(12) NOT NULL default '0',
  `qoption` text,
  `votes` int(10) default NULL,
  PRIMARY KEY  (`optionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_survey_question_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_survey_questions`
--

CREATE TABLE IF NOT EXISTS `tiki_survey_questions` (
  `questionId` int(12) NOT NULL auto_increment,
  `surveyId` int(12) NOT NULL default '0',
  `question` text,
  `options` text,
  `type` char(1) default NULL,
  `position` int(5) default NULL,
  `votes` int(10) default NULL,
  `value` int(10) default NULL,
  `average` decimal(4,2) default NULL,
  PRIMARY KEY  (`questionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_survey_questions`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_surveys`
--

CREATE TABLE IF NOT EXISTS `tiki_surveys` (
  `surveyId` int(12) NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  `description` text,
  `taken` int(10) default NULL,
  `lastTaken` int(14) default NULL,
  `created` int(14) default NULL,
  `status` char(1) default NULL,
  PRIMARY KEY  (`surveyId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_surveys`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_tags`
--

CREATE TABLE IF NOT EXISTS `tiki_tags` (
  `tagName` varchar(80) NOT NULL default '',
  `pageName` varchar(160) NOT NULL default '',
  `hits` int(8) default NULL,
  `description` varchar(200) default NULL,
  `data` longblob,
  `lastModif` int(14) default NULL,
  `comment` varchar(200) default NULL,
  `version` int(8) NOT NULL default '0',
  `user` varchar(40) default NULL,
  `ip` varchar(15) default NULL,
  `flag` char(1) default NULL,
  PRIMARY KEY  (`tagName`,`pageName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_tags`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_theme_control_categs`
--

CREATE TABLE IF NOT EXISTS `tiki_theme_control_categs` (
  `categId` int(12) NOT NULL default '0',
  `theme` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`categId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_theme_control_categs`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_theme_control_objects`
--

CREATE TABLE IF NOT EXISTS `tiki_theme_control_objects` (
  `objId` varchar(250) NOT NULL default '',
  `type` varchar(250) NOT NULL default '',
  `name` varchar(250) NOT NULL default '',
  `theme` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`objId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_theme_control_objects`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_theme_control_sections`
--

CREATE TABLE IF NOT EXISTS `tiki_theme_control_sections` (
  `section` varchar(250) NOT NULL default '',
  `theme` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`section`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_theme_control_sections`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_topics`
--

CREATE TABLE IF NOT EXISTS `tiki_topics` (
  `topicId` int(14) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `image_name` varchar(80) default NULL,
  `image_type` varchar(80) default NULL,
  `image_size` int(14) default NULL,
  `image_data` longblob,
  `active` char(1) default NULL,
  `created` int(14) default NULL,
  PRIMARY KEY  (`topicId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_topics`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_tracker_fields`
--

CREATE TABLE IF NOT EXISTS `tiki_tracker_fields` (
  `fieldId` int(12) NOT NULL auto_increment,
  `trackerId` int(12) NOT NULL default '0',
  `name` varchar(255) default NULL,
  `options` text,
  `type` char(1) default NULL,
  `isMain` char(1) default NULL,
  `isTblVisible` char(1) default NULL,
  `position` int(4) default NULL,
  `isSearchable` char(1) NOT NULL default 'y',
  `isPublic` char(1) NOT NULL default 'n',
  `isHidden` char(1) NOT NULL default 'n',
  `isMandatory` char(1) NOT NULL default 'n',
  PRIMARY KEY  (`fieldId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_tracker_fields`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_tracker_item_attachments`
--

CREATE TABLE IF NOT EXISTS `tiki_tracker_item_attachments` (
  `attId` int(12) NOT NULL auto_increment,
  `itemId` int(12) NOT NULL default '0',
  `filename` varchar(80) default NULL,
  `filetype` varchar(80) default NULL,
  `filesize` int(14) default NULL,
  `user` varchar(40) default NULL,
  `data` longblob,
  `path` varchar(255) default NULL,
  `downloads` int(10) default NULL,
  `created` int(14) default NULL,
  `comment` varchar(250) default NULL,
  `longdesc` blob,
  `version` varchar(40) default NULL,
  PRIMARY KEY  (`attId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_tracker_item_attachments`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_tracker_item_comments`
--

CREATE TABLE IF NOT EXISTS `tiki_tracker_item_comments` (
  `commentId` int(12) NOT NULL auto_increment,
  `itemId` int(12) NOT NULL default '0',
  `user` varchar(40) default NULL,
  `data` text,
  `title` varchar(200) default NULL,
  `posted` int(14) default NULL,
  PRIMARY KEY  (`commentId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_tracker_item_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_tracker_item_fields`
--

CREATE TABLE IF NOT EXISTS `tiki_tracker_item_fields` (
  `itemId` int(12) NOT NULL default '0',
  `fieldId` int(12) NOT NULL default '0',
  `value` text,
  PRIMARY KEY  (`itemId`,`fieldId`),
  FULLTEXT KEY `ft` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_tracker_item_fields`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_tracker_items`
--

CREATE TABLE IF NOT EXISTS `tiki_tracker_items` (
  `itemId` int(12) NOT NULL auto_increment,
  `trackerId` int(12) NOT NULL default '0',
  `created` int(14) default NULL,
  `status` char(1) default NULL,
  `lastModif` int(14) default NULL,
  PRIMARY KEY  (`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_tracker_items`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_tracker_options`
--

CREATE TABLE IF NOT EXISTS `tiki_tracker_options` (
  `trackerId` int(12) NOT NULL default '0',
  `name` varchar(80) NOT NULL default '',
  `value` text,
  PRIMARY KEY  (`trackerId`,`name`(30))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_tracker_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_trackers`
--

CREATE TABLE IF NOT EXISTS `tiki_trackers` (
  `trackerId` int(12) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `created` int(14) default NULL,
  `lastModif` int(14) default NULL,
  `showCreated` char(1) default NULL,
  `showStatus` char(1) default NULL,
  `showLastModif` char(1) default NULL,
  `useComments` char(1) default NULL,
  `useAttachments` char(1) default NULL,
  `items` int(10) default NULL,
  `showComments` char(1) default NULL,
  `showAttachments` char(1) default NULL,
  `orderAttachments` varchar(255) NOT NULL default 'filename,created,filesize,downloads,desc',
  PRIMARY KEY  (`trackerId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_trackers`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_translated_objects`
--

CREATE TABLE IF NOT EXISTS `tiki_translated_objects` (
  `traId` int(14) NOT NULL auto_increment,
  `type` varchar(50) NOT NULL default '',
  `objId` varchar(255) NOT NULL default '',
  `lang` varchar(16) default NULL,
  PRIMARY KEY  (`type`,`objId`),
  KEY `traId` (`traId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_translated_objects`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_untranslated`
--

CREATE TABLE IF NOT EXISTS `tiki_untranslated` (
  `id` int(14) NOT NULL auto_increment,
  `source` tinyblob NOT NULL,
  `lang` varchar(16) NOT NULL default '',
  PRIMARY KEY  (`source`(255),`lang`),
  UNIQUE KEY `id` (`id`),
  KEY `id_2` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_untranslated`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_answers`
--

CREATE TABLE IF NOT EXISTS `tiki_user_answers` (
  `userResultId` int(10) NOT NULL default '0',
  `quizId` int(10) NOT NULL default '0',
  `questionId` int(10) NOT NULL default '0',
  `optionId` int(10) NOT NULL default '0',
  PRIMARY KEY  (`userResultId`,`quizId`,`questionId`,`optionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_answers`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_answers_uploads`
--

CREATE TABLE IF NOT EXISTS `tiki_user_answers_uploads` (
  `answerUploadId` int(4) NOT NULL auto_increment,
  `userResultId` int(11) NOT NULL default '0',
  `questionId` int(11) NOT NULL default '0',
  `filename` varchar(255) NOT NULL default '',
  `filetype` varchar(64) NOT NULL default '',
  `filesize` varchar(255) NOT NULL default '',
  `filecontent` longblob NOT NULL,
  PRIMARY KEY  (`answerUploadId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_answers_uploads`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_assigned_modules`
--

CREATE TABLE IF NOT EXISTS `tiki_user_assigned_modules` (
  `name` varchar(200) NOT NULL default '',
  `position` char(1) default NULL,
  `ord` int(4) default NULL,
  `type` char(1) default NULL,
  `user` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`name`,`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_assigned_modules`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_bookmarks_folders`
--

CREATE TABLE IF NOT EXISTS `tiki_user_bookmarks_folders` (
  `folderId` int(12) NOT NULL auto_increment,
  `parentId` int(12) default NULL,
  `user` varchar(40) NOT NULL default '',
  `name` varchar(30) default NULL,
  PRIMARY KEY  (`user`,`folderId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_bookmarks_folders`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_bookmarks_urls`
--

CREATE TABLE IF NOT EXISTS `tiki_user_bookmarks_urls` (
  `urlId` int(12) NOT NULL auto_increment,
  `name` varchar(30) default NULL,
  `url` varchar(250) default NULL,
  `data` longblob,
  `lastUpdated` int(14) default NULL,
  `folderId` int(12) NOT NULL default '0',
  `user` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`urlId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_bookmarks_urls`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_mail_accounts`
--

CREATE TABLE IF NOT EXISTS `tiki_user_mail_accounts` (
  `accountId` int(12) NOT NULL auto_increment,
  `user` varchar(40) NOT NULL default '',
  `account` varchar(50) NOT NULL default '',
  `pop` varchar(255) default NULL,
  `current` char(1) default NULL,
  `port` int(4) default NULL,
  `username` varchar(100) default NULL,
  `pass` varchar(100) default NULL,
  `msgs` int(4) default NULL,
  `smtp` varchar(255) default NULL,
  `useAuth` char(1) default NULL,
  `smtpPort` int(4) default NULL,
  PRIMARY KEY  (`accountId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_mail_accounts`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_menus`
--

CREATE TABLE IF NOT EXISTS `tiki_user_menus` (
  `user` varchar(40) NOT NULL default '',
  `menuId` int(12) NOT NULL auto_increment,
  `url` varchar(250) default NULL,
  `name` varchar(40) default NULL,
  `position` int(4) default NULL,
  `mode` char(1) default NULL,
  PRIMARY KEY  (`menuId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_menus`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_modules`
--

CREATE TABLE IF NOT EXISTS `tiki_user_modules` (
  `name` varchar(200) NOT NULL default '',
  `title` varchar(40) default NULL,
  `data` longblob,
  `parse` char(1) default NULL,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_modules`
--

INSERT INTO `tiki_user_modules` (`name`, `title`, `data`, `parse`) VALUES
('mnu_application_menu', 'Menu', 0x7b6d656e752069643d34327d, 'n');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_notes`
--

CREATE TABLE IF NOT EXISTS `tiki_user_notes` (
  `user` varchar(40) NOT NULL default '',
  `noteId` int(12) NOT NULL auto_increment,
  `created` int(14) default NULL,
  `name` varchar(255) default NULL,
  `lastModif` int(14) default NULL,
  `data` text,
  `size` int(14) default NULL,
  `parse_mode` varchar(20) default NULL,
  PRIMARY KEY  (`noteId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_postings`
--

CREATE TABLE IF NOT EXISTS `tiki_user_postings` (
  `user` varchar(40) NOT NULL default '',
  `posts` int(12) default NULL,
  `last` int(14) default NULL,
  `first` int(14) default NULL,
  `level` int(8) default NULL,
  PRIMARY KEY  (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_postings`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_preferences`
--

CREATE TABLE IF NOT EXISTS `tiki_user_preferences` (
  `user` varchar(40) NOT NULL default '',
  `prefName` varchar(40) NOT NULL default '',
  `value` varchar(250) default NULL,
  PRIMARY KEY  (`user`,`prefName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_preferences`
--

INSERT INTO `tiki_user_preferences` (`user`, `prefName`, `value`) VALUES
('admin', 'realName', 'System Administrator'),
('c8h10n4o2', 'theme', 'boreal.css'),
('c8h10n4o2', 'language', 'en'),
('c8h10n4o2', 'display_timezone', 'Local'),
('c8h10n4o2', 'user_information', 'public'),
('c8h10n4o2', 'user_dbl', 'y'),
('c8h10n4o2', 'diff_versions', 'n'),
('c8h10n4o2', 'email is public', 'n'),
('c8h10n4o2', 'mailCharset', 'utf-8'),
('c8h10n4o2', 'userbreadCrumb', '10');

-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_quizzes`
--

CREATE TABLE IF NOT EXISTS `tiki_user_quizzes` (
  `user` varchar(40) default NULL,
  `quizId` int(10) default NULL,
  `timestamp` int(14) default NULL,
  `timeTaken` int(14) default NULL,
  `points` int(12) default NULL,
  `maxPoints` int(12) default NULL,
  `resultId` int(10) default NULL,
  `userResultId` int(10) NOT NULL auto_increment,
  PRIMARY KEY  (`userResultId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_quizzes`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_taken_quizzes`
--

CREATE TABLE IF NOT EXISTS `tiki_user_taken_quizzes` (
  `user` varchar(40) NOT NULL default '',
  `quizId` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`user`,`quizId`(100))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_taken_quizzes`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_tasks`
--

CREATE TABLE IF NOT EXISTS `tiki_user_tasks` (
  `taskId` int(14) NOT NULL auto_increment,
  `last_version` int(4) NOT NULL default '0',
  `user` varchar(40) NOT NULL default '',
  `creator` varchar(200) NOT NULL default '',
  `public_for_group` varchar(30) default NULL,
  `rights_by_creator` char(1) default NULL,
  `created` int(14) NOT NULL default '0',
  `status` char(1) default NULL,
  `priority` int(2) default NULL,
  `completed` int(14) default NULL,
  `percentage` int(4) default NULL,
  PRIMARY KEY  (`taskId`),
  UNIQUE KEY `creator` (`creator`,`created`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_user_tasks`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_tasks_history`
--

CREATE TABLE IF NOT EXISTS `tiki_user_tasks_history` (
  `belongs_to` int(14) NOT NULL default '0',
  `task_version` int(4) NOT NULL default '0',
  `title` varchar(250) NOT NULL default '',
  `description` text,
  `start` int(14) default NULL,
  `end` int(14) default NULL,
  `lasteditor` varchar(200) NOT NULL default '',
  `lastchanges` int(14) NOT NULL default '0',
  `priority` int(2) NOT NULL default '3',
  `completed` int(14) default NULL,
  `deleted` int(14) default NULL,
  `status` char(1) default NULL,
  `percentage` int(4) default NULL,
  `accepted_creator` char(1) default NULL,
  `accepted_user` char(1) default NULL,
  PRIMARY KEY  (`belongs_to`,`task_version`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_tasks_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_votings`
--

CREATE TABLE IF NOT EXISTS `tiki_user_votings` (
  `user` varchar(40) NOT NULL default '',
  `id` varchar(255) NOT NULL default '',
  `optionId` int(10) NOT NULL default '0',
  PRIMARY KEY  (`user`,`id`(100))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_votings`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_user_watches`
--

CREATE TABLE IF NOT EXISTS `tiki_user_watches` (
  `user` varchar(40) NOT NULL default '',
  `event` varchar(40) NOT NULL default '',
  `object` varchar(200) NOT NULL default '',
  `hash` varchar(32) default NULL,
  `title` varchar(250) default NULL,
  `type` varchar(200) default NULL,
  `url` varchar(250) default NULL,
  `email` varchar(200) default NULL,
  PRIMARY KEY  (`user`,`event`,`object`(100))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_user_watches`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_userfiles`
--

CREATE TABLE IF NOT EXISTS `tiki_userfiles` (
  `user` varchar(40) NOT NULL default '',
  `fileId` int(12) NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  `filename` varchar(200) default NULL,
  `filetype` varchar(200) default NULL,
  `filesize` varchar(200) default NULL,
  `data` longblob,
  `hits` int(8) default NULL,
  `isFile` char(1) default NULL,
  `path` varchar(255) default NULL,
  `created` int(14) default NULL,
  PRIMARY KEY  (`fileId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_userfiles`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_userpoints`
--

CREATE TABLE IF NOT EXISTS `tiki_userpoints` (
  `user` varchar(40) default NULL,
  `points` decimal(8,2) default NULL,
  `voted` int(8) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_userpoints`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_users`
--

CREATE TABLE IF NOT EXISTS `tiki_users` (
  `user` varchar(40) NOT NULL default '',
  `password` varchar(40) default NULL,
  `email` varchar(200) default NULL,
  `lastLogin` int(14) default NULL,
  PRIMARY KEY  (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_users`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_users_score`
--

CREATE TABLE IF NOT EXISTS `tiki_users_score` (
  `user` char(40) NOT NULL default '',
  `event_id` char(40) NOT NULL default '',
  `expire` int(14) NOT NULL default '0',
  `tstamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`user`,`event_id`),
  KEY `user` (`user`,`event_id`,`expire`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_users_score`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_webmail_contacts`
--

CREATE TABLE IF NOT EXISTS `tiki_webmail_contacts` (
  `contactId` int(12) NOT NULL auto_increment,
  `firstName` varchar(80) default NULL,
  `lastName` varchar(80) default NULL,
  `email` varchar(250) default NULL,
  `nickname` varchar(200) default NULL,
  `user` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`contactId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_webmail_contacts`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_webmail_messages`
--

CREATE TABLE IF NOT EXISTS `tiki_webmail_messages` (
  `accountId` int(12) NOT NULL default '0',
  `mailId` varchar(255) NOT NULL default '',
  `user` varchar(40) NOT NULL default '',
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  PRIMARY KEY  (`accountId`,`mailId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_webmail_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_wiki_attachments`
--

CREATE TABLE IF NOT EXISTS `tiki_wiki_attachments` (
  `attId` int(12) NOT NULL auto_increment,
  `page` varchar(200) NOT NULL default '',
  `filename` varchar(80) default NULL,
  `filetype` varchar(80) default NULL,
  `filesize` int(14) default NULL,
  `user` varchar(40) default NULL,
  `data` longblob,
  `path` varchar(255) default NULL,
  `downloads` int(10) default NULL,
  `created` int(14) default NULL,
  `comment` varchar(250) default NULL,
  PRIMARY KEY  (`attId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tiki_wiki_attachments`
--


-- --------------------------------------------------------

--
-- Table structure for table `tiki_zones`
--

CREATE TABLE IF NOT EXISTS `tiki_zones` (
  `zone` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`zone`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiki_zones`
--


-- --------------------------------------------------------

--
-- Table structure for table `users_grouppermissions`
--

CREATE TABLE IF NOT EXISTS `users_grouppermissions` (
  `groupName` varchar(255) NOT NULL default '',
  `permName` varchar(30) NOT NULL default '',
  `value` char(1) default '',
  PRIMARY KEY  (`groupName`(30),`permName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_grouppermissions`
--

INSERT INTO `users_grouppermissions` (`groupName`, `permName`, `value`) VALUES
('Anonymous', 'tiki_p_view', ''),
('Anonymous', 'tiki_p_wiki_view_history', ''),
('Anonymous', 'tiki_p_wiki_view_comments', ''),
('Registered', 'tiki_p_blog_admin', ''),
('Registered', 'tiki_p_create_blogs', ''),
('Registered', 'tiki_p_read_blog', ''),
('Registered', 'tiki_p_edit_submission', ''),
('Registered', 'tiki_p_approve_submission', ''),
('Registered', 'tiki_p_submit_article', ''),
('Registered', 'tiki_p_read_article', ''),
('Registered', 'tiki_p_remove_article', ''),
('Registered', 'tiki_p_edit_article', ''),
('Registered', 'tiki_p_remove_submission', ''),
('Registered', 'tiki_p_view_directory', ''),
('Registered', 'tiki_p_admin_directory_cats', ''),
('Registered', 'tiki_p_submit_link', ''),
('Registered', 'tiki_p_admin_directory_sites', ''),
('Registered', 'tiki_p_admin_directory', ''),
('Registered', 'tiki_p_create_file_galleries', ''),
('Registered', 'tiki_p_download_files', ''),
('Registered', 'tiki_p_upload_files', ''),
('Registered', 'tiki_p_view_file_gallery', ''),
('Registered', 'tiki_p_admin_file_galleries', ''),
('Registered', 'tiki_p_view_html_pages', ''),
('Registered', 'tiki_p_edit_html_pages', ''),
('Registered', 'tiki_p_view_templates', ''),
('Registered', 'tiki_p_view_stats', ''),
('Registered', 'tiki_p_view_categories', ''),
('Registered', 'tiki_p_use_HTML', ''),
('Registered', 'tiki_p_admin_categories', ''),
('Registered', 'tiki_p_rename', ''),
('Registered', 'tiki_p_wiki_view_attachments', ''),
('Registered', 'tiki_p_wiki_attach_files', ''),
('Registered', 'tiki_p_wiki_admin_ratings', ''),
('Registered', 'tiki_p_remove', ''),
('Registered', 'tiki_p_minor', ''),
('Registered', 'tiki_p_upload_picture', ''),
('Registered', 'tiki_p_edit', ''),
('Registered', 'tiki_p_lock', ''),
('Registered', 'tiki_p_edit_structures', ''),
('Registered', 'tiki_p_rollback', '');

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
  `groupName` varchar(255) NOT NULL default '',
  `groupDesc` varchar(255) default NULL,
  `groupHome` varchar(255) default NULL,
  `usersTrackerId` int(11) default NULL,
  `groupTrackerId` int(11) default NULL,
  `usersFieldId` int(11) default NULL,
  `groupFieldId` int(11) default NULL,
  PRIMARY KEY  (`groupName`(30))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`groupName`, `groupDesc`, `groupHome`, `usersTrackerId`, `groupTrackerId`, `usersFieldId`, `groupFieldId`) VALUES
('Anonymous', 'Public users not logged', NULL, NULL, NULL, NULL, NULL),
('Registered', 'Users logged into the system', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_objectpermissions`
--

CREATE TABLE IF NOT EXISTS `users_objectpermissions` (
  `groupName` varchar(255) NOT NULL default '',
  `permName` varchar(30) NOT NULL default '',
  `objectType` varchar(20) NOT NULL default '',
  `objectId` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`objectId`,`objectType`,`groupName`(30),`permName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_objectpermissions`
--


-- --------------------------------------------------------

--
-- Table structure for table `users_permissions`
--

CREATE TABLE IF NOT EXISTS `users_permissions` (
  `permName` varchar(30) NOT NULL default '',
  `permDesc` varchar(250) default NULL,
  `level` varchar(80) default NULL,
  `type` varchar(20) default NULL,
  PRIMARY KEY  (`permName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_permissions`
--

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`) VALUES
('tiki_p_abort_instance', 'Can abort a process instance', 'editors', 'workflow'),
('tiki_p_access_closed_site', 'Can access site when closed', 'admin', 'tiki'),
('tiki_p_add_events', 'Can add events in the calendar', 'registered', 'calendar'),
('tiki_p_admin', 'Administrator, can manage users groups and permissions, Hotwords and all the weblog features', 'admin', 'tiki'),
('tiki_p_admin_banners', 'Administrator, can admin banners', 'admin', 'tiki'),
('tiki_p_admin_banning', 'Can ban users or ips', 'admin', 'tiki'),
('tiki_p_admin_calendar', 'Can create/admin calendars', 'admin', 'calendar'),
('tiki_p_admin_categories', 'Can admin categories', 'editors', 'tiki'),
('tiki_p_admin_charts', 'Can admin charts', 'admin', 'charts'),
('tiki_p_admin_chat', 'Administrator, can create channels remove channels etc', 'editors', 'chat'),
('tiki_p_admin_cms', 'Can admin the cms', 'editors', 'cms'),
('tiki_p_admin_directory', 'Can admin the directory', 'editors', 'directory'),
('tiki_p_admin_directory_cats', 'Can admin directory categories', 'editors', 'directory'),
('tiki_p_admin_directory_sites', 'Can admin directory sites', 'editors', 'directory'),
('tiki_p_admin_drawings', 'Can admin drawings', 'editors', 'drawings'),
('tiki_p_admin_dynamic', 'Can admin the dynamic content system', 'editors', 'tiki'),
('tiki_p_admin_faqs', 'Can admin faqs', 'editors', 'faqs'),
('tiki_p_admin_file_galleries', 'Can admin file galleries', 'editors', 'file galleries'),
('tiki_p_admin_forum', 'Can admin forums', 'editors', 'forums'),
('tiki_p_admin_galleries', 'Can admin Image Galleries', 'editors', 'image galleries'),
('tiki_p_admin_games', 'Can admin games', 'editors', 'games'),
('tiki_p_admin_integrator', 'Can admin integrator repositories and rules', 'admin', 'tiki'),
('tiki_p_admin_mailin', 'Can admin mail-in accounts', 'admin', 'tiki'),
('tiki_p_admin_newsletters', 'Can admin newsletters', 'admin', 'newsletters'),
('tiki_p_admin_objects', 'Can edit object permissions', 'admin', 'tiki'),
('tiki_p_admin_polls', 'Can admin polls', 'admin', 'tiki'),
('tiki_p_admin_quizzes', 'Can admin quizzes', 'editors', 'quizzes'),
('tiki_p_admin_received_articles', 'Can admin received articles', 'editors', 'comm'),
('tiki_p_admin_received_pages', 'Can admin received pages', 'editors', 'comm'),
('tiki_p_admin_rssmodules', 'Can admin rss modules', 'admin', 'tiki'),
('tiki_p_admin_sheet', 'Can admin sheet', 'admin', 'sheet'),
('tiki_p_admin_shoutbox', 'Can admin shoutbox (Edit/remove msgs)', 'editors', 'shoutbox'),
('tiki_p_admin_surveys', 'Can admin surveys', 'editors', 'surveys'),
('tiki_p_admin_trackers', 'Can admin trackers', 'editors', 'trackers'),
('tiki_p_admin_users', 'Can admin users', 'admin', 'user'),
('tiki_p_admin_wiki', 'Can admin the wiki', 'editors', 'wiki'),
('tiki_p_admin_workflow', 'Can admin workflow processes', 'admin', 'workflow'),
('tiki_p_approve_submission', 'Can approve submissions', 'editors', 'cms'),
('tiki_p_attach_trackers', 'Can attach files to tracker items', 'registered', 'trackers'),
('tiki_p_autoapprove_submission', 'Submited articles automatically approved', 'editors', 'cms'),
('tiki_p_autosubmit_link', 'Submited links are valid', 'editors', 'directory'),
('tiki_p_autoval_chart_suggestio', 'Autovalidate suggestions', 'editors', 'charts'),
('tiki_p_batch_upload_files', 'Can upload zip files with files', 'editors', 'file galleries'),
('tiki_p_batch_upload_image_dir', 'Can use Directory Batch Load', 'editors', 'image galleries'),
('tiki_p_batch_upload_images', 'Can upload zip files with images', 'editors', 'image galleries'),
('tiki_p_blog_admin', 'Can admin blogs', 'editors', 'blogs'),
('tiki_p_blog_post', 'Can post to a blog', 'registered', 'blogs'),
('tiki_p_broadcast', 'Can broadcast messages to groups', 'admin', 'messu'),
('tiki_p_broadcast_all', 'Can broadcast messages to all user', 'admin', 'messu'),
('tiki_p_cache_bookmarks', 'Can cache user bookmarks', 'admin', 'user'),
('tiki_p_change_events', 'Can change events in the calendar', 'registered', 'calendar'),
('tiki_p_chat', 'Can use the chat system', 'registered', 'chat'),
('tiki_p_comment_tracker_items', 'Can insert comments for tracker items', 'basic', 'trackers'),
('tiki_p_configure_modules', 'Can configure modules', 'registered', 'user'),
('tiki_p_create_blogs', 'Can create a blog', 'editors', 'blogs'),
('tiki_p_create_bookmarks', 'Can create user bookmarks', 'registered', 'user'),
('tiki_p_create_css', 'Can create new css suffixed with -user', 'registered', 'tiki'),
('tiki_p_create_file_galleries', 'Can create file galleries', 'editors', 'file galleries'),
('tiki_p_create_galleries', 'Can create image galleries', 'editors', 'image galleries'),
('tiki_p_create_tracker_items', 'Can create new items for trackers', 'registered', 'trackers'),
('tiki_p_download_files', 'Can download files', 'basic', 'file galleries'),
('tiki_p_edit', 'Can edit pages', 'registered', 'wiki'),
('tiki_p_edit_article', 'Can edit articles', 'editors', 'cms'),
('tiki_p_edit_comments', 'Can edit all comments', 'editors', 'comments'),
('tiki_p_edit_content_templates', 'Can edit content templates', 'editors', 'content templates'),
('tiki_p_edit_cookies', 'Can admin cookies', 'editors', 'tiki'),
('tiki_p_edit_copyrights', 'Can edit copyright notices', 'editors', 'wiki'),
('tiki_p_edit_drawings', 'Can edit drawings', 'basic', 'drawings'),
('tiki_p_edit_dynvar', 'Can edit dynamic variables', 'editors', 'wiki'),
('tiki_p_edit_html_pages', 'Can edit HTML pages', 'editors', 'html pages'),
('tiki_p_edit_languages', 'Can edit translations and create new languages', 'editors', 'tiki'),
('tiki_p_edit_sheet', 'Can create and edit sheets', 'editors', 'sheet'),
('tiki_p_edit_structures', 'Can create and edit structures', 'editors', 'wiki'),
('tiki_p_edit_submission', 'Can edit submissions', 'editors', 'cms'),
('tiki_p_edit_templates', 'Can edit site templates', 'admin', 'tiki'),
('tiki_p_eph_admin', 'Can admin ephemerides', 'editors', 'tiki'),
('tiki_p_exception_instance', 'Can declare an instance as exception', 'registered', 'workflow'),
('tiki_p_forum_attach', 'Can attach to forum posts', 'registered', 'forums'),
('tiki_p_forum_autoapp', 'Auto approve forum posts', 'editors', 'forums'),
('tiki_p_forum_post', 'Can post in forums', 'registered', 'forums'),
('tiki_p_forum_post_topic', 'Can start threads in forums', 'registered', 'forums'),
('tiki_p_forum_read', 'Can read forums', 'basic', 'forums'),
('tiki_p_forum_vote', 'Can vote comments in forums', 'registered', 'forums'),
('tiki_p_forums_report', 'Can report msgs to moderator', 'registered', 'forums'),
('tiki_p_list_users', 'Can list registered users', 'registered', 'community'),
('tiki_p_live_support', 'Can use live support system', 'basic', 'support'),
('tiki_p_live_support_admin', 'Admin live support system', 'admin', 'support'),
('tiki_p_lock', 'Can lock pages', 'editors', 'wiki'),
('tiki_p_map_create', 'Can create new mapfile', 'admin', 'maps'),
('tiki_p_map_delete', 'Can delete mapfiles', 'admin', 'maps'),
('tiki_p_map_edit', 'Can edit mapfiles', 'editors', 'maps'),
('tiki_p_map_view', 'Can view mapfiles', 'basic', 'maps'),
('tiki_p_map_view_mapfiles', 'Can view contents of mapfiles', 'registered', 'maps'),
('tiki_p_messages', 'Can use the messaging system', 'registered', 'messu'),
('tiki_p_minical', 'Can use the mini event calendar', 'registered', 'user'),
('tiki_p_minor', 'Can save as minor edit', 'registered', 'wiki'),
('tiki_p_modify_tracker_items', 'Can change tracker items', 'registered', 'trackers'),
('tiki_p_newsreader', 'Can use the newsreader', 'registered', 'user'),
('tiki_p_notepad', 'Can use the notepad', 'registered', 'user'),
('tiki_p_play_games', 'Can play games', 'basic', 'games'),
('tiki_p_post_comments', 'Can post new comments', 'registered', 'comments'),
('tiki_p_post_shoutbox', 'Can post messages in shoutbox', 'basic', 'shoutbox'),
('tiki_p_read_article', 'Can read articles', 'basic', 'cms'),
('tiki_p_read_blog', 'Can read blogs', 'basic', 'blogs'),
('tiki_p_read_comments', 'Can read comments', 'basic', 'comments'),
('tiki_p_remove', 'Can remove', 'editors', 'wiki'),
('tiki_p_remove_article', 'Can remove articles', 'editors', 'cms'),
('tiki_p_remove_comments', 'Can delete comments', 'editors', 'comments'),
('tiki_p_remove_submission', 'Can remove submissions', 'editors', 'cms'),
('tiki_p_rename', 'Can rename pages', 'editors', 'wiki'),
('tiki_p_rollback', 'Can rollback pages', 'editors', 'wiki'),
('tiki_p_send_articles', 'Can send articles to other sites', 'editors', 'comm'),
('tiki_p_send_instance', 'Can send instances after completion', 'registered', 'workflow'),
('tiki_p_send_newsletters', 'Can send newsletters', 'editors', 'newsletters'),
('tiki_p_send_pages', 'Can send pages to other sites', 'registered', 'comm'),
('tiki_p_sendme_articles', 'Can send articles to this site', 'registered', 'comm'),
('tiki_p_sendme_pages', 'Can send pages to this site', 'registered', 'comm'),
('tiki_p_submit_article', 'Can submit articles', 'basic', 'cms'),
('tiki_p_submit_link', 'Can submit sites to the directory', 'basic', 'directory'),
('tiki_p_subscribe_email', 'Can subscribe any email to newsletters', 'editors', 'newsletters'),
('tiki_p_subscribe_newsletters', 'Can subscribe to newsletters', 'basic', 'newsletters'),
('tiki_p_suggest_chart_item', 'Can suggest items', 'basic', 'charts'),
('tiki_p_suggest_faq', 'Can suggest faq questions', 'basic', 'faqs'),
('tiki_p_take_quiz', 'Can take quizzes', 'basic', 'quizzes'),
('tiki_p_take_survey', 'Can take surveys', 'basic', 'surveys'),
('tiki_p_tasks', 'Can use tasks', 'registered', 'user'),
('tiki_p_tasks_admin', 'Can admin public tasks', 'admin', 'user'),
('tiki_p_tasks_receive', 'Can  receive tasks from other users', 'registered', 'user'),
('tiki_p_tasks_send', 'Can send tasks to other users', 'registered', 'user'),
('tiki_p_topic_read', 'Can read a topic (Applies only to individual topic perms)', 'basic', 'topics'),
('tiki_p_tracker_view_ratings', 'Can view rating result for tracker items', 'basic', 'trackers'),
('tiki_p_tracker_vote_ratings', 'Can vote a rating for tracker items', 'registered', 'trackers'),
('tiki_p_upload_files', 'Can upload files', 'registered', 'file galleries'),
('tiki_p_upload_images', 'Can upload images', 'registered', 'image galleries'),
('tiki_p_upload_picture', 'Can upload pictures to wiki pages', 'registered', 'wiki'),
('tiki_p_use_HTML', 'Can use HTML in pages', 'editors', 'tiki'),
('tiki_p_use_content_templates', 'Can use content templates', 'registered', 'content templates'),
('tiki_p_use_webmail', 'Can use webmail', 'registered', 'webmail'),
('tiki_p_use_workflow', 'Can execute workflow activities', 'registered', 'workflow'),
('tiki_p_userfiles', 'Can upload personal files', 'registered', 'user'),
('tiki_p_usermenu', 'Can create items in personal menu', 'registered', 'user'),
('tiki_p_validate_links', 'Can validate submited links', 'editors', 'directory'),
('tiki_p_view', 'Can view page/pages', 'basic', 'wiki'),
('tiki_p_view_calendar', 'Can browse the calendar', 'basic', 'calendar'),
('tiki_p_view_categories', 'Can browse categories', 'basic', 'tiki'),
('tiki_p_view_chart', 'Can view charts', 'basic', 'charts'),
('tiki_p_view_directory', 'Can use the directory', 'basic', 'directory'),
('tiki_p_view_eph', 'Can view ephemerides', 'registered', 'tiki'),
('tiki_p_view_faqs', 'Can view faqs', 'basic', 'faqs'),
('tiki_p_view_file_gallery', 'Can view file galleries', 'basic', 'file galleries'),
('tiki_p_view_html_pages', 'Can view HTML pages', 'basic', 'html pages'),
('tiki_p_view_image_gallery', 'Can view image galleries', 'basic', 'image galleries'),
('tiki_p_view_integrator', 'Can view integrated repositories', 'basic', 'tiki'),
('tiki_p_view_quiz_stats', 'Can view quiz stats', 'basic', 'quizzes'),
('tiki_p_view_referer_stats', 'Can view referer stats', 'editors', 'tiki'),
('tiki_p_view_sheet', 'Can view sheet', 'basic', 'sheet'),
('tiki_p_view_sheet_history', 'Can view sheet history', 'admin', 'sheet'),
('tiki_p_view_shoutbox', 'Can view shoutbox', 'basic', 'shoutbox'),
('tiki_p_view_stats', 'Can view site stats', 'basic', 'tiki'),
('tiki_p_view_survey_stats', 'Can view survey stats', 'basic', 'surveys'),
('tiki_p_view_templates', 'Can view site templates', 'admin', 'tiki'),
('tiki_p_view_tiki_calendar', 'Can view TikiWiki tools calendar', 'basic', 'calendar'),
('tiki_p_view_trackers', 'Can view trackers', 'basic', 'trackers'),
('tiki_p_view_trackers_closed', 'Can view trackers closed items', 'registered', 'trackers'),
('tiki_p_view_trackers_pending', 'Can view trackers pending items', 'editors', 'trackers'),
('tiki_p_view_user_results', 'Can view user quiz results', 'editors', 'quizzes'),
('tiki_p_vote_chart', 'Can vote', 'basic', 'charts'),
('tiki_p_vote_comments', 'Can vote comments', 'registered', 'comments'),
('tiki_p_vote_poll', 'Can vote polls', 'basic', 'tiki'),
('tiki_p_wiki_admin_attachments', 'Can admin attachments to wiki pages', 'editors', 'wiki'),
('tiki_p_wiki_admin_ratings', 'Can add and change ratings on wiki pages', 'admin', 'wiki'),
('tiki_p_wiki_attach_files', 'Can attach files to wiki pages', 'registered', 'wiki'),
('tiki_p_wiki_view_attachments', 'Can view wiki attachments and download', 'registered', 'wiki'),
('tiki_p_wiki_view_comments', 'Can view wiki comments', 'basic', 'wiki'),
('tiki_p_wiki_view_history', 'Can view wiki history', 'basic', 'wiki'),
('tiki_p_wiki_view_ratings', 'Can view rating of wiki pages', 'basic', 'wiki'),
('tiki_p_wiki_vote_ratings', 'Can participate to rating of wiki pages', 'registered', 'wiki');

-- --------------------------------------------------------

--
-- Table structure for table `users_usergroups`
--

CREATE TABLE IF NOT EXISTS `users_usergroups` (
  `userId` int(8) NOT NULL default '0',
  `groupName` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`userId`,`groupName`(30))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_usergroups`
--

INSERT INTO `users_usergroups` (`userId`, `groupName`) VALUES
(2, 'Registered');

-- --------------------------------------------------------

--
-- Table structure for table `users_users`
--

CREATE TABLE IF NOT EXISTS `users_users` (
  `userId` int(8) NOT NULL auto_increment,
  `email` varchar(200) default NULL,
  `login` varchar(40) NOT NULL default '',
  `password` varchar(30) default '',
  `provpass` varchar(30) default NULL,
  `default_group` varchar(255) default NULL,
  `lastLogin` int(14) default NULL,
  `currentLogin` int(14) default NULL,
  `registrationDate` int(14) default NULL,
  `challenge` varchar(32) default NULL,
  `pass_due` int(14) default NULL,
  `hash` varchar(32) default NULL,
  `created` int(14) default NULL,
  `avatarName` varchar(80) default NULL,
  `avatarSize` int(14) default NULL,
  `avatarFileType` varchar(250) default NULL,
  `avatarData` longblob,
  `avatarLibName` varchar(200) default NULL,
  `avatarType` char(1) default NULL,
  `score` int(11) NOT NULL default '0',
  PRIMARY KEY  (`userId`),
  KEY `score` (`score`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users_users`
--

INSERT INTO `users_users` (`userId`, `email`, `login`, `password`, `provpass`, `default_group`, `lastLogin`, `currentLogin`, `registrationDate`, `challenge`, `pass_due`, `hash`, `created`, `avatarName`, `avatarSize`, `avatarFileType`, `avatarData`, `avatarLibName`, `avatarType`, `score`) VALUES
(1, '', 'admin', '', '', NULL, 1219767416, 1219778680, NULL, NULL, 1268221471, 'c04861451e2fa1caa78a2378ed96180b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2, 'james@sandlininc.com', 'c8h10n4o2', '', '', NULL, 1222112879, 1222973145, 1181916663, NULL, 1306081069, '1b7ee5bcfa00327de5aa260c314c6bf1', 1181916663, NULL, NULL, NULL, NULL, NULL, NULL, 0);
