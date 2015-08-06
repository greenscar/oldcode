<?
include("header.inc");
commonHeader("$Company","Update An Item");

blackFont("Arial","Select the item to update, and then SUBMIT!<br><br>");
echo("<TABLE BORDER=\"0\" CELLPADDING=\"10\" CELLSPACING=\"10\"><TR>");
echo("<FORM ACTION=\"./update_item_process.php\" METHOD=\"POST\">");
echo("<tr><td>");
blackFont("Arial","Select An Item<br>");
echo("<select name=\"ItemID\" size=\"1\">");
$result = mysql_query("SELECT itemID, nameID, SKU FROM itemDef WHERE active = 1");
while ($row = mysql_fetch_array($result)) {
	$nameID = $row["nameID"];
	$search = mysql_query("SELECT name FROM nameDef WHERE nameID = $nameID");
	$name = mysql_fetch_array($search);
	$name = $name["name"];		
	echo("<option value=\"" . $row["itemID"] . "\"> $name - " . $row["SKU"] . " </option>");
}
echo("</select></td></tr>");
echo("<tr><td align=\"center\"><INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Submit\"><input TYPE=\"Button\" VALUE=\"Cancel\" onClick=\"window.location='./index.php'\"></form></TABLE>");

adminFooter();
?>
