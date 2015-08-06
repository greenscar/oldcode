<?php
class Secretary
{
   var $file;
   
   function Secretary()
   {
      $this->file = date("Y_m_d") . ".log";  
   }
   
   function write($string)
   {
      
      $date = date("d-m-Y H:i");
		$fileName = $_SERVER["DOCUMENT_ROOT"] . "/logging/" . $this->file;
		$fh = fopen($fileName, "a") or die("Can't open file");
      fputs($fh, $date . " => " .$string . "\n");
      fclose ($fh);
   }
	
}
?>