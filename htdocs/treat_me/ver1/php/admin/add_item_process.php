<?php

	$nameID = 0;
	$flavorID = 0;
	$sizeID = 0;
	/***********************************************************************************
	* IF THIS IS A NEW NAME, INSERT IT INTO THE NAME TABLE. 
	* OTHERWISE, GET THE nameID OF THE NAME
	***********************************************************************************/
	$search_string = "SELECT nameID FROM nameDef WHERE name = '" . @$_POST["name"] . "'";
	//echo($search . "<br>");
	$search = mysql_query($search_string) or die("Error in Query: $search_string. mysql said " . mysql_error() . "in $search_string."); 
	$search_occurances = mysql_num_rows($search); 
	if (($search_occurances == '0')) {     	
		//echo("name search_occurances == 0<br>");
		$newName = @$_POST["name"];
		$insert = "INSERT INTO nameDef SET " .
				"name = '$newName', " . 
				"description = '" . nl2br($_POST["itemDescription"]). "'";
		if(!mysql_query($insert)){
    		echo("<H1>Error in $insert: ".mysql_error()."</H1>");
			return false;
		}
		//GET THE flavorID OF THE FLAVOR JUST INSERTED
		$name_sequence = "SELECT MAX(nameID) AS nameID FROM nameDef";
		$the_num = mysql_query($name_sequence);
		$row = mysql_fetch_array($the_num);
		$nameID = $row["nameID"];
	}
	else{
		$search = "SELECT nameID FROM nameDef WHERE name = '" . @$_POST["name"] . "'";
		//echo($search."<br>");
		$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . "in $search.");
		$row = mysql_fetch_array($search);
		$nameID = $row["nameID"];
	}
	//echo("nameID = $nameID<br>");
	/***********************************************************************************
	* IF THIS IS A NEW FLAVOR, INSERT IT INTO THE FLAVOR TABLE. 
	* OTHERWISE, GET THE flavorID OF THE FLAVOR
	***********************************************************************************/
	$search = "SELECT flavorID FROM flavorDef WHERE flavor = '" . @$_POST["flavor"] . "'";
	$search_query = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . "in $search.");
	$search_occurances = mysql_num_rows($search_query); 
	//echo($search . "<br>");
	if (($search_occurances == '0')) {     	
		//echo("flavor search_occurances == 0<br>");
		$newFlavor = @$_POST["flavor"];
		$insert = "INSERT INTO flavorDef SET " .
				"flavor = '$newFlavor';";
		if(!mysql_query($insert)){
    		echo("<H1>Error in $insert: ".mysql_error()."</H1>");
			return false;
		}
		//GET THE flavorID OF THE FLAVOR JUST INSERTED
		$flavor_sequence = "SELECT MAX(flavorID) AS flavorID FROM flavorDef";
		$the_num = mysql_query($flavor_sequence);
		$row = mysql_fetch_array($the_num);
		$flavorID = $row["flavorID"];
	}
	else{
		//echo("flavor search_occurances != 0<br>");
		$search = "SELECT flavorID FROM flavorDef WHERE flavor = '" . @$_POST["flavor"] . "'";
		//echo($search . "<br>");
		$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . "in $search.");
		$row = mysql_fetch_array($search) or die("Error in Query: $search. mysql said " . mysql_error() . "in $search.");;
		$flavorID = $row["flavorID"];
	}
	//echo("flavorID = $flavorID<br>");
	/***********************************************************************************
	* IF THIS IS A NEW SIZE, INSERT IT INTO THE SIZE TABLE. 
	* OTHERWISE, GET THE sizeID OF THE SIZE
	***********************************************************************************/
	$search = "SELECT sizeID FROM sizeDef WHERE size = " . @$_POST["size"];
	$search_query = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . "<BR>");
	$search_occurances = mysql_num_rows($search_query); 
	if (($search_occurances == '0')) {     	
		//echo("size search_occurances == 0<br>");
		$newSize = @$_POST["size"];
		$insert = "INSERT INTO sizeDef SET " .
				"size = '$newSize';";
		if(!mysql_query($insert)){
    		echo("<H1>Error in $insert: ".mysql_error()."</H1>");
			return false;
		}
		//GET THE flavorID OF THE FLAVOR JUST INSERTED
		$size_sequence = "SELECT MAX(sizeID) AS sizeID FROM sizeDef";
		$the_num = mysql_query($size_sequence);
		$row = mysql_fetch_array($the_num) or die("Error in Query: $the_num. mysql said " . mysql_error() . "in $search.");;
		$sizeID = $row["sizeID"];
	}
	else{
		//echo("size search_occurances != 0<br>");
		$search = "SELECT sizeID FROM sizeDef WHERE size = " . @$_POST["size"] . "";
		//echo($search . "<br>");
		$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . "in $search.");
		$row = mysql_fetch_array($search);
		$sizeID = $row["sizeID"];
	}
	/**********************************************************************************
	* INSERT THE NEW ITEM INTO THE ITEM TABLE
	***********************************************************************************/
	$costRetail=ereg_replace( "[^0-9.]", "", $_POST["costRetail"]);
	$query = "INSERT INTO itemDef " .
			 "(SKU, categoryID, nameID, flavorID, sizeID, cost_retail) VALUES ( '" .
			$_POST["itemSKU"] . "' , '" . 
			$_POST["category"] . "' , '" . 
			$nameID . "' , '" .
			$flavorID . "' , '" .
			$sizeID . "' , '" .
			$_POST["costRetail"] . "')";
	
	mysql_query($query) or die("Error in Query: $query. mysql said " . mysql_error() . "<BR>"); 
	$query = "SELECT itemID FROM itemDef WHERE SKU='" . $_POST["itemSKU"] . "' AND nameID='" . $nameID . "'";
	//echo $query . "<BR>";
	$result = mysql_query($query) or die("Error in Query: $search. mysql said " . mysql_error() . "<BR>");
	//echo($query . "<BR>");
	while ($row = mysql_fetch_array($result)) {
		$II=$row["itemID"];
	//	echo("Location: $Relative/admin/upload.php?II=$II" . "<BR>");
	}
	//echo("Location: $Relative/admin/upload.php?II=$II" . "<BR>");
	Header("Location: ./upload.php?II=$II");
?>