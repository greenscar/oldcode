<?php
   $title = "Add App";
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/Online_App.inc");
   require_once("./objects/App_Server.inc");
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
      && !empty($appserver_name) && !empty($appserver_node) && !empty($appserver_port) && ($em->is_whole_number($appserver_port)))
   {
      // PROCESS FORM ADDING APP TO DATABASE
      $result = $em->insert_new_app($envid, $appid, $wsappname, $cluster, $cell, $dns, $dbid, $mqid, $appid, $appserver_name, $appserver_node, $appserver_port);
      echo("result = $result");
      if((strlen($result) > 10) && (@substr_compare($result, "$wsappname already exists.", 24)))
      {
         //header("Location: " . $_SERVER["PHP_SELF"]);
         //exit();
         ?>
         <HTML>
         <HEAD>
         <TITLE>That app already exists.</TITLE>
         <SCRIPT Language="JavaScript">
         <!--
         function move(x){
            //history.go(x);         
         }
         //-->
         </SCRIPT>
         </HEAD>
         <BODY onLoad="setTimeout('move(-1)',1000);">
            <h1><?php echo($result); ?></h1>
         </BODY>
         </HTML>
         <?
         exit();
         //echo("compare results = " . substr_compare($result, "$wsappname already exists.", 24) . "<BR>");
      }
      else if(strcmp($result, true) == 0)
      {
         header("Location: apps_online.php");
         exit();
      }
      else
      {
         echo("There has been an error");
      }
   }
   else
   {  
   include("header.inc");
?>
<div id="Content">
<h1 align="center">App Add</h1>
   <?php
   if(empty($envid) || empty($wsappname) || empty($cluster) || empty($cell) || empty($dns) 
      || empty($appserver_name) || empty($appserver_node) || empty($appserver_port) || empty($dbid) || empty($mqid) || empty($appid))
   {
      echo("<h3 style=\"color:red; text-align:center;\">You must enter all values</h1>");
   }
   if(!$em->is_whole_number($appserver_port))
   {
      echo("<h3 style=\"color:red; text-align:center;\">The PORT must be an integer.</h1>");
   }
   ?>
   <form name="app_add" method="post" action="app_add.php">
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
            <td>
               <select name="cellid">
                  <?php
                  $count = $em->db_load_cells();
                  echo("<option value=\"\"");
                  if(!isset($cellid)) echo(" SELECTED");
                  echo(">SELECT YOUR WS_CELL_NAME NAME</option>\n"); 
                  foreach($em->cells as $id => $name)
                  {
                     echo("<option value=\"" . $id . "\"");
                     if($id == $cellid)
                     {
                        echo(" SELECTED");
                     }  
                     echo(">" . $name . "</option>\n");    
                  }
                  ?>
               </select>
            </td>
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
  include("menu.inc"); ?>
</body>
</html>
