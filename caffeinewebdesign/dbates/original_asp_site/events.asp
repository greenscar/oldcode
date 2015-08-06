<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"-->                     
<%
if ($Request->QueryString('popup')->item =~ m{on}i)
	{
	$Response->Cookies->SetProperty('item', 'publicDurhamAndBates', 'public'); 
	$Response->Cookies('PublicDurhamAndBates')->SetProperty('item', 'PopUp', 'on'); 
	}
%>
<html>
<head>
	<title>Durham and Bates - Events and Seminars</title>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, customer, resource, article, liability, employment, regulations, d&o">
</head>
<body topmargin="0" leftmargin="0">
<!--#Include virtual="/component/PreToc.asp"-->
	<img src="/resource/t_events.jpg"><br>

<p>Creating exceptional value for our clients is accomplished in part through our ongoing effort to organize and host events and seminars that directly benefit your business.  Whether it be an intimate seminar to present business owners with relevant issues concerning how e-Business will impact your business or a larger, accredited seminar for lawyers providing the required continuing education ethics credits for the year, Durham and Bates continually seeks ways to ensure the success of your business.</p>
<p><b>Seminars and Events:</b></p>
		<ul>
		<%$DocTable->DocList('event');%>     
		</ul>

 
<%
if ($Request->Cookies('publicDurhamAndBates')->Item('PopUp') =~ m{off})
	{
	%>
        <br>
        <table width="440px" cellspacing="0" cellpadding="0"><tr><td bgcolor="#808080" width="90%"><img src="/resource/spacer.gif"></td></tr></table>
        <img src="/resource/t_settings.jpg" border="0"><br>
	<p><b>Pop-up Announcements</b></p>
	<p>From time to time, Durham and Bates will announce an upcoming event 
	with a special pop-up window that appears when you first arrive at  
	our site.  You have switched off this feature.  If you decide 
	that you would like to see these announcements again <a href="/events.asp?popup=on">click here</a>.</p>
	<br>
	<%
	}
%>	
<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>
