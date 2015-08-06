<?php
require_once("ensure_client.inc");
if(($security->user_is_sa_user($client)) || ($client->dbLoadCustomPages($dbmgr)))
{
   if(($client->hasCPage($dbmgr)) || ($client->hasBFPage($dbmgr)) || ($security->user_is_sa_user($client)))
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
         <?php include("../menu_left_secure.inc");?>
         <td width="500px" style="background-color:#FFF9EC;padding: 0px; vertical-align: top;">
            <table class="title">
               <tr>
                  <td>
                     <img class="title" src="../public_images/map.jpg" alt="Commercial Insurance" >
                  </td>
                  <td style="padding: 0 0 2px 10px;">
                     <font class="pageTitle"><?php echo($client->name); ?></font>
                  </td>
               </tr>
            </table>
            <br><br>
            <table align="left" border=0 style="left: 5px; top:80px; width: 490px;font-size: 13px; font-family: 'Verdana', Verdana, sans-serif;">
               <tr>
                  <td style="padding-left: 5px;">
                     <p>
                        While we make every effort to preserve the confidentiality and privacy of the information
                        transmitted through this site, Durham and Bates cannot guarantee the absolute confidentiality
                        of this transaction. Any information provided by you to D&B, including but not limited to
                        client/policy data, feedback, questions, comments, suggestions or the like, shall be deemed
                        to be non-confidential. However, D&B will not use your name or otherwise publicize the fact
                        that you submitted materials or other information to D&B unless:
                    </p>
                    <p>
                        <ul>
                            <li>
                                We ask your permission to use your name; or
                            </li>
                            <li>
                                We first notify you that the materials or other information you submit to
                                particular part of this site will be published or otherwise used with your name on it; or
                            </li>
                            <li>
                                We are required to do so by law.
                            </li>
                        </ul>
                    <p>
                        Any policy changes or endorsement requests made by you to D&B shall not be taken as complete
                        until a written or verbal confirmation is given by D&B.
                    </p>
                    <p>
                        Should you have any interest in a particular product or service, or in information discussed
                        or described in the Durham & Bates Agencies, Inc. website, please contact our representative for
                        further information.
                    </p>
                    <p>
                        Additionally this website provide links to other sites which D&B does not maintain. D&B is not
                        responsible for the content of those sites, which are referenced as additional information sources
                        only, and that these links do not imply endorsement by D&B.
                    </p>
                     </p>
                  </td>
               </tr>
               <tr>
                  <td align="center">
                     <form name="form" method="POST" action="./privacy_stmt_process.php">
                        <input type="hidden" name="agree" value="agree">
                        <input type="submit" name="agree" value="I Agree">
                     </form>
                     <form name="form" method="POST" action="./privacy_stmt_process.php">
                        <input type="hidden" name="agree" value="disagree">
                        <input type="submit" name="agree" value="I Disagree">
                     </form>
                  </td>
               </tr>
            </table>    
         </td>
      </tr>
      <tr>
      <td align="center" colspan="2" style="background-color: #899E88; border-top: 1px #006390 solid; border-bottom: 2px #006390 solid; top: 0px;left: 0px;padding: 0px;">
         <a href="#" class="menuBottom">Home</a>
         <a href="#" class="menuBottom">Contact Us</a>
         <a href="#" class="menuBottom">Site Map</a>
         <a href="#" class="menuBottom">Search Site</a>
         <a href="#" class="menuBottom">Privacy Policy</a>
         <a href="#" class="menuBottom">Site by Caffeine Web Design</a>
      </td>
      </tr>
   </table>
   </html>
   <?php
   }
   else
   {
      require_once("../classes/Security.inc");
      $security = new Security();
      $security->destroy_session("user");
      header("Location: ../login.php?do=np");
   }
}
else
{
   echo("<H1>YOU DO NOT HAVE A CUSTOM PAGE</H1>");
   echo("<H2>If you feel this is an error, please contact Durham & Bates.</h2>");
   echo("<a href=\"" . $_SERVER["PHP_SELF"] . "\">BACK</A>");
}
?>