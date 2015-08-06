<?
include("header.inc");
require_once("../figure_shipping.inc");
GLOBAL $giftWrap;
GLOBAL $giftWrapLabel;
$buyer_id = $_GET["BI"];
$order_number = $_GET["ON"];
mysql_connect("$DBHost","$DBUser","$DBPass");
commonHeader("$Company","Your receipt - Thank You!");

//blackFont("Arial","<b>Thank you for your order.  Please print this receipt for your records.</b><br><br>");

blackFont("Arial","<b>Order Number: </b>");
whiteFont ("Arial","$order_number<br><br>");

echo "<table border='0' cellpadding='5' cellspacing='5' width='550'><tr>";
echo "<td valign='top' align='right'>";

fontFace("Comic Sans MS,Arial","$Company<br>");
$shipping = "SELECT Shipping FROM orders WHERE OrderNumber = $order_number";
$shipping = mysql_query($shipping);
$shipping = mysql_fetch_array($shipping);
$shipping_type = $shipping["Shipping"];
whiteFont("Arial", "$Address1<BR>");
if(!empty($Address2)){
	whiteFont("Arial", "$Address2<BR>");
}
fontFace("Arial","$City $State, $Zip<br>");
if ($Phone == "" ) {
	echo "";
} 
else {
	blackFont("Arial","<b>Phone:</b>");
	whiteFont("Arial", " $Phone<BR>");
}
if ($Web == "" ) {
	echo "";
} 
else {
	blackFont("Arial","<b>World Wide Web:</b>");
	whiteFont("Arial", " $Web<BR>");
}
if ($Email == "" ) {
	echo "";
} 
else {
	blackFont("Arial","<b>E-mail:</b>");
	whiteFont("Arial", " $Email<BR>");
}
$result = "SELECT Date, giftWrap, giftWrapLabel FROM orders WHERE OrderNumber='$order_number'";
$result=mysql_query($result) or die(mysql_error() . "in $result<br>");;
while ($row=mysql_fetch_row($result)) {
	$order_date=$row[0]; 
	$giftWrap = $row[1];
	$giftWrapLabel = $row[2];
}

$pieces=explode(":",$order_date);
blackFont("Arial","<b>Order Date:</b>");
$date = $pieces[2] . "<BR>";
whiteFont("Arial", $date);
echo "</td></tr><tr><td valign='top' align='left'>";
$result = "SELECT * FROM buyers WHERE BuyerID='$buyer_id'";
//echo($result . "<BR>");
$result=mysql_query($result) or die(mysql_error() . "in $result<br>");
while ($row=mysql_fetch_row($result)) {
	$buyers_name=$row[0] . " " . $row[1];
	$buyers_address_1=$row[2];
	$buyers_address_2=$row[3];
	$buyers_city=$row[4];
	$buyers_state=$row[5];
	$buyers_zip=$row[6];
	$shipping_name=$row[7] . " " . $row[8];
	$shipping_address_1=$row[9];
	$shipping_address_2=$row[10];
	$shipping_city=$row[11];
	$shipping_state=$row[12];
	$shipping_zip=$row[13];
	$buyers_email=$row[14];
	$buyers_day_phone=$row[15];
	$buyers_eve_phone=$row[16];
	$contact_buyer=$row[17];
	$payment_method=$row[18];
	$cc_type=$row[19];
	$cc_auth_code=$row[20];
	$order_total=$row[21];
	$order_date=$row[22];
	$order_number=$row[23];
	$buyers_user_id=$row[24];
	$buyers_buyer_id=$row[25];
	//for($i = 0; $i < 19; $i++)	{echo("$i) " . $row[$i] . "<BR>");}
}
//echo("buyers_buyer_id = $buyers_buyer_id" . "<br>");
//echo("buyer_id = " . $buyer_id . "<br>");
//echo("order_number = " . $order_number . "<br>");
if(empty($shipping_name) && empty($shipping_address_1)){
		$shipping_name=$buyers_name;
		$shipping_address_1=$buyers_address_1;
		$shipping_address_2=$buyers_address_2;
		$shipping_city=$buyers_city;
		$shipping_state=$buyers_state;
		$shipping_zip=$buyers_zip;
}
echo("<TABLE BORDER=0>\n");
echo("<TR>");
echo("<TD>");
fontSize("+2","","Arial","Order For:<br>");
echo("</TD>");
echo("<TD></TD>");
echo("<TD>");
fontSize("+2","","Arial","Ship To:<br>");
echo("</TD>");
echo("</TR>");
echo("<TR>");
echo("<TD>");
fontFace("Arial","$buyers_name<br>");
echo("</TD>");
echo("<TD WIDTH=100></TD>");
echo("<TD>");
fontFace("Arial","$shipping_name<br>");
echo("</TD>");
echo("</TR>");
echo("<TR>");
echo("<TD>");
fontFace("Arial","$buyers_address_1<br>");
echo("</TD>");
echo("<TD></TD>");
echo("<TD>");
fontFace("Arial","$shipping_address_1<br>");
echo("</TD>");
echo("</TR>");
echo("<TR>");
echo("<TD>");
if (isset($buyers_address_2)) {
	fontFace("Arial"," $buyers_address_2<br>");
}
echo("</TD>");
echo("<TD WIDTH=100></TD>");
echo("<TD>");
if (isset($buyers_address_2)) {
	fontFace("Arial"," $shipping_address_2<br>");
}
echo("</TD>");
echo("</TR>");
echo("<TR>");
echo("<TD>");
fontFace("Arial"," $buyers_city $buyers_state, $buyers_zip<br>");
echo("</TD>");
echo("<TD WIDTH=100></TD>");
echo("<TD>");
fontFace("Arial"," $shipping_city $shipping_state, $shipping_zip<br>");
echo("</TD>");
echo("</TR>");
echo("<TR>");
echo("<TD>");
if ($buyers_day_phone != "") {
	fontFace("Arial","<B>Day phone:</B></TD><TD>");
	fontFace("Arial","$buyers_day_phone");
}
echo("</TD>");
echo("</TR>");
echo("<TR>");
echo("<TD>");
if ($buyers_eve_phone != "") {
	fontFace("Arial","<B>Evening phone:</B></TD><TD>");
	fontFace("Arial", "$buyers_eve_phone");
}
echo("</TD>");
echo("</TR>");
echo("<TR>");
echo("<TD>");
if ($buyers_email != "") {
	fontFace("Arial","<B>E-mail:</B></TD><TD>");
	fontFace("Arial","$buyers_email");
}
echo("</TD>");
echo("</TR>");
echo("</TABLE>\n");
whiteFont("Arial","<b>You have ordered the following items...</b><br><br>");

echo  "<table border='1' cellpadding='5' cellspacing='5' width=\"800\"><tr>";
echo  "<th>";
blackFont( "Arial", "Product Code");
echo  "</th>";
echo  "<th>";
blackFont( "Arial", "Product Name");
echo  "</th>";
echo  "<th>";
blackFont( "Arial", "Product Flavor");
echo  "</th>";
echo  "<th>";
blackFont( "Arial", "Product Size");
echo  "</th>";
echo  "<th>";
blackFont( "Arial", "Cost");
echo  "</th>";
echo  "<th>";
blackFont( "Arial", "Quantity");
echo  "</th>";
echo  "<th>";
blackFont( "Arial", "Total");
echo  "</th>";
echo  "</th></tr>";
$select = "SELECT ItemID, ItemQuantity FROM receipts WHERE BuyerID='$buyer_id' AND OrderNumber='$order_number'";
//echo($select . "<BR>");
$result=mysql_query($select) or die(mysql_error() . "in $select<br>");
$sub_total = 0;
while ($row=mysql_fetch_row($result)) {
	$item_id = $row[0];
	$item_quantity = $row[1];
	
	$item_select = "SELECT * FROM itemDef WHERE itemID = $item_id";
	$item_select = mysql_query($item_select);
	$item_row = mysql_fetch_row($item_select);
	
   	$item_sku=$item_row[0];
	$cat_ID=$item_row[1];
	$name_ID=$item_row[2];
	$flavor_ID=$item_row[3];
	$size_ID=$item_row[4];
	$item_cost=$item_row[5];
	$item_id=$item_row[6];
	
	//for($i = 0; $i < 9; $i++)	{echo("$i) " . $item_row[$i] . "<BR>");}
	$name = "SELECT name FROM nameDef WHERE nameID = $name_ID";
	$name = mysql_query($name) or die(mysql_error() . " in $name<br>");
	$name = mysql_fetch_array($name);
	$item_name = $name["name"];
					
	$flavor = "SELECT flavor FROM flavorDef WHERE flavorID = $flavor_ID";
	$flavor = mysql_query($flavor) or die(mysql_error() . " in $flavor<br>");
	$flavor = mysql_fetch_array($flavor);
	$item_flavor = $flavor["flavor"];
	
	$size = "SELECT size FROM sizeDef WHERE sizeID = $size_ID";
	$size = mysql_query($size) or die(mysql_error() . " in $size<br>");
	$size = mysql_fetch_array($size);
	$item_size = $size["size"];

	echo "<tr><td>";
	echo("<DIV align=\"right\">");
	whiteFont("Arial","$item_sku");
	echo("</DIV>");
	echo "</td><td>";
	echo("<DIV align=\"right\">");
	whiteFont("Arial","$item_name");
	echo("</DIV>");
	echo "</td><td>";
	echo("<DIV align=\"right\">");
	whiteFont("Arial","$item_flavor");
	echo("</DIV>");
	echo "</td><td>";
	echo("<DIV align=\"right\">");
	whiteFont("Arial","$item_size oz.");
	echo("</DIV>");
	echo "</td><td>";
	$item_cost = $item_cost;
	$item_cost=number_format($item_cost,"2",".","thousands_sep");
	echo("<DIV align=\"right\">");
	whiteFont("Arial","$$item_cost");
	echo("</DIV>");
	echo "</td><td>";
	echo("<DIV align=\"right\">");
	whiteFont("Arial","$item_quantity");
	echo("</DIV>");
	echo "</td><td>";
	$total_cost = $item_cost * $item_quantity;
	$total_cost=number_format($total_cost,"2",".","thousands_sep");
	echo("<DIV align=\"right\">");
	whiteFont("Arial","$$total_cost"); 
	echo("</DIV>");
	echo "</td></tr>";
	
	$sub_total=$sub_total+$total_cost;
}

$sub_total=number_format($sub_total,"2",".","thousands_sep");
$shipping_price = compute_shipping($sub_total);
echo "<tr></tr><tr><td colspan=\"5\"></td><td>";
blackFont("Arial","<b><i>Sub Total:</i></b>");
echo "</td><td>";
whiteFont("Arial","<b>$$sub_total</b>");
echo "</td></tr>";
echo "<tr><td colspan=\"5\"></td><td>";
blackFont("Arial","<b><i>Shipping:</i></b>");
echo "</td><td>";

if(isset($shipping_type))
	$shipping = compute_shipping_upgrade($shipping_price, $shipping_type);
$shipping=number_format($shipping,"2",".","thousands_sep");
whiteFont("Arial","<b>$$shipping</b>");
echo "</td></tr>";

if(strcmp($giftWrap, "TRUE") == 0){
	echo "<tr><td colspan=\"5\"></td>";
	echo("<td>");
	blackFont("Arial","<b><i>Gift Wrap:</i></b>");
	echo "</td>";
	echo("<td>");
	whiteFont("Arial","<b>$$giftWrapPrice</b>");
	echo "</td></tr>";
	//	$part3 .= stripslashes(nl2br($giftWrapLabel));
}
	
if(isset($shipping_type)){
	echo "<tr><td colspan=\"5\"></td><td>";
	blackFont("Arial","<b><i>Shipping Type</i></b>");
	echo "</td><td>";
	//$shipping = compute_shipping_upgrade($shipping, $shipping_type);
	whiteFont("Arial","<b>" . strtoupper(str_replace("_", " ", $shipping_type)) . "</b>");
	echo "</td></tr>";
}
echo "<tr><td colspan=\"5\"></td><td>";
$total = $shipping + $sub_total;	
if(strcmp($giftWrap, "TRUE") == 0){
	$total = $total + $giftWrapPrice;
}
$total=number_format($total,"2",".","thousands_sep");
blackFont("Arial","<b><i>Total:</i></b>");
echo "</td><td>";
whiteFont("Arial","<b>$$total</b>");
echo "</td></tr>";

echo "</table>";
if(strcmp($giftWrap, "TRUE") == 0){
	fontSize(4,"black","Arial","Gift Wrap Label:");
	$giftWrapLabel = stripslashes(nl2br($giftWrapLabel));
	fontSize(4,"white","Arial","<B>$giftWrapLabel</B><BR><BR>");
}
if ($payment_method == "Check") {
	blackFont("Arial","<p>You have elected to pay via ");
	whiteFont ("Arial","Check or Money Order");
	blackFont("Arial",".<br>We will ship the products you ordered upon receipt of your payment.<br>");
} 
elseif ($payment_method == "Credit") {
	blackFont("Arial","<p>You have elected to pay via ");
	whiteFont ("Arial","$cc_type");
	blackFont("Arial"," credit card.<br>We will ship the products you ordered upon credit approval.<br>");
}
else {
	blackFont ("Arial","<p>We will contact you to make payment arrangements.<br>");
}
if ($contact_buyer == '1') {
	blackFont("Arial","<p>We will contact you before fulfilling this order.<br>");
} 
else {
	echo "";
}
echo "<br><br>";
blackFont("Arial","If you have questions about this order, please contact us at:<br>");
whiteFont("Arial","<a href=\"mailto:$Email\">$Email</a><br>");
blackFont("Arial","or<br>");
blackFont("Arial","$Phone<br><br> <b>Please refer to order number</b>");
whitefont("Arial"," $order_number");
//whiteFont("Arial","<p><b>If you need access to this document again, you can point your web browser to:</b><br>");
//$Relative=ereg_replace("^/","",$Relative);
//fontSize("-1","blue","Arial","<a href=\"". $Relative . "receipt.php?buyer_id=$buyer_id&order_number=$order_number&payment_method=$payment_method&CT=$cc_type&contact_buyer=$contact_buyer\">$Web$Relative/receipt.php?buyer_id=$buyer_id&order_number=$order_number&payment_method=$payment_method&CT=$cc_type&contact_buyer=$contact_buyer</a>");
echo "<center><p><hr width=\"70%\"><p>";
whiteFont("Arial","<a href=\"./index.php\">Home</a></center></td></tr></table></html>");
?>
