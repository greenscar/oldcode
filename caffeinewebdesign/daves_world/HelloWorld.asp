<% @LANGUAGE="VBScript"%>
<script RUNAT="SERVER" LANGUAGE="VBScript">

Sub SayHello () 
	Response.write ("<h1>Hello! Today's date is " & Date & " </h1>")
End Sub 

</script>

<html>

<head>
<title>ASP Syntax</title>
</head>
<%
	Call SayHello ()
	Response.Write ("</HR>")
%>

<body>
</body>
</html>
