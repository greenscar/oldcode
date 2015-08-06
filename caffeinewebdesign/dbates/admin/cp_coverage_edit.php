<?php
   require_once("../classes/DB_Mgr.inc");
   require_once("../classes/Admin.inc");
   require_once("../classes/Client.inc");
   require_once("../classes/Coverage.inc");
   require_once("../classes/Security.inc");
   $security = new Security();
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
   $client = new Client();
   
if((isset($_GET["cid"]) && empty($_GET["do"])))
{
   $client_id = $_GET["cid"];
   $client->id = $client_id;
   $client->dbLoad($dbmgr);
   $cov = new Coverage();
   $title = "Edit the Coverage.";
   include("html_header.inc");
   ?>
   <form name="coverage_edit" method="post" action="cp_coverage_edit.php" onsubmit="return validate_cp_coverage_edit(this)">
      <input type="hidden" name="client_id" value="<?php echo($client_id); ?>">
   <?php
   if($_GET["cov_id"] != 0)
   {
      // EDITING AN EXISTING COVERAGE
      $cov->cov_id = $_GET["cov_id"];
      $cov->dbLoad($dbmgr);
      ?>
      <input type="hidden" name="file_orig" value="<?php echo($cov->file_id); ?>">
      <input type="hidden" name="cov_id" value="<?php echo($cov->cov_id);?>">
      <?php
   }
   ?>
      <table class="mod_screen">
         <tr><th class="menu" colspan="2">
         <?php
            if($_GET["cov_id"] != 0) echo("Edit your Coverage File");
            else echo("Select a Coverage File");
         ?>
         </th></tr>
         <tr>
            <td>Client</td>
            <td><?php echo($client->name);?></td>
         </tr>
         <tr>
            <td>Title</td>
            <td><input type="text" name="title" value="<?php echo(htmlspecialchars($cov->title)); ?>"></td>
         </tr>
         <tr>
            <td>File</td>
            <td>
               <select name="file_id">
                  <?php
                  $fileArray = $admin->dbLoadFileList($dbmgr);
                  for($l=0; $l<sizeof($fileArray);$l++)
                  {
                     echo("\t\t\t\t<option value=\"" . $fileArray[$l]->id . "\"");
                     if($fileArray[$l]->id == $cov->file_id) echo(" selected");
                     echo(">" . $fileArray[$l]->title . "</option>\n");
                  }
                  ?>
               </select>
            </td>
         </tr>
         <tr>
            <td colspan="2" align="center">
               <input class="submitButton" type="submit" name="Submit" value="Submit">
               <?php
               if($_GET["cov_id"] != 0)
               {
               ?>
               <input class="submitButton" type="button" name="Delete" value="Delete" onclick="if(confirm('Are you sure you want to delete this link')){location.href='cp_coverage_edit.php?cid=<?php echo($client_id); ?>&cov_id=<? echo($cov->cov_id)?>&do=del'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <?php
               }
               ?>
               <input class="submitButton" type="button" name="Cancel" value="Cancel" onclick="location.href='cp_edit.php?cid=<?php echo($client_id); ?>'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
            </td>
         </tr>
      </table>
   </form>
   <?php
}
else
{
   $cov = new Coverage();
   if(!empty($_GET["do"]) && strcmp($_GET["do"], "del") == 0)
   {
   $client_id = $_GET["cid"];
   $client->id = $client_id;
   $client->dbLoad($dbmgr);
      // DELETE THIS COVERAGE
      $cov->client_id = $_GET["cid"];
      $cov->cov_id = $_GET["cov_id"];
      if($cov->dbDelete($dbmgr))
      {
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
         echo("DATABASE ERROR in Coverage Delete");
      }
   }
   else
   {
      // PROCESS MOD OR CREATION
      
      //include("php_fxns.inc");
      //view_array($_POST);
      $client_id =$_POST["client_id"];
      $client->id = $client_id;
      $client->dbLoad($dbmgr);
      $cov->client_id = $_POST["client_id"];
      $cov->file_id = $_POST["file_id"];
      $cov->title = $_POST["title"];
      
      if(isset($_POST["cov_id"]))
      {
         // THIS IS AN UPDATE OF AN EXISTING COVERAGE.
         $file_orig = $_POST["file_orig"];
         $cov->cov_id = $_POST["cov_id"];
         // UPDATE DB
         $cov_id = $cov->dbUpdate($dbmgr);
      }
      else
      {
         // THIS IS A NEW COVERAGE BEING INSERTED.
         // INSERT TO DB
         $cov_id = $cov->dbInsert($dbmgr);
      }
      
      if($cov_id == $cov->cov_id)
      {
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
   