<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"-->                     
<html>
<head>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<title>Durham & Bates Sponsored Events</title>
	<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, specialist, coverage, business, commercial, professional, marine, personal, property, casualty, liability">
</head>

<!--DBToc-->
<body topmargin="0" leftmargin="0">
<!--#Include virtual="/component/PreToc.asp"-->        
<img src="/resource/t_about.jpg" width="110" height="23"><br>    
<br><p><img src="/resource/dbnews.jpg"></p>
<p>Durham and Bates will use this forum to shares news of activities, sponsorships, seminars and events.  We always welcome your feedback and questions regarding this information.</p>
<ul>
        <%$DocTable->DocList('news');%><br>     
</ul>     
<br>
<!--#Include virtual="/component/MidToc.asp"--> 
	<hr>
<!--#Include virtual="/component/AboutBar.asp"-->   
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>