<?php	
	set_time_limit(0);
	$dbcnx = mysql_connect("localhost", "tamsplace", "tam7739");
	if (!dbcnx){
   		echo( "<P>Unable to connect to the " .
          "database server at this time.</P>" );
    	exit();
  	}
	if (!@mysql_select_db("tamsplace")){}

	/**
	 * Open and read the file
	 */ 
	if (!$fp = fopen($theFile, "r")){
		echo("<h1>ERROR: ". mysql_error() . "</h1>");
		echo("<h2>Your file wasn't uploaded correctly. Please press your back arrow and try again.</h2>");
		exit();
	}
	$message=fread($fp,filesize($theFile));
	fclose($fp);
	/**
	 * End Open and read the file
	 */ 
	
	/**
	 * Send out the email
	 */
	$senderName = "TamsPlace.com Artisan Gallery";
	$senderEmail = "TamsPlace_com@yahoo.com";
	$senderFull = $senderName . " " . $senderEmail;
	$fullList = mysql_query("SELECT * FROM mailingList");
	echo("<TABLE align = center border = 1> \n <caption><b>The above message has been sent to the following:</b></caption>\n <tr> \n\t <td>ID</td>\n\t<td>Name</td>\n\t<td>Address</td>\n\t" .
		 "<td>Subject</td>\n\t<td>From Name</td>\n\t<td>From Address</td>\n</tr>");
	while ($thisEntry = mysql_fetch_array($fullList))
	{
		$toName = ($thisEntry["firstName"] . " " . $thisEntry["lastName"]);
		$toAddress = $thisEntry["eMail"];
		$recipient = $toName." <".$toAddress.">";
		$sender="Tamsplace <TamsPlace_com@yahoo.com>";
		echo("<tr> \n\t <td>$thisEntry[id]</td>\n\t<td> $toName</td>\n\t<td> $toAddress </td>\n\t" .
		  	 "<td>$subject</td>\n\t<td>$senderName</td>\n\t<td>$senderEmail</td></tr>");
		else mail($recipient, "\"$subject\"", $message, "From: $sender\nReply-To: $sender\nX-Mailer: PHP/" . phpversion());	
		
	}
	echo("\n </TABLE>");	 
	
?>