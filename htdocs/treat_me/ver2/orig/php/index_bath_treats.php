<?php
include("header.inc");
$REMOTE_ADDR =$_ENV["REMOTE_ADDR"];
mysql_connect("$DBHost","$DBUser","$DBPass");
$old=date("z")-1;
mysql_query("DELETE FROM Users WHERE Date < $old");

$result=mysql_query("SELECT cartItemsID , Date FROM CartItems");
while (@$row=mysql_fetch_row(@$result)) {
	$CII=$row[0];
	$CDa=$row[1];
	$pieces=explode(":",$CDa);
	$DCHK=@$pieces[1];
	if ($DCHK < $old) {
		mysql_query("DELETE FROM CartItems WHERE cartItemsID = '$CII'");
	}
}


if (!empty($_GET["UID"])) {
	$UID = $_GET["UID"];
	//echo("SELECT * FROM Users WHERE User=$UID");
	@$result = mysql_query("SELECT * FROM Users WHERE User='$UID'");
	$num = @mysql_num_rows($result);
	if ($num == "0") {
		$dt=date("YmdHis");
		$UID="$dt$REMOTE_ADDR";
		$date=date("z");
		mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
		Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID");
	}
}

if (empty($_GET["UID"])) {
	$dt=date("YmdHis");
	$UID="$dt$REMOTE_ADDR";
	$date=date("z");
	mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
	Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID");
}
$items = "SELECT * FROM itemdef, category, namedef WHERE " .
		"itemdef.CategoryID = category.CategoryID AND " .
		"namedef.nameID = itemdef.nameID AND " .
		"category.Category = \"Bath Treats\"";
$items = mysql_query($items);

while($item = mysql_fetch_array($items)){
	echo($item["name"] . "<BR>");
}
?>