<HTML>
<HEAD>
<TITLE>This is not the dragon pictured in the auction</TITLE>
<script language="JavaScript"><!-- 
javascript:window.history.forward(1); 
//--></script> 
<style type="text/css">
img {align:center; border:0px}
.preppy
{
color:#223399;
font-weight:900;
}

</style>
</HEAD>

<BODY BGCOLOR="#000000" TEXT="#FFFFFF">
<div align="center">
<H1 class=preppy>Ebay Photos</H1>
<img src="./orig_1.jpg">
<img src="./orig_2.jpg">
<H1 class=preppy>What I got in the mail</H1>
</div>
<?php
	for($i= 1 ;$i<50 ;$i++){
		$fileName = "";
		if($i < 100) $fileName .= "0";
		if($i < 10) $fileName .="0";
		$fileName .= $i;
		if(file_exists("./" . $fileName . ".jpg")){
			echo("<div align=\"center\">");
			echo("<IMG SRC=\"./" . $fileName . ".jpg\">");
			echo("</div><br><br><br>\n");
		}
	}		
?>
<p class=preppy>Where did the residue on his stomach come from? Bubble Wrap? </p>
</BODY>
</HTML>