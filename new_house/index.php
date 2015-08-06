<HTML>
<HEAD>
<TITLE>Our New Home... we hope.</TITLE>
</HEAD>
<BODY BGCOLOR="#000000" TEXT="#FFFFFF">
<P align="center"><img src="./images/map.jpg"></P>
<?php
$files = array("argus", "outside", "entryway", "livingroom", "diningroom", "drybar", "kitchen", "basemententry", "basement", "mainbedroom", "mainclosed", "bathroom", "otherbedroom");
$names = array("Argus", "Outside", "Entry Way", "Living Room", "Dining Room", "Dry Bar", "Kitchen", "Basement Entry", "Basement", "Main Bedroom", "Main Closet", "Bathroom", "Bedroom #2");
display_photos_with_form($files, $names);
function display_photos_with_form($files, $names){
	for($al=0;$al<sizeof($files);$al++){
		for($i = 0; $i < 10; $i++){
			$filename = "./images/" . $files[$al] . $i . ".jpg";
			if(file_exists($filename)){
				echo("<p align=\"center\"><IMG SRC=\"" . $filename . "\"></p>\n");
				echo("<h3 align=\"center\">" . $names[$al] . "</h3>");
			}
		}
	}
		
}

?>
</BODY>
</HTML>