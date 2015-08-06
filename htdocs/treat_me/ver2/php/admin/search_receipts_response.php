<?
include("header.inc");
blueFont("Arial","<b>Select the proper order to continue...</b><br><br>");
echo "<ul>";
if ($_GET["criteria"] == "order") {
	$result=mysql_query("SELECT BuyerID,OrderNumber,PayMethod,CCType,Contact,nameFirst, nameLast FROM buyers WHERE OrderNumber = '" . $_POST["OrderNumber"] . "' ORDER BY OrderNumber");
	while ($row = mysql_fetch_row($result)) {
		$BuyerID=$row[0];
		$OrderNumber=$row[1];
		$PayMethod=$row[2];
		$CCType=$row[3];
		$Contact=$row[4];
		$Name=$row[5] . " " . $row[6];
		fontFace("Arial","<li><a href=\"./receipt.php?BI=$BuyerID&ON=$OrderNumber&PM=$PayMethod&CT=$CCType&Co=$Contact\">$Name - Order Number <b>$OrderNumber</b></a></li>");
	}
} 
elseif ($_GET["criteria"] == "name") {
	$result=mysql_query("SELECT BuyerID,OrderNumber,PayMethod,CCType,Contact, nameFirst, nameLast FROM buyers WHERE nameLast LIKE '%" . $_POST["LastName"] . "%' ORDER BY OrderNumber");
	while ($row = mysql_fetch_row($result)) {
		$BuyerID=$row[0];
		$OrderNumber=$row[1];
		$PayMethod=$row[2];
		$CCType=$row[3];
		$Contact=$row[4];
		$Name=$row[5] . " " . $row[6];
		fontFace("Arial","<li><a href=\"./receipt.php?BI=$BuyerID&ON=$OrderNumber&PM=$PayMethod&CT=$CCType&Co=$Contact\">$Name - Order Number <b>$OrderNumber</b></a></li>");
	}
} 
elseif ($_GET["criteria"] == "date"){
	$string = "SELECT BuyerID,OrderNumber,PayMethod,CCType,Contact,nameFirst, nameLast FROM buyers WHERE Date LIKE '%" . $_POST["Year"] . "%-%" . $_POST["Month"] . "%-%" . $_POST["Day"] . "%' ORDER BY OrderNumber";
	$result=mysql_query($string) or die(mysql_error() . "in $string<BR>");
	while ($row = mysql_fetch_row($result)) {
		$BuyerID=$row[0];
		$OrderNumber=$row[1];
		$PayMethod=$row[2];
		$CCType=$row[3];
		$Contact=$row[4];
		$Name=$row[5] . " " . $row[6];
		fontFace("Arial","<li><a href=\"./receipt.php?BI=$BuyerID&ON=$OrderNumber&PM=$PayMethod&CT=$CCType&Co=$Contact\">$Name - Order Number <b>$OrderNumber</b></a></li>");
	}
}
else{
	$string = "SELECT BuyerID,OrderNumber,PayMethod,CCType, Contact,nameFirst, nameLast FROM buyers ORDER BY OrderNumber";
	$result=mysql_query($string) or die(mysql_error() . "in $string<BR>");
	while ($row = mysql_fetch_row($result)) {
		$BuyerID=$row[0];
		$OrderNumber=$row[1];
		$PayMethod=$row[2];
		$CCType=$row[3];
		$Contact=$row[4];
		$Name=$row[5] . " " . $row[6];
		fontFace("Arial","<li><a href=\"./receipt.php?BI=$BuyerID&ON=$OrderNumber&PM=$PayMethod&CT=$CCType&Co=$Contact\">$Name - Order Number <b>$OrderNumber</b></a></li>");
	}
}
echo "</ul>";
adminFooter();
?>
