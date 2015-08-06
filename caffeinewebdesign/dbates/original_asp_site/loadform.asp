<%@ LANGUAGE = PerlScript %>   
<!--#Include virtual="/component/Redirect.asp"-->
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"-->  
<!--#Include virtual="/component/ClientTable.asp"-->  
<%                         
$Session->{Timeout} = 60;     
$Session->{Form} = 0;  
if ($Session->{Form})
	{
	push @Alert, "You cannot process two forms at once.  Please finish your current form first";
	$Failure=1; 
	$Finish=1;
	}      
else
	{          
        $ID = ${$Request->QueryString}{ID}{item};        
        $FormFound = $DocTable->GetRecord("ID='$ID'",''); 
        $ThisForm = ${$DocTable->FieldData}{Location}{value}[0];
        if ($FormFound and -e $Server->MapPath($ThisForm))
        	{
        	$Access = ${$DocTable->FieldData}{Access}{value}[0]?'client':'public';
        	&CheckAccount($Access,'1');  
		&ConfirmPrivacy;
                }
        else     
        	{
        	push @Alert, "Requested form could not be found";
        	$Failure=1;
        	}   
	}   
                   
if ($Failure)
	{
	%>			
	<html><head>
        <script language="javascript">
        <!--
        <% for (@Alert) {%>alert("<%=$_%>");<%}%>
	<%
	if ($Finish)
		{%>location.href="/EditForm.asp";<%}
	else       
		{%>location.href="/client";<%}%>
        //-->
        </script>
        </head></html>
	<%
	exit;
	}

@FileInfo = stat($Server->MapPath($ThisForm));
open (FORM, '<'.$Server->MapPath($ThisForm));
read (FORM, $SubmissionTree, $FileInfo[7]);
close (FORM);

# Notify session we've got form underway, load the tree.
$Session->{Form}=1;
$Session->{FormViewer}='client';
$Session->{FormViewMode}='page';
$Session->{XMLFile} = $Server->CreateObject("MSXML.DOMDocument");
$Session->{XMLFile}->{async} = false;
$Session->{XMLFile}->loadXML($SubmissionTree); 
$Session->{XMLFile}->setProperty("SelectionLanguage", "XPath");
   
# Add nodes containing document and client information
$DocTable->DataToNode($Session->{XMLFile}->documentElement);
$ClientID = ${$Session->{Persona}}[${$DocTable->FieldData}{Access}{value}[0]][1];   
$ClientTable->GetRecord("ID='$ClientID'",'');
$ClientTable->DataToNode($Session->{XMLFile}->documentElement);

# One-time default values accessed from references
$ExternalReferences = $Session->{XMLFile}->selectNodes('//refDefault');

for ($index = 0; $index < $ExternalReferences->{length}; $index++)
	{$ExternalReferences->item($index)->{text} = $Session->{XMLFile}->selectSingleNode($ExternalReferences->item($index)->{text})->{text};}

%>
<!--#Include virtual="/component/forms/LoadFormPage.asp"-->
