<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->   
<!--#Include virtual="/component/ActivityTable.asp"--> 
<!--#Include virtual="/component/AssociateTable.asp"--> 
<!--#Include virtual="/component/MailTable.asp"-->
<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)
{%>
<html>
<head>
	<title>Suggestions and Comments</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
</head>     
<body>
<h1 style="margin:5pt">Suggestions</h1>                
<p>Please feel free to share any ideas, suggestions or comments 
you may have to improve our online services.  This site is being designed for <b>your</b> use.</p>
<br>
<form action="suggest.asp" method="post">
<center><textarea wrap="virtual" cols="50" rows="6" name="suggestion"></textarea><br>
<input type="submit" value="Send Suggestion">
<input type="button" value="Cancel" onClick="location.href='cpmain.asp'">
</center>
</form>
</body>
</html>
<%}   

elsif ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/post/i)
{
$Suggestion = ${$Request->Form}{Suggestion}{item};

$AssociateRecords = $AssociateTable->GetRecord("ID='${$Session->{Persona}}[2][1]'",'');
${$MailTable->FieldData}{FromName}{value}[0] = ${$AssociateTable->FieldData}{Name}{value}[0];
${$MailTable->FieldData}{FromAddress}{value}[0] = ${$AssociateTable->FieldData}{Email}{value}[0];
${$MailTable->FieldData}{Subject}{value}[0] = "Suggestion";
${$MailTable->FieldData}{BodyText}{value}[0] = "<p>".${$Request->Form}{suggestion}{item}."</p>";
$MailTable->AddRecipient('role#webmaster','');
$MailTable->AddRecipient('role#dbmonitor','');

if ($MailTable->SendMail)
	{push @Alert, "Your suggestion has been sent!";}
else
	{push @Alert, "There was a problem with the mail server.  Your suggestion has been queued for later delivery.";}

%>
<html>
<head>
        <script language="javascript">
        <!--
	<% for (@Alert) {%>alert('<%=$_%>');<%}%>
        location.href="cpmain.asp";
        //-->
        </script>
</head>
</html>
<%
}
%>