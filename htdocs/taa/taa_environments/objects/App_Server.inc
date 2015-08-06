<?php
require_once("Secretary.inc");

class App_Server
{
   var $server_name;
   var $node;
   var $port;
   var $date_start;
   var $date_end;
   
   function App_Server()
   {
      $this->log = new Secretary();
   }
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= "server_name => " . $this->server_name . "\r\n";
      $str .= "node => " . $this->node . "\r\n";
      $str .= "port => " . $this->port . "\r\n";
      $str .= "date_start => " . $this->date_start . "\r\n";
      $str .= "date_end => " . $this->date_end . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }
}
?>
