<?php
include("get_browser_type.inc");
if(strcmp($browser_agent, "ie") == 0)
{
   $submenu_height =1270;
   $body_height = 1345;
}
else
{
   $submenu_height = 1170;
   $body_height = 1245;
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Caffeine Web Design - Portland, OR - E-Commerce and Web Development</title>
<meta name="keywords" content="web design, web company, web development, e-commerce, database, shopping cart, server side, scripting, portland oregon, portland or, portland, or, PHP, MySQL, java, JSP, servlets, CSS, DHTML, JavaScript">
<meta name="Description" content="Caffeine Web Design - Portland, OR based company specializing in server side functionality for your web site.">
<META NAME="revisit-after" CONTENT="30 days">
<meta name="robots" content="index,follow">
<META NAME="classification" CONTENT="computer,internet">
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/javascript" src="script.js"></script>
<link href="styles.css" rel="stylesheet" type="text/css"/>
</head>

<body style="text-align: center; margin-left: auto; margin-right: auto;" background="#FFFFFF" onLoad="MM_preloadImages('images/home_down.gif','images/services_down.gif','images/process_down.gif','images/portfolio_down.gif','images/about_down.gif','images/contact_down.gif');">
<div id="entireBody" style="position:relative; margin: 0 auto; width: 800px; height: 500px;text-align: left;"> 
   <?php include("logo.inc");?>
   <?php include("menu_top.inc");?>
   <div id="subMenu" style="position:absolute; left:12px; top:180px; width:114px; height:<?=$submenu_height?>px; z-index:3; background-image: url(images/left_menu_center.gif); background-repeat: repeat-y;"> 
      <div id="subMenuTop" style="position:absolute; left:0px; top:0px; width:114px; height:33px; z-index:1;"> 
         <img src="images/left_menu_top.gif" width="114" height="33"> </div>
         <div id="subMenuTop" style="position:absolute; left:0px; bottom:-10px; width:114px; height:36px; z-index:1;padding:0px;border-width: 0px;"> 
            <img src="images/left_menu_bottom.gif" width="114" height="35" style="padding:0px;border-width: 0px;"> 
         </div>
      </div>
      <div id="body" style="position:absolute; left: 125px; top: 110px; width: 651px; height: <?=$body_height?>px; padding:0px; border-width: 0px;z-index: 20;background-image: url(images/body_center.gif); background-repeat: repeat-y;"> 
         <div id="bodyTop" style="position:absolute; left:0px; top:0px; width:651px; height:72px;"> 
            <img src="images/body_top.gif" width="651" height="72"> </div>
         <div id="bodyCenter" style="position:relative;left:255px;right:127px;top:50px;z-index: 21;"> 
         <h3><font face="Verdana, Arial, Helvetica, sans-serif">SERVICES</font></h3>
      </div>
      <div id="bodyBottom" style="position:absolute; left:0px; bottom:-5px; width:651px; height:70px; z-index:19;padding:0px;border-width: 0px;"> 
         <img src="images/body_bottom.gif" width="651" height="70" style="padding:0px;border-width: 0px;"><br>
      </div>
      <div id="content" style="position:absolute;width: 90%; left:5%;right:5%;top:75px; border: 0px solid #FF00FF; padding: 10px 0px 0px 0px; z-index:30;">
         <hr>
         <h3>Custom Website Design & Development</h3>
         <p>
         Planning, organizing, designing, and developing professional and innovative websites that meet your business needs is our business.
         Our professional team is dedicated to building our clients effective and visually appealing websites that provide value to the
         customers who visit their site.  Whether you need a site that creates an easy online shopping experience, provides dynamic
         information, or showcases something unique or special, Caffeine Web Design can get you there.  
         </p>
         <h3>Website Redesign or Enhancements</h3>
         <p>
         Websites often need refinement and improvement over time to maintain a positive customer experience and meet the needs of your
         growing business. Over time, your may need to add new pages to your site as you provide additional information to your 
         clients or the products and services you offer evolves over time. Caffeine Web Design can update your website or if needed,
         give your site a fresh new look that reflects your image and meets your current needs . 
         </p>
         <h3>Adding Functionality</h3>
         <p>
         Caffeine Web Design programming professionals use a wide variety of available technologies to make sure your site contains
         all the functionality your business requires. The right functionality for your site depends on the objectives of your website.
         Caffeine Web Design specializes in designing completely customized applications that will provide your website with any
         functionality you may require. At Caffeine, We want your site to meet all of your goals and expectations as well as the goals
         and expectations of your users. Below are a few examples of functionality you may wish to include in your site.
         </p>
         <ul>
         <li>Mailing Lists / Newsletters</li>
         <li>Registered User Lists</li>
         <li>Dynamic Content Management</li>
         <li>Customer Specific Information</li>
         <li>Inventory Tracking</li>
         <li>Adding Questioners or Forms to your site</li>
         <li>Database Driven site content</li>
         </ul>
         <h3>Database Connectivity</h3>
         <p>
         A database is an efficient method for storing customer contact information or managing your inventory.  If you site requires a
         database, we have the experience to build an efficient data storage repository to meet your needs.
         </p>
         <h3>Maintaining Your Website</h3>
         <p>
         Caffeine Web Design is available for contract hire at an hourly rate for any maintenance your website may require.  In addition,
         we build custom applications for your website that will allow you or your employees to perform any routine maintenance such as
         swapping out graphics or photographs, content management, or modifying, deleting, or adding inventory. 
         </p>
         <h3>Domain Names and Hosting</h3>
         <p>
         We can help you determine the best domain name for your website, make sure it is available, and register it. Based on your
         particular needs, we will help determine the best hosting company for your site's traffic.  A hosting company will charge a
         monthly fee for hosting your website. We will contact the hosting company and help you get setup with a hosting package that
         is right for you. If you prefer, we do offer a monthly site maintenance program which will include host maintenance and all minor
         updates to your site. Send us an email or give us a call for more information.
         </p>
         <h3>Search Engine Ranking and Optimization</h3>
         <p>
         We are dedicated to improving the visibility of your site to the people who are searching for the information or products your
         website has to offer. Our goal is to drive as much traffic to your site in the most cost-effective manor. Search engine optimization
         is the best way to accomplish this goal.  Other options are available, such as directory listing and pay-per-click.  We can also
         help you with these services if you would like to <br>pursue either of these avenues.
         </p>
      </div>
      <?php include("bottom_toolbar.inc");?>
   </div>
</div>
<!-- body -->
</body>
</html>
