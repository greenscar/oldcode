<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>   
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/LinkTable.asp"-->                
<html>
<head>
	<title>Link Database</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
</head>                                                   
<body>             
<form>
<table border="0" cellpadding="0" cellspacing="0" width="90%" bgcolor="#EFEFEF" align="center">                                     
	<tr>
		<td align="center" colspan="2"><h1>Link Index</h1></td>
	</tr>               

	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp;</td>
	</tr>

	<tr bgcolor="#D0D0D0" align="center">
		<td><b>Link ID</b></td>
		<td><b>Link Title/Address</b></td>
	<tr bgcolor="#DDDDFF" align="center">
		<td width="150px">Click this column to edit the properties of the link</td>
		<td>Click link address to view actual site</td>
	</tr>   

	<%
$RecordCount = $LinkTable->GetRecord('','','Title');
while ($index < $RecordCount)
	{
	%>
	<tr>
		<td width="40px">
			<p>
			<a href="EditLink.asp?ID=<%=${$LinkTable->FieldData}{ID}{value}[$index]%>">
				<%=${$LinkTable->FieldData}{ID}{value}[$index]%>
			</a>
			</p>
		</td>
		<td>
			<p><b>
			<%=${$LinkTable->FieldData}{Title}{value}[$index]%>
			</b></p>
		</td>
	<tr>
		<td bgcolor="white">
		</td>
		<td bgcolor="white">
			<p style="margin-left:50pt">
				<a href="<%=${$LinkTable->FieldData}{Address}{value}[$index]%>" style="font-weight:normal;">
					<%=${$LinkTable->FieldData}{Address}{value}[$index]%>
				</a>
			</p>
		</td>
	</tr>
	<%
	$index++;
	}	
	%>
        <tr>
        	<td colspan="2" align="center"><hr>
        			<input type="button" value="Add New Link" onClick="location.href='EditLink.asp'"><br>
        			<input type="button" value="Cancel" onClick="location.href='cpmain.asp'">    
        	</td>
        </tr>
</table>
</form>
</body>
</html>