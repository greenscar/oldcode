<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class Link{
   var $log;
   var $id;
   var $title;
   var $address;
   var $description;
   var $public;
   
   function Link()
   {
      $this->log = new Secretary();
   }
   function dbUpdate($dbmgr)
   {
      $this->log->write("Link->dbUpdate(dbmgr)");
      $upd = "UPDATE LINK SET "
           . "TITLE = '" . $this->title
           . "', ADDRESS = '" . $this->address
           . "', DESCRIPTION = '" . $this->description
           . "', PUBLIC = '" . $this->public
           . "' WHERE LINK_ID = " . $this->id;
//.*write(.*$.*);
      $rs = $dbmgr->query($upd);
      if(!$rs)
//.*write(.*$.*);
      return(true);
   }
   function dbInsert($dbmgr)
   {
      $this->log->write("Link->dbInsert(dbmgr)");
      $ins = "INSERT INTO LINK (TITLE, ADDRESS, DESCRIPTION, PUBLIC) "
           . "VALUES "
           . "('" . $this->title . "', '" . $this->address . "', '" . $this->description . "', '" . $this->public . "')";
//.*write(.*$.*);
      if(!($dbmgr->query($ins)))
//.*write(.*$.*);
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
   function dbDelete($dbmgr)
   {
      $this->log->write("Link->dbDelete(dbmgr)");
      $del = "DELETE FROM LINK WHERE LINK_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($del)))
         return("ERROR in $del<BR>");
   }
   function dbLoad($dbmgr)
   {
      $this->log->write("Link->dbLoad(dbmgr)");
      $load = "SELECT TITLE, ADDRESS, DESCRIPTION, PUBLIC FROM LINK "
            . "WHERE LINK_ID = " . $this->id;
//.*write(.*$.*);
      if(!($dbmgr->query($load)))
//.*write(.*$.*);
      $row = $dbmgr->fetch_row();
      $this->title = $row[0];
      $this->address = $row[1];
      $this->description = $row[2];
      $this->public = $row[3];
      return $this->id;
   }
}
?>