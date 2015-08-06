<?
include("header.inc");
$nameID = $_POST["lastItemViewedID"];
$cartItemsID = @$_POST["cartItemsID"];
$UID = @$_POST["UID"];
mysql_connect("$DBHost","$DBUser","$DBPass");
$select = "SELECT ItemQuantity FROM cartItems WHERE cartItemsID='$cartItemsID'";
$result=mysql_query($select) or die(mysql_error() . "in $select<BR>");;
while ($row  =  mysql_fetch_row($result))  {
	@$Number=$row[0];
}
$NewValue=(@$Number + 1);
$update = "UPDATE cartItems set ItemQuantity='$NewValue' WHERE cartItemsID='$cartItemsID'";
mysql_query($update) or die(mysql_error() . "in $update<BR>");
//echo("Location: view_cart.php?UID=$UID?nameID=$nameID");
Header("Location: view_cart.php?UID=$UID&nameID=$nameID");
?>
