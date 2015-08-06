<?
include("header.inc");
require_once("figure_shipping.inc");
$i=0;
$j=0;
mysql_connect("$DBHost","$DBUser","$DBPass");

if(!empty($_GET["UID"])) $UID = @$_GET["UID"];
else if(!empty($_POST["UID"])) $UID = @$_POST["UID"];
$REMOTE_ADDR =$_ENV["REMOTE_ADDR"];

if (!empty($_GET["UID"])) {
	$UID = $_GET["UID"];
	//echo("SELECT * FROM Users WHERE User=$UID");
	@$result = mysql_query("SELECT * FROM Users WHERE User='$UID'");
	$num = @mysql_num_rows($result);
	if ($num == "0") {
		$dt=date("YmdHis");
		$UID="$dt$REMOTE_ADDR";
		$date=date("z");
		mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
		Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID&categoryID=1");
	}
}
if (empty($UID)) {
	$dt=date("YmdHis");
	$UID="$dt$REMOTE_ADDR";
	$date=date("z");
	mysql_query("INSERT INTO users VALUES ('$UID','$date')");
	Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID");
}
$query = "SELECT * FROM cartItems WHERE UserID='$UID'";
$result=mysql_query($query) or die(mysql_error() . "in $query<BR>");;
$num=mysql_num_rows($result);
if ($num == "0") {
	commonHeader("$Company","View the contents of your shopping cart");
	echo("<H1>Your shopping cart is empty</H1>\n");
} 
else {
	commonHeader("$Company","View the contents of your shopping cart");
	echo("<H2>Your shopping cart contains the following items:</H2>\n");
	echo "<table border='1' cellpadding='5' cellspacing='5' align=\"left\">\n<tr>\n";
	echo("\t\n<th>\t");
	echo("Product Code");
	echo("\n</th>\n");
	echo("\t\n<th>\t");
	echo("Product Name");
	echo("</th>\n");
	echo("\t\n<th>\t");
	echo("Flavor");
	echo("</th>\n");
	echo("\t\n<th>\t");
	echo("Size");
	echo("</th>\n");
	echo("\t\n<th>\t");
	echo("Quantity");
	echo("</th>\n");
	echo("\t\n<th>\t");
	echo("Cost");
	echo("</th>\n");
	echo("\t\n<th>\t");
	echo("Total");
	echo("</th>\n");
	echo "<th colspan='2'>\n";
	echo("Add/Remove Items");
	echo "</th></tr>\n";
	$q = "SELECT * FROM cartItems WHERE UserID='$UID'";
	$result=mysql_query($q) or die(mysql_error() . "in $q <BR>");
	while ($row  =  mysql_fetch_row($result)) {
		$UserID=$row[0];
		$ItemID=$row[1];
		$ItemQuantity=$row[2];
		$date=$row[3];
		$cartItemsID=$row[4];
		$q = "SELECT * FROM itemDef WHERE itemID='$ItemID'";
		$result2=mysql_query($q) or die(mysql_error() . "in $q <BR>");
		while ($row2=mysql_fetch_row($result2)) {
			//echo("inside while<br>");
			$SKU=$row2[0];
			$categoryID = $row2[1];
			$nameID = $row2[2];
			$flavorID=$row2[3];
			$sizeID=$row2[4];
			$cost_retail=$row2[5];
			$itemID=$row2[6];
			
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
			$size_rounded = round($size);
			if($size == $size_rounded) $size = $size_rounded;
			//fontFace("Arial","<li><a href='description.php?ID=$cartItemsID&UID=$UID");
			$To[$i]=(($ItemQuantity * $cost_retail));
			echo "<tr>\n\t<td>\n\t\t";
			echo("<P>$SKU</P>");
			echo "\n\t</td>\n\t<td>\n\t\t";
			echo("<P>$name</P>");
			echo "\n\t</td>\n\t<td>\n\t\t";
			echo("<P>$flavor</P>");
			echo "\n\t</td>\n\t<td>\n\t\t";
			echo("<P>$size oz.</P>");
			echo "\n\t</td>\n\t<td>\n\t\t";
			echo("<P>$ItemQuantity</P>");
			echo "\n\t</td>\n\t<td>\n\t\t";
			$cost_retail=number_format($cost_retail,"2",".","thousands_sep");
			echo("<P>$$cost_retail</P>");
			echo "\n\t</td>\n\t<td>\n\t\t";
			$Tot=number_format($To[$i],"2",".","thousands_sep");
			echo("<P>$$Tot</P>");
			echo "<td valign=\"center\"><center>\n";
			echo "<FORM ACTION=\"add_item.php\" METHOD=\"POST\">\n";
			echo "<input type=\"hidden\" name=\"lastItemViewedID\" value=\"" . $_GET["nameID"] . "\">\n";
			echo "<input type=\"hidden\" name=\"cartItemsID\" value=\"$cartItemsID\">\n";
			echo "<input type=\"hidden\" name=\"ItemName\" value=\"$name\">\n";
			echo "<input type=\"hidden\" name=\"UID\" value=\"$UID\">\n";
			echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Add\">\n";
			echo "</center></td>\n";
			echo "</form>\n";
			echo "<td><center>\n";
			echo "<FORM ACTION=\"remove_item.php\" METHOD=\"POST\">\n";
			echo "<input type=\"hidden\" name=\"lastItemViewedID\" value=\"" . $_GET["nameID"] . "\">\n";
			echo "<input type=\"hidden\" name=\"cartItemsID\" value=\"$cartItemsID\">\n";
			echo "<input type=\"hidden\" name=\"UID\" value=\"$UID\">\n";
			echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Remove\">\n";
			echo "</center></td></tr>\n";
			echo "</form>\n";
			$i++;
		}
	}
if(empty($sub_total)){
	$sub_total = 0;
}
while ($j < $i) {
	$sub_total=$sub_total+$To[$j];
	$j++;
}

$sub_total=number_format($sub_total,"2",".","thousands_sep");
$shipping = compute_shipping($sub_total);

echo "<tr><td></td><td></td><td></td><td></td>\n";
echo "<td colspan='2'>\n";
blackFont("Arial","<center><b><i>Sub Total: </i></b></center>\n");
echo "<td>\n";
whiteFont("Arial","<b><center> $$sub_total </center></b>\n"); 
echo "<tr><td></td><td></td><td></td><td></td>\n";
echo "<td colspan='2'>\n";
blackFont("Arial","<center><b><i>Shipping: </i></b></center>\n");
echo "<td>\n";
if ($shipping == "0.00") {
	$ES="1";
	whiteFont("Arial","<b><center> FREE! </center></b>\n"); 
} 
else{
	whiteFont("Arial","<b><center> $$shipping </center></b>\n"); 
}

$total = $shipping + $sub_total;
$total=number_format($total,"2",".","thousands_sep");

echo "<tr><td></td><td></td><td></td><td></td>\n";
echo "<td colspan='2'>\n";
blackFont("Arial","<center><b><i>Total: </i></b></center>\n");
echo "<td>\n";
whiteFont("Arial","<b><center> $$total </center></b>\n"); 


echo "<td colspan=\"2\"><center>\n";
/*
echo "<FORM ACTION=\"empty_cart.php\" METHOD=\"POST\">\n";
echo "<input type=\"hidden\" NAME=\"UID\" value=\"$UID\">\n";
echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Empty This Cart\">\n";
echo "</form>\n";
*/
echo "</center></td></tr>\n";
echo "<br><br><BR><P>\n";
}
commonFooter($UID);
?>
