<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->   
<!--#Include virtual="/component/ActivityTable.asp"--> 
<!--#Include virtual="/component/MailTable.asp"-->
<% $Clear = ${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{post}i; %>
<html>
<head>
	<title>Queued e-mail messages</title>
	<link rel="stylesheet" type="text/css" href="/agent/document/resource/agent.css"> 
</head>
<body> 
<h2>Queued e-mail messages</h2>
<li>Click on subject to view message</li>
<br>   
<form action="unstick.asp" method="post">
<table border="1" width="90%">
	<tr align="center">
		<td bgcolor="black" align="center"><p style="color:white;margin:0pt;">Original send date</p></td>
		<td bgcolor="black" align="center"><p style="color:white;margin:0pt;">Sender</p></td>
		<td bgcolor="black" align="center"><p style="color:white;margin:0pt;">Recipient</p></td>
		<td bgcolor="black" align="center"><p style="color:white;margin:0pt;">Subject</p></td>
<%if ($Clear)
	{%>
		<td bgcolor="black" align="center"><p style="color:white;margin:0pt;">Success</p></td>
      <%}%>
	</tr>
<%
$MailRecords = $MailTable->GetRecord('','ServerTime');
while ($index < $MailRecords)
	{
	undef @Recipients;
        for (${$MailTable->FieldData}{Recipients}{value}[0] =~ m{<recipient>(.*?)</recipient>}isg)
	        {m{<name>(.*?)</name>}i;
		push @Recipients, $1;
		}
	$Recipients = join (',<br>',@Recipients);
	%>
	<tr>
		<td bgcolor="#D0D0D0"><%=@{[$ScriptingNamespace->PrettyTime(${$MailTable->FieldData}{ServerTime}{value}[0])]}%></td>
		<td bgcolor="#D0D0D0"><%=${$MailTable->FieldData}{FromName}{value}[0]%></td>
		<td bgcolor="#D0D0D0"><%=$Recipients%></td>
		<td bgcolor="#D0D0D0"><%=$Clear?'':"<a target='_new' href='ViewMail.asp?TransID=${$MailTable->FieldData}{TransID}{value}[0]'>"%><%=${$MailTable->FieldData}{Subject}{value}[0]%><%=$Clear?'':'</a>'%></td>
<%if ($Clear)
	{%>
		<td bgcolor="#D0D0D0" align="center"><b><%=$MailTable->RetrieveMail(${$MailTable->FieldData}{TransID}{value}[0])?'Y':'N'%></b></td>   
      <%}%>

	</tr>
	<%
	$index++;
	for (keys %{$MailTable->FieldData})
		{shift @{${$MailTable->FieldData}{$_}{value}};}
	}

if (!$Clear)
	{%>
	<tr>
		<td colspan="4" align="center"  valign="top" bgcolor="#A00000">
			<br><input type="submit" value="Clear queued messages">
		</td>
	</tr>
      <%}%>
	<tr>
		<td colspan="5" align="center" valign="top" bgcolor="#A00000">
			<br><input type="button" value="Done" onClick="javascript:location.href='cpother.asp'">
		</td>
	</tr>
</table> 
</form>                        
</body>
</html>   

