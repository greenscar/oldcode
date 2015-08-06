<?php
   $title = "TIERS Batch Apps";
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/Batch_App.inc");
   $em = new Envt_Mgr();
   $ba = new Batch_App();
   include("header.inc");
?>
<div id="Content">
<h1 align="center">TIERS Batch Apps</h1>
<table border="0" align="center" cellpadding=0 cellspacing=0>
<tr>
   <th><a href="<?php echo($_SERVER["PHP_SELF"]); ?>?cn=id">ENV NAME</a></th>
   <th><a href="<?php echo($_SERVER["PHP_SELF"]); ?>?cn=path">PATH</a></th>
   <th><a href="<?php echo($_SERVER["PHP_SELF"]); ?>?cn=box">BOX</a></th>
   <th><a href="<?php echo($_SERVER["PHP_SELF"]); ?>?cn=schema">SCHEMA</a></th>
   <th><a href="<?php echo($_SERVER["PHP_SELF"]); ?>?cn=mq">MQ</a></th>
</tr>
<?php
   if(isset($_GET["cn"]))
      $orderby = $_GET["cn"];
   else
      $orderby = "id";
   $num_batch = $em->db_load_batch_apps($orderby);
   $row_num = 0;
   foreach($em->batch_apps AS $id=>$ba)
   {
   //for($i = 0; $i < $num_batch; $i++)
      //$aBatch = $em->batch_apps[$i];
      $class = ((($row_num++) % 2) == 0) ? 'grey' : 'white';
      echo("<tr class=\"" . $class .  "\">\n");
      echo("<td class=\"data\">" . $ba->env_name . "</td>\n");
      echo("<td class=\"data\">" . $ba->path  . "</td>\n");
      echo("<td class=\"data\">" . $ba->box  . "</td>\n");
      echo("<td class=\"data\">" . $ba->schema->id . "</td>\n");
      echo("<td class=\"data\">" . $ba->mq->id . "</td>\n");
      echo("</tr>\n");      
   }
?> 
</table>
</div>   
<?php 
//include("menu.inc"); 
?>
</body>
</html>
