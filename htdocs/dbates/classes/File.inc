<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class File
{
   var $log;
   var $id;
   var $title; // Max Length 20
   var $description; // Max length 100;
   var $size;
   var $file_name;
   function File()
   {
      $this->log = new Secretary();
   }
   function getFileType()
   {
      return substr($this->file_name, (strlen($this->file_name) - 3), strlen($this->file_name));
   }
   function deleteFile()
   {
      $this->log->write("File->deleteFile()");
      $fileName = $_SERVER["DOCUMENT_ROOT"] . "/upload_dir/" . $this->file_name;
//.*write(.*$.*);
      $x = unlink($fileName);
//.*write(.*$.*);
   }
   function dbDelete($dbmgr)
   {
      $this->log->write("File->dbDelete(dbmgr)");
      $del1 = "DELETE FROM FILE WHERE FILE_ID = " . $this->id;
      $del2 = "DELETE FROM CP_COVERAGE WHERE FILE_ID = " . $this->id;
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
      $ins = "INSERT INTO FILE (TITLE, DESCRIPTION, FILE_NAME, SIZE)"
           . " VALUES('"
           . $this->title . "', '"
           . $this->description . "', '"
           . $this->file_name . "', "
           . $this->size . ");";
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
      $upd = "UPDATE FILE SET "
           . "TITLE = '" . $this->title . "', "
           . "DESCRIPTION = '" . $this->description . "' ";
      if(!empty($this->file_name))
         $upd .= ", FILE_NAME = '" . $this->file_name . "'";
      $upd .= " WHERE FILE_ID = " . $this->id;
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
      $load = "SELECT TITLE, DESCRIPTION, FILE_NAME FROM FILE WHERE FILE_ID = " . $this->id;
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