<?php
require_once("Secretary.inc");
//require_once("Settings.inc");
class WS_Cell
{  
   var $cell_name;
   var $admin_http;
   //var $log;
   
   function App()
   {
      //$this->log = new Secretary();
   }
   
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= "CELL_name => " . $this->cell_name . "\r\n";
      $str .= "admin_http => " . $this->admin_http . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }   
}
?>
