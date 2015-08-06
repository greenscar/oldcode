<?php
require_once("Secretary.inc");
class Measurement
{
   var $id;
   var $descr;
   function Measurement()
   {
      $this->log = new Secretary();
   }
   function db_load_via_id($id, $dbmgr)
   {
      $sel = "SELECT msrmnt_descr FROM msrmnt_def WHERE msrmnt_id = $id";
      $dbmgr->query($sel);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->id = $id;
         $this->name = $row["msrmnt_descr"];
      }
   }
   function db_create($msrmnt_descr, $dbmgr)
   {
       $this->log->write("Measurement->db_create($msrmnt_descr, dbmgr) START");
       $msrmnt_descr = trim($msrmnt_descr);
       $this->descr = $msrmnt_descr; 
       if(!empty($this->descr))
       {
          $sel = "SELECT msrmnt_id FROM msrmnt_def where msrmnt_descr like '" . $this->descr . "'";
          $this->log->write($sel);
          $dbmgr->query($sel);
          if($row = $dbmgr->fetch_assoc_array())
          {
            $this->log->write("found a row");
              $this->id = $row["msrmnt_id"];
              $this->log->write($sel . " => " . $this->id);
          }
          else
          {
              $ins = "INSERT INTO msrmnt_def (msrmnt_descr) VALUES (\"" . $this->descr . "\")";
              $this->log->write($ins);
              $dbmgr->query($ins);
              $this->log->write($ins);
              $sel = "SELECT msrmnt_id FROM msrmnt_def where msrmnt_descr like '" . $this->descr . "'";
              $dbmgr->query($sel);
              $row = $dbmgr->fetch_assoc_array();
              $this->id = $row["msrmnt_id"];
              $this->log->write($sel . " => " . $this->id);
          }
       }
       $this->log->write("Measurement->db_create($msrmnt_descr, dbmgr) END");
   }   
}
?>