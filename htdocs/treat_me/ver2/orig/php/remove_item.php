<?
include("header.inc");
$nameID = $_POST["lastItemViewedID"];
$cartItemsID = @$_POST["cartItemsID"];
$UID = @$_POST["UID"];
$query = "SELECT ItemQuantity FROM cartItems WHERE cartItemsID='$cartItemsID'";
$result = mysql_query($query) or die(mysql_error() . " in $query<BR>");
while ($row  =  mysql_fetch_row($result))  {
	@$Number=$row[0];
}
$NewValue=(@$Number - 1);
if($NewValue == 0){
	$query = "DELETE FROM cartItems WHERE cartItemsID='" . $cartItemsID ."'";
	mysql_query($query) or die(mysql_error() . " in $query<BR>");
}
else{
	$query = "UPDATE cartItems set ItemQuantity='$NewValue' WHERE cartItemsID='$cartItemsID'";
	mysql_query($query) or die(mysql_error() . " in $query<BR>");
}
Header("Location: view_cart.php?UID=$UID&nameID=$nameID");
?>
