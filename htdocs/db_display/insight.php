<?php
	/*
  	* This header file connects us to the database which will
  	*  be used.
  	*/
$host_name = "DW";
$user_name = "sa";
$password = "sa";
$database = "InSight";
$row_color = "#999999";
$dbcnx = MSSQL_CONNECT($host_name,$user_name,$password) or DIE("<h1>DATABASE FAILED TO RESPOND.</h1>"); 
if(!mssql_select_db("$database")){
   	echo( "<P>Unable to connect to the database server at this time.</P>");
  	exit();
}
$title = "Your tables";
echo("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 //EN\">\n");
echo("<HTML>\n<HEAD>\n");
echo("<TITLE>$title</TITLE>\n");
echo("<meta http-equiv=\"Content-Type\" CONTENT=\"text/html; charset=iso-8859-1\">\n");
echo("</HEAD>\n");
echo("<BODY background = \"../Logo.jpg\" TEXT=#000000>\n");

//$testTables = array("EXAM", "EXAM_ENTRY", "SECTION_HEADER", "TRUE_FALSE", "ESSAY", "MULT_CHOICE", "MATCHING", "MATCHING_QUESTION", "MATCHING_CHOICE", "WORD_BANK", "WORD_BANK_QUESTION", "WORD_BANK_CHOICE", "FILL_IN_BLANK", "FILL_IN_BLANK_SOLUTION");
$selectTables = "select name from sysobjects where type='U'";// and name like 'SI_%'";
$tableQuery = mssql_query($selectTables);
echo("<table border=4 align=\"center\">");
echo("<tr valign=\"middle\"><td><h1>$title</h1></td></tr>");
echo("</table>");
while($row = mssql_fetch_row($tableQuery)){
//for($i = 0; $i < sizeof($testTables); $i++){
	$rowNum = 0;
	echo("<h3 align=center>" . $row[0] . "</H3>");
	if(strcmp($row[0], "TimeDimension") == 0)
		$query = "SELECT * FROM " . $row[0];
	else
	$query = "SELECT TOP 50 * FROM " . $row[0];
	$temp = mssql_query($query);
	$fields = mssql_num_fields ($temp);
	echo("<TABLE border=1 align=center>");
	for ( $f = 0 ; $f < $fields ; $f++ ){
		$name = mssql_fetch_field($temp, $f);
		echo "<th>".$name->name."</th>";
	}
	while($row = mssql_fetch_row($temp)){
		echo("<tr ");
		if($rowNum++%2 == 0){
			echo("bgcolor=\"$row_color\" ");
		}
		echo("valign=\"top\">");
		for($x=0; $x < sizeof($row); $x++){
			echo("<TD>" . stripslashes($row[$x]) . "</TD>");
		}
		echo("</tr>");
	}
	echo("</TABLE>");
}
?>
</BODY>
</HTML>