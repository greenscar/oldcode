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
    echo( "<P>Unable to locate the " .
          "database at this time.</P>" );
    exit();
  }
?>
<H2 ALIGN = CENTER> The following entries have been removed from the contest: </H2>

<?php

	//CREATE TABLE HEADER
	echo("<TABLE border = 1 align = center width 100% cellpadding=5 cellspacing=5>\n");
	echo("	<THEAD>\n");
	echo("	<tr>\n");
	echo("		<th>ID</th>\n");
	echo("		<th>Name</th>\n");
	echo("		<th>Address</th>\n");
	echo("		<th>City</th>\n");
	echo("		<th>State</th>\n");
	echo("		<th>Zip</th>\n");
	echo("		<th>Country</th>\n");
	echo("		<th>Phone</th>\n");
	echo("		<th>Email</th>\n");
	echo("		<th>How we heard</th>\n");
	if($deleteButton == "REMOVE SELECTED FROM CONTEST"){
		echo("		<th>On Mailing List</th>\n");
	}
	echo("		<th>Date Entered</th>\n");
	echo("	</tr>\n");
	echo("	</THEAD>\n");
	echo("<TBODY>\n");	
	/*
	 *DISPLAY ALL ENTRIES WHOSE BOX WAS CHECKED
	 * THESE ENTRIES ARE BEING DELETED.
	 */
	$result = mysql_query("SELECT * FROM entries");
	if (!$result){
		echo("<P> Error performing query: " .
		mysql_error() . "</P>");
		exit();
	}
	$numresult = mysql_query("SELECT COUNT(*) AS NumEntries ".
							 "FROM entries ORDER BY ID" );  
	
  	$numrow = mysql_fetch_array($numresult);
  	$numentries = $numrow["NumEntries"];
	$totalNumDeleted = 0;
	$numChecking = 1; //checkboxes == id for each row
	while($row = mysql_fetch_array($result)){
		if (isset($$row["id"])){
			echo("<tr>");
    		echo("<td>" . $row["id"] . "</td> \n");
			echo("<td>" .$row["firstName"]. " " . $row["lastName"]. "</td> \n");
    		echo("<td>" . $row["address"] . "</td> \n");
			echo("<td>" . $row["city"] . "</td> \n");
			echo("<td>" . $row["state"] . "</td> \n");
    		echo("<td>" . $row["zip"] . "</td> \n" );
			echo("<td>" . $row["country"] . "</td> \n" );
			echo("<td>" . $row["phone"] . "</td> \n" );
			echo("<td><a href = \" mailto:" . $row["eMail"] . "\">" . $row["eMail"] . "</a></td> \n" );
			echo("<td>" . $row["howHeard"]. "</td> \n" );
			if ($deleteButton == "REMOVE SELECTED FROM CONTEST")
			{
				echo("<td align=\"CENTER\">");
				if($row["onMailList"]) echo("YES");
				else echo("NO");
			}
			echo("<td>" . $row["date"] . "</td> \n" );
			echo("\n</td></tr>");
						
			/*
			 *DEFINE & PERFORM THE DELETE STATEMENT AND
			 * MAKE SURE IT WAS SUCCESSFUL
			 */
		    $sql = "DELETE FROM entries WHERE counter = " . $row["counter"];
			if ( mysql_query($sql) ){
			}
			else {  
				echo("<P> ROW " . $row["counter"] . "COULD NOT BE DELETED." .
				mysql_error() .
				"</P>");
			}
			$totalNumDeleted += 1;


			//RENUMBER AFTER DELETED ONE	
			$renumberSQL = "UPDATE entries SET ID = ID - 1 WHERE counter >= " . $row["counter"];
			if ( mysql_query($renumberSQL) ){
				//echo("<P> ROW " . $kCheck . " HAS BEEN DELETED.</P>");
			}
			else {  
				echo("<P> COULD NOT RENUMBER " . counter . " BECAUSE " .
				mysql_error() .
				"</P>");
			}
		}//end if
		$numChecking ++;
	}//end while
?>
</TBODY>
</TABLE>




<H2 ALIGN = CENTER> Here is your new full list of contest entries: </H2>
<TABLE border = "1" align = "center" width "100%" cellpadding="5" cellspacing="5">
<THEAD>
<tr>
	<th>ID</th>
	<th>Name</th>
	<th>Address</th>
	<th>City</th>
	<th>State</th>
	<th>Zip</th>
	<th>Country</th>
	<th>Phone</th>
	<th>Email</th>
	<th>How we heard</th>
	<th>On Mailing List</th>
	<th>Date Entered</th>
</tr>
</THEAD>

<TBODY>
<?php
	/*
 	 * THE FOLLOWING CODE WILL DO NOTHING BUT DISPLAY THE TABLE
	 * 	TO SHOW THE USER THE RESULTS OF THE DELETIONS.
	 */
    // Request the text of all the info
   	$result = mysql_query("SELECT * FROM entries ORDER BY ID");
  	if (!$result) {
    	echo("<P>Error performing query: " .
        mysql_error() . "</P>");
    	exit();
  	}
  // DISPLAY ENTIRE DATABASE
  while ( $row = mysql_fetch_array($result) ) {
    echo("<tr>");	
    echo("<td>" . $row["id"] . "</td> \n");
	echo("<td>" .$row["firstName"]. " " . $row["lastName"]. "</td> \n");
    echo("<td>" . $row["address"] . "</td> \n");
	echo("<td>" . $row["city"] . "</td> \n");
	echo("<td>" . $row["state"] . "</td> \n");
    echo("<td>" . $row["zip"] . "</td> \n" );
	echo("<td>" . $row["country"] . "</td> \n" );
	echo("<td>" . $row["phone"] . "</td> \n" );
	//DISPLAY THE EMAIL AS A LINK
	echo("<td><a href = \" mailto:" . $row["eMail"] . "\">" . $row["eMail"] . "</a></td> \n" );
	echo("<td>" . $row["howHeard"]. "</td> \n" );
	echo("<td align=\"CENTER\">");
	if($row["onMailList"]) echo("YES");
	else echo("NO");
	echo("<td>" . $row["date"] . "</td> \n" );
	echo("\n</td></tr>");
  }
?>

</TBODY></TABLE>

<P ALIGN = CENTER>
	<h2 align=center>To perform a different search, <a href=../searchpage.html>CLICK HERE</a> </h2>
</P>
</BODY>
</HTML>