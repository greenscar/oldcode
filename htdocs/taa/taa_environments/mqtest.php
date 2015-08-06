<?php
   $title = "TIERS Databases";
   require_once("./objects/Envt_Mgr.inc");
   require_once("./objects/MQ.inc");
   $em = new Envt_Mgr();
   $em->db_load_mqs();
   $a_mq = new MQ();
   include("header.inc");
?>
<?php 
//include("menu.inc"); 
?>
</body>
</html>
