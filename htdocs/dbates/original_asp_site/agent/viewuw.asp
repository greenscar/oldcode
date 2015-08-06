<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>   
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/UWTable.asp"-->                
<html>
<head>
	<title>UW Index</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
</head>                                                   
<body>             
<table border="0" width="90%" cellspacing="0" cellpadding="0" bgcolor="#EFEFEF" align="center">                                     
	<tr>
		<td align="center" colspan="4">
			<h1>UW Index</h1>
		</td>
	</tr>             
	<tr bgcolor="#D0D0D0">
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr bgcolor="#DDDDFF">
		<td colspan="4" align="center">
			<b>Click on underwriter code to edit profile. Click on underwriter name to view their upload page.</b>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
<%
$UWRecords = $UWTable->GetRecord('Active=1','ID');
while ($index < int((1+$UWRecords)/2))
	{
	%>
	<tr>
		<td align="center">
			<a href="EditUW.asp?ID=<%=${$UWTable->FieldData}{ID}{value}[$index]%>"><p style="font-weight:bold;color:<%=${$UWTable->FieldData}{Active}{value}[$index]?'blue':'gray'%>"><%=${$UWTable->FieldData}{ID}{value}[$index]%></p></a>
		</td>
		<td>
			<a href="UWPage.asp?ID=<%=${$UWTable->FieldData}{ID}{value}[$index]%>">
				<%=${$UWTable->FieldData}{Name}{value}[$index]%>
			</a>
		</td> 

		<td align="center">
			<a href="EditUW.asp?ID=<%=${$UWTable->FieldData}{ID}{value}[$index+int((1+$UWRecords)/2)]%>"><p style="font-weight:bold;color:<%=${$UWTable->FieldData}{Active}{value}[$index+int((1+$UWRecords)/2)]?'blue':'gray'%>"><%=${$UWTable->FieldData}{ID}{value}[$index+int((1+$UWRecords)/2)]%></p></a>
		</td>
		<td>
			<a href="UWPage.asp?ID=<%=${$UWTable->FieldData}{ID}{value}[$index+int((1+$UWRecords)/2)]%>">
				<%=${$UWTable->FieldData}{Name}{value}[$index+int((1+$UWRecords)/2)]%>
			</a>
		</td>

	</tr>
	<%
	$index++;
	}	

%>
	<tr>
		<td colspan="4" align="center"><hr>
			<input type="button" value="Cancel" onClick="location.href='cpmain.asp'">    
		</td>
	</tr>
</table>
</body>
</html>