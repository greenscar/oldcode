<!--

  DISCLAIMER:
     This code is distributed in the hope that it will be useful, but without any warranty; 
     without even the implied warranty of merchantability or fitness for a particular purpose.

   Main PHP that demonstrates how to use the SIM library. 
   Input (Form or QueryString):
      x_Amount
      x_Description
-->

<HTML>
<HEAD>
<TITLE>Order Form</TITLE>
</HEAD>
<BODY>
<H3>Final Order</H3>

<?
$x_Description = $_GET['x_Description'];
$x_Amount = $_GET['x_Amount'];

// *** IF YOU WANT TO PASS CURRENCY CODE do the following: ***
// Assign the transaction currency (from your shopping cart) to $currencycode variable

if ($x_Description == "")
	$x_Description = $_POST['x_Description'];

if ($x_Amount == "")
	$x_Amount = $_POST['x_Amount'];

?>

Description: <?=$x_Description?>  <BR />
Total Amount : <?=$x_Amount?>

<BR /><BR />
<FORM action="https://certification.authorize.net/gateway/transact.dll" method="POST">
<?

// authdata.php contains the loginid and txnkey. 
// You may use a more secure alternate method to store these (like a DB / registry).

include ("simdata.php"); 
include ("simlib.php");

$amount = $x_Amount;

// Trim $ sign if it exists
if (substr($amount, 0,1) == "$") {
	$amount = substr($amount,1);
}
// I would validate the Order here before generating a fingerprint

// Seed random number for security and better randomness.

srand(time());
$sequence = rand(1, 1000);
// Insert the form elements required for SIM by calling InsertFP
$ret = InsertFP ($loginid, $txnkey, $amount, $sequence);

//*** IF YOU ARE PASSING CURRENCY CODE uncomment and use the following instead of the InsertFP invocation above  ***
// $ret = InsertFP ($loginid, $txnkey, $amount, $sequence, $currencycode);

// Insert rest of the form elements similiar to the legacy weblink integration
echo ("<input type=\"hidden\" name=\"x_description\" value=\"" . $x_Description . "\">\n" );
echo ("<input type=\"hidden\" name=\"x_login\" value=\"" . $loginid . "\">\n");
echo ("<input type=\"hidden\" name=\"x_amount\" value=\"" . $amount . "\">\n");

// *** IF YOU ARE PASSING CURRENCY CODE uncomment the line below *****
//echo ("<input type=\"hidden\" name=\"x_currency_code\" value=\"" . $currencycode . "\">\n");

?>
<INPUT type="hidden" name="x_show_form" value="PAYMENT_FORM">
<INPUT type="hidden" name="x_test_request" value="TRUE">
<INPUT type="submit" value="Accept Order">
</FORM>
</BODY>
</HTML>
