<?php
if((empty($_POST["titles"])) && (empty($_POST["ingredients"]))){   header("Location: index.php");   exit();}
if(!(empty($_POST["titles"]))){$title = "Ooh Ah Eats - Recipes with " . $_POST["titles"] . " in the title";
include("header.inc");
?>
<div id="Content">
<h1>Recipes containing <?=$_POST["titles"]?> in the title</h1>
<?php
   include("variables.inc");
   require_once("./classes/Cookbook.inc");
   $c = new Cookbook();
   $t = $c->search_recipes("titles", $_POST["titles"]);
   echo $t . "<BR>";
   $recipe_list = $c->recipes;
   foreach($recipe_list as $id=>$recipe)
   {
      echo("<a href=\"recipe_display.php?id=" . $recipe->id . "\">" . $recipe->name . "</a><BR>");
   }
}
if(!(empty($_POST["ingredients"]))){
$title = "Ooh Ah Eats - Recipies that use " . $_POST["ingredients"];
include("header.inc");
?>
<div id="Content">
<h1>Recipes containing <?=$_POST["ingredients"]?> as an ingredient</h1>
<?php
   include("variables.inc");
   require_once("./classes/Cookbook.inc");
   
   $c = new Cookbook();
   $t = $c->search_recipes("ingredients", $_POST["ingredients"]);
   echo $t . "<BR>";
   $recipe_list = $c->recipes;
   foreach($recipe_list as $id=>$recipe)
   {
      echo("<a href=\"recipe_display.php?id=" . $recipe->id . "\">" . $recipe->name . "</a><BR>");
   }
}
?>
</div>

<?php include("menu.inc"); ?>
</body>
</html>