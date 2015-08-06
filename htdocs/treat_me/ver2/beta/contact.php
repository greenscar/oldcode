<?php
$title = "";
$page_header = "";
$onload = "preloadImages('images/contact_us_email_over.gif')";
include("header.inc");
?>

<body >
<div class="body" style="padding-top: 10px;">
   <table width=100% align="center">
      <tr>
         <td align="center">
            <img src="images/mailing_address_phone.gif"  border="0" align="center"> 
         </td>     
      </tr>
      <tr>
         <td align="center">
            <img align="center" src="images/contact_us.gif" border="0"> 
         </td>
      </tr>
      <tr>
         <td align="center"> 
            <a href="mailto:contactus@treatmenu.com" onMouseOut="swapImgRestore()" onMouseOver="swapImage('contact_us','','images/contact_us_email_over.gif',1)">
               <img src="images/contact_us_email.gif" alt="contactus@treatmenu.com" name="contact_us" border="0">
            </a> 
         </td>
      </tr>
   </table>
</div>
	
	
<?php
include("footer.inc");
?>