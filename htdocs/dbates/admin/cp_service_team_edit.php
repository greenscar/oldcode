<?php
    include("ensure_admin.inc");
?>
<?php
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Service_Team.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Service_Member.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
   $client = new Client();
   $sm = new Service_Member();
   $st = new Service_Team();
if(isset($_GET["cid"]) && empty($_GET["do"]))
{
   $client_id = $_GET["cid"];
   $client->id = $client_id;
   $client->dbLoad($dbmgr);
   $st->dbLoad($dbmgr, $client_id);
   $sm->client_id = $client->id;
   ?>
   <?php
   if($_GET["rep_id"] != 0)
   {
      // EDITING AN EXISTING REP
      $sm->rep->id = $_GET["rep_id"];
      $sm->dbLoad($dbmgr);
      $title = "Modify " . $client->name;
      ?>
      <?php
   }
   else $title = "Create your Service Team Member";
      include("html_header.inc");
   ?>
   <form name="form" method="post" action="cp_service_team_edit.php" onsubmit="return validate_cp_service_team_edit(form)">
      <input type="hidden" name="client_id" value="<?php echo($client_id); ?>">
      <input type="hidden" name="rep_id_orig" value="<?php echo($_GET["rep_id"]);?>">
      <table class="mod_screen">
         <tr><th colspan="2" class="menu">Service Representative</th></tr>
         <tr>
            <td>Client:</td>
            <td><?php echo($client->name);?></td>
         </tr>
         <?php
         if(!($security->user_is_sa_user($client)))
         {
         ?>
         <tr>
            <td>Service Type:</td>
            <td>
               <select name="service_type">
               <?php
                  if(strcmp($sm->type, "Leader") == 0)
                  {
               ?>
                  <option value="LEADER" selected>Account Leader</option>
                  <option value="SERVICE">Account Service</option>
               <?php
                  }
                  else
                  {
               ?>
                  <option value="LEADER">Account Leader</option>
                  <option value="SERVICE" selected>Account Service</option>
               <?php
                  }
               ?>>
               </select>
            </td>
         </tr>
         <?php
         }
         ?>
         <tr>
            <td>Agent Title:</td>
            <td><input type="text" name="title" value="<?php echo(htmlspecialchars($sm->title)); ?>"></td>
         </tr>
         <tr>
            <td>Agent:</td>
            <td>
               <?php
                  $repArray = $admin->dbLoadRepListBrief($dbmgr);
                  //echo("size = " . sizeof($repArray));
                  echo("\t\t<select class=\"associate\" name=\"rep_id\">\n");
                  if($sm->rep->id != 0)
                     echo("\t\t\t<option selected value=\"" . $sm->rep->id . "\">" . $sm->rep->get_full_name() . "</option>\n");
                  else
                     echo("\t\t\t<option selected value=\"0\">Select an Agent</option>\n");
                  for($i=0; $i<sizeof($repArray); $i++)
                  {
                     $rep = $repArray[$i];
                     if(!($st->repIsOnServiceTeam($rep->id)))
                        echo("\t\t\t<option value=\"" . $rep->id . "\">" . $rep->get_full_name() . "</option>\n");
                  }
                     echo("\t\t</select>\n");
               ?>
            </td>
         </tr>
         <tr>
            <td colspan="2" align="center">
               <input class="submitButton" type="submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <input class="submitButton" type="button" name="Delete" value="Delete" onclick="if(confirm('Are you sure you want to delete this link')){location.href='cp_service_team_edit.php?cid=<?php echo($client_id); ?>&repId=<? echo($_GET["rep_id"])?>&do=del'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <input class="submitButton" type="button" name="Cancel" value="Cancel" onclick="location.href='cp_edit.php?cid=<?php echo($client_id); ?>'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
            </td>
         </tr>
      </table>
   </form>
   <?php
}
else
{
   if(isset($_GET["cid"]) && !empty($_GET["do"]))
   {
      $client_id = $_GET["cid"];
      $client->id = $client_id;
      $client->dbLoad($dbmgr);
      if(strcmp($_GET["do"], "del") == 0)
      {
         // DELETE THIS SERVICE TEAM MEMBER FROM THIS USER.
         $st->client_id = $client_id;
         if($st->dbDeleteServiceMember($dbmgr, $_GET["repId"], $client_id))
         {
            //successful
            if($security->user_is_sa_user($client))
            {
               header("Location: sa_edit.php");
            }
            else
            {
               header("Location: cp_edit.php?cid=" . $client->id);
            }
         }
         else
         {
            //failure
            echo("DATABASE ERROR");
         }
      }
   }
   else
   {
      //include("php_fxns.inc");
      //view_array($_POST);
      
      $client_id = $_POST["client_id"];
      $client_id = $_POST["client_id"];
      $client->id = $client_id;
      $client->dbLoad($dbmgr);
      $sm->client_id = $_POST["client_id"];
      $new_rep_id = $_POST["rep_id"];
      $sm->title = $_POST["title"];
      if(isset($_POST["service_type"]))
         $sm->type = $_POST["service_type"];
      else
         $sm->type = "LEADER";
      if(isset($_POST["rep_id_orig"]))
      {
         // It's an update.
         // 1) Delete where old_rep_id && client_id are in table.
         $sm->rep_id = $_POST["rep_id_orig"];
         $sm->dbDelete($dbmgr, $sm->client_id);
      }
      
      // Insert the rep.
      $sm->rep->id = $new_rep_id;
      $result = $sm->dbInsert($dbmgr);
      
      if($result == $sm->rep->id)
      {
            //successful
            if($security->user_is_sa_user($client))
            {
               header("Location: sa_edit.php");
            }
            else
            {
               header("Location: cp_edit.php?cid=" . $client->id);
            }
      }
      else
      {
         //failure
         echo("DATABASE ERROR");
      }
   }
}
?>
   