<?php
class Category
{
   var $id;
   var $descr;
   function Category()
   {
   }
   function db_load($dbmgr)
   {
      $q = "SELECT cat_descr FROM category_def WHERE cat_id = " . $this->id;
      $dbmgr->query($q);
      if($row = $dbmgr->fetch_assoc_array())
      {
         $this->descr = $row["cat_descr"];
         return(true);
      }
      else
      {
         return(false);
      }
   }
}
?>