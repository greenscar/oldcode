<%@Language="PerlScript"%>
<!--#Include virtual="/component/SQLTable.asp"--> 
<!--#Include virtual="/component/SubmissionTable.asp"-->              
<!--#Include virtual="/component/ActivityTable.asp"-->
<!--#Include virtual="/component/Redirect.asp"-->       
<%                      
&CheckAccount('agent','1');
$Session->{Form} = 0;    
if ($Session->{Form})
	{
	push @Alert, "You cannot view two forms at once.  Please close the current form first";
	%>			
	<html><head>
        <script language="javascript">
        <!--
        <% for (@Alert) {%>alert("<%=$_%>");<%}%>
	location.href="/agent/ViewForm.asp"
        //-->
        </script>
        </head></html>
	<%
	exit;
	}   

if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{get}i)
	{
	$TransID = ${$Request->QueryString}{TransID}{item};

	if ($TransID)
		{    
		$RecordCount = $SubmissionTable->GetRecord("TransID='$TransID'",'');
		if ($RecordCount)	
			{
			$ActivityLog->AddEntry('viewed',${$SubmissionTable->FieldData}{ClientID}{value}[0],'submission',$TransID);
			if (!${$SubmissionTable->FieldData}{ReceivedTime}{value}[0])
				{
        			${$SubmissionTable->FieldData}{ReceivedBy}{value}[0]=${$Session->{Persona}}[2][3];
        			${$SubmissionTable->FieldData}{ReceivedTime}{value}[0]=time;
        			${$SubmissionTable->FieldData}{ReceivedTrans}{value}[0]=$ActivityLog->{TRANSID};
        			$SubmissionTable->UpdateRecord('',"TransID='$TransID'",'');
				}
                        $Session->{XMLFile} = $Server->CreateObject("MSXML.DOMDocument");
                        $Session->{XMLFile}->{async} = false;
                        $Session->{XMLFile}->loadXML($SubmissionTable->FieldData->{Data}->{value}->[0]);   
			$Session->{XMLFile}->setProperty("SelectionLanguage", "XPath");
                        $Session->{Form}=1;
			$Session->{FormViewer} = 'agent';
			$Session->{FormViewMode} = 'submission';

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
		location.href="/agent/cpmain.asp";
	//-->
	</script>
</head>
</html>