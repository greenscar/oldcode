<HTML>
<HEAD>
<TITLE> Contest Entries </TITLE>
</HEAD>
<BODY BACKGROUND="../imshome/laceback.jpg">
<?php
  // Connect to the database server  
  @$dbcnx = mysql_connect("localhost", "tamsplace", "tam7739");  
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

	@$result = mysql_query("SELECT * FROM test ORDER BY date");
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
	//if($email == 'email')	
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
	//if($email == 'email')	
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

