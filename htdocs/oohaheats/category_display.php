<?php
if(empty($_GET["id"]))
{   header("Location: index.php");   exit();
}
$title = $_GET["name"];
include("header.inc");
?>

<div id="Content">
<?php
   require_once("./classes/Cookbook.inc");
   $c = new Cookbook();
   $c->get_recipes_of_category($_GET["id"]);
   $recipe_list = $c->recipes;
   echo("<h1 align=\"center\">" . $c->a_category->descr . "</h1>");
   foreach($recipe_list as $id=>$recipe)
   {
      echo("<a href=\"recipe_display.php?id=" . $recipe->id . "\">" . $recipe->name . "</a><BR>");
   }
?>
</div>

<?php include("menu.inc"); ?>
</body>
</html>