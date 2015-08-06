<?
include("header.inc");
commonHeader("$Company","Remove An Item");

blueFont("Arial","Select the item to remove, and then SUBMIT!<br><br>");
echo "<TABLE BORDER=\"0\" CELLPADDING=\"10\" CELLSPACING=\"10\"><TR>";
echo "<tr><td>";
$string = "SELECT * FROM itemDef WHERE itemID='" . $_POST["itemID"] . "'";
$result=mysql_query($string);

while ($row = mysql_fetch_array($result)) {
	$nameID = $row["nameID"];
	$search = mysql_query("SELECT name FROM nameDef WHERE nameID = $nameID");
	$name = mysql_fetch_array($search);
	$sizeID = $row["sizeID"];
	$search = mysql_query("SELECT size FROM sizeDef WHERE sizeID = $sizeID");
	$size = mysql_fetch_array($search);
	$flavorID = $row["flavorID"];
	$search = mysql_query("SELECT flavor FROM flavorDef WHERE flavorID = $flavorID");
	$flavor = mysql_fetch_array($search);
	$SKU = $row["SKU"];
	$ID=$row["itemID"];
	$name = $name["name"];		
	$flavor = $flavor["flavor"];
	$size = $size["size"];
}

blueFont("Arial","<h2>Are you sure you want to delete </h22>");
colorFont("yellow", "Arial","<h2>Item $SKU ($size oz. $flavor $name)?</h2><p>");
echo "<form action=\"remove_item_response.php\" method=\"post\">";
echo "<input type=\"hidden\" name=\"itemID\" value=\"$ID\">";
echo "<INPUT TYPE=\"submit\" VALUE=\"YES\"></form><p>";

echo "<form action=\"./admin/\" method=\"post\">";
echo "<INPUT TYPE=\"submit\" VALUE=\"NO\"></form><p>";

echo "</td></tr></table>";

adminFooter();
?>
