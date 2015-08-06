<?
include("header.inc");

mysql_connect("$DBHost","$DBUser","$DBPass");

$result=mysql("$DBName","SELECT ItemID FROM Items WHERE Category='$CategoryID'");
while ($row=mysql_fetch_row($result)) {
$III=$row[0];
exec("rm $WebRoot/images/$III.jpg");
mysql("$DBName","DELETE FROM Items WHERE ItemID='$III'");
}
mysql("$DBName","DELETE FROM Category WHERE CategoryID='$CategoryID'");

Header("Location: admin/");
?>
