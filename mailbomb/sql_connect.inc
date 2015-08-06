<?php
include("variables.inc");
     /*
      * This header file connects us to the database which will
      *  be used.
      */
	  	//echo("DBHost = $DBHost<BR>DBPass = $DBHost<BR>DBUser = $DBUser<BR>DBName = $DBName<BR>");
     	$dbcnx = mysql_connect("$DBHost", "$DBUser","$DBPass");
     	if(!mysql_select_db("$DBName",$dbcnx)){
        	echo( "<P>Unable to connect to the " .
         	"database server at this time.<BR>" . mysql_error() . "</P>");
        	exit();
    	}
	 
?>
