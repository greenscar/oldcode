<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>   
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/ClientTable.asp"-->                
<html>
<head>
	<title>Web Client Index</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
</head>                                                   
<body>             
	<table border="0" width="90%" cellspacing="0" cellpadding="0" bgcolor="#EFEFEF" align="center">                                     
	<tr>
		<td align="center" colspan="2">
			<h1>Web Client Index</h1>
		</td>
	</tr>             
	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr bgcolor="#DDDDFF">
		<td colspan="2" align="center">
		<b>Click on client name to view account.</b>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<%  
$ClientRecords = $ClientTable->GetRecord('Active=1','ID');
while ($index < $ClientRecords)
	{
	%>
	<tr>
		<td align="center">
			<%=${$ClientTable->FieldData}{ID}{value}[$index]%>
		</td>
		<td>
			<a href="EditClient.asp?ID=<%=${$ClientTable->FieldData}{ID}{value}[$index]%>">
				<%=${$ClientTable->FieldData}{Name}{value}[$index]%>			</a>
		</td>
	</tr>
	<%      
	$index++;
	}	
	%>
	<tr>
		<td colspan=2 align="center">
			<hr>
			<input type="button"  value="Done" onClick="location.href='cpmain.asp'">
		</td>
	</tr>
</table>       
</body>
</html>
	