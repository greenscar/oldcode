<?php
require_once("DB_Mgr.inc");
require_once("Ingredient.inc");
require_once("Secretary.inc");
require_once("Category.inc");
class Recipe
{
   var $category;
   var $name;
   var $id;
   var $ingredients;
   var $steps;
   var $time_to_complete;
   var $num_servings;
	var $num_views;
   var $log;
   var $db;
   
   function Recipe()
   {
      $this->dbmgr = new DB_Mgr();
      $this->ingredients = Array();
      $this->instructions = Array();
      $this->steps = Array();
      $this->log = new Secretary();
   }
   
   function set_category($cat_id, $cat_descr)
   {
      $this->category = new Category();
      $this->category->id = $cat_id;
      $this->category->descr = $cat_descr;
   }
   
   /*
    * If item is in DB, load item_id from DB.
    * Else, insert item into DB & get item_id.
    *
    */
   function addIngredient($order_num, $qty, $msrmnt_descr, $item_descr)
   {
      $this->log->write("Recipe->addIngredient($order_num, $qty, $msrmnt_descr, $item_descr) START");
      $this->dbmgr->connect();
      $i = new Ingredient();
      $i->order_num = $order_num;
      $i->quantity = $qty;
      $i->set_measurement($msrmnt_descr, $this->dbmgr);
      $i->set_item_via_descr($item_descr, $this->dbmgr);
      $this->ingredients[$order_num - 1] = $i;
      $this->dbmgr->disconnect();
      $this->log->write("Recipe->addIngredient($order_num, $qty, $msrmnt_descr, $item_descr) END");
   }
   
   function addIngredientWOMeasurement($order_num, $item_descr)
   {
      $this->log->write("Recipe->addIngredientWOMeasurement($order_num, $item_descr) START");
      $this->dbmgr->connect();
      $i = new Ingredient();
      $i->order_num = $order_num;
      $i->set_item_via_descr($item_descr, $this->dbmgr);
      $this->ingredients[$order_num - 1] = $i;
      $this->dbmgr->disconnect();
      $this->log->write("Recipe->addIngredientWOMeasurement($order_num, $item_descr) END");
   }
   function addStep($descr)
   {
      array_push($this->steps, $descr);
   }
   
   function dbInsert()
   {
      $this->log->write("Recipe->dbInsert() START");
      $this->dbmgr->connect();
      /****************************************************
       * INSERT HEADER
       ***************************************************/
      $ins = "INSERT INTO recipes (name, cat_id, time_to_complete, num_servings)"
           . " VALUES (\"" . $this->name . "\", "
           . $this->category->id . ", "
           . "\"" . $this->time_to_complete . "\", \""
           . $this->num_servings . "\");";
      $this->log->write($ins);
      $this->dbmgr->query($ins);
      $this->id = $this->dbmgr->get_last_key();
      $this->log->write("key = " . $this->id);
      /****************************************************
       * END INSERT HEADER
       ***************************************************/
      /****************************************************
       * INSERT INGREDIENTS
       ***************************************************/
      foreach($this->ingredients as $ingredient)
      {
         $ingredient->db_insert($this->id, $this->dbmgr);
      }
      /****************************************************
       * END INSERT INGREDIENTS
       ***************************************************/
      /****************************************************
       * INSERT STEPS
       ***************************************************/
      foreach($this->steps as $order=>$step)
      {
         $ins = "INSERT INTO steps (recipe_id, order_num, step_descr) "
              . "VALUES "
              . "(" . $this->id . ", " . $order . ", \"" . addslashes($step) . "\")";
         $this->log->write($ins);
         $this->dbmgr->query($ins);
      }
      /****************************************************
       * END INSERT STEPS
       ***************************************************/
      $this->dbmgr->disconnect();
      $this->log->write("Recipe->dbInsert() END");
   }
   
   function dbUpdate()
   {
      $this->log->write("Recipe->dbUpdate() START");
      $this->dbmgr->connect();
      /****************************************************
       * UPDATE
       ***************************************************/
      $upd = "UPDATE recipes SET "
           . "name = \"" . $this->name . "\", "
           . "cat_id = " . $this->category->id . ", "
           . "time_to_complete = \"" . $this->time_to_complete . "\", "
           . "num_servings = " . $this->num_servings . " "
           . "WHERE recipe_id = " . $this->id;
      $this->log->write($upd);
      $this->dbmgr->query($upd);
      /****************************************************
       * END UPDATE HEADER
       ***************************************************/
      /****************************************************
       * UPDATE INGREDIENTS
       ***************************************************/
      // 1) Delete existing ingredients.
      // 2) Insert these ingredients.
      // NOTE: Leave all items in item_def because they are
      //    probably used in another recipe or will be used
      //    again.
      $del = "DELETE FROM ingredients WHERE recipe_id = " . $this->id;
      $this->log->write($del);
      $this->dbmgr->query($del);
      foreach($this->ingredients as $ingredient)
      {
         //if(!($ingredient->set_item_via_descr($this->id, $this->dbmgr)))
            $ingredient->db_insert($this->id, $this->dbmgr);
      }
      /****************************************************
       * END UPDATE INGREDIENTS
       ***************************************************/
      /****************************************************
       * UPDATE STEPS
       ***************************************************/
      // 1) Delete existing Steps
      // 2) Insert these steps.
      $del = "DELETE FROM steps WHERE recipe_id = " . $this->id;
      $this->log->write($del);
      $this->dbmgr->query($del);
      foreach($this->steps as $order=>$step)
      {
         //INSERT
         $ins = "INSERT INTO steps (recipe_id, order_num, step_descr) "
              . "VALUES "
              . "(" . $this->id . ", " . $order . ", \"" . addslashes($step) . "\")";
         $this->log->write($ins);
         $this->dbmgr->query($ins);
      }
      /****************************************************
       * END UPDATE STEPS
       ***************************************************/
      $this->db_clean_item_table();
      $this->dbmgr->disconnect();
      $this->log->write("Recipe->dbUpdate() END");
   }
   
   function db_clean_item_table()
   {
      $this->log->write("Recipe->db_clean_item_table() START");
      // FIGURE OUT HOW TO CLEAN OUT ITEM_DEF TABLE.
      // CANT DO NOT EXISTS ON LOCAL SERVER.
      // MYSQL OLDER VERSION?
      $this->log->write("Recipe->db_clean_item_table() END");
   }
   
   function db_delete()
   {
      $this->log->write("Recipe->db_delete() START");
      $this->dbmgr->connect();
      /****************************************************
       * DELETE RECIPE HEADER
       ***************************************************/
      $del = "DELETE FROM recipes "
           . "WHERE recipe_id = " . $this->id;
      $this->log->write($del);
      $this->dbmgr->query($del);
      /****************************************************
       * END DELETE HEADER
       ***************************************************/
      /****************************************************
       * DELETE INGREDIENTS
       ***************************************************/
      // 1) Delete existing ingredients.
      // NOTE: Leave all items in item_def because they are
      //    probably used in another recipe or will be used
      //    again.
      $del = "DELETE FROM ingredients WHERE recipe_id = " . $this->id;
      $this->log->write($del);
      $this->dbmgr->query($del);
      /****************************************************
       * END DELETE INGREDIENTS
       ***************************************************/
      /****************************************************
       * DELETE STEPS
       ***************************************************/
      // 1) Delete existing Steps
      $del = "DELETE FROM steps WHERE recipe_id = " . $this->id;
      $this->log->write($del);
      $this->dbmgr->query($del);
      /****************************************************
       * END DELETE STEPS
       ***************************************************/
      $this->db_clean_item_table();
      $this->dbmgr->disconnect();
      $this->log->write("Recipe->db_delete() END");
   }
   function db_load()
   {
      $this->log->write("Recipe->db_load() START");
      $this->ingredients = Array();
      $this->steps = Array();
      if($this->id == null)
      {
         return(false);
      }
      $this->dbmgr->connect();
      // Load header info     
      $sel = "SELECT "
           . "r.name, r.time_to_complete, r.num_servings, r.num_views, "
           . "c.cat_id, c.cat_descr "
           . "FROM "
           . "recipes r, category_def c "
           . "WHERE "
           . "r.cat_id = c.cat_id "
           . "AND "
           . "r.recipe_id = " . $this->id;
      $this->log->write($sel);
      $this->dbmgr->query($sel);
      if($row = $this->dbmgr->fetch_assoc_array())
      {
         $this->name = $row["name"];
         $this->time_to_complete = $row["time_to_complete"];
			$this->num_views = $row["num_views"];
         $this->num_servings = $row["num_servings"];
         $this->category->id = $row["cat_id"];
         $this->category->descr = $row["cat_descr"];
      }
      // Load ingredients
      $sel = "SELECT "
           . "id.item_id, id.item_descr, "
           . "i.quantity, i.order_num, "
           . "m.msrmnt_id, m.msrmnt_descr "
           . "FROM "
           . "ingredients i, item_def id, msrmnt_def m "
           . "WHERE "
           . "i.item_id = id.item_id "
           . "AND "
           . "i.msrmnt_id = m.msrmnt_id "
           . "AND "
           . "i.recipe_id = " . $this->id;
      $this->log->write($sel);
      $this->dbmgr->query($sel);
      while($row = $this->dbmgr->fetch_assoc_array())
      {
         $i = new Ingredient();
         $i->item->id = $row["item_id"];
         $i->item->descr = $row["item_descr"];
         $i->quantity = $row["quantity"];
         $i->order_num = $row["order_num"];
         $i->measurement->id = $row["msrmnt_id"];
         $i->measurement->descr = $row["msrmnt_descr"];
         $this->log->write($i->to_string());
         $this->ingredients[$i->order_num - 1] = $i;
      }
      // Load ingredients without measurements
      $sel = "SELECT "
           . "id.item_id, id.item_descr, i.order_num "
           . "FROM "
           . "ingredients i, item_def id "
           . "WHERE "
           . "i.item_id = id.item_id "
           . "AND "
           . "i.quantity is null "
           . "AND "
           . "i.msrmnt_id = 0 "
           . "AND "
           . "i.recipe_id = " . $this->id;
      $this->dbmgr->query($sel);
      while($row = $this->dbmgr->fetch_assoc_array())
      {
         $i = new Ingredient();
         $i->item->id = $row["item_id"];
         $i->item->descr = $row["item_descr"];
         $i->order_num = $row["order_num"];
         $this->log->write($i->to_string());
         $this->ingredients[$i->order_num - 1] = $i;
      }
      $this->log->write("num_ingredients = " . sizeof($this->ingredients));
      // Load steps
      $sel = "SELECT "
           . "order_num, step_descr "
           . "FROM "
           . "steps "
           . "WHERE "
           . "recipe_id = " . $this->id;
      $this->log->write($sel);
      $this->dbmgr->query($sel);
      $temp =  Array();
      while($row = $this->dbmgr->fetch_assoc_array())
      {
         $array_loc = $row["order_num"] - 1;
         $temp[$array_loc] = stripslashes($row["step_descr"]);
      }
      foreach($temp as $a_step)
      {
         $this->addStep($a_step);
      }
      $this->dbmgr->disconnect();
   }
	function db_increase_num_views()
	{
		
		$this->num_views = $this->num_views + 1;
		$upd = "UPDATE recipes SET num_views = " . $this->num_views . " WHERE recipe_id = " . $this->id;
		$this->dbmgr->connect();
		$this->dbmgr->query($upd);
		$this->dbmgr->disconnect();
	}
}
?>