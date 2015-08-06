<?php
include("../show_errors.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");   
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
//require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File_Custom_Page.inc");
$client = new Client();
$dbmgr = new DB_Mgr("dbates");
//$bfcp = new Batch_File_Custom_Page();
$bfcp = new BFCP();
if(empty($_FILES))
{
     $client->id = $_GET["cid"];
      $client->dbLoad($dbmgr);
      $bfcp->client = $client;
      $bfcp->dbInsert($dbmgr);
      $title = "Upload your files";
      include("html_header.inc");
      //header("Location: bf_cp_upload.php?cid=" . $client->id);
      ?>
      <h2 class="title" align="center">Upload files for <?php echo($client->name);?></h2>
      <hr>
      <p align="center">
       <applet 
        code="JUpload/startup.class"
        archive="./jupload.jar"
        width="750"
        height="500"
        mayscript
        name="JUpload"
        alt="JUpload by www.jupload.biz">
      
       <!-- Java Plug-In Options -->
       <param name="progressbar" value="true">
       <param name="boxmessage" value="Loading JUpload Applet ...">
      
       <!-- Target links -->
       <param name="actionURL" value="http://<?php echo($_SERVER["SERVER_NAME"]); ?>/admin/bf_cp_edit_upload.php?cid=<?php echo($client->id); ?>">
      
       <!PARAM NAME="maxTotalRequestSize" VALUE="4">
       <param name="preselectedFiles" value="">
      
       <param name="askAuthentification" value="false">
       <param name="usePresetAuthentification" value="dXNlcm5hbWU6cGFzc3dvcmQ=">
      
       <!-- IF YOU HAVE PROBLEMS, CHANGE THIS TO TRUE BEFORE CONTACTING SUPPORT -->
       <param name="debug" value="true">
      
       Your browser does not support applets. Or you have disabled applet in your options.
       To use this applet, please install the newest version of Sun's java. You can get it from <a href="http://www.java.com/">java.com</a>
       </applet>
      </p>
      <input type="button" class="submitButton" value="NEXT" onclick="location.href='bf_cp_edit.php?cid=<?php echo($client->id); ?>&do=disp'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
<?php
      } // END if(empty($_FILES))
else // $_FILES NOT EMPTY
{
   // Process File Upload
   $client->id = $_GET["cid"];
   $bfcp->client = $client;
   $result = $bfcp->processFileUpload($dbmgr, $_FILES);
   if(is_array($result))
   {
      echo("<b>UPLOAD COMPLETE.</b> <ul><li>Please click \"NEXT\" below to name the files.</li></ul>");  
   }
   else
   {
      echo($result);
   }
}
?>