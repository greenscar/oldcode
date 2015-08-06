<?php
if(isset($_POST["user_name"]))
{
	// Process Client Create
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
	$dbmgr = new DB_Mgr("dbates");
	$c = new Client();
	$c->user_name = $_POST["user_name"];
	$c->setPassword($_POST["password"]);
	//$c->password = $_POST["password"];
	$c->sec_lvl_id = $_POST["sec_lvl_id"];
	$c->name = $_POST["name"];
	$c->contact = $_POST["contact"];
	$c->phone = $_POST["phone"];
	$c->email = $_POST["email"];
	$c->active = $_POST["active"];
	$c->lead_producer = $_POST["lead_producer"];
	$c->lead_csr = $_POST["lead_csr"];
	
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
					$c->csrs[$line_num] = $elem;
				}
				else if(strcmp($line_type, "producer") == 0)
				{
					$c->producers[$line_num] = $elem;
				}
			}
			//echo($line_type . "[" . $line_num . "] = " . $elem . " <BR>");
		}
	}
	
	//echo($c->dbInsert($dbmgr));
	if(!($c->dbInsert($dbmgr)))
	{
		die("<h1 class=\"error\">ERROR - CANNOT INSERT</h1>" . $c->dbInsert($dbmgr));
	}
	header("Location: user_menu.php");
}
else
{
	// Display Client Create Form
	$title = "Enter your client information";
	include("html_header.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
	require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
	$dbmgr = new DB_Mgr("dbates");
	$admin = new Admin();
	?>
	<body>
		<form name="form" method="post" action="<?php echo($_SERVER["PHP_SELF"]); ?>" onsubmit="return validateUserCreate(this)";>
			<table class="mod_screen">
				<tr>
					<th class="menu" colspan="2">Enter User Profile</th>
				</tr>
				<tr>
					<td width="40%">LOGIN ID:</td>
					<td><input type="text" name="user_name"></input></td>
				</tr>
				<tr>
					<td>FULL NAME:</td>
					<td><input type="text" name="name"></input></td>
				</tr>
				<tr>
					<td>PASSWORD:</td>
					<td><input type="password" name="password"></input></td>
				</tr>
				<tr>
					<td>PASSWORD (AGAIN):</td>
					<td><input type="password" name="password2"></input></td>
				</tr>
				<tr>
					<td>CONTACT:</td>
					<td><input type="text" name="contact"></input></td>
				</tr>
				<tr>
					<td>CLIENT TYPE:</td>
					<td>
						<input type="radio" class="radio" name="sec_lvl_id" value="1">Client
						<input type="radio" class="radio" name="sec_lvl_id" value="2">Admin
						<input type="radio" class="radio" name="sec_lvl_id" value="3">Root
					</td>
				</tr>
				<tr>
					<td>PHONE #:</td>
					<td><input type="text" name="phone"></td>
				</tr>
				<tr>
					<td>EMAIL:</td>
					<td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>STATUS:</td>
					<td>
						<input class="radio" type="radio" name="active" value="1" checked>&nbsp; Active
						<input class="radio" type="radio" name="active" value="0">&nbsp; Inactive
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
						echo("\t\t\t<option value=\"" . $rep->id . "\">" . $rep->get_full_name() . "</option>\n");
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
					$repArray = $admin->dbLoadRepListBrief($dbmgr);
					//echo("size = " . sizeof($repArray));
					for($i=0; $i<sizeof($repArray); $i++)
					{
						$rep = $repArray[$i];
						echo("\t\t\t<option value=\"" . $rep->id . "\">" . $rep->get_full_name() . "</option>\n");
					}
						echo("\t\t</select>\n");
				?>
					</td>
				</tr>
				<?php
					$depts = $admin->dbLoadInsuranceDeptsActive($dbmgr);
					for($deptNum=0; $deptNum < sizeof($depts); $deptNum++)
					{
						//echo("<tr><td>depts.size = " . sizeof($depts) . "</td></tr>");
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
					//echo("size = " . sizeof($repArray));
					for($i=0; $i<sizeof($repArray); $i++)
					{
						$rep = $repArray[$i];
						echo("\t\t\t<option value=\"" . $rep->id . "\">" . $rep->get_full_name() . "</option>\n");
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
					//echo("size = " . sizeof($repArray));
					for($i=0; $i<sizeof($repArray); $i++)
					{
						$rep = $repArray[$i];
						echo("\t\t\t<option value=\"" . $rep->id . "\">" . $rep->get_full_name() . "</option>\n");
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
						<input type="Submit" class="submit" name="Submit" value="Submit" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
						<input type="Button" class="submit" name="Cancle" value="Cancel" onClick="location.href='user_menu.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
					</td>
				</tr>
			</table>
		</form>
	</body>
	</html>
<?php
}
?>