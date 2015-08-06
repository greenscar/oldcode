<HTML>
<HEAD>
<TITLE> Thank you. </TITLE>
</HEAD>
<BODY BACKGROUND="../imshome/laceback.jpg">
<?php
  // Connect to the database server  
  //$dbcnx = mysql_connect("localhost", "c8h10n4o2", "Zoolu4");
  $dbcnx = mysql_connect("localhost", "tamsplace", "tam7739");  
  if (!$dbcnx) { 
   echo( "<P>Unable to connect to the " .
          "database server at this time.</P>" );
    exit();
  }


  // Select the database
  if (! @mysql_select_db("tamsplace") ) {
    //echo( "<P>Unable to locate the mailingList " .
    //      "database at this time. Creating it now.</P>" );
    //exit();
  }
  /***********************************************************
   * Open both tables and if they do not exist, create them
   ***********************************************************/
  $checkForEntryTable = "select * from entries";
  if (mysql_query($checkForEntryTable) ) {
  } 
  else {
	  $sql = "CREATE TABLE entries ( " .
	  		 "counter INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  " .
	         "id INT NOT NULL, " . 
	  	     "firstName TEXT, lastName TEXT, " .
	    	 "address TEXT, city TEXT, " .
			 "state TEXT, zip INT, country TEXT, " .
			 "phone TEXT, eMail TEXT, " .
			 "howHeard TEXT, onMailList INT, " .
			 "date DATE)";
		if ( mysql_query($sql) ) {
  		} 
  		else {
  		   echo("<P>Error creating entries table: " . mysql_error() . "</P>");
  		}
  }
  $checkForMailListTable = "select * from mailingList";
  if(mysql_query($checkForMailListTable) ) {
  } 
  else {
	  $sql = "CREATE TABLE mailingList ( " .
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
  		   echo("<P>Error creating mailingList table: " . mysql_error() . "</P>");
  		}
  }
  /***********************************************************
   * END Open both tables and if they do not exist, create them
   ***********************************************************/
   
   
  /***********************************************************
   * Count the number of entries in each table
   ***********************************************************/
  //SUBMIT A NEW ENTRY INTO THE DATABASE
    $alreadyEnteredToday = 0;
  	$result = mysql_query("SELECT COUNT(*) AS NumEntries ".
      					"FROM entries" );  
  	$row = mysql_fetch_array($result);
  	$numentries = $row["NumEntries"];
	
	$result2 = mysql_query("SELECT COUNT(*) AS NumEntries ".
      					"FROM mailingList" );  
  	$row2 = mysql_fetch_array($result2);
  	$numMailEntries = $row2["NumEntries"];
	
  /***********************************************************
   * END Count the number of entries in each table
   ***********************************************************/
	
	
  /***********************************************************
   * Make sure all fields are complete
   ***********************************************************/
	if (($firstname == "") || ($lastname == "") || ($Address == "") || ($City == "") || ($myState == "") || ($Zip == "")
		 || ($Country == "") || ($Phone == "") || ($email == "") || ($howHeard == ""))
	{
		echo("<h1 align=center>You must complete all fields to enter contest or mailing list.</h1>");
		echo("<h2 align=center>Click your back arrow or <a href=../giveaway3.html#enter>CLICK HERE</a> </h2>");
		exit();
	}
	
  /***********************************************************
   * END Make sure all fields are complete
   ***********************************************************/
   
  /***********************************************************
   * Check to see if this email address has entered today
   ***********************************************************/
	$isEntered = mysql_query("SELECT * FROM entries WHERE eMail LIKE '$email'");
	
	if (!$isEntered){
    	echo("<P>Error performing query: " .
        mysql_error() . "</P>");
    	exit();
  	}
	$alreadyEnteredToday = 0;
	while ($thisRow = mysql_fetch_array($isEntered)){
		if ($thisRow["date"] == date("Y-m-d")){
			//WITH THIS DOCUMENTED OUT, THE SAME EMAIL CAN ENTER AS MANY TIMES AS THEY WANT.
			$alreadyEnteredToday = 1;
		}
	}		
  /***********************************************************
   * END Check to see if this email address has entered today
   ***********************************************************/
   
  /***********************************************************
   * If person has not entered today, enter them into the contest
   ***********************************************************/
   	
	//echo("<p>HELLO</p>");
	$alreadyOnList = 0;
	$sql = "INSERT INTO entries SET id = " . ($numentries + 1) . ", firstName = '$firstname', " .
			"lastName = '$lastname', address = '$Address', city = '$City', state = '$myState', " . 
   			"zip = '$Zip', country = '$Country', phone = '$Phone', eMail = '$email', " .
   			"howHeard = '$howHeard', onMaillist = '$Mailing_list', date = '" . date("Y-m-d") . "' ;";
	$onMailList = mysql_query("SELECT * FROM mailingList WHERE eMail LIKE '%$email%'");
	if (!$onMailList){
    		echo("<P>Please Try Again.</P>");
			echo("<h2 align=center>Click your back arrow or <a href=../giveaway3.html#enter>CLICK HERE</a> </h2>");
    		exit();
  	}
	while ($thisRow = mysql_fetch_array($onMailList)){
			if ($thisRow["eMail"] == $email){
				//echo("alreadyOnList == " . $alreadyOnList . "<br>");
				$alreadyOnList = 1;
				//echo("alreadyOnList is being set == 1<br>");
				//echo("alreadyOnList == " . $alreadyOnList . "<br>");
			}
	}
	
	//echo("alreadyEnteredToday == " . $alreadyEnteredToday);
	if (@($alreadyEnteredToday == 1)){
		
		echo("<h1 align=center>I'm sorry but you can only enter once a day.</h1>");
		echo("<h2 align=center><a href=../index.html>CLICK HERE TO RETURN HOME</a> </h2>");
		exit();
		
	}
		//echo("alreadyEnteredToday == $alreadyEnteredToday<br>");
   	else{
		//echo("alreadyOnList == " . $alreadyOnList . "<br>");
		if (mysql_query($sql)){
			echo( "<h1 align = center>You have been added for the contest" );
				if ($Mailing_list){
					//echo("alreadyOnList == " . $alreadyOnList);
					if ($alreadyOnList == 1){}
					else{
						$insertMe = "INSERT INTO mailingList SET id = " . ($numMailEntries + 1) . ", " .
							"firstName = '$firstname', lastName = '$lastname', address = '$Address', " .
							"city = '$City', state = '$myState', zip = '$Zip', country = '$Country', " .
							"phone = '$Phone', eMail = '$email', howHeard = '$howHeard', date = '" . date("Y-m-d") . "' ;";
						if (mysql_query($insertMe)){}
						echo(" and the mailing list");
					}
				}
				echo(". Thank you.</h1>");
				echo("<h2 align=center><a href=../index.html>CLICK HERE TO RETURN HOME</a> </h2>");
		}
		else echo("<P>There has been an error. Please click your back arrow and then the submit button again.</P>");
		
   	}
?>
</BODY></HTML>

