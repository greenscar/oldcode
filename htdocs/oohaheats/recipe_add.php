<?php
   $title = "Create a Recipe";
   $require_admin=true;
   include("header.inc");
?>
<div id="autosuggest"><ul></ul></div>
<div id="Content" style="text-align: center;">
   <h1>Create a Recipe</h1>   
   <form name="form1" method="post" action="recipe_add_process.php">   
   <table border="0" cellspacing="3" cellpadding="3">      
   <tr>         
   <th>Title:&nbsp; 
   <input name="title" type="text" id="title" size="30"></th>      
   </tr>      
   <tr>         
   <th>Category:&nbsp;            
   <select name="category">             
   <?php               
   require_once("./classes/Cookbook.inc");               
   $cookbook = new Cookbook();               
   $cats = $cookbook->get_categories();   
   $msrmnts = $cookbook->get_measurements();
   foreach($cats as $cat)               
   {                  
       echo("<option value=\"" . $cat->id . "\">" . $cat->descr . "</option>\n");               
   }               
   ?>            
   </select>         
   </th>      
   </tr>      
   <tr>         
   <th>Time to Complete: &nbsp;<input name="time_to_complete" type="text" id="time_to_complete"></th>      
   </tr>      
   <tr>         
   <th>Number of Servings:&nbsp;<input name="num_servings" type="text" id="num_servings"></th>      
   </tr>      
   <tr>         
   <th><div align="center">INGREDIENTS</div></th>      </tr>      <tr>         <td>
         <ul>
         <?php      
         for($i=1; $i<=$num_ingredients; $i++)      
         {         
            ?>
            <li>
            <input name="qty_<?=$i?>" type="text" id="qty_<?=$i?>" size="5" maxlength="10">
            <input type="text" name="msrmnt_<?=$i?>" id="msrmnt_<?=$i?>">
            <script language="Javascript">
			var msrmnt_<?=$i?>s = new Array(<?php
            for($j = 0; $j < sizeof($msrmnts); $j++)
            {
                $x = $msrmnts[$j];
                echo("\"" . $x->descr . "\"");
                if(($j+1) < sizeof($msrmnts)) echo(", ");
            }
            ?>);
			new AutoSuggest(document.getElementById('msrmnt_<?=$i?>'),msrmnt_<?=$i?>s);
		</script>
<?php
            /*            
            <select name="msrmnt_<?=$i?>">            
            <?php            
            $amts = $cookbook->getMeasurements();            
            foreach($amts as $amt)            
            {            
                echo("<option value=\"" . $amt->id . "\">" . $amt->descr . "</option>\n");
            }
            ?>
            </select>
            */
?>
            <input name="ingredient_<?=$i?>" type="text" id="ingredient_<?=$i?>" class="ingredient" maxlength="200">
            </li>
         <?      }      ?>
         </ul>
         </td>
         </tr>
         <tr>
         <td>&nbsp;</td>
         </tr>
         <tr>
         <td>&nbsp;</td>
         </tr>
         <tr>
         <td><div align="center">STEPS</div></td>
         </tr>
         <tr>
         <td>
         <ol>
         <?php
         for($i=1; $i <= $num_steps; $i++)      {         ?>
         <li>
         <textarea name="step_<?=$i?>" cols="65" rows="3" id="step_<?=$i?>"></textarea>
         </li>      
         <?php      }      ?>
         </ol>
         </td>
         </tr>
         <tr>
         <td colspan="2" align="center">   <input type="submit" name="Submit" value="Submit">   </td>   </tr>   </table>   </form>
</div>
<?php include("menu.inc"); ?>
</body>
</html>
