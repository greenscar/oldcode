<HTML>
<HEAD>
<TITLE> Email list </TITLE>
</HEAD>
<BODY BACKGROUND="../imshome/laceback.jpg">
<?php
  // Connect to the database server  
  $dbcnx = mysql_connect("localhost", $id, $pwd);  
  if (!$dbcnx) { 
   	echo( "<P>Unable to connect to the " .
          "database server at this time.</P>" );
    exit();
  }


  // Select the contest database
  if (! @mysql_select_db("tamsplace") ) {
    echo( "<P>Unable to locate the mailingList " .
          "database at this time.</P>" );
    exit();
  }
?>
<H2 ALIGN = CENTER> Here is your mailing list: </H2>
<br><br>

<?php

	$result = mysql_query("SELECT * FROM mailingList");
	if (!$result){
		echo("<P> Error performing query: " .
		mysql_error() . "</P>");
		exit();
	}
	if ($row = mysql_fetch_array($result)){
		echo($row["eMail"]);
	}
	while($row = mysql_fetch_array($result)){
		echo(" , " .$row["eMail"]);
	}//end while
?>
<br><br><br>

<H2 ALIGN = CENTER>To perform a different search, <a href=../searchpage.html>CLICK HERE</a> </H2>
</BODY>
</HTML>