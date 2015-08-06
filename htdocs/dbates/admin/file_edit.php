<?php
	include($_SERVER["DOCUMENT_ROOT"]."/admin/ensure_admin.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Uploader.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/File.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
    
if(isset($_GET["do"]) && $_GET["do"] == "DEL")
{
	//DELETE THIS FORM
	$file = new File();
	$file->id = $_GET["fid"];
	$file->dbLoad($dbmgr);
	$file->dbDelete($dbmgr);
	header("Location: file_menu.php");
}
else if(isset($_POST["title"]))
{
	$dbmgr = new DB_Mgr("dbates");
	if(!empty($_FILES["the_file"]["name"]))
	{
		$uploader = new Uploader();
		$file = $uploader->upload($_FILES["the_file"]);
	}
	else
	{
		$file = new File();
	}
	$file->id = $_POST["file_num"];
	if(is_object($file))
	{
		$file->title = $_POST["title"];
		$file->description = nl2br($_POST["description"]);
		if(!($file->dbUpdate($dbmgr)))
		{
			echo("<h1 class=\"error\">ERROR - CANNOT INSERT</h1>" . $file->dbUpdate($dbmgr));
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
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/File.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["fNum"]))
	{
		$file = new File();
		$file->id = $_GET["fNum"];
		$fNum = $file->dbLoad($dbmgr);
		if($fNum != $_GET["fNum"])
		{
			echo("<h1>ERROR. Please select a file from the File List</h1>");
			exit();
		}
		// A FILE HAS BEEN SELECTED FOR EDITING
		
		$title = "Do your modifications then press submit.";		
		include("html_header.inc");
		?>
		<body>
		<form ENCTYPE="multipart/form-data" name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateFileForm(form, 'title', 'Title')";>
		<input type="hidden" name="file_num" value="<?php echo($file->id);?>">
			<table class="mod_screen">
				<tr>
					<th colspan="2" class="menu">Upload File</th>
				</tr>
				<tr>
					<td>Title</td>
					<td>
						<input type="text" name="title" value="<? echo(htmlentities($file->title)); ?>"></input>
					</td>
				</tr>
				<tr>
					<td>File (Leave Blank to keep current file)</td>
					<td>
						<INPUT NAME="the_file" class="file" TYPE="file" SIZE="35">
					</td>
				</tr>
				<tr>
					<td>Description</td>
					<td>
						<textarea name="description"><? echo(htmlentities($admin->br2nl($file->description))); ?></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input class="submitButton" type="Button" name="Cancle" value="Cancel" onClick="location.href='file_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Delete" value="Delete" onClick="if(confirm('Are you sure you want to delete this form')){location.href='file_edit.php?fid=<?php echo($file->id);?>&do=DEL'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						
					</td>
				</tr>
			</table>
		</form>
	</body>
	</html>
		<?
	}
	else
	{
		header("Location: menu.php");
	}
}
?>