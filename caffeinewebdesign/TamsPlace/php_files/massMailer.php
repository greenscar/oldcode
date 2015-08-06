<?php	
  	//$dbcnx = mysql_connect("localhost", $id, $pwd);  
	set_time_limit(0);
	$dbcnx = mysql_connect("localhost", $id, $pwd);
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
	$senderName = "\"TamsPlace.com Artisan Gallery\"";
	$senderEmail = "tam@tamsplace.com";
	$fullList = mysql_query("SELECT * FROM mailingList");
	//$fullList = mysql_query("SELECT * FROM mailingList");
	echo("<TABLE align = center border = 1> \n <caption><b>The message has been sent to the following:</b></caption>\n <tr> \n\t <td>ID</td>\n\t<td>Name</td>\n\t<td>Address</td>\n\t" .
		 "<td>Subject</td>\n\t<td>From Name</td>\n\t<td>From Address</td>\n</tr>");
	while ($thisEntry = mysql_fetch_array($fullList))
	{
		$headers  = "MIME-Version: 1.0\n";
		$headers .= "Content-type: text/html; charset=iso-8859-1\n";
		$toName = ($thisEntry["firstName"] . " " . $thisEntry["lastName"]);
		$toAddress = $thisEntry["eMail"];
		$recipient = $toName." <".$toAddress.">";
		$sender="Tamsplace <tam@tamsplace.com>";
		$headers .= "From: $sender\nReply-To: $sender\nX-Mailer: PHP/" . phpversion();
		echo("<tr> \n\t <td>$thisEntry[id]</td>\n\t<td> $toName</td>\n\t<td> $toAddress </td>\n\t" .
		  	 "<td>$subject</td>\n\t<td>$senderName</td>\n\t<td>$senderEmail</td></tr>");
			 
		mail($recipient, "\"$subject\"", $message, $headers);	
	}
	echo("\n </TABLE>");	 
	echo("<P ALIGN = CENTER><h2 align=center><a href=../searchpage.html>Search the Database</a> </h2></P>");
?>