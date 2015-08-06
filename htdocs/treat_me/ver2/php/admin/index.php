<?

include("header.inc");
$Yr=date("Y");
$Dy=date("z");

$result = mysql_query("SELECT Date,BuyerID,OrderNumber FROM buyers");
while ($row=mysql_fetch_row($result)) {
	$Date=$row[0];
	$BuyerID=$row[1];
	$OrderNumber=$row[2];
	$pieces=explode(":",$Date);
	if ($Yr > $pieces[0] AND $Dy > $pieces[1]) {
		mysql_query("DELETE FROM Buyers WHERE BuyerID='$BuyerID'");
		mysql_query("DELETE FROM Orders WHERE OrderNumber='$OrderNumber'");
		mysql_query("DELETE FROM Receipts WHERE OrderNumber='$OrderNumber'"); 
	}
}

commonHeader("$Company","Administrative Functions");

blueFont("Arial","<p>Choose an administrative function...</p><br>\n");
fontFace("Arial","<a href='./search_receipts.php'>Get A Receipt</a><br>\n");
/*
fontFace("Arial","<a href='./add_item.php'>Add An Item</a><br>\n");
fontFace("Arial","<a href='./update_item.php'>Update An Item</a><br>\n");
fontFace("Arial","<a href='./remove_item.php'>Remove An Item</a><br>\n");
*/
//fontFace("Arial","<a href='./add_category.php'>Add A Category</a><br>\n");
//fontFace("Arial","<p><a href='./removeCategory.php'>Remove A Category</a></p>");
fontFace("Arial","<a href='./view_catalog.php'>View Catalog</a><br>");
fontFace("Arial","<a href='./massMail.htm'>Mass Email</a><br>");
echo "</ul>\n";
echo("</HTML>")
?>

