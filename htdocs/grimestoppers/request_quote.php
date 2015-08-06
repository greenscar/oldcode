<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=windows-1252">
	<TITLE>Grime Stoppers - Portland, OR - Janitorial, Cleaning, Janitor Services</TITLE>
	<META NAME="GENERATOR" CONTENT="OpenOffice.org 2.0  (Win32)">
	<META NAME="CREATED" CONTENT="20060807;21242475">
	<META NAME="CHANGED" CONTENT="20060807;21283443">
	<META NAME="&yuml;%&ocirc;&Ograve;&brvbar;b&yuml;%&eth;&Ograve;&brvbar;b&yuml;%&igrave;&Ograve;&brvbar;b&yuml;%&egrave;&Ograve;&brvbar;b&yuml;%&auml;&Ograve;&brvbar;b&yuml;%&agrave;&Ograve;&brvbar;b&yuml;%&Uuml;&Ograve;&brvbar;b&yuml;%&Oslash;&Ograve;&brvbar;b&yuml;%&Ocirc;&Ograve;&brvbar;b&yuml;%&ETH;&Ograve;&brvbar;b&yuml;%&Igrave;&Ograve;&brvbar;b&yuml;%&Egrave;&Ograve;&brvbar;b&yuml;%&Auml;&Ograve;&brvbar;b&yuml;%&Agrave;&Ograve;&brvbar;b&yuml;%&frac14;&Ograve;&brvbar;b&yuml;%&cedil;&Ograve;&brvbar;b&yuml;%&acute;&Ograve;&brvbar;b&yuml;%&deg;&Ograve;&brvbar;b&yuml;%&not;&Ograve;&brvbar;b&yuml;%&uml;&Ograve;&brvbar;b&yuml;%&curren;&Ograve;&brvbar;b&yuml;%&nbsp;&Ograve;&brvbar;b&yuml;%&#156;&Ograve;&brvbar;b&yuml;%&#152;&Ograve;&brvbar;b&yuml;%&#148;&Ograve;&brvbar;b&yuml;%&#144;&Ograve;&brvbar;b&yuml;%&#140;&Ograve;&brvbar;b&yuml;%&#136;&Ograve;&brvbar;b&yuml;%&#132;&Ograve;&brvbar;b&yuml;%&#128;&Ograve;&brvbar;b&yuml;%|&Ograve;&brvbar;b&yuml;%x&Ograve;&brvbar;b&yuml;%t&Ograve;&brvbar;b&yuml;%p&Ograve;&brvbar;b&yuml;%l&Ograve;&brvbar;b&yuml;%h&Ograve;&brvbar;b&yuml;%d&Ograve;&brvbar;b&yuml;%`&Ograve;&brvbar;b&yuml;%\&Ograve;&brvbar;b&yuml;%X&Ograve;&brvbar;b&yuml;%T&Ograve;&brvbar;b&yuml;%P&Ograve;&brvbar;b&yuml;%L&Ograve;&brvbar;b&yuml;%H&Ograve;&brvbar;b&yuml;%D&Ograve;&brvbar;b&yuml;%@&Ograve;&brvbar;b&yuml;%&lt;&Ograve;&brvbar;b&yuml;%8&Ograve;&brvbar;b&yuml;%4&Ograve;&brvbar;b&yuml;%0&Ograve;&brvbar;b&yuml;%,&Ograve;&brvbar;b&yuml;%(&Ograve;&brvbar;b&yuml;%$&Ograve;&brvbar;b&yuml;% &Ograve;&brvbar;b&yuml;%&Ograve;&brvbar;b&yuml;%&Ograve;&brvbar;b&yuml;%&Ograve;&brvbar;b&yuml;%&Ograve;&brvbar;b&yuml;%&Ograve;&brvbar;b&yuml;%&Ograve;&brvbar;b&yuml;%&Ograve;&brvbar;b&yuml;%" CONTENT="services, cleaning">
	<META NAME="DESCRIPTION" CONTENT="Grime Stoppers - Portland, OR Professional custodial services for corporate environments">
	<META NAME="KEYWORDS" CONTENT="janitor, cleaning, Portland, custodian">
	<META NAME="revisit-after" CONTENT="10 days">
	<META NAME="robots" CONTENT="index,follow,noarchive">
	<META HTTP-EQUIV="Content-Language" CONTENT="en-us">      
        <script type="text/javascript" src="check_fields.js"></script>
        <LINK REL=StyleSheet HREF="style.css" TITLE="Caffeine Web Design">
</HEAD>
<BODY LANG="en-US" DIR="LTR">
<DIV ID="leftBar" DIR="LTR">
	<P><BR><BR>
	</P>
</DIV>
<DIV ID="logoBox" DIR="LTR">
	<P>
            <A NAME="logo" style="border: 0px dotted pink;">
                <IMG SRC="logo.gif"  alt="Portland, OR Custodial Services" alt="Portland, OR Custodial Services" NAME="graphics1" ALIGN=BOTTOM WIDTH=200 HEIGHT=189 BORDER=0>
            </A>
        </P>
</DIV>
<DIV ID="Content" DIR="LTR" style="text-align: center">
  <?php
   require_once("./private_info/email.inc");
   if(isset($_POST["name"]))
   {
   require("./phpmailer-1.72/class.phpmailer.php");
   
   $mail = new PHPMailer();
   
   //$mail->IsSMTP();                                   // send via SMTP
   $mail->IsMail();
   $mail->Host     = "mail.Grime Stoppers.org"; // SMTP servers
   $mail->SMTPAuth = true;     // turn on SMTP authentication
   $mail->Username = "contactus@Grime Stoppers.org";//$id;  // SMTP username
   $mail->Password = "uscontact"; // SMTP password
   
   $mail->From     = "contactus@Grime Stoppers.org";
   $mail->FromName = "Contact Form";
   $mail->AddAddress("contactus@Grime Stoppers.org","Grime Stoppers");
   //$mail->AddAddress("jessica@Grime Stoppers.org");               // optional name
   //$mail->AddAddress("jsandlin@gmail.com", "James");
   $mail->AddReplyTo("contactus@Grime Stoppers.org","Grime Stoppers");
   
   $mail->WordWrap = 50;                              // set word wrap
   //$mail->AddAttachment("/var/tmp/file.tar.gz");      // attachment
   //$mail->AddAttachment("/tmp/image.jpg", "new.jpg");
   $mail->IsHTML(true);                               // send as HTML   
   $mail->Subject  =  "Grime Stoppers - Request a quote";
   $body = "<html><head></head><body>"
        . "<h1 align=\"center\">Request a Quote Form</h1>"
        . "<table width=\"400px\" border=\"1\">"
        . "<tr><td>Name</td><td>" . stripslashes($_POST["name"]) . "</td></tr>"
        . "<tr><td>Address</td><td>" . stripslashes($_POST["address"]) . "</td></tr>"
        . "<tr><td>Address2</td><td>" . stripslashes($_POST["address2"]) . "</td></tr>"
        . "<tr><td>City, State Zip</td><td>" . stripslashes($_POST["city"]) . ", " . $_POST["state"] . " " . $_POST["zip"] . "</td></tr>"
        . "<tr><td>Day Phone</td><td>" . stripslashes($_POST["day_phone"]) . "</td></tr>"
        . "<tr><td>Fax</td><td>" . stripslashes($_POST["fax"]) . "</td></tr>"
        . "<tr><td>E-Mail</td><td>" . stripslashes($_POST["email"]) . "</td></tr>"
        . "<tr><td>How'd You Hear About Us</td><td>" . stripslashes($_POST["hearAbout"]) . "</td></tr>"
        . "<tr><td>How soon to start service</td><td>" . stripslashes($_POST["howSoon"]) . "</td></tr>"
        . "<tr><td>Type of Service</td><td>" . stripslashes($_POST["serviceType"]) . "</td></tr>"
        . "<tr><td>Square Footage</td><td>" . stripslashes($_POST["squareFootage"]) . "</td></tr>"
        . "<tr><td>Number of Employees</td><td>" . stripslashes($_POST["numEmployees"]) . "</td></tr>"
        . "<tr><td>Cleaning Frequency</td><td>" . stripslashes($_POST["cleaningFrequency"]) . "</td></tr>"
        . "<tr><td>Number of Offices</td><td>" . stripslashes($_POST["numOffices"]) . "</td></tr>"
        . "<tr><td>Number of Restrooms</td><td>" . stripslashes($_POST["numRestrooms"]) . "</td></tr>"
        . "<tr><td>Number of Conference Rooms</td><td>" . stripslashes($_POST["numConfRooms"]) . "</td></tr>"
        . "<tr><td>Number of Kitchens</td><td>" . stripslashes($_POST["numKitchens"]) . "</td></tr>"
        . "<tr><td>Type of Flooring</td><td>" . stripslashes($_POST["flooring"]) . "</td></tr>"
        . "<tr><td>Dust Screens?</td><td>" . stripslashes($_POST["dustScreens"]) . "</td></tr>"
        . "<tr><td>Move Items & Dust</td><td>" . stripslashes($_POST["moveItems"]) . "</td></tr>"
        . "<tr><td>Special Attention Surfaces</td><td>" . stripslashes($_POST["specialSurfaces"]) . "</td></tr>"
        . "<tr><td>Best Time to Contact</td><td>" . stripslashes($_POST["bestContact"]) . "</td></tr>"
        . "<tr><td>Additional Comments</td><td>" . stripslashes($_POST["comments"]) . "</td></tr>";    
   $body .= "</table></body></html>";
   $mail->Body     =  $body;
   if(!$mail->Send())
   {
   echo "Message was not sent <p>";
   echo "Mailer Error: " . $mail->ErrorInfo;
   exit;
   }
   
   echo "<br><br><p>Thank you for your interest in Grime Stoppers. <br><br>We will contact you shortly.</p>";
   }
   else
   {
   ?>
	<H3>Grime Stoppers<br>
	Portland, OR <br>Janitorial Services</H3>
	<P>We would love the opportunity to provide you with a quote for our
	services. Please take a moment to complete the questions below,
	click on the submit button and we will get back to you with a quote.</P>
        <form name="contactUs" METHOD="post" onsubmit="return (checkFields(this))" action="request_quote.php">
            <p align="center">
            <TABLE BORDER=0 CELLPADDING=2 CELLSPACING=2 width=80%>
                    <TR>
                            <TD COLSPAN=2>
                                <h4 align="center">Contact Information</h4>
                            </TH>
                    </TR>
                    <TR>
                            <TD width=33%>
                                    <P>*NAME</P>
                            </TD>
                            <TD><input type="text" name="name" style="width:100%;"></TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>ADDRESS</P>
                            </TD>
                            <TD><input type="text" name="address" style="width:100%;"></TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>ADDRESS 2</P>
                            </TD>
                            <TD><input type="text" name="address2" style="width:100%;"></TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>*CITY, *STATE *ZIP</P>
                            </TD>
                            <TD><input type="text" name="city" style="width:55%;">,
                            <?php
                            echo(CB_STATES("x_ship_to_state", "OR"));
                            ?>
                            <input type="text" name="zip" style="width:14%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>DAY PHONE</P>
                            </TD>
                            <TD><input type="text" name="day_phone" style="width:100%;"></TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>FAX</P>
                            </TD>
                            <TD><input type="text" name="fax" style="width:100%;"></TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>*EMAIL</P>
                            </TD>
                            <TD><input type="text" name="email" style="width:100%;"></TD>
                    </TR>
                    <TR>
                            <TD COLSPAN=2>
                                    <P>*Indicates a required field.</P>
                            </TD>
                    </TR>
            </TABLE>
            </p>
            <hr>
            <p align="center">
            <TABLE BORDER=0 CELLPADDING=2 CELLSPACING=2 width= 80%;>
                    <TR>
                            <TD COLSPAN=2>
                                <h4 align="center">General Information</h4>
                            </TD>
                    </TR>
                    <TR>
                            <TD width=30%; class="top">
                                    <P>How did you hear about us?</P>
                            </TD>
                            <TD>
                                <textarea name="hearAbout" style="width:100%; height: 70px;"></textarea>
                            </TD>
                    </TR>
                    <TR>
                            <TD class="top">
                                    <P>How soon are you looking to start service?</P>
                            </TD>
                            <TD>
                                <input type="text" name="howSoon" style="width:100%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD class="top">
                                    <P>Type of service?</P>
                            </TD>
                            <TD>
                                <textarea name="serviceType" style="width:100%; height: 70px;"></textarea>
                            </TD>
                    </TR>
                    <TR>
                            <TD class="top">
                                    <P>Approximate square footage?</P>
                            </TD>
                            <TD>
                                <input type="text" name="squareFootage" style="width:100%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD class="top">
                                    <P>Number of employees?</P>
                            </TD>
                            <TD>
                                <input type="text" name="numEmployees" style="width:100%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD class="top">
                                    <P>Cleaning frequency?</P>
                            </TD>
                            <TD>
                                <textarea name="cleaningFrequency" style="width:100%; height: 70px;"></textarea>
                            </TD>
                    </TR>
            </TABLE>
            </p>
            <hr>
            <p align="center">
            <TABLE BORDER=0 CELLPADDING=2 CELLSPACING=2 width=80%>
                    <TR>
                            <TD COLSPAN=2>
                                    <H4 align="center">SPECIFIC INFORMATION ABOUT YOUR FACILITY</H4>
                            </TD>
                    </TR>
                    <TR>
                            <TD width="80%">
                                    <P>Number of Private Offices</P>
                            </TD>
                            <TD>
                                <input type="text" name="numOffices" style="width: 100%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>Number of Restrooms</P>
                            </TD>
                            <TD>
                                <input type="text" name="numRestrooms" style="width: 100%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>Number of Conference Rooms</P>
                            </TD>
                            <TD>
                                <input type="text" name="numConfRooms" style="width: 100%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>Number of Kitchenettes</P>
                            </TD>
                            <TD>
                                <input type="text" name="numKitchens" style="width: 100%;">
                            </TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>Type of Flooring</P>
                            </TD>
                            <TD>
                                <select name="flooring" style="width: 100%;">
                                    <option value="" selected></option>
                                    <option value="carpet">Carpet</option>
                                    <option value="tile">Tile</option>
                                    <option value="linoleum">Linoleum</option>
                                    <option value="concrete">Concrete</option>
                                    <option value="laminate">Laminate</option>
                                    <option value="other">Other</option>
                                </select>
                            </TD>
                    </TR>
            </TABLE>
            </p>
            <hr>
            <p align="center">
            <TABLE BORDER=0 CELLPADDING=2 CELLSPACING=2 width=80%>
                    <TR>
                            <TH COLSPAN=2>
                                    <H4 align="center">In the Offices</H4>
                            </TH>
                    </TR>
                    <TR>
                            <TD width="80%">
                                    <P>Do you want us to dust computer screens/printers?</P>
                            </TD>
                            <TD>
                                <select name="dustScreens" style="width: 100%;">
                                    <option value="" selected></option>
                                    <option value="yes">Yes</option>
                                    <option value="no">No</option>
                                </select>
                            </TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>Do you want us to move items on desk to dust?</P>
                            </TD>
                            <TD>
                                <select name="moveItems" style="width: 100%;">
                                    <option value="" selected></option>
                                    <option value="yes">Yes</option>
                                    <option value="no">No</option>
                                </select>
                            </TD>
                    </TR>
            </TABLE>
            </p>
            <hr>
            <p align="center">
            <TABLE BORDER=0 CELLPADDING=2 CELLSPACING=2 width=80%>
                    <TR>
                            <TH COLSPAN=2>
                                    <H4 align="center">OTHER:</H4>
                            </TH>
                    </TR>
                    <TR>
                            <TD width="80%">
                                    <P>Do you have surfaces that require special attention?</P>
                            </TD>
                            <TD>
                                <select name="specialSurfaces" style="width: 100%;">
                                    <option value="" selected></option>
                                    <option value="yes">Yes</option>
                                    <option value="no">No</option>
                                </select>
                            </TD>
                    </TR>
                    <TR>
                            <TD>
                                    <P>Where is the best place to reach you during the day?</P>
                            </TD>
                            <TD>
                                <select name="bestContact" style="width: 100%;">
                                    <option value="" selected></option>
                                    <option value="phone">Phone</option>
                                    <option value="email">Email</option>
                                </select>
                            </TD>
                    </TR>
            </TABLE>
            </p>
            <hr>
            <p align="center">
            <TABLE BORDER=0 CELLPADDING=2 CELLSPACING=2 width=80%>
                    <TR>
                            <Td colspan=2>
                                    <H4 align="center">COMMENTS SECTION:</H4>
                            </Td>
                    </TR>
                    <TR>
                            <TD width=30%>
                                    <P>Please feel free to use the below area to provide us with any
                                    comments that might be helpful in submitting a proposal/bid for
                                    you.</P>
                            </TD>
                    </TR>
                    <tr>
                        <td>
                            <textarea name="comments" style="width:100%; height: 70px;"></textarea>
                        </td>
                    </tr>
            </TABLE>
            </p>
            <hr>
            <p align="center">
            <input type="submit" name="submit" value="Submit to Grime Stoppers">
            </p>
        </form>
   <?
   }
   ?>
</DIV>
<DIV ID="Menu" DIR="LTR">
	<P>
        <A HREF="index.htm">Home</A><BR>
        <A HREF="about_us.htm">About Us</A><BR>
        <A HREF="services.htm">Services Provided</A><BR>
        <a href="customer_comments.htm">Customer Comments</a><br>
        <A HREF="request_quote.php">Request a Quote</A><BR>
        <A HREF="faq.htm">FAQ's</A><BR><BR><BR>
	</P>
</DIV>
<P><!-- BlueRobot was here. --><BR><BR>
</P>
</BODY>
</HTML>
<?php

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
	$lb="<select name='$name'  style=\"width:25%;\">\n"; 
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
        $thisarr=array("OR"=>"Oregon","WA"=>"Washington");
	return $thisarr; 
} //end function 

?>