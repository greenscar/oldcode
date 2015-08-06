<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/LinkTable.asp"-->     
<html>
<head>
	<title>Links to other online resources</title>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, link, resource, site, safety">
</head>
<body topmargin="0" leftmargin="0">
<!--#Include virtual="/component/PreToc.asp"-->
<img src="/resource/title.jpg" ><br>
<img src="/resource/t_links.jpg"> 
<p>The following insurance and safety-related sites also contain a wealth of information and resources.
<ul>
<%
$LinkRecords = $LinkTable->GetRecord('','Title');
while ($index < $LinkRecords)   
	{
	%>
	<li>
		<a href="<%=${$LinkTable->FieldData}{Address}{value}[$index]%>">
			<%=${$LinkTable->FieldData}{Title}{value}[$index]%>
		</a>
		&nbsp;&nbsp;
		<%=${$LinkTable->FieldData}{Description}{value}[$index]%>
	</li>
	<%
	$index++;
	}                          
%>
</ul>
<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body></html>