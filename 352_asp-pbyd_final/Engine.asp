<%@ LANGUAGE="VBSCRIPT" %>
<html>
<head>
<title>Photography by Design Brides</title>
</head>

<body bgcolor="#666666" onLoad="">
<p align="center"><img src="photographyby.jpg" width="444" height="163"><br>
<img src="design.jpg" width="346" height="161"> 
</p>

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
		<h1 align = "center">Brides</h1>
		<p  align = "center">
		<% Do While Not objRec2.EOF%>  
			<img src="images/<%=objRec2("imageFile")%>small.jpg"> <br>
  		<% objRec2.MoveNext
			Loop
		%> </p>
	<%End If%>
<%End If%>
<%
objRec2.Close
objConn.Close
%>

<p align="center">&nbsp;</p>
<p align="center">
<table width="75%" border="0" vspace="0" hspace="20">
  <tr> 
    <td><img src="buttons/recentweddingbuttonOver.jpg" width="144" height="72"></td>
    <td><img src="buttons/homebuttonOver.jpg" width="144" height="72"></td>
    <td><img src="buttons/linksbuttonOver.jpg" width="144" height="72"></td>
    <td><img src="buttons/portraitbuttonOver.jpg" width="144" height="72"></td>
    <td><img src="buttons/weddingbuttonOver.jpg" width="144" height="72"></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td> 
      <div align="center"><font color="#FFFFFF">(713) 455-8833 Houston, TX 77015</font></div>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</p>
</body>
</html>
