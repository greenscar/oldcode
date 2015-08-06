
<?php
   $title = "Framework Pages";
   require_once("./objects/Schema.inc");
   require_once("./objects/Db_Mgr_Oracle.inc");
   $db_mgr = new Db_Mgr_Oracle();
   $order_by = @$_GET["order_by"];
   $query = "SELECT PAGE_ID, PAGE_TITLE, SESN_EJB_NM, METHOD_NAME, METHOD_SIGNATURE FROM  v_fw_pages_prod"; //ENV_ID, 
   if(isset($order_by)) $query .= " order by $order_by";
   include("header.inc");
?>
<div id="Content">
<h1 align="center">Production's FW_PAGES<?php if(isset($order_by)) echo " order by $order_by";?> </h1>
<table border="0" align="center" cellpadding=0 cellspacing=0>
<?php
   $db_mgr->connect();
   $db_mgr->query($query);
   $num_cols = $db_mgr->get_num_fields();
   
   echo("<tr>\n");
   for($i=0; $i < $num_cols; $i++)
   {
      $column_name = $db_mgr->get_field_name($i+1);
      echo "<th><a href=\"" . $_SERVER["PHP_SELF"] . "?order_by=$column_name";
      echo"\">$column_name</a></th>";   
   }
   echo("</tr>\n");
   $row_num = 0;
   while($row = $db_mgr->fetch_assoc_array())
   {
      $class = ((($row_num++) % 2) == 0) ? 'grey' : 'white';
      echo("<tr class=\"" . $class .  "\">\n");
      echo("\n<td class=\"data\">" . $row["PAGE_ID"] . "</td>\n");
      echo("\n<td class=\"data\">" . $row["PAGE_TITLE"] . "</td>\n");
      echo("\n<td class=\"data\">" . $row["SESN_EJB_NM"] . "</td>\n");
      echo("\n<td class=\"data\">" . $row["METHOD_NAME"] . "</td>\n");
      echo("\n<td class=\"data\">" . $row["METHOD_SIGNATURE"] . "</td>\n");
      echo("<tr>\n");
   }
   $db_mgr->disconnect();
?> 
</table>
</div>

<?php 
//include("menu.inc"); 
?>
</body>
</html>
