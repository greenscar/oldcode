<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>  
<!--#Include virtual="/component/SQLTable.asp"-->                      
<!--#Include virtual="/component/ActivityTable.asp"--> 
<%
$Response->{ContentType} = 'text/html';
$PersonaType = ${$Request->QueryString}{type}{item};
$RecordCount = $ActivityLog->GetRecord("PersonaType='$PersonaType'",'ServerTime');
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="/agent/document/resource/agent.css">
</head>
<body> 
<h3>Activity Log: <%=ucfirst($PersonaType)%> Entries</h3>
<%                                        
while ($index < $RecordCount)
	{
	$Response->Write("<p style='font-family:arial;font-size:8pt;margin-left:2pt;'>@{[$ActivityLog->ParseEntry]}</li><br>");
	for $ColumnName (keys %{$ActivityLog->FieldData})
		{shift @{${$ActivityLog->FieldData}{$ColumnName}{value}};}
	$Response->Flush;  
	$index++;
	}
%> 
<form><input type="button" value="Done" onClick="javascript:location.href='cpmain.asp'"></form>
</body>
</html>
