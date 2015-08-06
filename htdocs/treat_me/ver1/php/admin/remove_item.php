<?
include("header.inc");
commonHeader("$Company","Remove An Item");

blueFont("Arial","Select the item to remove, and then SUBMIT!<br><br>");
echo "<TABLE BORDER=\"0\" CELLPADDING=\"10\" CELLSPACING=\"10\"><TR>";
echo "<FORM ACTION=\"./remove_item2.php\" METHOD=\"POST\">";

echo "<tr><td>";
blueFont("Arial","Select An Item<br>");
echo "<select name=\"itemID\" size=\"1\">";
$result = mysql_query("SELECT itemID, nameID, SKU FROM itemDef WHERE active=1 ORDER BY categoryID, nameID, SKU");
while ($row = mysql_fetch_array($result)) {
	$nameID = $row["nameID"];
	$search = mysql_query("SELECT name FROM nameDef WHERE nameID = $nameID");
	$name = mysql_fetch_array($search);
	$name = $name["name"];		
	echo("<option value=\"" . $row["itemID"] . "\"> $name - " . $row["SKU"] . " </option>\n");
}
echo("</select></td></tr>");
echo "<tr>\n\t<td align=\"center\">\n\t\t";
echo("<INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Submit\">\n\t\t");
echo("<input TYPE=\"Button\" VALUE=\"Cancel\" onClick=\"window.location='./index.php'\">\n\t");
echo("</TD>\n</TR>\n</form>\n</TABLE>");

adminFooter();
?>
