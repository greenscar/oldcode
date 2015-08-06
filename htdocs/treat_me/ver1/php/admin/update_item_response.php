<?
include("header.inc");
$nameID = 0;
$flavorID = 0;
$sizeID = 0;
//phpinfo();
/***********************************************************************************
* IF THIS IS A NEW NAME, INSERT IT INTO THE NAME TABLE. 
* OTHERWISE, GET THE nameID OF THE NAME
***********************************************************************************/
$search = "SELECT nameID FROM nameDef WHERE name = \"" . @$_POST["name"] . "\"";
//echo($search);
$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . '.'); 
$search_occurances = mysql_num_rows($search); 
//echo("num_rows = " . $search_occurances . "<BR>");
if (($search_occurances == '0')) {     	
	$newName = @$_POST["name"];
	$insert = "INSERT INTO nameDef SET " .
			"name = '$newName', " . 
			"description = '" . nl2br($_POST["description"])  . "'";
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
	$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . '.'); 
	$row = mysql_fetch_array($search);
	$nameID = $row["nameID"];	
	$updateDescription = "UPDATE nameDef SET name = '" . @$_POST["name"] . "', description = '" . $_POST["description"]  . "' WHERE nameID = '$nameID'";
	mysql_query($updateDescription) or die("Error in Query: $updateDescription. mysql said " . mysql_error() . '.'); 
}
/***********************************************************************************
* IF THIS IS A NEW FLAVOR, INSERT IT INTO THE FLAVOR TABLE. 
* OTHERWISE, GET THE flavorID OF THE FLAVOR
***********************************************************************************/
$search = "SELECT flavorID FROM flavorDef WHERE flavor = '" . @$_POST["flavor"] . "'";
$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . '.'); 
$search_occurances = mysql_num_rows($search); 
if (($search_occurances == '0')) {     	
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
	$search = "SELECT flavorID FROM flavorDef WHERE flavor = '" . @$_POST["flavor"] . "'";
	$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . '.'); 
	$row = mysql_fetch_array($search);
	$flavorID = $row["flavorID"];
}
/***********************************************************************************
* IF THIS IS A NEW SIZE, INSERT IT INTO THE SIZE TABLE. 
* OTHERWISE, GET THE sizeID OF THE SIZE
***********************************************************************************/
$search = "SELECT sizeID FROM sizeDef WHERE size = " . @$_POST["size"];
$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . '.'); 
$search_occurances = mysql_num_rows($search); 
if (($search_occurances == '0')) {     	
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
	$row = mysql_fetch_array($the_num);
	$sizeID = $row["sizeID"];
}
else{
	$search = "SELECT sizeID FROM sizeDef WHERE size = " . @$_POST["size"] . "";
	$search = mysql_query($search) or die("Error in Query: $search. mysql said " . mysql_error() . '.'); 
	$row = mysql_fetch_array($search);
	$sizeID = $row["sizeID"];
}

$retail=ereg_replace( "[^0-9.]", "", $_POST["retail"]);

//SET THE ITEM NOT ACTIVE
$update = "UPDATE itemDef SET active = 0 WHERE itemID = '" . $_POST["itemID"] . "'";
mysql_query($update) or die("Error in Query: $update. mysql said " . mysql_error() . '.'); 

//INSERT THE NEW ITEM
$update = "INSERT INTO itemDef SET " .
		"SKU = '" . $_POST["SKU"] . "', " .
		"categoryID = '" . $_POST["categoryID"] . "', " .
		"nameID = '" . $nameID . "', " .
		"flavorID = '" . $flavorID . "', " .
		"sizeID = '" . $sizeID . "', " .
		"cost_retail = '" . $retail . "';";
/*
$update = "UPDATE itemDef SET " .
		"SKU = '" . $_POST["SKU"] . "', " .
		"categoryID = '" . $_POST["categoryID"] . "', " .
		"nameID = '" . $nameID . "', " .
		"flavorID = '" . $flavorID . "', " .
		"sizeID = '" . $sizeID . "', " .
		"cost_retail = '" . $retail . "'  " .
		"WHERE itemID = '" . $_POST["itemID"] . "'";
		* 
//echo ($update . "<BR>");
*/
mysql_query($update) or die("Error in Query: $update. mysql said " . mysql_error() . '.'); 
$II = "0";
$query = "SELECT itemID FROM itemDef WHERE SKU='" . $_POST["SKU"] . "' AND nameID='" . $nameID . "'";
$result = mysql_query($query) or die("Error in Query: $query. mysql said " . mysql_error() . '.'); 
//echo($query . "<BR>");
while ($row=mysql_fetch_array($result)) {
//echo($row["itemID"] . "<BR>");
	$II=$row["itemID"];
	//echo("Location: admin/upload.php?II=$II" . "<BR>");
}
//echo("Location: admin/upload.php?II=$II" . "<BR>");
Header("Location: ./upload.php?II=$II");
?>