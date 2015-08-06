<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
$log = new Secretary();
$log->write("-=-=-=-=-=-=-=-=- sa_cp.php START -=-=-=-=-=-=-=-=-");
require_once("ensure_sa_client.inc");
require_once("../classes/Custom_Page_Sel_Accts.inc");
$log->write("create custom_page");
$sap = new Custom_Page_Sel_Accts($dbmgr);
$sap->client = $client;
$sap->dbLoad($dbmgr);
?>
<html>
<head>
   <title>SELECT ACCOUNTS</title>
   <style type="text/css">@import "../template_client.css";</style>
</head>
   <body>
      <!--<table class="body" border="1">-->
      <table class="mod_screen" style="height: 600px">
         <tr>
            <td width="30%" style="background-color: #006390"> <!-- LEFT COLUMN -->
               <table border="0" width="100%">
                  <tr>
                     <td align="center">
                        <img class="logo" style="width: 200px;" src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/upload_dir/select_accts_logo.jpg">
                     </td>
                  </tr>
                  <tr>
                     <th>SPECIALTIES</th>
                  </tr>
                        <?php
                        foreach($sap->coverage_list AS $key=>$cov)
                        //for($i=0; $i < sizeof($sap->coverage_list); $i++)
                        {
                           echo("\t<tr>\n");
                           echo("\t\t<td>\n");
                            echo("<a class=\"list\" TARGET=\"_blank\" href=\"../upload_dir/" . $cov->file_name . "\">> ");
                           echo(htmlentities($cov->title));
                           echo("</a>");
                           echo("\t\t</td>\n");
                           echo("\t</tr>\n");
                        }
                        ?>
                  <tr>
                     <th>SERVICE TEAM</th>
                  </tr>
                  <tr><td>
                  <?php
                     foreach($sap->service_team->member_array AS $id=>$member)
                     //for($i=0; $i < $sap->service_team->get_size(); $i++)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td class=\"service_team\">\n");
                        echo("<a class=\"list\" href=\"mailto:" . $member->rep->email . "\">> ");
                        echo($member->rep->first_name . " " . $member->rep->last_name . "<br>\n");
                        echo("<i class=\"nonbold\">" . $member->title . "</i><br>\n");
                        echo("<div class=\"nonbold\">" . $member->rep->phone . "</div>");
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  ?>
                  </td></tr>
                  <tr>
                     <th>LINKS</th>
                  </tr>
                  <?php
                     foreach($sap->link_list AS $id=>$link)
                     //for($i=0; $i < sizeof($sap->link_list); $i++)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a class=\"list\" TARGET=\"_blank\" href=\"" . $link->address . "\">> ");
                        echo(htmlentities($link->title));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  ?>
               </table>
            </td>
            <td> <!-- BODY COLUMN -->
               <table width="100%" border="0">
                  <tr style="height: 50px">
                     <td class="darkBlackSmall"><img style="height: 50px"src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/public_images/client_access_logo.gif"></td>
                  </tr>
                  <tr>
                     <th>FORMS & APPLICATIONS</th>
                  </tr>
               <tr>
                  <th>ONLINE FORMS</th>
               </tr>
               <?php
                  foreach($sap->form_list AS $id=>$aForm)
                  {
                     if(strcmp($aForm->getFileType(), "php") == 0)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                           echo("<a class=\"list\" TARGET=\"_blank\" href=\"../upload_dir/" . $aForm->file_name . "?cid=" . $sap->client->id . "&fid=" . $aForm->id . "\">> ");
                        echo(htmlentities($aForm->title));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  }
               ?>
               <tr>
                  <th>PRINTABLE FORMS</th>
               </tr>
               <?php
                  //for($i=0; $i < sizeof($sap->form_list); $i++)
                  foreach($sap->form_list AS $id=>$aForm)
                  {
                     if(strcmp($aForm->getFileType(), "php") != 0)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                           echo("<a class=\"list\" TARGET=\"_blank\" href=\"../upload_dir/" . $aForm->file_name . "\">> ");
                        echo(htmlentities($aForm->title));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  }
               ?>
               </table>
            </td>
         </tr>
         <tr>
            <td colspan="3" align="center">
               <input type="button" class="submitButton" name="logout" value="Logout" onclick="location.href='logout.php'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
            </td>
         </tr>
      </table>
   </body>
