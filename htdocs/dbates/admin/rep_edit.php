<?php
    //ini_set('display_errors', true);
    //ini_set('error_reporting', E_ALL);
//echo($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
//require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
    include("ensure_admin.inc");
if((isset($_GET["rNum"]) && isset($_GET["do"])))
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
   require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
   //require_once("../php/classes/Admin.inc");
   $dbmgr = new DB_Mgr("dbates");
   $rep = new Rep();
	if(isset($_GET["do"]))
   {
	   if(strcmp($_GET["do"], "DEL") == 0)
      {
         $rep->id = $_GET["rNum"];
         if(!($rep->dbDelete($dbmgr)))
				echo("ERROR");
      }
   }
   header("Location: rep_menu.php");
}
if(isset($_POST["rNum"]))
{
	include($_SERVER["DOCUMENT_ROOT"]."/inc_files/php_fxns.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
	//require_once("../php/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$rep = new Rep();
	$rep->id = $_POST["rNum"];
	$rep->first_name = $_POST["first_name"];
	$rep->last_name = trim($_POST["last_name"]);
	$rep->active = $_POST["active"];
	$rep->role_1 = $_POST["role_1"];
	$rep->role_2 = $_POST["role_2"];
	$rep->role_3 = $_POST["role_3"];
	$rep->setDeptViaId($dbmgr, $_POST["dept"]);
	$rep->phone = $_POST["phone"];
	$rep->fax = $_POST["fax"];
	$rep->email = $_POST["email"];
	
	$rep->specialties = Array();
	foreach($_POST as $id=>$val)
	{
		$x = strncmp($id, "specialty_", 10);
		if($x == 0)
		{
			$rep->addSpecialty($val);
			//echo("adding $val<br>");
		}
	}
	//view_array($rep->specialties);
	if(!($rep->dbUpdate($dbmgr)))
	{
		die("<h1 class=\"error\">CANNOT UPDATE DB</h1>");
	}
   
	/*
	 * Process VCard Upload
	 */
    if(isset($_POST["deleteVCard"]))
    {
         $target_path = $rep->getVcardPath();
			if(file_exists($target_path))
			{
				unlink($target_path);
			}
    }
	if((!empty($_FILES["vcard"])) && (!empty($_FILES["vcard"]["name"])))
	{
		// ONLY ALLOW .vcf FILES TO BE UPLOADED
		$filename = strtolower($_FILES['vcard']['name']);
		$extension = substr($filename, (strlen($filename) - 3));
		if(strcmp($extension, "vcf") == 0)
		{
			//$target_path = $_SERVER["DOCUMENT_ROOT"] . "/vcards/" . $_POST["first_name"] . "_" . $_POST["last_name"] . ".vcf";
         $target_path = $rep->getVcardPath();
			if(file_exists($target_path))
			{
				unlink($target_path);
			}
			if(!(move_uploaded_file($_FILES['vcard']['tmp_name'], $target_path))) 
			{
				die("<h1 class=\"error\">Error uploading vCard</h1>");
			}
		}
		else
		{
			echo("<h1 class=\"error\">You can only upload *.vcf for vCards. Please press the back arrow and resubmit with a valid vCard</H1>");
		}
	}
	/*
	 * END Process VCard Upload
	 */
   
	header("Location: rep_menu.php");
}
else
{
	$title = "Do your modifications and press submit.";
	include("html_header.inc");
	echo("<body>\n");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["rNum"]))
	{
		// A REP HAS BEEN SELECTED FOR EDITING.
		// DISPLAY TO EDIT
		$rep = new Rep();
		$rep->id = $_GET["rNum"];
		$eNum = $rep->dbLoad($dbmgr);
		if($eNum != $_GET["rNum"])
		{
			die("<H1 class=\"error\">$eNum. YOU MUST SELECT YOUR EMPLOYEE THROUGH THE MENU</H1>");
		}
		else
		{   
		?>
		<form name="form" enctype="multipart/form-data" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateEmpForm(this)";>
		<input type="hidden" name="rNum" value="<?echo($eNum);?>">
		<table class="mod_screen">
			<tr>
				<th class="menu" colspan="2">Update Associate Profile</th>
			</tr>
			<tr>
				<td>NAME:</td>
				<td>
					<input type="text" name="first_name" value="<?echo(htmlentities($rep->first_name));?>"></input>
					<input type="text" name="last_name" value="<?echo(htmlentities($rep->last_name));?>"></input>
				</td>
			</tr>
			<tr>
				<td>STATUS:</td>
				<td><?php
						 echo("<input class=\"radio\" type=\"radio\" name=\"active\" value=\"1\"");
						 if($rep->active)
							  echo(" checked");
						 echo(">&nbsp; Active\n");
						 echo("<input class=\"radio\" type=\"radio\" name=\"active\" value=\"0\"");
						 if(!($rep->active))
							  echo(" checked");
						 echo(">&nbsp; Inactive\n");
				?></td>
			</tr>
			<tr>
				<td>Title 1</td>
				<td><input type="text" name="role_1" value="<?php echo(htmlentities($rep->role_1));?>"></input></td>
			</tr>
			<tr>
				<td>Title 2</td>
				<td><input type="text" name="role_2" value="<?php echo(htmlentities($rep->role_2));?>"></input></td>
			</tr>
			<tr>
				<td>Title 3</td>
				<td><input type="text" name="role_3" value="<?php echo(htmlentities($rep->role_3));?>"></input></td>
			</tr>
			<tr>
				<?php
					$deptArray = $admin->dbLoadDepts($dbmgr);
				?>
				<td>Dept</td>
				<td>
					<?
					$deptArray = $admin->dbLoadDepts($dbmgr);
					for($i = 0; $i < sizeof($deptArray); $i++)
					{
						if(($deptArray[$i]->active) || ($rep->dept->id == $deptArray[$i]->id))
						{
							?>
							<input class="radio" type="radio" name="dept" value="<?php echo($deptArray[$i]->id);?>"<?php
								if($rep->dept->id == $deptArray[$i]->id) echo(" checked");
							?>>&nbsp;<?echo($deptArray[$i]->name);?><br>
							<?
						}
					}
					?>
				</td>
			</tr>
			<tr>
				<?php
					$specialArray = $admin->dbLoadSpecialties($dbmgr);
				?>
				<td>Specialties</td>
				<td>
						<?
						for($i = 0; $i < sizeof($specialArray); $i++)
						{
							if(($specialArray[$i]->active) || ($rep->hasSpecialty($specialArray[$i]->id)))
							{
								?>
								<input class="radio" type="checkbox" name="specialty_<?php echo($specialArray[$i]->id); ?>" value="<?php echo($specialArray[$i]->id);?>"<?php
								if($rep->hasSpecialty($specialArray[$i]->id)) echo(" checked");
								?>>&nbsp;<?echo($specialArray[$i]->name);?><br>
								<?
							}
						}
						?>
				</td>
			</tr>
			<tr>
				<td>Phone #</td>
				<td><input type="text" name="phone" value="<?php echo($rep->phone);?>"></td>
			</tr>
			<tr>
				<td>Fax #</td>
				<td><input type="text" name="fax" value="<?php echo($rep->fax);?>"></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" value="<?php echo($rep->email);?>"></td>
			</tr>
			<tr>
				<td>vCard</td>
				<td>
					<input type="file" name="vcard">
					<?php
						if($rep->vCardExists())
						{
							echo("&nbsp;&nbsp;&nbsp;<a href=\"http://" . $rep->getVcardLink() . "\"><b>Current vCard</b></a>");
						}
					?>
               <br>
               Delete vCard: <input style="width: 30px;" type="checkbox" name="deleteVCard">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input class="submitButton" type="Submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					<input class="submitButton" type="Button" name="Cancle" value="Cancel" onClick="location.href='rep_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Delete" value="Delete" onClick="if(confirm('Are you sure you want to delete this Agent?')){location.href='rep_edit.php?rNum=<?php echo($rep->id);?>&do=DEL'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
				</td>
			</tr>
		</table>
		</form>
		<?
		}
	}
	else
	{
		header("Location: menu.php");
	}
	?>
	</body>
	</html>
<?php
}
?>