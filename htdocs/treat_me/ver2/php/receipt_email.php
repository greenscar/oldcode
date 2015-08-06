<?php
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
//$Email  .= "laptop@caffeinewebdesign.com";
$headers  = "MIME-Version: 1.0\r\n";
$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
$headers .= "From: $Email\r\nReply-To: $Email\r\n";
$headers .= "Cc: marnie@treat-me.biz\r\n";
$headers .= "Bcc: laptop@caffeinewebdesign.com\r\n";
$headers .= "Errors-To: laptop@caffeinewebdesign.com\n";
$headers .= "X-Mailer: PHP/" . phpversion() . "\r\n";
$footer="<BR>This order was automatically generated from Treat-me.biz.\n\n";
mail("$buyers_email", "Treat-Me.Biz Order #$order_number", "$part1$part2$part3$footer", $headers);
mail("$Email", "Treat-Me.Biz Order #$order_number", "$part1$part2$part3$footer", $headers);
?>