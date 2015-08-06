<?
include("./some_useful_functions.inc");
include("header.inc");
mysql_connect("$DBHost","$DBUser","$DBPass");
$UID = $_GET["UID"];
$itemID = $_GET["itemID"];
$quantity_to_add = 1;
$date=date("Y:z:Y-m-d");
$select = "SELECT * FROM cartItems WHERE UserID = '$UID' AND ItemID = '$itemID'";
//echo($select . "<BR>");
$select = mysql_query($select) or die(mysql_error() . "in $select<BR>");
$select = mysql_fetch_array($select);
//view_array($select);
$quantity_in_cart = @$select["ItemQuantity"];
$cartItemsID = @$select["cartItemsID"];
//echo(@$select["ItemQuantity"] . ", " . $select["cartItemsID"] . "<BR>");
//echo($quantity_in_cart . ", " . $cartItemsID . "<BR>");
if(isset($quantity_in_cart)){
	$quantity = $quantity_in_cart + $quantity_to_add;
	$insert = "UPDATE cartItems set ItemQuantity='$quantity' WHERE cartItemsID='$cartItemsID'";
}
else{
	$insert = "INSERT INTO cartItems VALUES ('$UID' , '$itemID' , '$quantity_to_add' , '$date' , '')";
}
//echo $insert . "<BR>";
mysql_query($insert) or die(mysql_error() . "in $insert<BR>");
//echo("Location: view_cart.php?UID=" . $UID);
Header("Location: view_cart.php?UID=" . $UID . "&nameID=" . $itemID);
?>
