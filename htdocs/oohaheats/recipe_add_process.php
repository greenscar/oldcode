<?php
include("variables.inc");
require_once("./classes/Recipe.inc");
require_once("./classes/Secretary.inc");
if(empty($_POST["title"])){   
    header("Location: index.php");   
    exit();
}
$log = new Secretary();
$log->write("recipe_add_process.php START");
/*********************************************************** * Process form & create Recipe object **********************************************************/
$r = new Recipe();
$r->name = trim($_POST["title"]);
$log->write("recipe name = " . $r->name);
if(!empty($_POST["time_to_complete"]))
    $r->time_to_complete = trim($_POST["time_to_complete"]);
else
   $r->time_to_complete = 0;

$log->write("time_to_complete = " . $r->time_to_complete);
if(!empty($_POST["num_servings"]))   
    $r->num_servings = trim($_POST["num_servings"]);
else
   $r->num_servings = 0;
$r->category->id = $_POST["category"];
for($i=1; $i <= $num_ingredients; $i++)
{   
   if((!empty($_POST["qty_$i"])) && (!empty($_POST["msrmnt_$i"])) && (!empty($_POST["ingredient_$i"])))
   {
      $r->addIngredient($i, $_POST["qty_$i"], $_POST["msrmnt_$i"], $_POST["ingredient_$i"]);
   }
   else if((empty($_POST["qty_$i"])) && (empty($_POST["msrmnt_$i"])) && (!empty($_POST["ingredient_$i"])))
   {
      $r->addIngredientWOMeasurement($i, $_POST["ingredient_$i"]);
   }
}
for($i=1; $i <= $num_steps; $i++){   
   if(!empty($_POST["step_$i"]))      
    $r->addStep($_POST["step_$i"]);
}
/*********************************************************** * END Process form & create Recipe object **********************************************************/
/*********************************************************** * Insert Recipe object into DB **********************************************************/
echo($r->dbInsert());
/*********************************************************** * END Insert Recipe object into DB **********************************************************/   
$log->write("recipe_add_process.php END");
header("Location: index.php");   exit();
?>