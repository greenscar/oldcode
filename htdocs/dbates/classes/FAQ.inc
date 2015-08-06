<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class FAQ
{
   var $id;
   var $question;
   var $solution;
   var $log;
   
   function FAQ()
   {
      $this->log = new Secretary();
   }
   
   function dbUpdate($dbmgr)
   {
      $this->log->write("FAQ->dbUpdate(dbmgr)");
      $upd = "UPDATE FAQ SET "
           . "QUESTION = '" . $this->question
           . "', SOLUTION = '" . $this->solution
           . "' WHERE FAQ_ID = " . $this->id;
//.*write(.*$.*);
      $rs = $dbmgr->query($upd);
      if(!$rs)
      {
//.*write(.*$.*);
         return(false);
      }
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $this->log->write("FAQ->dbInsert(dbmgr)");
      $ins = "INSERT INTO FAQ (QUESTION, SOLUTION)"
           . "VALUES "
           . "('" . $this->question . "', '" . $this->solution . "');";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
   function dbDelete($dbmgr)
   {
      $this->log->write("FAQ->dbDelete(dbmgr)");
      $del = "DELETE FROM FAQ WHERE FAQ_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
   }
   function dbLoad($dbmgr)
   {
      $this->log->write("FAQ->dbLoad(dbmgr)");
      $load = "SELECT QUESTION, SOLUTION FROM FAQ WHERE FAQ_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($load)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_row();
      $this->question = $row[0];
      $this->solution = $row[1];
      return $this->id;
   }
}
?>