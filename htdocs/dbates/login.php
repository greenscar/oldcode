<?php
require_once("./classes/Security.inc");
require_once("./classes/Secretary.inc");
require_once("./classes/DB_Mgr.inc");
session_start();
header("Cache-control: private");
$dbmgr = new DB_Mgr("dbates");
$guard = new Security();
$log = new Secretary();

//echo($log->write("test"));
if(isset($_SESSION["user"]))
{
	$user = $_SESSION["user"];
	$log->write("isset(_SESSION['user'])");
	// CLIENT ALREADY HAS A SESSION ACTIVE.
	// FORWARD TO CORRECT PAGE.
	if($guard->user_is_admin($user))
	{
		// ADMIN & ROOT WILL HAVE SAME SCREEN, ROOT WILL JUST HAVE 1 EXTRA MENU OPTION TO MANAGE ADMINS
		$log->write("Forwarding user to https://" . $_SERVER["SERVER_NAME"] . "/admin/index.php?UID=" . $user->id);
		header("Location: http://" . $_SERVER["SERVER_NAME"] . "/admin/index.php?UID=" . $user->id);
	}
	else if ($guard->user_is_sa_user($_SESSION["user"]))
	{
		// CLIENT IS SELECT ACCOUNT CLIENT
		$log->write("Forwarding user to https://" . $_SERVER["SERVER_NAME"] . "/client/index.php?UID=" . $user->id);
		header("Location: http://" . $_SERVER["SERVER_NAME"] . "/client/index.php?UID=" . $user->id);
	}
	else if ($guard->user_is_user($_SESSION["user"]))
	{
		// CLIENT IS CLIENT
		$log->write("Forwarding user to https://" . $_SERVER["SERVER_NAME"] . "/client/index.php?UID=" . $user->id);
		header("Location: http://" . $_SERVER["SERVER_NAME"] . "/client/index.php?UID=" . $user->id);
	}
	else
	{
		$user = $_SESSION["user"];
		$user->logValues();
		$_SESSION = array();
		session_destroy();
		$log->write("session destroyed. Forwarding user to " . $_SERVER["PHP_SELF"]);
		header("Location: " . $_SERVER["PHP_SELF"]);
	}
}
else if(empty($_POST["id"]))
{
	$log->write("empty(_POST['id'])");
	$log->write("Display login form");
   // CLIENT NEEDS TO ENTER LOGIN INFO
   // DISPLAY LOGIN FORM
   ?>
<html>
	<head><title>Durham and Bates - Portland, OR - Client Login</title>
	<style type="text/css">@import "template_public.css";</style>
		<script language =" javascript" type="text/javascript">
		function validateLoginForm(loginForm)
		{
		// only allow numbers to be entered
		var checkOK = "0123456789";
		var checkID = loginForm.id.value;
		var checkpwd = loginForm.pwd.value;
		var allValid = true;
		var allNum = "";
		if (checkID.length == 0)
		{
			alert("Please enter a login ID.");
			loginForm.id.focus();
			return (false);
		}    
		
		if (checkpwd.length == 0)
		{
			alert("You must enter a pwd.");
			loginForm.pwd.focus();
			return (true);
		}    
		}
		
		</script>
	</head>
	<body onload="loginForm.id.select(); loginForm.id.focus();">
	<table align="center" width=750px height=552px style="border: 1px solid #000000; border-spacing: 0px;border-collapse: collapse; padding: 0px;margin:0px auto;">
	<tr>
		<td colspan="2" align="right" valign="middle">
		<div class="topBar" style="background-color: #00A9DE;">            
			<form method="GET" action="http://www.dbates.com/cgi-bin/htsearch">
				<input type="text" name="words" class="searchText"></input>
				<input type="submit" name="Search" value="Search Site" class="searchButton" onMouseOver="this.style.backgroundColor='#003366'"; onMouseOut="this.style.backgroundColor='#006390'">
				<input type="hidden" name="config" value="htdig">
				<input type="hidden" name="restrict" value="">
				<input type="hidden" name="exclude" value="">
			</form>
		</div>
		</td>
	</tr>
	<tr>
		<?php include("menu_left_secure.inc");?>
		<td width="500px" style="background-color:#FFF9EC;padding: 0px; vertical-align: top;">
		<table class="title">
		<tr>
			<td>
			<img class="title" src="./public_images/map.jpg" alt="Client Login" >
			</td>
			<td style="padding: 0 0 2px 10px;">
			<font class="pageTitle">CLIENT LOGIN</font>
			</td>
		</tr>
		</table>
		<br><br>
			<FORM NAME="loginForm" METHOD="post" ACTION="<?php echo($_SERVER["PHP_SELF"]); ?>" ONSUBMIT="return validateLoginForm(this)">
			<TABLE BORDER="4" CELLPADDING="4" ALIGN="CENTER" HEIGHT="115">
			<?php
				if(isset($_GET["do"]) && $_GET["do"] == "np")
				{
					echo("<tr><td align=\"center\">You do hot have a custom page. <br>If you feel this is an error, please contact us.</td></tr>");
				}
			?>
				<TR>
				<TD>            
				<TABLE BORDER="0" ALIGN="CENTER" HEIGHT="115">
					<TR>                  
					<TD ALIGN="right">Login ID:</TD>
		
					<TD><INPUT TYPE="text" NAME="id" value=""></TD>
					</TR>
					<TR>
					<TD ALIGN="right">Password:</TD>
					<TD><INPUT TYPE="password" NAME="pwd" value=""></TD>               
					</TR>               
					<TR>
					<TD ALIGN ="CENTER" colspan="2">
					<INPUT TYPE="submit" NAME="Submit" VALUE="Login">   
					<INPUT TYPE="reset" NAME="Reset" VALUE="Reset">
					</TD>               
					</TR>            
				</TABLE>
				</TD>
				</TR>      
			</TABLE>   
			</FORM>   
		</td>
	</tr>
	<tr>
	<td align="center" colspan="2" style="background-color: #00A9DE; border-top: 1px #006390 solid; border-bottom: 2px #006390 solid; top: 0px;left: 0px;padding: 0px;">
        <?php include("menu_bottom.inc");?>
	</td>
	</tr>
	</table>   
	</body>
   </html>
   <?php
}
else if(isset($_POST["id"]))
{
	$log->write("isset(_POST['id'])");
	// CLIENT IS ATTEMPTING TO LOG IN.
	// PROCESS LOGIN
	$loginSuccessful = $guard->dbLoginUser(&$_SESSION, $dbmgr, $_POST["id"], $_POST["pwd"]);
	if($loginSuccessful)
	{
		if($guard->user_is_admin($_SESSION["user"]))
		{
			// ADMIN & ROOT WILL HAVE SAME SCREEN, ROOT WILL JUST HAVE 1 EXTRA MENU OPTION TO MANAGE ADMINS
			$log->write("Forwarding user to https://" . $_SERVER["SERVER_NAME"] . "/admin/index.php?UID=" . $_POST["id"]);
			header("Location: http://" . $_SERVER["SERVER_NAME"] . "/admin/index.php?UID=" . $_POST["id"]);
			//header("Location: https://" . $_SERVER["SERVER_NAME"] . "/admin/index.php?UID=" . $_POST["id"]);
		}
		else
		{
			// CLIENT IS CLIENT
			$log->write("Forwarding user to https://" . $_SERVER["SERVER_NAME"] . "/client/index.php?UID=" . $_POST["id"]);
			header("Location: http://" . $_SERVER["SERVER_NAME"] . "/client/index.php?UID=" . $_POST["id"]);
			//header("Location: https://" . $_SERVER["SERVER_NAME"] . "/client/index.php?UID=" . $_POST["id"]);
		}   
	}
	else
	{
		$log->write("loginSuccessful == false. Forwarding user to " . $_SERVER["PHP_SELF"]);
		header("Location: " . $_SERVER["PHP_SELF"]);
	}
}
?>