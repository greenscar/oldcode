<?php
require_once("Measurement.inc");
require_once("Item.inc");
require_once("Secretary.inc");
class Ingredient
{
   var $order_num;
   var $item;
   var $quantity;
   var $measurement;
   var $log;
   
   function Ingredient()
   {
      $this->measurement = new Measurement();
      $this->item = new Item();
      $this->log = new Secretary();
   }
   function to_string()
   {
      $str = "\r\n-------------------------------------------\r\n";
      $str .= "order_num => " . $this->order_num . "\r\n";
      $str .= "item_id => " . $this->item->id . "\r\n";
      $str .= "item_descr => " . $this->item->descr . "\r\n";
      $str .= "quantity => " . $this->quantity . "\r\n";
      $str .= "measurement_id => " . $this->measurement->id . "\r\n";
      $str .= "measurement_descr => " . $this->measurement->descr . "\r\n";
      $str .= "-------------------------------------------\r\n";
      return($str);
   }
   
   /*
    * Check the item_def table for an entry with this name.
    * If the item exists, load the id.
    * If the item doesn't exist, insert the item then load the id.
    */
   function set_item_via_descr($descr, $dbmgr)
   {
      $this->log->write("Ingredient->set_item_via_descr($descr, dbmgr) START");
      $to_return = false;
      if($this->item->db_load_via_descr($descr, $dbmgr))
      {
         $to_return = true;
      }
      else
      {
         //$this->item->id = 0;
         $this->item->descr = $descr;
         $this->item->db_insert($dbmgr);
         $to_return = false;
      }
      $this->log->write("Ingredient->set_item_via_descr($descr, dbmgr) END => " . $this->item->id);
      return($to_return);
   }
   function set_measurement($msrmnt_descr, $dbmgr)
   {
      $this->measurement->db_create($msrmnt_descr, $dbmgr);
   }
   
   /*
    * Check to see if item exists in item_def.
    * If it does exist in item_def, get the item_id
    *    from the DB and assign it to this item.
    * If it doesn't exist in item_def, insert it and
    *    return the new item_id
    */
   function db_insert($recipe_id, $dbmgr)
   {
      $this->log->write("Ingredient->db_insert($recipe_id, dbmgr) START");
      // Insert the item into the item table if the item_id == 0 
      //if($this->item->id == 0)
      //{
      //   $this->item->db_insert($dbmgr);
      //}
      // Insert into the Ingredient table.
      if((!empty($recipe_id)) && (!empty($this->quantity)) && (!empty($this->measurement->id)) && (!empty($this->item->id)) && (!empty($this->order_num)))
      {
         $ins = "INSERT INTO ingredients (recipe_id, quantity, msrmnt_id, item_id, order_num) "
              . "VALUES "
              . "(" . $recipe_id . ", \"" . $this->quantity . "\", " . $this->measurement->id . ", "
              . $this->item->id . ", " . $this->order_num . ")";
      }
      else if((!empty($recipe_id)) && (!empty($this->item->id)) && (!empty($this->order_num)))
      {
         $ins = "INSERT INTO ingredients (recipe_id, item_id, order_num) "
              . "VALUES "
              . "(" . $recipe_id . ", " . $this->item->id . ", " . $this->order_num . ")";
      }
      
      $this->log->write($ins);
      $dbmgr->query($ins);
      $this->log->write("Ingredient->db_insert($recipe_id, dbmgr) END");
   }
}
?>