<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>   
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/AssociateTable.asp"-->                
<html>
<head>
	<title>Associate Index</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
</head>                                                   
<body>             
<table border="0" width="90%" cellspacing="0" cellpadding="0" bgcolor="#EFEFEF" align="center">                                     
	<tr>
		<td align="center" colspan="4">
			<h1>Associate Index</h1>
		</td>
	</tr>             
	<tr bgcolor="#D0D0D0">
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr bgcolor="#DDDDFF">
		<td colspan="4" align="center">
			<b>Click on associate name to view profile.</b>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
<%
$AssociateRecords = $AssociateTable->GetRecord('DeptOutside=0','ID');
while ($index < int((1+$AssociateRecords)/2))
	{
	%>
	<tr>
		<td align="center">
			<p style="font-weight:bold;color:<%=${$AssociateTable->FieldData}{Active}{value}[$index]?'#000000':'#0000A0'%>"><%=${$AssociateTable->FieldData}{ID}{value}[$index]%></p>
		</td>
		<td>
			<a href="EditAssociate.asp?ID=<%=${$AssociateTable->FieldData}{ID}{value}[$index]%>">
				<%=${$AssociateTable->FieldData}{Name}{value}[$index]%>
			</a>
		</td> 

		<td align="center">
			<p style="font-weight:bold;color:<%=${$AssociateTable->FieldData}{Active}{value}[$index+int((1+$AssociateRecords)/2)]?'#000000':'#0000A0'%>"><%=${$AssociateTable->FieldData}{ID}{value}[$index+int((1+$AssociateRecords)/2)]%></p>
		</td>
		<td>
			<a href="EditAssociate.asp?ID=<%=${$AssociateTable->FieldData}{ID}{value}[$index+int((1+$AssociateRecords)/2)]%>">
				<%=${$AssociateTable->FieldData}{Name}{value}[$index+int((1+$AssociateRecords)/2)]%>
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