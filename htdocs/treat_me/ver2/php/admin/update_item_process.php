<?
include("header.inc");
$SKU=0;
$nameID=0;
$flavorID=0;
$sizeID=0;
$description=0;
$retail=0;
$wholesale=0;
$shipping=0;
$itemID=0;
commonHeader("$Company","Update An Item");
$result = mysql_query("SELECT * FROM itemDef WHERE itemID = '" . $_POST["ItemID"] . "'");
while($row=mysql_fetch_row($result)) {
	$SKU=$row[0];
	$categoryID=$row[1];
	$nameID=$row[2];
	$flavorID=$row[3];
	$sizeID=$row[4];
	$retail=$row[5];
	$itemID=$row[6];
}

$name = mysql_query("SELECT name, description FROM nameDef WHERE nameID = $nameID");
$name = mysql_fetch_array($name);
$description = $name["description"];
$name = $name["name"];

$flavor = mysql_query("SELECT flavor FROM flavorDef WHERE flavorID = $flavorID");
$flavor = mysql_fetch_array($flavor);
$flavor = $flavor["flavor"];

$size = mysql_query("SELECT size FROM sizeDef WHERE sizeID = $sizeID");
$size = mysql_fetch_array($size);
$size = $size["size"];

blackFont("Arial","Type the new data into the boxes, and then SUBMIT!<br><br>");
echo("<TABLE BORDER=\"0\" CELLPADDING=\"2\" CELLSPACING=\"2\"><TR>");
echo("<FORM ACTION=\"./update_item_response.php\" METHOD=\"POST\">");
echo("<tr><td>");
blackFont("Arial","Item itemID (SKU)<br>");
echo("<input type='text' name=\"SKU\" size=\"6\" value=\"$SKU\">");
echo("</td></tr>");

echo("<tr><td>");
blackFont("Arial","Item Category (SKU)<br>");
echo "<select name=\"categoryID\" size=\"1\">";
$result=mysql_query("SELECT * FROM category ORDER BY category");
while ($row = mysql_fetch_row($result)) {
	echo "<option ";
	if($row[1] == $categoryID)
		echo "selected ";
	echo "value=\"$row[1]\"> $row[0] </option>";
}
echo "</select></td></tr>";

//echo("<input type='text' name=\"SKU\" size=\"40\" value=\"$SKU\">");
//echo("</td></tr>");

echo("<tr><td>");
blackFont("Arial","Item Name<br>");
echo("<input type=\"text\" name=\"name\" size=\"40\" value=\"$name\">");
echo("</td></tr>");

echo("<tr><td>");
blackFont("Arial","Item Flavor<br>");
echo("<input type=\"text\" name=\"flavor\" size=\"40\" value=\"$flavor\">");
echo("</td></tr>");

echo("<tr><td>");
blackFont("Arial","Item Size<br>");
echo("<input type=\"text\" name=\"size\" size=\"5\" value=\"$size\">oz.");
echo("</td></tr>");

echo("<tr><td>");
blackFont("Arial","Cost<br>");
if ($retail == "0.00") $retail = "";
echo("<input type=\"text\" name=\"retail\" size=\"6\" value=\"$retail\">");
echo("</td></tr>");

echo("<tr><td colspan='2'>");
blackFont("Arial","ItemDescription<br>");
$description=ereg_replace("\"","&quot;",$description);
echo("<textarea name=\"description\" rows=\"10\" cols=\"50\" wrap>" . strip_tags($description) .  "</textarea>");
echo("</td></tr>");
echo("<input type=\"hidden\" name=\"itemID\" value=\"$itemID\">");
echo("<tr><td align=\"center\"><INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Submit\"><input TYPE=\"Button\" VALUE=\"Cancel\" onClick=\"window.location='./index.php'\"></form></TABLE>");

fontFace("Arial"," | <a href=\"./index\">Home</a>");
adminFooter();
?>
