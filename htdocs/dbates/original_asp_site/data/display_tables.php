<html><header><title>DBates Tables</title>

<style type="text/css">
table
{
   background: #444444;
   padding: 5px;
   border: #FF0000 2px dashed;
   margin: 10px;
   
   }
body {
   background: #000000;
   font-family: "new century schoolbook", serif;
   color: #FFFFFF;
}
td.header {
   text-align: center;
   background: #00FF00;
   /*border: 5px solid red;*/
   font-weight: 900;
   font-size: 15pt;
}
td.data {
   text-align: center;
   font-family: Verdana, Serif; 
   font-weight: bold; 
   font-size: 12px;
   font-color: #FFFFFF;
}
tr.odd{
   background: #BBBBBB;
}
tr.even{
   background: #888888;
}
h3 {
   text-align: center;
   background: #00FF00;
   border: 5px solid red;
   font-weight: 900;
   font-size: 25pt;
}
</style>
</header>
<body>
<table width="1000px">
<?php
$database = "..\wwwroot\dbates_orig\data\dbates.mdb";
$conn = new COM("ADODB.Connection");
$conn->Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=$database");

$aLoc = 0;
$rowNum = 0;
$tables = array("ClientTable", "UWTable", "DocTable","SubmissionTable", "ArchiveTable", "MailTable", "AssociateTable", "ActivityLog", "LinkTable");
//$tables = array("ArchiveTable", "MailTable");
for($aLoc = 0; $aLoc < sizeof($tables); $aLoc++)
{
   echo("<tr><td>\n");
   $table = $tables[$aLoc];
   $select = "SELECT * FROM " . $table;
   $rs = $conn->Execute($select) or die("Error in $select<br>");
   $num_columns = $rs->Fields->Count();
   echo("<div class=\"divtable\">\n<table border=\"1\" align=\"left\" width=\"650px\">\n");
   echo("\t<tr><td colspan=\"$num_columns\">\n");
   echo("\t\t<h3>" . $table . "</h3>\n");
   echo("\t</td></tr>\n");
   echo("\t<tr>\n");
   for ($i=0; $i < $num_columns; $i++) {
      $fld[$i] = $rs->Fields($i);
      echo "\t\t<td>".$fld[$i]->name."</td>\n";
   }
   echo("\t</tr>\n");
   $rowNum = 0;
   while ((!$rs->EOF) && ($rowNum < 100))
   {  
      echo("\t<tr class=\"");
      if($rowNum%2 == 0) echo("even\">\n");
      else echo("odd\">\n");
      for ($i=0; $i < $num_columns; $i++)
         echo("\t\t<TD class=\"data\">" . $fld[$i]->value . "</TD>\n");
      echo("\t</tr>\n");
      $rowNum++;            // increments rowcount
      $rs->MoveNext();
   }
   echo("</table>\n</div>\n");
   echo("</td></tr>\n");
}

$rs->Close();
$conn->Close();
$rs = null;
$conn = null;
?>
</table>
</body>
</html>