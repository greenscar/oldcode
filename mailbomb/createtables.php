<?php
include("sql_connect.inc");
create_name_db();
fill_name_db();
function create_name_db(){
	mysql_query("DROP TABLE names");
	$sql = "CREATE TABLE names (" .
			"nameID BIGINT NOT NULL AUTO_INCREMENT," .
			"name VARCHAR(30) NOT NULL, " .
			"PRIMARY KEY(nameID))";
			
	//echo($sql."<BR>");
	mysql_query($sql) or die(mysql_error() . "<BR> in $sql<BR>");
}
function fill_name_db(){
	$file = fopen("names.txt", "r+");
	$names = array();
	while(!feof($file)){
		$name = "";
		while ($c = fgetc($file)){
			if(strcmp($c, "\n") != 0)
				$name = $name . $c;			
			else
				break;
		}
		$names[$c] == $name;
		$insert = "INSERT INTO names (name) VALUES ('$name');";
		mysql_query($insert) or die(mysql_error() . " in $insert<BR>");
		//echo("name = $name<BR>");
		//$c = fgetc($file);
		//if (strcmp($c, "\n") == 0) echo"XXX";
		//else echo $c;
	}	
}

?>