<%@ LANGUAGE="VBSCRIPT" %>
<html>
<head>
<title>Photography by Design Portraits</title>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body bgcolor="#666666" onLoad="MM_preloadImages('buttons/homebuttonOver.jpg','buttons/bridebuttonOver.jpg','buttons/weddingbuttonOver.jpg','buttons/recentweddingbuttonOver.jpg','buttons/linksbuttonOver.jpg')">
<p align="center"><img src="photographyby.jpg" width="444" height="163"> 
  <br>
  <img src="design.jpg" width="346" height="161"> 
  <br>
  <font color="#FFFFFF" size="+2">(713) 455-8833<br>
  Houston, TX 77015</font> </p>

<%
    
	DBPath = Server.MapPath("pbyd.mdb")
	Forum = "DRIVER={Microsoft Access Driver (*.mdb)};" & "DBQ=" & DBPath

	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open Forum

	SqlJunk = "SELECT * FROM pbyd"
	
	SqlJunk = SqlJunk & " WHERE photoType LIKE '%" & "portrait" & "%'"
	
    	set objRec2 = objConn.Execute(SqlJunk)%>
	
<% If objRec2.BOF and objRec2.EOF Then %> 
	<h2 align="center"><font color="#000000">I'm sorry; we did not find a match</font></h2>
<% Else %> 
	<% If Not objRec2.BOF Then %> 
<p  align = "center">
		<% Do While Not objRec2.EOF%>  
			
 <img src="images/<%=objRec2("imageFile")%>small.jpg" hspace="40" vspace="30"> 
  		<% objRec2.MoveNext
			Loop
		%>
</p>
	<%End If%>
<%End If%>
<%
objRec2.Close
objConn.Close
%>
<p align="center">&nbsp;</p>
<p align="center">&nbsp; </p>
<table width="75%" border="0" vspace="0" hspace="30" align = "center">
  <tr> 
    <td><a href="index.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','buttons/homebuttonOver.jpg',1)" value = "bride"><img name="Image1" border="0" src="buttons/homebuttonUn.jpg" width="144" height="72"></a></td>
    <td><a href="bride.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','buttons/bridebuttonOver.jpg',1)"><img name="Image2" border="0" src="buttons/bridebuttonUn.jpg" width="144" height="72"></a></td>
    <td><a href="wedding.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','buttons/weddingbuttonOver.jpg',1)"><img name="Image3" border="0" src="buttons/weddingbuttonUn.jpg" width="144" height="72"></a></td>
    <td><a href="recent.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','buttons/recentweddingbuttonOver.jpg',1)"><img name="Image4" border="0" src="buttons/recentweddingbuttonUn.jpg" width="144" height="72"></a></td>
    <td><a href="link.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','buttons/linksbuttonOver.jpg',1)"><img name="Image5" border="0" src="buttons/linksbuttonUn.jpg" width="144" height="72"></a></td>
  </tr>
</table>
</body>
</html>
