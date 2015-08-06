<HTML>
<HEAD>
<TITLE> Contest Entries </TITLE>
</HEAD>
<BODY BACKGROUND="../imshome/laceback.jpg">
<H1 align = center>I'm Sorry to see you go.</H1>
<?php
  	// Connect to the database server  
  	$dbcnx = mysql_connect("localhost", "tamsplace", "tam7739");  
  	if (!$dbcnx) { 
  		echo( "<P>Unable to connect to the " .
        "database server at this time.</P>" );
    	exit();
  	}
  	// Select the contest database
  	if (! @mysql_select_db("tamsplace") ) {
  	  	echo( "<P>Unable to locate the fentonMailingList " .
  	        "database at this time.</P>" );
  	  	exit();
  	}
	$removePerson = mysql_query("DELETE FROM fentonMailingList WHERE eMail LIKE '$email'");	
	if (!$removePerson){
		echo( "<h2 align = center>There has been an error in your entry." .
			" Please <a href=../removeMe.html>RETURN</a> and try again.</h2>" );
  	}
	else{ 
		echo( "<h2 align=center>You, $email, have been removed from the Julie Fenton Young mailing list</h2>" );
	}
?>
<h3 align=center><a href=../index.html>CLICK HERE TO RETURN HOME</a> </h3>
</BODY>
</HTML>