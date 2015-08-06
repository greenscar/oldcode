<?
include("header.inc");
require_once("figure_shipping.inc");
$i=0;
$j=0;
mysql_connect("$DBHost","$DBUser","$DBPass");
$UID = @$_GET["UID"];
$REMOTE_ADDR =$_ENV["REMOTE_ADDR"];

if(!empty($_GET["UID"])) {
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
$select = "SELECT * FROM cartItems WHERE UserID='$UID'";
$result=mysql_query($select) or die(mysql_error() . "in $select<BR>");
$num=mysql_num_rows($result);
if ($num == "0") {
	commonHeader("$Company","View the contents of your shopping cart");
	whiteFont("Arial","Your shopping cart is empty <br><br>");
} 
else {
	commonHeader("$Company","View the contents of your shopping cart");
	whiteFont("Arial","Your shopping cart contains the following items:<br><br>");
	echo "<table border='1' cellpadding='5' cellspacing='5'><tr>";
	echo "<th>";
	blackFont("Arial","Product Code");
	echo "</th>";
	echo "<th>";
	blackFont("Arial","Product Name");
	echo "</th>";
	echo "<th>";
	blackFont("Arial","Quantity");
	echo "</th>";
	echo "<th>";
	blackFont("Arial","Cost");
	echo "</th>";
	echo "<th>";
	blackFont("Arial","Total");
	echo "</th>";
	echo "<th colspan='2'>";
	blackFont("Arial","Add/Remove Items");
	echo "</th></tr>";
	$result=mysql_query("SELECT * FROM cartItems WHERE UserID='$UID'");
	while ($row  =  mysql_fetch_row($result)) {
		$CUI=$row[0];
		$CII=$row[1];
		$CIQ=$row[2];
		$CDa=$row[3];
		$CCI=$row[4];
		$result2=mysql_query("SELECT * FROM itemDef WHERE itemID='$CII'");
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
		
			$To[$i]=($CIQ * $cost_retail);
			echo "<tr><td>";
			whiteFont("Arial","$SKU");
			echo "</td><td>";
			whiteFont("Arial","$name");
			echo "</td><td>";
			whiteFont("Arial","$CIQ");
			echo "</td><td>";
			$cost_retail=number_format($cost_retail,"2",".","thousands_sep");
			whiteFont("Arial","$$cost_retail");
			echo "</td><td>";
			$sub_total=number_format($To[$i],"2",".","thousands_sep");
			
			whiteFont("Arial","<b>$$sub_total</b>");
			echo "<td valign=\"center\"><center>";
			echo "<FORM ACTION=\"add_item.php\" METHOD=\"POST\">";
			echo "<input type=\"hidden\" name=\"cartItemsID\" value=\"$CCI\">";
			echo "<input type=\"hidden\" name=\"ItemName\" value=\"$name\">";
			echo "<input type=\"hidden\" name=\"UID\" value=\"$UID\">";
			echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Add\">";
			echo "</center></td>";
			echo "</form>";
			echo "<td><center>";
			echo "<FORM ACTION=\"remove_item.php\" METHOD=\"POST\">";
			echo "<input type=\"hidden\" name=\"cartItemsID\" value=\"$CCI\">";
			echo "<input type=\"hidden\" name=\"UID\" value=\"$UID\">";
			echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Remove\">";
			echo "</center></td></tr>";
			echo "</form>";
			$i++;
        }
	}
	while ($j < $i) {
		$total=@$total+$To[$j];
		$j++;
	}
	$sub_total=number_format($total,"2",".","thousands_sep");
	$shipping = compute_shipping($sub_total);
	echo "<tr><td></td><td></td>\n";
	echo "<td colspan='2'>\n";
	blackFont("Arial","<center><b><i>Sub Total: </i></b></center>\n");
	echo "<td>\n";
	whiteFont("Arial","<b><center> $$sub_total </center></b>\n"); 
	echo "<tr><td></td><td></td>\n";
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
	
	echo "<tr><td></td><td></td>\n";
	echo "<td colspan='2'>\n";
	blackFont("Arial","<center><b><i>Total: </i></b></center>\n");
	echo "<td>\n";
	whiteFont("Arial","<b><center> $$total </center></b>\n"); 
	
	echo "<td colspan=\"2\"><center>";
	echo "<FORM ACTION=\"empty_cart.php\" METHOD=\"POST\">";
	echo "<input type=\"hidden\" NAME=\"UID\" value=\"$UID\">";
	echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Empty This Cart\">";
	echo "</center></td></tr></table>";
	echo "</form>";
	echo "<p>";
	fontSize("+1","white","Arial","<b>Are you sure that you want to check out?</b><p>");
	//echo "<form action=\"user_info.php\" method=\"post\" target=\"_parent\">
	echo "<form action=\"$WebSecure/user_info.php\" method=\"post\" target=\"_parent\">
	<input type=\"hidden\" name=\"UID\" value=\"$UID\">
	<input type=\"hidden\" name=\"OrderTotal\" value=\"$total\">
	<input type=\"submit\" value=\"YES\"></form>
	<form action=\"view_cart.php\" method=\"post\">
	<input type=\"hidden\" name=\"UID\" value=\"$UID\">
	<input type=\"submit\" value=\"NO\"></form>";
}
commonFooter($UID);
?>
