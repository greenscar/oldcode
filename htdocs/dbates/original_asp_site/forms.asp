<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('client','0');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"-->                     
<html>
<head>
	<title>Durham and Bates - Forms and Applications</title>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, form, application, client, interactive, certificate, MVR, report">
</head>
<body topmargin="0" leftmargin="0">
<!--#Include virtual="/component/PreToc.asp"-->
	<img src="/resource/title.jpg" ><br>
	<img src="/resource/t_formapp.jpg"><br>
	<p>Click an item below to begin a new form or application.  
To copy, edit, or view a previously submitted form or application please visit the <a href='/client/FormManager.asp'>Submission Manager</a>.</p>
	<ul>
		<%$DocTable->DocList('form');%>     
	</ul>
        <br>
        <table width="440px" cellspacing="0" cellpadding="0"><tr><td bgcolor="#808080" width="90%"><img src="/resource/spacer.gif"></td></tr></table>
        <a href="/client/AccountSettings.asp">
		<img src="/resource/t_settings.jpg" border="0">
	</a>
        <br>
        <p>Would you like to log in automatically or change your contact information?</p>
	<ul>
	        <li class="feature"><p><a href="/client/AccountSettings.asp">Click here to access your Account Settings</a>.</p></li>
	</ul>
<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>
