<?php
// If the session isn't set, the user came here directly.
// Forward the user to the login.
require_once("../classes/Client.inc");
require_once("../classes/Security.inc");
require_once("../classes/DB_Mgr.inc");
session_start();
header("Cache-control: private");//IE 6 Fix
$security = new Security();
$dbmgr = new DB_Mgr("dbates");
$client = $security->session_get_client($_SESSION);
if(!$client)
{
   $goTo = "Location: http://" . $_SERVER["SERVER_NAME"];
   header($goTo);

}
?>