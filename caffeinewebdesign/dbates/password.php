<?
   include("./classes/DB_Mgr.inc");
   $dbmgr = new DB_Mgr("dbates");
   $dbmgr2 = new DB_Mgr("dbates");
   $q = "SELECT USER_ID, USER_NAME, PASSWORD FROM USER WHERE USER_NAME != 'jsandlin'";
   $dbmgr->query($q);
   if(!($dbmgr->query($q)))
         return("ERROR in $q<BR>");
   for($i=0; $row = $dbmgr->fetch_row(); $i++)
   {
      echo($row[0] . " = " . $row[1] . " = " . $row[2]. "<BR>");
      $newPwd = crypt($row[2]);
      $upd = "UPDATE USER SET PASSWORD = '$newPwd' WHERE USER_ID = " . $row[0];
      //$dbmgr2->query($upd) or die(mssql_error());
      echo($upd . "<BR>");
   }
  ?> 
   <?php
/*
   function setPassword($pwd)
   {
      $this->password = crypt($pwd);
      //$this->password = $this->encryptPassword($pwd);
   }
   function checkPassword($inputPwd)
   {
      $this->log->write("Security->checkPassword($inputPwd, $compareTo)");
      return(crypt($inputPwd, $pwdFromDB) == $pwdFromDB);
   }
   
   
$password = "Zoolu4Zoolu4Zoolu4";

// Not using any salts
echo("old password = $password<BR>");

$pwdFromDB = crypt($password);
echo("password from db = $pwdFromDB<br>");
// Now do the comparison

//$shortPass = substr($password, 0, 8);
$shortPass = $password;
echo("shortPass = $shortPass<br>");
if (crypt( $shortPass,  $pwdFromDB ) == $pwdFromDB )
   echo "The passwords match";
else
   echo "The passwords do not match";
*/
?>