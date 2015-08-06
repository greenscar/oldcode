<?php
   $title = "Framework Pages";
   require_once("./objects/Schema.inc");
   require_once("./objects/Db_Mgr_Oracle.inc");
   $db_mgr = new Db_Mgr_Oracle();
   $order_by = @$_GET["order_by"];
   $query = "SELECT PAGE_ID, PAGE_TITLE, SESN_EJB_NM, METHOD_NAME, METHOD_SIGNATURE FROM  v_fw_pages_prod"; //ENV_ID, 
   if(isset($order_by)) $query .= " order by $order_by";
   
   $str = "<html xmlns=\"http://www.w3.org/1999/xhtml\">
         <head>
             <meta http-equiv=\"content-type\" content=\"text/html; charset=iso-8859-1\" />
             <title>Production Framework Pages</title>
             <style type=\"text/css\" media=\"all\">@import \"./style.css\";</style>
         </head>
         
         <body>
         ";
   $str .= "<div id=\"Content\">";
   $str .= "<h1 align=\"center\">Production's FW_PAGES</h1>";
   $str .= "<table border=\"0\" align=\"center\" cellpadding=0 cellspacing=0>";
   $db_mgr->connect();
   $db_mgr->query($query);
   $num_cols = $db_mgr->get_num_fields();
   
   $str .= "<tr>\n";
   for($i=0; $i < $num_cols; $i++)
   {
      $column_name = $db_mgr->get_field_name($i+1);
      $str .= "<th><a href=\"" . $_SERVER["PHP_SELF"] . "\">$column_name</a></th>";   
   }
   $str .= "</tr>\n";
   $row_num = 0;
   while($row = $db_mgr->fetch_assoc_array())
   {
      $class = ((($row_num++) % 2) == 0) ? 'grey' : 'white';
      $str .= "<tr class=\"" . $class .  "\">\n";
      $str .= "\n<td class=\"data\">" . $row["PAGE_ID"] . "</td>\n";
      $str .= "\n<td class=\"data\">" . $row["PAGE_TITLE"] . "</td>\n";
      $str .= "\n<td class=\"data\">" . $row["SESN_EJB_NM"] . "</td>\n";
      $str .= "\n<td class=\"data\">" . $row["METHOD_NAME"] . "</td>\n";
      $str .= "\n<td class=\"data\">" . $row["METHOD_SIGNATURE"] . "</td>\n";
      $str .= "<tr>\n";
   }
   $db_mgr->disconnect();
   $str .= "\n</table>\n</div></body>\n</html>";
   $handle = fopen("/opt/csw/apache2/share/htdocs/workbench/sections/content/environments/fw_pages.htm", "w");
   fwrite($handle, $str);
   fclose($handle);
?>


