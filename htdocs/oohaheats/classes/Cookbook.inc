<?php
require_once("DB_Mgr.inc");
require_once("Category.inc");
require_once("Measurement.inc");
require_once("Recipe.inc");
require_once("Secretary.inc");
require_once("User.inc");
class Cookbook
{
   var $categories;
   var $a_category;
   var $recipes;
   var $measurements;
   var $dbmgr;
   var $log;
   
   function Cookbook()
   {
      $this->categories = Array();
      $this->measurements = Array();
      $this->log = new Secretary();
      $this->dbmgr = new DB_Mgr();
   }
   function process_login($id, $pwd)
   {
      $this->log->write("Cookbook->process_login() START");
      if($id == null || $pwd == null)
      {
         return(false);
      }
      $this->dbmgr->connect();
      $u = new User();
      $successful = $u->dbLogin($id, $pwd, $this->dbmgr);
      $this->dbmgr->disconnect();
      $this->log->write("Cookbook->process_login() END => " . $successful);
      if($successful)
         return $u;
      else
         return(false);
   }
   function get_categories()
   {
      if(sizeof($this->categories) == 0)
      {
         $this->dbmgr->connect();
         // Load categories from DB.
         $sel = "SELECT cat_id, cat_descr FROM category_def";
         $this->dbmgr->query($sel);
         while($row = $this->dbmgr->fetch_assoc_array())
         {
            $c = new Category();
            $c->id = $row["cat_id"];
            $c->descr = $row["cat_descr"];
            array_push($this->categories, $c);
         }
         $this->dbmgr->disconnect();
      }
      return $this->categories;
   }
   
   function get_measurements()
   {
      if(sizeof($this->measurements) == 0)
      {
         $this->dbmgr->connect();
         // Load measurements from DB.
         $sel = "SELECT msrmnt_id, msrmnt_descr FROM msrmnt_def";
         $this->dbmgr->query($sel);
         while($row = $this->dbmgr->fetch_assoc_array())
         {
            $m = new Measurement();
            $m->id = $row["msrmnt_id"];
            $m->descr = $row["msrmnt_descr"];
            array_push($this->measurements, $m);
         }
         $this->dbmgr->disconnect();
      }
      return $this->measurements;
   }
   function get_recipes_all()
   {
      $this->log->write("Cookbook->get_recipes_all() START");
      $this->recipes = Array();
      if(sizeof($this->recipes) == 0)
      {
         $this->dbmgr->connect();
         $sel = "SELECT r.recipe_id, r.name, r.tried, r.time_to_complete, r.cat_id, c.cat_descr "
              . "FROM recipes r, category_def c "
              . "WHERE r.cat_id = c.cat_id "
              . "ORDER BY r.name";
         $this->log->write($sel);
         $this->dbmgr->query($sel);
         while($row = $this->dbmgr->fetch_assoc_array())
         {
            $r = new Recipe();
            $r->id = $row["recipe_id"];
            $r->name = $row["name"];
            $r->tried = $row["tried"];
            $r->time_to_complete = $row["time_to_complete"];
            $r->set_category($row["cat_id"], $row["cat_descr"]);
            array_push($this->recipes, $r);
         }
         $this->dbmgr->disconnect();
      }
      $this->log->write("Cookbook->get_recipes_all() FINISHED => " . sizeof($this->recipes) . " recipes");
      return $this->recipes;
   }

   function search_recipes($table, $for="salt")
   {
      $this->log->write("Cookbook->search_recipies($table, $for) START");
      $this->dbmgr->connect();
      $this->recipes = Array();
      $for=addslashes($for);
      if(strcmp($table, "ingredients") == 0)
      {
         $sel = "SELECT r.recipe_id, r.name "
              . "FROM recipes r, ingredients ig, item_def id "
              . "WHERE id.item_descr like '%$for%' "
              . "AND ig.item_id = id.item_id "
              . "AND ig.recipe_id = r.recipe_id "
              . "GROUP BY r.recipe_id "
              . "ORDER BY r.name";
         $this->log->write($sel);
      }
      else if(strcmp($table, "titles") == 0)
      {
         $sel = "SELECT recipe_id, name FROM recipes where name like '%$for%'";
         $this->log->write($sel);
      }
      $this->dbmgr->query($sel);
      while($row = $this->dbmgr->fetch_assoc_array())
      {
         $r = new Recipe();
         $r->id = $row["recipe_id"];
         $r->name = $row["name"];
         array_push($this->recipes, $r);
      }   
      $this->dbmgr->disconnect();
      $this->log->write("Cookbook->search_recipies($table, $for) END");
      //return($sel);
   }
   
   function get_recipes_of_category($cat_id)
   {
      $this->log->write("Cookbook->get_recipes_of_category($cat_id) START");
      $this->dbmgr->connect();
      $this->a_category = new Category();
      $this->a_category->id = $cat_id;
      $this->a_category->db_load($this->dbmgr);
      $sel = "SELECT recipe_id, name "
           . "FROM recipes where cat_id = $cat_id "
           . "ORDER BY name";
      $this->dbmgr->query($sel);
      $this->log->write($sel);
      $this->recipes = array();
      while($row = $this->dbmgr->fetch_assoc_array())
      {
         $r = new Recipe();
         $r->id = $row["recipe_id"];
         $r->name = $row["name"];
         array_push($this->recipes, $r);
         $this->log->write($r->name);
      }   
      $this->dbmgr->disconnect();
      $this->log->write("Cookbook->get_recipes_of_category($cat_id) END");
   }
}
?>