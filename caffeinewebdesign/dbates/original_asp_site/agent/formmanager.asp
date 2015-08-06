<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/SubmissionTable.asp"-->  
<%
if (${$Request->QueryString}{ID}{item})
	{push @Criterion, "ClientID='${$Request->QueryString}{ID}{item}'";}
$Criteria = join ('AND ',@Criterion);   
%>
<html>
<head>
	<title>Durham and Bates - Submissions Manager</title>
	<link rel="stylesheet" type="text/css" href="/agent/document/resource/agent.css">
</head>
<body> 
<h3>Submission Manager</h2>
<%$SubmissionTable->SearchSubmissions($Criteria);%>
</body>
</html>
