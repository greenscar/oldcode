<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->   
<!--#Include virtual="/component/MailTable.asp"-->
<%
$MailTable->GetRecord("TransID='${$Request->QueryString}{TransID}{item}'",'');
$MailFile=$Server->MapPath('/').'/data/template/email.tem';
@FileInfo = stat($MailFile);
open (MailTemplate, "<$MailFile");
read (MailTemplate, $MailTemplate, $FileInfo[7]);    
close (MailTemplate);     

${$MailTable->FieldData}{Recipients}{value}[0] = join (',<br>', ${$MailTable->FieldData}{Recipients}{value}[0] =~ m{<name>(.*?)</name>}isg);
${$MailTable->FieldData}{ServerTime}{value}[0] = $ScriptingNamespace->UTCTime(${$MailTable->FieldData}{ServerTime}{value}[0]);
${$MailTable->FieldData}{BodyText}{value}[0] =~ s{<.?html>}{}isg;
${$MailTable->FieldData}{BodyText}{value}[0] =~ s{<.?body>}{}isg;

for (keys %{$MailTable->FieldData})
	{$MailTemplate =~ s{#$_#}{${$MailTable->FieldData}{$_}{value}[0]}isg;}
$Response->write($MailTemplate);
%>