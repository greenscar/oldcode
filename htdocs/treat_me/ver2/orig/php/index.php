<?
$outside_table_x = 700;
$outside_table_y = 400;
$category_table_x = 164;
$category_table_y = 400;
$logo_cell_y = 148;
$logo_cell_x= 154;
$cat_cell_y = 35;
$cat_cell_x = $logo_cell_x;
$main_window_x = 510;
$picture_box_x = 210;
$picture_box_y = 140;
$description_x = 300;
$item_detail_y = 200;
$item_name_y = 30;
$border_size = 0;

include("header.inc");
require_once("some_useful_functions.inc");
//phpinfo();
$REMOTE_ADDR =$_ENV["REMOTE_ADDR"];
mysql_connect("$DBHost","$DBUser","$DBPass");
$old=date("z")-5;
$delete = "DELETE FROM Users WHERE Date < $old";
mysql_query($delete);

$result=mysql_query("SELECT cartItemsID , Date FROM CartItems");
while (@$row=mysql_fetch_row(@$result)) {
	$cart_item_id=$row[0];
	$cart_date=$row[1];
	$pieces=explode(":",$cart_date);
	$DCHK=@$pieces[1];
	if ($DCHK < $old) {
		mysql_query("DELETE FROM CartItems WHERE cartItemsID = '$cart_item_id'");
	}
}

//view_array($_GET); 
if (!empty($_GET["UID"])) {
	$UID = $_GET["UID"];
	//echo("SELECT * FROM Users WHERE User=$UID");
	@$result = mysql_query("SELECT * FROM Users WHERE User='$UID'");
	$num = @mysql_num_rows($result);
	if ($num == "0") {
		$dt=date("YmdHis");
		$UID="$dt$REMOTE_ADDR";
		$date=date("z");
		mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
		Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID&categoryID=1");
	}
}

if (empty($_GET["UID"])) {
	$category = @$_GET["category"];
	$dt=date("YmdHis");
	$UID="$dt$REMOTE_ADDR";
	$date=date("z");
	mysql_query("INSERT INTO Users VALUES ('$UID','$date')");
	Header("Location: " . $_SERVER['PHP_SELF'] . "?UID=$UID&categoryID=1");
}
if(@$_GET["order_item"]){
	require_once("some_useful_functions.inc");
	//echo("GET<BR>");
	//view_array($_GET);
	$item_id = $_GET["itemID"];
	Header("Location: add_cart.php?UID=$UID&itemID=$item_id");
	exit();
}
/********************************************************************************
* START THE ACTUAL WEB PAGE.
********************************************************************************/
commonHeader("Treat-Me", "Treat-Me Catelog");
echo("<TABLE WIDTH=\"$outside_table_x\" HEIGHT=\"$outside_table_y\" VALIGN=\"TOP\" BORDER=\"$border_size\">\n");
echo("\t<TD WIDTH=\"$category_table_x\" VALIGN=\"TOP\">\n");
echo("\t\t<TABLE BORDER=\"$border_size\" CELLPADDING=\"0\" VALIGN=\"TOP\" WIDTH=\"$category_table_x\">\n");
echo("\t\t\t<TR>\n");
echo("\t\t\t\t<TD ALIGN=\"CENTER\" HEIGHT=\"$logo_cell_y\" WIDTH=\"$logo_cell_x\"><IMG SRC=\"../photos/treat_logo.gif\"></TD>\n");
echo("\t\t\t</TR>\n");

//GET THE CATEGORIES TO DISPLAY ON THE FAR LEFT FROM THE DATABASE
$categories = mysql_query("SELECT * FROM category") or die(mysql_error() . "in SELECT * FROM category<BR>");
echo("\t\t\t<H3>\n");
while($row = mysql_fetch_array($categories)){
	$categoryID = $row["CategoryID"];
	$category_name = $row["Category"];
	$numItems = mysql_query("select count(active) from itemDef where active = 1 and categoryID = " . $categoryID);
	//echo("categoryID = $categoryID<br>");
	$numItems = @mysql_fetch_row($numItems);
	//echo("numItems = ".$numItems[0]);
	if(!empty($numItems[0])){
		//echo("select count(active) from itemdef where active = 1 and categoryID = " . $categoryID . " == ". $numItems[0] . "<BR>");
		echo("\t\t\t<TR>\n");
		echo("\t\t\t\t<TD HEIGHT=\"$cat_cell_y\" WIDTH=\"$cat_cell_x\">\n");
		echo("\t\t\t\t\t<a href='index.php?categoryID=$categoryID&UID=$UID' class=menu>$category_name</a>\n");
		echo("\t\t\t\t</TD>\n");
		echo("\t\t\t</TR>\n");
	}
	
}
echo("\t\t\t</H3>\n");
//END GET THE CATEGORIES TO DISPLAY ON THE FAR LEFT FROM THE DATABASE
echo("\t\t</TABLE>\n");
echo("\t</TD>\n");
echo("\t<TD VALIGN=\"TOP\" WIDTH=\"0\">\n");
echo("\t\t<IMG SRC=\"../photos/vert_line.gif\">\n");
echo("\t</TD>\n");


/*********************************************************************************
* An item has been selected to display.
**********************************************************************************/
if(empty($_POST["nameID"])){
	/*
	* We are given a categoryID and itemID and userID through the GET method.
	* Therefore, we know what item to display.
	*/
	require_once("some_useful_functions.inc");
	$UID = $_GET["UID"];
	$name_array[] = null;
	$itemID_array[] = null;
	$available_sizes[] = null;
	$available_flavors[] = null;
	$categoryID = $_GET["categoryID"];
	if(!isset($categoryID)) $categoryID = 1;
	/*
	* If POST isset, the person has chosen an item using the 
	*/
	if(isset($_POST["itemID"])){
		$itemID = $_POST["itemID"];
		//echo("<br>POST[itemID] == " . $itemID . "<BR>");
	}
	else if(isset($_GET["itemID"])){
		$itemID = $_GET["itemID"];
		//echo("<br>GET[itemID] == " . $itemID . "<BR>");
	}
	else{
		$itemID = "SELECT itemID FROM itemDef WHERE categoryID = $categoryID AND active = 1";
		//echo("<br>" . $itemID . "<br>");
		$itemID = mysql_query($itemID);
		$itemID = mysql_fetch_array($itemID);
		$itemID = $itemID["itemID"];
		//echo("<br>itemID = $itemID</br>");
	}
	$item_to_display = 1;
	
	//SET COUNTERS FOR SIZE, FLAVOR, PRICE ARRAYS TO 0
	$size_n_price_cntr = 0;
	$flavor_cntr = 0;
	/****************************************************************************
	* Get the items under this categoryID
	*****************************************************************************/
	$items = "SELECT * FROM itemDef, nameDef WHERE " .
			"itemDef.categoryID = $categoryID AND " .
			"itemDef.active = 1 AND " .
			"itemDef.nameID = nameDef.nameID " .
			"ORDER BY itemDef.itemID";
	$item_sel = mysql_query($items) or die("error is: " . mysql_error() . "<BR> in <BR> $items");
	while($row=mysql_fetch_array($item_sel)){
		$itemID_TEMP = $row["itemID"];
		$name = $row["name"];
		$search = array_search($name, $name_array);
		if(empty($search)){
			array_push($name_array, $name);
			array_push($itemID_array, $itemID_TEMP);
		}
	}
	$num_items = sizeof($name_array);
	/****************************************************************************
	* End Get the items under this categoryID
	****************************************************************************/
	
	/****************************************************************************
	* Get the name & nameID & description of the item with this itemID
	****************************************************************************/
	$name_query = "SELECT name, description, nameDef.nameID FROM nameDef, itemDef WHERE " .
			"itemDef.itemID = $itemID AND " .
			"nameDef.nameID = itemDef.nameID";
	//echo($name_query . "<BR>");
	$name_info = mysql_query($name_query) or die(mysql_error() . " IN: $name_query<BR>");;
	$name_info = mysql_fetch_array($name_info);
	$name = $name_info["name"];
	$nameID = $name_info["nameID"];
	$description = $name_info["description"];
	/****************************************************************************
	* End Get the name & nameID & description  of the item with this itemID
	****************************************************************************/
	
	/****************************************************************************
	* Get the flavor for this itemID and the flavors available for this nameID
	****************************************************************************/
	$flavors = "SELECT flavor FROM flavorDef, itemDef WHERE " .
				"itemDef.itemID = $itemID AND " .
				"itemDef.flavorID = flavorDef.flavorID";
	$flavors = mysql_query($flavors) or die(mysql_error() . " IN: $flavors<BR>");
	$flavors = mysql_fetch_array($flavors);
	$this_flavor = $flavors["flavor"];
	
	$avail_flavors_q = "SELECT flavor FROM flavorDef, itemDef WHERE " .
					"itemDef.nameID = $nameID AND " .
					"itemDef.active = 1 AND " .
					"itemDef.flavorID = flavorDef.flavorID";
	$avail_flavors = mysql_query($avail_flavors_q) or die(mysql_error() . " IN: $avail_flavors_q<BR>");
	while($avail = mysql_fetch_array($avail_flavors)){
		$temp = $avail["flavor"];
		$search = array_search($temp, $available_flavors);
		if(empty($search))	array_push($available_flavors, $temp);
	}	
	/****************************************************************************
	* End Get the flavor for this itemID and the flavors available for this nameID
	****************************************************************************/
		
	/****************************************************************************
	* Get the size of this itemID and the sizes available in this nameID
	****************************************************************************/
	$size = "SELECT size FROM sizeDef, itemDef WHERE " .
			"sizeDef.sizeID = itemDef.sizeID AND " .
			"itemDef.itemID = $itemID";
	$size = mysql_query($size) or die(mysql_error() . " IN: $size<BR>");
	$size = mysql_fetch_array($size);
	$size = $size["size"];
	
	$avail_size_q = "SELECT itemID, size from itemDef, sizeDef WHERE " .
					   "itemDef.sizeID = sizeDef.sizeID AND " .
					   "itemDef.active = 1 AND " .
					   "itemDef.nameID = $nameID ORDER BY size";
	$avail_size = mysql_query($avail_size_q) or die(mysql_error() . " IN: $avail_size_q<BR>");
	//echo($avail_size_q . "<BR>");
	while($avail = mysql_fetch_array($avail_size)){
		$temp = $avail["size"];
		//echo("temp = $temp<BR>");
		$search = array_search($temp, $available_sizes);
		if(empty($search))	array_push($available_sizes, $temp);
	}
	/****************************************************************************
	* END Get the size of this itemID and the sizes available in this nameID
	****************************************************************************/
	
	/****************************************************************************
	* Get the price of this itemID
	****************************************************************************/
	$price = "SELECT cost_retail FROM itemDef WHERE itemID = $itemID";
	$price = mysql_query($price);
	$price = mysql_fetch_array($price);
	$price = $price["cost_retail"];
	/****************************************************************************
	* End Get the price of this itemID
	****************************************************************************/
	/****************************************************************************
	* Get the name of the photo for this item
	****************************************************************************/
	if(file_exists("../photos/$itemID.jpg")){
		$photo = "../photos/$itemID.jpg";
	}
	else{
		$photo = "../photos/coming_soon.gif";
	}
	/****************************************************************************
	* END Get the name of the photo for this item
	****************************************************************************/
}

else{
	//phpinfo();
	require_once("some_useful_functions.inc");
	$UID = $_GET["UID"];
	$name_array[] = null;
	$itemID_array[] = null;
	$available_sizes[] = null;
	$available_flavors[] = null;
	$categoryID = $_POST["categoryID"];
	$nameID = $_POST["nameID"];
	$sizeID = $_POST["sizeID"];
	$flavorID = $_POST["flavorID"];
	$photo = $_POST["photo"];
	$description = $_POST["description"];
	
	if(isset($_POST["quantity"])) $quantity = $_POST["quantity"];
	else $quantity = 1;
	
	$item_to_display = 1;
	
	//SET COUNTERS FOR SIZE, FLAVOR, PRICE ARRAYS TO 0
	$size_n_price_cntr = 0;
	$flavor_cntr = 0;
	
	/****************************************************************************
	* Get the itemID & cost from this item
	*****************************************************************************/
	$item_id_q = "SELECT cost_retail, itemID FROM itemDef WHERE " .
				"itemDef.active = 1 AND " .
				"categoryID = $categoryID AND " .
				"nameID = $nameID AND " .
				"flavorID = $flavorID AND " .
				"sizeID = $sizeID";				
	$item_id = mysql_query($item_id_q) or die(mysql_error() . " in $item_id_q<BR>");
	$item_id = mysql_fetch_array($item_id);
	$itemID = $item_id["itemID"];
	$cost = $item_id["cost_retail"];
	/****************************************************************************
	* END Get the itemID & cost from this item
	*****************************************************************************/
	
	/****************************************************************************
	* Get the items under this categoryID
	*****************************************************************************/
	$item_query = "SELECT * FROM itemDef, nameDef WHERE " .
				"itemDef.active = 1 AND " .
				"itemDef.categoryID = $categoryID AND " .
				"itemDef.nameID = nameDef.nameID " .
				"ORDER BY itemDef.itemID";
	$items = mysql_query($item_query) or die(mysql_error() . " in $item_query<BR>");
	while($row=mysql_fetch_array($items)){
		$itemID_TEMP = $row["itemID"];
		$name = $row["name"];
		$search = array_search($name, $name_array);
		if(empty($search)){
			array_push($name_array, $name);
			array_push($itemID_array, $itemID_TEMP);
		}
	}
	$num_items = sizeof($name_array);
	/****************************************************************************
	* End Get the items under this categoryID
	****************************************************************************/
		
	/****************************************************************************
	* Get the name & nameID & description of the item with this itemID
	****************************************************************************/
	$name_query = "SELECT name, description FROM nameDef WHERE nameID = $nameID";
	$name_info = mysql_query($name_query) or die(mysql_error() . " IN: $name_query<BR>");;
	$name_info = mysql_fetch_array($name_info);
	$name = $name_info["name"];
	$description = $name_info["description"];
	/****************************************************************************
	* End Get the name & nameID & description  of the item with this itemID
	****************************************************************************/
	
	/****************************************************************************
	* Get the flavor for this itemID and the flavors available for this nameID
	****************************************************************************/
	$flavors = "SELECT flavor FROM flavorDef WHERE flavorID = $flavorID";
	$flavors = mysql_query($flavors) or die(mysql_error() . " IN: $flavors<BR>");
	$flavors = mysql_fetch_array($flavors);
	$this_flavor = $flavors["flavor"];
	
	$avail_flavors_q = "SELECT flavor FROM flavorDef, itemDef WHERE " .
					"itemDef.nameID = $nameID AND " .
					"itemDef.active = 1 AND ".
					"itemDef.flavorID = flavorDef.flavorID";
	$avail_flavors = mysql_query($avail_flavors_q) or die(mysql_error() . " IN: $avail_flavors_q<BR>");
	while($avail = mysql_fetch_array($avail_flavors)){
		$temp = $avail["flavor"];
		$search = array_search($temp, $available_flavors);
		if(empty($search))	array_push($available_flavors, $temp);
	}	
	/****************************************************************************
	* End Get the flavor for this itemID and the flavors available for this nameID
	****************************************************************************/
		
	/****************************************************************************
	* Get the size of this itemID and the sizes available in this nameID
	****************************************************************************/
	$size_q = "SELECT size FROM sizeDef WHERE sizeID = $sizeID";
	$size = mysql_query($size_q) or die(mysql_error() . " IN: $size_q<BR>");
	$size = mysql_fetch_array($size);
	$size = $size["size"];
	
	$avail_size_q = "SELECT itemID, size from itemDef, sizeDef WHERE " .
					   "itemDef.sizeID = sizeDef.sizeID AND " .
					   "itemDef.active = 1 AND " .
					   "itemDef.nameID = $nameID ORDER BY size";
	$avail_size = mysql_query($avail_size_q) or die(mysql_error() . " IN LINE 512: $avail_size_q<BR> ");
	//echo($avail_size_q . "<BR>");
	while($avail = mysql_fetch_array($avail_size)){
		$temp = $avail["size"];
		$search = array_search($temp, $available_sizes);
		if(empty($search))	array_push($available_sizes, $temp);
	}
	/****************************************************************************
	* END Get the size of this itemID and the sizes available in this nameID
	****************************************************************************/
	
	/****************************************************************************
	* Get the price of this itemID
	****************************************************************************/
	$price_q = "SELECT cost_retail FROM itemDef WHERE itemID = $itemID";
	$price = mysql_query($price_q) or die(mysql_error() . " IN LINE 530: $price_q<BR> ");
	$price = mysql_fetch_array($price);
	$price = $price["cost_retail"];
	/****************************************************************************
	* End Get the price of this itemID
	****************************************************************************/
}
/****************************************************************************
* THE ACTUAL WEB PAGE.... DISPLAY THE CORRECT DATA.
****************************************************************************/
//START THE FORM
echo("\t<FORM NAME=\"treat_form\" ACTION=\"" . $_SERVER['PHP_SELF'] . "?UID=$UID\" METHOD=\"POST\">\n");
echo("\t<INPUT TYPE=\"HIDDEN\" NAME=\"categoryID\" VALUE=\"$categoryID\">\n");
echo("\t<TD WIDTH=\"$main_window_x\" VALIGN=\"TOP\">\n");
/****************************************************************************
* DISPLAY THE NAME, PHOTO AND DESCRIPTION
****************************************************************************/
echo("\t\t<TABLE BORDER=\"$border_size\" CELLPADDING=\"0\" HALIGN=\"LEFT\" VALIGN=\"TOP\" CELLSPACING=\"2\" WIDTH=\"$main_window_x\" HEIGHT=\"$item_detail_y\">\n");	
echo("\t\t\t<TR VALIGN=\"TOP\"><TD COLSPAN=\"2\" WIDTH=\"$main_window_x\" HEIGHT=\"$item_name_y\"><P CLASS=ITEMNAMEHEADER>$name</P></TD></TR>\n");
echo("\t\t\t<INPUT TYPE=\"HIDDEN\" NAME=\"nameID\" VALUE=\"$nameID\">\n");
echo("\t\t\t<TR>\n");
$image = getimagesize($photo);
$photo_width = $image[0];
$photo_height = $image[1];

echo("\t\t\t\t<TD WIDTH=\"$picture_box_x\" HEIGHT=\"$picture_box_y\" ALIGN=\"CENTER\"><IMG SRC=\"$photo\" ");
if($photo != "../photos/coming_soon.gif"){
	if(($photo_width <= $picture_box_x) && ($photo_height <= $picture_box_y)){
		echo("WIDTH=\"$photo_width\" HEIGHT=\"$photo_height\" ");
	}
	else if (($photo_width <= $picture_box_x) && ($photo_height > $picture_box_y)){
		echo("HEIGHT=\"$picture_box_y\" ");
	}
	else if (($photo_width > $picture_box_x) && ($photo_height <= $picture_box_y)){
		echo("WIDTH=\"$picture_box_x\" ");
	}
	else{ //BOTH PHOTO X AND Y ARE > PICTURE BOX X AND Y
		if(($photo_width - $picture_box_x) > ($photo_height - $picture_box_y)){
			echo("WIDTH=\"$picture_box_x\" ");
		}
		else{
			echo("HEIGHT=\"$picture_box_y\" ");
		}
	}
}
echo("></TD>\n");

echo("\t\t\t\t<INPUT TYPE=\"HIDDEN\" NAME=\"photo\" VALUE=\"$photo\">\n");
echo("\t\t\t\t<TD WIDTH=\"$description_x\" HEIGHT=\"$picture_box_y\" VALIGN=CENTER ALIGN=LEFT><P CLASS=DESCRIPTION>$description</P></TD>\n");
echo("\t\t\t\t<INPUT TYPE=\"HIDDEN\" NAME=\"description\" VALUE=\"$description\">\n");
echo("\t\t\t</TR>\n");
echo("\t\t</TABLE>\n");
/****************************************************************************
* END DISPLAY THE NAME, PHOTO AND DESCRIPTION
****************************************************************************/
//echo("\t\t\t<TABLE BORDER=\"$border_size\" CELLPADDING=\"0\" WIDTH=\"$main_window_x\" HEIGHT=\"$item_detail_y\" ALIGN=\"LEFT\">\n");
//echo("\t\t<TD WIDTH=\"$picture_box_x\" HEIGHT=\"$item_detail_y\" BORDER=\"$border_size\">\n");
echo("\t\t\t<TABLE BORDER=\"$border_size\" CELLPADDING=\"0\" WIDTH=\"$main_window_x\" HEIGHT=\"$item_detail_y\" ALIGN=\"LEFT\">\n");
echo("\t\t<TD WIDTH=\"$picture_box_x\" VALIGN=\"TOP\">\n");
echo("\t\t\t<TABLE BORDER=\"$border_size\" CELLPADDING=\"0\" HEIGHT=\"" . $item_name_y * 6 . "\"WIDTH=\"$picture_box_x\" VALIGN=\"TOP\" ALIGN=\"LEFT\">\n");
echo("\t\t\t\t<TR><TD HEIGHT=\"$item_name_y\">&nbsp</TD></TR>\n");
echo("\t\t\t<H3>\n");
for($i=1; $i<7;$i++){
	echo("\t\t\t\t<TR>\n");
	echo("\t\t\t\t\t<TD HEIGHT=\"$item_name_y\">\n");
	if($i < sizeof($itemID_array))
		echo("\t\t\t\t\t\t<P><A HREF='index.php?categoryID=$categoryID&itemID=" . $itemID_array[$i] . "&UID=$UID'>" . $name_array[$i] . "</A></P>\n");
	else 
		echo("\t\t\t\t\t\t&nbsp\n");
	echo("\t\t\t\t\t</TD>\n");
	echo("\t\t\t\t</TR>\n");
}
echo("\t\t\t</H3>\n");
echo("\t\t\t</TABLE>\n");;
	
echo("\t\t</TD>\n");
echo("\t\t<TD VALIGN=\"TOP\">\n");
echo("\t\t\t<TABLE BORDER=\"$border_size\" WIDTH=\"$description_x\" HEIGHT\"$item_detail_y\"  VALIGN=\"TOP\" ALIGN=\"LEFT\">\n");

/*************************************************************
* THIS ROW SHOWS THE PRICE
*************************************************************/
echo("\t\t\t\t\t<TR><TD COLSPAN=\"2\"><P>Price: $ $price</P></TD></TR>\n");
/**************************************************************
* END THIS ROW SHOWS THE PRICE
***************************************************************/

/***************************************************************
* THIS HAS 2 CELLS. QUANTITY & SIZE
***************************************************************/
echo("\t\t\t\t\t<TR>\n");
echo("\t\t\t\t\t\t<TD ALIGN=\"LEFT\" COLSPAN=\"2\">\n");
//echo("\t\t\t\t\t\t&nbsp\n");
//echo("\t\t\t\t\t\t\t<P>Quantity:&nbsp<INPUT TYPE=\"TEXT\" NAME=\"quantity\" SIZE=\"2\" VALUE=\"$quantity\"></P>\n");
//echo("\t\t\t\t\t\t</TD>\n");
//echo("\t\t\t\t\t\t<TD ALIGN=\"LEFT\" WIDTH=\"100\">\n");
echo("\t\t\t\t\t\t\t<P>Size:&nbsp\n");
echo("\t\t\t\t\t\t\t<select name=\"sizeID\" onChange=\"submit();\">\n");
for($i = 1; $i < sizeof($available_sizes); $i++)
{
	$sizeID_q = "SELECT sizeID FROM sizeDef WHERE " .
			  "sizeDef.size = " . $available_sizes[$i];
	$sizeID = mysql_query($sizeID_q) or die(mysql_error() . " IN: $sizeID_q<BR>");
	$sizeID = mysql_fetch_array($sizeID);
	$sizeID = $sizeID["sizeID"];
	echo("\t\t\t\t\t\t\t\t<OPTION value=\"$sizeID\"");
	if(!isset($size) && ($i == 1)){
			echo(" SELECTED ");
			$size = $available_sizes[$i];
	} 
	else if($available_sizes[$i] == $size) echo(" SELECTED ");
	echo("> $available_sizes[$i] </OPTION>\n");
}
echo("\t\t\t\t\t\t\t</select> oz.</P>\n");
echo("\t\t\t\t\t\t</TD>\n");
echo("\t\t\t\t\t</TR>\n");
/***************************************************************
* END THIS HAS 2 CELLS. QUANTITY & SIZE
***************************************************************/

/***************************************************************
* THIS CELL SHOWS THE FLAVOR
***************************************************************/
echo("\t\t\t\t\t\t<TD COLSPAN=\"2\" ALIGN=\"LEFT\">\n");
echo("\t\t\t\t\t\t\t<P>Flavor:\n");
echo "\t\t\t\t\t\t\t<select name=\"flavorID\" onChange=\"submit();\">\n";
for($i = 1; $i < sizeof($available_flavors); $i++)
{
	$flavorID_q = "SELECT flavorID FROM flavorDef WHERE " .
			  "flavorDef.flavor = '" . $available_flavors[$i] . "'";
	$flavorID = mysql_query($flavorID_q) or die(mysql_error() . " IN: $flavorID_q<BR>");
	$flavorID = mysql_fetch_array($flavorID);
	$flavorID = $flavorID["flavorID"];
	echo "\t\t\t\t\t\t\t\t<OPTION value=\"$flavorID\"";
	if(!isset($flavor) && ($i == 1)){
			echo(" SELECTED ");
			$flavor = $available_flavors[$i];
	} 
	else if($available_flavors[$i] == $this_flavor) echo(" SELECTED ");
	//if($i == 1) echo(" SELECTED ");
	echo("> $available_flavors[$i] </OPTION>\n");
}
echo("\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t</P>");
echo("\t\t\t\t\t\t</TD>\n");	
/***************************************************************
* END THIS CELL SHOWS THE FLAVOR
***************************************************************/
	
//HAVE A SINGLE LINE BREAK
echo("\t\t\t\t\t\t<TR><TD colspan=\"2\">&nbsp</TD></TR>\n");
	
//DISPLAY "ADD TO BAG"
echo("\t\t\t\t\t\t<TR><TD colspan=\"2\" ALIGN=\"LEFT\">");
echo("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
echo("<A HREF=\"index.php?itemID=$itemID&UID=$UID&order_item=true\"><IMG SRC=\"../photos/add_to_treat_bag.gif\" BORDER=\"0\" HEIGHT=\"25\"></A></TD></TR>\n");
//HAVE 2 LINE BREAKS
echo("\t\t\t\t\t\t<TR><TD colspan=\"2\">&nbsp</TD></TR>\n");
//echo("\t\t\t\t\t\t<TR><TD colspan=\"2\">&nbsp</TD></TR>\n");

//VIEW TREAT BAG AND CHECKOUT
echo("\t\t\t\t\t\t<TR><TD ALIGN=\"LEFT\"><A HREF=\"view_cart.php?UID=$UID\"><IMG SRC=\"../photos/view_treat_bag.gif\" BORDER=\"0\" HEIGHT=\"25\"></A></TD>\n");
echo("\t\t\t\t\t\t<TD ALIGN=\"LEFT\"><a href=\"./checkout.php?UID=$UID\"><IMG SRC=\"../photos/checkout.gif\" BORDER=\"0\" HEIGHT=\"25\"></A></TD></TR>\n");
?>					
				</TABLE>
			</TD>
	</FORM>
</TABLE>
</BODY>
</HTML>	