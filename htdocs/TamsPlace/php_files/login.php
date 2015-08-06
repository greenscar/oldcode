<?php 
	if (!((@$id == "") or (@$pwd == "") or (!@mysql_connect("localhost", $id, $pwd)))){
		setcookie("id", $id);
		setcookie("pwd", $pwd);
	}
?>

<?php
	@$dbcnx = mysql_connect("localhost", $id, $pwd);  
	if ((@$id == "") or (@$pwd == "") or (!$dbcnx)){
		echo("<HTML><HEAD><TITLE> Log In </TITLE>");
		echo("</HEAD><BODY BACKGROUND=\"../imshome/laceback.jpg\">");
  	// Connect to the database server  
  	   	echo("\n\t<table align=center width=auto border=0>\n\t<tr>\n\t\t" .
		"<td>\n\t\t\t<div align=center>\n\t\t\t\t<h1>Your login was incorrect.</h1>" .
    	"\n\t\t\t</div>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td>\n\t\t\t<div align=center>" .
    	"<a href = \"../login.html\"> Try Again<a href>\n\t\t\t</div>\n\t\t</td>" .
    	"\n\t</tr>\n\t</table>\n</form>");
		exit();
  	}
	else {
		//echo("id = " . $id);
		echo("<HTML><HEAD><TITLE> Log In </TITLE>");
		echo("</HEAD><BODY BACKGROUND=\"../imshome/laceback.jpg\">");
		echo("<h1 align = center>Welcome Tam. </h1>");
		echo("<P ALIGN = CENTER><h2 align=center><a href=../searchpage.html>Search the Database</a> </h2></P>");
		echo("<P ALIGN = CENTER><h2 align=center><a href=../sendMailingList.html>Send out an Email to the Mailing List Members.</a> </h2></P>");
		echo("<P ALIGN = CENTER><h2 align=center><a href=../sendFentonMailingList.html>Send out an Email to the Julie Fenton Young Mailing List Members.</a> </h2></P>");
		
	}
	
	
?>

</BODY>
</HTML>