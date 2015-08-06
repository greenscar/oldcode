<?
/*************************************************
 * user_info.php
 * This form collects user info for
 * billing and shipping information
 *************************************************/

$i=0;
$j=0;
include("figure_shipping.inc");
require_once("./session_header.php");
/******************************************************************
 * Display the Items the user is about to pay for
 *****************************************************************/
$queryString = "SELECT * FROM cartItems WHERE UserID='$UID'";
$result=mysql_query($queryString);
$num=mysql_num_rows(@$result);
if ($num == "0")
{
	commonHeader("$Company","View the contents of your shopping cart");
	whiteFont("Arial","Your shopping cart is empty <br><br>\n");
} 
else
{
	checkoutHeader("$Company","Welcome to Checkout.");
	whiteFont("Arial","Your shopping cart contains the following items:<br><br>\n");
	echo "<table border='1' cellpadding='5' cellspacing='5'>\n<tr>\n";
	echo "\t\n<th>\t";
	blackFont("Arial","Product Code");
	echo "\n</th>\n";
	echo "\t\n<th>\t";
	blackFont("Arial","Product Name");
	echo "</th>\n";
	echo "\t\n<th>\t";
	blackFont("Arial","Quantity");
	echo "</th>\n";
	echo "\t\n<th>\t";
	blackFont("Arial","Cost");
	echo "</th>\n";
	echo "\t\n<th>\t";
	blackFont("Arial","Total");
	echo "</th>\n";
	echo "<th colspan='2'>\n";
	blackFont("Arial","Add/Remove _items");
	echo "</th></tr>\n";
	$result=mysql_query("SELECT * FROM cartItems WHERE UserID='$UID'");
	while ($row  =  mysql_fetch_row($result))
	{
		$x_cust_id=$row[0];
		$_itemID=$row[1];
		$_itemQuantity=$row[2];
		$date=$row[3];
		$cart_itemsID=$row[4];
		$result2=mysql_query("SELECT * FROM itemDef WHERE itemID='$_itemID'");
		while ($row2=mysql_fetch_row($result2))
		{
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
			
			//fontFace("Arial","<li><a href='description.php?ID=$cart_itemsID&UID=$UID");
			$To[$i]=(($_itemQuantity * $cost_retail));
			echo "<tr>\n\t<td>\n\t\t";
			whiteFont("Arial","$SKU");
			echo "\n\t</td>\n\t<td>\n\t\t";
			whiteFont("Arial","$name");
			echo "\n\t</td>\n\t<td>\n\t\t";
			whiteFont("Arial","$_itemQuantity");
			echo "\n\t</td>\n\t<td>\n\t\t";
			$cost_retail=number_format($cost_retail,"2",".","thousands_sep");
			whiteFont("Arial","$$cost_retail");
			echo "\n\t</td>\n\t<td>\n\t\t";
			$Tot=number_format($To[$i],"2",".","thousands_sep");
			whiteFont("Arial","<b>$$Tot</b>\n");
			echo "<td valign=\"center\"><center>\n";
			echo "<FORM ACTION=\"add_item.php\" METHOD=\"POST\">\n";
			echo "<input type=\"hidden\" name=\"cartItemsID\" value=\"$cart_itemsID\">\n";
			echo "<input type=\"hidden\" name=\"_itemName\" value=\"$name\">\n";
			echo "<input type=\"hidden\" name=\"UID\" value=\"$UID\">\n";
			echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Add\">\n";
			echo "</center></td>\n";
			echo "</form>\n";
			echo "<td><center>\n";
			echo "<FORM ACTION=\"remove_item.php\" METHOD=\"POST\">\n";
			echo "<input type=\"hidden\" name=\"cartItemsID\" value=\"$cart_itemsID\">\n";
			echo "<input type=\"hidden\" name=\"UID\" value=\"$UID\">\n";
			echo "<input type=\"SUBMIT\" NAME=\"SUBMIT\" value=\"Remove\">\n";
			echo "</center></td></tr>\n";
			echo "</form>\n";
			$i++;
		}
	}
	if(empty($sub_total))
	{
		$sub_total = 0;
	}
	while ($j < $i)
	{
		$sub_total=$sub_total+$To[$j];
		$j++;
	}
	$sub_total=number_format($sub_total,"2",".","thousands_sep");
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
	if ($shipping == "0.00")
	{
		$ES="1";
		whiteFont("Arial","<b><center> FREE! </center></b>\n"); 
	} 
	else
	{
		whiteFont("Arial","<b><center> $$shipping </center></b>\n"); 
	}
	
	$total = $shipping + $sub_total;
	$total=number_format($total,"2",".","thousands_sep");
	
	echo "<tr><td></td><td></td>\n";
	echo "<td colspan='2'>\n";
	blackFont("Arial","<center><b><i>Total: </i></b></center>\n");
	echo "<td>\n";
	whiteFont("Arial","<b><center> $$total </center></b>\n"); 
	
	echo "<td colspan=\"2\"><center>\n";
	echo("</td></tr></table>\n");
	echo "<br><br>\n";
	fontSize("-1","black", "Arial","<center>HINT: ");
	fontSize("-1","white","Arial","To add more of a particular item to your shopping cart, ");
	fontSize("-1","white","Arial","click \"Add.\"  To remove an item from your cart, click ");
	fontSize("-1","white","Arial","\"Remove.\"</center>\n");
}
/******************************************************************
 * END Display the Items the user is about to pay for
 *****************************************************************/

/******************************************************************
 * Display the form for the buyer information.
 *****************************************************************/
echo "<p>";
GLOBAL $WebSecure;
echo "<form name=\"buyerInfo\" action=\"https://secure.authorize.net/gateway/transact.dll\" method=\"POST\" onsubmit=\"return (checkFields(this))\">";

// Insert the form elements required for SIM by calling InsertFP
include("./cc_process_inc/simdata.inc");
include("./cc_process_inc/simlib.inc");
// Seed random number for security and better randomness.
srand(time());
$sequence = rand(1, 1000);
$ret = InsertFP ($loginid, $txnkey, $total, $sequence);
// END Insert the form elements required for SIM by calling InsertFP

//x_test_request is used to submit test data to Authorize.net
echo("<input type=\"hidden\" name=\"x_test_request\" value=\"false\">");

echo ("<input type=\"hidden\" name=\"x_login\" value=\"" . $loginid . "\">\n");
echo("<INPUT type=\"hidden\" name=\"x_relay_url\" value=\"http://www.treat-me.biz/php/process_order.php\">");

fontSize("+1","white","Arial","<b>Please fill out the information below</b><p>");
echo("<table border=\"0\"><tr><td>\n");
fontSize("+1","white","Arial","Your Billing Address<p>");
fontSize("-1","white","Arial","Your name<br>");
echo "<input type=\"hidden\" name=\"x_amount\" size=\"40\" value=\"$total\"><p>";

//echo "<input type=\"text\" name=\"Name\" size=\"40\" value=\"" . @$_POST["Name"] . "\"><p>";
echo "<input type=\"text\" name=\"x_first_name\" size=\"30\" value=\"" . @$_POST["x_first_name"] . "\"> &nbsp;";
echo "<input type=\"text\" name=\"x_last_name\" size=\"30\" value=\"" . @$_POST["x_last_name"] . "\"><p>";
fontSize("-1","white","Arial","Your address<br>");
echo "<input type=\"hidden\" name=\"x_address\" size=\"40\"><br>";
echo "<input type=\"text\" name=\"BuyAddress1\" size=\"40\" value=\"" . @$_POST["BuyAddress1"] . "\"><br>";
echo "<input type=\"text\" name=\"BuyAddress2\" size=\"40\" value=\"" . @$_POST["BuyAddress2"] . "\"><p>";

fontSize("-1","white","Arial","Your city state and zip code<br>");
echo "<input type=\"text\" name=\"x_city\" size=\"20\" value=\"" . @$_POST["x_city"] . "\">";
echo ", " . CB_STATES("x_state", @$_POST["x_state"]); 

echo "&nbsp;&nbsp;<input type=\"text\" name=\"x_zip\" size=\"7\" maxlength=\"12\" value=\"" . @$_POST["x_zip"] . "\"><p>";

echo("</TD><TD width=10>\n");
echo("</TD><TD>\n");
fontSize("+1","white","Arial","Mailing information (if different)<p>");
fontSize("-1","white","Arial","Recipient's name<br>");
echo "<input type=\"text\" name=\"x_ship_to_first_name\" size=\"30\" value=\"" . @$_POST["x_ship_to_first_name"] . "\">&nbsp;";
echo "<input type=\"text\" name=\"x_ship_to_last_name\" size=\"30\" value=\"" . @$_POST["x_ship_to_last_name"] . "\"><p>";

fontSize("-1","white","Arial","Recipient's address<br>");
echo "<input type=\"text\" name=\"shipBuyAddress1\" size=\"40\" value=\"" . @$_POST["shipBuyAddress1"] . "\"><br>";
echo "<input type=\"text\" name=\"shipBuyAddress2\" size=\"40\" value=\"" . @$_POST["shipBuyAddress2"] . "\"><p>";
echo "<input type=\"text\" name=\"x_ship_to_address\" size=\"40\"><br>";
fontSize("-1","white","Arial","Recipient's city state and zip code<br>");
echo "<input type=\"text\" name=\"x_ship_to_city\" size=\"20\" value=\"" . @$_POST["x_ship_to_city"] . "\">";
echo ", " . CB_STATES("x_ship_to_state", @$_POST["x_ship_to_state"]); 

echo "&nbsp;&nbsp;<input type=\"text\" name=\"x_ship_to_zip\" size=\"7\" maxlength=\"12\" value=\"" . @$_POST["x_ship_to_zip"] . "\"><p>";
echo("</TD></TR><TR><TD colspan=3>\n");

fontSize("-1","white","Arial","Your e-mail address<br>");
echo "<input type=\"text\" name=\"x_email\" size=\"40\" value=\"" . @$_POST["x_email"] . "\"><p>";

fontSize("-1","white","Arial","Your daytime (work) phone number<br>");
echo "<input type=\"text\" name=\"x_phone\" size=\"15\" value=\"" . @$_POST["x_phone"] . "\"><p>";

fontSize("-1","white","Arial","Your evening (home) phone number<br>");
echo "<input type=\"text\" name=\"eve_phone\" size=\"15\" value=\"" . @$_POST["eve_phone"] . "\"><p>";

fontSize("-1","white","Arial","Shipping upgrade options<br>");
echo("<SELECT NAME=\"shipping_type\" SIZE=\"1\">\n\t");
echo("<OPTION VALUE=\"ground\">Ground</OPTION>\n\t");
echo("<OPTION VALUE=\"3rd_day\">3rd Business Day + $5.95</OPTION>\n\t");
echo("<OPTION VALUE=\"2nd_day\">2nd Business Day + $10.95</OPTION>\n\t");
echo("<OPTION VALUE=\"overnight\">Overnight + $20.00</OPTION>\n\t");
echo("</SELECT><p>\n");

fontSize("-1","white","Arial","Yes, I would like my items gift wrapped for $$giftWrapPrice.&nbsp&nbsp");
echo("<INPUT TYPE=\"CHECKBOX\" NAME=\"giftWrap\" VALUE=\"TRUE\"></INPUT><BR>");
fontSize("-1","white","Arial","Please let us know what you would like the gift card to read: <BR>");
echo("<TEXTAREA NAME=\"giftWrapLabel\" COLS=30 ROWS=3></TEXTAREA><br><br>");
echo "<input type=\"hidden\" name=\"PayMethod\" size=\"40\" value=\"CC\"><p>";

fontSize("-1","white","Arial", "Credit Card type:&nbsp&nbsp<IMG SRC=\"../photos/visa.gif\">&nbsp<IMG SRC=\"../photos/mastercard.gif\"><br>");
echo("<SELECT NAME=CCType SIZE=\"1\">\n\t");
echo("<OPTION VALUE=\"Visa\">Visa</OPTION>\n\t");
echo("<OPTION VALUE=\"MasterCard\">MasterCard</OPTION>\n");
echo("</SELECT><p>\n");

fontSize("-1","white","Arial", "Customer Credit Cards will be billed as Treat-Me<p>");
fontSize("-1","white","Arial", "Credit Card number<br>");
echo  "<input type=\"text\" name=\"x_card_num\" size=\"22\"><p>\n";
echo("<input type=\"hidden\" name=\"x_email_customer\" value=\"false\">");
fontSize("-1","white","Arial", "Credit Card expiration date(MM/YY)<br>");
echo  "<input type=\"text\" name=\"x_exp_date\" size=\"4\"><p>\n";

echo  "<input type=\"checkbox\" name=\"Contact\" value=\"1\" CHECKED>";
fontSize("-1","white","Arial", "&nbsp;&nbsp;Please contact me before filling this order<p>");

$Date=date("Y:z:Y-m-d");
$total=ereg_replace(",","",$total);
echo ("<input type=\"hidden\" name=\"OrderTotal\" value=\"$total\">\n");
echo ("<input type=\"hidden\" name=\"Date\" value=\"$Date\">\n");
echo ("<input type=\"hidden\" name=\"x_cust_id\" value=\"$UID\">\n");
echo ("<input type=\"hidden\" name=\"BuyerID\" value=\"\">\n");
echo ("<input type=\"submit\" value=\"Complete This Order\">\n</form>\n");
echo "</td></tr></table>";
commonFooter($UID);
/******************************************************************
 * END Display the form for the buyer information.
 *****************************************************************/


/*
* This is a prebuilt combobox of states and provinces with the ability to easily preset the combobox to a preferblack value. 
* The next line is an example of how the code would be called 
*
* <? 
*	echo CB_STATES("CA"); 
* ?> 
*
* This should give you the combobox with California already selected. 
*/

function CB_STATES($name, $vState = NULL) 
{ 
	$dataSet=""; 
	$DBconn=""; 
	$stateRS=""; 
	$lb=""; 
	$statearr=GetAllStates(); 
	$lb="<select name='$name' size='1'>\n"; 
	while(list($key,$val)=each($statearr)){ 
		$lb=$lb . "<option value='$key'"; 
		if (!is_null($vState)) 
			if (trim($vState)==trim($key)) $lb=$lb . " Selected "; 
            	$lb=$lb . ">$val</option>\n"; 
	} //end while 
	$lb = $lb . "</Select>"; 
	return $lb; 
} //end function CB_STATES 

function GetAllStates() 
{ 
	$thisarr=array("AL"=>"Alabama", 
				"AK"=>"Alaska", 
				"AB"=>"Alberta, Canada", 
				"AS"=>"American Samoa", 
				"AZ"=>"Arizona", 
				"AR"=>"Arkansas", 
				"BC"=>"British Columbia, Canada", 
				"CA"=>"California", 
				"CO"=>"Colorado", 
				"CT"=>"Connecticut", 
				"DE"=>"Delaware", 
				"DC"=>"District of Columbia", 
				"FM"=>"Federated Micronesia", 
				"FL"=>"Florida", 
				"GA"=>"Georgia", 
				"GU"=>"Guam", 
				"HI"=>"Hawaii", 
				"ID"=>"Idaho", 
				"IL"=>"Illinois", 
				"IN"=>"Indiana", 
				"IA"=>"Iowa", 
				"KS"=>"Kansas", 
				"KY"=>"Kentucky", 
				"LA"=>"Louisiana", 
				"ME"=>"Maine", 
				"MB"=>"Manitoba, Canada", 
				"MH"=>"Marshall Islands", 
				"MD"=>"Maryland", 
				"MA"=>"Massachusetts", 
				"MI"=>"Michigan", 
				"MN"=>"Minnesota", 
				"MS"=>"Mississippi", 
				"MO"=>"Missouri", 
				"MT"=>"Montana", 
				"NE"=>"Nebraska", 
				"NV"=>"Nevada", 
				"NB"=>"New Brunswick, Canada", 
				"NH"=>"New Hampshire", 
				"NJ"=>"New Jersey", 
				"NM"=>"New Mexico", 
				"NY"=>"New York", 
				"NF"=>"Newfoundland, Canada", 
				"NC"=>"North Carolina", 
				"ND"=>"North Dakota", 
				"NT"=>"North West Territory, Canada", 
				"MP"=>"Northern Marianas", 
				"NS"=>"Nova Scotia, Canada", 
				"OH"=>"Ohio", 
				"OK"=>"Oklahoma", 
				"ON"=>"Ontario, Canada", 
				"OR"=>"Oregon", 
				"PW"=>"Palau", 
				"PA"=>"Pennsylvania", 
				"PE"=>"Prince Edward Island, Canada", 
				"PR"=>"Puerto Rico", 
				"PQ"=>"Quebeq, Canada", 
				"RI"=>"Rhode Island", 
				"SK"=>"Saskatchewan, Canada", 
				"SC"=>"South Carolina", 
				"SD"=>"South Dakota", 
				"TN"=>"Tennessee", 
				"TX"=>"Texas", 
				"UT"=>"Utah", 
				"VT"=>"Vermont", 
				"VI"=>"Virgin Islands", 
				"VA"=>"Virginia", 
				"WA"=>"Washington", 
				"WV"=>"West Virginia", 
				"WI"=>"Wisconsin", 
				"WY"=>"Wyoming", 
				"YT"=>"Yukon Territories, Canada"); 
	return $thisarr; 
} //end function 

?>
