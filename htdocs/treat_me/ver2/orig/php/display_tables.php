<?php
include("header.inc");
$title = "Your tables";
$result = mysql_list_tables($DBName);
if (!$result) {
	print "DB Error, could not list tables\n";
	print 'MySQL Error: ' . mysql_error();
	exit;
}
$x = 0;
while ($row = mysql_fetch_row($result)) {
	$tables[$x] = $row[0];
	$x++;
}
mysql_free_result($result);

//ables = array("matching_def", "question_type_def", "test_header_def", "emp_def", "question_def", "test_taken_dtl", "sec_lvl_def", "test_solution_dtl", "student_answer_dtl", "test_category_def");

for($i = 0; $i < sizeof($tables); $i++){
	echo("<h1 align=center>" . $tables[$i] . "</H1>");
	$temp = mysql_query("SELECT * FROM " . $tables[$i]);
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
?>