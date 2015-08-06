<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class Coverage
{
   function Coverage()
   {
      $this->log = new Secretary();
   }
   var $cov_id;
   var $file_id;
   var $title;
   var $log;
   var $file_name;
   var $client_id;
   
   function dbInsert($dbmgr)
   {
      $this->log->write("Coverage->dbInsert(dbmgr)");
      $insert = "INSERT INTO CP_COVERAGE( USER_ID, FILE_ID, TITLE ) VALUES ("
              . $this->client_id . ", "
              . $this->file_id . ", '"
              . $this->title . "')";
//.*write(.*$.*);
      if(!($dbmgr->query($insert)))
      {
//.*write(.*$.*);
         $this->log->write("Coverage->dbInsert(dbmgr) => FALSE");
         return(false);
      }
      $this->cov_id = $dbmgr->get_last_key();
//.*write(.*$.*);
      return $this->cov_id;
   }
   
   function dbDelete($dbmgr)
   {
      $del = "DELETE FROM CP_COVERAGE WHERE COV_ID = " . $this->cov_id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      return(true);
   }
   
   function dbLoad($dbmgr)
   {
      $this->log->write("Coverage->dbLoad(dbmgr)");
      $sel = "SELECT C.USER_ID, C.FILE_ID, C.TITLE, F.FILE_NAME "
           . " FROM CP_COVERAGE C, FILE F"
           . " WHERE C.COV_ID = " . $this->cov_id
           . " AND C.FILE_ID = F.FILE_ID";
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         $this->log->write("Coverage->dbLoad(dbmgr) => FALSE");
         return(false);
      }
      else
      {
         $row = $dbmgr->fetch_array();
         $this->client_id = $row["USER_ID"];
         $this->file_id = $row["FILE_ID"];
         $this->title = $row["TITLE"];
         $this->file_name = $row["FILE_NAME"];
         $this->log->write("Coverage->dbLoad(dbmgr) => TRUE");
         return(true);
      }
   }
   
   function dbUpdate($dbmgr)
   {
      $this->log->write("Coverage->dbUpdate(dbmgr)");
      $upd = "UPDATE CP_COVERAGE SET"
           . " USER_ID = " . $this->client_id
           . ", FILE_ID = " . $this->file_id
           . ", TITLE = \"" . $this->title . ""
           . "\" WHERE COV_ID = " . $this->cov_id;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         $this->log->write("Coverage->dbUpdate(dbmgr) => FALSE");
         return(false);
      }
//.*write(.*$.*);
      return($this->cov_id);
   }
}
?>