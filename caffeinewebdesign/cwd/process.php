<?php
include("get_browser_type.inc");
if(strcmp($browser_agent, "ie") == 0)
{
   $submenu_height =985;
   $body_height = 1060;
}
else
{
   $submenu_height = 885;
   $body_height = 960;
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Caffeine Web Design - Portland, OR - E-Commerce and Web Development</title>
<meta name="keywords" content="web design, web company, web development, e-commerce, database, shopping cart, server side, scripting, portland oregon, portland or, portland, or, PHP, MySQL, java, JSP, servlets, CSS, DHTML, JavaScript">
<meta name="Description" content="Caffeine Web Design - Portland, OR based company specializing in server side functionality for your web site.">
<META NAME="revisit-after" CONTENT="10 days">
<meta name="robots" content="index,follow">
<META NAME="classification" CONTENT="computer,internet">
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/javascript" src="script.js"></script>
<link href="styles.css" rel="stylesheet" type="text/css"/>
</head>

<body style="text-align: center; margin-left: auto; margin-right: auto;" background="#FFFFFF" onLoad="MM_preloadImages('images/home_down.gif','images/services_down.gif','images/process_down.gif','images/portfolio_down.gif','images/about_down.gif','images/contact_down.gif');">
<div id="entireBody" style="position:relative; margin: 0 auto; width: 800px; height: 500;text-align: left;"> 
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
    <div id="bodyCenter" style="position:relative;left:250px;right:127px;top:50px;z-index: 21;"> 
      <h3><font face="Verdana, Arial, Helvetica, sans-serif">THE PROCESS</font></h3>
    </div>
    <div id="bodyBottom" style="position:absolute; left:0px; bottom:-5px; width:651px; height:70px; z-index:30;padding:0px;border: 0px solid green;"> 
      <img src="images/body_bottom.gif" width="651" height="70" style="padding:0px;border-width: 0px;"><br>
    </div>
   <div style="position:absolute;width: 90%; left:5%;right:5%;top:75px; border: 0px solid #FF00FF; padding: 10px 0px 0px 0px;z-index: 30; "> 
      <hr>
         <h3>Free Initial Consultation</h3>
         <p>
            Once you have contacted Caffeine Web design, we will set up a convenient time to meet with you and discuss the details of your
            project. After our initial meeting, we will submit a written proposal to you with specific details of the work to be completed, 
            estimated time line, and cost of the project.  A 25% down payment and your signature on the proposal will serve as a contract
            of services for your web design project.
         </p>
         <p>
            To get you started thinking about your web design project, please feel free to download and complete our
            <a href=# class="process" onclick="alert('Coming Soon');">Web Design Questionnaire</a>. This document will give us a good
            idea of the goals, objectives, and functionality of your website and will help facilitate our initial meeting.     
         </p>
         <h3>Step 1: Design Examples</h3>
         <p>
            During this step, we will create a few examples for the look and feel of your website for you to choose from. If you already
            have a company logo, colors, and accompanying graphics, we will use those in our example pages.  Also, depending on the
            functionality you may require, we will show you the different possibilities for incorporating that functionality into your website.
         </p>
         <h3>Step 2: Implementing, Testing, & Revising</h3>
         <p>
            Once you have chosen the design, we will begin building your website.  Building your site consists of the following:
	 </p>
         <ul>
            <li>coding customized functionality</li>
            <li>coding the HTML/CSS/JavaScript pages</li>
            <li>creating graphics</li>
            <li>optimizing the load time of each page</li>
            <li>search engine optimization</li>
         </ul>
         <p>
            Once we have a working website created, we will place the site in a testing area where you can proof, test, and make any
            requests for modifications you would like.  Once the site is loaded in the test environment, a payment equal to 50% of the
            project is required.
         </p>
         <h3>Step 3: Delivery of the Final Site & Training</h3>
         <p>
            Once all modification have been made and your are ready to make the site live, the final payment equal to 25% of the project
            is required.  We will then upload your site to the appropriate URL address and provide you with a copy of the code and any
            graphics on CD. Also, we will provide any training you may require for your site at this time.
         </p>
         <h3>Any Questions?</h3>
         <p>
            If you have any questions, please <a class="process" href="contact.php">contact us</a> at any time. We will be happy to give
            you a more detailed explanation or discuss the particulars of your website.
         </p>
         <p>
            Thank You.<br>
            Caffeine Web Design
         </p>
      </div>
<?php include("bottom_toolbar.inc");?>
  </div>
</div>
<!-- body -->
</body>
</html>
