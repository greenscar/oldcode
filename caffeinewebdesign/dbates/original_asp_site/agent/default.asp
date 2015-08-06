<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>                
<html>
<head>
	<title>Control Panel</title> 
</head>
<frameset rows="40,*" marginwidth="0" marginheight="0" spacing="0">
<frame src="cptoc.asp" name="toc" marginheight="0" scrolling="no" frameborder="yes">
<frame src="cpmain.asp" name="main">
</frameset>
</html>