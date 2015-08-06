<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/error_reporting.inc");
if(isset($_GET["cid"]))
{
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
	$dbmgr = new DB_Mgr("dbates");
	$u = new User();
	$u->id = $_GET["cid"];
	// DEACTIVATE OR ACTIVATE CLIENT.
	if(strcmp($_GET["do"], "DEL") == 0)
	{
		// DEACTIVATE CLIENT
		if($u->dbDelete($dbmgr))
		{
			header("Location: user_menu.php");
		}
		else
		{
			echo($u->deDelete($dbmgr));
			exit();
		}
	}
}
else if(isset($_POST["user_name"]))
{
	// Process mod
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Security.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Root.inc");
	$dbmgr = new DB_Mgr("dbates");
	$security = new Security();
	$sec_lvl_id = $_POST["sec_lvl_id"];
	if($sec_lvl_id == 1)
		$u = new Client();
	else if($sec_lvl_id == 2)
		$u = new Admin();
	else // $sec_lvl_id == 3
		$u = new Client();
	$u->sec_lvl_id = $sec_lvl_id;
	$u->id = $_POST["id"];
	$u->user_name = $_POST["user_name"];
	$u->name = $_POST["name"];
	$u->contact = $_POST["contact"];
	$u->phone = $_POST["phone"];
	$u->email = $_POST["email"];
	$u->active = $_POST["status"];
	$u->logValues();
	if(is_a($u, "Client"))
	{
		$u->lead_producer = $_POST["lead_producer"];
		$u->lead_csr = $_POST["lead_csr"];
		
		foreach ($_POST as $key => $elem)
		{
			$underscore_loc = strpos($key, "_");
			$line_num = substr($key, 0, $underscore_loc);
			if(!empty($line_num) && $elem != 0)
			{
				$line_type = substr($key, $underscore_loc + 1, strlen($key));
				if(is_numeric($line_num))
				{
					if(strcmp($line_type, "csr") == 0)
					{
						$u->csrs[$line_num] = $elem;
					}
					else if(strcmp($line_type, "producer") == 0)
					{
						$u->producers[$line_num] = $elem;
					}
				}
				//echo($line_type . "[" . $line_num . "] = " . $elem . " <BR>");
			}
		}
	}
	$u->logValues();
	if($_POST["pwd_reset"] == 1)
	{
		$u->resetPassword();
	}
	$u->logValues();
	//echo($u->dbUpdate($dbmgr));
	if(!($u->dbUpdate($dbmgr)))
	{
		die("<h1 class=\"error\">ERROR - CANNOT IN UPDATE</h1>" . $u->dbUpdate($dbmgr));
	}
	$u->logValues();
	header("Location: user_menu.php");
}
else
{
	// Display mod form
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Root.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Security.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	if(!empty($_GET["id"]))
	{
		// A USER HAS BEEN SELECTED FOR EDITING.
		// DISPLAY TO EDIT
		$s = new Security();
		$u = $s->dbLoadUser($dbmgr, $_GET["id"]);
			
		if($u->id != $_GET["id"])
		{
			die("<H1 class=\"error\">$u. YOU MUST SELECT YOUR USER THROUGH THE MENU</H1>");
		}
		else //if($cNum != $_GET["id"])
		{
			$title = "Edit " . htmlspecialchars($u->user_name);
			include("html_header.inc");
			$u->logValues();
		?>
	<body>
		<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateClientMod(this)";>
			<input type="hidden" name="id" value="<? echo($u->id); ?>">
			<table class="mod_screen">
				<tr>
					<th class="menu" colspan="2">Modify User Profile</th>
				</tr>
				<tr>
					<td>LOGIN ID:</td>
					<td><input type="text" name="user_name" value="<? echo(htmlspecialchars($u->user_name));?>"></input></td>
				</tr>
				<tr>
					<td>FULL NAME:</td>
					<td><input type="text" name="name" value="<? echo(htmlspecialchars($u->name));?>"></input></td>
				</tr>
				<tr>
					<td>CONTACT:</td>
					<td><input type="text" name="contact" value="<?
						if(isset($u->contact))
							echo(htmlspecialchars($u->contact));
						else
							echo(htmlspecialchars($u->name));
					?>"></input></td>
				</tr>
				<tr>
					<td>CLIENT TYPE:</td>
					<td>
						<input type="radio" class="radio" name="sec_lvl_id" value="1" <?php if($u->sec_lvl_id == 1) echo("checked"); ?>>Client
						<input type="radio" class="radio" name="sec_lvl_id" value="2" <?php if($u->sec_lvl_id == 2) echo("checked"); ?>>Admin
						<input type="radio" class="radio" name="sec_lvl_id" value="3" <?php if($u->sec_lvl_id == 3) echo("checked"); ?>>Root
					</td>
				</tr>
				<tr>
					<td>PHONE #:</td>
					<td><input type="text" name="phone" value="<? echo($u->phone);?>"></td>
				</tr>
				<tr>
					<td>EMAIL:</td>
					<td><input type="text" name="email" value="<? echo($u->email);?>"></td>
				</tr>
				<tr>
					<td>STATUS:</td>
					<td><?php
						 echo("<input class=\"radio\" type=\"radio\" name=\"status\" value=\"1\"");
						 if($u->active)
							  echo(" checked");
						 echo(">&nbsp; Active\n");
						 echo("<input class=\"radio\" type=\"radio\" name=\"status\" value=\"0\"");
						 if(!($u->active))
							  echo(" checked");
						 echo(">&nbsp; Inactive\n");
				?></td>
				</tr>
				<tr>
					<td>RESET PASSWORD TO "password":</td>
					<td>
						<input class="radio" type="radio" name="pwd_reset" value="1">&nbsp;YES
						<input class="radio" type="radio" name="pwd_reset" value="0" checked>&nbsp;NO
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<h4>Multi-Line Accounts</h4>
					</td>
				</tr>
				<tr>
					<td>LEAD PRODUCER:</td>
					<td>
				<?php
					echo("\t\t<select class=\"associate\" name=\"lead_producer\">\n");
					$repArray = $admin->dbLoadRepListBrief($dbmgr);
					//echo("size = " . sizeof($repArray));
					echo("\t\t\t<option value=\"0\">NONE</option>\n");
					for($i=0; $i<sizeof($repArray); $i++)
					{
						$rep = $repArray[$i];
						echo("\t\t\t<option value=\"" . $rep->id . "\"");
						if(@$u->lead_producer == $rep->id){echo(" selected");}
						echo(">" . $rep->get_full_name() . "</option>\n");
					}
						echo("\t\t</select>\n");
				?>
					</td>
				</tr>
				<tr>
					<td>LEAD CSR:</td>
					<td>
				<?php
					echo("\t\t<select class=\"associate\" name=\"lead_csr\">\n");
					echo("\t\t\t<option value=\"0\">NONE</option>\n");
					//$repArray = $admin->dbLoadRepListBrief($dbmgr);
					//echo("size = " . sizeof($repArray));
					for($i=0; $i<sizeof($repArray); $i++)
					{
						$rep = $repArray[$i];
						echo("\t\t\t<option value=\"" . $rep->id . "\"");
						if(@$u->lead_csr == $rep->id) echo(" selected");
						echo(">" . $rep->get_full_name() . "</option>\n");
					}
						echo("\t\t</select>\n");
				?>
					</td>
				</tr>
				<?php
					$depts = $admin->dbLoadInsuranceDeptsActive($dbmgr);
					for($deptNum=0; $deptNum<sizeof($depts); $deptNum++)
					{
						$aDept = $depts[$deptNum];
					?>
				<tr>
					<td colspan="2">
						<h4><?php echo($aDept->name);?></h4>
					</td>
				</tr>
				<tr>
					<td>PRODUCER:</td>
					<td>
				<?php
					echo("\t\t<select class=\"associate\" name=\"" . $aDept->id . "_producer\">\n");
					echo("\t\t\t<option value=\"0\">NONE</option>\n");
					$repArray = $aDept->dbLoadRepList($dbmgr);
					for($i=0; $i<sizeof($repArray); $i++)
					{
						$rep = $repArray[$i];
						echo("\t\t\t<option value=\"" . $rep->id . "\"");
						if(isset($u->producers[$aDept->id]))
							if($u->producers[$aDept->id] == $rep->id) echo(" selected");
						echo(">" . $rep->get_full_name() . "</option>\n");
					}
						echo("\t\t</select>\n");
						?>
					</td>
				</tr>
				<tr>
					<td>CSR:</td>
					<td>
				<?php
					echo("\t\t<select class=\"associate\" name=\"" . $aDept->id . "_csr\">\n");
					echo("\t\t\t<option value=\"0\">NONE</option>\n");
					for($i=0; $i<sizeof($repArray); $i++)
					{
						$rep = $repArray[$i];
						echo("\t\t\t<option value=\"" . $rep->id . "\"");
						if(isset($u->csrs[$aDept->id]))
							if($u->csrs[$aDept->id] == $rep->id) echo(" selected");
						echo(">" . $rep->get_full_name() . "</option>\n");
					}
					echo("\t\t</select>\n");
						 ?>
					</td>
				</tr>
				<?php
					} // END for($i=0; $i<sizeof($depts); $i++)
				?>
				<tr>
					<td colspan="2" align="center">
						<input type="Submit" class="submitButton" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input class="submitButton" type="button" name="DELETE" value="DELETE" onclick="if(confirm('Are you sure you want to delete this user? (THIS WILL BE PERMANENT)')){location.href='user_edit.php?cid=<?php echo($u->id);?>&do=DEL'}" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submitButton" name="Cancle" value="Cancel" onClick="location.href='user_menu.php'" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					</td>
				</tr>
			</table>
		</form>
	<?
		} // END else //if($cNum != $_GET["id"])
	}// END if(!empty($_GET["id"]))
	else //if(!empty($_GET["id"]))
	{
		header("Location: menu.php");
	}
	?>
	</body>
	</html>
<?
}
?>