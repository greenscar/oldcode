<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->               
<!--#Include virtual="/component/AssociateTable.asp"-->                      
<!--#Include virtual="/component/UWTable.asp"-->                
<%

if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)

{
$ID=uc($Request->QueryString('ID')->item);
$UWExists = $UWTable->GetRecord("ID='$ID'",''); 

%>
<html>
<head>
	<title>UW Profiles</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
        
	<script language="javascript">
        <!--
        if (!<%=$UWExists%>)
        	{
		UWCreate=window.confirm("Underwriter [<%=$ID%>] does not exist.\n Create new profile?");
                if (!UWCreate)
        		{location.href="cpmain.asp";}
        	}
        //-->
        </script> 
  
	<script language="javascript" src="/agent/document/resource/validation.js"></script>
</head>                                                   
<body>             
<form name="DBForm" action="EditUW.asp" method="post">      
	<input type="hidden" name="ID" value="<%=$ID%>">
	<input type="hidden" name="Complete"/>
	<input type="hidden" name="IncludedFields"/>
	<table border="0" width="90%" bgcolor="#EFEFEF" cellspacing="2px" cellpadding="2px" align="center">                                     
	<tr>
		<td align="center" colspan="2">
			<h1><%=($UWExists)? 'Update':'Create'%> UW Profile</h1>
		</td>
	</tr>   
	<tr bgcolor="D0D0D0" valign="top">
		<td align="right">UW ID</td>
		<td><b><%=$ID%></b></td>
	</tr>
	<tr>
		<td align="right">UW Name</td>
		<td><input type="text" name="Name"  required="1" value="<%=${$UWTable->FieldData}{'Name'}{value}[0]%>"  size="30"></td>
	</tr>
	<tr>
		<td style="text-align: right;">E-mail</td>
		<td><input type="text" name="ContactEmail" required="1" value="<%=${$UWTable->FieldData}{'ContactEmail'}{value}[0]%>" size="30"></td>
	</tr>
	<tr>
		<td align="right">Status</td>
		<td>
			<input type="radio" name="Active" value="1" <%= !$UWExists || ${$UWTable->FieldData}{'Active'}{value}[0] ? 'CHECKED' : ''%> > Active 
			<input type="radio" name="Active" value="0" <%= !$UWExists || ${$UWTable->FieldData}{'Active'}{value}[0] ? '' : 'CHECKED'%> > Inactive
		</td>
	</tr>
<%
if (!$UWExists)
	{%> 
	<tr bgcolor="#D0D0D0">
		<td colspan="2"/>
	</tr>
	<tr>
		<td style="text-align:right;">Set Password<br><small>at least 6 long</small></td>
		<td><input type="text" name="ManualPassword" size="6"><small>&nbsp;&nbsp;(Leave blank to generate random password)</small></td>
	</tr> 
	<tr bgcolor="#D0D0D0"/>
	</tr> 
	<%}
else
	{%> 
	<tr bgcolor="#D0D0D0">
		<td colspan="2"/>
	</tr>
	<tr>
		<td style="text-align:right;">Reset Password<br><small>at least 6 long</small></td>
		<td><input type="text" name="ManualPassword" size="6"><small>&nbsp;&nbsp;(Leave blank to keep existing password)</small></td>
	</tr> 
	<tr bgcolor="#D0D0D0"/>
	</tr> 
	<%}
%>     
<%
$UWRoot = $main::Server->MapPath('/data/uw');
opendir (UW, $UWRoot);
@Folders = sort {uc($a) cmp uc($b)} readdir(UW);
close (UW);
for $ThisFolder (@Folders)
	{
	if (($ThisFolder =~ m{\w}) && (-d "$UWRoot/$ThisFolder"))
		{
		$Folders.= "<option";
		if (!$UWExists || ($ThisFolder eq ${$UWTable->FieldData}{'Folder'}{value}[0])) {$Folders.=" SELECTED ";}
		$Folders.=">$ThisFolder</option>\n";
		}
	}
%>
	<tr bgcolor="#D0D0D0">
		<td colspan="2"/>
	</tr>
	<tr>
		<td style="text-align:right;">Assign to folder:</td>
		<td>
			<table>
				<tr>
					<td>Choose existing folder </td>
					<td><select name="Folder"><%=$Folders%></select></td>
				</tr>
				<tr>
					<td colspan="2">Or create a new folder</td>
					<td><input name="NewFolder" size="10"/></td>
				</tr>
			</table>
		</td>
	</tr> 
	<tr bgcolor="#D0D0D0"/>
	</tr> 


	<tr bgcolor="D0D0D0">
		<td colspan="2" align="center">
			<input type="button" value="<%=$UWExists?'Update':'Create'%> UW Profile" onClick="FormValidation(1)"><br>
                        <hr>
                        <input type="button"  value="Cancel" onClick="location.href='cpmain.asp'">    
                </td>
	</tr>
</table>
</form>
<br><br> 
</body>
</html>
<%      
}  

if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/post/i)
                      
{                                                     
%><!--#Include virtual="/component/ActivityTable.asp"--><%
%><!--#Include virtual="/component/MailTable.asp"--><%

$ID = ${$Request->Form}{ID}{item};
$ExistingUW = $UWTable->GetRecord("ID='$ID'",'');
$StatusVector = ${$Request->Form}{Active}{item} - ${$UWTable->FieldData}{Active}{value}[0];
$UWTable->LoadFormData;
                                            
if (${$Request->Form}{NewFolder}{item})
	{
	$NewFolder = ${$Request->Form}{NewFolder}{item};
	$NewFolder =~ s{\W}{}isg;
	$NewFolder = substr($NewFolder, 0, 16);
	$FSO = Win32::OLE->new("Scripting.FileSystemObject");
	$FSO->createFolder($Server->MapPath('/data/uw').'/'.$NewFolder);
	undef $FSO;
	${$UWTable->FieldData}{Folder}{value}[0] = $NewFolder;
	}

if (${$Request->Form}{ManualPassword}{item})
	{
	($PW) = ${$Request->Form}{ManualPassword}{item} =~ m{(\w+)}is;
	if (length($PW) < 4)
		{
		undef $PW;
		for ($i=0;$i<=6;$i++) {$PW.=chr(rand(26)+65);}
		}
	${$UWTable->FieldData}{CryptPW}{value}[0] = crypt(uc($PW),join("", ('A'..'Z', 'a'..'z')[rand 64, rand 64]));
	                            
	$MailFile=$Server->MapPath('/').'/data/template/newuwpw.tem';
        open (MailTemplate, "<$MailFile") || die $!;
	@FileInfo = stat(MailTemplate);	
        read (MailTemplate, $MailTemplate, $FileInfo[7]);    
        close (MailTemplate);
        $MailTemplate =~ s{#UWID#}{$ID}isg;
        $MailTemplate =~ s{#PW#}{$PW}isg;

	$AssociateRecords = $AssociateTable->GetRecord("ID='${$Session->{Persona}}[2][1]'",'');
        ${$MailTable->FieldData}{FromName}{value}[0] = ${$AssociateTable->FieldData}{Name}{value}[0];
        ${$MailTable->FieldData}{FromAddress}{value}[0] = ${$AssociateTable->FieldData}{Email}{value}[0];
        ${$MailTable->FieldData}{Subject}{value}[0] = "Welcome To Durham and Bates Online";
        ${$MailTable->FieldData}{BodyText}{value}[0] = $MailTemplate; 
        $MailTable->AddRecipient(${$UWTable->FieldData}{Name}{value}[0],${$UWTable->FieldData}{ContactEmail}{value}[0]);
        if ($MailTable->SendMail)
	        {push @Alert, "A welcome message has been sent to your underwriter!";}
        else
        	{push @Alert, "There was a problem with the e-mail server.  The welcome message to your underwriter has been queued for later delivery.";}
        $ActivityLog->AddEntry('sent','welcome e-mail','to',"${$Request->Form}{Name}{item}");
	}

if ($ExistingUW)
	{
	if ($UWTable->UpdateRecord('',"ID='$ID'",''))
		{
                if ($StatusVector < 0)
        		{push @Alert, $ActivityLog->AddEntry('inactivated',${$Request->Form}{Name}{item},'in','UWTable');}
                if ($StatusVector == 0)
        		{push @Alert,  $ActivityLog->AddEntry('updated',${$Request->Form}{Name}{item},'in','UWTable');}
                if ($StatusVector > 0)
        		{push @Alert,  $ActivityLog->AddEntry('reactivated',${$Request->Form}{Name}{item},'in','UWTable');}
		}
	else
		{push @Alert,  "Error updating database";}
	}
else
	{
	if ($UWTable->AddRecord)
		{push @Alert, $ActivityLog->AddEntry('created',${$Request->Form}{Name}{item},'in','UWTable');}
	else
		{push @Alert, "Error creating new record";}
	}

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