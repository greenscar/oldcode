<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Secretary.inc");
class Department
{
   var $id;
   var $name;
   // BOOLEAN TELLING IF THIS IS A TYPE OF IS_INSURANCE OR NOT (Agency Services is a DEPT but not insurance)
   var $insurance;
   var $active;
   var $log;
   
   function Department(){
      $this->log = new Secretary();
   }
   
   function isInsurance()
   {
      if($this->insurance) $toReturn = "YES";
      else $toReturn = "NO";
//.*write(.*$.*);
      return $toReturn;
   }
   function isActive()
   {
      if($this->active) $toReturn = "YES";
      else $toReturn = "NO";
//.*write(.*$.*);
      return $toReturn;
   }
   // REQUIRE id BE SET
   function dbLoad($dbmgr)
   {
      $this->log->write("Department->dbLoad(dbmgr)");
      if(!empty($this->id))
      {
         $sel = "SELECT NAME, IS_INSURANCE , ACTIVE FROM DEPT_DEF WHERE DEPT_ID = " . $this->id;
         if(!($dbmgr->query($sel)))
            return("ERROR in $sel<BR>");
         $row = $dbmgr->fetch_row();
         $this->name = $row[0];
         $this->insurance = $row[1];
         $this->active = $row[2];
         return($this->id);
      }
   }
   function dbInsert($dbmgr)
   {
      $ins = "INSERT INTO DEPT_DEF (NAME, IS_INSURANCE, ACTIVE) VALUES ('"
           . $this->name . "', '"
           . $this->insurance . "', '"
           . $this->active . "');";
      if(!($dbmgr->query($ins)))
            return("ERROR in $ins<BR>");
      $this->id = $dbmgr->get_last_key();
      return $this->id;
   }
   
   function dbUpdate($dbmgr)
   {
      $upd = "UPDATE DEPT_DEF SET "
           . "NAME = '"
           . $this->name . "', "
           . "IS_INSURANCE = '"
           . $this->insurance . "', "
           . "ACTIVE = '"
           . $this->active . "' "
           . "WHERE DEPT_ID = " . $this->id;
           //return $upd;
//.*write(.*$.*);
      if(!($dbmgr->query($upd)))
//.*write(.*$.*);
      return true;
   }
   
   function dbLoadRepList($dbmgr)
   {
//.*write(.*$.*);
      require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Rep.inc");
      $sel = "SELECT R.FIRST_NAME, R.LAST_NAME, R.REP_ID "
           . " FROM REP R, DEPT_DEF D WHERE "
           . " R.DEPT_ID = D.DEPT_ID"
           . " AND R.ACTIVE = '1'"
           . " AND D.DEPT_ID = " . $this->id;
      if(!($dbmgr->query($sel)))
//.*write(.*$.*);
      $repArray[] = Array();
      $c = 0;
      if($dbmgr->get_num_rows() <= 0)
         return null;      
      while($row = $dbmgr->fetch_row())
      {
         $rep = new Rep();
         $rep->first_name = $row[0];
         $rep->last_name = $row[1];
         $rep->id = $row[2];
         $repArray[$c++] = $rep;
      }
      return $repArray;
   }
}
?>