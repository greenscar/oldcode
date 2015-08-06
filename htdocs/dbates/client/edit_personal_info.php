<?php
require_once("ensure_client.inc");
if(!empty($_POST["oldPwd"]))
{
   //echo("password=".$client->password."<BR>");
   //echo("oldPwd = " . $_POST["oldPwd"]."<BR>");
   if($client->checkPassword($_POST["oldPwd"]))
   {
      if(!empty($_POST["newPassword"]))
      {
         $client->setPassword($_POST["newPassword"]);
         // Process Password change
      }
      if(!empty($_POST["contactName"]))
      {
         $client->contact = $_POST["contactName"];
      }
      if(!empty($_POST["contactEmail"]))
      {
         $client->email = $_POST["contactEmail"];
      }
      if(!empty($_POST["contactPhone"]))
      {
         $client->phone = $_POST["contactPhone"];
      }
      $client->dbUpdateContactInfo($dbmgr);
      $_SESSION["user"] = $client;
      $_GET["ip"] = null;
      header("Location: custom_page.php");
   }
   else
      header("Location: edit_personal_info.php?ip=true");
}
else
{
   require_once("../classes/Custom_Page.inc");
   
   $cp = new Custom_Page();
   $cp->client = $client;
   $cp->dbLoad($dbmgr);
   header("Cache-control: private");//IE 6 Fix
   ?>
   <html>
   <head>
      <title><?php echo($client->name); ?></title>
      <script language="JavaScript" type="text/javascript" src="../form_check.js"></script>
      <script language="JavaScript" type="text/javascript">
         function validatePersonalInfo(form)
         {
            var oldPwd = eval("form.oldPwd");
            var newPwd = eval("form.newPassword");
            var newPwd2 = eval("form.newPassword2");
            //if(newPwd.value.length > 0) alert("newPwd = " + newPwd.value.length);
            //return(false);
            if(field_is_blank(form, "oldPwd", "Old Password"))
               return(false);
            if((newPwd.value.length > 0) || (newPwd2.value.length > 0))
            {
               if(!check_password(form, "newPassword", "newPassword2"))
                  return(false);
            }
            return(true);
         }
      </script>
      <style type="text/css">@import "../template_client.css";</style>
   </head>
      <body>
         <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validatePersonalInfo(this);">
         <!--<table class="body" border="1">-->
         <table class="mod_screen" style="height: 600px">
            <tr>
               <td width="20%">
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
                     <tr>
                        <?php
                        if(isset($_GET["ip"]) && strcmp($_GET["ip"], "true") == 0)
                        {
                        ?>
                        <th style="text-align:left;color: red;" colspan="2">
                           The old password you entered was incorrect.<br> Please reenter your information.
                        </th>
                        <?php
                        }
                        ?>
                     <tr>
                        <th style="text-align:left" colspan="2">
                           <?php echo($cp->client->name); ?>, change your password
                        </th>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left" width="40%">Old Password:</td>
                        <td>
                           <input class="name" type="password" name="oldPwd"></input>
                        </td>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left">New Password:</td>
                        <td>
                           <input class="name" type="password" name="newPassword"></input>
                        </td>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left">New Password (Again):</td>
                        <td>
                           <input class="name" type="password" name="newPassword2"></input>
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2">&nbsp;</td>
                     </tr>
                     <tr>
                        <th style="text-align:left" colspan="2">
                           You may enter default user information to automatically be included when you complete forms on this site.
                        </th>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left">Contact Name:</td>
                        <td>
                           <input class="name" type="text" name="contactName" value="<?php echo($client->contact); ?>"></input>
                        </td>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left">Contact Phone:</td>
                        <td>
                           <input class="name" type="text" name="contactPhone" value="<?php echo($client->phone); ?>"></input>
                        </td>
                     </tr>
                     <tr>
                        <td class="darkBlackSmall" style="text-align: left">Contact Email:</td>
                        <td>
                           <input class="name" type="text" name="contactEmail" value="<?php echo($client->email); ?>"></input>
                        </td>
                     </tr>
                  </table>
               </td>
               <td width="20%">
                  <table class="sub">
                     <tr>
                        <th>SERVICE TEAM</th>
                     </tr>
                     <tr>
                        <td style="text-align: center; font-size: xx-small;font-weight: bold;font-family: 'Verdana', Verdana, sans-serif;">ACCOUNT LEADERS</td>
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
                              echo("<div  class=\"nonbold\">" . $member->rep->phone . "</div>");
                              echo("</a>");
                              echo("\t\t</td>\n");
                              echo("\t</tr>\n");
                           }
                        }
                     ?>
                     </td></tr>
                     <tr>
                        <td style="text-align: center; font-size: xx-small;font-weight: bold;font-family: 'Verdana', Verdana, sans-serif;">ACCOUNT SERVICE</td>
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
                        <td align="center" style="padding-top:10px;">
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr>
               <td colspan="3" align="center">
                  <input onclick="location.href='custom_page.php'" class="submitButton" type="button" name="cancel" value="Cancel" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input type="submit" class="submitButton" name="update" value="Process Update" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
         </form>
      </body>
<?php
}
?>