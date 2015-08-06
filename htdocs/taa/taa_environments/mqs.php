<?php
   $title = "TIERS Related MQs";
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/MQ.inc");
   $em = new Envt_Mgr();
   $a_mq = new MQ();
   include("header.inc");
?>
<div id="Content">
<h1 align="center">TIERS MQs</h1>
<table border="0" align="center" cellpadding=0 cellspacing=0>
<?php
   $num_mqs = $em->db_load_MQs_all(@$_GET["cn"]);
   $cols = $a_mq->get_variables();
   $num_cols = sizeof($cols);
   echo("<tr>\n");
   for($i=0; $i < $num_cols; $i++)
   {
      $column_name = strtoupper($cols[$i]);
      echo "<th><a href=\"" . $_SERVER["PHP_SELF"] . "?cn=$column_name\">$column_name</a></th>";   
   }
   echo("</tr>\n");
   for($i=0, $row_num=0; $i < $num_mqs; $i++)
   {
      $a_mq = $em->mqs[$i];
      $class = ((($row_num++) % 2) == 0) ? 'grey' : 'white';
      echo("<tr class=\"" . $class .  "\">\n");
      echo("<td class=\"data\">" . $a_mq->id . "</td>\n");
      echo("<td class=\"data\">" . $a_mq->host  . "</td>\n");
      echo("<td class=\"data\">" . $a_mq->port  . "</td>\n");
      echo("<td class=\"data\">" . $a_mq->mgw . "</td>\n");
      echo("<td class=\"data\">" . $a_mq->channel . "</td>\n");
      echo("<td class=\"data\">" . $a_mq->date_start . "</td>\n");
      echo("<td class=\"data\">" . $a_mq->date_end . "</td>\n");
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
