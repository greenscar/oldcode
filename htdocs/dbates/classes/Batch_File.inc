<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class Batch_File
{
   var $log;
   var $id;
   var $title; // Max Length 20
   var $file_name;
   var $client_id;
   function Batch_File()
   {
      $this->log = new Secretary();
   }
   function delete($dbmgr, $dir)
   {
      $res = $this->dbDelete($dbmgr);
      if($res)
      {
//.*write(.*$.*);
         $x = unlink($dir . $this->file_name);
//.*write(.*$.*);
         return(true);
      }
      else
      {
//.*write(.*$.*);
         return($res);
      }
   }
   function dbDelete($dbmgr)
   {
      $this->log->write("Batch_File->dbDelete(dbmgr)");
      $del = "DELETE FROM BFCP_FILE "
           . " WHERE BFCP_FILE_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $this->log->write("Batch_File->dbInsert(dbmgr)");
      $ins = "INSERT INTO BFCP_FILE (USER_ID, FILE_NAME, TITLE) "
           . "VALUES (" . $this->client_id . ", '" . $this->file_name . "', '" . $this->file_name . "');";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
   function dbUpdate($dbmgr)
   {
      $this->log->write("Batch_File->dbUpdate(dbmgr)");
      $upd = "UPDATE BFCP_FILE SET "
           . " TITLE = '" . $this->title . "' ";
      if(isset($this->file_name))
      {
         $upd .= ", FILE_NAME = '" . $this->file_name . "' ";
      }
      if(isset($this->client_id))
      {
         $upd .= ", USER_ID = '" . $this->client_id . "' ";
      }
      $upd .= "WHERE BFCP_FILE_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(false);
      }
      else
      {
         return(true);
      }    
   }
   function dbLoad($dbmgr)
   {
      $this->log->write("Batch_File->dbLoad(dbmgr)");
      $load = "SELECT FILE_NAME, TITLE FROM BFCP_FILE "
            . "WHERE BFCP_FILE_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($load)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_array();
      $this->file_name = $row["FILE_NAME"];
//.*write(.*$.*);
      $this->title = $row["TITLE"];
//.*write(.*$.*);
      return $this->id;
   }
}
?>