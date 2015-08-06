<?php
   $title = "Modify App";   
   // DISPLAY ENVT TO MODIFY
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/Online_App.inc");
   require_once("./objects/App_Server.inc");
   $em = new Envt_Mgr();
   if(empty($_GET["id"]) && empty($_POST["envid"]))
   {
      include("header.inc");
      // DISPLAY ENVTS TO CHOOSE FROM
      ?>
      <div id="Content">
      <h1 align="center">TIERS Apps</h1>
      <table border="0" align="center" cellpadding=0 cellspacing=0 width=1200px>
      <tr>
         <th><a href="<?php echo( $_SERVER["PHP_SELF"]); ?>?cn=name">ENV NAME</a></th>
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
            echo("<tr class=\"" . (($row_num++) % 2) .  "\">\n");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">" . $oa->environment->name . "</a></td>");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">$oa->source_stream</a></td>");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">$oa->build_time</a></td>");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">$oa->cluster</a></td>");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">$oa->cell</a></td>");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">" . $oa->dns . "</a></td>");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">" . $oa->mq->id . "</a></td>");
            echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">" . $oa->schema->id . "</a></td>");
            foreach($oa->app_servers AS $key=>$obj)
            {
               echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">$obj->server_name</a></td>");
               echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">$obj->node</a></td>");
               echo("<td class=\"data\"><a href=\"" .  $_SERVER["PHP_SELF"] . "?id=" . $oa->environment->id . "\">$obj->port</a></td>");
            }
            echo("</tr>\n");
         }
      ?> 
      </table>
      </div>
      <?php
   }
   else if(isset($_POST["change_done"]))
   {
      // CHANGE HAD BEEN ENTERED INTO THE PAGE. PROCESS THE CHANGE.
      
      $em = new Envt_Mgr();
      $envid = @$_POST["envid"]; 
      $appid = @$_POST["appid"];
      $wsappname = @$_POST["wsappname"];
      $cluster = @$_POST["cluster"];
      $cell = @$_POST["cell"];
      $dns = @$_POST["dns"];
      $dbid = @$_POST["dbid"];
      $mqid = @$_POST["mqid"];
      $appserver_name = @$_POST["appserver_name"];
      $appserver_node = @$_POST["appserver_node"];
      $appserver_port = @$_POST["appserver_port"];
      /*
      * ENSURE ALL FORM VALUES WERE ENTERED. IF ANY WERE LEFT BLANK, REDISPLAY THE FORM.
      */
      if(!empty($envid) && !empty($appid) && !empty($wsappname) && !empty($cluster) && !empty($cell) 
         && !empty($dns) && !empty($dbid) && !empty($mqid) && !empty($appid)
         && !empty($appserver_name) && !empty($appserver_node) && !empty($appserver_port)) 
         
      {
         // PROCESS FORM ADDING APP TO DATABASE
         $res = $em->app_mod($envid, $appid, $wsappname, $cluster, $cell, $dns, $dbid, $mqid, $appid, $appserver_name, $appserver_node, $appserver_port);
         if($res)
         {
            echo("res = TRUE");
            //header("Location: apps_mod.php");   
            //exit();
         }
         else
         {
            echo("res = FALSE");
            //header($_SERVER["PHP_SELF"]);
            exit();
         }
      }
   }
   else
   {
      include("header.inc");
      // DISPLAY ENVT MOD PAGE
      $id = $_GET["id"];
      $envid = @$_POST["envid"]; 
      $appid = @$_POST["appid"];
      $wsappname = @$_POST["wsappname"];
      $cluster = @$_POST["cluster"];
      $cell = @$_POST["cell"];
      $dns = @$_POST["dns"];
      $dbid = @$_POST["dbid"];
      $mqid = @$_POST["mqid"];
      $appserver_name = @$_POST["appserver_name"];
      $appserver_node = @$_POST["appserver_node"];
      $appserver_port = @$_POST["appserver_port"];
         
      $em->db_load_single_online_app($id);
      $app = $em->apps_online[$id];
      $envid = $app->environment->id; 
      $appid = $app->id;
      $wsappname = $app->ws_app_name;
      $cluster = $app->cluster;
      $cell = $app->cell;
      $dns = $app->dns;
      $dbid = $app->schema->id;
      $mqid = $app->mq->id;
      if($app->get_server_count() == 1)
         $appserver = $app->app_servers[0];
      $appserver_name = $appserver->server_name;
      $appserver_node = $appserver->node;
      $appserver_port = $appserver->port;
      ?>
      <div id="Content">
      <h1 align="center">TIERS App Modify</h1>
      <form name="app_mod" method="post" action="app_mod.php">
         <input type="hidden" name="change_done" value="1">
         <table border="0" align="center" cellpadding=0 cellspacing=0 width="500px">
            <tr>
               <td>ENV NAME</td>
               <td>
                  <select name="envid">
                     <?php
                     $count = $em->db_load_envt_list();
                     echo("<option value=\"\"");
                     if(!isset($envid)) echo(" SELECTED");
                     echo(">SELECT YOUR ENV NAME</option>\n"); 
                     foreach($em->environments as $id => $envt)
                     {
                        echo("<option value=\"" . $envt->id . "\"");
                        if($envt->id == $envid)
                        {
                           echo(" SELECTED");
                        }  
                        echo(">" . $envt->name . "</option>\n");    
                     }
                     ?>
                  </select>
               </td>
            </tr>
            <tr>
               <td>APPLICATION</td>
               <td>
                  <select name="appid">
                     <?php
                     $count = $em->db_load_applications();
                     echo("<option value=\"\"");
                     if(!isset($appid)) echo(" SELECTED");
                     echo(">SELECT YOUR APP NAME</option>\n"); 
                     foreach($em->applications as $id => $name)
                     {
                        echo("<option value=\"" . $id . "\"");
                        if($id == $appid)
                        {
                           echo(" SELECTED");
                        }  
                        echo(">" . $name . "</option>\n");    
                     }
                     ?>
                  </select>
               </td>
            </tr>
            <tr>
               <td>WEBSPHERE APP NAME</td>
               <td><input type="text" name="wsappname" value="<?php echo($wsappname);?>"></td>
            </tr>
            <tr>
               <td>CLUSTER</td>
               <td><input type="text" name="cluster" value="<?php echo($cluster);?>"></td>
            </tr>
            <tr>
               <td>WS_CELL_NAME</td>
               <td><input type="text" name="cell" value="<?php echo($cell);?>"></td>
            </tr>
            <tr>
               <td>DNS</td>
               <td><input type="text" name="dns" value="<?php echo($dns);?>"></td>
            </tr>
            <tr>
               <td>MQ</td>
               <td>
                  <select name="mqid">
                     <?php
                     $em->db_load_MQs_all();
                     echo("<option value=\"\"");
                     if(!isset($mqid)) echo(" SELECTED");
                     echo(">SELECT YOUR MQ</option>\n"); 
                     foreach($em->MQs as $id => $a_mq)
                     {
                        echo("<option value=\"" . $a_mq->id . "\"");
                        if($a_mq->id == $mqid)
                        {
                           echo(" SELECTED");
                        }  
                        echo(">" . $a_mq->id . "</option>\n");    
                     }
                     ?>
                  </select>
               </td>
            </tr>
            <tr>
               <td>SERVER_NAME</td>
               <td><input type="text" name="appserver_name" value="<?php echo($appserver_name);?>"></td>
            </tr>
            <tr>
               <td>NODE</td>
               <td><input type="text" name="appserver_node" value="<?php echo($appserver_node);?>"></td>
            </tr>
            <tr>
               <td>PORT</td>
               <td><input type="text" name="appserver_port" value="<?php echo($appserver_port);?>"></td>
            </tr>
            <tr>
               <td>DB ID</td>     
               <td>
                  <select name="dbid">
                     <?php
                     $em->db_app = "ALL";
                     $em->db_order_by = "ENV_ID";
                     $em->db_load_schemas();
                     echo("<option value=\"\"");
                     if(!isset($dbid)) echo(" SELECTED");
                     echo(">SELECT YOUR DB</option>\n"); 
                     foreach($em->Schemas as $id => $schema)
                     {
                        echo("<option value=\"" . $schema->id . "\"");
                        if($schema->id == $dbid)
                        {
                           echo(" SELECTED");
                        }  
                        echo(">" . $schema->id . " (" . $schema->uid . "@" . $schema->db . ")</option>\n");        
                     }
                     ?>
                  </select>
               </td>
            </tr>
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr>
               <td colspan="2" align="center">
                  <input type="submit" name="Submit" value="Submit">
               </td>
            </tr>
         </table>
      </form>
      </div>   
      <?php
   }
   ?>
<?php 
//include("menu.inc"); 
?>
</body>
</html>
