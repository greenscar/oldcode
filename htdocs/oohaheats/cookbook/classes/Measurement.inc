<?php
class Measurement
{
   var $id;
   var $descr;
   function Measurement()
   {
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
}
?>