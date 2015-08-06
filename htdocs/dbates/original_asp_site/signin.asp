<%@ LANGUAGE = PerlScript %>  
<%
if (lc($Request->ServerVariables('HTTP_HOST')->item) ne 'www.dbates.com')
        {
	$Response->Redirect('http://www.dbates.com/client');
        }   
%>
<html>
<head>
	<title>Enter Client-Only Area</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/resource/dbates.css">
</head>
<body>
<!--#Include virtual="/component/PreToc.asp"-->
<img src="/resource/title.jpg"><br>
<img src="/resource/logon.gif"><br>
       <p>
	The page you have requested is only available to registered clients 
        of Durham and Bates agencies.  To continue, please enter
        the ID and password which your agent provided to you.
	</p>
<form action="<%=$Session->{'AvailableHttpsProtocol'}%><%=$Request->ServerVariables('HTTP_HOST')->item%>/component/login.asp" method="post">
        &nbsp;&nbsp;&nbsp;&nbsp;  ID <input type="text" name="AllegedID" size="8">&nbsp;
        Password <input type="password" name="AllegedPW" size="6">&nbsp;&nbsp;  
	<input type="submit" value="Sign In">
	</form>      
<img src="/resource/linetab.gif"><br>
<h3 style="margin-bottom:0pt;">About the Client Site</h3>
<p>Durham and Bates is committed to providing its customers with an 
exceptional level of service.  In addition to the general information 
you will find on our main website, we have also created a seperate area
containing custom tools and resources that address the 
unique needs of individual clients.  If you are interested in taking advantage of these additional services 
please give us a call.
</p>
</li>
<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>

