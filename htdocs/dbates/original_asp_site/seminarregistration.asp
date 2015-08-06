<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->   
<!--#Include virtual="/component/ActivityTable.asp"--> 
<!--#Include virtual="/component/AssociateTable.asp"--> 
<!--#Include virtual="/component/MailTable.asp"-->
<!--#Include virtual="/component/DocTable.asp"-->
<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/post/i)
{             
$ID = ${$Request->Form}{ID}{item};
$DocTable->GetRecord("ID='$ID'",'');

$MailBody = "
<html><body>
<p><b>${$DocTable->FieldData}{Title}{value}[0]</b><br>
Session: ${$Request->Form}{Session}{item}</p>
<ul>
        <li>Name: ${$Request->Form}{Name}{item}</li>
        <li>Company: ${$Request->Form}{Company}{item}</li>
        <li>Phone: ${$Request->Form}{Phone}{item}</li>
        <li>E-mail: ${$Request->Form}{Email}{item}</li>
        <li>Attendees: ${$Request->Form}{Attendees}{item}</li>
</ul>
</body></html>";

${$MailTable->FieldData}{FromName}{value}[0] = ${$Request->Form}{Name}{item};
${$MailTable->FieldData}{ReplyTo}{value}[0] = ${$Request->Form}{Email}{item};
${$MailTable->FieldData}{FromAddress}{value}[0] = 'SeminarRegistration@dbates.com';
${$MailTable->FieldData}{Subject}{value}[0] = "Seminar Registration";
${$MailTable->FieldData}{BodyText}{value}[0] = $MailBody;
$MailTable->AddRecipient(${$DocTable->FieldData}{RecipientName}{value}[0],${$DocTable->FieldData}{RecipientAddress}{value}[0]); 
if ($MailTable->SendMail)
	{push @Alert, "Your registration has been sent!";}
else
	{push @Alert, "There was a problem with the mail server.  Your suggestion has been queued for later delivery.";}
%>
<html>
<head>
        <script language="javascript">
        <!--
	<% for (@Alert) {%>alert('<%=$_%>');<%}%>
        location.href="events.asp";
        //-->
        </script>
</head>
</html>
<%
}
%>