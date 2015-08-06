<?php
    include("ensure_root.inc");
?>
<?php
if(isset($_POST["spec_id"]))
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Specialty.inc");
   //require_once("../php/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $spec = new Specialty();
   $spec->id = $_POST["spec_id"];
   $spec->name = $_POST["title"];
   $spec->active = $_POST["active"];
   if(!($spec->dbUpdate($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT UPDATE DB</h1>");
   }
   header("Location: specialty_menu.php");
}
else
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Specialty.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["sNum"]))
	{
		$spec = new Specialty();
		$spec->id = $_GET["sNum"];
		$sNum = $spec->dbLoad($dbmgr);
		if($sNum != $_GET["sNum"])
		{
			echo("<h1>ERROR. Please select a specialty from the Specialty List</h1>");
			exit();
		}
		// A SPECIALTY HAS BEEN SELECTED FOR EDITING
		$title = "Edit your Specialty then press Submit.";
		include("html_header.inc");
		?>
		<body>
			<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateSpecialtyForm(this)";>
			<input type="hidden" name="spec_id" value="<?php echo($spec->id);?>">
				<table class="mod_screen">
					<tr>
						<th colspan="2" class="menu">Edit Specialty</th>
					</tr>
					<tr>
						<td>Title</td>
						<td>
							<input type="text" name="title" value="<?php echo(htmlentities($spec->name)); ?>"></input>
						</td>
					</tr>
					<tr>
						<td>Status:</td>
						<td><?php
								 echo("<input type=\"radio\" class=\"radio\" name=\"active\" value=\"1\"");
								 if($spec->active)
									  echo(" checked");
								 echo(">&nbsp; Active\n");
								 echo("<input type=\"radio\" class=\"radio\" name=\"active\" value=\"0\"");
								 if(!($spec->active))
									  echo(" checked");
								 echo(">&nbsp; Inactive\n");
						?></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
							<input type="Button" class="submitButton" name="Cancle" value="Cancel" onClick="location.href='specialty_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
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