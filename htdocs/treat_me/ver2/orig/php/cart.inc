<?
/* Replace these variables with information about your company */
$giftWrapPrice = "3.00";
$Company ="Treat-Me";
$Address1="163 N Hayden Bay Drive";
$Address2="";
$City    ="Portland";
$State   ="OR";
$Zip     ="97217";
$Phone   ="(503) 757-8992";
/*
$Web = "http://127.0.0.1/treats";
$WebSecure = "http://127.0.0.1/treats/php";
$Email   ="laptop@caffeinewebdesign.com";
*/
$WebSecure = "https://www.treat-me.biz/php";
$Web     ="http://www.treat-me.biz";
//$Web = "http://127.0.0.1/treats";
$Email   ="marnie@treat-me.biz";
$NoShipping = "Shipping Extra";
function Brand() {
global $Company,$Address1,$Address2,$City,$State,$Zip,$Phone,$Web,$Email,$NoShipping;
}

/* Replace these variables with information for connecting to your
database server */
$DBHost="localhost";
$DBUser="treatm_treat";
$DBPass="platinum";
$DBName="treatm_treats";
/*
$DBUser="c8h10n4o2";//"treatme_treatme";
$DBPass="Zoolu4";//"platinum";
*/
function DBInfo() {
global $DBHost,$DBUser,$DBPass,$DBName;
}

/* Replace these variables with the absolute and relative paths to your
MyCart scripts */
$WebRoot="http://127.0.0.1";
//$WebHost="www.caffeinewebdesign.com";
function Root() {
global $WebRoot,$WebHost;
}

function redFont($font,$text) {
echo "<FONT FACE=\"$font\" COLOR=\"red\">$text</FONT>";
}

function blueFont($font,$text) {
echo "<FONT FACE=\"$font\" COLOR=\"blue\">$text</FONT>";
}

function blackFont($font,$text) {
echo "<FONT FACE=\"$font\" COLOR=\"black\">$text</FONT>";
}

function whiteFont($font,$text) {
echo "<FONT FACE=\"$font\" COLOR=\"white\">$text</FONT>";
}
function colorFont($color,$font,$text) {
echo "<FONT FACE=\"$font\" COLOR=\"$color\">$text</FONT>";
}

function fontFace($font,$text) {
echo "<FONT FACE=\"$font\" COLOR=\"WHITE\">$text</FONT>";
}

function fontSize($size,$color,$font,$text) {
echo "<FONT FACE=\"$font\" COLOR=\"$color\" SIZE=\"$size\">$text</FONT>";
}

function commonHeader($Company,$title) {
?>
<HTML>
<HEAD>
<TITLE><?$title?></TITLE>
<STYLE TYPE="text/css">
<!-- /* $WEFT -- Created by: james (c8h10n4o2@hotmail.com) on 11/14/2002 -- */
 	
	H2 {color:white;  font-weight: 1100; font-weight:bold; text-decoration:none}
  	H3 {color:white;  font-weight: 900; font-weight:bold; text-decoration:none}
	H4 {color:white; text-align:center; vertical-align:top; font-size: 20pt; font-weight: bold; text-decoration:none}
	P {color:white;  font-size: 12pt; font-weight: bold; text-decoration:none}
	P.ITEMNAMEHEADER {color:white; text-align:center; vertical-align:top; font-size: 20pt; font-weight: bold; text-decoration:none}
	P.DESCRIPTION {color:white;  font-size: 8pt; vertical-align:top; font-weight: BOLD; text-decoration:none}
	A{color:WHITE;  font-size: 12pt; font-weight: bold; text-decoration:none; border:none; padding:0}
	A:link{color:WHITE;  font-size: 12pt; font-weight: bold;text-decoration:none; border:none; padding:0}
	A:hover{color:BLACK;  font-size: 12pt; font-weight: bold;text-decoration:none; border:none}
	A.picture{}
	A.menu{color:white; font-size:16pt; font-weight: bold;text-decoration:none}
	A.menu:link{color:white; font-size:16pt; font-weight: bold;text-decoration:none}
	A.menu:hover{color:BLACK; font-size:16pt; font-weight: bold;text-decoration:none}
	
-->
</STYLE>
</HEAD>
<BODY BGCOLOR="#CC3333">
<?PHP
}


function receiptHeader($Company,$title) {
echo "<HTML><TITLE>$Company Receipt - $title</TITLE><BODY BGCOLOR=\"#CC3333\">";
}

function commonFooter($UID) {
GLOBAL $Web;
//echo("<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>");
//echo("<CENTER>\n");
echo("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
echo("<TR ALIGN=\"CENTER\"><TD COLSPAN=\"9\">");
echo("<TABLE BORDER=\"0\" WIDTH=\"80%\" ALIGN=\"CENTER\">\n");
echo("\t<TR><TD ALIGN=\"CENTER\"><hr width=\"70%\"></TD></TR>\n");
echo("\t<TR><TD ALIGN=\"CENTER\"><b><a href=\"$Web/php/checkout.php?UID=$UID\">Go To The Check Out Stand</a></b></TD></TR>\n");
echo("\t<TR><TD ALIGN=\"CENTER\"><b><a href=\"$Web/php/view_cart.php?UID=$UID\">View The Contents Of Your Cart</a></b></TD></TR>\n");
echo("\t<TR><TD ALIGN=\"CENTER\"><b><a href=\"$Web/php/index.php?UID=$UID&itemID=" . $_GET["nameID"] . "\">Continue Shopping</a></b></TD></TR>\n");
echo("</TABLE>");
echo("</TR></TD>");
echo("</TABLE>");
//echo("</CENTER>\n");
echo "<br><br></BODY></HTML>";
}

function adminFooter() {
echo "<center><br><br><hr width=\"70%\"><br>";
fontFace("Arial"," | <a href=\"./index.php\">Our Catalog</a>");
fontFace("Arial"," | <a href=\"./index.php\">Shopping Cart Admin</a>");
echo "<br><br></center></BODY></HTML>";
}

function receiptFooter($Company) {
echo "<br><br><center>";
fontFace("Arial","Thank you for ordering from <b>$Company</b>");
echo "</center><br><br>";
}

?>
