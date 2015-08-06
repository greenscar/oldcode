<?php
class Flavor
{
   var $id;
   var $name;
   var $description;
   function Flavor()
   {
   }
   
   function dbLoad($dbmgr)
   {
      $q = "SELECT flavor, description from flavorDef where flavorID = " . $this->id;
      if(!($dbmgr->query($sel)))
      {
         $this->log->write("Error in $sel");
         return(false);
      }
      else
      {
         $row = $dbmgr->fetch_array();
         $this->name = $row[0];
         $this->description = $row[1];
      }
   }
         
}
?>