<?php
class User
{
   var $id;
   var $pwd;
   var $first_name;
   var $last_name;
   var $email;
   function User()
   {
   }
   function dbLogin($id, $pwd, $dbmgr)
   {
      $toReturn = false;
      $sel = "SELECT first_name, last_name, email FROM users WHERE id = '"
           . trim($id)
           . "' AND pwd = '" . trim($pwd) . "'";
      $dbmgr->query($sel);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->id = trim($id);
         $this->pwd = trim($pwd);
         $this->first_name = trim($row["first_name"]);
         $this->last_name = trim($row["last_name"]);
         $this->email = trim($row["email"]);
         $toReturn = true;
      }
      return $toReturn;
   }
}
?>