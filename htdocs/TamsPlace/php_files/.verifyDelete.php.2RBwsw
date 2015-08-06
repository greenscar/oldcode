<HTML>
<HEAD>
<TITLE> Contest Entries </TITLE>
</HEAD>
<BODY>
<?php
  if ($deleteButton == "UNSELECT ALL")
  {
 	echo("Now returning to list");
  }
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
<H2 ALIGN = CENTER> The following entries have been removed: </H2>
<TABLE border = "1" align = "center" width "100%" cellpadding="5" cellspacing="5">
<THEAD>
<tr>
	<th>ID</th>
	<th>Name</th>
	<th>Address</th>
	<th>City</th>
	<th>State</th>
	<th>Zip</th>
	<th>Phone</th>
	<th>Email</th>
	<th>How we heard</th>
	<th>On Mailing List</th>
</tr>
</THEAD>

<FORM ACTION = "deleteSelected.php" METHOD = "POST">
<TBODY>
<?php
	//Display all entries whose box was checked
	$result = mysql_query("SELECT * FROM entries");
	if (!$result){
		echo("<P> Error performing query: " .
		mysql_error() . "</P>");
		exit();
	}
	for($k = 1; $row = mysql_fetch_array($result); $k++){
		if (isset($$k))	{
			echo("<tr>");
    		echo("<td>" . $row["id"] . "</td> \n");
			echo("<td>" .$row["name"]. "</td> \n");
    		echo("<td>" . $row["address"] . "</td> \n");
			echo("<td>" . $row["city"] . "</td> \n");
			echo("<td>" . $row["state"] . "</td> \n");
    		echo("<td>" . $row["zip"] . "</td> \n" );
			echo("<td>" . $row["phone"] . "</td> \n" );
			//DISPLAY THE EMAIL AS A LINK
			echo("<td><a href = \" mailto:" . $row["email"] . "\">" . $row["email"] . "</a></td> \n" );
			echo("<td>" . $row["howheard"]. "</td> \n" );
			echo("<td align=\"CENTER\">");
			if($row["maillist"]) echo("YES");
			else echo("NO");
			echo("\n</td></tr>");
			$sql = "DELETE entries WHERE" . $row["id"] . "LIKE" .$k;
		}
	}
?>
</TBODY>
</TABLE>
<H2 ALIGN = CENTER> Here is your new full list: </H2>
<?php
    // Request the text of all the info
   	$result = mysql_query("SELECT * FROM entries");
  	if (!$result) {
    	echo("<P>Error performing query: " .
        mysql_error() . "</P>");
    	exit();
  	}
  // DISPLAY ENTIRE DATABASE
  while ( $row = mysql_fetch_array($result) ) {
    echo("<tr>");
    echo("<td>" . $row["id"] . "</td> \n");
	echo("<td>" .$row["name"]. "</td> \n");
    echo("<td>" . $row["address"] . "</td> \n");
	echo("<td>" . $row["city"] . "</td> \n");
	echo("<td>" . $row["state"] . "</td> \n");
    echo("<td>" . $row["zip"] . "</td> \n" );
	echo("<td>" . $row["phone"] . "</td> \n" );
	//DISPLAY THE EMAIL AS A LINK
	echo("<td><a href = \" mailto:" . $row["email"] . "\">" . $row["email"] . "</a></td> \n" );
	echo("<td>" . $row["howheard"]. "</td> \n" );
	echo("<td align=\"CENTER\">");
	if($row["maillist"]) echo("YES");
	else echo("NO");
	echo("\n</td></tr>");
  }
?>
<P ALIGN = CENTER>
<INPUT TYPE = SUBMIT NAME = "deleteButton" VALUE = "BACK TO FULL LIST">
</FORM>
</P>
</BODY>
</HTML>