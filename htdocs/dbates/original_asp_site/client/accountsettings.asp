<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('client','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/ClientTable.asp"-->                
<!--#Include virtual="/component/DocTable.asp"-->                     
<%
$DocRoot = $Server->MapPath('/');                   
$Content = $DocRoot.'/data/content.xml';
$DB = Win32::OLE->new('Msxml2.DOMDocument.4.0');
$DB->load($Content);                                       
$ClientID = ${$Session->{Persona}}[1][1];   
$ClientName = ${$Session->{Persona}}[1][3];   
$Logo =  $DB->selectSingleNode("/content/clients/client[\@id='$ClientID']/body/logo")->getAttribute('source');
$ExistingClient = $ClientTable->GetRecord("ID='$ClientID'",''); 

if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{get}i)        
	{%>
<html>
<head>
	<link REL="stylesheet" TYPE="text/css" HREF="document/resource/client.css">    
	<script language="javascript">
		<!-- 	
		function MatchPW(FormObj)
			{if ( FormObj.NEWPW1.value != FormObj.NEWPW2.value) 
				{window.alert("You have entered your new password differently in each box.  Please try again.");}
			else
				{document.Settings.submit();}
			}
		//-->  
	</script>
</head>
<body topmargin="0" leftmargin="0">
	<table width="760" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td width="124" bgcolor="#004C7A" valign="top" align="center" style="padding-top: 15px;">
				<img src="<%=$Logo%>"/>
				<img src="resource/coverage.gif" width="103" height="23" style="margin-top: 15px;"/><br/>
	                	<%                                              
                        	$Lines = $DB->selectNodes("/content/clients/client[\@id='$ClientID']/coverage/line");
                               	for ($LineIndex = 0; $LineIndex < $Lines->{length} ; $LineIndex++)
                                		{
                                		$Line = $Lines->item($LineIndex);
                				$Response->write("<a target='_new' class='toc' href='coverage.aspx?id=".$Line->getAttribute('source')."'>> ".$Line->getAttribute('title')."</a> ".$Line->getAttribute('description')."<br/>");
                                		}
        	                %>                
				<br/>
				<a href="/" target="_top"><img src="resource/dbhome.gif"  width="89" height="17"  border="0" style="margin-top: 5px;"/></a>
				<br/>
				<a href="accountsettings.asp" target="_top"><img src="resource/settings.gif"  width="89" height="17"  border="0" style="margin-top: 2px; margin-bottom: 20px;"/></a>

			</td>
			<td width="16" background="resource/divider.gif">&nbsp;</td>
			<td width="460" valign="top">
                                <img src="/resource/t_settings.jpg" border="0">
                                <%
                                if ($Session->{Hits} < -1) 
                                	{%>
                                        <h3 style="margin:10pt;">Welcome to the online services of Durham and Bates.</h3>
                                        <p>Before you begin you might want to take this opportunity to change your password.
                                        If you like, your password may also be stored on your computer.  This will 
                                        allow you to log on automatically.  Please be aware, though, that if
                                         you choose to save your password anyone else who uses your computer
                                         will also be able to log on using your account.</p>
                                        
                                        <p>Finally, if you don't wish to change any settings now, just click
                                         on the "Skip this step" button at the bottom of the screen.At 
                                        any time in the future just visit "Account Settings" area of the 
                                        "Forms and Applications" page to come back to this screen.</p>
                                	<%}
                                %>
                                <form name="Settings" action="AccountSettings.asp" method="post">
                                <table>
                                <tr>
                                	<td bgcolor="#004C7A" colspan="2" align="left"><p style="color: white"><b>Change Password?</b></p></td></tr>
                                	<tr><td><p>Old Password</p></td><td><input type="password" size="10" name="OLDPW"></td></tr>
                                	<tr><td><p>New Password</p></td><td><input type="password" size="10" name="NEWPW1"></td></tr>
                                	<tr><td><p>New Password<br><small>(2nd time)</small></p></td><td><input type="password" size="10" name="NEWPW2"></td></tr>
                                	<tr><td colspan="2"><p bgcolor="#004C7A" style="color: white;"><b>Saved Password</b></p></td></tr>
				<!--
                                	<tr>
                                		<td align="center">
                                <%
                                if ($Request->Cookies('clientDurhamAndBates')->{HasKeys})
                                	{
                                	%>
                                			<input type="checkbox" value="on" name="delcookie">
                                		</td>
                                		<td>Delete saved password on your computer. Change to manual login?
                                	<%
                                	}
                                else
                                	{
                                	%>
                                			<input type="checkbox" value="on" name="cookie">
                                		</td>
                                		<td>Save password on your computer for automatic login?
                                	<%
                                	}
                                %>
                                		</td>
                                	</tr>
				-->
                                <tr align="left"><td bgcolor="#004C7A" colspan="2"><p style="color: white;"><b>You may enter default user information which will automatically be included when you complete forms on this site.</b></p></td></tr>
                                	<tr>
                                		<td><p>Contact Name</p></td>
                                		<td><input type="text" name="ContactName"value="<%=${$ClientTable->FieldData}{'ContactName'}{value}[0]%>"size="30"></td></tr>
                                
                                	<tr>
                                		<td><p>Contact Phone</p></td>
                                		<td><input type="text" name="ContactPhone"value="<%=${$ClientTable->FieldData}{'ContactPhone'}{value}[0]%>"size="21"></td></tr>
                                
                                	<tr>
                                		<td><p>Contact E-mail</p></td>
                                		<td><input type="text" name="ContactEmail" value="<%=${$ClientTable->FieldData}{'ContactEmail'}{value}[0]%>" size="30"></td></tr>
                                        
                                <tr bgcolor="#D0D0D0"><td colspan="2" align="center"><hr><input type="button" value="Submit Form" onClick="MatchPW(this.form)"><br>
                                
                                <%
                                if ($Session->{Hits} == 1) 
                                	{%>
                                	<input type="button" value="Skip this step" onClick="location.href='<%=$Session->{'RedirectTarget'}%>'"></td></tr>
                                	<%}
                                else
                                	{%>
                                	<input type="button" value="Cancel" onClick="location.href='<%=$Session->{'RedirectTarget'}%>'"></td></tr>
                                	<%}
                                %>
                                </table>
                                </form>

                        	<br/>                                
				<br/>               
			</td>
			<td width="16" background="resource/divider.gif">&nbsp;</td>
			<td width="144" bgcolor="#004C7A" valign="top" align="center" style="padding-top: 15px;">
				<img src="resource/serviceteam.gif" width="103" height="23"/>
       	                	<%                                              
				%Teams = ('executive'=>'ACCOUNT LEADERS','service'=>'ACCOUNT SERVICE','extended'=>'ADDITIONAL SERVICE RESOURCES');
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
			</td>

		</tr>
	</table>
</body>
</html>
	<%}

if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{post}i)        
	{
	$ClientID = ${$Session->{Persona}}[1][1];
	$OldPW=uc(${$Request->Form}{OLDPW}{item});  
	$NewPW=uc(${$Request->Form}{NEWPW1}{item});
	$NewPW=~s{\s}{}sg;
	$ClientTable->GetRecord("ID='$ClientID'",'');

        #reset p/w if neccessary
        if (length($NewPW)>0)
        	{
		$FlagNewPW=1;
        	$CryptExistingPW=${$ClientTable->FieldData}{CryptPW}{value}[0];
        	$CryptOldPW=crypt($OldPW,$CryptExistingPW);
        	if ($CryptExistingPW ne $CryptOldPW)
        		{push @Alert, "The old password you provided was incorrect.  Keeping old password.";}
        	else                                                              
        		{
#			$XPW=crypt($NewPW, join("", (0..9, 'A'..'Z', 'a'..'z')[rand 62, rand 62]));
			${$ClientTable->FieldData}{CryptPW}{value}[0] = crypt($NewPW, 'db');
			}
        	}
        #update contact info
        ${$ClientTable->FieldData}{'ContactName'}{value}[0]=${$Request->Form}{ContactName}{item};
        ${$ClientTable->FieldData}{'ContactPhone'}{value}[0]=${$Request->Form}{ContactPhone}{item};
        ${$ClientTable->FieldData}{'ContactEmail'}{value}[0]=${$Request->Form}{ContactEmail}{item};
        ${$ClientTable->FieldData}{Hits}{value}[0]++;
        $Session->{Hits}++;
        $ClientTable->UpdateRecord('',"ID='$ClientID'",'');
        
        #set cookie login if desired
	if ($Request->Cookies('clientDurhamAndBates')->{HasKeys}) {$FlagCookie=1;}
	$CurrentCryptPW = ${$ClientTable->FieldData}{CryptPW}{value}[0];
        if ((${$Request->Form}{cookie}{item}=~ m/on/i) || ( $FlagCookie&&$FlagNewPW ) )
        	{
        	$Response->Cookies->SetProperty('Item', 'clientDurhamAndBates', "client"); 
        	$Response->Cookies('clientDurhamAndBates')->{Expires} = "December 31, 2010";      
        	if ($Session->{Locale})
        		{$Response->Cookies('clientDurhamAndBates')->{Secure} = 1;}
        	$Response->Cookies('clientDurhamAndBates')->SetProperty('Item', 'ID', $ClientID); 
        	$Response->Cookies('clientDurhamAndBates')->SetProperty('Item', 'PW', $CurrentCryptPW);
        	}
                                                              
        #delete cookie login
        if (${$Request->Form}{delcookie}{item}=~ m/on/i)
        	{
        	$Response->Cookies->SetProperty('Item', 'clientDurhamAndBates', "client"); 
        	$Response->Cookies('clientDurhamAndBates')->{Expires} = "May 18, 1980";      
        	}
        push @Alert, "Your account settings have been updated";
        $Session->{'RedirectTarget'} = '/client';
        %>			
        <html><head>
        <script language="javascript">
        <!--
        <% for (@Alert) {%>alert('<%=$_%>');<%}%>
        location.href="<%=$Session->{'RedirectTarget'}%>";
        //-->
        </script>
        </head></html>
        <%
        }%>
