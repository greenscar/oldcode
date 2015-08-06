<?php
   $title = "TIERS Apps";
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/Online_App.inc");
   require_once("./objects/Batch_App.inc");
   require_once("./objects/App_Server.inc");
   $em = new Envt_Mgr();
   include("header.inc");
?>
<div id="Content">
<h1 align="center">All Apps</h1>
<table border="0" align="center" cellpadding=0 cellspacing=0 width=1150px>
<tr>
   <th colspan=7>APPLICATION</th>
   <th colspan=3>SERVER</th>
   <th colspan=3>BATCH</th>
</tr>
<tr>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=id">APP ID</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=name">WS APP NAME</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=cluster">WS CLUSTER</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=cell">WS CELL NAME</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=dns">DNS</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=mq">MQ</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=ondb">DB</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=server_name01">WS SERVER NAME01</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=node01">WS NODE01</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=port01">WS PORT01</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=box">BOX</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=path">PATH</a></th>
   <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?ob=badb">DB</a></th>
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
   $num_apps = $em->db_load_tiers_apps(@$_GET["ob"]);
   $row_num = 0;
   foreach($em->apps_online AS $id=>$oa)
   //for($i = 0; $i < $num_apps; $i++)
   {
     // $oa = $em->apps_online[$i];
      $class = ((($row_num++) % 2) == 0) ? 'grey' : 'white';
      echo("<tr class=\"" . $class .  "\">\n");
      echo("<td class=\"data\">" . $oa->environment->name . "</td>");
      echo("<td class=\"data\">$oa->ws_app_name</td>");
      echo("<td class=\"data\">$oa->cluster</td>");
      echo("<td class=\"data\">$oa->cell</td>");
      echo("<td class=\"data\">$oa->dns</td>");
      echo("<td class=\"data\">" . $oa->mq->id . "</td>\n");
      echo("<td class=\"data\">" . $oa->schema->id . "</td>\n");
      //foreach($oa->AppServers AS $key=>$obj)
      foreach($oa->app_servers AS $key=>$as)
      {
         echo("<td class=\"data\">$as->server_name</td>");
         echo("<td class=\"data\">$as->node</td>");
         echo("<td class=\"data\">$as->port</td>");
      }
      $ba = @$em->batch_apps[$oa->environment->name];
      if(isset($ba))
      {
         echo("<td class=\"data\">" . $ba->box . "</td>\n");
         echo("<td class=\"data\">" . $ba->path . "</td>\n");
         echo("<td class=\"data\">" . $ba->schema->id . "</td>\n");
      }
      else
      {
         echo("<td class=\"data\" colspan=3 style=\"text-align:center; border-top: 2px solid black;border-bottom: 2px solid black;\">N/A</td>\n");
      }
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
