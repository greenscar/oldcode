<?php
include("header.inc");
commonHeader("$Company","Your catalog");
$item = "SELECT * FROM itemDef WHERE active = 1 ORDER BY categoryID, nameID, SKU";
$theItems = mysql_query($item);
?>
<HTML>
<TITLE>Your Catalog</TITLE>
</HTML>
<BODY>
<?php
	blueFont("Arial","<h2 align=\"center\">YOUR CATALOG</h2>");
	echo("<TABLE BORDER=\"1\" ALIGN=\"CENTER\">");
	echo("\n<TH>\n\tSKU #\n</TH>");
	echo("\n<TH>\n\tCategory\n</TH>");
	echo("\n<TH>\n\tName\n</TH>");
	echo("\n<TH>\n\tFlavor\n</TH>");
	echo("\n<TH>\n\tSize\n</TH>");
	echo("\n<TH>\n\tPicture\n</TH>");
	echo("\n<TH>\n\tDescription\n</TH>");
	echo("\n<TH>\n\tPrice\n</TH>");
	while($row = mysql_fetch_array($theItems)){
		$name = "SELECT * FROM nameDef WHERE nameID = '" . @$row["nameID"] ."';";
		$flavor = "SELECT flavor FROM flavorDef WHERE flavorID = '" . @$row["flavorID"] ."';";
		$size = "SELECT size FROM sizeDef WHERE sizeID = '" . @$row["sizeID"] ."';";
		$category = "SELECT category FROM category WHERE categoryID = '" . @$row["categoryID"] ."';";
		$itemID = @$row["itemID"];
		//echo("itemID = $itemID");
		$name = mysql_query($name);
		$flavor = mysql_query($flavor);
		$size = mysql_query($size);
		$category = mysql_query($category);
		
		$name = mysql_fetch_array($name);
		$flavor = mysql_fetch_array($flavor);
		$size = mysql_fetch_array($size);
		$category = mysql_fetch_array($category);
		
		$description = nl2br($name["description"]);
		//echo($description . "<BR>");
		$nameID = $name["nameID"];
		$name = $name["name"];
		$flavor = @$flavor["flavor"];
		$size = @$size["size"];
		$category = @$category["category"];
		
		echo("<TR>\n");
		echo("<TD ALIGN = CENTER>\n\t" . @$row["SKU"] . "\n</TD>\n");
		echo("<TD ALIGN = CENTER>\n\t" . @$category . "\n</TD>\n");
		echo("<TD ALIGN = CENTER>\n\t" . @$name . "\n</TD>\n");
		echo("<TD ALIGN = CENTER>\n\t" . @$flavor . "\n</TD>\n");
		echo("<TD ALIGN = CENTER>\n\t" . @$size . " oz.\n</TD>\n");
		if(file_exists("../../photos/$itemID.jpg")){
			$photo = "../../photos/$itemID.jpg";
		}
		else{
			$photo = "../../photos/coming_soon.gif";
		}
		echo("<TD>\n\t<IMG SRC=\"$photo\">\n</TD>\n");
		if(empty($description)){
			echo("<TD ALIGN = CENTER>\n\tNot avaliable\n</TD>\n");
		}
		else{
			echo("<TD ALIGN = CENTER>\n\t" . $description . "\n</TD>\n");		
		}
		echo("<TD ALIGN = CENTER>\n\t$ " . @$row["cost_retail"] . "\n</TD>\n");
		echo("</TR>\n");
    }
?>
<TR>
<TD COLSPAN="9">
	<P ALIGN="center">
		<input TYPE="Button" VALUE="Home" onClick="window.location='./index.php'">
	</P>
</TD>
</TR>
</TABLE>	
</FORM>
<?
	/* Free resultset */
	mysql_free_result($theItems);
?>
</BODY>