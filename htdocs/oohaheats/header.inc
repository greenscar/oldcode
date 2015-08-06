<?php
session_start(); 
header("Cache-control: private"); // ie 6 fix
if(!empty($require_admin))
{
   if($require_admin)
   {
      if(!(isset($_SESSION['user'])))
      {
         header("Location: index.php");
         exit();
      }
   }
}
include("variables.inc");
?>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <script type="text/javascript" src="script.js"></script>
    <script language="Javascript" src="autosuggest.js"></script>
    <meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
    <title><?=$title?></title>
    <style type="text/css" media="all">@import "style.css";</style>
</head>

<body>

<div id="Header"><a href="http://www.oohaheats.com/" title="Ooh Ah Eats Home">OohAhEats.com</a></div>
