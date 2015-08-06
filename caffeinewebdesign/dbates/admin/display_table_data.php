<?php
    include("ensure_admin.inc");
?>
<?php

$title = "DBATES";
include("html_header.inc");
$dbmgr = new DB_Mgr("dbates");
?>

<input type="Button" name="Main Menu" value="Main Menu" onClick="location.href='index.php'">
<?
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
	?>
	
<input type="Button" name="Main Menu" value="Main Menu" onClick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
	<?
}
?>


<input type="Button" name="Main Menu" value="Main Menu" onClick="location.href='index.php';" onmouseover="this.className='submitButton_hover';" onmouseout="this.className='submitButton';">
</BODY>
</HTML>
