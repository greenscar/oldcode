<?php
    include("ensure_root.inc");
?>
<?php
//    include("../includes/php_files/ensure_admin.inc");
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Please Enter The Role</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" type="text/css" href="./inc_files/template.css"/>
</head>

<body>
<form name="ldp" method="post" action="role_create_process.php">

<div class="center">
	<div class="grey_box_70">
		<div class="spacer"></div>
<?php
if(isset($_GET["disp"]))
{
?>
		<div class="row_center">
			You have entered a role that is already in the list below.
		</div>
		<div class="spacer"></div>
<?php
}
?>
		<div class="row">
			<span class="label">
				Role Name:
			</span>
			<span class="right">
				<input type="text" class="name" name="name">
			</span>
		</div>
		<div class="spacer">&nbsp;</div>
		<div class="row_center">
			<input class="grey" type="submit" name="submit" value="Submit">
		</div>
		<div class="spacer">&nbsp;</div>
	</div>
</div>
</form>
<div class="center">
	<div class="grey_box_70">
		<div class="spacer"></div>
		<div class="header">
			Existing Roles
		</div>
		<div class="spacer"></div>
		<div class="grey_box_25">
			
<?php
include("../php/classes/DB_Mgr.inc");
$dbmgr = new DB_Mgr("dbates");
$query = "SELECT * FROM 


require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Phone_System.inc");
$ps = new Phone_System();
$ps->db_load_phone_type_list();
for($i=0; $i < $ps->phone_type_list_size(); $i++)
{
	$phone_line = $ps->get_a_phone_type_from_list($i);
?>
			
		<div class="row_center">
			<?php echo($phone_line->name); ?>
		</div>
		<div class="spacer"></div>
<?php
}
?>
		</div>
	</div>
</div>
<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>
<div class="center">
	<div class="grey_box_50">
	<div class="spacer"></div>
	<a class="button" href="index.htm">Home</a>
	<div class="spacer"></div>
	</div>
</div>
</body>
</html>