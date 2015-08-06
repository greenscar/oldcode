# phpMyAdmin SQL Dump
# version 2.5.7-pl1
# http://www.phpmyadmin.net
#
# Host: sqlc2.megasqlservers.com
# Generation Time: Jan 02, 2007 at 09:35 PM
# Server version: 4.0.27
# PHP Version: 4.4.1
# 
# Database : `default_dbates_com`
# 

# --------------------------------------------------------

#
# Table structure for table `BFCP_FILE`
#

CREATE TABLE `BFCP_FILE` (
  `BFCP_FILE_ID` int(11) NOT NULL auto_increment,
  `USER_ID` int(11) NOT NULL default '0',
  `TITLE` varchar(40) NOT NULL default '',
  `FILE_NAME` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`BFCP_FILE_ID`)
) TYPE=MyISAM AUTO_INCREMENT=7 ;

#
# Dumping data for table `BFCP_FILE`
#

INSERT INTO `BFCP_FILE` VALUES (1, 1, '1_11057686082.jpg', '1_11057686082.jpg');

# --------------------------------------------------------

#
# Table structure for table `BFCP_INDEX`
#

CREATE TABLE `BFCP_INDEX` (
  `USER_ID` int(11) NOT NULL default '0',
  `ACTIVE` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`USER_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `BFCP_INDEX`
#

INSERT INTO `BFCP_INDEX` VALUES (1, '1');
INSERT INTO `BFCP_INDEX` VALUES (19, '1');
INSERT INTO `BFCP_INDEX` VALUES (8, '1');
INSERT INTO `BFCP_INDEX` VALUES (4, '0');

# --------------------------------------------------------

#
# Table structure for table `CLIENT_PRODUCER`
#

CREATE TABLE `CLIENT_PRODUCER` (
  `USER_ID` int(11) NOT NULL default '0',
  `REP_ID` int(11) NOT NULL default '0',
  `DEPT_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`REP_ID`,`DEPT_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `CLIENT_PRODUCER`
#

INSERT INTO `CLIENT_PRODUCER` VALUES (14, 2179, 16);
INSERT INTO `CLIENT_PRODUCER` VALUES (18, 2149, 2);
INSERT INTO `CLIENT_PRODUCER` VALUES (18, 2179, 16);
INSERT INTO `CLIENT_PRODUCER` VALUES (18, 2200, 3);
INSERT INTO `CLIENT_PRODUCER` VALUES (18, 2212, 4);
INSERT INTO `CLIENT_PRODUCER` VALUES (20, 2200, 3);

# --------------------------------------------------------

#
# Table structure for table `CLIENT_REP`
#

CREATE TABLE `CLIENT_REP` (
  `USER_ID` int(11) NOT NULL default '0',
  `REP_ID` int(11) NOT NULL default '0',
  `DEPT_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`REP_ID`,`DEPT_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `CLIENT_REP`
#

INSERT INTO `CLIENT_REP` VALUES (14, 2216, 16);
INSERT INTO `CLIENT_REP` VALUES (18, 2199, 3);
INSERT INTO `CLIENT_REP` VALUES (18, 2210, 2);
INSERT INTO `CLIENT_REP` VALUES (18, 2216, 16);
INSERT INTO `CLIENT_REP` VALUES (20, 2199, 3);

# --------------------------------------------------------

#
# Table structure for table `CP_COVERAGE`
#

CREATE TABLE `CP_COVERAGE` (
  `COV_ID` int(11) NOT NULL auto_increment,
  `USER_ID` int(11) NOT NULL default '0',
  `FILE_ID` int(11) NOT NULL default '0',
  `TITLE` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`COV_ID`)
) TYPE=MyISAM AUTO_INCREMENT=52 ;

#
# Dumping data for table `CP_COVERAGE`
#

INSERT INTO `CP_COVERAGE` VALUES (43, 4, 39, 'EPL, D&O, FL and Crime');
INSERT INTO `CP_COVERAGE` VALUES (40, 4, 33, 'Foreign Liability');
INSERT INTO `CP_COVERAGE` VALUES (39, 4, 35, 'Bumbershoot');
INSERT INTO `CP_COVERAGE` VALUES (38, 4, 38, 'Umbrella');
INSERT INTO `CP_COVERAGE` VALUES (37, 4, 37, 'Marine Liability');
INSERT INTO `CP_COVERAGE` VALUES (36, 4, 34, 'Automobile Liability');
INSERT INTO `CP_COVERAGE` VALUES (27, 14, 13, 'Technology');
INSERT INTO `CP_COVERAGE` VALUES (46, 4, 32, 'Property');
INSERT INTO `CP_COVERAGE` VALUES (23, 14, 12, 'Manufacturing');
INSERT INTO `CP_COVERAGE` VALUES (20, 14, 11, 'Introduction');
INSERT INTO `CP_COVERAGE` VALUES (35, 4, 36, 'General Liability/Property');
INSERT INTO `CP_COVERAGE` VALUES (34, 4, 21, 'Coverage Diagram');
INSERT INTO `CP_COVERAGE` VALUES (49, 20, 29, 'D&B 03-04 Tumac Claims');
INSERT INTO `CP_COVERAGE` VALUES (44, 4, 17, 'Workers\' Comp - Oregon');
INSERT INTO `CP_COVERAGE` VALUES (45, 4, 18, 'Workers\' Comp - Other States');
INSERT INTO `CP_COVERAGE` VALUES (47, 4, 19, 'Workers\' Comp - Oregon Barge');
INSERT INTO `CP_COVERAGE` VALUES (48, 4, 20, 'Workers\' Comp - ZRZ Realty');
INSERT INTO `CP_COVERAGE` VALUES (50, 20, 30, 'D&B 04-05 Tumac Claims');
INSERT INTO `CP_COVERAGE` VALUES (51, 20, 31, 'D&B 05-06 Tumac Claims');

# --------------------------------------------------------

#
# Table structure for table `CP_FAQ`
#

CREATE TABLE `CP_FAQ` (
  `USER_ID` int(11) NOT NULL default '0',
  `FAQ_ID` int(11) NOT NULL default '0'
) TYPE=MyISAM;

#
# Dumping data for table `CP_FAQ`
#

INSERT INTO `CP_FAQ` VALUES (4, 1);
INSERT INTO `CP_FAQ` VALUES (18, 3);
INSERT INTO `CP_FAQ` VALUES (14, 1);
INSERT INTO `CP_FAQ` VALUES (8, 3);
INSERT INTO `CP_FAQ` VALUES (4, 2);
INSERT INTO `CP_FAQ` VALUES (22, 3);

# --------------------------------------------------------

#
# Table structure for table `CP_FORM`
#

CREATE TABLE `CP_FORM` (
  `USER_ID` int(11) NOT NULL default '0',
  `FORM_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`FORM_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `CP_FORM`
#

INSERT INTO `CP_FORM` VALUES (3, 1);
INSERT INTO `CP_FORM` VALUES (3, 2);
INSERT INTO `CP_FORM` VALUES (3, 5);
INSERT INTO `CP_FORM` VALUES (3, 6);
INSERT INTO `CP_FORM` VALUES (4, 1);
INSERT INTO `CP_FORM` VALUES (4, 2);
INSERT INTO `CP_FORM` VALUES (8, 1);
INSERT INTO `CP_FORM` VALUES (8, 2);
INSERT INTO `CP_FORM` VALUES (14, 1);
INSERT INTO `CP_FORM` VALUES (14, 2);
INSERT INTO `CP_FORM` VALUES (14, 5);
INSERT INTO `CP_FORM` VALUES (14, 6);
INSERT INTO `CP_FORM` VALUES (18, 1);
INSERT INTO `CP_FORM` VALUES (18, 2);
INSERT INTO `CP_FORM` VALUES (22, 1);
INSERT INTO `CP_FORM` VALUES (22, 6);

# --------------------------------------------------------

#
# Table structure for table `CP_INDEX`
#

CREATE TABLE `CP_INDEX` (
  `USER_ID` int(11) NOT NULL default '0',
  `LOGO` varchar(50) NOT NULL default '',
  `ACTIVE` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `CP_INDEX`
#

INSERT INTO `CP_INDEX` VALUES (4, '1104946761.jpg', '1');
INSERT INTO `CP_INDEX` VALUES (8, '1105404015.gif', '1');
INSERT INTO `CP_INDEX` VALUES (18, '1108149366.jpg', '1');
INSERT INTO `CP_INDEX` VALUES (20, '1149539596.jpg', '1');
INSERT INTO `CP_INDEX` VALUES (22, '1154381144.jpg', '1');

# --------------------------------------------------------

#
# Table structure for table `CP_LINK`
#

CREATE TABLE `CP_LINK` (
  `USER_ID` int(11) NOT NULL default '0',
  `LINK_ID` int(11) NOT NULL default '0'
) TYPE=MyISAM;

#
# Dumping data for table `CP_LINK`
#

INSERT INTO `CP_LINK` VALUES (14, 1);
INSERT INTO `CP_LINK` VALUES (14, 136);
INSERT INTO `CP_LINK` VALUES (2, 133);
INSERT INTO `CP_LINK` VALUES (2, 135);
INSERT INTO `CP_LINK` VALUES (2, 131);
INSERT INTO `CP_LINK` VALUES (14, 137);
INSERT INTO `CP_LINK` VALUES (14, 138);
INSERT INTO `CP_LINK` VALUES (4, 141);
INSERT INTO `CP_LINK` VALUES (14, 140);
INSERT INTO `CP_LINK` VALUES (8, 136);
INSERT INTO `CP_LINK` VALUES (3, 136);
INSERT INTO `CP_LINK` VALUES (3, 138);
INSERT INTO `CP_LINK` VALUES (3, 140);
INSERT INTO `CP_LINK` VALUES (3, 137);
INSERT INTO `CP_LINK` VALUES (4, 138);
INSERT INTO `CP_LINK` VALUES (4, 139);
INSERT INTO `CP_LINK` VALUES (4, 133);
INSERT INTO `CP_LINK` VALUES (4, 131);
INSERT INTO `CP_LINK` VALUES (4, 142);
INSERT INTO `CP_LINK` VALUES (4, 136);
INSERT INTO `CP_LINK` VALUES (4, 140);
INSERT INTO `CP_LINK` VALUES (4, 137);
INSERT INTO `CP_LINK` VALUES (8, 134);
INSERT INTO `CP_LINK` VALUES (8, 140);
INSERT INTO `CP_LINK` VALUES (18, 135);
INSERT INTO `CP_LINK` VALUES (18, 138);
INSERT INTO `CP_LINK` VALUES (18, 140);
INSERT INTO `CP_LINK` VALUES (18, 134);
INSERT INTO `CP_LINK` VALUES (20, 143);
INSERT INTO `CP_LINK` VALUES (22, 138);
INSERT INTO `CP_LINK` VALUES (22, 132);
INSERT INTO `CP_LINK` VALUES (22, 136);

# --------------------------------------------------------

#
# Table structure for table `CP_SERVICE_TEAM`
#

CREATE TABLE `CP_SERVICE_TEAM` (
  `USER_ID` int(11) NOT NULL default '0',
  `REP_ID` int(11) NOT NULL default '0',
  `TITLE` varchar(75) NOT NULL default '',
  `TYPE` enum('LEADER','SERVICE') NOT NULL default 'SERVICE'
) TYPE=MyISAM;

#
# Dumping data for table `CP_SERVICE_TEAM`
#

INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2174, 'E&O, Crime and Fiduciary Liability', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2207, 'Wet Marine', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2195, 'All Other', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2199, 'Wet Marine Customer Service', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2185, 'Marine & Non-Marine Liability', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (20, 2200, 'Senior Vice President', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2159, 'E&O, Crime and Fiduciary Liability Customer Service', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2183, 'Customer Service (Non Wet  Marine)', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (14, 2179, ' Select Accounts Department Manager', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (3, 2179, ' Select Accounts Department Manager', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (8, 2205, 'Customer Service', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (3, 2216, ' Select Accounts Client Manager', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (14, 2216, ' Select Accounts Client Manager', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (8, 2195, 'President, CEO', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (18, 2195, 'President, CEO', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (18, 2209, 'Customer Service', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2182, 'Property and Flood', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2149, 'Pollution and Environmental', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (4, 2221, 'Workers\' Comp', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (20, 2199, 'Assistant Vice President', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (20, 2218, 'Claims Administrator', 'SERVICE');
INSERT INTO `CP_SERVICE_TEAM` VALUES (22, 2207, 'Lead Producer', 'LEADER');
INSERT INTO `CP_SERVICE_TEAM` VALUES (22, 2199, 'Lead CSR', 'SERVICE');

# --------------------------------------------------------

#
# Table structure for table `DEPT_DEF`
#

CREATE TABLE `DEPT_DEF` (
  `DEPT_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(50) NOT NULL default '',
  `IS_INSURANCE` enum('0','1') NOT NULL default '0',
  `ACTIVE` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`DEPT_ID`)
) TYPE=MyISAM AUTO_INCREMENT=17 ;

#
# Dumping data for table `DEPT_DEF`
#

INSERT INTO `DEPT_DEF` VALUES (1, 'Agency Services', '0', '1');
INSERT INTO `DEPT_DEF` VALUES (2, 'Commercial Lines', '1', '1');
INSERT INTO `DEPT_DEF` VALUES (3, 'Marine', '1', '1');
INSERT INTO `DEPT_DEF` VALUES (4, 'Personal Lines', '1', '1');
INSERT INTO `DEPT_DEF` VALUES (5, 'Corporate', '0', '1');
INSERT INTO `DEPT_DEF` VALUES (6, 'General Business Consulting', '0', '0');
INSERT INTO `DEPT_DEF` VALUES (7, 'Outside Consulting', '0', '0');
INSERT INTO `DEPT_DEF` VALUES (16, 'Select Accounts (Small Commercial)', '1', '1');

# --------------------------------------------------------

#
# Table structure for table `FAQ`
#

CREATE TABLE `FAQ` (
  `FAQ_ID` int(11) NOT NULL auto_increment,
  `QUESTION` text NOT NULL,
  `SOLUTION` text NOT NULL,
  PRIMARY KEY  (`FAQ_ID`)
) TYPE=MyISAM AUTO_INCREMENT=4 ;

#
# Dumping data for table `FAQ`
#

INSERT INTO `FAQ` VALUES (1, 'Do all P&I Clubs have the same expiration date? Why?', 'Yes. That\'s when the ice in the Bering Sea thaws and ships can begin sailing again.\r\n');
INSERT INTO `FAQ` VALUES (2, 'How does the Supplemental Call history of the American Club compare with other P&I Clubs?', '<a target="_new" href="../upload_dir/supplemental_call_history.htm">Click Here for a Comparatory Graph</a>');
INSERT INTO `FAQ` VALUES (3, 'Why should Durham and Bates be my broker?', 'We are an expanding, multi-lined agency providing risk management services to a number of industries. We view ourselves as a consulting brokerage, partnering with clients as risk management specialists – knowledgeable in specific industries beyond our insurance expertise.\r\n\r\nAt Durham and Bates, we practice utmost selectivity in the recruitment and retention of our associates. We hire only those people with whom you’d want to do business. Each Durham and Bates associate must demonstrate exceptional character, world class communication skills, an individual passion for their expertise, and a proven, high degree of specialty competence. Each associate is ready and eager to bring a personal brand of real value to your business. ');

# --------------------------------------------------------

#
# Table structure for table `FILE`
#

CREATE TABLE `FILE` (
  `FILE_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(100) NOT NULL default '',
  `DESCRIPTION` varchar(100) default NULL,
  `FILE_NAME` varchar(20) NOT NULL default '',
  `SIZE` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`FILE_ID`,`FILE_ID`)
) TYPE=MyISAM AUTO_INCREMENT=40 ;

#
# Dumping data for table `FILE`
#

INSERT INTO `FILE` VALUES (34, 'Zidell Auto 0607', '', '1154988065.pdf', 16153);
INSERT INTO `FILE` VALUES (33, 'Zidell Foreign Liab 0607', '', '1154988034.pdf', 21187);
INSERT INTO `FILE` VALUES (32, 'Zidell Property 0607', '', '1154987963.pdf', 1671831);
INSERT INTO `FILE` VALUES (31, 'D&B 05-06 Tumac claims', '', '1149540835.pdf', 14902);
INSERT INTO `FILE` VALUES (29, 'D&B 03-04 Tumac claims', '', '1149540780.pdf', 17701);
INSERT INTO `FILE` VALUES (11, 'Select - Expertise', 'Expertise2 brochure', '1110991097.pdf', 68617);
INSERT INTO `FILE` VALUES (12, 'Select - Manufacturing', '', '1109110078.pdf', 249012);
INSERT INTO `FILE` VALUES (13, 'Select - Technology', '', '1109110112.pdf', 85838);
INSERT INTO `FILE` VALUES (30, 'D&B 04-05 Tumac Claims', '', '1149540805.pdf', 12373);
INSERT INTO `FILE` VALUES (39, 'Zidell EPL_DO_FL_CR0607', '', '1157564670.pdf', 149451);
INSERT INTO `FILE` VALUES (17, 'Zidell WC OR 0506', '', '1126198886.pdf', 14227);
INSERT INTO `FILE` VALUES (18, 'Zidell WC Other 0506', '', '1126198917.pdf', 14220);
INSERT INTO `FILE` VALUES (19, 'Zidell WC Oregon Barge 0506', '', '1126198946.pdf', 13781);
INSERT INTO `FILE` VALUES (20, 'Zidell WC ZRZ Realty 0506', '', '1126198968.pdf', 13669);
INSERT INTO `FILE` VALUES (21, 'Zidell CoverageDiag 0506', '', '1126201333.pdf', 8205);
INSERT INTO `FILE` VALUES (35, 'Zidell Bumbershoot 0607', '', '1154988097.pdf', 18667);
INSERT INTO `FILE` VALUES (36, 'Zidell GenLiabProp 0607', '', '1154988142.pdf', 25535);
INSERT INTO `FILE` VALUES (37, 'Zidell Marine Liab 0607', '', '1154988302.pdf', 23056);
INSERT INTO `FILE` VALUES (38, 'Zidell Umbrella 0607', '', '1154988359.pdf', 17400);

# --------------------------------------------------------

#
# Table structure for table `FORM`
#

CREATE TABLE `FORM` (
  `FORM_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(100) NOT NULL default '',
  `DESCRIPTION` varchar(255) default NULL,
  `FILE_NAME` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`FORM_ID`)
) TYPE=MyISAM AUTO_INCREMENT=7 ;

#
# Dumping data for table `FORM`
#

INSERT INTO `FORM` VALUES (1, 'Request a Certificate of Insurance', 'Request that proof of property and/or liability insurance be provided for your business.', '1101692582.php');
INSERT INTO `FORM` VALUES (2, 'Request a Motor Vehicle Report', 'Request motor vehicle driving history for your employees.', '1101692696.php');
INSERT INTO `FORM` VALUES (5, 'New Location Questionnaire', 'Changing or adding locations for your business?  Please use this form.', '1110996934.pdf');
INSERT INTO `FORM` VALUES (6, 'Request for Policy Change', 'If you need to make changes to your policy, please use this form.', '1105372849.pdf');

# --------------------------------------------------------

#
# Table structure for table `LEAD`
#

CREATE TABLE `LEAD` (
  `USER_ID` int(11) NOT NULL default '0',
  `PRODUCER_ID` int(11) NOT NULL default '0',
  `CSR_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID`,`PRODUCER_ID`,`CSR_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `LEAD`
#

INSERT INTO `LEAD` VALUES (9, 0, 0);
INSERT INTO `LEAD` VALUES (10, 0, 0);
INSERT INTO `LEAD` VALUES (13, 0, 0);
INSERT INTO `LEAD` VALUES (15, 0, 0);
INSERT INTO `LEAD` VALUES (18, 2195, 2209);
INSERT INTO `LEAD` VALUES (20, 0, 0);
INSERT INTO `LEAD` VALUES (21, 0, 0);
INSERT INTO `LEAD` VALUES (22, 2207, 2199);

# --------------------------------------------------------

#
# Table structure for table `LINK`
#

CREATE TABLE `LINK` (
  `LINK_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(50) NOT NULL default '',
  `ADDRESS` varchar(75) NOT NULL default '',
  `DESCRIPTION` text NOT NULL,
  `PUBLIC` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`LINK_ID`)
) TYPE=MyISAM AUTO_INCREMENT=144 ;

#
# Dumping data for table `LINK`
#

INSERT INTO `LINK` VALUES (131, 'Electronic Alerts from Barran Liebman LLP', 'http://www.barran.com/free_electronic_alerts.htm', 'Through our partnership with the Northwest Labor and Employment law firm Barran Liebman, Durham and Bates presents alerts which summarize the most recent developments in employee and labor case law and statutes.', '0');
INSERT INTO `LINK` VALUES (132, 'Federal Emergency Management Agency', 'http://www.fema.gov/', 'Emergency and disaster preparedness information.', '0');
INSERT INTO `LINK` VALUES (133, 'Online Hazard Maps', 'http://www.esri.com/hazards/', 'From FEMA, multi-hazard maps and information via the Internet.', '0');
INSERT INTO `LINK` VALUES (134, 'Insurance Institute for Highway Safety', 'http://www.hwysafety.org/', 'Vehicle safety ratings and highway safety.', '0');
INSERT INTO `LINK` VALUES (135, 'Independent Insurance Agents of America', 'http://www.independentagent.com/', 'A resource for consumers, media, and insurance professionals.', '0');
INSERT INTO `LINK` VALUES (136, 'Insurance News Network', 'http://www.insure.com/', 'Description', '0');
INSERT INTO `LINK` VALUES (137, 'Oregon Insurance Division', 'http://www.cbs.state.or.us/external/ins/index.html', 'Consumer information and news.', '0');
INSERT INTO `LINK` VALUES (138, 'Glossary of Insurance Terms', 'http://www.glossarist.com/glossaries/economy-finance/insurance.asp', '', '1');
INSERT INTO `LINK` VALUES (139, 'Affiliated FM Insurance Co.', 'http://www.affiliatedfm.com/', '', '1');
INSERT INTO `LINK` VALUES (140, 'OSHA', 'http://www.osha.gov', '', '1');
INSERT INTO `LINK` VALUES (141, 'The American Club', 'http://www.american-club.com/', '', '1');
INSERT INTO `LINK` VALUES (142, 'National Pollution Fund Center', 'http://www.uscg.mil/hq/npfc/index.htm', '', '1');
INSERT INTO `LINK` VALUES (143, 'St.Paul Travelers', 'http://www.stpaultravelers.com/', 'St.Paul Travelers main website', '1');

# --------------------------------------------------------

#
# Table structure for table `NEWS`
#

CREATE TABLE `NEWS` (
  `NEWS_ID` int(11) NOT NULL auto_increment,
  `TITLE` varchar(50) NOT NULL default '',
  `DESCRIPTION` text NOT NULL,
  `POST_DATE` bigint(20) NOT NULL default '0',
  `EXPIRE_DATE` bigint(20) default NULL,
  `NEVER_EXPIRE` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`NEWS_ID`)
) TYPE=MyISAM AUTO_INCREMENT=3 ;

#
# Dumping data for table `NEWS`
#

INSERT INTO `NEWS` VALUES (1, 'Announcing the Redesigned Durham and Bates Website', 'We\'ve redesigned our entire site to make it easier to find the information and resources you need to help you make informed decisions about your insurance.  Please look through our site and let us know what you think.  <br />\r\n<br />\r\nWe\'re looking forward to doing business with you.', 1104946543, 1107234000, '0');

# --------------------------------------------------------

#
# Table structure for table `REP`
#

CREATE TABLE `REP` (
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
) TYPE=MyISAM AUTO_INCREMENT=2228 ;

#
# Dumping data for table `REP`
#

INSERT INTO `REP` VALUES (2145, '', 'Alison', 'Szalvay', 'AJH', 'alisons@dbates.com', '503-224-6491', '503-478-6618', 1, NULL, '1');
INSERT INTO `REP` VALUES (2148, '', 'Barbara', 'Hayden', 'BJH', 'barbh@dbates.com', '503-221-0540', '503-242-9400', 2, NULL, '0');
INSERT INTO `REP` VALUES (2149, '', 'Bill', 'Prenger', 'BJP', 'billp@dbates.com', '503-221-0540', '503-796-1645', 2, NULL, '1');
INSERT INTO `REP` VALUES (2150, '', 'Brea', 'Sparks', 'BKS', 'breas@dbates.com', '503-224-6491', '503-241-9226', 1, NULL, '1');
INSERT INTO `REP` VALUES (2151, '', 'Charlotte', 'Shepherd', 'CBS', 'charlottes@dbates.com', '503-224-6491', '503-796-0290', 1, NULL, '1');
INSERT INTO `REP` VALUES (2152, '', 'Christen', 'Picot', 'CEP', 'christenp@dbates.com', '503-224-6491', '503-796-0291', 2, NULL, '1');
INSERT INTO `REP` VALUES (2154, '', 'Douglas', 'Miller', 'DAM', 'bigthe@bellsouth.net', '504-945-4930', '504-945-4930', 1, NULL, '0');
INSERT INTO `REP` VALUES (2156, '', 'Dennis', 'Peterson', 'DHP', 'dennisp@dbates.com', '503-221-0540', '503-796-1646', 2, NULL, '0');
INSERT INTO `REP` VALUES (2157, '', 'Joe', 'Collver', 'DJC', 'joec@dbates.com', '503-221-0540', '503-242-9408', 2, NULL, '1');
INSERT INTO `REP` VALUES (2226, '', 'Diane', 'Girard', '', 'dianeg@dbates.com', '503-221-0540', '503-241-9217', 2, NULL, '1');
INSERT INTO `REP` VALUES (2159, '', 'Debra', 'Hallock', 'DMH', 'debrah@dbates.com', '503-221-0540', '503-796-1649', 2, NULL, '1');
INSERT INTO `REP` VALUES (2214, '', 'Sara', 'Lewis', '', 'saral@dbates.com', '503-221-0540', '503-796-0296', 2, NULL, '1');
INSERT INTO `REP` VALUES (2164, '', 'Greg', 'Ryerson', 'GSR', 'gregr@dbates.com', '503-221-0540', '503-242-9405', 2, NULL, '1');
INSERT INTO `REP` VALUES (2166, '', 'Ingo', 'Wittig', 'IMW', 'iwittig@dbates.com', '503-224-6491', '503-241-9222', 1, NULL, '1');
INSERT INTO `REP` VALUES (2168, '', 'Julie', 'Greenley', 'JAG', 'julieg@dbates.com', '503-224-6491', '503-796-0292', 1, NULL, '1');
INSERT INTO `REP` VALUES (2174, '', 'Jeremy', 'Andersen', 'JLA', 'jeremya@dbates.com', '503-221-0540', '503-796-1642', 2, NULL, '1');
INSERT INTO `REP` VALUES (2176, '', 'Julie', 'Olver', 'JLO', 'julieo@dbates.com', '503-221-0540', '503-542-5207', 5, NULL, '1');
INSERT INTO `REP` VALUES (2227, '', 'Heather', 'Tombleson', '', 'heathert@dbates.com', '503-221-0540', '503-241-9210', 2, NULL, '1');
INSERT INTO `REP` VALUES (2179, '', 'Justine', 'Avera', 'JUA', 'justinea@dbates.com', '503-221-0540', '503-241-9229', 16, NULL, '0');
INSERT INTO `REP` VALUES (2180, '', 'Janna', 'Brown', 'JVB', 'jannab@dbates.com', '503-221-0540', '503-796-0293', 2, NULL, '1');
INSERT INTO `REP` VALUES (2181, '', 'Katrina', 'Green', 'KMG', 'katrinag@dbates.com', '503-224-4236', '503-241-9214', 3, NULL, '1');
INSERT INTO `REP` VALUES (2182, '', 'David', 'Hearns', 'LDH', 'davidh@dbates.com', '503-221-0540', '503-796-1640', 2, NULL, '1');
INSERT INTO `REP` VALUES (2183, '', 'Marie', 'Tedesco', 'MJT', 'mariet@dbates.com', '503-221-0540', '503-242-9409', 2, NULL, '1');
INSERT INTO `REP` VALUES (2218, '', 'Steven', 'Disque', '', 'steved@dbates.com', '503-224-4236', '503-242-9403', 3, NULL, '1');
INSERT INTO `REP` VALUES (2185, '', 'Mike', 'Davis', 'MLD', 'miked@dbates.com', '503-221-0540', '503-242-9402', 2, NULL, '1');
INSERT INTO `REP` VALUES (2222, '', 'Nancy', 'Parish', '', 'nancyp@dbates.com', '503-221-0540', '503-478-6617', 2, NULL, '1');
INSERT INTO `REP` VALUES (2223, '', 'Dan', 'Jewusiak', '', 'danj@dbates.com', '503-221-0540', '503-241-9219', 2, NULL, '1');
INSERT INTO `REP` VALUES (2224, '', 'Susan', 'Freer', '', 'susanf@dbates.com', '503-221-0540', '503-242-9409', 2, NULL, '1');
INSERT INTO `REP` VALUES (2216, '', 'Julie', 'Douglas', '', 'julied@dbates.com', '503-221-0540', '503-796-0294', 16, NULL, '1');
INSERT INTO `REP` VALUES (2217, '', 'Andrew', 'Lewis', '', 'andyl@dbates.com', '503-224-4236', '503-241-9213', 3, NULL, '1');
INSERT INTO `REP` VALUES (2195, '', 'Dick', 'Seekins', 'RLS', 'dicks@dbates.com', '503-221-0540', '503-241-9216', 2, NULL, '1');
INSERT INTO `REP` VALUES (2196, '', 'Bob', 'White', 'RMW', 'bobw@dbates.com', '503-224-4236', '503-241-9215', 3, NULL, '1');
INSERT INTO `REP` VALUES (2198, '', 'Susan', 'DeLair', 'SBD', 'susand@dbates.com', '503-423-9495', '503-241-9225', 4, NULL, '1');
INSERT INTO `REP` VALUES (2199, '', 'Stacey', 'Kramer', 'SLK', 'staceyk@dbates.com', '503-224-4236', '503-242-9406', 3, NULL, '1');
INSERT INTO `REP` VALUES (2200, '', 'Sean', 'McCarthy', 'SMM', 'seanm@dbates.com', '503-224-4236', '503-241-9228', 3, NULL, '1');
INSERT INTO `REP` VALUES (2215, '', 'Amy', 'Byerley', '', 'amyb@dbates.com', '503-224-4236', '503-478-6616', 3, NULL, '1');
INSERT INTO `REP` VALUES (2220, '', 'Joanna', 'Brown', '', 'joannab@dbates.com', '503-221-0540', '503-241-9221', 2, NULL, '1');
INSERT INTO `REP` VALUES (2205, '', 'Terri', 'Mayeda', 'TLC', 'terrim@dbates.com', '503-221-0540', '503-241-9218', 2, NULL, '0');
INSERT INTO `REP` VALUES (2207, '', 'Bill', 'Hurst', 'WDH', 'billh@dbates.com', '503-224-4236', '503-241-9212', 3, NULL, '1');
INSERT INTO `REP` VALUES (2209, '', 'Evelyn', 'Sorenson', 'EAS', 'evelyns@dbates.com', '503-221-0540', '503-796-1641', 2, NULL, '1');
INSERT INTO `REP` VALUES (2210, '', 'Alexandra', 'Koleno', 'AAK', 'alliek@dbates.com', '503-221-0540', '503-796-0295', 2, NULL, '1');
INSERT INTO `REP` VALUES (2225, '', 'Melody', 'Kirkendall', '', 'melodyk@dbates.com', '503-221-0540', '503-241-0154', 2, NULL, '1');
INSERT INTO `REP` VALUES (2221, '', 'Colleen', 'Aaker', '', 'colleena@dbates.com', '503-221-0540', '503-796-0297', 2, NULL, '1');

# --------------------------------------------------------

#
# Table structure for table `REP_ROLE`
#

CREATE TABLE `REP_ROLE` (
  `REP_ID` int(11) NOT NULL default '0',
  `ROLE_1` varchar(40) NOT NULL default '',
  `ROLE_2` varchar(40) NOT NULL default '',
  `ROLE_3` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`REP_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `REP_ROLE`
#

INSERT INTO `REP_ROLE` VALUES (2214, 'Commercial Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2215, 'Marine Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2174, 'Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2179, 'Select Accounts Department Manager', '', '');
INSERT INTO `REP_ROLE` VALUES (2220, 'Senior Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2180, 'Senior Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2205, 'Senior Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2157, 'Account Representative', '', '');
INSERT INTO `REP_ROLE` VALUES (2185, 'Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2198, 'Assistant Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2181, 'Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2168, 'Corporate Administrator', 'Secretary/Treasurer', '');
INSERT INTO `REP_ROLE` VALUES (2159, 'Assistant Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2148, 'Senior Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2182, 'Assistant Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2207, 'Chairman', '', '');
INSERT INTO `REP_ROLE` VALUES (2221, 'Account Executive', '', '');
INSERT INTO `REP_ROLE` VALUES (2210, 'Commercial Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2199, 'Assistant Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2200, 'Senior Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2154, 'former Web Admin', '', '');
INSERT INTO `REP_ROLE` VALUES (2176, 'Marketing & New Business Development Mgr', '', '');
INSERT INTO `REP_ROLE` VALUES (2156, 'Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2152, 'Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2149, 'Senior Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2164, 'Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2195, 'President', 'CEO', '');
INSERT INTO `REP_ROLE` VALUES (2151, 'Accounting Manager', '', '');
INSERT INTO `REP_ROLE` VALUES (2209, 'Senior Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2150, 'Administrative Assistant', 'Licensing Coordinator', '');
INSERT INTO `REP_ROLE` VALUES (2145, 'Administrative Coordinator', '', '');
INSERT INTO `REP_ROLE` VALUES (2183, 'Assistant Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2196, 'Marine Claims Manager', '', '');
INSERT INTO `REP_ROLE` VALUES (2166, 'Information Technology Manager', '', '');
INSERT INTO `REP_ROLE` VALUES (2216, 'Select Accounts Client Manager', '', '');
INSERT INTO `REP_ROLE` VALUES (2217, 'Account Executive', '', '');
INSERT INTO `REP_ROLE` VALUES (2218, 'Claims Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2222, 'Commercial Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2223, 'Account Manager', '', '');
INSERT INTO `REP_ROLE` VALUES (2224, 'Processor', '', '');
INSERT INTO `REP_ROLE` VALUES (2225, 'Account Administrator', '', '');
INSERT INTO `REP_ROLE` VALUES (2226, 'Assistant Vice President', '', '');
INSERT INTO `REP_ROLE` VALUES (2227, 'Account Administrator', '', '');

# --------------------------------------------------------

#
# Table structure for table `REP_SPECIALTY`
#

CREATE TABLE `REP_SPECIALTY` (
  `REP_ID` int(11) NOT NULL default '0',
  `SPECIALTY_ID` int(11) NOT NULL default '0'
) TYPE=MyISAM;

#
# Dumping data for table `REP_SPECIALTY`
#

INSERT INTO `REP_SPECIALTY` VALUES (2214, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2215, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2174, 6);
INSERT INTO `REP_SPECIALTY` VALUES (2174, 5);
INSERT INTO `REP_SPECIALTY` VALUES (2174, 4);
INSERT INTO `REP_SPECIALTY` VALUES (2174, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2179, 6);
INSERT INTO `REP_SPECIALTY` VALUES (2148, 12);
INSERT INTO `REP_SPECIALTY` VALUES (2180, 7);
INSERT INTO `REP_SPECIALTY` VALUES (2180, 8);
INSERT INTO `REP_SPECIALTY` VALUES (2180, 9);
INSERT INTO `REP_SPECIALTY` VALUES (2180, 10);
INSERT INTO `REP_SPECIALTY` VALUES (2205, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2157, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2185, 10);
INSERT INTO `REP_SPECIALTY` VALUES (2185, 11);
INSERT INTO `REP_SPECIALTY` VALUES (2198, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2181, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2168, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2159, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2148, 10);
INSERT INTO `REP_SPECIALTY` VALUES (2148, 4);
INSERT INTO `REP_SPECIALTY` VALUES (2148, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2182, 13);
INSERT INTO `REP_SPECIALTY` VALUES (2182, 7);
INSERT INTO `REP_SPECIALTY` VALUES (2207, 14);
INSERT INTO `REP_SPECIALTY` VALUES (2223, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2222, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2221, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2210, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2199, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2200, 14);
INSERT INTO `REP_SPECIALTY` VALUES (2154, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2220, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2176, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2156, 3);
INSERT INTO `REP_SPECIALTY` VALUES (2149, 7);
INSERT INTO `REP_SPECIALTY` VALUES (2152, 4);
INSERT INTO `REP_SPECIALTY` VALUES (2149, 13);
INSERT INTO `REP_SPECIALTY` VALUES (2149, 16);
INSERT INTO `REP_SPECIALTY` VALUES (2149, 17);
INSERT INTO `REP_SPECIALTY` VALUES (2164, 2);
INSERT INTO `REP_SPECIALTY` VALUES (2164, 7);
INSERT INTO `REP_SPECIALTY` VALUES (2195, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2151, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2209, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2150, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2145, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2182, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2183, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2196, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2166, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2216, 3);
INSERT INTO `REP_SPECIALTY` VALUES (2152, 6);
INSERT INTO `REP_SPECIALTY` VALUES (2152, 12);
INSERT INTO `REP_SPECIALTY` VALUES (2179, 4);
INSERT INTO `REP_SPECIALTY` VALUES (2179, 23);
INSERT INTO `REP_SPECIALTY` VALUES (2179, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2216, 10);
INSERT INTO `REP_SPECIALTY` VALUES (2216, 24);
INSERT INTO `REP_SPECIALTY` VALUES (2216, 25);
INSERT INTO `REP_SPECIALTY` VALUES (2156, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2174, 12);
INSERT INTO `REP_SPECIALTY` VALUES (2217, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2218, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2179, 7);
INSERT INTO `REP_SPECIALTY` VALUES (2182, 26);
INSERT INTO `REP_SPECIALTY` VALUES (2224, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2225, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2226, 1);
INSERT INTO `REP_SPECIALTY` VALUES (2227, 1);

# --------------------------------------------------------

#
# Table structure for table `SPECIALTY_DEF`
#

CREATE TABLE `SPECIALTY_DEF` (
  `SPECIALTY_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(50) NOT NULL default '',
  `ACTIVE` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`SPECIALTY_ID`)
) TYPE=MyISAM AUTO_INCREMENT=27 ;

#
# Dumping data for table `SPECIALTY_DEF`
#

INSERT INTO `SPECIALTY_DEF` VALUES (1, 'None', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (2, 'Construction', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (3, 'Workers\' Compensation', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (23, 'Executive Protection', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (4, 'Technology', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (5, 'Life Sciences', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (6, 'Professional Liability', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (7, 'Manufacturing', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (8, 'Distribution', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (9, 'Commercial Auto', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (10, 'General Business', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (11, 'Shoreside Marine', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (12, 'Management Liability', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (13, 'Food Processing', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (14, 'Ocean Marine/Cargo', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (15, 'Workers\' Comp', '0');
INSERT INTO `SPECIALTY_DEF` VALUES (16, 'Environmental', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (17, 'Real Estate', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (18, 'Construction', '0');
INSERT INTO `SPECIALTY_DEF` VALUES (19, 'Plastic Processors', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (20, 'Metalworking', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (21, 'Paper Products', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (22, 'Wholesale', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (24, 'Professional Services Offices', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (25, 'Investment Properties', '1');
INSERT INTO `SPECIALTY_DEF` VALUES (26, 'Property', '1');

# --------------------------------------------------------

#
# Table structure for table `USER`
#

CREATE TABLE `USER` (
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
) TYPE=MyISAM AUTO_INCREMENT=23 ;

#
# Dumping data for table `USER`
#

INSERT INTO `USER` VALUES (1, 'CLIENT1', '$1$3tXltAIe$alp3FUvP5sAwnIqD7T1UJ0', 'Test Client Inc', 'Valued Client', '503-224-5170', 'info@dbates.com', '1', 1);
INSERT INTO `USER` VALUES (14, 'select', '$1$noZYtOkj$PQq8Z3d0QS3SXo5c12A2m1', 'Select Accounts Client', 'Ingo Wittig', '503-224-5170', 'iwittig@dbates.com', '1', 1);
INSERT INTO `USER` VALUES (4, 'ZIDELL', '$1$2ejXcfLC$pV4dvjbkDNS8CmNTtARRl1', 'Zidell Marine', 'Kathleen Thompson', '503-937-2229', 'kathyt@zidell.com', '1', 1);
INSERT INTO `USER` VALUES (6, 'jsandlin', '$1$/KR7p8FS$F7rY5CefMn/sSwJm7XHwY/', 'James Sandlin', 'James Sandlin', '503-887-8510', 'james@caffeinewebdesign.com', '1', 3);
INSERT INTO `USER` VALUES (7, 'iwittig', '$1$1O8CkurR$KGpVLQ7gaqZC8bo6lLxb.0', 'Ingo Wittig', 'Ingo Wittig', '123-333-3333', 'iwittig@dbates.com', '1', 3);
INSERT INTO `USER` VALUES (8, 'test', '$1$371.Oq/.$VxqnOY9zRn1uwHqizzXv7.', 'test', 'test', '444-444-4444', 'james@caffeinewebdesign.com', '1', 1);
INSERT INTO `USER` VALUES (9, 'breas', '$1$IQ5Qt1VK$ZhkeKzLorkfYaUZlVm8Ri1', 'Brea Sparks', 'Brea Sparks', '503-241-9226', 'breas@dbates.com', '1', 2);
INSERT INTO `USER` VALUES (10, 'alisons', '$1$LBOc//nD$Xxe1d1LUWpq2KDN0vc9ee/', 'Alison Szalvay', 'Alison Szalvay', '503-478-6618', 'alisons@dbates.com', '1', 2);
INSERT INTO `USER` VALUES (13, 'julieo', '$1$tTs2ZyqF$fhIlFxiKiyOgFzwfhD3hu1', 'Julie Olver', 'Julie Olver', '503-542-5207', 'julieo@dbates.com', '1', 2);
INSERT INTO `USER` VALUES (0, 'root', '$1$2twmA8O3$fTa/qzvYGmMhvu06u49DZ0', 'root', 'James Sandlin', '503-887-8510', 'james@caffeinewebdesign.com', '1', 3);
INSERT INTO `USER` VALUES (18, 'Valued', '$1$4VNd2NK0$eETQd8Lm0ClO21TdpyKZN1', 'Valued Client', 'Valued Client', '503-224-5170', 'info@dbates.com', '1', 1);
INSERT INTO `USER` VALUES (19, 'DavidP', '$1$3t5GD9MF$ekNO75MkpXQv7JB1WETtJ/', 'David Paez', 'David Paez', '503-241-9220', 'davidp@dbates.com', '1', 1);
INSERT INTO `USER` VALUES (20, 'TUMAC', '$1$yph6IIoc$115lKDT3sKU/LwH.kVdGc0', 'Tumac Lumber Co.', 'Brad McMurchie', '(503)226-666', '', '1', 1);
INSERT INTO `USER` VALUES (21, 'steved', '$1$Qa9LQg3f$m.J56GjVqtghUKfSOGeOP/', 'Steve Disque', 'Steve Disque', '', '', '1', 2);
INSERT INTO `USER` VALUES (22, 'SALTCHUK', '$1$o/ORnHwr$i6e1KVNZvF8zmcmE.w54./', 'Saltchuk Resources, Inc.', 'Ellen Cooper', '', '', '1', 1);

# --------------------------------------------------------

#
# Table structure for table `USER_SEC_LVL`
#

CREATE TABLE `USER_SEC_LVL` (
  `SEC_LVL_ID` int(11) NOT NULL auto_increment,
  `SEC_LVL_NAME` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`SEC_LVL_ID`)
) TYPE=MyISAM AUTO_INCREMENT=4 ;

#
# Dumping data for table `USER_SEC_LVL`
#

INSERT INTO `USER_SEC_LVL` VALUES (1, 'CLIENT');
INSERT INTO `USER_SEC_LVL` VALUES (2, 'ADMIN');
INSERT INTO `USER_SEC_LVL` VALUES (3, 'ROOT');
