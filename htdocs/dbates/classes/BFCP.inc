<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Batch_File.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Uploader.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Client.inc");
class BFCP
{
   var $log;
   var $client;
   var $files;
   var $active;
   
   function BFCP()
   {
      $this->log = new Secretary();
      $this->client = new Client();
      $this->files[] = Array();
   }
   function getImageDir()
   {
      $dir = "https://www.dbates.com/upload_dir/batch_pages/";
      //return "http://" . $_SERVER["SERVER_NAME"] . "upload_dir/batch_pages/" . $this->client->id;
      //$dir = "upload_dir/batch_pages/";
      return $dir;
   }
   function isActive()
   {
      if($this->active == 1) $toReturn = "ACTIVE";
      else $toReturn = "INACTIVE";
//.*write(.*$.*);
      return $toReturn;
   }
   function dbInsert($dbmgr)
   {
//.*write(.*$.*);
      $ins = "INSERT INTO BFCP_INDEX(USER_ID) VALUES(". $this->client->id . ");";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
      {
//.*write(.*$.*);
         return(false);
      }
      return($this->client->id);
   }
   function dbUpdate($dbmgr)
   {
      
//.*write(.*$.*);
      $upd = "UPDATE BFCP_INDEX SET"
           . " ACTIVE = '" . $this->active . "'"
           . " WHERE USER_ID = " . $this->client->id;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
      {
//.*write(.*$.*);
         return(false);
      }
      foreach($this->files AS $id=>$value)
      {
         if($id > 0)
         {
            if(!($value->dbUpdate($dbmgr)))
            {
               $this->log->write("ERROR in Batch_File Update");
               return(false);
            }
         }
      }
      return(true);
   }
   function processFileUpload($dbmgr, $_FILES)
   {
      $uploader = new Uploader();
      $this->files = Array();
      $this->files = $uploader->uploadBatch($dbmgr, $_FILES, $this->client->id);
      return($this->files);
   }
   
   function dbLoad($dbmgr)
   {
//.*write(.*$.*);
      $sel = "SELECT ACTIVE FROM BFCP_INDEX WHERE USER_ID = " . $this->client->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_array();
      $this->active = $row["ACTIVE"];
      
      $sel = "SELECT F.BFCP_FILE_ID, F.FILE_NAME, F.TITLE "
           . "FROM BFCP_FILE F "
           . "WHERE F.USER_ID = " . $this->client->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
//.*write(.*$.*);
      $sel = "SELECT ACTIVE FROM BFCP_INDEX WHERE USER_ID = " . $this->client->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_array();
      $this->active = $row["ACTIVE"];
      
      $sel = "SELECT F.BFCP_FILE_ID, F.FILE_NAME, F.TITLE "
           . "FROM BFCP_FILE F "
           . "WHERE F.USER_ID = " . $this->client->id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $this->files = Array();
//.*write(.*$.*);
      for($i=0; $row = $dbmgr->fetch_array(); $i++)
      {
//.*write(.*$.*);
         $bf = new Batch_File();
         $bf->client_id = $this->client->id;
         $bf->id = $row["BFCP_FILE_ID"];
         $bf->file_name = $row["FILE_NAME"];
         $bf->title = $row["TITLE"];
         $this->files[$bf->id] = $bf;
      }
//.*write(.*$.*);
      return(sizeof($this->files));
   }
}
/*
class BFCP
{
   function dbLoad($dbmgr)
   {
   }
   
}
   */
?>