<?php
    include("ensure_root.inc");
?>
<?php
if(isset($_POST["did"]))
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Department.inc");
   //require_once("../php/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $dept = new Department();
   $dept->id = $_POST["did"];
   $dept->name = $_POST["title"];
   $dept->insurance = $_POST["insurance"];
   $dept->active = $_POST["active"];
   //echo($dept->dbUpdate($dbmgr));
   if(!($dept->dbUpdate($dbmgr)))
   {
      die("<h1 class=\"error\">CANNOT UPDATE DB</h1>");
   }
   header("Location: dept_menu.php");
}
else
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Department.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["did"]))
	{
		$dept = new Department();
		$dept->id = $_GET["did"];
		$did = $dept->dbLoad($dbmgr);
		if($did != $_GET["did"])
		{
			echo("<h1>ERROR. Please select a department from the Department List</h1>");
			exit();
		}
		// A LINK HAS BEEN SELECTED FOR EDITING
		// DISPLAY THE FORM.
		$title = "Modify your Department Information";
		include("html_header.inc");
		?>
		<body>
		<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateDeptForm(this)";>
		<input type="hidden" name="did" value="<?php echo($dept->id);?>">
			<table class="mod_screen">
				<tr>
					<th colspan="2" class="menu">Modify Department</th>
				</tr>
				<tr>
					<td width="40%">Department Name</td>
					<td><input type="text" name="title" value="<?php echo(htmlentities($dept->name)); ?>"></input></td>
				</tr>
				<tr>
					<td>Is this a type of insurance?</td>
					<td><?php
							 echo("<input class=\"radio\" type=\"radio\" name=\"insurance\" value=\"1\"");
							 if($dept->insurance)
								  echo(" checked");
							 echo(">&nbsp; Yes\n");
							 echo("<input class=\"radio\" type=\"radio\" name=\"insurance\" value=\"0\"");
							 if(!($dept->insurance))
								  echo(" checked");
							 echo(">&nbsp; No\n");
					?></td>
				</tr>
				<tr>
					<td>Active:</td>
					<td><?php
							 echo("<input type=\"radio\" class=\"radio\" name=\"active\" value=\"1\"");
							 if($dept->active)
								  echo(" checked");
							 echo(">&nbsp; Yes\n");
							 echo("<input type=\"radio\" class=\"radio\" name=\"active\" value=\"0\"");
							 if(!($dept->active))
								  echo(" checked");
							 echo(">&nbsp; No\n");
					?></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Cancle" value="Cancel" onClick="location.href='dept_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
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