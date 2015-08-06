<?php
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



?>