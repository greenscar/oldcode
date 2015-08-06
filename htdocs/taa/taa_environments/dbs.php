<?php
   $title = "TIERS Databases";
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/Schema.inc");
   $em = new Envt_Mgr();
   $aSchema = new Schema();
   $rel_num = @$_GET["rel_num"];
   $order_by = @$_GET["order_by"];
   if((strcmp($order_by, "CONNECT_PASSWORD") == 0) || (strcmp($order_by, "HOST_PORT") == 0))
      $order_by = "ENV_ID";
   $app = $_GET["app"];
   include("header.inc");
?>
<div id="Content">
<h1 align="center">
<?php
   if(isset($env)) echo($env . " ");
   echo("Databases");
   if((isset($rel_num)) & (strcmp("ALL", $rel_num) != 0)) echo(" release $rel_num");
   if(isset($order_by)) echo(" sorted by $order_by");
?>
</h1>
<table border="0" align="center" cellpadding=0 cellspacing=0>
<?php
   if(isset($order_by)) $em->db_order_by = $order_by;
   if(isset($rel_num)) $em->db_release_num = $rel_num;
   if(isset($app)) $em->db_app = $app;
   $num_schemas = $em->db_load_schemas();
   $cols = array("ENV_ID", "BUILD_NUM", "NAME", "HOST_STRING", "HOST_NAME", "HOST_PORT", "CONNECT_ACCOUNT", "CONNECT_PASSWORD");
   echo("<tr>\n");
   foreach($cols as $id=>$column_name)
   {
      echo "<th><a href=\"" . $_SERVER["PHP_SELF"] . "?order_by=$column_name";
      if(isset($app)) echo("&app=$app");
      if(isset($rel_num)) echo("&rel_num=" . $rel_num);
      echo"\">$column_name</a></th>";
   }
   /*
   $num_cols = $em->db_mgr_ora->get_num_fields();
   for($i=0; $i < $num_cols; $i++)
   {
      $column_name = $em->db_mgr_ora->get_field_name($i+1);
      echo "<th><a href=\"" . $_SERVER["PHP_SELF"] . "?order_by=$column_name";
      if(isset($app)) echo("&app=$app");
      if(isset($rel_num)) echo("&rel_num=" . $rel_num);
      echo"\">$column_name</a></th>";   
   }
   */
   echo("</tr>\n");
   $row_num = 0;
   foreach($em->Schemas AS $id=>$aSchema)
   {
      $class = ((($row_num++) % 2) == 0) ? 'grey' : 'white';
      echo("<tr class=\"" . $class .  "\">\n");
      echo("<td class=\"data\">" . $aSchema->id . "</td>\n");
      echo("<td class=\"data\">" . $aSchema->version  . "</td>\n");
      echo("<td class=\"data\">" . $aSchema->descr . "</td>\n");
      echo("<td class=\"data\">" . $aSchema->db . "</td>\n");
      echo("<td class=\"data\">" . $aSchema->box . "</td>\n");
      echo("<td class=\"data\">" . $aSchema->port . "</td>\n");
      echo("<td class=\"data\">" . $aSchema->uid . "</td>\n");
      echo("<td class=\"data\">" . $aSchema->pwd . "&nbsp;</td>\n");
      echo("</tr>\n");      
   }
?> 
</table>
<?php
   $em->db_load_db_release_nums();
?>
<hr>
<table border="0" align="center" cellpadding=0 cellspacing=0>
<tr><th colspan="<?php echo( sizeof($em->release_nums) + 1); ?>">View Based on Release:</th></tr>
   <tr>
   <?php
      echo("<td class=\"data\"><a href=\"" . $_SERVER["PHP_SELF"] . "?rel_num=ALL");   
      if(isset($app)) echo("&app=$app");  
      if(isset($order_by)) echo("&order_by=$order_by");
      echo("\">ALL</a></td>");
      for($i=0; $i<sizeof($em->release_nums); $i++)
      {
         $release_num = $em->release_nums[$i];
         echo("<td class=\"data\"><a href=\"" . $_SERVER["PHP_SELF"] . "?rel_num=$release_num");
         if(isset($app)) echo("&app=$app");
         if(isset($order_by)) echo("&order_by=$order_by");
         echo("\">$release_num</a></td>");
      }
   ?>
   </tr>
</table>
<table border="0" align="center" cellpadding=0 cellspacing=0>
<tr><th colspan="<?php echo(sizeof($em->get_app_list()) + 1); ?>">View Based on App:</th></tr>
   <tr>
   <?php
      echo("<td class=\"data\"><a href=\"" . $_SERVER["PHP_SELF"] . "?app=ALL");   
      if(isset($rel_num)) echo("&rel_num=$rel_num");
      if(isset($order_by)) echo("&order_by=$order_by");
      echo("\">ALL</a></td>");
      $app_list = $em->get_app_list();
      for($i=0; $i<sizeof($app_list); $i++)
      {
         $app = $app_list[$i];
         echo("<td class=\"data\"><a href=\"" . $_SERVER["PHP_SELF"] . "?app=$app");
         if(isset($rel_num)) echo("&rel_num=$rel_num");
         if(isset($order_by)) echo("&order_by=$order_by");
         echo("\">$app</a></td>");
      }
   ?>
   </tr>
</table>
</div>

<?php 
//include("menu.inc"); 
?>
</body>
</html>
