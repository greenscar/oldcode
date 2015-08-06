<?php
   $title = "TIERS Online Apps";
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/Online_App.inc");
   require_once("./objects/App_Server.inc");
   $em = new Envt_Mgr();
   include("header.inc");
?>
<div id="Content">
<h1 align="center">Online Apps</h1>
<table border="0" align="center" cellpadding=0 cellspacing=0 width="1350px">
<tr>
<tr>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=name">ENV NAME</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=name">APPLICATION</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=name">SOURCE STREAM</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=name">BUILD TIME</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=cluster">CLUSTER</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=cell">WS_CELL_NAME</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=dns">DNS</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=mq">MQ</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=schema">SCHEMA</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=server_name01">SERVER_NAME01</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=node01">NODE01</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=port01">PORT01</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=test">Test</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=admin">WebSphere</a></th>
<?php
/*
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=server_name02">SERVER_NAME02</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=node02">NODE02</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=port02">PORT02</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=DATE_START02">DATE START 02</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=DATE_END02">DATE END 02</a></th>
*/

?>
</tr>
<?php
   $num_apps = $em->db_load_apps_online(@$_GET["cn"]);
   $row_num = 0;  
   foreach($em->apps_online AS $id=>$oa)
   {
      $class = ((($row_num++) % 2) == 0) ? 'grey' : 'white';
      echo("<tr class=\"" . $class .  "\">\n");
      echo("<td class=\"data\">" . $oa->environment->name . "</td>\n");
      echo("<td class=\"data\">" . $oa->application->name . "</td>\n");
      echo("<td class=\"data\">$oa->source_stream</td>\n");
      echo("<td class=\"data\">$oa->build_time</td>\n");
      echo("<td class=\"data\">$oa->cluster</td>\n");
      echo("<td class=\"data\">$oa->cell</td>\n");
      echo("<td class=\"data\"><a href=\"" . $oa->get_login_page() . "\" target=\"_blank\">" . $oa->dns . "</a></td>\n");
      echo("<td class=\"data\">" . $oa->mq->id . "</td>\n");
      echo("<td class=\"data\">" . $oa->schema->id . "</td>\n");
      foreach($oa->app_servers AS $key=>$obj)
      {
         echo("<td class=\"data\">$obj->server_name</td>\n");
         echo("<td class=\"data\">$obj->node</td>\n");
         echo("<td class=\"data\">$obj->port</td>\n");
      }
      echo("<td class=\"data\"><a href=\"" . $oa->get_envt_test_link() . "\" target=\"_blank\">" . $oa->dns . "</a></td>\n");
      echo("<td class=\"data\" align=\"center\"><a href=\"" . $oa->admin_panel. "\" target=\"_blank\">Admin</a></td>\n");
      echo("</tr>\n");
   }
?> 
<!--
<tr><td colspan=14 style="border-top:2px solid #000000;">&nbsp;</td></tr>
<tr><td colspan=14 align="center" style="padding: 5px 0px 5px 0px;"><a href="app_add.php">Add an App</a>&nbsp;|&nbsp;<a href="app_mod.php">Modify an App</a></td></tr>
-->
</table>
</div>
   
<?php
// include("menu.inc"); 
   //include("footer.inc");
?>
</body>
</html>
