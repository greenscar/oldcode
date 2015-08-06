<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('client','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/ClientTable.asp"-->                
<%
$DocRoot = $Server->MapPath('/');                   
$Content = $DocRoot.'/data/content.xml';
if (-e $Content)
	{
	$DB = Win32::OLE->new('Msxml2.DOMDocument.4.0');
	$DB->load($Content);                                       
	$ClientID = 'SELECT';   
	}
%><html>
<head>
	<link REL="stylesheet" TYPE="text/css" HREF="document/resource/client.css">    
</head>
<body topmargin="0" leftmargin="0">
	<table width="660" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td width="160" bgcolor="#004C7A" valign="top" align="center" style="padding-top: 15px;">
				<a href="SelectAccounts/Select Accounts Expertise.pdf"><img src="SelectAccounts/logo.gif" border="0"/></a>
				<br/><br/><img src="resource/specialties.gif"/>
					<p class='toc'><a class='toc' href='SelectAccounts/Select Accounts Expertise.pdf'>> Introduction</a><br/></p>
					<p class='toc'><a class='toc' href='SelectAccounts/mfg.pdf'>> Manufacturers</a><br/></p>
					<p class='toc'><a class='toc' href='SelectAccounts/tech.pdf'>> Technology Industry</a><br/></p>

				<br/><img src="resource/serviceteam.gif" width="103" height="23"/>
       	                	<%                                              
				%Teams = ('executive'=>'ACCOUNT LEADERS','service'=>'','extended'=>'ADDITIONAL SERVICE RESOURCES');
				for $SubTeam ('executive','service','extended','test')
					{
	                               	$Team = $DB->selectSingleNode("/content/clients/client[\@id='$ClientID']/team[$SubTeam]");
					if ($Team)
						{                                                                                     
						%><br/><p class="toc"><%=$Teams{$SubTeam}%></p><%
		                               	$Members = $DB->selectNodes("/content/clients/client[\@id='$ClientID']/team/$SubTeam/member");
                                               	for ($MemberIndex = 0; $MemberIndex < $Members->{length}; $MemberIndex++)
                                                		{
                                                		$Member = $Members->item($MemberIndex);
                                				$Response->write("<p class='toc'><a class='toc' href='mailto:".$Member->getAttribute('email')."'>> ".$Member->getAttribute('name')."</a><br/><i>".$Member->getAttribute('title')."</i><br/>".$Member->getAttribute('phone')."</p>");
                                                		}
						}
					}
               	                %>                                                                     
				<br/><img src="resource/leftlinks.gif" width="102" height="21"/>
				<a href="http://www.glossarist.com/glossaries/economy-finance/insurance.asp"><p class='toc'>> Glossary of<br/>Insurance Terms</p></a><br/>
				<a href="/" target="_top"><img src="resource/dbhome.gif"  width="89" height="17"  border="0" style="margin-top: 5px;margin-bottom: 10px;"/></a>
				<br/>
			</td>
			<td width="16" background="resource/divider.gif">&nbsp;</td>
			<td width="484" style="padding-top: 15px;" valign="top">
                        	<img src="resource/title.gif" width="394" height="51"/><br/><br/>
                		<h3><p>> Resources and information for our Select Accounts clients:</p></h3><br/>
				<%
                        	$Forms = $DB->selectNodes("//form[ancestor::global or ancestor::client[\@id='$ClientID']]");
				if ($Forms->{length}>0)
					{%><p><img src="resource/forms.gif" width="157" height="11"/></p><br/><%}
                        	$Forms = $DB->selectNodes("//form[(ancestor::global or ancestor::client[\@id='$ClientID']) and not(\@class='print')]");
				if ($Forms->{length}>0)
					{
					%>
					<p>
						<b><small>ONLINE FORMS:</small></b><br/>
					<%
                                       	for ($FormIndex = 0; $FormIndex < $Forms->{length}; $FormIndex++)
                                        		{
                                        		$Form = $Forms->item($FormIndex);
                        				$Response->write("<li class='feature'><p>&nbsp;<a href='".$Form->getAttribute('source')."'>".$Form->getAttribute('title')."</a> ".$Form->getAttribute('description')."</p></li>");
                                        		}
                	                %></p><%
					}
                        	$Forms = $DB->selectNodes("//form[(ancestor::global or ancestor::client[\@id='$ClientID']) and \@class='print']");
				if ($Forms->{length}>0)
					{
					%>
					<br/>
					<p>
						<b><small>PRINTABLE FORMS:</small></b><br/>
					<%
                                       	for ($FormIndex = 0; $FormIndex < $Forms->{length} ; $FormIndex++)
                                        		{
                                        		$Form = $Forms->item($FormIndex);
                        				$Response->write("<li class='feature'><p>&nbsp;<a href='loadprintform.asp?id=".$Form->getAttribute('source')."' target='_new'>".$Form->getAttribute('title')."</a> ".$Form->getAttribute('description')."</p></li>");
                                        		}
                	                %></p><%
					}
				%>
				<br/>               
			</td>
		</tr>
	</table>
</body>
</html>