<?php
//require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
class Secretary
{
   var $file;
   //var $dbmgr;
   function Secretary()
   {
      //$this->dbmgr = new DB_Mgr("dbates");
      $this->file = date("Y_m_d") . ".log";
      //$this->file = date("w") . ".log";  
   }
   
   function write($string)
   {
      //$q = "INSERT INTO LOGGING (WHEN, STATEMENT) values(\"" . date("Y-m-d H:i:s") . "\", \"" . addslashes($string) . "\");";
      //$this->dbmgr->query($q);
      $date = date("d-m-Y H:i");
      $fileName = $_SERVER["DOCUMENT_ROOT"] . "/logging/" . $this->file;
      $fh = fopen($fileName, "a") or die("Secretary could not open file " . $fileName);
      fputs($fh, $date . " => " .$string . "<br>\n");
      fclose ($fh);
   }
	
}
?>