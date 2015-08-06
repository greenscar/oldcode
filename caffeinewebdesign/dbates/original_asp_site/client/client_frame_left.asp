<%
$DocRoot = $Server->MapPath('/');                   
$Content = $DocRoot.'/data/content.xml';
if (-e $Content)
	{
	if (${$Session->{Persona}}[1][1] eq 'SELECT') {$Response->Redirect('select.asp');}
	$DB = Win32::OLE->new('Msxml2.DOMDocument.4.0');
	$DB->load($Content);                                       
	$ClientID = ${$Session->{Persona}}[1][1];   
	$ClientName = ${$Session->{Persona}}[1][3];   
	
	$Logo =  $DB->selectSingleNode("/content/clients/client[\@id='$ClientID']/body/logo")->getAttribute('source');
	$ExistingClient = $ClientTable->GetRecord("ID='$ClientID'",''); 
	}
%>

<html>
<head>
	<link REL="stylesheet" TYPE="text/css" HREF="document/resource/client.css">    
</head>
<body topmargin="0" leftmargin="0">
	<table width="760" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td width="124" bgcolor="#004C7A" valign="top" align="center" style="padding-top: 15px;">
				<a href="/client"><img src="<%=$Logo%>" border="0"/></a>
				<%
                        	$Lines = $DB->selectNodes("/content/clients/client[\@id='$ClientID']/coverage/line");
				if ($Lines->{length}>0)
					{
					%>
					<img src="resource/coverage.gif" width="103" height="23" style="margin-top: 15px;"/><br/>
					<%
                                       	for ($LineIndex = 0; $LineIndex < $Lines->{length} ; $LineIndex++)
                                        		{
                                        		$Line = $Lines->item($LineIndex);
                        				$Response->write("<a target='_new' class='toc' href='coverage.aspx?id=".$Line->getAttribute('source')."'>> ".$Line->getAttribute('title')."</a> ".$Line->getAttribute('description')."<br/>");
                                        		}
	        	                %>                
					<br/>
					<%
					}
				%>
				<a href="/" target="_top"><img src="resource/dbhome.gif"  width="89" height="17"  border="0" style="margin-top: 5px;"/></a>
				<br/>
				<a href="accountsettings.asp" target="_top"><img src="resource/settings.gif"  width="89" height="17"  border="0" style="margin-top: 2px; margin-bottom: 20px;"/></a>
			</td>
			<td width="16" background="resource/divider.gif">&nbsp;</td>
			<td width="460" style="padding-top: 15px;" valign="top">
