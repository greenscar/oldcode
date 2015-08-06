<?php
$x = $_GET["x"];

echo("is_whole_number($x) => " . is_whole_number($x));

function is_whole_number($var){
  return (is_numeric($var)&&(intval($var)==floatval($var))&&($var>0));
}

?>
