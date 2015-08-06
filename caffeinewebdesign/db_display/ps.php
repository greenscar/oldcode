<?php

$title = "PSPROD";
include("header.inc");
$tbl_dbmgr = new DB_Mgr("ps"); 
    
//$selectTables = "select name from sysobjects where type='U' and name like 'SI_%'";
$selectTables = "select name from sysobjects where type='U' and name like 'PS_TAX_LOCATION1'";
$tbl_dbmgr->query($selectTables);


echo("<table border=4 align=\"center\">");
echo("<tr valign=\"middle\"><td><h1> <font color=#FFFFFF>The Store Tables</font></h1></td></tr>");
echo("</table>");
while($tbl_dbmgr->fetch_row())
{
	$rowNum = 0;
   $table = trim($tbl_dbmgr->get_field(1));
	echo("<h3>" . $table . "</H3>");
	
   $data_db_mgr = new DB_Mgr("ps");
   $query = "SELECT * FROM " . $table;
   $temp = $data_db_mgr->query($query);
   echo("<TABLE border=1 align=center>");
	for ( $f = 1 ; $f <= $data_db_mgr->get_num_fields(); $f++ ){
      $name = $data_db_mgr->get_field_name($f);
		echo "<td class=\"header\">".$name."</td>";
	}
	
   while($data_db_mgr->fetch_row())
   {
	//while($row = mssql_fetch_row($temp)){
		echo("<tr class=\"");
		if($rowNum++%2 == 0){
			echo("even\">");
		}
      else
         echo("odd\">");
      for($x=1; $x <= $data_db_mgr->get_num_fields(); $x++)
      {
			echo("<TD class=\"data\">" . $data_db_mgr->get_field($x) . "</TD>");
		}
		echo("</tr>");
	}
	echo("</TABLE>");
}
?>
</BODY>
</HTML>
