
<HTML>
<HEAD>
<TITLE> Contest Entries </TITLE>
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
	

<?php
	if ($clear == "Clear Contest Entries"){
		$command = mysql_query("DROP TABLE entries");
		if (!$command){
			echo("<P> Error deleting table</P>". mysql_error() );
			exit();
		}
		
	}
?>
<P ALIGN = CENTER>
	<h2 align=center>To perform a different search, <a href=../searchpage.html>CLICK HERE</a> </h2>
</P>
</BODY>
</HTML>
			