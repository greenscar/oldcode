<?
include("header.inc");

mysql_connect("$DBHost","$DBUser","$DBPass");
$nameID = @$_GET["nameID"];
$UID = @$_GET["UID"];
$ID = @$_GET["ID"];
if (!empty($UID)) {
	$result=mysql_query("SELECT * FROM Users WHERE User='$UID'");
	$num=@mysql_num_rows($result);
	if ($num == "0") {
		$dt=date( "YmdHis");
		$UID= "$dt$REMOTE_ADDR";
		$date=date( "z");
		mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
		Header( "Location: $PHP_SELF?II=$ID&UID=$UID");
	}
}

if (empty($UID)) {
	$dt=date( "YmdHis");
	$UID= "$dt$REMOTE_ADDR";
	$date=date( "z");
	mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
	Header( "Location: $PHP_SELF?II=$ID&UID=$UID");
}

$name = mysql_query("SELECT name, description FROM nameDef WHERE nameID = $nameID");
$name = mysql_fetch_array($name);
$description = $name["description"];
$name = $name["name"];

commonHeader("$Company","Product description");
$string = "SELECT * FROM itemDef WHERE ID='$ID'";
$result=mysql_query($string);

echo "<table border='0' cellpadding='10' cellspacing='10'>";

$row = mysql_fetch_row($result);
$SKU=$row[0];
$categoryID=$row[1];
$nameID=$row[2];
$flavorID=$row[3];
$sizeID=$row[4];
$retail=$row[5];
$wholesale=$row[6];
$ID=$row[7];

$flavor = mysql_query("SELECT flavor FROM flavorDef WHERE flavorID = $flavorID");
$flavor = mysql_fetch_array($flavor);
$flavor = $flavor["flavor"];

$size = mysql_query("SELECT size FROM sizeDef WHERE sizeID = $sizeID");
$size = mysql_fetch_array($size);
$size = $size["size"];

blueFont("Arial","<b>Here is a description of $name...<br><br>");

if (file_exists("./images/$ID.jpg")) {
	echo "<tr><td></td><td></td><td rowspan=\"5\" valign=\"bottom\">";
	echo "<p><br><p><br><img src=\"images/$ID.jpg\"></td></tr>";
}


echo "<tr><td>";
redFont ("Arial","Product Code: ");
echo "</td><td>";
blueFont("Arial"," $SKU");
echo "</td><td></td></tr>";
echo "<tr><td>";
redFont ("Arial","Product Name: ");
echo "</td><td>";
blueFont("Arial"," $name");
echo "</td><td></td></tr>";
echo "<tr><td>";
redFont ("Arial","Price: ");
echo "</td><td>";
$retail=number_format($retail,"2",".","thousands_sep");
blueFont("Arial"," $$retail");
echo "</td><td></td></tr><tr><td>";
echo "</td><td></td></tr>";
echo "<tr><td>";
if ($ID != "") {
	redFont ("Arial","Description: "); 
}
echo "</td><td colspan='2'>";
blueFont("Arial"," $description");
echo "</td></tr>";

echo "</table>";

echo "<table border=\"0\" cellpadding=\"5\" cellspacing=\"5\"><tr><td>";
echo "<FORM ACTION=\"./addCart.php\" METHOD=\"POST\">";
blueFont("Arial","<br><br><INPUT TYPE=\"checkbox\" NAME=\"ID\" VALUE=\"$ID\" CHECKED> Add ");
blueFont("Arial","<INPUT TYPE=\"TEXT\" Name=\"Quantity\" Value=\"1\" size=\"2\"> of");
blueFont("Arial"," this item to my shopping cart");
echo "<INPUT TYPE=\"hidden\" NAME=\"UID\" VALUE=\"$UID\">";
$Date=date("Y:z:Y-m-d");
echo "<input type=\"hidden\" name=\"Date\" value=\"$Date\">";
echo "<input type=\"hidden\" name=\"ID\" value=\"$ID\">";
echo "</td><td><br><br><INPUT TYPE=\"SUBMIT\" VALUE=\"Add This Item To My Cart\"></td></tr></table></FORM>";

commonFooter($Relative,$UID);
?>
