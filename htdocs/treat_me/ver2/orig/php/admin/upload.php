<?
include("header.inc");
commonHeader( "$Company", "Picture Addition");

echo  "<FORM ENCTYPE=\"multipart/form-data\" ACTION=\"./upload_item.php\" METHOD=\"POST\">\n";
echo  "<INPUT TYPE=\"hidden\" name=\"itemID\" value=\"" . $_GET["II"] . "\">\n";
$fileName = "../images/" . $_GET["II"] . ".jpg";
	
if(file_exists(@$fileName)){
	blackFont( "Arial", "<b>Your current picture is:</b>\n<IMG SRC=\"$fileName\">\n<br><br>\n");
	blackFont( "Arial", "To change this photo, choose your new one here: \n");
	echo  "<INPUT NAME=\"image\" TYPE=\"file\">\n";
	echo  "<INPUT TYPE=\"submit\" VALUE=\"Send Photo\"><BR><BR>\n";
	blackFont( "Arial", "To keep this current photo, click here: \n");
	echo "<input TYPE=\"Button\" VALUE=\"Keep current photo\" onClick=\"window.location='./index.php'\"></FORM>";
	blackFont( "Arial", "<p><b>This file MUST be a JPEG (jpg) image.</b>\n\n\n\n\n\n\n");
	echo("");
}
else{
	blackFont( "Arial", "<b>You can now upload a picture...</b><br><br>\n");
	blackFont( "Arial", "Send this file: \n");
	echo  "<INPUT NAME=\"image\" TYPE=\"file\">\n";
	echo  "<INPUT TYPE=\"submit\" VALUE=\"Send Photo\">&nbsp\n";
	echo "<input TYPE=\"Button\" VALUE=\"Do NOT Send Photo\" onClick=\"window.location='./index.php'\"></FORM>";
	blackFont( "Arial", "<p><b>This file MUST be a JPEG (jpg) image.</b>\n\n\n\n\n\n\n");
}
echo("</FORM>");

adminFooter();
?>
