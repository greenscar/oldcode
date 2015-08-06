<?php
class Secretary
{
   var $file_name;
   function Secretary()
   {
      $fn = date("Y_m_d", mktime());
      $this->file_name = $_SERVER["DOCUMENT_ROOT"] . "/logging/" . date("Y_m_d", mktime()) . "oohaheats.log";
   }
   function write($msg)
   {
      // open file
      $fd = fopen($this->file_name, "a");
      
      // append date/time to message
      $str = "[" . date("H:i", mktime()) . "] " . $msg;
      
      // write string
      fwrite($fd, $str . "\n");
      
      // close file
      fclose($fd);
   }
   function log_end_of_fxn()
   {
      // open file
      $fd = fopen($this->file_name, "a");
      
      // append date/time to message
      $str = "[" . date("Y/m/d H:i", mktime()) . "] --------------------------------------------";
      
      // write string
      fwrite($fd, $str . "\n");
      
      // close file
      fclose($fd);
   }
      
}
?>