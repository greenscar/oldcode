<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");   
//require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File_Custom_Page.inc");
$client = new Client();
$dbmgr = new DB_Mgr("dbates");
//$bfcp = new Batch_File_Custom_Page();
$bfcp = new BFCP();
if(isset($_GET["cid"]))
{
   // DISPLAY IMAGES TO RENAME
   $client->id = $_GET["cid"];
   $bfcp->client = $client;
   if($bfcp->dbLoad($dbmgr))
   {
      // DISPLAY BATCH FILE CUSTOM PAGE FOR EDITING
      $client->dbLoad($dbmgr);
      $bfcp->client = $client;
      $bfcp->dbLoad($dbmgr);
      $title = "Batch File Rename Page for " . $bfcp->client->name;
      include("html_header.inc");
      //echo("active = " . $bfcp->isActive());
      ?>
      <body>
      <form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>">
      <input type="hidden" name="cid" value="<?php echo($client->id); ?>">
		<table class="mod_screen">
         <tr>
            <th colspan="2" class="menu">
               Batch File Rename Page for <?php echo($bfcp->client->name); ?>
            </th>
         </tr>
         <?php
            $rowNum = 0;
            foreach($bfcp->files AS $key=>$the_file)
            {
               $rowNum++;
               if($rowNum % 2 == 1){ echo("<tr>\n\t\t");}
               ?>
               <td align="center">
                  <table>
                     <tr>
                        <td>
                           <?php
                              echo("<img src=\"../" . $bfcp->getImageDir() . "/" . $the_file->file_name . "\">");
                           ?>
                        </td>
                     </tr>
                     <tr>
                        <td>
                           FILE NAME: <input type="text" name="file_<?php echo($key); ?>" value="<?php echo($the_file->title); ?>">
                        </td>
                     </tr>
                  </table>
               </td>
               <?
               if($rowNum % 2 == 0){ echo("</tr>\n\t\t");}
            }
         ?>
         <tr>
            <td colspan="2" align="center">
               <input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               <input class="submitButton" type="Button" name="Cancel" value="Cancel" onClick="location.href='bf_cp_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
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
		header("Location: bf_cp_menu.php");
   }
} // END DISPLAY IMAGES TO RENAME
else
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File.inc");
   // PROCESS RENAMING
   foreach($_POST AS $id=>$value)
   {
      if(strncmp("file_", $id, 5) == 0)
      {
         $bf = new Batch_File();
         $bf->id = substr($id, 5);
         $bf->title = $value;
         $bf->dbUpdate($dbmgr);
      }
   }
	header("Location: bf_cp_edit.php?cid=" . $_POST["cid"]);
}
?>