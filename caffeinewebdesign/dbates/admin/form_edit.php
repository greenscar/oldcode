<?php
    include("ensure_admin.inc");
	require_once("../classes/Uploader.inc");
	require_once("../classes/Form.inc");
	require_once("../classes/DB_Mgr.inc");
	$dbmgr = new DB_Mgr("dbates");
if(isset($_GET["do"]) && $_GET["do"] == "DEL")
{
	//DELETE THIS FORM
	$form = new Form();
	$form->id = $_GET["fid"];
	$form->dbLoad($dbmgr);
	$form->dbDelete($dbmgr);
	header("Location: form_menu.php");
}
if(isset($_POST["title"]))
{
	if(!empty($_FILES["the_file"]["name"]))
	{
		$form = new Form();
      $form->id = $_POST["fid"];
      $form->dbLoad($dbmgr);
      $form->deleteFile();
		$uploader = new Uploader();
		$form = $uploader->uploadForm($_FILES["the_file"]);
      $form->id = $_POST["fid"];
	}
	else
	{
		$form = new Form();
      $form->id = $_POST["fid"];
	}
	if(is_object($form))
	{
		$form->title = $_POST["title"];
		$form->description = nl2br($_POST["description"]);
		if(!($form->dbUpdate($dbmgr)))
		{
			echo("<h1 class=\"error\">ERROR - CANNOT INSERT</h1>" . $form->dbUpdate($dbmgr));
			exit();
		}
		header("Location: form_menu.php");
	}
	else
	{
		echo("ERROR : $form");
	}
}
else
{
	// DISPLAY NEWS FORM TO MODIFY NEWS.
	require_once("../classes/Admin.inc");
	$admin = new Admin();
	if(!empty($_GET["fid"]))
	{
		$form = new Form();
		$form->id = $_GET["fid"];
		$fid = $form->dbLoad($dbmgr);
		if($fid != $_GET["fid"])
		{
			echo("<h1>ERROR. Please select a form from the Form List</h1>");
			exit();
		}
		// A LINK HAS BEEN SELECTED FOR EDITING
		$title = "Do your modification then press submit.";
		include("html_header.inc");
		?>
	<body>
		<form ENCTYPE="multipart/form-data" name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateFormForm(this)";>
		<input type="hidden" name="fid" value="<?php echo($form->id);?>">
			<table class="mod_screen">
				<tr>
					<th colspan="2" class="menu">Edit Form</th>
				</tr>
				<tr>
					<td>Title</td>
					<td>
						<input class="newsEdit" type="text" name="title" value="<?php echo(htmlentities($form->title)); ?>"></input>
					</td>
				</tr>
            <tr>
               <td>Description</td>
               <td>
                  <textarea class="newsEdit" style="height: 100px;" name="description"><?php echo(htmlentities($admin->br2nl($form->description))); ?></textarea>
               </td>
            </tr>
				<tr>
					<td>File (Leave Blank to keep current form)</td>
					<td>
						<INPUT NAME="the_file" class="form" TYPE="file" SIZE="35">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Cancel" value="Cancel" onClick="location.href='form_menu.php'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Delete" value="Delete" onClick="if(confirm('Are you sure you want to delete this form')){location.href='form_edit.php?fid=<?php echo($form->id);?>&do=DEL'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
									
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