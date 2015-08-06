<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/AssociateTable.asp"-->                
<!--#Include virtual="/component/ActivityTable.asp"-->                
<%

if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)

{
$ID=uc($Request->QueryString('ID')->item);
$AssociateExists = $AssociateTable->GetRecord("ID='$ID'",''); 

%>
<html>
<head>
	<title>Associate Profiles</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
        
	<script language="javascript">
        <!--
        if (!<%=$AssociateExists%>)
        	{
		AssocCreate=window.confirm("Associate [<%=$ID%>] does not exist.\n Create new profile?");
                if (!AssocCreate)
        		{location.href="cpmain.asp";}
        	}
        //-->
        </script> 
  
	<script language="javascript" src="/agent/document/resource/validation.js"></script>
</head>                                                   
<body>             
<form name="DBForm" action="EditAssociate.asp" method="post">      
	<input type="hidden" name="ID" value="<%=$ID%>">
	<input type="hidden" name="Complete"/>
	<input type="hidden" name="IncludedFields"/>
	<table border="0" width="90%" bgcolor="#EFEFEF" cellspacing="2px" cellpadding="2px" align="center">                                     
	<tr>
		<td align="center" colspan="2">
			<h1><%=($AssociateExists)? 'Update':'Create'%> Associate Profile</h1>
		</td>
	</tr>   
	<tr bgcolor="D0D0D0" valign="top">
		<td align="right">Associate ID</td>
		<td><b><%=$ID%></b></td>
	</tr>
	<tr>
		<td align="right">Associate Name</td>
		<td><input type="text" name="Name"  required="1" value="<%=${$AssociateTable->FieldData}{'Name'}{value}[0]%>"  size="30"></td></tr>
	<tr>
		<td align="right">Status</td>
		<td>
			<input type="radio" name="Active" value="1" <%= ${$AssociateTable->FieldData}{'Active'}{value}[0] ? 'CHECKED' : ''%> > Active 
			<input type="radio" name="Active" value="0" <%= ${$AssociateTable->FieldData}{'Active'}{value}[0] ? '' : 'CHECKED'%> > Inactive
		</td>
	</tr>
	<tr>
		<td align="right">Title(s)</td>
		<td><input type="text" name="Title" required="1" value="<%=${$AssociateTable->FieldData}{'Title'}{value}[0]%>"  size="30"></td>
	</tr>
	<tr valign="top">
		<td align="right">Departments</td>
		<td>
			<input type="checkbox" name="DeptAgency" value='1' <%if (${$AssociateTable->FieldData}{'DeptAgency'}{value}[0] == 1) {%>CHECKED<%}%> > Agency Services<br>
        		<input type="checkbox" name="DeptCommercial" value='1' <%if (${$AssociateTable->FieldData}{'DeptCommercial'}{value}[0] == 1) {%>CHECKED<%}%> > Commercial Lines<br>
        		<input type="checkbox" name="DeptMarine" value='1' <%if (${$AssociateTable->FieldData}{'DeptMarine'}{value}[0] == 1) {%>CHECKED<%}%> > Marine<br>
        		<input type="checkbox" name="DeptPersonal" value='1' <%if (${$AssociateTable->FieldData}{'DeptPersonal'}{value}[0] == 1) {%>CHECKED<%}%> > Personal Lines<br>
        		<input type="checkbox" name="DeptProfProg" value='1' <%if (${$AssociateTable->FieldData}{'DeptProfProg'}{value}[0] == 1) {%>CHECKED<%}%> > Professional Liability<br>
        		<input type="checkbox" name="DeptConsulting" value='1' <%if (${$AssociateTable->FieldData}{'DeptConsulting'}{value}[0] == 1) {%>CHECKED<%}%> > General Business Consulting<br>
        		<input type="checkbox" name="DeptOutside" value='1' <%if (${$AssociateTable->FieldData}{'DeptOutside'}{value}[0] == 1) {%>CHECKED<%}%> > Outside Consultant
		</td>
	</tr>        
	<tr>
		<td align="right">Role Codes</td>
		<td><input type="text" name="Role" value="<%=${$AssociateTable->FieldData}{'Role'}{value}[0]%>"  size="30"></td>
	</tr>
	<tr>
		<td align="right">Direct Phone Line</td>
		<td><input type="text" name="DirectLine" required="1" value="<%=${$AssociateTable->FieldData}{'DirectLine'}{value}[0]%>"  size="21"></td>
	</tr>
	<tr>
		<td align="right">E-mail</td>
		<td><input type="text" name="Email" required="1" value="<%=${$AssociateTable->FieldData}{'Email'}{value}[0]%>" size="30"></td>
	</tr>
	<tr>
		<td align="right">Nearest fax</td>
		<td><input type="text" name="Fax" value="<%=${$AssociateTable->FieldData}{'Fax'}{value}[0]%>"  size="21"></td>
	</tr>
	<tr bgcolor="D0D0D0">
		<td colspan="2" align="center">
			<input type="button" value="<%=$AssociateExists?'Update':'Create'%> Associate Profile" onClick="FormValidation(1)"><br>
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
$ID = ${$Request->Form}{ID}{item};
$ExistingAssociate = $AssociateTable->GetRecord("ID='$ID'",'');
$StatusVector = ${$Request->Form}{Active}{item} - ${$AssociateTable->FieldData}{Active}{value}[0];
$AssociateTable->LoadFormData;
if ($ExistingAssociate)
	{
	if ($AssociateTable->UpdateRecord('',"ID='$ID'",''))
		{
                if ($StatusVector < 0)
        		{push @Alert, $ActivityLog->AddEntry('inactivated',${$Request->Form}{Name}{item},'in','AssociateTable');}
                if ($StatusVector == 0)
        		{push @Alert,  $ActivityLog->AddEntry('updated',${$Request->Form}{Name}{item},'in','AssociateTable');}
                if ($StatusVector > 0)
        		{push @Alert,  $ActivityLog->AddEntry('reactivated',${$Request->Form}{Name}{item},'in','AssociateTable');}
		}
	else
		{push @Alert,  "Error updating database";}
	}
else
	{
	${$AssociateTable->FieldData}{CryptPW}{value}[0] = crypt('TEST','db');
	if ($AssociateTable->AddRecord)
		{push @Alert,  $ActivityLog->AddEntry('created',${$Request->Form}{Name}{item},'in','AssociateTable');}
	else
		{push @Alert,  "Error creating new record";}
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