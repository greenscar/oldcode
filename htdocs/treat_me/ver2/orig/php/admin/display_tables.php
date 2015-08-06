<HTML>
<HEAD>
<TITLE>
Your tables
</TITLE>
</HEAD>
<BODY>
<?php
include("../header.inc");
//require("./inc_files/Person.php");
//require_once("./inc_files/check_session.inc");
//require_once("./inc_files/html_header.inc");

$tables = mysql_list_tables($DBName);
//$tables = array("question_type_def", "test_header_def", "emp_def", "question_def", "sec_lvl_def", "question_solution_dtl", "test_taken_dtl", "student_answer_dtl", "test_category_def");
//$tables = array("question_type_def", "question_def","question_solution_dtl");
while($a_table = mysql_fetch_row($tables)){	
	echo("<h1 align=center>" . $a_table[0] . "</H1>");
	$temp = mysql_query("SELECT * FROM " . $a_table[0]);
	$fields = mysql_num_fields ($temp);
	echo("<TABLE border=1 align=center>");
	for ( $f = 0 ; $f < $fields ; $f++ ){
		$name = mysql_fetch_field($temp, $f);
		echo "<th>".$name->name."</th>";
	}
	
	while($row = mysql_fetch_row($temp)){
		echo("<tr valign=\"top\">");
		for($x=0; $x < sizeof($row); $x++){
			echo("<TD>" . stripslashes($row[$x]) . "</TD>");
		}
		echo("</tr>");
	}
	echo("</TABLE>");
}
echo("<P ALIGN=CENTER><INPUT TYPE=\"BUTTON\" VALUE=\"create_tables\" onClick=\"window.location='./create_tables.php'\"><p>\n");
?>
</BODY>
</HTML>
