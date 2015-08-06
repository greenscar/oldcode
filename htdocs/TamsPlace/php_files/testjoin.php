<HTML>
<HEAD>
<TITLE> Thank you. </TITLE>
</HEAD>
<BODY BACKGROUND="../imshome/laceback.jpg">
<?php
  // Connect to the database server  
  $dbcnx = mysql_connect("localhost", "tamsplace", "tam7739");  
  if (!$dbcnx) { 
   echo( "<P>Unable to connect to the " .
          "database server at this time.</P>" );
    exit();
  }


  // Select the database
  if (! @mysql_select_db("tamsplace") ) {
    //echo( "<P>Unable to locate the test " .
    //      "database at this time. Creating it now.</P>" );
    //exit();
  }
  $checkForMailListTable = "select * from test";
  //if(mysql_query($checkForMailListTable) ) {
  	$sql = "DROP TABLE test";
	if (mysql_query($sql))
	{
		echo("<p>Table Dropped</p>");
	}
	else
	{
		echo("<p>Couldn't drop table</p>");
	}
  //} 
  //else {
	  $sql = "CREATE TABLE test ( " .
	  		 "counter INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  " . 
	         "id INT NOT NULL, " . 
	  	     "firstName TEXT, lastName TEXT, " .
	    	 "address TEXT, city TEXT, " .
			 "state TEXT, zip INT, country TEXT, " .
			 "phone TEXT, eMail TEXT, " .
			 "howHeard TEXT, " .
			 "date DATE)";
		if ( mysql_query($sql) ) {
  		} 
  		else {
  		   echo("<P>Error creating test table: " . mysql_error() . "</P>");
  		}
	  	$sql = "INSERT INTO test SET " .
	  		 "id = 1 , " . 
	  	     "firstName = 'JOE', lastName = 'SET', " .
			 "eMail ='tam@tamsplace.com' , " .
			 "date = '" . date("Y-m-d") . "' ;";
		if ( mysql_query($sql) ) {
  		} 
  		else {
  		   echo("<P>Error creating test table: " . mysql_error() . "</P>");
  		}
	  	$sql = "INSERT INTO test SET " .
	  		 "id = 2 , " . 
	  	     "firstName = 'JOE', lastName = 'SET', " .
			 "eMail ='yourtam@yahoo.com' , " .
			 "date = '" . date("Y-m-d") . "' ;";
		if ( mysql_query($sql) ) {
  		} 
  		else {
  		   echo("<P>Error creating test table: " . mysql_error() . "</P>");
  		}
	  	$sql = "INSERT INTO test SET " .
	  		 "id = 3 , " . 
	  	     "firstName = 'JOE', lastName = 'SET', " .
			 "eMail ='tamsplace_com@yahoo.com' , " .
			 "date = '" . date("Y-m-d") . "' ;";
		if ( mysql_query($sql) ) {
  		} 
  		else {
  		   echo("<P>Error creating test table: " . mysql_error() . "</P>");
  		}
  //}
  //SUBMIT A NEW ENTRY INTO THE DATABASE
	$result2 = mysql_query("SELECT COUNT(*) AS NumEntries ".
      					"FROM test" );  
  	$row2 = mysql_fetch_array($result2);
  	$numMailEntries = $row2["NumEntries"];
	
			
	if ($email == ""){
		echo("<h1 align=center>You must enter an email address.</h1>");
		echo("<h2 align=center>Click your back arrow or <a href=../joinmailinglist.html>CLICK HERE</a> </h2>");
	}
	else
	{
		$isEntered = mysql_query("SELECT * FROM test WHERE eMail LIKE '$email'");
		if (!$isEntered){
    		echo("<P>Error performing query: " .
        	mysql_error() . "</P>");
    		exit();
  		}
		while ($thisRow = mysql_fetch_array($isEntered)){
			if ($thisRow["eMail"] == $email)
			{
				$alreadyEnteredToday = 1;
			}
		}		
		if (($submitPerson == "Add me to the Mailing List"))
		{
			if (@$alreadyEnteredToday != 1)
			{
				echo( "<h1 align = center>You have been added to the mailing list</h1>" );
				$insertMe = "INSERT INTO test SET " .
					"id = " . ($numMailEntries + 1) . ", " .
					"firstName = '$firstname', " .
					"lastName = '$lastname', " .
					"address = '$Address', " .
					"city = '$City', " .
					"state = '$myState', " .
					"zip = '$Zip', " .
					"country = '$Country', " .
					"phone = '$Phone', " .
					"eMail = '$email', " .
					"howHeard = '$howHeard', " . 
					"date = '" . date("Y-m-d") . "' ;";
					if (mysql_query($insertMe)){
						echo("<h1 align = center>Thank you.</h1>");
						echo("<h2 align=center><a href=../index.html>CLICK HERE TO RETURN HOME</a> </h2>");
					}
					else echo("<P>There has been an error. Please click your back arrow and then the submit button again.</P>");			
			}
			else
			{
				echo( "<h1 align = center>You are already on the mailing list</h1>" );
				echo("<h1 align = center>Thank you.</h1>");
				echo("<h2 align=center><a href=../index.html>CLICK HERE TO RETURN HOME</a> </h2>");
			}
		}
		else //submitPerson == "Remove me from the Mailing List"
		{
			$removePerson = mysql_query("DELETE FROM test WHERE eMail LIKE '$email'");	
			if (!$removePerson){
				echo( "<h2 align = center>There has been an error in your entry." .
					" Please <a href=../removeMe.html>RETURN</a> and try again.</h2>" );
  			}
			else{ 
				echo( "<h2 align=center>You, $email, have been removed from the mailing list</h2>" );
				echo("<h2 align=center><a href=../index.html>CLICK HERE TO RETURN HOME</a> </h2>");
			}
		}
	}
?>
</BODY></HTML>

