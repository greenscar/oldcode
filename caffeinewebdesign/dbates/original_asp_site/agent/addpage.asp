<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<% &CheckAccount('agent','1'); %>
<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)
	{
%>
<html>                        
<head>
	<link rel="stylesheet" type="text/css" href="/agent/document/resource/agent.css">
	<title>Reference Existing Page</title>  
	<script language="javascript" src="/agent/document/resource/validation.js"></script>
</head>
<body> 
<a name="top"></a>     
<h1>Reference Existing Page</h1>
<form action="AddPage.asp" name="DBForm" method="post">   
	<input type="hidden" name="Complete"/>
	<input type="hidden" name="IncludedFields"/>

        <b>1. Enter address of page to reference</b>.
        	<ul><input type="text" name="Location" size="50" value = "http://www.dbates.com/" required="1"></ul>
        <b>2. What type of document is it?</b>
        	<ul>
                	<input type="radio" name="DocType" value="page" checked> Existing site page
                	<input type="radio" name="DocType" value="form"> Form
        	</ul>
        <b>3. Which access level? </b>
        	<ul>
                	<input type="radio" name="Access" value="0" checked>Public access
                	<input type="radio" name="Access" value="1">Clients only
        	</ul>
        <b>4. Will this be a featured item? </b>
        	<ul>
	        	<input type="checkbox" name="Feature" value="1">Featured
        	</ul>                                 
        <b>5. Document information</b>
	<table border="0">
        	<tr>
			<td>Title</td>
			<td><input type="text" size="30" name="Title" required="1"></td>
		</tr>
        	<tr>
			<td>Description</td>
			<td><textarea rows="3" cols="40" name="Description" wrap="virtual" required="1"></textarea></td>
		</tr>
        	<tr>
			<td>Profile keywords</td>
			<td><input type="text" size="30" name="Profile" required="1"></td>
		</tr>
        	<tr>
			<td>Expiration Date (of page reference)</td>
			<td>
				<input type="text" size="2" name="Month" onFocus="javascript:Time=new Date();this.value=1+Time.getMonth();">-
				<input type="text" size="2" name="Day" onFocus="javascript:Time=new Date();this.value=Time.getDate();">-
				<input type="text" size="4" name="Year" onFocus="javascript:Time=new Date();this.value=1+Time.getYear();">
			</td>
		</tr>
       	</table>
<hr>          
<center>
	<input type="button" value="Send Document" onClick="FormValidation(1)">
	<input type="button" value="Cancel" onClick="location.href='cpmain.asp'">
</center>
</form>          

<hr> 
<a name="help"></a>
</body></html>
<%
}

elsif ($Request->ServerVariables('REQUEST_METHOD')->item =~ m{post}i)
{
%>                 
<!--#Include virtual="/component/SQLTable.asp"-->  
<!--#Include virtual="/component/ActivityTable.asp"-->                
<!--#Include virtual="/component/DocTable.asp"-->                     
<%
$DocTable->LoadFormData;                               
${$DocTable->FieldData}{Expiration}{value}[0] = $main::ScriptingNamespace->ParameterDate(${$Request->Form}{Year}{item},-1+${$Request->Form}{Month}{item},${$Request->Form}{Day}{item});
if (${$DocTable->FieldData}{Expiration}{value}[0] < 0) {${$DocTable->FieldData}{Expiration}{value}[0] = 1100000000;}
${$DocTable->FieldData}{ID}{value}[0] = $ActivityLog->TransactionID;
if (${$DocTable->FieldData}{Location}{value}[0] =~ m{d\w*?bates\.com(/.*)}i)
	{${$DocTable->FieldData}{Location}{value}[0] = $1;} 
if (-e $Server->MapPath('/').${$DocTable->FieldData}{Location}{value}[0])
	{
        if ($DocTable->AddRecord)  
        	{push @Alert, $ActivityLog->AddEntry('referenced',${$DocTable->FieldData}{Title}{value}[0],'in','DocTable');}
        else 
        	{push @Alert, 'Error updating database';}
	}
else
	{push @Alert, 'Referenced page does not exist.  Double check address and try again';}
%>			
<html><head>
<script language="javascript">
<!--
<% for (@Alert) {%>alert("<%=$_%>");<%}%>
location.href="AddPage.asp";
//-->
</script>
</head></html>
<%
}      
%>
