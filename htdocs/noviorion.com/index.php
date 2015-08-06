<HTML>
<HEAD>
<TITLE>Novi Orion Sandlin</TITLE>
<script language="JavaScript"><!-- 
javascript:window.history.forward(1); 
//--></script> 
<style type="text/css">
img {align:center; border:0px}
img.big{ padding:1px; border-width:7px;border-style: outset; border-color: #FA9615; background-color: #FA9615;}
A:link { padding:1px; border-width:7px;border-style: outset; border-color: #50FF03; background-color: #50FF03;}       /* unvisited link */
A:visited { padding:1px; border-width:7px;border-style: outset;border-color:#B309C7;}   /*  background-color: #B309C7;visited links */
A:active { padding:1px; border-width:7px;border-style: outset; border-color: #B309C7;}    /* active links */
</style>
</HEAD>
<BODY BGCOLOR="#000000" TEXT="#FFFFFF">
<table border=5 align="center"><tr><td>
<table align="center" width="330" border=0>
	<tr>
		<td colspan=2>
			<H1 align="center">Novi Orion Sandlin</H1>
		</td>
	</tr>
	<tr>
		<td width="150">
			DOB:
		</td>
		<td>
			10/06/2003 5:36 AM
		</td>
	</tr>
	<tr>
		<td width="150">Weight:</td>
		<td>6lb 13oz</td>
	</tr>
	<tr>
		<td width="150">Height:</td>
		<td>19 3/4 in.</td>
	</tr>
</table>
</td></tr></table>
<?php
if(!isset($_GET["fileName"])){
	echo("<p align=\"center\">If you would like to see one of these images in full size, "
			. "click on the image and be patient.</p><br><br>");
	display_all_photos();
}
else{
	echo("<p align=\"center\">To return to the previous page, click on the image.</p>\n");
	display_one_photo($_GET["fileName"]);
}

function display_all_photos(){
	for($i= 1 ;$i<100 ;$i++){
		$fileName = "";
		if($i < 100) $fileName .= "0";
		if($i < 10) $fileName .="0";
		$fileName .= $i;
		if(file_exists("./small/" . $fileName . ".jpg")){
			echo("<div align=\"center\">");
			echo("<a name=\"$fileName\" href=\"./index.php?fileName=$fileName\">");
			echo("<IMG SRC=\"./small/" . $fileName . ".jpg\">");
			echo("</a> </div><br><br><br>\n");
		}
	}		
}
function display_one_photo($fileName){
	echo("<div  align=\"center\"><a href=\"./index.php#$fileName\"><img class=\"big\" src=\"./large/$fileName.jpg\"></a></div>");
}

?>
</BODY>
</HTML>