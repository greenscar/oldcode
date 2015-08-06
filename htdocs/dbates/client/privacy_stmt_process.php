<?php
require_once("ensure_client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
$log = new Secretary();
if((empty($_POST["agree"]) || strcmp($_POST["agree"], "I Agree") != 0))
{
   $log->write("USER HAS NOT AGREED. LOG THEM OUT.");
   header("Location: ./logout.php");
   exit();
}
if($security->user_is_sa_user($client))
{
   $log->write("SELECT ACCOUNT USER LOGGING IN -> FORWARD TO SELECT ACCOUNT PAGE");
   header("Location: sa_cp.php");
   exit();
}
if($client->dbLoadCustomPages($dbmgr))
{
   if(($client->hasCPage($dbmgr)) && !($client->hasBFPage($dbmgr)))
   {
      // HAS CUSTOM PAGE BUT NOT BATCH IMAGE PAGE
      // FORWARD TO CUSTOM PAGE.
      $log->write("HAS CUSTOM PAGE BUT NOT BATCH IMAGE PAGE -> FORWARD TO CUSTOM PAGE.");
      header("Location: custom_page.php");
      exit();
   }
   $log->write("-------------");
   if(!($client->hasCPage($dbmgr)) && ($client->hasBFPage($dbmgr)))
   {
      // HAS BATCH IMAGE PAGE BUT NOT CUSTOM PAGE
      // FORWARD TO BATCH IMAGE PAGE
      $log->write("HAS BATCH IMAGE PAGE BUT NOT CUSTOM PAGE -> FORWARD TO BATCH IMAGE PAGE");
      header("Location: batch_file_page.php");
      exit();
   }
   $log->write("-------------");
   if(($client->hasCPage($dbmgr)) && ($client->hasBFPage($dbmgr)))
   {
   ?>
   
         <html>
<head>
   <title>Durham and Bates - Portland, OR - Client Menu</title>
   <style type="text/css">@import "../template_public.css";</style>
   <script language="JavaScript" type="text/javascript" src="script.js"></script>
</head>
   <table align="center" width=750px height=552px style="border: 1px solid #000000; border-spacing: 0px;border-collapse: collapse; padding: 0px;margin:0px auto;">
      <tr>
         <td colspan="2" align="right" valign="middle">
            <div class="topBar" style="background-color: #899E88;">
               <input type="text" name="searchFor" class="searchText"></input>
               <input type="submit" name="Search" value="Search Site" class="searchButton" onMouseOver="this.style.backgroundColor='#003366'"; onMouseOut="this.style.backgroundColor='#006390'">
            </div>
         </td>
      </tr>
      <tr>
         <?php include("../menu_left.inc");?>
         <td width="500px" style="background-color:#FFF9EC;padding: 0px; vertical-align: top;">
            <table class="title">
               <tr>
                  <td>
                     <img class="title" src="../public_images/map.jpg" alt="Custom Pages" >
                  </td>
                  <td style="padding: 0 0 2px 10px;">
                     <font class="pageTitle"><?php echo($client->name); ?></font>
                  </td>
               </tr>
            </table>
            <br><br>
            <table align="left" border=0 style="left: 5px; top:180px; width: 490px;font-size: 13px; font-family: 'Verdana', Verdana, sans-serif;">
               <tr>
                  <td align="center">
                     <?php
                  
                     if($client->hasCPage($dbmgr))
                     {
                        echo("<a href=\"custom_page.php\" class=\"custPage\">Client Page</a>&nbsp;&nbsp;");
                     }
                     if($client->hasBFPage($dbmgr))
                     {
                        echo("<a href=\"batch_file_page.php\" class=\"custPage\">File Download</a>");
                     }
                     ?>
                  </td>
               </tr>
            </table>    
         </td>
      </tr>
      <tr>
      <td align="center" colspan="2" style="background-color: #899E88; border-top: 1px #006390 solid; border-bottom: 2px #006390 solid; top: 0px;left: 0px;padding: 0px;">
         <a href="../index.php" class="menuBottom" style="color:<?php echo($color);?>">Home</a>
         <a href="mailto://info@dbates.com" class="menuBottom" style="color:<?php echo($color);?>">Contact Us</a>
         <a href="../site_map.php" class="menuBottom" style="color:<?php echo($color);?>">Site Map</a>
         <a href="../search.php" class="menuBottom" style="color:<?php echo($color);?>">Search Site</a>
         <a href="../privacy.php" class="menuBottom" style="color:<?php echo($color);?>">Privacy Policy</a>
         <a href="http://www.caffeinewebdesign.com" class="menuBottom"  target="_BLANK" style="color:<?php echo($color);?>">Site by Caffeine Web Design</a>
      </td>
      </tr>
   </table>
   </html>
   <?php
   }
   else
   {
      header("Location: ./logout.php");
   }
}
else
{
   echo("<H1>YOU DO NOT HAVE A CUSTOM PAGE</H1>");
   echo("<H2>If you feel this is an error, please contact Durham & Bates.</h2>");
   echo("<a href=\"" . $_SERVER["PHP_SELF"] . "\">BACK</A>");
}
?>