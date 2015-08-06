<?
include("header.inc");
//SET THE ITEM NOT ACTIVE
$update = "UPDATE itemDef SET active = 0 WHERE itemID = '" . $_POST["itemID"] . "'";
mysql_query($update) or die("Error in Query: $update. mysql said " . mysql_error() . '.'); 
//mysql_query("DELETE FROM itemDef WHERE itemID='" . $_POST["itemID"] . "'");
exec("rm $WebRoot/images/" . $_POST["itemID"] . ".jpg");
Header("Location: ./index.php");
?>
