<%@Language="PerlScript"%>
<!--#Include virtual="/component/SQLTable.asp"--> 
<!--#Include virtual="/component/DocTable.asp"--> 
<!--#Include virtual="/component/ClientTable.asp"--> 
<!--#Include virtual="/component/SubmissionTable.asp"-->  
<!--#Include virtual="/component/Redirect.asp"-->                   
<%
$Session->{Form}=0;    
if ($Session->{Form})
	{
	push @Alert, "You cannot process two forms at once.  Finish your current form first";
	%>			
	<html><head>
        <script language="javascript">
        <!--
        <% for (@Alert) {%>alert("<%=$_%>");<%}%>
	location.href="/EditForm.asp"
        //-->
        </script>
        </head></html>
	<%
	exit;
	}   

if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{get}i)
	{
	$TransID = ${$Request->QueryString}{TransID}{item};
	$Clone = ${$Request->QueryString}{Clone}{item}; 

	if ($TransID)
		{    
		$RecordCount = $SubmissionTable->GetRecord("TransID='$TransID'",'');
		if ($RecordCount)	
			{                  
                        $Session->{XMLFile} = $Server->CreateObject("MSXML.DOMDocument");
                        $Session->{XMLFile}->{async} = false;
                        $Session->{XMLFile}->loadXML($SubmissionTable->FieldData->{Data}->{value}->[0]);   
			$Session->{XMLFile}->setProperty("SelectionLanguage", "XPath");
			$Access = $Session->{XMLFile}->selectSingleNode('//DocTable/Access')->{text}?'client':'public';
	        	&CheckAccount($Access,'1');
                        $Session->{Form}=1;
                        
                       	$CompletionStatus = ${$SubmissionTable->FieldData}{CompletionStatus}{value}[0];
			if ($Clone)
				{
				$CompletionStatus = 0;
				$SubmissionNode = $Session->{XMLFile}->selectSingleNode('//SubmissionTable');
				$Session->{XMLFile}->documentElement->removeChild($SubmissionNode); 
                                   
				$DocID = $Session->{XMLFile}->selectSingleNode('//DocTable/ID')->{text}; 
				$DocTable->GetRecord("ID='$DocID'",'');
				$DocNode = $Session->{XMLFile}->selectSingleNode('//DocTable');
				$Session->{XMLFile}->documentElement->removeChild($DocNode);  
				$DocTable->DataToNode($Session->{XMLFile}->documentElement);

				$ClientID = $Session->{XMLFile}->selectSingleNode('//ClientTable/ID')->{text}; 
				$ClientTable->GetRecord("ID='$ClientID'",'');
        			$ClientNode = $Session->{XMLFile}->selectSingleNode('//ClientTable');
				$Session->{XMLFile}->documentElement->removeChild($ClientNode);
				$ClientTable->DataToNode($Session->{XMLFile}->documentElement);

				$CompletedPages = $Session->{XMLFile}->selectNodes('//page[@complete]');				
				for ($index = 0; $index < $CompletedPages->{length}; $index++)
					{$CompletedPages->item($index)->removeAttribute('complete');}
				}

			%> 
			<!--#Include virtual="/component/forms/LoadFormPage.asp"-->
			<%     
			exit;
			} 
		else
			{push @Alert, "Invalid Submission ID, no matching form";}
		} 
	else
		{push @Alert, "Invalid Submission ID";}
	}
else
	{$Response->Redirect('/');}
%>
<html>
<head>
	<script language="javascript">
	<!--
		<% for (@Alert) {%>alert("<%=$_%>");<%}%>
		location.href="/client";
	//-->
	</script>
</head>
</html>