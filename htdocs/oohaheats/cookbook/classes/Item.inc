<?php
require_once("Secretary.inc");
class Item
{
   var $id;
   var $descr;
   var $log;
   
   function Item()
   {
      $this->log = new Secretary();
   }
   
   function db_load_via_id($id, $dbmgr)
   {
      $this->log->write("Item->db_load_via_id($id) START");
      $toReturn = false;
      $sel = "SELECT item_descr FROM item_def WHERE item_id = $id";
      $dbmgr->query($sel);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->id = $id;
         $this->descr = $row["item_descr"];
         $toReturn = true;
      }
      $this->log->write("Item->db_load_via_id($id) END");
      return($toReturn);
   }
   function db_load_via_descr($descr, $dbmgr)
   {
      $this->log->write("Item->db_load_via_descr($descr) START");
      $toReturn = false;
      $sel = "SELECT item_id FROM item_def WHERE item_descr = \"$descr\"";
      $this->log->write($sel);
      $dbmgr->query($sel);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->id = $row["item_id"];
         $this->descr = $descr;
         $this->log->write($descr . " found in DB. ID => " . $this->id);
         $toReturn = true;
      }
      $this->log->write("Item->db_load_via_descr($descr) END => " . $toReturn);
      return($toReturn);
   }
   
   function db_insert($dbmgr)
   {
      $this->log->write("Item->db_insert() START");
      $ins = "INSERT INTO item_def (item_descr) VALUES (\"" . addslashes($this->descr) . "\");";
      $this->log->write($ins);
      $dbmgr->query($ins);
      $this->id = $dbmgr->get_last_key();
      if($this->id == 0)
      {
         die("ERROR IN Item.db_insert() => " . $this->descr . " did not get inserted into the DB!!!");
      }
      $this->log->write("Item->db_insert() END");
   }
}
?>