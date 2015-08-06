<?
include("header.inc");
mysql_connect("$DBHost","$DBUser","$DBPass");
$category_ID = $_GET["CA"];
$UID = $_GET["UID"];
$REMOTE_ADDR = $_ENV["REMOTE_ADDR"];

if (!empty($UID)) {
	$result=mysql_query("SELECT * FROM users WHERE User='$UID'");
	$num=mysql_num_rows($result);
	if ($num ==   "0") {
		$dt=date("YmdHis");
		$UID=  "$dt$REMOTE_ADDR";
		$date=date("z");
		mysql_query("INSERT INTO users VALUES ('$UID','$date')");
		Header("Location: " . $_SERVER['PHP_SELF'] . "?CA=$category_ID&UID=$UID");
	}
}

if (empty($UID)) {
	$dt=date("YmdHis");
	$UID=  "$dt$REMOTE_ADDR";
	$date=date("z");
	mysql_query("INSERT INTO users VALUES ('$UID','$date')");
	Header("Location: " . $_SERVER['PHP_SELF'] . "?CA=$category_ID&UID=$UID");
}


commonHeader("$Company","Select an item");
fontFace("Arial","Select an item:<br><br>");
echo "<ul>";
/*
$category_name = mysql_query("SELECT name, description FROM nameDef WHERE category_ID = $category_ID");
$category_name = mysql_fetch_array($category_name);
$description = $category_name["description"];
$category_name = $category_name["name"];
*/
$cat_string = "SELECT category, CategoryDescription FROM category WHERE CategoryID='$category_ID'";
$category = mysql_query($cat_string) or die(mysql_error() . "in $cat_string<br>");
$category = mysql_fetch_array($category);
$category_name = $category["category"];
$description = $category["CategoryDescription"];
fontFace("Arial","<h1 align=\"center\">$category_name</H1><h3 align=\"center\">$description</h3>"); 
$string = "SELECT * FROM itemDef WHERE categoryID='$category_ID'";
//echo($string . "<BR>");
$result=mysql_query($string) or die(mysql_error() . " in $string<BR>");
while ($row  =  mysql_fetch_row($result)) {
	$SKU=$row[0];
	$categoryID = $row[1];
	$nameID = $row[2];
	$flavorID=$row[3];
	$sizeID=$row[4];
	$cost_retail=$row[5];
	$cost_wholesale=$row[6];
	$ID=$row[7];

	$flavor = mysql_query("SELECT flavor FROM flavorDef WHERE flavorID = $flavorID");
	$flavor = mysql_fetch_array($flavor) or die(mysql_error() . " in $flavor<BR>");;
	$flavor = $flavor["flavor"];

	$size = mysql_query("SELECT size FROM sizeDef WHERE sizeID = $sizeID");
	$size = mysql_fetch_array($size) or die(mysql_error() . " in $size<BR>");;
	$size = $size["size"];
	

	$name = mysql_query("SELECT name FROM nameDef WHERE nameID = $nameID");
	$name = mysql_fetch_array($name) or die(mysql_error() . " in $name<BR>");;
	$name = $name["name"];

	fontFace("Arial","<li><a href='description.php?ID=$ID&UID=$UID&nameID=$nameID'>$name</a>");
	if ($ID != "") {
		fontFace("Arial"," - $category_name - $flavor - $size oz. $$cost_retail"); 
	}
	echo "</li>";
}
echo "</ul>";

commonFooter($Relative,$UID);
?>
