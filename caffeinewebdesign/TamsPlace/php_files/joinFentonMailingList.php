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
    //echo( "<P>Unable to locate the fentonMailingList " .
    //      "database at this time. Creating it now.</P>" );
    //exit();
  }
  $checkForMailListTable = "select * from fentonMailingList";
  if(mysql_query($checkForMailListTable) ) {
  } 
  else {
	  $sql = "CREATE TABLE fentonMailingList ( " .
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
  		   echo("<P>Error creating fentonMailingList table: " . mysql_error() . "</P>");
  		}
  }
  //SUBMIT A NEW ENTRY INTO THE DATABASE
	$result2 = mysql_query("SELECT COUNT(*) AS NumEntries ".
      					"FROM fentonMailingList" );  
  	$row2 = mysql_fetch_array($result2);
  	$numMailEntries = $row2["NumEntries"];
	
			
	if ($email == ""){
		echo("<h1 align=center>You must enter an email address.</h1>");
		echo("<h2 align=center>Click your back arrow or <a href=../joinmailinglist.html>CLICK HERE</a> </h2>");
	}
	else
	{
		$isEntered = mysql_query("SELECT * FROM fentonMailingList WHERE eMail LIKE '$email'");
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
		if ($submitPerson == "Add me to the Julie Fenton Young Mailing List")
		{
			if (@$alreadyEnteredToday != 1)
			{
				echo( "<h1 align = center>You have been added to the mailing list</h1>" );
				$insertMe = "INSERT INTO fentonMailingList SET " .
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
						exit();
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
		else //if(submitPerson == "Remove me from the Mailing List")
		{
			$removePerson = mysql_query("DELETE FROM fentonMailingList WHERE eMail LIKE '$email'");	
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

