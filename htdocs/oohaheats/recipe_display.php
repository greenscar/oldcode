<?php
if(empty($_GET["id"]))
{   header("Location: index.php");   exit();
}
require_once("./classes/Recipe.inc");
$r = new Recipe();
$r->id = $_GET["id"];
$r->db_load();
$r->db_increase_num_views();
$title = $r->name;
include("header.inc");
?>

<div id="Content">
   <h1 align="center"><?=$r->name?></h1>
   <table border=0  align="center" width="600px">
   <tr>
      <th>Category: <?=$r->category->descr?></th>
   </tr>
   <tr>
      <th>Time to Complete: <?=$r->time_to_complete?></th>
   </tr>
   <tr>
      <th># of servings: <?=$r->num_servings?></th>
   </tr>
   <tr><td>&nbsp;</td></tr>
   <tr>
      <th>INGREDIENTS</th>
   </tr>
   <tr>
      <td>
         <ul>
<?php
foreach($r->ingredients as $i)
{
   echo("<li>\n");
   if(!empty($i->quantity) && (!empty($i->measurement)))
   {
      echo($i->quantity . "&nbsp;" . $i->measurement->descr. "&nbsp;");
   }
   echo($i->item->descr);
   echo("</li>\n");
}
?>
      </td>
   </tr>
   <tr><td>&nbsp;</td></tr>
   <tr>
      <th>INSTRUCTIONS</th>
   </tr>
   <tr>
      <td>
      <ol>
<?php
foreach($r->steps as $n=>$s)
{
   ?>
         <li><?=$s?></li>
   <?php
}
?>
      </ol>
      </td>
   </tr>
</table>
<?php
if(isset($_SESSION['user']))
{
   ?>
   <br>
   <p align="center">
      <a href="recipe_mod.php?id=<?=$r->id?>">Modify</a><br>
   </p>
   <?php
}
?>
</div>

<?php include("menu.inc"); ?>
</body>
</html>