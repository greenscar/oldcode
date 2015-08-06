<?
include("header.inc");
require_once("figure_shipping.inc");
mysql_connect("$DBHost","$DBUser","$DBPass");
$missing_something = false;
$UID = $_POST["UserID"];
$total = $_POST["OrderTotal"];
$order_number = 0;
$buyer_id = 0;
echo "<FORM ACTION=\"user_info.php\" METHOD=\"POST\">\n";
echo("<input type=\"hidden\" name=\"UID\" value=\"$UID\">");
echo("<input type=\"hidden\" name=\"OrderTotal\" value=\"$total\">");
if ($_POST["Name"] == "") {
	fontSize("+1","black","Arial","<b>You forgot to tell me your NAME. Please go back and complete the order form.<BR>");
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"Name\" value=\"" . $_POST["Name"] . "\">\n";
}

if ($_POST["BuyAddress1"] == "") {
	fontSize("+1","black","Arial","<b>You forgot to tell me your ADDRESS. Please go back and complete the order form.<BR>");
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"BuyAddress1\" value=\"" . $_POST["BuyAddress1"] . "\">\n";
	echo "<input type=\"hidden\" name=\"BuyAddress2\" value=\"" . @$_POST["BuyAddress2"] . "\">\n";
}

if (!isset($_POST["PayMethod"])) {
	fontSize("+1","black","Arial","<b>You forgot to tell me your Pay Method. Please go back and complete the order form.<BR>");
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"PayMethod\" value=\"" . $_POST["PayMethod"] . "\">\n";
}
if($_POST["BuyCity"] == ""){
	fontSize("+1","black","Arial","<b>You forgot to tell me your city. Please go back and complete the order form.<BR>");	
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"BuyCity\" value=\"" . $_POST["BuyCity"] . "\">\n";
}
echo "<input type=\"hidden\" name=\"BuyState\" value=\"" . $_POST["BuyState"] . "\">\n";
if($_POST["BuyZip"] == ""){
	fontSize("+1","black","Arial","<b>You forgot to tell me your zip code. Please go back and complete the order form.<BR>");	
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"BuyZip\" value=\"" . $_POST["BuyZip"] . "\">\n";
}


if ($_POST["BuyEmail"] == "") {
	fontSize("+1","black","Arial","<b>You forgot to tell me your E-MAIL ADDRESS. Please go back and complete the order form.<BR>");
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"BuyEmail\" value=\"" . $_POST["BuyEmail"] . "\">\n";
}

if ($_POST["DayPhone"] == "" AND $_POST["EvePhone"] == "") {
	fontSize("+1","black","Arial","<b>You forgot to tell me your PHONE NUMBER. Please go back and complete the order form.<BR>");
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"DayPhone\" value=\"" . $_POST["DayPhone"] . "\">\n";
	echo "<input type=\"hidden\" name=\"EvePhone\" value=\"" . $_POST["EvePhone"] . "\">\n";
}

if(@$_POST["PayMethod"] != ""){
	echo "<input type=\"hidden\" name=\"PayMethod\" value=\"" . $_POST["PayMethod"] . "\">\n";
}
if (@$_POST["PayMethod"] == "Credit" AND @$_POST["CCType"] == "") {
	fontSize("+1","black","Arial","<b>You forgot to tell me your CREDIT CARD TYPE. Please go back and complete the order form.<BR>");
	$missing_something = true;
}
else{
	echo "<input type=\"hidden\" name=\"CCType\" value=\"" . $_POST["CCType"] . "\">\n";
}
if (@$_POST["PayMethod"] == "Credit" AND @$_POST["CCNum"] == "") {
	fontSize("+1","black","Arial","<b>You forgot to tell me your CREDIT CARD NUMBER. Please go back and complete the order form.<BR>");
	$missing_something = true;
}

if (@$_POST["PayMethod"] == "Credit" AND @$_POST["CCExpire"] == "") {
	fontSize("+1","black","Arial","<b>You forgot to tell me your CREDIT CARD EXPIRATION DATE. Please go back and complete the order form.<BR>");
	$missing_something = true;
}
if(@$_POST["PayMethod"] =="Credit" AND $_POST["CCNum"] != "" AND $_POST["CCExpire"] != ""){	
	if(!validate_cc($_POST["CCNum"], $_POST["CCType"])){
		fontSize("+1","black","Arial","<b>Your credit card number/type was not valid. Please try again.<BR>");	
		$missing_something = true;
	}
}


if($missing_something){
	echo "<input type=\"SUBMIT\" NAME=\"Return to form\" value=\"Return\">\n";
	echo "</FORM>\n";
}
else{
	$total = $_POST["OrderTotal"];
	$shipping_type = $_POST["shipping_type"];
	$total = compute_shipping_upgrade($total, $shipping_type);
	echo "</FORM>\n";
	$insert_buyer = "INSERT INTO buyers VALUES ('$_POST[Name]', '$_POST[BuyAddress1]', '$_POST[BuyAddress2]', " .
		"'$_POST[BuyCity]', '$_POST[BuyState]', '$_POST[BuyZip]', '$_POST[shipName]', '$_POST[shipBuyAddress1]', '$_POST[shipBuyAddress2]', " .
		"'$_POST[shipBuyCity]', '$_POST[shipBuyState]', '$_POST[shipBuyZip]', '$_POST[BuyEmail]', '$_POST[DayPhone]', '$_POST[EvePhone]', " .
		"'" . @$_POST["Contact"] . "', '$_POST[PayMethod]', '$_POST[CCType]', '$_POST[CCNum]', '$_POST[CCExpire]', '$total', " .
		"'$_POST[Date]', '0', '$_POST[UserID]', '$_POST[BuyerID]')";
	mysql_query($insert_buyer) or die(mysql_error() . "in <br>$insert_buyer<br>");
	$UserID = $_POST["UserID"];
	$Date = $_POST["Date"];
	$Name = $_POST["Name"];
	$buyer_id = $_POST["BuyerID"];
	$OrderTotal = $_POST["OrderTotal"];
	$shipping_type = $_POST["shipping_type"];
	$giftWrap = $_POST["giftWrap"];
	if(strcmp($giftWrap, "TRUE") == 0){
		$giftWrapLabel = $_POST["giftWrapLabel"];
		$OrderTotal = $OrderTotal + $giftWrapPrice;
	}
	else{
		$giftWrap = "FALSE";
		$giftWrapLabel = "DO NOT GIFTWRAP";
	}
	$query = "SELECT BuyerID FROM buyers WHERE UserID='$UserID' AND Date='$Date' AND Name='$Name'";
	$result = mysql_query($query) or die(mysql_error() . "in $query<br>");
	while ($row=mysql_fetch_row($result)) {
		$buyer_id=$row[0];
	}
	
	$OrderTotal += shipping_upgrade_price($shipping_type);
	$insert_order = "INSERT INTO orders VALUES ('$buyer_id','$UserID','$Date', '$shipping_type', '$giftWrap', '$giftWrapLabel', '$OrderTotal','')";
	mysql_query($insert_order) or  die(mysql_error() . "in <br>$insert_order<br>");;
	$query = "SELECT OrderNumber FROM orders WHERE UserID='$UserID' AND Date='$Date' AND BuyerID='$buyer_id'";
	$result=mysql_query($query) or die(mysql_error() . "in <br>$query<br>");
	while ($row=mysql_fetch_row($result)) {
		$order_number=$row[0];
	}
	mysql_query("UPDATE buyers SET OrderNumber='$order_number' WHERE BuyerID='$buyer_id'");
	$search = "SELECT * FROM cartItems WHERE UserID='$UserID'";
	$result=mysql_query($search) or die(mysql_error() . "in $search<BR>");
	while ($row  =  mysql_fetch_row($result)) {
		$cart_user_id=$row[0];
		$cart_item_id=$row[1];
		$cart_item_quantity=$row[2];
		$cart_date=$row[3];
		$cart_id=$row[4];
		$search2 = "SELECT * FROM itemDef WHERE itemID='$cart_item_id'";
		$result2=mysql_query($search2) or die(mysql_error() . "in $search2<BR>");
		$i = 0;
	    while ($row2=mysql_fetch_row($result2)) {
	    	$item_SKU=$row2[0];
			$cat_ID=$row2[1];
			$name_ID=$row2[2];
			$flavor_ID=$row2[3];
			$size_ID=$row2[4];
			$cost_retail=$row2[5];
			$item_id=$row2[6];

			$name = mysql_query("SELECT name FROM nameDef WHERE nameID = $name_ID") or die(mysql_error() . "<br>");
			$name = mysql_fetch_array($name);
			$item_name = $name["name"];
						
			$flavor = mysql_query("SELECT flavor FROM flavorDef WHERE flavorID = $flavor_ID") or die(mysql_error() . "<br>");
			$flavor = mysql_fetch_array($flavor);
			$item_flavor = $flavor["flavor"];

			$size = mysql_query("SELECT size FROM sizeDef WHERE sizeID = $size_ID") or die(mysql_error() . "<br>");
			$size = mysql_fetch_array($size);
			$item_size = $size["size"];
			
			$insert = "INSERT INTO receipts VALUES ('$buyer_id','$UserID','$order_number','$Date','$item_id','$cart_item_quantity')";
			//echo($insert);
			mysql_query($insert) or die(mysql_error() . "in $insert<BR>");
			$i++;
		}
	}
	
	mysql_query("DELETE FROM cartItems WHERE UserID='$UserID'") or die(mysql_error() . " in DELETE<BR>");
	mysql_query("DELETE FROM users WHERE User='$UserID'") or die(mysql_error() . " in DELETE<BR>");
	
	$result=mysql_query( "SELECT * FROM buyers WHERE BuyerID='$buyer_id'") or die(mysql_error() . " in 174");
	while ($row=mysql_fetch_row($result)) {
		$buyers_name=$row[0];
		$buyers_address_1=$row[1];
		$buyers_address_2=$row[2];
		$buyers_city=$row[3];
		$buyers_state=$row[4];
		$buyers_zip=$row[5];
		$shipping_name=$row[6];
		$shipping_address_1=$row[7];
		$shipping_address_2=$row[8];
		$shipping_city=$row[9];
		$shipping_state=$row[10];
		$shipping_zip=$row[11];
		$buyers_email=$row[12];
		$buyers_day_phone=$row[13];
		$buyers_eve_phone=$row[14];
		$contact_buyer=$row[15];
		$payment_method=$row[16];
		$cc_type=$row[17];
		$cc_num=$row[18];
		$cc_expiration=$row[19];
		$order_total=$row[20];
		$order_date=$row[21];
		$order_number=$row[22];
		$buyers_user_id=$row[23];
		$buyers_buyer_id=$row[24];
	}
	if (@$_POST["Contact"] == "1") {
		$contact_buyer="Yes";
	} 
	else {
		$contact_buyer="No"; 
	}	
	
	$pieces=explode(":",$order_date);
	$part1 = "<HTML><HEAD><TITLE>Order Number $order_number</TITLE></HEAD><BODY>";
	$part1 .= "<B>Order Number:</B> $order_number<BR>";
	$part1 .= "<B>Buyer:</B> $buyers_name<BR>";
	$part1 .="<B>Address:</B> $buyers_address_1<BR>";
	$part1 .="\t\t$buyers_address_2<BR>";
	$part1 .="\t\t$buyers_city, $buyers_state $buyers_zip\n<BR>";
	$part1 .="<B><U>SHIP TO</U></B><BR>";
	$part1 .= "<B>Buyer:</B> $shipping_name<BR>";
	$part1 .="<B>Address:</B> $shipping_address_1<BR>";
	$part1 .="\t\t$shipping_address_2<BR>";
	$part1 .="\t\t$shipping_city, $shipping_state $shipping_zip\n<BR>";
	$part1 .="<B>EMAIL:</B> $buyers_email<BR>";
	$part1 .="<B>Daytime Phone:</B> $buyers_day_phone<BR>";
	$part1 .="<B>Evening Phone:</B> $buyers_eve_phone<BR>";
	$part1 .="<B>Contact Before Placing Order?</B> $contact_buyer<BR>";
	$part1 .="<B>Payment Method:</B> $payment_method<BR>";
	$part1 .="<B>Date:</B> $pieces[2]<BR>";
	$part2 = "<TABLE BORDER=1>";
	$part2 .= "<TR><TH>SKU</TH><TH>Item</TH><TH>Flavor</TH><TH>Size</TH><TH>Cost</TH><TH>Quantity</TH><TH>Total</TH><TR>";
	$total = 0;
	$select = "SELECT * FROM receipts WHERE BuyerID='$buyer_id' AND OrderNumber='$order_number'";
	$result=mysql_query($select) or die(mysql_error() . " in $select<BR>");;
	while ($row=mysql_fetch_row($result)) {
		$receipt_buyer_id=$row[0];
		$receipt_user_id=$row[1];
		$receipt_order_number=$row[2];
		$receipt_date=$row[3];
		$receipt_item_id=$row[4];
		$receipt_item_quantity=$row[5];
		
		$get_item = "SELECT * FROM itemDef WHERE itemID = $receipt_item_id";
		$result2 = mysql_query($get_item) or die(mysql_error() . " in $get_item");;
		$item = mysql_fetch_array($result2);
		
		$item_sku=$item[0];
		$cat_ID=$item[1];
		$name_ID=$item[2];
		$flavor_ID=$item[3];
		$size_ID=$item[4];
		$item_cost=$item[5];
		$item_id=$item[6];
		
		$total=$receipt_item_quantity * $item_cost;
		$total_cost = number_format($total, 2);
		@$sub_total += $total;
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
		$part2 .= "<TR><TD>$item_sku</TD><TD>$item_name</TD><TD>$item_flavor</TD><TD>$item_size oz.</TD><TD>$$item_cost</TD><TD>$receipt_item_quantity</TD><TD>$$total_cost</TD><TR>";
		//$part2 .="SKU: $item_sku\n<BR>Item Name: $item_name\n<BR>Item Flavor: $item_flavor\n<BR>Item Size: $item_size\n<BR>Cost: $$item_cost\n<BR>Quantity: $receipt_item_quantity\n<BR>Total Cost: $$total_cost\n\n<BR>";
	}
	$part2 .="</TABLE>";
	$sub_total = number_format($sub_total, 2);
	$part3="SUB TOTAL: $$sub_total <BR>\n\n";
	if(strcmp($giftWrap, "TRUE") == 0){
		$part3 .= "GIFTWRAP: $$giftWrapPrice <BR>\n\n";
		$part3 .= "GIFTWRAP CARD: " . stripslashes(nl2br($giftWrapLabel) . "<br>\n\n");
	}
	$sub_total=number_format($sub_total,"2",".","thousands_sep");
	$part3.="SHIPPING: ";
	$shipping = compute_shipping($sub_total);
	if(isset($shipping_type))
		$shipping = compute_shipping_upgrade($shipping, $shipping_type);
	$shipping=number_format($shipping,"2",".","thousands_sep");

	if($shipping == 0) $part3.="FREE!\n\n<BR>";
	else $part3.= "$$shipping\n\n<BR>";
	if(strcmp($giftWrap, "TRUE") == 0){
		$total = $sub_total + $shipping + $giftWrapPrice;
	}
	else{
		$total = $sub_total + $shipping;
	}
	$total=number_format($total,"2",".","thousands_sep");
	$part3.="TOTAL: $$total\n\n<BR>";
	
	$part3.= "SHIPPING TYPE: " .  strtoupper(str_replace("_", " ", $shipping_type));
	
	$headers  = "MIME-Version: 1.0\r\n";
	$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
	$headers .= "From: $Email\r\nReply-To: $Email\r\nX-Mailer: PHP/" . phpversion() . "\r\n";
	$headers .= "Cc: $Email\r\n";
    $headers .= "Bcc: laptop@caffeinewebdesign.com\r\n";
	
	$footer="<BR>This order was automatically generated from Treat-me.biz.\n\n";
	mail("$buyers_email", "Treat-Me.Biz Order #$order_number", "$part1$part2$part3$footer", $headers);
	//mail("$Email", "Treat-Me.Biz Order #$order_number", "$part1$part2$part3$footer", $headers);
	/*
	$headers = "From: $Email\r\nReply-To: $Email\r\n";
	$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
	$headers .= "X-Mailer: PHP/" . phpversion() . "\r\n";
	$headers .= "Cc: ".$Email;
	mail("$buyers_email", "Your Treat-me.biz Order", "$part1$part2$part3$footer" , "$headers");
	*/
	include("receipt.php");
}
function validate_cc($Num, $Name = 'n/a') {
	//  Innocent until proven guilty
    $GoodCard = true;

	//  Get rid of any non-digits
    $Num = ereg_replace("[^[:digit:]]", "", $Num);

	//  Perform card-specific checks, if applicable
    switch ($Name) {
	    case "Mastercard" :
      		$GoodCard = ereg("^5[1-5].{14}$", $Num);
      		break;
    	case "Visa" :
      		$GoodCard = ereg("^4.{15}$|^4.{12}$", $Num);
      		break;
    	case "amx" :
      		$GoodCard = ereg("^3[47].{13}$", $Num);
      		break;
		case "dsc" :
      		$GoodCard = ereg("^6011.{12}$", $Num);
      		break;
    }

	//  The Luhn formula works right to left, so reverse the number.
    $Num = strrev($Num);

    $Total = 0;
    for ($x=0; $x<strlen($Num); $x++) {
    	$digit = substr($Num,$x,1);
		//    If it's an odd digit, double it
      	if ($x/2 != floor($x/2)) {
        	$digit *= 2;
			//    If the result is two digits, add them
        	if (strlen($digit) == 2) 
          		$digit = substr($digit,0,1) + substr($digit,1,1);
     	}

		//    Add the current digit, doubled and added if applicable, to the Total
      	$Total += $digit;
	}

	//  If it passed (or bypassed) the card-specific check and the Total is
	//  evenly divisible by 10, it's cool!
    if ($GoodCard && $Total % 10 == 0) return true; else return false;
}
?>
