<?php
session_start(); 
header("Cache-control: private"); // ie 6 fix
if($require_admin)
{
   if(!(isset($_SESSION['user'])))
   {
      header("Location: index.php");
      exit();
   }
}
// Set page height    
if(empty($page_height)) $page_height = 700;
$header_height = 180;
if(empty($footer_height)) $footer_height = 50;
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="keywords" content="ACS, American, Crime, School">
<meta name="Description" content="American Crime School">
<META NAME="classification" CONTENT="education">
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">@import "css_template.css"; </style>
<script language="JavaScript" type="text/javascript" src="./javascript.js"></script>
<title>
<?php
echo($title);
if(empty($page_height)) $page_height = 700;
$header_height = 180;
if(empty($footer_height)) $footer_height = 50;
?>
</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body >
   <!-- START BODY DIV -->
   <div id="fullbody" style="margin-top:10px;padding:0px;height:<?php echo($page_height); ?>px;text-align:center;width:800px;border:#000000 1px solid;background-color:#FFFFFF;margin-left: auto; margin-right: auto;">
      <div id="header">
         <!-- LOGO -->
         <div style="float:left;">
            <a href="index.php" style="padding: 0px; margin: 0px;">
               <img src="images/logo.gif" alt="American Crime School" border="0" style="position:relative; z-index:4; left:15px;top:7px;padding: 0px; margin: 0px;"> 
            </a>
         </div>
         <!-- END LOGO -
         <!-- PAGE TITLE -->
         <div style="float:left; padding-top: 10px;margin-left:-50px;z-index:1;">
         
            <span style="position:relative; left: 70px;z-index:1;">
            <img src="images/american_crime_school.gif">
            </span>
            
            <!--
            <style="font-size:70px; font-family:arial; font-weight:bold; position: relative; left: 64px;padding: 0px; margin: 0px;">American Crime School</span><br>
            <span style="font-size:45px; font-family:arial narrow; font-weight:bold; position: relative; left: 60px;padding: 0px; margin: 0px;">The Science of Crime Scenes</span>
            -->
            <span style="position:relative; left: 45px;top:-22px;z-index:10;">
            <img src="images/science_of_crime_scenes.gif">
            </span>
         </div>
         <!-- END PAGE TITLE -->
      </div>
      <!-- START BODY CONTENTS -->
      <div id="contents" style="border:0px dashed red; height:<?php echo($page_height - $header_height - $footer_height); ?>px;">
         <!-- START MENU FRAME -->
         <div id="menuframe">
            <div class="buttons">
            <ul style="list-style-image:url(images/red_light.gif);list-style-type:disc;list-style-position: outside; ">
              <li style="padding-left: 0px;" class="menu">
                <a href="index.php" class="button" style="margin-top:15px;"> 
                   Home
                </a>  
              </li>
	      <li  class="menu">
                <a href="forensic_consultation.php" class="button"> 
                   Forensic Consultation
                </a>
            </li> 
         
            <li  class="menu">
                <a href="about_acs.php" class="button"> 
                   About ACS
                </a>
            </li>
            <li  class="menu">
                <a href="courses.php" class="button"> 
                   Courses
                </a>
            </li>
            <li  class="menu">
                <a href="register.php" class="button"> 
                   Register For A Class
                </a>
            </li>
            <li  class="menu">
                <a href="withdraw.php" class="button"> 
                   Withdraw From A Class
                </a>
            </li>
            <li  class="menu">
                <a href="hosting.php" class="button"> 
                   Hosting an ACS Class
                </a>
            </li>
            <li  class="menu">
                <a href="course_descriptions.php" class="button"> 
                   Course Description
                </a>
            </li>
            <!--
            <li  class="menu">
                <a href="schedule.php" class="button"> 
                   Course Schedule
                </a>
            </li>
            -->
            <li  class="menu">
                <a href="response.php" class="button"> 
                   Student Response
                </a>
            </li>
	    <!--
            <li  class="menu">
                <a href="docs/racehorse.doc" class="button"> 
                   Student Publications
                </a>
            </li>
	    -->
            <li  class="menu">
                <a href="docs/perfect.crime.final.mw.002.doc" class="button"> 
                   Student Publications
                </a>
            </li>
            <li  class="menu">
                <a href="instructors.php" class="button"> 
                   The Instructors
                </a>
            </li>
            <li  class="menu">
                <a href="advisory_board.php" class="button"> 
                   Advisory Board
                </a>
            </li>
            <li  class="menu">
                <a href="links.php" class="button"> 
                   Professional Links
                </a>
            </li>
	    <!--
            <li  class="menu">
                <a href="journals.php" class="button"> 
                   Journals (IFSC)
                </a>
            </li>
	    -->
	    <!--
            <li  class="menu">
                <a href="advisors.php" class="button"> 
                   ACS Blog
                </a>
            </li>
	    -->
            <li  class="menu">
                <a href="conferences.php" class="button"> 
                   Conferences
                </a>
            </li>
            <li  class="menu">
                <a href="csi_junior.php" class="button"> 
                   CSI Junior
                </a>
            </li>
            <li  class="menu">
                <a href="current_news_events.php" class="button"> 
                   Current News & Events
                </a>
            </li>
            <li  class="menu">
                <a href="powerpoints.php" class="button"> 
                   Powerpoints
                </a>
            </li>
	    <!--
            <li  class="menu">
                <a href="specialtraining.php" class="button"> 
                   Special Training Courses
                </a>
            </li>
	    -->
            </ul>
            </div> <!-- buttons -->
         </div> <!-- END MENU FRAME -->
