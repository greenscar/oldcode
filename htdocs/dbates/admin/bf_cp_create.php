<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");   
//require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File_Custom_Page.inc");
$client = new Client();
$dbmgr = new DB_Mgr("dbates");
//$bfcp = new Batch_File_Custom_Page();
$bfcp = new BFCP();
if(empty($_FILES))
{
   if(empty($_POST["cid"]))
   {
      // Display list of clients without batch file custom pages
      //      for user to select who to create one for.
      
      // DISPLAY FORM FOR CREATING CLIENT
      //require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
      require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
      //$dbmgr = new DB_Mgr("dbates");
      $admin = new Admin();
      $title = "Select your client";
      include("html_header.inc");
      $clientList = $admin->dbLoadClientListActiveWithoutBatchPages($dbmgr);
      if($clientList == null)
      {
         echo("<h2>Every client in the system has a batch page. Please goto <a href=\"cp_menu.php\">MENU</a></h2>");
      }
      else
      {
         ?>
         <body>
         <form ENCTYPE="multipart/form-data" name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return drop_down_selected(form, 'cid', 'Client')";>
            <table class="mod_screen">
               <tr>
                  <th colspan="2" class="menu">Create a Batch Custom Client Page</th>
               </tr>
               <tr>
                  <td>Client</td>
                  <td>
                     <?php
                        echo("\t\t<select class=\"associate\" name=\"cid\">\n");
                        echo("\t\t\t<option value=\"0\">NONE</option>\n");                  
                        for($i=0; $i<sizeof($clientList); $i++)
                        {
                           $cl = $clientList[$i];
                           echo("\t\t\t<option value=\"" . $cl->id . "\">" . $cl->name . "</option>\n");
                        }
                        echo("\t\t</select>\n");
                     ?>
                  </td>
               </tr>
               <tr>
                  <td colspan="2" align="center">
                     <input class="submitButton" type="submit" name="submit" value="NEXT" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                     <input class="submitButton" type="button" name="MENU" value="MENU" onclick="location.href='bf_cp_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  </td>
               </tr>
            </table>
         </form>
   <?php
      }
   }// END if(empty($_POST["cid"]))
   else
   {
      // Display Form to upload files.
      
      /*
       * User has selected a client to create a batch file custom page for.
       * 1) Create a Batch File Custom Page in the DB
       * 2) Display the Batch File Upload Form
       */
      $client->id = $_POST["cid"];
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
       <param name="actionURL" value="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/admin/bf_cp_create.php?cid=<?php echo($client->id); ?>">
      
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
      <input type="button" class="submitButton" value="CANCEL" onclick="location.href='bf_cp_menu.php'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      <input type="button" class="submitButton" value="NEXT" onclick="location.href='bf_cp_edit.php?cid=<?php echo($client->id); ?>&do=disp'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
   <?
   } //END else
   // Display form to upload files
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