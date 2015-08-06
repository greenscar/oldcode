<?php
if(empty($_FILES))
{
   $title = "Upload Multiple Files";
   include("html_header.inc");
?>
<body>
 <h2 class="title">Upload Multiple Files</h2>

<hr>
<p align="center">
 <applet 
  code="JUpload/startup.class"
  archive="./jupload.jar"
  width="800"
  height="600"
  mayscript
  name="JUpload"
  alt="JUpload by www.jupload.biz">

 <!-- Java Plug-In Options -->
 <param name="progressbar" value="true">
 <param name="boxmessage" value="Loading JUpload Applet ...">

 <!-- Target links -->
 <!--<param name="actionURL" value="http://server/dbates/admin/jupload.php">-->
 <param name="actionURL" value="https://<?php echo($_SERVER["SERVER_NAME"]); ?>/admin/batch_file_upload.php">

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
<input type="button" class="submit" value="Main Menu" onclick="location.href='index.php'">
</body>
</html>
<?php
} // END if(isempty($_FILES))
else
{
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Uploader.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");   
   include("./php_fxns.inc");
   view_array($_POST);
   $dbmgr = new DB_Mgr("dbates");
   $uploader = new Uploader();
   $fileList[] = Array();
   $fileList = $uploader->uploadBatch($dbmgr, $_FILES, 1);
   //echo("Now that files are uploaded, you need to go to batch image edit to name them");
   foreach($fileList as $id=>$file)
   {
      echo($id . "<BR>");
      //echo($file->id . " => " . $file->file_name . "<BR>");
   }
   flush();
}
?>