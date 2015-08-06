<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Root.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/User.inc");
class Security
{
   var $log;
   function Security()
   {
      $this->log = new Secretary();
   }
   function dbLoadUser($dbmgr, $id)
   {
      
//.*write(.*$.*);
      $sel = "SELECT S.SEC_LVL_NAME, S.SEC_LVL_ID "
           . "FROM USER U, USER_SEC_LVL S  WHERE USER_ID = " . $id
           . " AND S.SEC_LVL_ID = U.SEC_LVL_ID";
//.*write(.*$.*);
      //return($dbmgr->query($sel));
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_array();
      $sec_lvl_name = $row["SEC_LVL_NAME"];
      if(strcmp($sec_lvl_name, "CLIENT") == 0)
      {
         $this->log->write("CREATING NEW CLIENT");
         $u = new Client();
         $u->id = $id;
         $u->sec_lvl_id = $row["SEC_LVL_ID"];
         $u->sec_lvl_name = $sec_lvl_name;
         $u->dbLoad($dbmgr);
      }
      else if(strcmp($sec_lvl_name, "ADMIN") == 0)
      {
         $this->log->write("CREATING NEW ADMIN");
         $u = new Admin();
         $u->id = $id;
         $u->sec_lvl_id = $row["SEC_LVL_ID"];
         $u->sec_lvl_name = $sec_lvl_name;
         $u->dbLoad($dbmgr);
      }
      else if(strcmp($sec_lvl_name, "ROOT") == 0)
      {
         $this->log->write("CREATING NEW ROOT");
         $u = new Root();
         $u->id = $id;
         $u->sec_lvl_id = $row["SEC_LVL_ID"];
         $u->sec_lvl_name = $sec_lvl_name;
         $u->dbLoad($dbmgr);
      }
      return $u;
   }
   
   function dbLoginUser($_SESSION, $dbmgr, $userName, $pwd)
   {
//.*write(.*$.*);
      $sel = "SELECT U.USER_ID, U.PASSWORD, S.SEC_LVL_NAME "
           . "FROM USER U, USER_SEC_LVL S WHERE U.USER_NAME = "
           . "'" . $userName . "' "
           . "AND S.SEC_LVL_ID = U.SEC_LVL_ID";
//.*write(.*$.*);
      //return($dbmgr->query($sel));
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      if($row = $dbmgr->fetch_array())
      {  
         if($this->checkPassword($pwd, $row["PASSWORD"]))
         {
            $sec_lvl_name = $row["SEC_LVL_NAME"];
//.*write(.*$.*);
            if(strcmp($sec_lvl_name, "CLIENT") == 0)
            {
               $this->log->write("CREATING NEW CLIENT");
               $u = new Client();
               $u->id = $row["USER_ID"];
               $u->password = $pwd;
               $u->userName = $userName;
               $u->dbLoad($dbmgr);
            }
            else if(strcmp($sec_lvl_name, "ADMIN") == 0)
            {
               $this->log->write("CREATING NEW ADMIN");
               $u = new Admin();
               $u->id = $row["USER_ID"];
               $u->password = $pwd;
               $u->userName = $userName;
               $u->dbLoad($dbmgr);
            }
            else if(strcmp($sec_lvl_name, "ROOT") == 0)
            {
               $this->log->write("CREATING NEW ROOT");
               $u = new Root();
               $u->id = $row["USER_ID"];
               $u->password = $pwd;
               $u->userName = $userName;
               $u->dbLoad($dbmgr);
            }
            $_SESSION["user"] = $u;
            $this->log->write("Security->dbLoginUser(dbmgr) => TRUE");
            return(true);
         }
         else
         {     
            $this->log->write("Security->dbLoginUser(dbmgr) => FALSE");
            return(false);
         }
      }
      else
      {
         $this->log->write("Security->dbLoginUser(dbmgr) => FALSE");
         return(false);
      }
   }
   function encryptPassword($pwd)
   {
      //return $pwd;
      return crypt($pwd);
   }
   function checkPassword($inputPwd, $pwdFromDB)
   {
//.*write(.*$.*);
      $toReturn = crypt($inputPwd, $pwdFromDB) == $pwdFromDB;
//.*write(.*$.*);
      return($toReturn);
      //return strcmp($pwdFromDB, $inputPwd) == 0;
   }
   function user_is_admin($user)
   {
      if(is_a($user, "Admin"))
      {
         return(true);
      }
      else if(is_a($user, "Root"))
      {
         return(true);
      }
      else
      {
         return(false);
      }
   }
   function user_is_root($user)
   {
      if(is_a($user, "Root"))
      {
         return(true);
      }
      else
      {
         return(false);
      }
   }
   function user_is_user($user)
   {
      if(is_a($user, "User"))
      {
         return(true);
      }
      else
      {
         return(false);
      }
   }
   function user_is_sa_user($user)
   {
      if((is_a($user, "User")) && ($user->id == 14))
      {
//.*write(.*$.*);
         return(true);
      }
      else
      {
//.*write(.*$.*);
         return(false);
      }
   }
   function session_get_client($_SESSION)
   {
//.*write(.*$.*);
      if(isset($_SESSION["user"]))
      {
         if($this->user_is_user($_SESSION["user"]))
         {
//.*write(.*$.*);
            return $_SESSION["user"];
         }
      }
//.*write(.*$.*);
      return(false);
   }
   function session_get_admin($_SESSION)
   {
//.*write(.*$.*);
      if(isset($_SESSION["user"]))
      {
         if($this->user_is_admin($_SESSION["user"]))
         {
//.*write(.*$.*);
            return $_SESSION["user"];
         }
      }
//.*write(.*$.*);
      return(false);
   }
   function session_get_root($_SESSION)
   {
//.*write(.*$.*);
      if(isset($_SESSION["user"]))
      {
         if($this->user_is_root($_SESSION["user"]))
         {
//.*write(.*$.*);
            return $_SESSION["user"];
         }
      }
//.*write(.*$.*);
      return(false);
   }
   function destroy_session($_SESSION)
   {
      $_SESSION = array();
      session_destroy();
      if(!empty($_SESSION["user"]))
         return false;
      else
         return true;
   }
}
?>