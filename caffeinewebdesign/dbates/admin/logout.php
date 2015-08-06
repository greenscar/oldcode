<?
session_start();
header("Cache-control: private");//IE 6 Fix
require_once($_SERVER["DOCUMENT_ROOT"]."/classes/Security.inc");
$sec = new Security();
if($sec->destroy_session($_SESSION))
   header("Location: http://" . $_SERVER["SERVER_NAME"] . "/index.php");
else
   echo("There was an error. You are still logged in.");
?> 