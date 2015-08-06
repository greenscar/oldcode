<?php

$database = "..\wwwroot\dbates_orig\data\dbates.mdb";
$conn = new COM("ADODB.Connection");
$conn->Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=$database");

$newConn = mysql_connect("server", "c8h10n4o2", "Zoolu4");
mysql_select_db("dbates");

$aLoc = 0;
$rowNum = 0;
//$tables = array("ArchiveTable", "MailTable", "ClientTable", "UWTable", "SubmissionTable", "AssociateTable", "DocTable", "ActivityLog", "LinkTable");

/***********************************************************************************
 * ASSOCIATE TABLE
 **********************************************************************************/
$tables = array("AssociateTable");
for($aLoc = 0; $aLoc < sizeof($tables); $aLoc++)
{
   $table = $tables[$aLoc];
   //$select = "SELECT * FROM " . $table;
   $select = "SELECT ID, Active, DirectLine, Fax, Email, Name, Active FROM AssociateTable";
   $rs = $conn->Execute($select) or die("Error in $select<br>");
   $num_columns = $rs->Fields->Count();
   for ($i=0; $i < $num_columns; $i++) {
      $fld[$i] = $rs->Fields($i);
   }
   //echo("\t</tr>\n");
   $rowNum = 0;
      $del = "DELETE  FROM REP";
      //echo($del);
      mysql_query($del, $newConn) or die(mysql_error() . " in $del<br>");
   while ((!$rs->EOF) && ($rowNum < 100))
   {
      $id = $fld[0]->value;
      $active = $fld[1]->value;
      $phone = str_replace(") ", "-", (str_replace("(", "", (str_replace(".", "-", $fld[2]->value)))));
      $fax = str_replace(") ", "-", (str_replace("(", "", (str_replace(".", "-", $fld[3]->value)))));
      $email = $fld[4]->value;
      $name = $fld[5]->value;
      $active = $fld[6]->value;
      $spaceLoc = strrpos(trim($name), " ");
      $firstName = substr($name, 0, $spaceLoc);
      $lastName = substr($name, $spaceLoc, strlen($name));
      $insert = "INSERT INTO REP(INITIALS, ACTIVE, PHONE, FAX, EMAIL, FIRST_NAME, LAST_NAME) VALUES('"
              . $id . "', '" . $active . "', '" . $phone . "', '"
              . $fax . "', '" . $email . "', '" . $firstName . "', '" . $lastName . "');";
      //echo($insert . "<BR>");
      mysql_query($insert, $newConn) or die(mysql_error() . " in $insert<br>");
      $rowNum++;            // increments rowcount
      $rs->MoveNext();
   }
}
/***********************************************************************************
 * END ASSOCIATE TABLE
 **********************************************************************************/

/***********************************************************************************
 * LINK TABLE
 **********************************************************************************/
$select = "SELECT Address, Description, Title FROM LinkTable";
$rs = $conn->Execute($select) or die("Error in $select<br>");
$num_columns = $rs->Fields->Count();
for ($i=0; $i < $num_columns; $i++) {
   $fld[$i] = $rs->Fields($i);
}
$rowNum = 0;
   $del = "DELETE  FROM LINK";
   //echo($del);
   mysql_query($del, $newConn) or die(mysql_error() . " in $del<br>");
while ((!$rs->EOF) && ($rowNum < 100))
{
   $address = $fld[0]->value;
   $description = $fld[1]->value;
   $title = $fld[2]->value;
   $insert = "INSERT INTO LINK (ADDRESS, DESCRIPTION, TITLE, PUBLIC) VALUES ("
           . " '" . $address . "', '" . $description . "', '" . $title . "', 1)";
   //echo($insert . "<BR>");
   mysql_query($insert, $newConn) or die(mysql_error() . " in $insert<br>");
   $rowNum++;            // increments rowcount
   $rs->MoveNext();
}
/***********************************************************************************
 * END LINK TABLE
 **********************************************************************************/

/***********************************************************************************
 * USER TABLE
 **********************************************************************************/
$select = "SELECT ID, Name, ContactEmail, ContactName, ContactPhone FROM ClientTable";
$rs = $conn->Execute($select) or die("Error in $select<br>");
$num_columns = $rs->Fields->Count();
for ($i=0; $i < $num_columns; $i++) {
   $fld[$i] = $rs->Fields($i);
}
$rowNum = 0;
$del = "TRUNCATE TABLE USER";
mysql_query($del, $newConn) or die(mysql_error() . " in $del<br>");
while ((!$rs->EOF) && ($rowNum < 100))
{
   $id = $fld[0]->value;
   $uName = $fld[1]->value;
   $email = $fld[2]->value;
   $cName = $fld[3]->value;
   $cPhone = str_replace(") ", "-", (str_replace("(", "", (str_replace(".", "-", $fld[4]->value)))));
   $insert = "INSERT INTO USER (USER_NAME, NAME, CONTACT, PHONE, EMAIL, ACTIVE) VALUES ("
           . " '" . $id . "', '" . $uName . "', '" . $cName . "', '" . $cPhone . "', '" . $email . "', '1')";
   //echo($insert . "<BR>");
   mysql_query($insert, $newConn) or die(mysql_error() . " in $insert<br>");
   $rowNum++;            // increments rowcount
   $rs->MoveNext();
}
/***********************************************************************************
 * END CLIENT TABLE
 **********************************************************************************/
$rs->Close();
$conn->Close();
$rs = null;
$conn = null;
header("Location: display_table_data.php");
?>
