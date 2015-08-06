<?php
if(empty($_POST["id"]) || empty($_POST["pwd"]))
{   header("Location: index.php");   exit();
}
require_once("./classes/Cookbook.inc");
$c = new Cookbook();
$result = $c->process_login($_POST["id"], $_POST["pwd"]);
//echo("result = '$result'<br>");
if($result)
{
   session_start(); 
   header("Cache-control: private"); // ie 6 fix
   $_SESSION['user'] = $result;
}
else
{
   session_unregister("user");
   //session_destroy();
}header("Location: index.php");exit();
?>