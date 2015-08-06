<?php
include("header.inc");
require_once("some_useful_functions.inc");
//phpinfo();
$REMOTE_ADDR =$_ENV["REMOTE_ADDR"];
mysql_connect("$DBHost","$DBUser","$DBPass");
$old=date("z")-5;
$delete = "DELETE FROM Users WHERE Date < $old";
mysql_query($delete);

$result=mysql_query("SELECT cartItemsID , Date FROM CartItems");
while (@$row=mysql_fetch_row(@$result)) {
	$cart_item_id=$row[0];
	$cart_date=$row[1];
	$pieces=explode(":",$cart_date);
	$DCHK=@$pieces[1];
	if ($DCHK < $old) {
		mysql_query("DELETE FROM CartItems WHERE cartItemsID = '$cart_item_id'");
	}
}

if (!empty($_GET["UID"])) {
	$UID = $_GET["UID"];
	@$result = mysql_query("SELECT * FROM Users WHERE User='$UID'");
	$num = @mysql_num_rows($result);
	if ($num == "0") {
		$dt=date("YmdHis");
		$UID="$dt$REMOTE_ADDR";
		$date=date("z");
		mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
		Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=" . $UID . "");
	}
}
else if (!empty($_POST["UID"])) {
	$UID = $_POST["UID"];
	@$result = mysql_query("SELECT * FROM Users WHERE User='$UID'");
	$num = @mysql_num_rows($result);
	if ($num == "0") {
		$dt=date("YmdHis");
		$UID="$dt$REMOTE_ADDR";
		$date=date("z");
		mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
		Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=" . $UID . "");
	}
}
else {
	$category = @$_GET["category"];
	$dt=date("YmdHis");
	$UID="$dt$REMOTE_ADDR";
	$date=date("z");
	mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
	Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=" . $UID . "");
}
?>