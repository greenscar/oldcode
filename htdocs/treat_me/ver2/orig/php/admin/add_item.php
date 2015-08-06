<?
include("header.inc");
$name = @$_POST["name"];
$flavor = @$_POST["flavor"];
$size = @$_POST["size"];
$wholesale = @$_POST["costWholesale"];
$retail = @$_POST["costRetail"];
$shipping = @$_POST["costShipping"];
$itemSKU = @$_POST["itemSKU"];
$description = @$_POST["itemDescription"];
$submitted = @$_POST["submitted"];
//phpinfo();
//echo("size = $size <BR>");
//echo("isset($size) = " . isset($size) . "<BR>");
//echo(isset($name) . ", " . isset($flavor) . ", " . isset($size) . ", empty($retail) = " . !empty($retail)  . ", " . (!isset($description)) . ", " .  (!isset($itemSKU)) . ", " . ($name != "newName") . ", " . ($flavor != "newFlavor") . ", " . ($size != "newSize"). "<BR> "  );
$all_variables_defined = isset($name) && isset($flavor) && isset($size) && (!empty($retail)) && (isset($description)) && (isset($itemSKU)) && ($name != "newName") && ($flavor != "newFlavor") && ($size != "newSize");
if 	($submitted && $all_variables_defined){
	//insert the info into the db then goto upload pic page
	require("./add_item_process.php");
}
else{
	commonHeader("$Company","Add An item");
	blueFont("Arial","Type your new item into the boxes, and then SUBMIT!<br><br>\n");
	echo("<TABLE BORDER=\"0\" CELLPADDING=\"2\" CELLSPACING=\"2\" ALIGN=\"CENTER\"><TR>\n");
	echo("<FORM ACTION=\"" . $_SERVER['PHP_SELF'] . "\" METHOD=\"POST\">\n");
	echo("<INPUT TYPE = \"HIDDEN\" NAME = \"submitted\" VALUE = \"true\">\n");
	echo("<tr><td>\n");
	blueFont("Arial","Item ID (SKU) :");
	echo("</td>\n<td>\n");
	echo("<input type=\"text\" name=\"itemSKU\" size=\"40\" VALUE=\"" . @$_POST["itemSKU"] . "\"></td></tr>\n");
	
	/*************************************
	* Get the category
	**************************************/
	echo("<tr><td>\n");
	blueFont("Arial","Select A Category<br>");
	echo("</td>\n<td>\n");
	echo "<select name=\"category\" size=\"1\">";
	$select = "SELECT * FROM category ORDER BY category";
	$result = mysql_query($select) or die(mysql_error() . "in $select<BR>");
	echo("\n\t\t\t<OPTION VALUE = \"0\"> --- Choose a category ---");
	while ($row = mysql_fetch_row($result)) {
		echo "<option ";
		if($row[1] == @$_POST["category"])
			echo ("SELECTED ");
		echo "value=\"$row[1]\"> $row[0] </option>";
	}
	echo "</select></td></tr>";
	
	
	/*************************************
	* Get the name
	**************************************/
	echo("<tr><td>\n");
	blueFont("Arial","Item Name :");
	echo("</td>\n");
	echo("\t<DEV ALIGN=\"right\">\n");
	$select = "SELECT * FROM nameDef";
	$results = mysql_query($select) or die("Error in Query: $select. mySQL said " . mysql_error() . '.');
	echo("<td>\n\t\t");
	
	
	//IF name IS NOT DEFINED, DISPLAY THE DROP DOWN BOX FOR INITIAL FLAVOR SELECTION
	if(!isset($_POST["name"]) || ($_POST["name"] == "0")){
		echo("<SELECT NAME=\"name\" onChange=\"submit()\" SIZE=1>\n");
		echo("\n\t<OPTION SELECTED VALUE = \"0\"> --- Choose an item name ---");
		for($numNames = 0; $row = mysql_fetch_array($results);) { 
			echo("\n\t<OPTION VALUE=\"" .$row["name"]. "\">" . $row["name"]);
		}
		echo("\n\t<OPTION VALUE=\"newName\">Create a new name");
		echo("</SELECT>\n");	
	}
	else{
		//IF name IS DEFINED BUT EMPTY OR = newName, DISPLAY A TEXT ENTRY BOX FOR A NEW FLAVOR
		if($_POST["name"] == "newName" || @$_POST["name"] == ""){
			echo("<INPUT TYPE=\"text\" name=\"name\" SIZE=\"40\">\n");
		}
		//IF name IS DEFINED && != "" && != "newName", A FLAVOR HAS BEEN SELECTED.
		else{
			/*
			* AT THIS POINT, A FLAVOR HAS BEEN SELECTED BY THE USER. WE STILL MUST
			* 	 DETERMINE IF IT IS A FLAVOR FROM THE DATABASE OR A NEW FLAVOR
			*/
			$checkDB = "SELECT nameID, description FROM nameDef WHERE name = '" . $_POST["name"] . "'";
			$checkDB = mysql_query($checkDB)or die(mysql_error() . "in $checkDB<BR>");
			$inDB = mysql_num_rows($checkDB); 
			//IF THE FLAVOR IS IN THE DATABASE ALREADY, DISPLAY THE DROPDOWN WITH IT SELECTED
			if ($inDB) {
				$description = mysql_fetch_array($checkDB);
				echo("<SELECT NAME=\"name\" onChange=\"submit()\" SIZE=1>\n");
				echo("\n\t<OPTION VALUE = \"0\"> --- Choose an item name ---");
				for($numNames = 0; $row = mysql_fetch_array($results);) { 
					echo("\n\t<OPTION ");
					if($row["name"] == $_POST["name"]) 
						echo("SELECTED ");
					echo("VALUE=\"" .$row["name"]. "\">" . $row["name"]);
				}
				echo("\n\t<OPTION VALUE=\"newName\">Create a new name");
				echo("</SELECT>\n");
				$description = $description["description"];
			}
			//ELSE DISPLAY A TEXTBOX WITH THE FLAVOR IN IT		
			else{
				echo("<INPUT TYPE=\"text\" name=\"name\" SIZE=\"40\" value=\"" . $_POST["name"] . "\">\n");
			}
		}
	}
	
	echo("\n\t\t</td>\n");						    			
	echo("\n\t</DEV>\n");
	/*************************************
	* Get the flavor
	**************************************/
	echo("<tr><td>\n");
	blueFont("Arial","Flavor :");
	echo("</td>\n");
	echo("<DEV ALIGN=\"right\">\n");
	$select = "SELECT * FROM flavorDef";
	$results = mysql_query($select) or die("Error in Query: $select. mySQL said " . mysql_error() . '.');
	echo("<td>\n\t\t");
	
	//IF flavor IS NOT DEFINED, DISPLAY THE DROP DOWN BOX FOR INITIAL FLAVOR SELECTION
	if((!isset($_POST["flavor"])) || ($_POST["flavor"] == "0")){
		echo("<SELECT NAME=\"flavor\" onChange=\"submit()\" SIZE=1>\n");
		echo("\n\t<OPTION SELECTED VALUE = \"0\"> --- Choose an item flavor ---");
		while($row = mysql_fetch_array($results)){ 
			echo("\n\t<OPTION VALUE=\"" .$row["flavor"]. "\">" . $row["flavor"]);
		}
		echo("\n\t<OPTION VALUE=\"newFlavor\">Create a new flavor");
		echo("</SELECT>\n");	
	}
	else{
		//IF flavor IS DEFINED BUT EMPTY OR = newFlavor, DISPLAY A TEXT ENTRY BOX FOR A NEW FLAVOR
		if($_POST["flavor"] == "newFlavor" || @$_POST["flavor"] == ""){
			echo("<INPUT TYPE=\"text\" name=\"flavor\" SIZE=\"40\">\n");
		}
		//IF flavor IS DEFINED && != "" && != "newFlavor", A FLAVOR HAS BEEN SELECTED.
		else{
			/*
			* AT THIS POINT, A FLAVOR HAS BEEN SELECTED BY THE USER. WE STILL MUST
			* 	 DETERMINE IF IT IS A FLAVOR FROM THE DATABASE OR A NEW FLAVOR
			*/
			$checkDB = "SELECT flavorID FROM flavorDef WHERE flavor = '" . $_POST["flavor"] . "'";
			$checkDB = mysql_query($checkDB) or die("Error in Query: $checkDB. mysql said " . mysql_error() . "in $checkDB.");
			$inDB = mysql_num_rows($checkDB);
			//IF THE FLAVOR IS IN THE DATABASE ALREADY, DISPLAY THE DROPDOWN WITH IT SELECTED
			if ($inDB) {
				echo("<SELECT NAME=\"flavor\" onChange=\"submit()\" SIZE=1>\n");
				echo("\n\t<OPTION VALUE = \"0\"> --- Choose an item flavor ---");
				for($numNames = 0; $row = mysql_fetch_array($results);) { 
					echo("\n\t<OPTION ");
					if($row["flavor"] == $_POST["flavor"]) 
						echo("SELECTED ");
					echo("VALUE=\"" .$row["flavor"]. "\">" . $row["flavor"]);
				}
				echo("\n\t<OPTION VALUE=\"newFlavor\">Create a new flavor");
				echo("</SELECT>\n");
			}
			//ELSE DISPLAY A TEXTBOX WITH THE FLAVOR IN IT		
			else{
				echo("<INPUT TYPE=\"text\" name=\"flavor\" SIZE=\"40\" value=\"" . $_POST["flavor"] . "\">\n");
			}
		}
	}
	echo("</td>\n");		    			
	echo("</DEV>\n");
	/*************************************
	* Get the size
	**************************************/
	echo("<tr><td>\n");
	blueFont("Arial","Item Size (oz.):");
	echo("</td>\n");
	echo("<DEV ALIGN=\"right\">\n");
	echo("<td>\n\t\t");
	//IF size IS NOT DEFINED, DISPLAY THE DROP DOWN BOX FOR INITIAL FLAVOR SELECTION
	if(!isset($_POST["size"]) || ($_POST["size"]) == "0"){
		echo("<SELECT NAME=\"size\" onChange=\"submit()\" SIZE=1>\n");
		echo("\n\t<OPTION SELECTED VALUE = \"0\"> --- Choose an item size ---");$select = "SELECT * FROM sizeDef";
		$sizes = mysql_query($select) or die("Error in Query: $select. mySQL said " . mysql_error() . '.');
		for($numNames = 0; $row = mysql_fetch_array($sizes);) { 
			echo("\n\t<OPTION VALUE=\"" .$row["size"]. "\">" . $row["size"]);
		}
		echo("\n\t<OPTION VALUE=\"newSize\">Create a new size");
		echo("</SELECT>\n");	
	}
	else{
		//IF size IS DEFINED BUT EMPTY OR = newSize, DISPLAY A TEXT ENTRY BOX FOR A NEW FLAVOR
		if($_POST["size"] == "newSize" || @$_POST["size"] == ""){
			echo("<INPUT TYPE=\"text\" name=\"size\" SIZE=\"40\">\n");
		}
		//IF size IS DEFINED && != "" && != "newSize", A FLAVOR HAS BEEN SELECTED.
		else{
			/*
			* AT THIS POINT, A size HAS BEEN SELECTED BY THE USER. WE STILL MUST
			* 	 DETERMINE IF IT IS A size FROM THE DATABASE OR A NEW size
			*/
			$checkDB = "SELECT sizeID FROM sizeDef WHERE size = '" . $_POST["size"] . "'";
			$checkDB = mysql_query($checkDB) or die("Error in Query: $checkDB. mySQL said " . mysql_error() . '.');
			$inDB = mysql_num_rows($checkDB);
			$checkDB = mysql_fetch_array($checkDB);
			$sizeID = $checkDB["sizeID"];
			//IF THE FLAVOR IS IN THE DATABASE ALREADY, DISPLAY THE DROPDOWN WITH IT SELECTED
			if ($inDB) {
				echo("<SELECT NAME=\"size\" onChange=\"submit()\" SIZE=1>\n");
				echo("\n\t<OPTION VALUE = \"0\"> --- Choose an item size ---");
				$select = "SELECT * FROM sizeDef";
				$sizes = mysql_query($select) or die("Error in Query: $select. mySQL said " . mysql_error() . '.');
				while($row = mysql_fetch_array($sizes)){ 
					echo("\n\t<OPTION ");
					if($row["size"] == $_POST["size"]) 
						echo("SELECTED ");
					echo("VALUE=\"" .$row["size"]. "\">" . $row["size"]);
				}
				echo("\n\t<OPTION VALUE=\"newSize\">Create a new size");
				echo("</SELECT>\n");
			}
			//ELSE DISPLAY A TEXTBOX WITH THE FLAVOR IN IT		
			else{
				echo("<INPUT TYPE=\"text\" name=\"size\" SIZE=\"40\" value=\"" . $_POST["size"] . "\">\n");
			}
		}
	}
	
	echo("</td>\n");		    			
	echo("</DEV>\n");

	echo("<tr><td>\n");
	blueFont("Arial","Cost ($):");
	echo("</td>\n");
	echo("<td>\n");
	echo("<input type=\"text\" name=\"costRetail\" size=\"40\" value=\"$retail\"></td></tr>\n");
	echo("<tr>\n");
	echo("<tr><td colspan=\"2\">\n");
	blueFont("Arial","Item Description:<br>\n");
	//if(!empty($name)){
		//echo($description);
		echo("<textarea name=\"itemDescription\" rows=\"10\" cols=\"50\" wrap>" . strip_tags($description) . "</textarea></td></tr>\n");
	//}
	//else{
	//	echo("<textarea name=\"itemDescription\" rows=\"10\" cols=\"50\" wrap></textarea></td></tr>\n");
	//}
	echo("<tr><td colspan=\"2\" align=\"center\"><INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Submit\">&nbsp<input TYPE=\"Button\" VALUE=\"Cancel\" onClick=\"window.location='./index.php'\"></form></TABLE>\n");
	//phpinfo();

	adminFooter();
}
?>
