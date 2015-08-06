<?php
// If the session isn't set, the user came here directly.
// Forward the user to the login.
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Admin.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Security.inc");
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/DB_Mgr.inc");
session_start();
header("Cache-control: private");//IE 6 Fix
$security = new Security();
$dbmgr = new DB_Mgr("dbates");
$admin = $security->session_get_root($_SESSION);
if(!$admin)
{
   $goTo = "Location: http://" . $_SERVER["SERVER_NAME"];
   header($goTo);
}
?>