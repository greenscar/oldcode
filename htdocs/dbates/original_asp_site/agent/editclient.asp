<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1'); %>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/ClientTable.asp"-->                
<!--#Include virtual="/component/AssociateTable.asp"-->                
<!--#Include virtual="/component/ActivityTable.asp"-->                
<!--#Include virtual="/component/MailTable.asp"-->                

<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)
{
$ID=uc($Request->QueryString('ID')->item);
$ExistingClient = $ClientTable->GetRecord("ID='$ID'",''); 
%>
<html>
<head>
	<title>Web Client Information</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
        <script language="javascript">
        <!--
        if (!<%=$ExistingClient%>)
        	{ClientCreate=window.confirm("Client [<%=$ID%>] does not exist.\n Create new client?");
                if (!ClientCreate)
        		{location.href="cpmain.asp";}
        	}
        //-->
        </script>  
	<script language="javascript" src="/agent/document/resource/validation.js"></script> 
</head>   
<body> 
<a name="top"></a>            
<form name="DBForm" action="EditClient.asp" method="post">      
	<input type="hidden" name="ID" value="<%=$ID%>">
	<input type="hidden" name="deletion" value="0">   
	<input type="hidden" name="Complete"/>
	<input type="hidden" name="IncludedFields"/>

<table border="0" width="90%" bgcolor="#EFEFEF" cellspacing="0" cellpadding="2px" align="center">                                     
	<tr>
		<td align="center" colspan="2">
			<h1><%=$ExistingClient ? 'Update':'Create'%> Client Account</h1>
		</td>
	</tr>
	<tr bgcolor="D0D0D0">
		<td align="left">Client ID</td>
		<td><b><%=$ID%></b></td>
	</tr>       
	<tr bgcolor="D0D0D0">
		<td align="left">Status</td>
		<td>
			<input type="radio" name="Active" value="1" <%= ${$ClientTable->FieldData}{'Active'}{value}[0] ? 'CHECKED' : ''%> > Active 
			<input type="radio" name="Active" value="0" <%= ${$ClientTable->FieldData}{'Active'}{value}[0] ? '' : 'CHECKED'%> > Inactive
		</td>
	</tr>
	<tr>
		<td align="left">Client Name</td>
		<td><input type="text" name="Name"  required="1" value="<%=${$ClientTable->FieldData}{'Name'}{value}[0]%>" size="40"></td>
	</tr>

	<tr>
		<td align="left">Contact Name</td>
		<td><input type="text" name="ContactName" required="1" value="<%=${$ClientTable->FieldData}{'ContactName'}{value}[0]%>"  size="30"></td>
	</tr>

	<tr>
		<td align="left">Contact Phone</td>
		<td><input type="text" name="ContactPhone" value="<%=${$ClientTable->FieldData}{'ContactPhone'}{value}[0]%>"  size="21"></td>
	</tr>

	<tr>
		<td>Contact E-mail</td>
		<td><input type="text" name="ContactEmail" required="1" value="<%=${$ClientTable->FieldData}{'ContactEmail'}{value}[0]%>" size="30"></td>
	</tr>

<%
if (!$ExistingClient)
	{%> 
	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp</td>
	</tr>
	<tr>
		<td>Set Password<br><small>at least 6 long</small></td>
		<td><input type="text" name="ManualPassword" size="6"><small>&nbsp;&nbsp;(Leave blank to generate random password)</small></td>
	</tr> 
	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp</td>
	</tr> 
	<%}
%>     
<%
#                        
$Response->Flush;
$NoneOption = "<option value='ZZZ'> None </option>";
$DeptCommercial = $NoneOption.join("\n",$AssociateTable->DataToOptions('DeptCommercial=1','Name','ID','Name'));
$DeptAll = $NoneOption.join("\n",$AssociateTable->DataToOptions('DeptOutside=0','Name','ID','Name'));
$DeptPersonal = $NoneOption.join("\n",$AssociateTable->DataToOptions('DeptPersonal=1','Name','ID','Name'));
$DeptMarine = $NoneOption.join("\n",$AssociateTable->DataToOptions('DeptMarine=1','Name','ID','Name'));
$DeptProfProg = $NoneOption.join("\n",$AssociateTable->DataToOptions('DeptProfProg=1','Name','ID','Name'));

%>                                                
  
<!-- Lead Section -->
	<tr bgcolor="D0D0D0">
		<td></td>
		<td><b>Multi-line accounts:</b></td>
	</tr>
	<tr bgcolor="D0D0D0">
		<td>Lead Producer</td>
		<td>
			<select name="ProdLead">
				<%
				$ThisDeptAll = $DeptAll;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'ProdLead'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>
	<tr bgcolor="D0D0D0">
		<td>Lead CSR</td>
		<td>
			<select name="CSRLead">
				<%
				$ThisDeptAll = $DeptAll;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'CSRLead'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>  

<!-- Department Start -->      
	<tr>
		<td align="right">
			<input type="checkbox" name="DeptCommercial" value='1' <%=${$ClientTable->FieldData}{DeptCommercial}{value}[0]?'CHECKED':''%>>
		</td>
		<td><b>Commercial Lines Client?<b></td>
	</tr>
	
	<tr>
		<td>Producer </td>
		<td>
			<select name="ProdCommercial">
				<%
				$ThisDeptAll = $DeptCommercial;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'ProdCommercial'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>

	</tr>            
	<tr>
		<td>CSR </td>
		<td>
			<select name="CSRCommercial">
				<%
				$ThisDeptAll = $DeptCommercial;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'CSRCommercial'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>

	</tr>            
	
	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp</td>
	</tr> 
<!-- Department End -->

<!-- Department Start -->      
	<tr>
		<td align="right">
			<input type="checkbox" name="DeptMarine" value='1'  <%=${$ClientTable->FieldData}{DeptMarine}{value}[0]?'CHECKED':''%>>
		</td>
		<td><b>Marine Client?</b></td>
	</tr>
	
	<tr>
		<td>Producer </td>
		<td>
			<select name="ProdMarine">
				<%
				$ThisDeptAll = $DeptMarine;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'ProdMarine'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>            
	<tr>
		<td>CSR </td>
		<td>
			<select name="CSRMarine">
				<%
				$ThisDeptAll = $DeptMarine;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'CSRMarine'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>            
	
	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp</td>
	</tr> 
<!-- Department End --> 
<!-- Department Start -->      
	<tr>
		<td align="right">
			<input type="checkbox" name="DeptPersonal" value='1'  <%=${$ClientTable->FieldData}{DeptPersonal}{value}[0]?'CHECKED':''%>>
		</td>
		<td><b>Personal Lines Client?</b></td>
	</tr>
	
	<tr>
		<td>Producer </td>
		<td>
			<select name="ProdPersonal">
				<%
				$ThisDeptAll = $DeptPersonal;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'ProdPersonal'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>            
	<tr>
		<td>CSR </td>
		<td>
			<select name="CSRPersonal">
				<%
				$ThisDeptAll = $DeptPersonal;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'CSRPersonal'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>            
	
	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp</td>
	</tr> 
<!-- Department End -->
<!-- Department Start -->      
	<tr>
		<td align="right">
			<input type="checkbox" name="DeptProfProg" value='1'  <%=${$ClientTable->FieldData}{DeptProfProg}{value}[0]?'CHECKED':''%>>
		</td>
		<td><b>Professional Department Client?</b></td>
	</tr>
	
	<tr>
		<td>Producer codes</td>
		<td>
			<select name="ProdProfProg">
				<%
				$ThisDeptAll = $DeptProfProg;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'ProdProfProg'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>            
	<tr>
		<td>CSR codes</td>
		<td>
			<select name="CSRProfProg">
				<%
				$ThisDeptAll = $DeptProfProg;
				$ThisDeptAll =~ s{<option (value='${$ClientTable->FieldData}{'CSRProfProg'}{value}[0]')>}{<option $1 selected>}isg;
				$Response->write($ThisDeptAll);
				%>
			</select>
		</td>
	</tr>            
	
	<tr bgcolor="#D0D0D0">
		<td colspan="2">&nbsp</td>
	</tr> 
<!-- Department End -->
	<tr>
		<td>Keywords to match</td>
		<td><input type="text" name="Profile" value="<%=${$ClientTable->FieldData}{'Profile'}{value}[0]%>"  ></td>
	</tr>    

	<tr bgcolor="D0D0D0">
		<td colspan="2" align="center">
<%
if (!$ExistingClient)
	{%>                                          
			<input type="button" value="Create Client Profile" onClick="FormValidation(1)"><br>
	<%}
else
	{%>
                        <input type="button" value="Update Client Profile" onClick="FormValidation(1)"><br>
                        <input type="button" value="Reset Client Password" onClick="location.href='ResetPW.asp?ID=<%=$ID%>';"><br>
			<input type="button" value="Delete Client Profile" onClick="DBForm.deletion.value=1;FormValidation(1);"><br>
	<%}
%>  
			<hr>
			<input type="button"  value="Cancel" onClick="location.href='cpmain.asp'">    
		</td>
	</tr>
</table>
</form> 

<hr>
<h2><a name="help"></a>About the "Client Account" page</h2>
<table border="0" cellpadding="4px">
        <tr bgcolor="#DDDDFF">
        	<td colspan="2"><b>Fields</b></td>
        </tr>
        
        <tr valign="top" width="200px">
        	<td align="right"><b>Client ID</b></td>
        	<td>The client's Delphi ID</td>
        </tr>  
        
        <tr valign="top">
        	<td align="right"><b>Account Status</b></td>
        	<td>This allows you to temporarily inactivate a client's access to secure features without actually deleting the client's account.</td>
        </tr>
        
        <tr valign="top">
        	<td align="right"><b>Contact Information (name, phone, email)</b></td>
        	<td>Mostly used for business clients -- the primary contact person for the account.  This is used as the default contact information in the web forms.</td>
        </tr>
        
        <tr valign="top">
        	<td align="right"><b>Set Password</b></td>
        	<td>You may either enter a password here, or leave the field blank and let the program generate a random password.</td>
        </tr>
        
        
        <tr valign="top">
        	<td align="right"><b>Lead Producer/CSR</b></td>
        	<td>For multi-line accounts, the producer and CSR who coordinate the account.  These associates are shown at the top of the client's D&B Contacts page.</td>
        </tr>
        
        <tr valign="top">
        	<td align="right"><b>Department client<br>Producer/CSR codes</b></td>
        	<td>Checking this box will cause the department to be displayed on the Client's contact page, as well as the producers and CSRs entered below.  Use the Delphi producer/CSR codes and seperate with a space or comma.</td>
        </tr>
        
        <tr valign="top">
        	<td align="right"><b>Profile keywords to match</b></td>
        	<td>These codes are matched against the codes assigned to articles, events, forms, links and news items in order to custom-create web pages for each particular client.  These codes can be Delphi department codes, NCIC industry codes, or whatever -- provided you guys are organized about it.  You could also put other kinds of codes here too, I suppose.  Together these codes constitute the <b>client profile</b>.</td>
        </tr>
        
        <tr bgcolor="#DDDDFF">
        	<td colspan="2"><b>Buttons</b></td>
        </tr>                                     
        
        <tr valign="top" width="200px">
        	<td align="right"><b>Create/Update Client Account</b></td>
        	<td>Creates/saves client account to database.  If this is a new account, a welcome e-mail is sent to the client with username/password information.</td>
        </tr>
        
        <tr valign="top" width="200px">
        	<td align="right"><b>Reset Client Password</b></td>
        	<td>If the client forgets their password you can reset their password here.  An e-mail will be sent to the client with their new password.</td>
        </tr>
        
        <tr valign="top" width="200px">
        	<td align="right"><b>Delete Client Account</b></td>
        	<td>You have to pass through another confirmation screen before the client's account is actually deleted.</td>
        </tr>
        
        <tr valign="top" width="200px">
        	<td align="right"><b>Done/Cancel</b></td>
        	<td>Returns you to agent control panel.</td>
        </tr>
</table>
</body>
</html>
<%
}
  
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/post/i)
{                                   
$ID = ${$Request->Form}{'ID'}{item}; 
$ExistingClient = $ClientTable->GetRecord("ID='$ID'");

$ClientTable->LoadFormData;

if ($ExistingClient)
	{
	if (${$Request->Form}{deletion}{item})
                {
                push @Alert, $ActivityLog->AddEntry('deleted',${$Request->Form}{Name}{item},'from','ClientTable');
                $ClientTable->DeleteRecord("ID='$ID'",$ActivityLog->{TRANSID});
                }
	else
		{
        	if ($ClientTable->UpdateRecord('',"ID='$ID'",''))
        		{push @Alert, $ActivityLog->AddEntry('updated',${$Request->Form}{Name}{item},'in','ClientTable');}
        	else
        		{push @Alert, "Error updating database";}
		}

	}
else
	{
	($PW) = ${$Request->Form}{ManualPassword}{item} =~ m{(\w+)}is;
	if (length($PW) < 4)
		{
		undef $PW;
		for ($i=0;$i<=6;$i++) {$PW.=chr(rand(26)+65);}
		}
	${$ClientTable->FieldData}{CryptPW}{value}[0] = crypt(uc($PW),join("", ('A'..'Z', 'a'..'z')[rand 64, rand 64]));
	if ($ClientTable->AddRecord)
		{push @Alert, $ActivityLog->AddEntry('created',${$Request->Form}{Name}{item},'in','ClientTable');}
	else
		{push @Alert, "Error creating new record";}
	                            
	$MailFile=$Server->MapPath('/').'/data/template/newpw.tem';
	@FileInfo = stat($MailFile);
     open (MailTemplate, "<$MailFile");
     read (MailTemplate, $MailTemplate, $FileInfo[7]);    
     close (MailTemplate);
     $MailTemplate =~ s{#ClientID#}{$ID}isg;
     $MailTemplate =~ s{#PW#}{$PW}isg;

	$AssociateRecords = $AssociateTable->GetRecord("ID='${$Session->{Persona}}[2][1]'",'');
	${$MailTable->FieldData}{FromName}{value}[0] = ${$AssociateTable->FieldData}{Name}{value}[0];
	${$MailTable->FieldData}{FromAddress}{value}[0] = ${$AssociateTable->FieldData}{Email}{value}[0];
	${$MailTable->FieldData}{Subject}{value}[0] = "Welcome To Durham and Bates Online";
	${$MailTable->FieldData}{BodyText}{value}[0] = $MailTemplate; 
	$MailTable->AddRecipient(${$ClientTable->FieldData}{Name}{value}[0],${$ClientTable->FieldData}{Email}{value}[0]);
        if ($MailTable->SendMail)
        	{push @Alert, "A welcome message has been sent to your client!";}
        else
        	{push @Alert, "There was a problem with the e-mail server.  The welcome message to your client has been queued for later delivery.";}
	$ActivityLog->AddEntry('sent','welcome e-mail','to',"${$Request->Form}{Name}{item}");
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