<?php
//require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File_Custom_Page.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");   
$client = new Client();
$dbmgr = new DB_Mgr("dbates");
//$bfcp = new Batch_File_Custom_Page();
$bfcp = new BFCP();
if(isset($_GET["cid"]))
{
   $client->id = $_GET["cid"];
   $client->dbLoad($dbmgr);
   $bfcp->client = $client;
   $bfcp->dbLoad($dbmgr);      
   if(strcmp($_GET["do"], "del") == 0)
   {
      require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File.inc");
      // USER HAS SELECTED TO DELETE 1 IMAGE. DELETE THIS IMAGE THEN RETURN TO bf_cp_edit.php
      $client_id = $_GET["cid"];
      // DELETE THE FILE
      $bf = new Batch_File();
      $bf->id = $_GET["fid"];
      $bf->dbLoad($dbmgr);
      $res = $bf->delete($dbmgr, $bfcp->getImageDir());
      if($res)
         header("Location: bf_cp_edit.php?cid=$client_id&do=disp");
      else
      {
         echo($res);
         exit();
      }
   }
   else if(strcmp($_GET["do"], "disp") == 0)
   {
      // DISPLAY BATCH FILE CUSTOM PAGE FOR EDITING
      $title = "Batch File Page for " . $bfcp->client->name;
      include("html_header.inc");
      //echo("active = " . $bfcp->isActive() . "<BR>");
      //echo("active = " . $bfcp->active . "<BR>");
      ?>
      <body>
      <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>">
      <input type="hidden" name="cid" value="<?php echo($bfcp->client->id); ?>">
      <table class="mod_screen">
         <tr>
            <th colspan="2" class="menu">
               Batch File Page for <?php echo(htmlspecialchars($bfcp->client->name)); ?>
            </th>
         </tr>
         <tr>
            <td colspan="2" class="repEdit">STATUS:<?php
               echo("<input type=\"radio\" class=\"radio\" name=\"active\" value=\"1\"");
               if($bfcp->active == 1)
                   echo(" checked");
               echo(">&nbsp; Active\n");
               echo("<input type=\"radio\" class=\"radio\" name=\"active\" value=\"0\"");
               if(($bfcp->active == 0))
                   echo(" checked");
               echo(">&nbsp; Innactive\n");
            ?></td>
         </tr>
         <?php
            $rowNum = 0;
            foreach($bfcp->files AS $key=>$the_file)
            {
               $rowNum++;
               if($rowNum % 2 == 1){ echo("<tr>\n\t\t");}
               ?>
               <td align="center">
                  <?php
                     echo("<img src=\"" . $bfcp->getImageDir() . $the_file->file_name . "\">");
                  ?>
                  <br>
                  FILE NAME: <input type="text" name="file_<?php echo($key); ?>" value="<?php echo(htmlspecialchars($the_file->title)); ?>">
                  <br><br>
                  <input type="Button" name="deleteOne" value="Delete Me" class="submitButton" onClick="if(confirm('Are you sure you want to delete this image?')){location.href='bf_cp_edit.php?cid=<?php echo($bfcp->client->id); ?>&do=del&fid=<?php echo($key); ?>'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
               <?
               if($rowNum % 2 == 0){ echo("</tr>\n\t\t");}
            }
            if($rowNum == 0)
            {
               echo("<tr><td align=\"center\">There are currently no photos</td></tr>");
            }
            
            
            
         ?>
         <tr>
            <td colspan="2">&nbsp</td>
         </tr>
         <tr>
            <td colspan="2" align="center">
               <input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <input class="submitButton" type="Button" name="Menu" value="Menu" onClick="location.href='bf_cp_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <input type="Button" name="upload" value="Upload Photos" class="submitButton" onClick="location.href='bf_cp_edit_upload.php?cid=<?php echo($bfcp->client->id); ?>';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
            </td>
         </tr>
         </table>
         </form>
      </body>
      </html>
   <?php
   } // END NOT if(isset($_GET["fid"]))
} // END if(isset($_GET["cid"]))
else if(isset($_POST["cid"]))
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File.inc");
   $bfcp->client->id = $_POST["cid"];
   $bfcp->active = $_POST["active"];
   foreach($_POST AS $id=>$value)
   {
      if(strncmp("file_", $id, 5) == 0)
      {
         $bf = new Batch_File();
         $bf->id = substr($id, 5);
         $bf->title = $value;
         $bf->client_id = $bfcp->client->id;
         $bfcp->files[$bf->id] = $bf;
      }
   }
   if(!($bfcp->dbUpdate($dbmgr)))
   {
      echo("<h1>ERROR IN BATCH FILE CUSTOM PAGE UPDATE</H1>");
   }
   else
      header("Location: bf_cp_menu.php");
}
?>