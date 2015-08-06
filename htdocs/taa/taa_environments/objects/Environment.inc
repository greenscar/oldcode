<?php

class Environment
{
   var $id;
   var $name;
   
   function Environment()
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
   
   function db_insert($db_mgr_mysql)
   {
      $stmt = "INSERT INTO ENVIRONMENT SET NAME = '" . trim($this->name) . "'";
      $db_mgr_mysql->query($stmt);
      $stmt = "SELECT ENV_ID FROM ENVIRONMENT WHERE NAME LIKE '" . $this->name . "'";
      $db_mgr_mysql->query($stmt);
      $row = $db_mgr_mysql->fetch_assoc_array();
      $this->id = $row["ENV_ID"];
   }
}
?>
