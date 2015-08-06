<?php
include("header.inc");
mysql_connect("$DBHost","$DBUser","$DBPass");

if(!empty($_GET["UID"])) $UID = @$_GET["UID"];
else if(!empty($_POST["UID"])) $UID = @$_POST["UID"];
$REMOTE_ADDR =$_ENV["REMOTE_ADDR"];

if (!empty($UID)) {
	$result=mysql_query("SELECT * FROM Users WHERE User='$UID'");
	$num=mysql_num_rows($result);
	if ($num == "0") {
		$dt=date("YmdHis");
		$UID="$dt$REMOTE_ADDR";
		$date=date("z");
		mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
		Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID");
	}
}

if (empty($UID)) {
	$dt=date("YmdHis");
	$UID="$dt$REMOTE_ADDR";
	$date=date("z");
	mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
	Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID");
}

$result=mysql_query("SELECT * FROM CartItems WHERE UserID='$UID'");
$num=mysql_num_rows($result);
if ($num == "0") {
	commonHeader("$Company","View the contents of your shopping cart");
	blueFont("Arial","Your shopping cart is empty <br><br>\n");
} 
else {
	commonHeader("$Company","View the contents of your shopping cart");
	blueFont("Arial","Your shopping cart contains the following items:<br><br>\n");
	echo "<table border='1' cellpadding='5' cellspacing='5'>\n<tr>\n";
	echo "\t\n<th>\t";
	redFont("Arial","Product Code");
	echo "\n</th>\n";
	echo "\t\n<th>\t";
	redFont("Arial","Product Name");
	echo "</th>\n";
	echo "\t\n<th>\t";
	redFont("Arial","Quantity");
	echo "</th>\n";
	echo "\t\n<th>\t";
	redFont("Arial","Cost");
	echo "</th>\n";
	echo "\t\n<th>\t";
	redFont("Arial","Total");
	echo "</th>\n";
	echo "<th colspan='2'>\n";
	redFont("Arial","Add/Remove Items");
	echo "</th></tr>\n";
	$result=mysql_query("SELECT * FROM CartItems WHERE UserID='$UID'");
	while ($row  =  mysql_fetch_row($result)) {
		$UserID=$row[0];
		$ItemID=$row[1];
		$ItemQuantity=$row[2];
		$date=$row[3];
		$cartItemsID=$row[4];
		$result2=mysql_query("SELECT * FROM itemDef WHERE ID='$ItemID'");
		while ($row2=mysql_fetch_row($result2)) {
			//echo("inside while<br>");
			$SKU=$row2[0];
			$categoryID = $row2[1];
			$nameID = $row2[2];
			$flavorID=$row2[3];
			$sizeID=$row2[4];
			$cost_retail=$row2[5];
			$cost_wholesale=$row2[6];
			$itemID=$row2[7];
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
		
			//fontFace("Arial","<li><a href='description.php?ID=$cartItemsID&UID=$UID");
			$To[$i]=(($ItemQuantity * $cost_retail));
			echo "<tr>\n\t<td>\n\t\t";
			blueFont("Arial","$SKU");
			echo "\n\t</td>\n\t<td>\n\t\t";
			blueFont("Arial","$name");
			echo "\n\t</td>\n\t<td>\n\t\t";
			blueFont("Arial","$ItemQuantity");
			echo "\n\t</td>\n\t<td>\n\t\t";
			$cost_retail=number_format($cost_retail,"2",".","thousands_sep");
			blueFont("Arial","$$cost_retail");
			echo "\n\t</td>\n\t<td>\n\t\t";
			$Tot=number_format($To[$i],"2",".","thousands_sep");
			blueFont("Arial","<b>$$Tot</b>\n");
			echo "<td valign=\"center\"><center>\n";
			echo "<FORM ACTION=\"add_item.php\" METHOD=\"POST\">\n";
			echo "<input type=\"hidden\" name=\"cartItemsID\" value=\"$cartItemsID\">\n";
			echo "<input type=\"hidden\" name=\"ItemName\" value=\"$name\">\n";
			echo "<input type=\"hidden\" name=\"UID\" value=\"$UID\">\n";
			echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Add\">\n";
			echo "</center></td>\n";
			echo "</form>\n";
			echo "<td><center>\n";
			echo "<FORM ACTION=\"remove_item.php\" METHOD=\"POST\">\n";
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
	$shipping = 0;
	if($sub_total <= 49.99){
		$shipping = 4.95;
	}
	else if($sub_total <= 99.99){
		$shipping = 5.95;
	}
	$shipping=number_format($shipping,"2",".","thousands_sep");
	
	echo "<tr><td></td><td></td>\n";
	echo "<td colspan='2'>\n";
	redFont("Arial","<center><b><i>Sub Total: </i></b></center>\n");
	echo "<td>\n";
	blueFont("Arial","<b><center> $$sub_total </center></b>\n"); 
	echo "<tr><td></td><td></td>\n";
	echo "<td colspan='2'>\n";
	redFont("Arial","<center><b><i>Shipping: </i></b></center>\n");
	echo "<td>\n";
	if ($shipping == "0.00") {
		$ES="1";
		blueFont("Arial","<b><center> FREE! </center></b>\n"); 
	} 
	else{
		blueFont("Arial","<b><center> $$shipping </center></b>\n"); 
	}
	
	$total = $shipping + $sub_total;
	$total=number_format($total,"2",".","thousands_sep");
	
	echo "<tr><td></td><td></td>\n";
	echo "<td colspan='2'>\n";
	redFont("Arial","<center><b><i>Total: </i></b></center>\n");
	echo "<td>\n";
	blueFont("Arial","<b><center> $$total </center></b>\n"); 
	
?>