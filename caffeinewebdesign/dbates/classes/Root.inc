<?php
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
class Root extends Admin
{
   function Root()
   {
      Admin::Admin();
      $this->sec_lvl_id = 2;
      $this->sec_lvl_name = "ROOT";
   }
   function getUserType()
   {
      return $this->sec_lvl_name;
   }
}
?>