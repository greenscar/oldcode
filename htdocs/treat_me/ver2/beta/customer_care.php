<?php
$title = "";
$page_header = "./page_headers/customer_care_header.gif";
$page_height = 750;
$onload = "preloadImages('images/contact_us_email_cursive_over.gif')";
include("header.inc");
?>
<body>
<div class="body" style="padding-top: 0px;"> 
  <div align="center">
  <img src="./page_bodies/customer_care_body.gif">
  </div>
  <div align="center" style="padding-left: 110px">
  <a href="mailto:contactus@treatmenu.com" onMouseOut="swapImgRestore()" onMouseOver="swapImage('contact_us','','images/contact_us_email_cursive_over.gif',1)">
  <img src="images/contact_us_email_cursive.gif" alt="contactus@treatmenu.com" name="contact_us" width="253" height="30" border="0">
  </a> 
  </div>
  <div align="center">
  <img style="margin: 20px 0px 0px 40px;" src="./images/treat_yourself_and_enjoy.gif">
  </div>
</div>
	
	
<?php
include("footer.inc");
?>