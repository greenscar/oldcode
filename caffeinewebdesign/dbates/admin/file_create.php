<?php
    include("ensure_admin.inc");
?>
<?php
if(isset($_POST["title"]))
{   
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Uploader.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/File.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   $dbmgr = new DB_Mgr("dbates");
   
   $uploader = new Uploader();
   $file = $uploader->upload($_FILES["the_file"]);
   if(is_object($file))
   {
      $file->title = $_POST["title"];
      $file->description = nl2br($_POST["description"]);
      if(!($file->dbInsert($dbmgr)))
      {
         echo("<h1 class=\"error\">ERROR - CANNOT INSERT</h1>" . $file->dbInsert($dbmgr));
         exit();
      }
      header("Location: file_menu.php");
   }
   else
   {
      echo("ERROR : $file");
   }
}
else
{
   $title = "Enter the file you wish to upload";
	include("html_header.inc");
   ?>
   <body>
      <form ENCTYPE="multipart/form-data" name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateFileUpload(this)";>
         <table class="mod_screen">
            
				<tr>
					<th colspan="2" class="menu">Upload File</th>
				</tr>
            <tr>
               <td>Title</td>
               <td>
                  <input type="text" name="title"></input>
               </td>
            </tr>
            <tr>
               <td>File</td>
               <td>
                  <INPUT class="file" NAME="the_file" TYPE="file" SIZE="35">
               </td>
            </tr>
            <tr>
               <td>Description</td>
               <td>
                  <textarea name="description"></textarea>
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
                  <input class="submitButton" type="Button" name="Cancel" value="Cancel" onClick="location.href='file_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
               </td>
            </tr>
         </table>
      </form>
   </body>
   </html>
<?
}
?>