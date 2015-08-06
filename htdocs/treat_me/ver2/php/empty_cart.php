<?
include("header.inc");
$UID = $_POST["UID"];
mysql_connect("$DBHost","$DBUser","$DBPass");
mysql_query("DELETE FROM cartItems WHERE UserID='$UID'");
Header("Location: view_cart.php?UID=$UID");
?>
