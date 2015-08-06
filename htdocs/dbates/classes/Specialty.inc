<?php
require_once("Secretary.inc");
class Specialty
{
   var $id;
   var $name;
   var $active;
   var $log;
   function Specialty(){
      $this->log = new Secretary();   
   }
   function logValues()
   {
      $str = "id = " . $this->id . "\n"
            . "name = " . $this->name . "\n"
            . "active = " . $this->active . "\n";
      return($str);
   }
   function isActive()
   {
      //return $this->active;
      if($this->active) return "YES";
      else return "NO";
   }
   // REQUIRE id BE SET
   function dbLoad($dbmgr)
   {
      if(!empty($this->id))
      {
         $sel = "SELECT NAME, ACTIVE FROM SPECIALTY_DEF WHERE SPECIALTY_ID = " . $this->id;
         if(!($dbmgr->query($sel)))
            return("ERROR in $sel<BR>");
         $row = $dbmgr->fetch_row();
         $this->name = $row[0];
         $this->active = $row[1];
         return($this->id);
      }
   }
   function dbLoadViaName($dbmgr)
   {
      $this->log->write("Specialty->dbLoadViaName(dbmgr)");
      $sel = "SELECT SPECIALTY_ID, ACTIVE FROM SPECIALTY_DEF WHERE SPECIALTY_NAME = " . $this->name;
//.*write(.*$.*);
      if(!($dbmgr->query($sel)))
      {
//.*write(.*$.*);
         return(false);
      }
      $row = $dbmgr->fetch_row();
      $this->id = $row[0];
      $this->active = $row[1];
      return($this->id);
   }
   
   function dbUpdate($dbmgr)
   {
      $upd = "UPDATE SPECIALTY_DEF SET NAME = "
           . "'" . $this->name . "', "
           . "ACTIVE = '" . $this->active . "' "
           . "WHERE SPECIALTY_ID = " . $this->id;
      if(!($dbmgr->query($upd)))
//.*write(.*$.*);
      return true;
   }
   
   function dbInsert($dbmgr)
   {
      $ins = "INSERT INTO SPECIALTY_DEF (NAME, ACTIVE) VALUES "
           . "('" . $this->name . "', '" . $this->active . "');";
      //return $ins;
      if(!($dbmgr->query($ins)))
            return("ERROR in $ins<BR>");
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
}
?>