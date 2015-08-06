<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
class Service_Member
{
   var $client_id;
   var $rep;
   var $title;
   var $type; //'Leader' or 'Service'
   function Service_Member()
   {
      $this->log = new Secretary();
      $this->rep = new Rep();
   }
   
   function logValues()
   {
      $this->log->write("-----Service_Member-----\n"
                       ."client_id = " . $this->client_id . "\n"
                       ."title = " . $this->title . "\n"
                       ."type = " . $this->type . "\n");
      $this->rep->logValues();
      $this->log->write("---------------\n");
   }
   function dbLoad($dbmgr)
   {
      $this->log->write("Service_Member->dbLoad(dbmgr)");
      $sel = "SELECT TITLE, TYPE FROM CP_SERVICE_TEAM WHERE REP_ID = " . $this->rep->id . " AND USER_ID = " . $this->client_id;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_array();
      $this->title = $row["TITLE"];
      $this->type = $row["TYPE"];
      $this->rep->dbLoad($dbmgr);
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $this->log->write("Service_Member->dbInsert(dbmgr)");
      $ins = "INSERT INTO CP_SERVICE_TEAM"
           . " VALUES ("
           . $this->client_id . ", "
           . $this->rep->id . ", '"
           . $this->title . "', '"
           . $this->type . "')";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
      {
//.*write(.*$.*);
         $this->log->write("Service_Member->dbInsert(dbmgr) => false");
         return(false);
      }
      $this->log->write("Service_Member->dbInsert(dbmgr) => true");
      return(true);
   }
   function dbDelete($dbmgr, $client_id)
   {
//.*write(.*$.*);
      $del = "DELETE FROM CP_SERVICE_TEAM WHERE USER_ID = $client_id AND REP_ID = " . $this->rep->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
      {
//.*write(.*$.*);
         return(false);
      }
      return(true);
   }
}
?>