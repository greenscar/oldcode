<?php
   $title = "Recipe Mod";
   $require_admin=true;
   include("header.inc");
?>
<div id="autosuggest"><ul></ul></div>
<div id="Content" style="text-align: center;">
<?php
   if(empty($_GET["id"]))
   {
      // DISPLAY RECIPES TO CHOOSE FROM
      require_once("./classes/Cookbook.inc");
      $cookbook = new Cookbook();
      $recipe_list = $cookbook->get_recipes_all();
      foreach($recipe_list as $id=>$recipe)
      {
         echo("<a href=\"recipe_mod.php?id=" . $recipe->id . "\">" . $recipe->name . "</a><BR>");
      }
   }
   else
   {
      // DISPLAY RECIPE TO MOD
      include("./variables.inc");
      require_once("./classes/Recipe.inc");
      $r = new Recipe();
      $r->id = $_GET["id"];
      $r->db_load();
      ?>
      <form name="modForm" method="post" action="recipe_mod_process.php">
         <input type="hidden" name="id" value="<?=$r->id?>">
         <table border="0" cellspacing="3" cellpadding="3">
         <tr>
         <td style="width:50%;" align="right">Title</td>
         <td style="width:50%;">
         <input name="title" type="text" id="title" size="30" value="<?=$r->name?>">
         </td>
         </tr>
         <tr>
             <td align="right">Category</td>
             <td>
                 <select name="category">
                     <?php
                         require_once("./classes/Cookbook.inc");
                         $cookbook = new Cookbook();
                         $cats = $cookbook->get_categories();
                         $msrmnts = $cookbook->get_measurements();
                         foreach($cats as $cat)
                         {
                            echo("<option value=\"" . $cat->id . "\"");
                            if($cat->id == $r->category->id)
                                echo(" selected ");
                            echo(">" . $cat->descr . "</option>\n");
                         }
                     ?>
                 </select>
             </td>
         </tr>
         <tr>
            <td align="right">
                Time to Complete
            </td>
            <td>
                <input name="time_to_complete" type="text" id="time_to_complete" value="<?=$r->time_to_complete?>">
            </td>
         </tr>
         <tr>
            <td align="right">Number of Servings:</td>
            <td><input name="num_servings" type="text" id="num_servings" value="<?=$r->num_servings?>"></td>
         </tr>
         <tr>
            <td colspan="2"><h1>INGREDIENTS</h1></td>
         </tr>
        <?php
        for($i=1; $i<=$num_ingredients; $i++)
        {
            if(isset($r->ingredients[$i-1]))
               $ingredient = $r->ingredients[$i-1];
            else
               $ingredient = null;
            ?>
            <tr>
            <td align="right">
            <input name="qty_<?=$i?>" type="text" id="qty_<?=$i?>" value="<?php if(isset($ingredient)) { echo($r->ingredients[$i-1]->quantity);} ?>" size="5" maxlength="6">                  
            <input type="text" name="msrmnt_<?=$i?>" id="msrmnt_<?=$i?>" value="<?php if(isset($ingredient)) { echo($ingredient->measurement->descr); } ?>">
            <script language="Javascript">
                var msrmnt_<?php echo("$i"); ?>s = new Array(<?php
                for($j = 0; $j < sizeof($msrmnts); $j++)
                {
                    $x = $msrmnts[$j];
                    echo("\"" . $x->descr . "\"");
                    if(($j+1) < sizeof($msrmnts)) echo(", ");
                }
                ?>);
                new AutoSuggest(document.getElementById('msrmnt_<?=$i?>'),msrmnt_<?=$i?>s);
            </script>                       
            </td>
            <td>
            <input name="ingredient_<?=$i?>" type="text" id="ingredient_<?=$i?>" value="<?php if(isset($ingredient)) { echo($ingredient->item->descr); } ?>" class="ingredient" maxlength="50">
            </td>
            </tr>
            <?
                       }
                       ?>
                       <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                       </tr>
                       <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                       </tr>
                       <tr>
                       <td colspan="2"><h1>STEPS</h1></td>
                       </tr>
                       <?php
                       for($i=1; $i <= $num_steps; $i++)
                       {
                          ?>
                          <tr>
                          <td align="center" colspan=2><?=$i?>)
                          <textarea name="step_<?=$i?>" cols="50" rows="3" id="step_<?php echo($i); ?>"><?php if(isset($r->steps[$i-1])) { echo($r->steps[$i-1]);} ?></textarea></td>
                          </tr>            
                       <?php            
                       }            
                       ?>
                          <tr>
                          <td colspan="2" align="center">
                          <input type="submit" name="Submit" value="Submit">
                          <input type="submit" name="Submit" value="Delete" onclick="return verify('<?php echo($r->name); ?>')">
                          </td>
                          </tr>
                          </table>
                          </form>
      <?php
   }
?>
</div>
<?php include("menu.inc"); ?>
</body>
</html>