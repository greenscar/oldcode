<?php
    include("ensure_admin.inc");
?>
<?php
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/File.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $admin = new Admin();
	$title = "Select a File or Upload New";
	include("html_header.inc");
?>
<body>
   <table class="mod_screen">
   <tr>
      <th class="menu" colspan="2">File Index</th>
   </tr>
   <?
      $fileArray = $admin->dbLoadFileList($dbmgr);
      for($l=0; $l<sizeof($fileArray);$l++)
      {
         echo("\t<tr>\n");
         echo("\t\t<td>\n");
         echo("\t\t\t<a class=\"menu\" href=\"file_edit.php?fNum=" . $fileArray[$l]->id . "\">");
         echo(htmlentities($fileArray[$l]->title));
         echo("</a>\n");
         echo("\t\t</td>\n");
			$fn = $fileArray[$l]->file_name;
			if((strpos($fn, ".jpg") > 1) || (strpos($fn, ".gif") > 1)) 
			{
				echo("\t\t<td>\n");
				echo("\t\t\t<a class=\"menu\" href=\"file_edit.php?fNum=" . $fileArray[$l]->id . "\">");
         	echo("<img src=\"https://" . $_SERVER["SERVER_NAME"] . "/upload_dir/$fn\">\n");
				echo("</a>\n");
				echo("\t\t</td>\n");
			}
			echo("\t</tr>\n");
      }
   ?>
   <tr>
      <td align="center" colspan="2">
			<!--
			<input type="button" class="submitButton" value="Batch Upload" onclick="location.href='file_batch_upload.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
			-->
         <input type="button" class="submitButton" value="Upload New" onclick="location.href='file_create.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
         <input type="button" class="submitButton" value="Main Menu" onclick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
      </td>
   </tr>
   </table>
</body>
</html>
   