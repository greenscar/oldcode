<?php
require_once("Secretary.inc");
require_once("App.inc");
class Batch_App extends App
{
   var $path;
   var $box;
   
   /*
   function Batch_App()
   {
      $this->log = new Secretary();
   }
   */
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= parent::toString();
      $str .= "box => " . $this->box . "\r\n";
      $str .= "path => " . $this->path . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }
   
}
?>
