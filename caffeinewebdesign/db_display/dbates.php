<?php

$title = "DBATES";
include("header.inc");
$dbmgr = new DB_Mgr("dbates");

echo("<table border=4 align=\"center\">");
echo("<tr valign=\"middle\"><td><h1> <font color=#FFFFFF>DBates Tables</font></h1></td></tr>");
echo("</table>");
$dbmgr->set_table_list();
$rowNum = 0;
while ($row = $dbmgr->fetch_row()){
	$tables[$rowNum] = $row[0];
	$rowNum++;
}

for($i=0; $i < sizeof($tables); $i++)
{
	echo("<h3>" . $tables[$i] . "</h3>");
	$q = "SELECT * FROM " . $tables[$i];
	$temp = $dbmgr->query($q);
	echo("<TABLE border=1 align=center>\n");
	echo("\t<tr>\n");
	for ( $f = 0 ; $f < $dbmgr->get_num_fields(); $f++ ){
      $name = $dbmgr->get_field_name($f);
		echo "\t\t<td class=\"header\">".$name."</td>\n";
	}
	echo("\t</tr>\n");
	echo("\t<tr>\n");
	while($row = $dbmgr->fetch_row())
	{
		echo("<tr class=\"");
		if($rowNum++%2 == 0){
			echo("even\">");
		}
      else
         echo("odd\">");
      for($x=0; $x < $dbmgr->get_num_fields(); $x++)
      {
			echo("<TD class=\"data\">" . $row[$x] . "</TD>");
		}
		echo("</tr>");
	}
	echo("\t</tr>\n");
	echo("</table>\n");
}



/*

while($tbl_dbmgr->fetch_row())
{
	$rowNum = 0;
   $table = trim($tbl_dbmgr->get_field(1));
	echo("<h3>" . $table . "</H3>");
	
   $dbmgr = new DB_Mgr("web");
   $query = "SELECT * FROM " . $table;
   $temp = $dbmgr->query($query);
   echo("<TABLE border=1 align=center>");
	for ( $f = 1 ; $f <= $dbmgr->get_num_fields(); $f++ ){
      $name = $dbmgr->get_field_name($f);
		echo "<td class=\"header\">".$name."</td>";
	}
	
   while($dbmgr->fetch_row())
   {
	//while($row = mssql_fetch_row($temp)){
		echo("<tr class=\"");
		if($rowNum++%2 == 0){
			echo("even\">");
		}
      else
         echo("odd\">");
      for($x=1; $x <= $dbmgr->get_num_fields(); $x++)
      {
			echo("<TD class=\"data\">" . $dbmgr->get_field($x) . "</TD>");
		}
		echo("</tr>");
	}
	echo("</TABLE>");
}
*/
?>
</BODY>
</HTML>
