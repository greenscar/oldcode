<?
/*************************************************
 * process_order.php
 * Processes user information entered on user_info.php
 * If 
 *************************************************/

//phpinfo();
//exit();
if(($_POST["x_response_code"] == 2) || ($_POST["x_response_code"] == 3)
{
	echo("Your credit card information has an error.<br>");
	echo("Please hit your back arrow and try again.");
}
include("header.inc");
require_once("figure_shipping.inc");
mysql_connect("$DBHost","$DBUser","$DBPass");
$missing_something = false;
$UID = $_POST["x_cust_id"];
$total = $_POST["x_amount"];
$order_number = 0;
$buyer_id = 0;

echo "<FORM ACTION=\"user_info.php\" METHOD=\"POST\">\n";
if((@$_POST["x_ship_to_first_name"] == "") && (@$_POST["x_ship_to_last_name"] == "") && (@$_POST["shipBuyAddress1"] == ""))
{
	$_POST["x_ship_to_first_name"] = $_POST[x_first_name];
	$_POST["x_ship_to_last_name"] = $_POST[x_last_name];
	$_POST["shipBuyAddress1"] = $_POST[BuyAddress1];
	$_POST["shipBuyAddress2"] = $_POST[BuyAddress2];
	$_POST["x_ship_to_city"] = $_POST[x_city];
	$_POST["x_ship_to_state"] = $_POST[x_state];
	$_POST["x_ship_to_zip"] = $_POST[x_zip];
}
if(@$_POST["shipBuyAddress1"] == "")
{
	$_POST["shipBuyAddress1"] = $_POST[BuyAddress1];
	$_POST["shipBuyAddress2"] = $_POST[BuyAddress2];
	$_POST["x_ship_to_city"] = $_POST[x_city];
	$_POST["x_ship_to_state"] = $_POST[x_state];
	$_POST["x_ship_to_zip"] = $_POST[x_zip];
}
$total = $_POST["x_amount"];
$shipping_type = $_POST["shipping_type"];
$total = compute_shipping_upgrade($total, $shipping_type);
echo "</FORM>\n";
$insert_buyer = "INSERT INTO buyers VALUES ('$_POST[x_first_name]', '$_POST[x_last_name]', '$_POST[BuyAddress1]', '$_POST[BuyAddress2]', " .
	"'$_POST[x_city]', '$_POST[x_state]', '$_POST[x_zip]', '$_POST[x_ship_to_first_name]', '$_POST[x_ship_to_last_name]', '$_POST[shipBuyAddress1]', '$_POST[shipBuyAddress2]', " .
	"'$_POST[x_ship_to_city]', '$_POST[x_ship_to_state]', '$_POST[x_ship_to_zip]', '$_POST[x_email]', '$_POST[x_phone]', '$_POST[eve_phone]', " .
	"'" . @$_POST["Contact"] . "', '$_POST[PayMethod]', '$_POST[CCType]', '$_POST[x_auth_code]', '$total', " .
	"'$_POST[Date]', '0', '$_POST[x_cust_id]', '$_POST[BuyerID]')";
//echo($insert_buyer . "<BR>");
mysql_query($insert_buyer) or die(mysql_error() . "in <br>$insert_buyer<br>");
$x_cust_id = $_POST["x_cust_id"];
$Date = $_POST["Date"];
$Name = $_POST["x_first_name"] . " " . $_POST["x_last_name"];
$buyer_id = $_POST["BuyerID"];
$x_amount = $_POST["x_amount"];
$shipping_type = $_POST["shipping_type"];
$giftWrap = $_POST["giftWrap"];
if(strcmp($giftWrap, "TRUE") == 0){
	$giftWrapLabel = $_POST["giftWrapLabel"];
	$x_amount = $x_amount + $giftWrapPrice;
}
else{
	$giftWrap = "FALSE";
	$giftWrapLabel = "DO NOT GIFTWRAP";
}
$query = "SELECT BuyerID FROM buyers WHERE UserID='$x_cust_id' AND Date='$Date' AND nameFirst='$_POST[x_first_name]' AND nameLast='$_POST[x_last_name]'";
//echo($query . "<BR>");
$result = mysql_query($query) or die(mysql_error() . "in $query<br>");
while ($row=mysql_fetch_row($result)) {
	$buyer_id=$row[0];
}

$x_amount += shipping_upgrade_price($shipping_type);
$insert_order = "INSERT INTO orders VALUES ('$buyer_id','$x_cust_id','$Date', '$shipping_type', '$giftWrap', '$giftWrapLabel', '$x_amount','')";
mysql_query($insert_order) or  die(mysql_error() . "in <br>$insert_order<br>");;
$query = "SELECT OrderNumber FROM orders WHERE BuyerID='$buyer_id' AND Date='$Date' AND BuyerID='$buyer_id'";
//echo($query);
$result=mysql_query($query) or die(mysql_error() . "in <br>$query<br>");
while ($row=mysql_fetch_row($result)) {
	$order_number=$row[0];
}
mysql_query("UPDATE buyers SET OrderNumber='$order_number' WHERE BuyerID='$buyer_id'");
$search = "SELECT * FROM cartItems WHERE UserID='$x_cust_id'";
//echo($search);
$result=mysql_query($search) or die(mysql_error() . "in $search<BR>");
while ($row  =  mysql_fetch_row($result)) {
	$cart_user_id=$row[0];
	$cart_item_id=$row[1];
	$cart_item_quantity=$row[2];
	$cart_date=$row[3];
	$cart_id=$row[4];
	$search2 = "SELECT * FROM itemDef WHERE itemID='$cart_item_id'";
	//echo($search2 . "<br>");
	$result2=mysql_query($search2) or die(mysql_error() . "in $search2<BR>");
	$i = 0;
	while ($row2=mysql_fetch_row($result2))
	{
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
		
		$insert = "INSERT INTO receipts VALUES ('$buyer_id','$x_cust_id','$order_number','$Date','$item_id','$cart_item_quantity')";
		//echo($insert);
		mysql_query($insert) or die(mysql_error() . "in $insert<BR>");
		$i++;
	}
}

/******************************************************************
 * Remove Shopping Cart Items.
 *****************************************************************/
mysql_query("DELETE FROM cartItems WHERE UserID='$x_cust_id'") or die(mysql_error() . " in DELETE<BR>");
mysql_query("DELETE FROM users WHERE User='$x_cust_id'") or die(mysql_error() . " in DELETE<BR>");
/******************************************************************
 * END Remove Shopping Cart Items.
 *****************************************************************/

/******************************************************************
 * Load Buyer Info from DB for receipt.
 *****************************************************************/
$query = "SELECT * FROM buyers WHERE UserID='$x_cust_id'";
$result=mysql_query($query) or die(mysql_error() . " in 174");
while ($row=mysql_fetch_row($result)) {
	$buyers_name=$row[0] . " " . $row[1];
	//echo("<b>buyers_name=" . $buyers_name . "</b>");
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
	//$cc_num=$row[20];
	//$cc_expiration=$row[21];
	$order_total=$row[21];
	$order_date=$row[22];
	$order_number=$row[23];
	$buyers_user_id=$row[24];
	$buyers_buyer_id=$row[25];
}
if (@$_POST["Contact"] == "1") {
	$contact_buyer="Yes";
} 
else {
	$contact_buyer="No"; 
}	
/******************************************************************
 * END Load Buyer Info from DB for receipt.
 *****************************************************************/


/******************************************************************
 * Generate EMail and send it to the buyer and Marnie.
 *****************************************************************/
include("./receipt_email.php");
/******************************************************************
 * END Generate EMail and send it to the buyer and Marnie.
 *****************************************************************/

/******************************************************************
 * Print Reciept to screen
 *****************************************************************/
include("./receipt.php");
/******************************************************************
 * END Print Reciept to screen
 *****************************************************************/

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
?>
