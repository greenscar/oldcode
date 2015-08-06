<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class User
{
   var $log;
   var $id;
   var $user_name;
   var $password;
   var $name;
   var $phone;
   var $email;
   var $active;
   var $sec_lvl_id;
   var $sec_lvl_name;
   
   var $newsList;
   function logValues()
   {
      $this->log->write("id = " . $this->id . "\n"
                        . "user_name = " . $this->user_name . "\n"
                        . "name = " . $this->name . "\n"
                        . "password = " . $this->password . "\n"
                        . "phone = " . $this->phone . "\n"
                        . "email = " . $this->email . "\n"
                        . "active = " . $this->active . "\n"
                        . "sec_lvl_id = " . $this->sec_lvl_id . "\n"
                        . "sec_lvl_name = " . $this->sec_lvl_name);
   }
   function User()
   {
      $this->log = new Secretary();
   }
   function isActive()
   {
      if($this->active) $toReturn = "YES";
      else $toReturn = "NO";
//.*write(.*$.*);
      return $toReturn;
   }
   function dbUpdate($dbmgr)
   {
      $this->log->write("Client->dbUpdate(dbmgr)");
      if(empty($this->id)) return false;
      $upd = "UPDATE USER SET "
           . " USER_NAME = '" . $this->user_name;
           if($this->password != '')
           $upd .= "', PASSWORD = '" . $this->password;
           $upd .= "', NAME = '" . $this->name
           . "', CONTACT = '" . $this->contact
           . "', PHONE = '" . $this->phone
           . "', EMAIL = '" . $this->email
           . "', ACTIVE = '" . $this->active
           . "', SEC_LVL_ID = '" . $this->sec_lvl_id
           . "' WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
   }
   function dbDelete($dbmgr)
   {
      $del = "DELETE FROM USER WHERE USER_ID = " . $this->id;
      $del_lead = "DELETE FROM LEAD WHERE USER_ID = " . $this->id;
      $del_rep = "DELETE FROM CLIENT_REP WHERE USER_ID = " . $this->id;
      $del_pro = "DELETE FROM CLIENT_PRODUCER WHERE USER_ID = " . $this->id;
      if(!($dbmgr->query($del_lead)))
            return("ERROR in $del_lead<BR>");
      if(!($dbmgr->query($del_rep)))
            return("ERROR in $del_rep<BR>");
      if(!($dbmgr->query($del_pro)))
            return("ERROR in $del_pro<BR>");
      if(!($dbmgr->query($del)))
            return("ERROR in $del<BR>");
      return true;
   }
   function deActivate($dbmgr)
   {
      $this->log->write("User->deActivate(dbmgr)");
      $upd = "UPDATE CLIENT SET ACTIVE = '0' WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(mysql_error() . " in $upd<BR>");
      }
      return(true);
   }
   function reActivate($dbmgr)
   {
      $upd = "UPDATE CLIENT SET ACTIVE = '1' WHERE USER_ID = " . $this->id;
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(mysql_error() . " in $upd<BR>");
      }
      return(true);
   }
   function dbLoadName($dbmgr)
   {
      $this->log->write("Client->dbLoadName(dbmgr)");
      $sel = "SELECT NAME FROM USER WHERE USER_ID = " . $this->id;
//.*write(.*$.*);
      //return($dbmgr->query($sel));
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_row();
      $this->name = $row[0];
//.*write(.*$.*);
   }
   
   /*********************************************
    * FOR ENCRYPTED PASSWORDS
    ********************************************/
   function resetPassword()
   {
      if($this->id == 14)
         $this->setPassword("account");
      else
         $this->setPassword("password");
   }
   function setPassword($pwd)
   {
//.*write(.*$.*);
      $this->password = crypt($pwd);
   }
   function checkPassword($inputPwd)
   {
//.*write(.*$.*);
      //return(strcmp($inputPwd, $this->password) == 0);
      return(crypt($inputPwd, $this->password) == $this->password);
   }
   /*********************************************
    * END FOR ENCRYPTED PASSWORDS
    ********************************************/
}
?>