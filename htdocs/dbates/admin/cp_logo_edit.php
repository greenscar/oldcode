<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_GET["fn"]))
{
   // DISPLAY FORM TO EDIT LOGO
   $file = $_GET["fn"];
   $client_id = $_GET["cid"];
   $title = "Modify Your Logo";
   include("html_header.inc");
   ?>
   <body>
      <form ENCTYPE="multipart/form-data" name="form" method="post" action="cp_logo_edit.php" onsubmit="return validateFileForm(this, 'new_logo', 'New Logo')";>
         <input type="hidden" name="client_id" value="<?echo($client_id);?>">
         <table class="mod_screen">
            <tr>
               <th class="menu" colspan="2">Edit your Logo</th>
            </tr>
            <tr>
               <td>Current Logo:</td>
               <td>
                  <img width="100px" src="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/upload_dir/<?php echo($file); ?>">
               </td>
            </tr>
            <tr>
               <td>
                  Replace With:
               </td>
               <td>
                  <INPUT class="file" NAME="new_logo" TYPE="file" SIZE="35">
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <input class="submitButton" type="submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input class="submitButton" type="button" name="Cancle" value="Cancle" onclick="location.href='cp_edit.php?cid=<?php echo($client_id); ?>'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
      </form>
   </body>
   </html>
<?php
}
else
{
   // PROCESS LOGO EDIT AND FORWARD TO cp_menu.php
   require_once("../classes/DB_Mgr.inc");
   require_once("../classes/Admin.inc");
   require_once("../classes/Custom_Page.inc");
   require_once("../classes/Uploader.inc");
   
   $cid = $_POST["client_id"];
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
   $cp = new Custom_Page();
   $cp->setClient($dbmgr, $cid);
   
   $uploader = new Uploader();
   $file = $uploader->upload($_FILES["new_logo"]);
   //echo($file);
   if(is_object($file))
   {
      $cp->logo = $file->file_name;
      if(!$cp->dbUpdateLogo($dbmgr))
      {
         echo("ERROR IN FILE DB UPDATE");
      }
      else
         header("Location: cp_edit.php?cid=" . $cp->client->id);
   }
   else
   {
      echo($file);
      echo("<a href=\"cp_edit.php?cid=" . $cp->client->id . "\">BACK</a>");
      exit();
   }
   
   
   //$cp->logo = $newFile;
   //$cp->dbLoad($dbmgr);
}
?>
   