<?php

class Application
{
   // Application ID (key in DB for TIERS, SSP, STP) 
   var $id;
   // Application Name (TIERS, SSP, STP);
   var $name;
   
   function Application()
   {
   }
   
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= "id => " . $this->id . "\r\n";
      $str .= "name => " . $this->name . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }   
}
?>
