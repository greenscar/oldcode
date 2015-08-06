<HTML>
<HEAD>
<TITLE> Contest Entries </TITLE>
</HEAD>
<BODY BACKGROUND="../imshome/laceback.jpg">
<?php
  // Connect to the database server  
  @$dbcnx = mysql_connect("localhost", $id, $pwd);  
  if (!@$dbcnx) { 
   echo( "<P>Unable to connect to the " .
          "database server at this time.</P>" );
    exit();
  }


  // Select the contest database
  if (! @mysql_select_db("tamsplace") ) {
    //echo( "<P>Unable to locate the mailingList " .
      //    "database at this time.</P>" );
    //exit();
  }
?>

<?php
	if (@$search == "Search Mailing List"){
		if (@$dataToSearch == "Name"){
			echo("<FORM ACTION = \"deleteFromMailingList.php\" METHOD = \"POST\">\n");
			@$result = mysql_query("SELECT * FROM mailingList WHERE lastName LIKE  \"%" . $searchFor . "%\"");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM mailingList WHERE lastName LIKE  \"%" . $searchFor . "%\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			echo("<h1 align=center>All ". $count ." on the mailing list with a last name like " . $searchFor . "</h1>");
		}
		else if (@$dataToSearch == "emailAddress"){
			echo("<FORM ACTION = \"deleteFromMailingList.php\" METHOD = \"POST\">\n");
			@$result = mysql_query("SELECT * FROM mailingList WHERE eMail LIKE  \"%" . $searchFor . "%\"");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM mailingList WHERE eMail LIKE  \"%" . $searchFor . "%\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			echo("<h1 align=center>All $count on the mailing list with address like " . $searchFor . "</h1>");
		}
		else if (@$dataToSearch == "date"){
			echo("<FORM ACTION = \"deleteFromMailingList.php\" METHOD = \"POST\">\n");
			@$result = mysql_query("SELECT * FROM mailingList WHERE date = \"" . $searchFor . "\"");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM mailingList WHERE date = \"" . $searchFor . "\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			echo("<h1 align=center>Here are all $count who entered your mailing list on " . $searchFor . "</h1>");
		}		
		else {//($dataToSearch == "entryNumber"){
			echo("<FORM ACTION = \"deleteFromMailingList.php\" METHOD = \"POST\">\n");
			@$result = mysql_query("SELECT * FROM mailingList WHERE id = " . $searchFor);
			echo("<h1 align=center>Here is you mailing list id " . $searchFor . "</h1>");
		}
	}
	else if (@$search == "Search Contest"){
		if (@$dataToSearch == "Name"){
			echo("<FORM ACTION = \"deleteEntries.php\" METHOD = \"POST\">\n");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM entries WHERE lastName LIKE  \"%" . $searchFor . "%\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			@$result = mysql_query("SELECT * FROM entries WHERE lastName LIKE \"%" . $searchFor . "%\"");
			echo("<h1 align=center>All $count contest entries with last name like " . $searchFor . "</h1>");
		}
		else if (@$dataToSearch == "emailAddress"){
			echo("<FORM ACTION = \"deleteEntries.php\" METHOD = \"POST\">\n");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM entries WHERE eMail LIKE  \"%" . $searchFor . "%\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			@$result = mysql_query("SELECT * FROM entries WHERE eMail LIKE \"%" . $searchFor . "%\"");
			echo("<h1 align=center>All $count contest entries with email address like " . $searchFor . "</h1>");
		}
		else if (@$dataToSearch == "date"){
			echo("<FORM ACTION = \"deleteEntries.php\" METHOD = \"POST\">\n");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM entries WHERE date = \"" . $searchFor . "\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			@$result = mysql_query("SELECT * FROM entries WHERE date = \"" . $searchFor . "\"");
			echo("<h1 align=center>All $count contest entries who entered on " . $searchFor . "</h1>");
		}
		else {//($dataToSearch == "entryNumber"){
			echo("<FORM ACTION = \"deleteEntries.php\" METHOD = \"POST\">\n");
			@$result = mysql_query("SELECT * FROM entries WHERE id = " . $searchFor);
			echo("<h1 align=center>Here is your contest entry of id " . $searchFor . "</h1>");
		}
	}	
	else if (@$search == "Search Fenton Mailing List"){
		if (@$dataToSearch == "Name"){
			echo("<FORM ACTION = \"deleteFromFentonMailingList.php\" METHOD = \"POST\">\n");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM fentonMailingList WHERE lastName LIKE  \"%" . $searchFor . "%\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			@$result = mysql_query("SELECT * FROM fentonMailingList WHERE lastName LIKE \"%" . $searchFor . "%\"");
			echo("<h1 align=center>All $count Julie Fenton Young Updates entries with last name like " . $searchFor . "</h1>");
		}
		else if (@$dataToSearch == "emailAddress"){
			echo("<FORM ACTION = \"deleteFromFentonMailingList.php\" METHOD = \"POST\">\n");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM fentonMailingList WHERE eMail LIKE  \"%" . $searchFor . "%\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			@$result = mysql_query("SELECT * FROM fentonMailingList WHERE eMail LIKE \"%" . $searchFor . "%\"");
			echo("<h1 align=center>All $count Julie Fenton Young Updates entries with email address like " . $searchFor . "</h1>");
		}
		else if (@$dataToSearch == "date"){
			echo("<FORM ACTION = \"deleteFromFentonMailingList.php\" METHOD = \"POST\">\n");
			@$numresult = mysql_query("SELECT COUNT(*) AS num FROM fentonMailingList WHERE date = \"" . $searchFor . "\"");
  			$numrow = mysql_fetch_array($numresult);
  			$count = $numrow["num"];
			@$result = mysql_query("SELECT * FROM fentonMailingList WHERE date = \"" . $searchFor . "\"");
			echo("<h1 align=center>All $count Julie Fenton Young Updates entries who entered on " . $searchFor . "</h1>");
		}
		else {//($dataToSearch == "entryNumber"){
			echo("<FORM ACTION = \"deleteFromFentonMailingList.php\" METHOD = \"POST\">\n");
			@$result = mysql_query("SELECT * FROM fentonMailingList WHERE id = " . $searchFor);
			echo("<h1 align=center>Here is your Julie Fenton Young Updates entry of id " . $searchFor . "</h1>");
		}
	}
	//CREATE PAGE HEADER
	else if (@$createList == "List Everyone On Mailing List"){
		@$numresult = mysql_query("SELECT COUNT(*) AS num FROM mailingList");
  		$numrow = mysql_fetch_array($numresult);
  		$count = $numrow["num"];
		echo("<FORM ACTION = \"deleteFromMailingList.php\" METHOD = \"POST\">");
		echo("<h1 align=center>Here Are All $count Mailing List Entries in order of " . $mailOrderedBy . ":</h1>");
		if ($mailOrderedBy == "name"){
			@$result = mysql_query("SELECT * FROM mailingList ORDER BY lastName");
		}
		else if($mailOrderedBy == "state"){
			@$result = mysql_query("SELECT * FROM mailingList ORDER BY state");
		}
		else if($mailOrderedBy == "email"){
			@$result = mysql_query("SELECT * FROM mailingList ORDER BY eMail");
		}
		else /*($fullOrderedBy == "date")*/{
			@$result = mysql_query("SELECT * FROM mailingList ORDER BY date");
		}
	}
	
	else if (@$createList == "List Everyone On Fenton Mailing List"){
		@$numresult = mysql_query("SELECT COUNT(*) AS num FROM fentonMailingList");
  		$numrow = mysql_fetch_array($numresult);
  		$count = $numrow["num"];
		echo("<FORM ACTION = \"deleteFromFentonMailingList.php\" METHOD = \"POST\">");
		echo("<h1 align=center>Here Are All $count Fenton Mailing List Entries in order of " . $fentonOrderedBy . ":</h1>");
		if ($fentonOrderedBy == "name"){
			@$result = mysql_query("SELECT * FROM fentonMailingList ORDER BY lastName");
		}
		else if($fentonOrderedBy == "state"){
			@$result = mysql_query("SELECT * FROM fentonMailingList ORDER BY state");
		}
		else if($fentonOrderedBy == "email"){
			@$result = mysql_query("SELECT * FROM fentonMailingList ORDER BY eMail");
		}
		else /*($fentonOrderedBy == "date")*/{
			@$result = mysql_query("SELECT * FROM fentonMailingList ORDER BY date");
		}
	}
	else {//if ($createList == "List Current Contest Entries"){
		@$numresult = mysql_query("SELECT COUNT(*) AS num FROM entries");
  		$numrow = mysql_fetch_array($numresult);
  		$count = $numrow["num"];
		echo("<FORM ACTION = \"deleteEntries.php\" METHOD = \"POST\">");
		echo("<h1 align=center>Here Are All $count Current Contest Entries in order of " . $fullOrderedBy . ":</h1>");
		if ($fullOrderedBy == "name"){
			@$result = mysql_query("SELECT * FROM entries ORDER BY lastName");
		}
		else if($fullOrderedBy == "state"){
			@$result = mysql_query("SELECT * FROM entries ORDER BY state");
		}
		else if($fullOrderedBy == "email"){
			@$result = mysql_query("SELECT * FROM entries ORDER BY eMail");
		}
		else /*($fullOrderedBy == "date")*/{
			@$result = mysql_query("SELECT * FROM entries ORDER BY date");
		}
	}
	
	//CREATE TABLE HEADER
	echo("<TABLE border = 1 align = center width 100% cellpadding=5 cellspacing=5>\n");
	echo("	<THEAD>\n");
	echo("	<tr>\n");
	echo("		<th></th>\n");
	echo("		<th>ID</th>\n");
	echo("		<th>Name</th>\n");
	if($street == 'street')	
		echo("		<th>Address</th>\n");
	if ($csz == 'csz')	{	
		echo("		<th>City</th>\n");
		echo("		<th>State</th>\n");
		echo("		<th>Zip</th>\n");
		echo("		<th>Country</th>\n");
	}
	if($phone == 'phone')
		echo("		<th>Phone</th>\n");
	if($email == 'email')	
		echo("		<th>Email</th>\n");
	if($reference == 'reference')
		echo("		<th>How we heard</th>\n");
	if((@$search == "Search Contest") or (@$createList == "List Current Contest Entries")){
		echo("		<th>On Mailing List</th>\n");
	}
	if($datejoin == 'datejoin')
		echo("		<th>Date Entered</th>\n");
	echo("	</tr>\n");
	echo("	</THEAD>\n");
	echo("<TBODY>\n");
	if (!$result) {
    //	echo("<P>Error performing query: " .
      //  mysql_error() . "</P>");
    	//exit();
  	}
  // DISPLAY SELECTED ENTRIES
  while ( @$row = mysql_fetch_array($result) ) {
    echo("<tr>");
	echo("<td> <INPUT NAME = \"" . $row["id"] . "\" TYPE = \"checkbox\" ></td>");
    echo("<td>" . $row["id"] . "</td> \n");
	echo("<td>" .$row["firstName"]. " " . $row["lastName"]. "</td> \n");
    if($street == 'street')	
		echo("<td>" . $row["address"] . "</td> \n");
	if ($csz == 'csz')	{	
		echo("<td>" . $row["city"] . "</td> \n");
		echo("<td>" . $row["state"] . "</td> \n");
    	echo("<td>" . $row["zip"] . "</td> \n" );
		echo("<td>" . $row["country"] . "</td> \n" );
	}
	if($phone == 'phone')
		echo("<td>" . $row["phone"] . "</td> \n" );
	//DISPLAY THE EMAIL AS A LINK
	if($email == 'email')	
		echo("<td><a href = \" mailto:" . $row["eMail"] . "\">" . $row["eMail"] . "</a></td> \n" );
	if($reference == 'reference')
		echo("<td>" . $row["howHeard"]. "</td> \n" );
	
	if (((@$search == "Search Contest") or (@$createList == "List Current Contest Entries"))){
		echo("<td align=\"CENTER\">");
		if($row["onMailList"]) echo("YES");
		else echo("NO");
	}
	if($datejoin == 'datejoin')
		echo("<td>" . $row["date"] . "</td> \n" );
	echo("\n</td></tr>");
  }
echo("</TBODY></TABLE><P ALIGN = CENTER>");
if ((@$search == "Search Mailing List") or (@$createList == "List Everyone On Mailing List")){
	echo("<INPUT TYPE = SUBMIT NAME = \"deleteButton\" VALUE = \"REMOVE SELECTED FROM MAILING LIST\">");
}
else if((@$search == "Search Contest") or (@$createList == "List Current Contest Entries")){
	echo("<INPUT TYPE = SUBMIT NAME = \"deleteButton\" VALUE = \"REMOVE SELECTED FROM THE CONTEST\">");
}
else if((@$search == "Search Fenton Mailing List") or (@$createList == "List Everyone On Fenton Mailing List")){
	echo("<INPUT TYPE = SUBMIT NAME = \"deleteButton\" VALUE = \"REMOVE SELECTED FROM FENTON MAILING LIST\">");
}
echo("</P></FORM>");
?>

<P ALIGN = CENTER>
	<h2 align=center>To perform a different search, <a href=../searchpage.html>CLICK HERE</a> </h2>
</P>
</BODY>
</HTML>

