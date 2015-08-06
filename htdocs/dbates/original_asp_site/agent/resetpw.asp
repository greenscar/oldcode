<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<% &CheckAccount('agent','1'); %>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/ClientTable.asp"-->                
<!--#Include virtual="/component/AssociateTable.asp"-->                
<!--#Include virtual="/component/ActivityTable.asp"-->                
<!--#Include virtual="/component/MailTable.asp"-->                

<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)
{
$ID=uc($Request->QueryString('ID')->item);
$ClientTable->GetRecord("ID='$ID'",'');
%>
<html>
<head>
	<title>Reset Client Password</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
</head>     
<body>             
<form action="resetpw.asp" method="post">      
	<input type="hidden" name="ID" value="<%=$ID%>">
<table border="0" width="90%" bgcolor="#EFEFEF" cellspacing="1" cellpadding="5px" align="center">                                     
	<tr>
		<td align="center" colspan="2"><h1>Reset Client Password</h1></td></tr>
	<tr bgcolor="D0D0D0">
		<td>Client Name</td>
		<td><%=${$ClientTable->FieldData}{'ClientName'}{value}%></td></tr>
	<tr>
		<td>Client ID</td>
		<td><b><%=$ID%></b></td>
	</tr>                                
	<tr>
		<td>Reset Password<br><small>at least 6 long</small></td>
		<td><input type="text" name="ManualPassword" size="6"><small>&nbsp;&nbsp;(Leave blank to generate random password)</small></td>
	</tr> 
	<tr bgcolor="D0D0D0">                                        
		<td colspan="2" align="center">
                        <font color="red"><b>You are about to reset the client's password!</b></font><br><br>
			<input type="button" value="Yes, Reset Password" onClick="submit(this.form);"><hr>
			<input type="button" value="Cancel, Don't Reset" onClick="location.href='cpmain.asp'"><br>
		</td></tr>
</table>
</form>
</body>
</html>
<%
}  
     
elsif ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/post/i)
{
$ID=$Request->Form("ID")->item;  
($PW) = ${$Request->Form}{ManualPassword}{item} =~ m{(\w+)}is;
$ClientTable->GetRecord("ID='$ID'",'');

if (length($PW) < 4)
	{
	undef $PW;
	for ($i=0;$i<=6;$i++) {$PW.=chr(rand(26)+65);}
	}
${$ClientTable->FieldData}{CryptPW}{value}[0] = crypt(uc($PW),join("", ('A'..'Z', 'a'..'z')[rand 64, rand 64]));
if ($ClientTable->UpdateRecord(['CryptPW'],"ID='$ID'",''))
	{push @Alert, $ActivityLog->AddEntry('updated','password','for',${$ClientTable->FieldData}{Name}{value}[0]);}
else
	{push @Alert, "Error updating client record";}
                            
$MailFile=$Server->MapPath('/').'/data/template/resetpw.tem';
@FileInfo = stat($MailFile);
open (MailTemplate, "<$MailFile");
read (MailTemplate, $MailTemplate, $FileInfo[7]);    
close (MailTemplate);
$MailTemplate =~ s{#ClientID#}{$ID}isg;
$MailTemplate =~ s{#PW#}{$PW}isg;

$AssociateRecords = $AssociateTable->GetRecord("ID='${$Session->{Persona}}[2][1]'",'');
${$MailTable->FieldData}{FromName}{value}[0] = ${$AssociateTable->FieldData}{Name}{value}[0];
${$MailTable->FieldData}{FromAddress}{value}[0] = ${$AssociateTable->FieldData}{Email}{value}[0];
${$MailTable->FieldData}{Subject}{value}[0] = "Durham and Bates Online";
${$MailTable->FieldData}{BodyText}{value}[0] = $MailTemplate; 
$MailTable->AddRecipient(${$ClientTable->FieldData}{Name}{value}[0],${$ClientTable->FieldData}{ContactEmail}{value}[0]);
if ($MailTable->SendMail)
	{push @Alert, "A welcome message has been sent to your client!";}
else
	{push @Alert, "There was a problem with the e-mail server.  The welcome message to your client has been queued for later delivery.";}
$ActivityLog->AddEntry('sent','Reset Password e-mail','to',"${$ClientTable->FieldData}{Name}{value}[0]");
%>			
<html><head>
<script language="javascript">
<!--
<% for (@Alert) {%>alert('<%=$_%>');<%}%>
location.href="cpmain.asp";
//-->
</script>
</head></html>
<%
}
%>
                          
