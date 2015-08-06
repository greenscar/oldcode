<?php
     /*
      * This header file connects us to the database which will
      *  be used.
      */
     	$dbcnx = mysql_connect("$DBHost", "$DBUser","$DBPass");
     	if(!mysql_select_db("$DBName",$dbcnx)){
        	echo( "<P>Unable to connect to the " .
         	"database server at this time." . mysql_error() . "</P>");
        	exit();
    	}
	 
?>
