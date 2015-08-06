<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/File.inc");
class Form extends File
{
   function Form()
   {
      File::File();
   }
   
   function dbDelete($dbmgr)
   {
      $this->log->write("File->dbDelete(dbmgr)");
      $del1 = "DELETE FROM FORM WHERE FORM_ID = " . $this->id;
      $del2 = "DELETE FROM CP_FORM WHERE FORM_ID = " . $this->id;
//.*write(.*$.*);
//.*write(.*$.*);
      if(!($dbmgr->query($del1)))
      {
//.*write(.*$.*);
         return(false);
      }
      if(!($dbmgr->query($del2)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->deleteFile();
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $this->log->write("File->dbInsert(dbmgr)");
      $ins = "INSERT INTO FORM (TITLE, DESCRIPTION, FILE_NAME)"
           . " VALUES('"
           . $this->title . "', '"
           . $this->description . "', '"
           . $this->file_name . "');";
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
      $this->log->write("File->dbUpdate(dbmgr)");
      //$this->dbLoad($dbmgr);
      //$this->deleteFile();
      $upd = "UPDATE FORM SET "
           . "TITLE = '" . $this->title . "', "
           . "DESCRIPTION = '" . $this->description . "' ";
      if(!empty($this->file_name))
         $upd .= ", FILE_NAME = '" . $this->file_name . "'";
      $upd .= " WHERE FORM_ID = " . $this->id;
      $this->log->write("File->dbUpdate(dbmgr)");
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
      $this->log->write("File->dbLoad(dbmgr)");
      $load = "SELECT TITLE, DESCRIPTION, FILE_NAME FROM FORM WHERE FORM_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($load)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_array();
      $this->title = $row["TITLE"];
      $this->description = $row["DESCRIPTION"];
      $this->file_name = $row["FILE_NAME"];
//.*write(.*$.*);
      return $this->id;
   }
   
   function toString()
   {
      return("title = " . $this->title . "\n"
              . "description = " . $this->description . "\n"
              . "file_name = " . $this->file_name);
   }
}
?>