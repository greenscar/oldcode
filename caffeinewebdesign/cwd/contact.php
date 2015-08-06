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
<link href="styles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="script.js"></script>
<script language="JavaScript" type="text/javascript">
function protectmail() {
   var name = "contactus";
   var address = "caffeinewebdesign.com";
   var link = "email us";
   var subject = "Service Inquiry";
   document.write('<a class="email" href=mailto:' + name + '@' + address + '?subject=' + subject + '>' + link + '</a>');
}
function validateForm(form)
{
   if(field_is_blank(form, "first_name", "First Name"))
   {
   	  document.getElementById("first_name").className="textfield_incomplete";
   	  return(false);
   }
   if(field_is_blank(form, "last_name", "Last Name"))
   {
      document.getElementById("last_name").className="textfield_incomplete";
   	  return(false);
   }
   if(!check_email(form, "email"))
   {
      document.getElementById("email").className="textfield_incomplete";
   	  return(false);
   }
   return(true);
}
</script>
</head>
<body style="text-align: center; margin-left: auto; margin-right: auto;" background="#FFFFFF" onLoad="MM_preloadImages('/images/home_down.gif','images/services_down.gif','images/process_down.gif','images/portfolio_down.gif','images/about_down.gif','images/contact_down.gif');">
<div id="entireBody" style="position:relative; margin: 0 auto; width: 800px; height: 500;text-align: left;"> 
   <?php include("logo.inc");?>
   <?php include("menu_top.inc");?>
   <div id="subMenu" style="position:absolute; left:12px; top:180px; width:114px; height:400px; z-index:3; background-image: url(images/left_menu_center.gif); background-repeat: repeat-y;"> 
   <div id="subMenuTop" style="position:absolute; left:0px; top:0px; width:114px; height:33px; z-index:1;"> 
   <img src="images/left_menu_top.gif" width="114" height="33"> </div>
   <div id="subMenuTop" style="position:absolute; left:0px; bottom:-10px; width:114px; height:36px; z-index:1;padding:0px;border-width: 0px;"> 
   <img src="images/left_menu_bottom.gif" width="114" height="35" style="padding:0px;border-width: 0px;"> 
   </div>
   </div>
   <div id="body" style="position:absolute; left: 125px; top: 110px; width: 651px; height: 475px; padding:0px; border-width: 0px;z-index: 20;background-image: url(images/body_center.gif); background-repeat: repeat-y;"> 
   <div id="bodyTop" style="position:absolute; left:0px; top:0px; width:651px; height:72px;"> 
   <img src="images/body_top.gif" width="651" height="72"> </div>
   <div id="bodyCenter" style="position:relative;left:127px;right:127px;top:40px;z-index: 21;"> 
   </div>
   <div id="bodyBottom" style="position:absolute; left:0px; bottom:-5px; width:651px; height:70px; z-index:19;padding:0px;border-width: 0px;"> 
   <img src="images/body_bottom.gif" width="651" height="70" style="padding:0px;border-width: 0px;"><br>
   </div>
   <div id="content" style="position:absolute; width: 582px; left:40px; right:5%; top:25px; border: 0px solid #FF00FF; padding: 10px 0px 0px 0px; z-index: 30; height: 415px;"> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
   <?php
   require_once("./private_info/email.inc");
   if(isset($_POST["first_name"]))
   {
   require("./phpmailer-1.72/class.phpmailer.php");
   
   $mail = new PHPMailer();
   
   $mail->IsSMTP();                                   // send via SMTP
   $mail->Host     = "caffeinewebdesign.com"; // SMTP servers
   $mail->SMTPAuth = true;     // turn on SMTP authentication
   #$mail->Username = "caffeine";//$id;  // SMTP username
   #$mail->Password = ""; $pwd; // SMTP password
   
   $mail->From     = "contactus@caffeinewebdesign.com";
   $mail->FromName = "Contact Form";
   $mail->AddAddress("contactus@caffeinewebdesign.com","Caffeine Web Design");
   //$mail->AddAddress("jsandlin@gmail.com");               // optional name
   $mail->AddReplyTo("contactus@caffeinewebdesign.com","Caffeine Web Design");
   
   $mail->WordWrap = 50;                              // set word wrap
   //$mail->AddAttachment("/var/tmp/file.tar.gz");      // attachment
   //$mail->AddAttachment("/tmp/image.jpg", "new.jpg");
   $mail->IsHTML(true);                               // send as HTML
   
   $mail->Subject  =  "Caffeine Web Design - CONTACT US";
   $body = "<table width=\"400px\" border=\"0\">
   <tr valign=\"top\"> 
   <td width=\"30%\" class=\"bold\">First Name: *</td>
   <td width=\"35%\"> 
   <input name=\"first_name\" type=\"text\" id=\"first_name\" style=\"width: 210px;\" value=\"" . $_POST["first_name"] . "\"></td>
   <td width=\"35%\" rowspan=\"8\" style=\"border-left: 1px solid #333333;\"> 
   </td>
   </tr>
   <tr valign=\"top\"> 
   <td class=\"bold\">Last Name: *</td>
   <td> 
   <input name=\"last_name\" type=\"text\" id=\"last_name\" style=\"width: 210px;\" value=\"" . $_POST["last_name"] . "\"></td>
   </tr>
   <tr valign=\"top\"> 
   <td class=\"bold\">Email Address: *</td>
   <td> 
   <input name=\"email\" type=\"text\" id=\"email\" style=\"width: 210px;\" value=\"" . $_POST["email"] . "\"></td>
   </tr>
   <tr valign=\"top\"> 
   <td class=\"bold\">Phone Number:</td>
   <td> 
   <input name=\"phone\" type=\"text\" id=\"phone\" class=\"textfield\"";
   if(isset($_POST["phone"]))
   $body .= " value=\"" . $_POST["phone"] . "\"";
   $body .= "></td>
   </tr>
   <tr valign=\"top\"> 
   <td height=\"100\" class=\"bold\">Services Wanted:</td>
   <td> 
   <input name=\"services_wanted_1\" type=\"checkbox\" id=\"services_wanted_1\" value=\"site_from_scratch\"";
   if(isset($_POST["services_wanted_1"]))
   $body .= " checked";
   $body .= ">
   Create site from scratch<br>
   <input name=\"services_wanted_2\" type=\"checkbox\" id=\"services_wanted_2\" value=\"site_from_your_design\"";
   if(isset($_POST["services_wanted_2"]))
   $body .= " checked";
   $body .= ">
   Create site from your design<br>
   <input name=\"services_wanted_3\" type=\"checkbox\" id=\"services_wanted_3\" value=\"e_commerce\"";
   if(isset($_POST["services_wanted_3"]))
   $body .= " checked";
   $body .= ">
   E-Commerce site<br>
   <input name=\"services_wanted_4\" type=\"checkbox\" id=\"services_wanted_4\" value=\"site_redesign\"";
   if(isset($_POST["services_wanted_4"]))
   $body .= " checked";
   $body .= ">
   Site Redesign<br>
   <input name=\"services_wanted_5\" type=\"checkbox\" id=\"services_wanted_5\" value=\"flash_animation\"";
   if(isset($_POST["services_wanted_5"]))
   $body .= " checked";
   $body .= ">
   Flash Animation<br>
   <input name=\"services_wanted_6\" type=\"checkbox\" id=\"services_wanted_6\" value=\"content_management\"";
   if(isset($_POST["services_wanted_6"]))
   $body .= " checked";
   $body .= ">
   Content Management<br>
   <input name=\"services_wanted_7\" type=\"checkbox\" id=\"services_wanted_7\" value=\"search_engine_optimization\"";
   if(isset($_POST["services_wanted_7"]))
   $body .= " checked";
   $body .= ">
   Search Engine Optimization</td>
   </tr>
   <tr valign=\"top\"> 
   <td class=\"bold\">Additional Information:</td>
   <td>&nbsp;</td>
   </tr>
   <tr valign=\"top\"> 
   <td colspan=\"2\"> 
   <textarea name=\"textarea\" style=\"width: 390px; height: 90px;\">";
   if(isset($_POST["details"]))
   $body .= $_POST["details"];
   $body .= "</textarea> 
   </td>
   </tr>
   </table>
   ";
   
   
   $mail->Body     =  $body;
   if((strpos($_POST["details"], ".ru/")) || (strpos($_POST["details"], "href")))
   {
	   echo "<br><br><p>Thank you for contacting Caffeine Web Design. <br><br>We will contact you shortly.</p>";
   }
   else if(!$mail->Send())
   {
   echo "Message was not sent <p>";
   echo "Mailer Error: " . $mail->ErrorInfo;
   exit;
   }
   
   echo "<br><br><p>Thank you for contacting Caffeine Web Design. <br><br>We will contact you shortly.</p>";
   }
   else
   {
   ?>
   <h3 align="center">Contact Us</h3>
   <form name="form1" method="post" action="<?php echo($_POST["PHP_SELF"]); ?>" onsubmit="return validateForm(this);">
   <table width="100%" border="0" style="padding-top:10px;">
   <tr valign="top"> 
   <td width="30%" class="bold">First Name: *</td>
   <td width="35%"> 
   <input name="first_name" type="text" id="first_name" class="textfield"></td>
   <td width="35%" rowspan="8" style="border-left: 1px solid #333333;"> 
   <table width="100%" height="100%" border="0">
   <tr> 
   <td align="right"><strong>Caffeine Web Design</strong><br>
   1607 NE 19th Ave<br>
   Portland, OR 97232</td>
   </tr>
   <tr>
   <td align="right">&nbsp;</td>
   </tr>
   <tr> 
   <td align="right" class="bold" style="border-bottom: 1px solid #333333;">Phone:</td>
   </tr>
   <tr> 
   <td align="right">503-887-8510</td>
   </tr>
   <tr> 
   <td align="right">&nbsp;</td>
   </tr>
   <tr> 
   <td align="right" class="bold" style="border-bottom: 1px solid #333333;">Email:</td>
   </tr>
   <tr> 
   <td align="right">
   <script language="JavaScript" type="text/javascript">
   protectmail();
   </script>
   </td>
   </tr>
   <tr> 
   <td align="right">&nbsp;</td>
   </tr>
   </table></td>
   </tr>
   <tr valign="top"> 
   <td class="bold">Last Name: *</td>
   <td> 
   <input name="last_name" type="text" id="last_name" class="textfield"></td>
   </tr>
   <tr valign="top"> 
   <td class="bold">Email Address: *</td>
   <td> 
   <input name="email" type="text" id="email" class="textfield"></td>
   </tr>
   <tr valign="top"> 
   <td class="bold">Phone Number:</td>
   <td> 
   <input name="phone" type="text" id="phone" class="textfield"></td>
   </tr>
   <tr valign="top"> 
   <td height="100" class="bold">Services Wanted:</td>
   <td> 
   <input name="services_wanted_1" type="checkbox" id="services_wanted_1" value="site_from_scratch">
   Create site from scratch<br> <input name="services_wanted_2" type="checkbox" id="services_wanted_2" value="site_from_your_design">
   Create site from your design<br> <input name="services_wanted_3" type="checkbox" id="services_wanted_3" value="e_commerce">
   E-Commerce site<br> <input name="services_wanted_4" type="checkbox" id="services_wanted_4" value="site_redesign">
   Site Redesign<br> <input name="services_wanted_5" type="checkbox" id="services_wanted_5" value="flash_animation">
   Flash Animation<br> <input name="services_wanted_6" type="checkbox" id="services_wanted_6" value="content_management">
   Content Management<br> <input name="services_wanted_7" type="checkbox" id="services_wanted_7" value="search_engine_optimization">
   Search Engine Optimization</td>
   </tr>
   <tr valign="top"> 
   <td class="bold">Additional Information:</td>
   <td>&nbsp;</td>
   </tr>
   <tr valign="top"> 
   <td colspan="2"> 
   <textarea name="details" class="details"></textarea> 
   </td>
   </tr>
   <tr valign="top"> 
   <td>&nbsp;</td>
   <td> 
   <input type="submit" name="Submit" value="Submit"></td>
   </tr>
   </table>
   <br>
   </form>
   <?
   }
   ?>
   </div>
   <?php include("bottom_toolbar.inc");?>
   </div>
</div>
<!-- body -->
</body>
</html>
