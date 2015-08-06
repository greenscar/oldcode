<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/SQLTable.asp"-->        
<!--#Include virtual="/component/ActivityTable.asp"-->
<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m{get}i)
	{%>
<html>
<head>
	<link REL='stylesheet' TYPE='text/css' HREF='/resource/dbates.css'>
	<title>Privacy Statement</title>
</head>
<body>
	<!--#Include virtual="/component/PreToc.asp"-->
	<!--#Include virtual="/component/PrivacyStatement.htm"-->
<%
        if ($Request->QueryString->{confirm}->{item})
        	{
	%>
        <center>
        	<p>
                	<form action="privacy.asp" method="post">
                		<input type="submit" value="I have read and agreed to the above conditions">
                	</form>
        	</p>
                <p>
                	<form action="/default.asp">
                		<input type="submit" value="I do NOT agree to the above conditions">
                	</form>
        	</p>
	</center>
	<%}%>

<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>  
<%}%>
<%
elsif ($Request->ServerVariables('REQUEST_METHOD')->item =~ m{post}i)
	{         
	$Session->{Privacy} = 1;
	$ActivityLog->AddEntry('confirmed','privacy statement','from',$Session->{'RedirectTarget'});
	$Response->Redirect($Session->{'RedirectTarget'});  
	}
%>