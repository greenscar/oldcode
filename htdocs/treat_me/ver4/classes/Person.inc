<?php
require_once("Secretary.inc");
class Person
{
   var $log;
   var $first_name;
   var $last_name;
   var $address_1;
   var $address_2;
   var $city;
   var $state;
   var $zip;
   var $email;
   function Person
   {
      $this->log = new Secretary();
   }
   function joinMailingList($dbmgr)
   {
      $ins = "INSERT INTO clients values("
           . time() . ", "
           . "'" . $this->first_name . "', "
           . "'" . $this->last_name . "', "
           . "'" . $this->address_1 . "', "
           . "'" . $this->address_2 . "', "
           . "'" . $this->city . "', "
           . "'" . $this->state . "', "
           . $this->zip . ", "
           . "'" . $this->email . "', '1')";
      if(!($dbmgr->query($ins)))
      {
         $this->log->write("ERROR IN " . $ins);
         return(false);
      }
      return(true);
   }
   function quitMailingList($dbmgr)
   {
   }
}
?>