<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>  
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/LinkTable.asp"-->                
<!--#Include virtual="/component/ActivityTable.asp"-->                

<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)
{                
$ID=$Request->QueryString('ID')->item;
if ($ID) {$ExistingLink = $LinkTable->GetRecord("ID='$ID'",'Title');}
%>
<html>
<head>
	<title>Edit Links</title>
	<link rel="stylesheet" type="text/css" href="/agent/document/resource/agent.css">
	<script language="javascript" src="/agent/document/resource/validation.js"></script>
</head>
<body> 
<a name="top"></a> 
<form name="DBForm" action="EditLink.asp" method="post">
	<input type="hidden" name="ID" value="<%=$ID%>">
	<input type="hidden" name="deletion" value="0">
	<input type="hidden" name="Complete"/>
	<input type="hidden" name="IncludedFields"/>

	<table border="0" width="90%" bgcolor="#EFEFEF" cellspacing="0" cellpadding="1px" align="center">
		<tr>                                                              
			<td align="center" colspan="2"><h1>Edit Links</h1></td>
		</tr>
                <tr bgcolor="#D0D0D0">
			<td colspan="2" height="20px"><b><%=$ID%></b></td>
		</tr>
		<tr>
			<td>Link Title</td>
			<td><input type="text" size="50" name="Title" required="1" value="<%=${$LinkTable->FieldData}{'Title'}{value}[0]%>"></td>
		</tr>
		<tr>
			<td>Link Description</td>
			<td><textarea cols="50" rows="4" wrap="virtual" name="Description"><%=${$LinkTable->FieldData}{'Description'}{value}[0]%></textarea></td>
		</tr>
		<tr>
			<td>Address</td><td><input type="text" size="50" name="Address" required="1" value="<%=${$LinkTable->FieldData}{'Address'}{value}[0]%>"></td>
		</tr>
		<tr>
			<td>Match Codes</td>
			<td><input type="text" size="50" name="Profile" value="<%=${$LinkTable->FieldData}{'Profile'}{value}[0]%>"></td>
		</tr>
		<tr bgcolor="#D0D0D0">
       			<td colspan="2" align="center">
                <%
                if ($ExistingLink)
                        {%>
                                <input type="button" value="Update Link" onClick="FormValidation(1)"><br>
                                <input type="button" value="Delete Link" onClick="DBForm.deletion.value=1;FormValidation(1)"><br>
                        <%}
                else
                        {%>
                                <input type="button" value="Create Link" onClick="FormValidation(1)">
                        <%}
                %>
			        <br>
				<input type="button" value="Cancel" onClick="location.href='cpmain.asp'">
		        </td>
		</tr>
        </table>
</form>  
<hr>
<a name="help"></a>
<h2>About the "Edit Links" page</h2>
<table border="0" cellpadding="4pt">
	<tr bgcolor="#DDDDFF">
		<td colspan="2"><b>Fields</b></td>
	</tr>
	<tr valign="top" width="200px">
		<td align="right"><b>Link Title, Description</b></td>
		<td>The link title and description to be displayed on the client's Links page.</td></tr>
	<tr valign="top" width="200px">
		<td align="right"><b>Address</b></td>
		<td>The actual address of the web site, such as http://www.dbates.com.  Please be sure to visit the site first to verify that the address actually works.</td></tr>
	<tr valign="top" width="200px">
		<td align="right"><b>Profile Codes</b></td>
		<td>These codes are matched against the keywords in the client's profile.  If a code appears in both the link's profile and the client's profile it will be displayed on the Links page.</td>
	</tr>
</table>
</body>
</html> 
<%
}

if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/post/i)
	{                      
	$ID = ${$Request->Form}{ID}{item};
	if ($ID)
		{
		if (${$Request->Form}{deletion}{item})
			{          
			push @Alert, $ActivityLog->AddEntry('deleted',"$ID",'from','LinkTable');
			$LinkTable->DeleteRecord("ID='$ID'",$ActivityLog->{TRANSID});
			}
		else
			{
			$LinkTable->LoadFormData;
			$LinkTable->UpdateRecord('',"ID='$ID'",'Title');
			push @Alert, $ActivityLog->AddEntry('updated',"$ID",'in','LinkTable');
                	}
		}
	else
		{
		$LinkTable->LoadFormData;
		if (${$LinkTable->FieldData}{Address}{value}[0] !~ m{http://}i)
			{${$LinkTable->FieldData}{Address}{value}[0] = 'http://'.${$LinkTable->FieldData}{Address}{value}[0];}
		if (${$LinkTable->FieldData}{Address}{value}[0] =~ m{http://(.*?)/}i)
			{$DomainName = $1;}
		elsif (${$LinkTable->FieldData}{Address}{value}[0] =~ m{http://(.*?)$}i)
			{$DomainName = $1;}
		($ID) = $DomainName =~ m{(\w+)\.\w+$}i;
		$ID = uc(substr($ID,0,7)); 
		while ($LinkTable->FindRecord("ID='$ID'"))
			{$ID = substr($ID,0,7).chr(ord(substr($ID,7,1)+1));}
		${$LinkTable->FieldData}{ID}{value}[0] = $ID;
		$LinkTable->AddRecord;    
		push @Alert, $ActivityLog->AddEntry('added',"$ID",'to','LinkTable');
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