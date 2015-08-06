<?
include("header.inc");
$category= nl2br($_POST["category"]);
mysql_connect("$DBHost","$DBUser","$DBPass");
mysql_query("INSERT INTO category VALUES('$category','')") or die("Error: mysql said " . mysql_error() . '<br>'); 
Header("Location: ./index.php");
?>
