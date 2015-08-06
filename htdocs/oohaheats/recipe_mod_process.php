<?php
include("./variables.inc");
require_once("./classes/Recipe.inc");
if(empty($_POST["title"])){
   echo("empty");
   header("Location: ./index.php");
   exit();
}
session_start(); 
header("Cache-control: private"); // ie 6 fix
/***********************************************************
* Process form & create Recipe object *
*********************************************************/
$r = new Recipe();
$r->id = $_POST["id"];

if(strcmp($_POST["Submit"], "Delete") == 0)
{
   // DELETE RECIPE
   $r->db_delete();
}
else
{
   // PROCESSS MOD
   $r->name = $_POST["title"];
   if(!empty($_POST["time_to_complete"]))
      $r->time_to_complete = trim($_POST["time_to_complete"]);
   else
      $r->time_to_complete = 0;
   
   if(!empty($_POST["num_servings"]))
      $r->num_servings = trim($_POST["num_servings"]);
   else
      $r->num_servings = 0;$r->category->id = $_POST["category"];
      for($i=1; $i <= $num_ingredients; $i++){
         if((!empty($_POST["qty_$i"])) && (!empty($_POST["msrmnt_$i"])) && (!empty($_POST["ingredient_$i"])))
         {
            $r->addIngredient($i, $_POST["qty_$i"], $_POST["msrmnt_$i"], $_POST["ingredient_$i"]);
         }
         else if((empty($_POST["qty_$i"])) && (empty($_POST["msrmnt_$i"])) && (!empty($_POST["ingredient_$i"])))
         {
            $r->addIngredientWOMeasurement($i, $_POST["ingredient_$i"]);
         }
         else
         {
            break;
         }
      }
      
      
   
      
      
      
      for($i=1; $i <= $num_steps; $i++){
         if(empty($_POST["step_$i"]))
         break;
      $r->addStep($_POST["step_$i"]);
      }
   /***********************************************************
   * END Process form & create Recipe object
   **********************************************************/
   /***********************************************************
   * Insert Recipe object into DB *
   *********************************************************/
   $r->dbUpdate();
   $_SESSION['recipe'] = $r;
   //echo($r->dbInsert());
   /***********************************************************
   * END Insert Recipe object into DB *
   *********************************************************/
}
header("Location: recipe_display.php");
exit();
?>