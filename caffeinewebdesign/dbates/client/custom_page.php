<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
$log = new Secretary();
$log->write("-=-=-=-=-=-=-=-=- custom_page.php START -=-=-=-=-=-=-=-=-");
require_once("ensure_client.inc");
if($security->user_is_sa_user($client))
{
   $goTo = "Location: https://" . $_SERVER["SERVER_NAME"] . "/client/sa_cp.php";
   header($goTo);
}
require_once("../classes/Custom_Page.inc");

$cp = new Custom_Page();
$cp->client = $client;
$cp->dbLoad($dbmgr);
?>
<html>
<head>
   <title><?php echo($client->name); ?></title>
   <style type="text/css">@import "../template_client.css";</style>
   <script language="Javascript" type="text/javascript">
      function showHideAnswer(id)  
      {
      var elem = eval(document.getElementById(id));
       var elm = document.getElementById(id)
       elm.style.display == "inline"? elm.style.display = "none" : elm.style.display = "inline";
      }
   </script>
</head>
   <body>
      <!--<table class="body" border="1">-->
      <table class="mod_screen" style="height: 600px">
         <tr>
            <td width="20%" style="background-color: #006390">
               <table border="0" width="100%">
                  <tr>
                     <td align="center">
                        <img class="logo" src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/upload_dir/<?php echo($cp->logo); ?>">
                     </td>
                  </tr>
                  <tr>
                     <th>COVERAGE</th>
                  </tr>
                  <?php
                  foreach($cp->coverage_list as $id=>$cov)
                  //for($i=0; $i < sizeof($cp->coverage_list); $i++)
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
               </table>
            </td>
            <td>
               <table width="100%" border="0">
                  <tr style="height: 50px">
                     <td class="darkBlackSmall"><img style="height: 50px"src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/public_images/client_access_logo.gif"></td>
                  </tr>
                  <tr>
                     <th>FREQUENT QUESTIONS</th>
                  </tr>
                  <?php
                     //for($i=0; $i < sizeof($cp->link_list); $i++)
                     foreach($cp->faq_list AS $id=>$faq)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a href=# class=\"list\" onclick=\"showHideAnswer('faq" . $faq->id . "')\">> ");
                        echo(htmlentities($faq->question));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<div class=\"list\" style=\"display:none\" ID=\"faq" . $faq->id . "\"> ");
                        echo(nl2br($faq->solution));
                        echo("</div>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  ?>
                  <tr>
                     <td align="center" style="padding-top:10px;">
                     </td>
                  </tr>
                  <tr>
                     <th>LINKS</th>
                  </tr>
                  <?php
                     foreach($cp->link_list AS $id=>$link)
                     //for($i=0; $i < sizeof($cp->link_list); $i++)
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
                  <tr>
                     <td align="center" style="padding-top:10px;">
                        
                     </td>
                  </tr>
                  <tr>
                     <th>FORMS & APPLICATIONS</th>
                  </tr>
                  <?php
                     for($i=0; $i < sizeof($cp->form_list); $i++)
                     {
                        echo("\t<tr>\n");
                        echo("\t\t<td>\n");
                        echo("<a class=\"list\" TARGET=\"_blank\" href=\"../upload_dir/" . $cp->form_list[$i]->file_name . "?cid=" . $cp->client->id . "&fid=" . $cp->form_list[$i]->id . "\">> ");
                        echo(htmlentities($cp->form_list[$i]->title));
                        echo("</a>");
                        echo("\t\t</td>\n");
                        echo("\t</tr>\n");
                     }
                  ?>
                  <tr>
                     <td align="center" style="padding-top:10px;">
                        
                     </td>
                  </tr>
               </table>
            </td>
            <td width="20%" style="background-color: #006390">
               <table class="sub">
                  <tr>
                     <th>SERVICE TEAM</th>
                  </tr>
                  <tr>
                     <td class="darkBlackSmall">ACCOUNT LEADERS</td>
                  </tr>
                  <tr><td>
                  <?php
                     foreach($cp->service_team->member_array AS $id=>$member)
                     //for($i=0; $i < $cp->service_team->get_size(); $i++)
                     {
                        //$sm = $cp->service_team->get_member($i);
                        if(strcmp($member->type, "LEADER") == 0)
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
                     }
                  ?>
                  </td></tr>
                  <tr>
                     <td class="darkBlackSmall">ACCOUNT SERVICE</td>
                  </tr>
                  <?php
                     foreach($cp->service_team->member_array AS $id=>$member)
                     //for($i=0; $i < $cp->service_team->get_size(); $i++)
                     {
                        $member->logValues();
                        //$sm = $cp->service_team->get_member($i);
                        if(strcmp($member->type, "SERVICE") == 0)
                        {
                           echo("\t<tr>\n");
                           echo("\t\t<td class=\"service_team\">\n");
                           echo("<a class=\"list\" href=\"mailto:" . $member->rep->email . "\">> ");
                           echo($member->rep->first_name . " " . $member->rep->last_name . "<br>\n");
                           echo("<i class=\"nonbold\">" . $member->title . "</i><br>\n");
                           echo("<div  class=\"nonbold\">" . $member->rep->phone . "</div>");
                           echo("</a>");
                           echo("\t\t</td>\n");
                           echo("\t</tr>\n");
                        }
                     }
                  ?>
                  <tr>
                     <td align="center" style="padding-top:10px;v-align:bottom;">
                        <img src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/public_images/secure_site.gif" width="100px">
                     </td>
                  </tr>
               </table>
            </td>
         </tr>
         <tr>
            <td colspan="3" align="center">
            <?php if($client->hasBFPage($dbmgr)){ ?>
         <input type="button" class="submitButton" name="Menu"   value="Menu"   onClick="location.href='index.php'"  onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
            <?php } ?>
         <input type="button" class="submitButton" name="logout" value="Logout" onclick="location.href='logout.php'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input type="button" class="submitButton" name="edit" value="Edit Personal Info" onclick="location.href='edit_personal_info.php'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
            </td>
         </tr>
      </table>
   </body>
