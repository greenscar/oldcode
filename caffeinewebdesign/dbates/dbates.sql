# phpMyAdmin SQL Dump
# version 2.5.7-pl1
# http://www.phpmyadmin.net
#
# Host: localhost
# Generation Time: Dec 08, 2004 at 04:42 PM
# Server version: 4.0.21
# PHP Version: 4.3.9
# 
# Database : `dbates`
# 

# --------------------------------------------------------

#
# Table structure for table `bfcp_file`
#

DROP TABLE IF EXISTS `bfcp_file`;
CREATE TABLE `bfcp_file` (
  `BFCP_FILE_ID` int(11) NOT NULL auto_increment,
  `USER_ID` int(11) NOT NULL default '0',
  `TITLE` varchar(40) NOT NULL default '',
  `FILE_NAME` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`BFCP_FILE_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `bfcp_file`
#


# --------------------------------------------------------

#
# Table structure for table `bfcp_index`
#

DROP TABLE IF EXISTS `bfcp_index`;
CREATE TABLE `bfcp_index` (
  `USER_ID` int(11) NOT NULL default '0',
  `ACTIVE` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`USER_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `bfcp_index`
#


# --------------------------------------------------------

#
# Table structure for table `client_producer`
#

DROP TABLE IF EXISTS `client_producer`;
CREATE TABLE `client_producer` (
  `USER_ID` int(11) NOT NULL default '0',
  `REP_ID` int(11) NOT NULL default '0',
  `DEPT_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`REP_ID`,`DEPT_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `client_producer`
#


# --------------------------------------------------------

#
# Table structure for table `client_rep`
#

DROP TABLE IF EXISTS `client_rep`;
CREATE TABLE `client_rep` (
  `USER_ID` int(11) NOT NULL default '0',
  `REP_ID` int(11) NOT NULL default '0',
  `DEPT_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`REP_ID`,`DEPT_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `client_rep`
#


# --------------------------------------------------------

#
# Table structure for table `cp_coverage`
#

DROP TABLE IF EXISTS `cp_coverage`;
CREATE TABLE `cp_coverage` (
  `COV_ID` int(11) NOT NULL auto_increment,
  `USER_ID` int(11) NOT NULL default '0',
  `FILE_ID` int(11) NOT NULL default '0',
  `TITLE` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`COV_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `cp_coverage`
#


# --------------------------------------------------------

#
# Table structure for table `cp_faq`
#

DROP TABLE IF EXISTS `cp_faq`;
CREATE TABLE `cp_faq` (
  `USER_ID` int(11) NOT NULL default '0',
  `FAQ_ID` int(11) NOT NULL default '0'
) TYPE=MyISAM;

#
# Dumping data for table `cp_faq`
#


# --------------------------------------------------------

#
# Table structure for table `cp_form`
#

DROP TABLE IF EXISTS `cp_form`;
CREATE TABLE `cp_form` (
  `USER_ID` int(11) NOT NULL default '0',
  `FORM_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`FORM_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `cp_form`
#


# --------------------------------------------------------

#
# Table structure for table `cp_index`
#

DROP TABLE IF EXISTS `cp_index`;
CREATE TABLE `cp_index` (
  `USER_ID` int(11) NOT NULL default '0',
  `LOGO` varchar(50) NOT NULL default '',
  `ACTIVE` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `cp_index`
#


# --------------------------------------------------------

#
# Table structure for table `cp_link`
#

DROP TABLE IF EXISTS `cp_link`;
CREATE TABLE `cp_link` (
  `USER_ID` int(11) NOT NULL default '0',
  `LINK_ID` int(11) NOT NULL default '0'
) TYPE=MyISAM;

#
# Dumping data for table `cp_link`
#

INSERT INTO `cp_link` VALUES (4, 1);
INSERT INTO `cp_link` VALUES (4, 136);
INSERT INTO `cp_link` VALUES (2, 133);
INSERT INTO `cp_link` VALUES (2, 135);
INSERT INTO `cp_link` VALUES (2, 131);
INSERT INTO `cp_link` VALUES (4, 133);

# --------------------------------------------------------

#
# Table structure for table `cp_service_team`
#

DROP TABLE IF EXISTS `cp_service_team`;
CREATE TABLE `cp_service_team` (
  `USER_ID` int(11) NOT NULL default '0',
  `REP_ID` int(11) NOT NULL default '0',
  `TITLE` varchar(75) NOT NULL default '',
  `TYPE` enum('LEADER','SERVICE') NOT NULL default 'SERVICE'
) TYPE=MyISAM;

#
# Dumping data for table `cp_service_team`
#


# --------------------------------------------------------

#
# Table structure for table `dept_def`
#

DROP TABLE IF EXISTS `dept_def`;
CREATE TABLE `dept_def` (
  `DEPT_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(30) NOT NULL default '',
  `IS_INSURANCE` enum('0','1') NOT NULL default '0',
  `ACTIVE` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`DEPT_ID`)
) TYPE=MyISAM AUTO_INCREMENT=16 ;

#
# Dumping data for table `dept_def`
#

INSERT INTO `dept_def` VALUES (1, 'Agency Services', '0', '1');
INSERT INTO `dept_def` VALUES (2, 'Commercial Lines', '1', '1');
INSERT INTO `dept_def` VALUES (3, 'Marine', '1', '0');
INSERT INTO `dept_def` VALUES (4, 'Personal Lines', '1', '0');
INSERT INTO `dept_def` VALUES (5, 'Professional Liability', '1', '0');
INSERT INTO `dept_def` VALUES (6, 'General Business Consulting', '0', '0');
INSERT INTO `dept_def` VALUES (7, 'Outside Consulting', '0', '0');

# --------------------------------------------------------

#
# Table structure for table `faq`
#

DROP TABLE IF EXISTS `faq`;
CREATE TABLE `faq` (
  `FAQ_ID` int(11) NOT NULL auto_increment,
  `QUESTION` text NOT NULL,
  `SOLUTION` text NOT NULL,
  PRIMARY KEY  (`FAQ_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `faq`
#


# --------------------------------------------------------

#
# Table structure for table `file`
#

DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `FILE_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(20) NOT NULL default '',
  `DESCRIPTION` varchar(100) default NULL,
  `FILE_NAME` varchar(20) NOT NULL default '',
  `SIZE` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`FILE_ID`,`FILE_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `file`
#


# --------------------------------------------------------

#
# Table structure for table `form`
#

DROP TABLE IF EXISTS `form`;
CREATE TABLE `form` (
  `FORM_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(100) NOT NULL default '',
  `DESCRIPTION` varchar(255) default NULL,
  `FILE_NAME` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`FORM_ID`)
) TYPE=MyISAM AUTO_INCREMENT=3 ;

#
# Dumping data for table `form`
#

INSERT INTO `form` VALUES (1, 'Request a Certificate of Insurance', 'Request that proof of property and/or liability insurance be provided for your business.', '1101692582.php');
INSERT INTO `form` VALUES (2, 'Request a Motor Vehicle Report', 'Request motor vehicle driving history for your employees.', '1101692696.php');

# --------------------------------------------------------

#
# Table structure for table `lead`
#

DROP TABLE IF EXISTS `lead`;
CREATE TABLE `lead` (
  `USER_ID` int(11) NOT NULL default '0',
  `PRODUCER_ID` int(11) NOT NULL default '0',
  `CSR_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`PRODUCER_ID`,`CSR_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `lead`
#


# --------------------------------------------------------

#
# Table structure for table `link`
#

DROP TABLE IF EXISTS `link`;
CREATE TABLE `link` (
  `LINK_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(50) NOT NULL default '',
  `ADDRESS` varchar(75) NOT NULL default '',
  `DESCRIPTION` text NOT NULL,
  `PUBLIC` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`LINK_ID`)
) TYPE=MyISAM AUTO_INCREMENT=138 ;

#
# Dumping data for table `link`
#

INSERT INTO `link` VALUES (131, 'Electronic Alerts from Barran Liebman LLP', 'http://www.barran.com/free_electronic_alerts.htm', 'Through our partnership with the Northwest Labor and Employment law firm Barran Liebman, Durham and Bates presents alerts which summarize the most recent developments in employee and labor case law and statutes.', '0');
INSERT INTO `link` VALUES (132, 'Federal Emergency Management Agency', 'http://www.fema.gov/', 'Emergency and disaster preparedness information.', '0');
INSERT INTO `link` VALUES (133, 'Online Hazard Maps', 'http://www.esri.com/hazards/', 'From FEMA, multi-hazard maps and information via the Internet.', '0');
INSERT INTO `link` VALUES (134, 'Insurance Institute for Highway Safety', 'http://www.hwysafety.org/', 'Vehicle safety ratings and highway safety.', '0');
INSERT INTO `link` VALUES (135, 'Independent Insurance Agents of America', 'http://www.independentagent.com/', 'A resource for consumers, media, and insurance professionals.', '0');
INSERT INTO `link` VALUES (136, 'Insurance News Network', 'http://www.insure.com/', 'Description', '0');
INSERT INTO `link` VALUES (137, 'Oregon Insurance Division', 'http://www.cbs.state.or.us/external/ins/index.html', 'Consumer information and news.', '0');

# --------------------------------------------------------

#
# Table structure for table `news`
#

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `NEWS_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(50) NOT NULL default '',
  `DESCRIPTION` varchar(200) NOT NULL default '',
  `EXPIRE_DATE` bigint(20) default NULL,
  `NEVER_EXPIRE` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`NEWS_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `news`
#


# --------------------------------------------------------

#
# Table structure for table `rep`
#

DROP TABLE IF EXISTS `rep`;
CREATE TABLE `rep` (
  `REP_ID` int(11) NOT NULL auto_increment,
  `PWD` varchar(15) NOT NULL default '',
  `FIRST_NAME` varchar(12) NOT NULL default '',
  `LAST_NAME` varchar(20) NOT NULL default '',
  `INITIALS` varchar(5) NOT NULL default '',
  `EMAIL` varchar(30) default NULL,
  `FAX` varchar(12) default NULL,
  `PHONE` varchar(12) default NULL,
  `DEPT_ID` int(11) default NULL,
  `SPECIALTY_ID` int(11) default NULL,
  `ACTIVE` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`REP_ID`)
) TYPE=MyISAM AUTO_INCREMENT=2214 ;

#
# Dumping data for table `rep`
#

INSERT INTO `rep` VALUES (2145, '', 'Alison', ' Szalvay', 'AJH', 'alisons@dbates.com', '503-224-6491', '503-478-6618', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2146, '', 'Anne', ' Kasner', 'AJK', 'annek@dbates.com', '503-224-6491', '503-796-0290', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2147, '', 'Anna', ' Ferlitsch', 'ALF', 'annaf@dbates.com', '503-423-9495', '503-796-1643', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2148, '', 'Barbara', ' Hayden', 'BJH', 'barbh@dbates.com', '503-221-0540', '503-242-9400', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2149, '', 'Bill', ' Prenger', 'BJP', 'billp@dbates.com', '503-221-0540', '503-796-1645', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2150, '', 'Brea', ' Sparks', 'BKS', 'breas@dbates.com', '503-224-6491', '503-241-9226', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2151, '', 'Charlotte', ' Shepherd', 'CBS', 'charlottes@dbates.com', '503-224-6491', '503-796-0290', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2152, '', 'Christen', ' Picot', 'CEP', 'christenp@dbates.com', '503-224-6491', '503-796-0291', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2153, '', 'Carol', ' Bolton', 'CJB', 'carolb@dbates.com', '503-221-0540', '503-242-9401', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2154, '', 'Douglas', ' Miller', 'DAM', 'bigthe@bellsouth.net', '504-945-4930', '504-945-4930', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2155, '', 'David', ' Stalker', 'DDS', 'davids@dbates.com', '503-221-0540', '503-485-9490', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2156, '', 'Dennis', ' Peterson', 'DHP', 'dennisp@dbates.com', '503-221-0540', '503-796-1646', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2157, '', '(D.) Joe', ' Collver', 'DJC', 'joec@dbates.com', '503-221-0540', '503-242-9408', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2158, '', 'Debra', ' Melendez', 'DLM', 'debram@dbates.com', '503-224-4236', '503-242-9404', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2159, '', 'Debra', ' Hallock', 'DMH', 'debrah@dbates.com', '503-221-0540', '503-796-1649', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2160, '', 'Dan', ' Westby', 'DRW', 'danw@dbates.com', '503-224-6491', '503-224-5170', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2161, '', 'Ernie', ' Merfalen', 'EAM', 'erniem@dbates.com', '503-221-0540', '503-478-6614', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2162, '', 'Jayne', ' Stolte', 'EJS', 'jaynes@dbates.com', '503-221-0540', '503-242-9403', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2163, '', 'Evelyn', ' Widjaja', 'EW', 'evelynw@dbates.com', '503-423-9495', '503-241-9224', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2164, '', 'Greg', ' Ryerson', 'GSR', 'gregr@dbates.com', '503-221-0540', '503-242-9405', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2165, '', 'Heidi', ' Gulick', 'HNG', 'heidig@dbates.com', '503-221-0540', '503-478-6614', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2166, '', 'Ingo', ' Wittig', 'IMW', 'ingow@dbates.com', '503-224-6491', '503-241-9222', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2167, '', 'Joyce', ' Bjorge', 'JAB', 'joyceb@dbates.com', '503-221-0540', '503-478-6617', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2168, '', 'Julie', ' Greenley', 'JAG', 'julieg@dbates.com', '503-224-6491', '503-796-0292', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2169, '', 'Joan', ' Edelman', 'JBE', 'joane@dbates.com', '206-283-1569', '206-284-7776', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2170, '', 'Janet', ' Davis', 'JCD', 'janetd@dbates.com', '503-221-0540', '503-241-9219', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2171, '', 'Josh', ' Dirth', 'JED', 'joshd@dbates.com', '503-224-6491', '503-478-6616', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2172, '', 'Jim', ' Camburn', 'JFC', 'jimc@dbates.com', '503-221-0540', '503-796-0296', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2173, '', 'Janis', ' Housden', 'JH', 'janish@dbates.com', '503-221-0540', '503-796-0295', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2174, '', 'Jeremy', ' Andersen', 'JLA', 'jeremya@dbates.com', '503-221-0540', '503-796-1642', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2175, '', 'Juanita', ' Baldwin', 'JLB', 'juanitab@dbates.com', '206-283-1569', '206-284-7776', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2176, '', 'Julie', ' Olver', 'JLO', 'julieo@dbates.com', '503)224-6491', '503-423-9493', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2177, '', 'J P', ' Agnesse', 'JPA', 'jpagnesse@dbates.com', '503-221-0540', '503-241-9218', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2178, '', 'James', ' Ladd', 'JPL', 'jamesl@dbates.com', '503-221-0540', '503-423-9491', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2179, '', 'Justine', ' Avera', 'JUA', 'justinea@dbates.com', '503-221-0540', '503-241-9229', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2180, '', 'Janna', ' Brown', 'JVB', 'jannab@dbates.com', '503-221-0540', '503-796-0293', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2181, '', 'Katrina', ' Green', 'KMG', 'katrinag@dbates.com', '503-224-4236', '503-241-9214', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2182, '', 'David', ' Hearns', 'LDH', 'davidh@dbates.com', '503-221-0540', '503-796-1640', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2183, '', 'Marie', ' Tedesco', 'MJT', 'mariet@dbates.com', '503-221-0540', '503-242-9409', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2184, '', 'Marcia K.', ' Sanderman', 'MKS', 'marcias@dbates.com', '503-224-6491', '503-796-1641', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2185, '', 'Mike', ' Davis', 'MLD', 'miked@dbates.com', '503-221-0540', '503-242-9402', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2186, '', 'Matthew', ' Milsovic', 'MRM', 'mattm@dbates.com', '503-221-0540', '503-796-1643', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2187, '', 'Michelle', ' Nickles', 'MRN', 'michellen@dbates.com', '503-224-4236', '503-242-9407', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2188, '', 'Nicole', ' Roa', 'NMR', 'nicoler@dbates.com', '503-221-0540', '503-241-9218', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2189, '', 'Pati', ' Bengtson', 'PAB', 'patib@dbates.com', '503-221-0540', '503-796-1647', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2190, '', 'Pia', ' Nicastro', 'PEG', 'piag@dbates.com', '503-221-0540', '503-796-1641', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2191, '', 'Peggy', ' Smith', 'PJS', 'peggys@dbates.com', '503-221-0540', '503-241-9224', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2192, '', 'Pamela', ' Hamrick', 'PKH', 'pamelah@dbates.com', '503-423-9495', '503-796-0294', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2193, '', 'Patsy', ' Campbell', 'PLC', 'patsyc@dbates.com', '503-221-0540', '503-241-9220', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2194, '', 'Rebekkah', ' McCracken', 'RAM', 'beckym@dbates.com', '503-224-6491', '503-241-9213', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2195, '', 'Dick', ' Seekins', 'RLS', 'dicks@dbates.com', '503-221-0540', '503-241-9216', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2196, '', 'Bob', ' White', 'RMW', 'bobw@dbates.com', '503-224-4236', '503-241-9215', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2197, '', 'Ruth', ' Tucker', 'RT', 'rutht@dbates.com', '503-221-0540', '503-242-9408', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2198, '', 'Susan', ' DeLair', 'SBD', 'susand@dbates.com', '503-423-9495', '503-241-9225', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2199, '', 'Stacey', ' Kramer', 'SLK', 'staceyk@dbates.com', '503-224-4236', '503-242-9406', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2200, '', 'Sean', ' McCarthy', 'SMM', 'seanm@dbates.com', '503-224-4236', '503-241-9228', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2201, '', 'Sarah', ' Wilson', 'SMW', 'sarahw@dbates.com', '503-224-4236', '503-241-9213', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2202, '', 'Sarah S.', ' Adams', 'SSA', 'saraha@dbates.com', '503-221-0540', '503-796-1644', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2203, '', 'Teresa', ' Keel', 'TDK', 'teresak@dbates.com', '503-221-0540', '503-241-9221', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2204, '', 'Trinity', ' Collins', 'TEC', 'trinityc@dbates.com', '503-221-0540', '503-796-1641', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2205, '', 'Terri Lee', ' Cline', 'TLC', 'Terric@dbates.com', '503-221-0540', '503-241-9218', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2206, '', 'Theresa', ' McCreary', 'TMM', 'theresam@dbates.com', '503-221-0540', '503-241-9218', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2207, '', 'Bill', ' Hurst', 'WDH', 'billh@dbates.com', '503-224-4236', '503-241-9212', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2208, '', 'Yanira', ' Bartzis', 'YMB', 'yanirab@dbates.com', '503-221-0540', '503-796-1644', NULL, NULL, '0');
INSERT INTO `rep` VALUES (2209, '', 'Evelyn', ' Sorenson', 'EAS', 'evelyns@dbates.com', '503-221-0540', '503-796-1641', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2210, '', 'Allie', ' Koleno', 'AAK', 'alliek@dbates.com', '503-221-0540', '503-796-0295', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2211, '', 'David', ' Paez', 'DXP', 'davidp@dbates.com', '503-221-0540', '503-241-9220', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2212, '', 'Michael', ' Tabata', 'MYT', 'michaelt@dbates.com', '503-221-0540', '503-241-9219', NULL, NULL, '1');
INSERT INTO `rep` VALUES (2213, '', 'Karen', ' Johnson', 'KMJ', 'karenj@dbates.com', '503-221-0540', '503-241-9224', NULL, NULL, '1');

# --------------------------------------------------------

#
# Table structure for table `rep_role`
#

DROP TABLE IF EXISTS `rep_role`;
CREATE TABLE `rep_role` (
  `REP_ID` int(11) NOT NULL default '0',
  `ROLE_1` varchar(40) NOT NULL default '',
  `ROLE_2` varchar(40) NOT NULL default '',
  `ROLE_3` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`REP_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `rep_role`
#


# --------------------------------------------------------

#
# Table structure for table `specialty_def`
#

DROP TABLE IF EXISTS `specialty_def`;
CREATE TABLE `specialty_def` (
  `SPECIALTY_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(30) NOT NULL default '',
  `ACTIVE` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`SPECIALTY_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `specialty_def`
#


# --------------------------------------------------------

#
# Table structure for table `user`
#

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `USER_ID` int(11) NOT NULL auto_increment,
  `USER_NAME` varchar(15) NOT NULL default '',
  `PASSWORD` varchar(50) NOT NULL default '',
  `NAME` varchar(30) NOT NULL default '',
  `CONTACT` varchar(30) default NULL,
  `PHONE` varchar(12) NOT NULL default '',
  `EMAIL` varchar(30) NOT NULL default '',
  `ACTIVE` enum('0','1') NOT NULL default '0',
  `SEC_LVL_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`)
) TYPE=MyISAM AUTO_INCREMENT=8 ;

#
# Dumping data for table `user`
#

INSERT INTO `user` VALUES (1, 'CLIENT1', 'password', 'Test Client Inc', 'Douglas Miller', '504-945-4930', 'thedoug@bigthe.com', '1', 1);
INSERT INTO `user` VALUES (2, 'CONTACT', 'password', 'Contact Lumber', 'Contact Lumber', '503-221-1340', 'bigthe@bellsouth.net', '1', 1);
INSERT INTO `user` VALUES (3, 'SELECT', 'password', 'Select Accounts Client', 'Your Name', '', 'your@email.com', '1', 1);
INSERT INTO `user` VALUES (4, 'ZIDELL', 'Zidell', 'Zidell Marine', 'Kathleen Thompson', '503-937-2229', 'kathyt@zidell.com', '1', 1);
INSERT INTO `user` VALUES (5, 'ZIDELL2', 'password', 'Zidell Marine (mirror)', 'Douglas Miller', '', 'bigthe@bellsouth.net', '1', 1);
INSERT INTO `user` VALUES (6, 'jsandlin', 'jsandlin', 'James Sandlin', 'James Sandlin', '503-887-8510', 'james@caffeinewebdesign.com', '1', 3);
INSERT INTO `user` VALUES (7, 'iwittig', 'password', 'Ingo Wittig', 'Ingo Wittig', '123-333-3333', 'iwittig@dbates.com', '1', 2);

# --------------------------------------------------------

#
# Table structure for table `user_sec_lvl`
#

DROP TABLE IF EXISTS `user_sec_lvl`;
CREATE TABLE `user_sec_lvl` (
  `SEC_LVL_ID` int(11) NOT NULL auto_increment,
  `SEC_LVL_NAME` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`SEC_LVL_ID`)
) TYPE=MyISAM AUTO_INCREMENT=4 ;

#
# Dumping data for table `user_sec_lvl`
#

INSERT INTO `user_sec_lvl` VALUES (1, 'CLIENT');
INSERT INTO `user_sec_lvl` VALUES (2, 'ADMIN');
INSERT INTO `user_sec_lvl` VALUES (3, 'ROOT');
