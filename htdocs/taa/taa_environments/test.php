<?php
require_once("./objects/envtmgr.inc");
$mgr = new envtmgr();
echo("<br>db_load_schemas_tiers() => " . $mgr->db_load_schemas_tiers());
echo("<br>db_load_schemas_all() => " . $mgr->db_load_schemas_all());
echo("<br>db_load_mqs_all() => " . $mgr->db_load_mqs_all());

?>
