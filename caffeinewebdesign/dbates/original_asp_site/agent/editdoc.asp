<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"--> 
<!--#Include virtual="/component/ActivityTable.asp"--> 
<!--#Include virtual="/component/AssociateTable.asp"--> 
<%
$ID=${$Request->QueryString}{ID}{item}; 
if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{get}i)
	{
	$AssociateRecords = $AssociateTable->GetRecord('Active=1 AND DeptOutside=0','Name');
		$OptionString .= "\t\t\t\t<option value='role#dbmonitor'></option>\n";                    
	while ($index < $AssociateRecords)
		{
		$OptionString .= "\t\t\t\t<option value='id#${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";
		$index++;
		}
%>
        <html>
        <head>
        	<title>Edit Documents</title>
        	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
	<script language="javascript" src="/agent/document/resource/validation.js"></script>
        </head>                                                   
        <body> 
	<%
        if ($ID)
        	{ 
		$DocTable->GetRecord("ID='$ID'",'');
		$DocType = ${$DocTable->FieldData}{DocType}{value}[0];
		@Expiration = localtime(${$DocTable->FieldData}{Expiration}{value}[0]);
		%>
                <h1>Edit Document</h1><hr>
                <form action="EditDoc.asp" name="DBForm" method="post">
			<input type="hidden" name="ID" value="<%=$ID%>"> 
			<input type="hidden" name="Complete"/>
			<input type="hidden" name="IncludedFields"/>

                <%if (($DocType eq 'form') or ($DocType eq 'page'))
	                {
			if ($DocType eq 'page')
				{%><a href='<%=${$DocTable->FieldData}{Location}{value}[0]%>' target="_new">View Source</a><br><br><%}
			%>
                        <b>1. What type of document is it?</b>
                        	<ul>    
		                	<input type="radio" name="DocType" value="page" <%=($DocType eq 'page')?'checked':''%>> Existing site page
                			<input type="radio" name="DocType" value="form" <%=($DocType eq 'form')?'checked':''%>> Form
                        	</ul>
                        <b>2. Will this be a featured item? </b>
                        	<ul>
                	        	<input type="checkbox" name="Feature" value="1" <%=${$DocTable->FieldData}{Feature}{value}[0]?'checked':''%>>Featured
                        	</ul>      
                        <b>3. Which access level? </b>
                        	<ul>
                                	<input type="radio" name="Access" value="0" <%=${$DocTable->FieldData}{Access}{value}[0]?'':'checked'%> >Public access
                                	<input type="radio" name="Access" value="1" <%=${$DocTable->FieldData}{Access}{value}[0]?'checked':''%> >Clients only
                        	</ul> 
                        <b>4. Document information</b>
                	<table border="0">
                        	<tr>
                			<td>Title</td>
                			<td><input type="text" size="48" name="Title" value="<%=${$DocTable->FieldData}{Title}{value}[0]%>" required="1"></td>
                		</tr>
                        	<tr>
                			<td>Description</td>
                			<td><textarea rows="3" cols="48" name="Description" wrap="virtual" required="1"><%=${$DocTable->FieldData}{Description}{value}[0]%></textarea></td>
                		</tr>
                        	<tr>
                			<td>Profile keywords</td>
                			<td><input type="text" size="48" name="Profile" value="<%=${$DocTable->FieldData}{Profile}{value}[0]%>" required="1"></td>
                		</tr>
                        	<tr>
                			<td>Expiration Date</td>
                			<td>
                				<input type="text" size="2" name="Month" value="<%=$Expiration[4]+1%>">-
                				<input type="text" size="2" name="Day" value="<%=$Expiration[3]%>">-
                				<input type="text" size="4" name="Year" value="<%=$Expiration[5]+1900%>">
                			</td>
                		</tr>
                       	</table>
			<%}
		else
			{%>       
			<a href='/public/ViewDocument.asp?ID=<%=${$DocTable->FieldData}{ID}{value}[0]%>' target="_new">View Source</a><br><br>
                        <b>1. What type of document is it?</b>
                        	<ul>
                                	<input type="radio" name="DocType" value="article" <%=($DocType eq 'article')?'checked':''%>> Article
                                	<input type="radio" name="DocType" value="event" <%=($DocType eq 'event')?'checked':''%>> Event/Seminar
                                	<input type="radio" name="DocType" value="news" <%=($DocType eq 'news')?'checked':''%>> News
                        	</ul>
                        <b>2. Which access level? </b>
                        	<ul>
                                	<input type="radio" name="Access" value="0"  <%=${$DocTable->FieldData}{Access}{value}[0]?'':'checked'%> >Public access
                                	<input type="radio" name="Access" value="1" <%=${$DocTable->FieldData}{Access}{value}[0]?'checked':''%> >Clients only
                        	</ul>
                        <b>3. Will this be a featured item? </b>
                        	<ul>
                	        	<input type="checkbox" name="Feature" value="1"  <%=${$DocTable->FieldData}{Feature}{value}[0]?'checked':''%>>Featured
                        	</ul>      	

			<b>4. For seminars, will there be online registration?
                	<input type="radio" name="IsSeminar" value="1" <%=${$DocTable->FieldData}{Access}{value}[0]?'checked':''%>> Yes <input type="radio" name="IsSeminar" value="0" <%=${$DocTable->FieldData}{Access}{value}[0]?'':'checked'%>> No</p><br>
<%
$OptionString =~ s{(${$DocTable->FieldData}{RecipientName}{value}[0]')}{$1 selected}isg;
%>
			<p>Registrar: <select name="RecipientName" size="1"><%=$OptionString%></select></p>
			<p>Session Date/Times:</p> 
			<ul>    
<% 
(@SeminarSessions) = ${$DocTable->FieldData}{Sessions}{value}[0] =~ m{(\d+)}g;
for ($index = 1; $index <= 5; $index++)
	{
	if ($SeminarSessions[$index-1]>time)
		{
		@Session = localtime($SeminarSessions[$index-1]);
		if ($Session[2] > 12)
			{ 
			$Session[0] = 1;
			$Session[2] -= 12;
			}
		if (length($Session[1])<2) {$Session[1] = '0'.$Session[1];}
		$Session[4] += 1;
		$Session[5] += 1900;
		}
	else
		{undef @Session;}
	%>
                                
                                <li>
        				<B>Date</b> <input type="text" size="2" name="SessionMonth<%=$index%>" value="<%=$Session[4]%>">-
        				<input type="text" size="2" name="SessionDay<%=$index%>" value="<%=$Session[3]%>">-
        				<input type="text" size="4" name="SessionYear<%=$index%>" value="<%=$Session[5]%>">
        
        				<b>Time</b> <input type="text" size="2" name="SessionHour<%=$index%>" value="<%=$Session[2]%>">:
        				<input type="text" size="2" name="SessionMinute<%=$index%>" value="<%=$Session[1]%>">: 
        				<select size="1" name="SessionAmPm<%=$index%>">
                                                <option value="0"  <%=$Session[0]?'':'selected'%> >am</option>
                                                <option value="1" <%=$Session[0]?'selected':''%> >pm</option>
                                        </select> 
                                </li>
	<%}%>
			</ul>
	<br>                                 
                           
                        <b>5. Document information</b>
                	<table border="0">
                        	<tr>
                			<td>Title</td>
                			<td><input type="text" size="48" name="Title" value="<%=${$DocTable->FieldData}{Title}{value}[0]%>"  required="1"></td>
                		</tr>
                        	<tr>
                			<td>Description</td>
                			<td><textarea rows="3" cols="48" name="Description" wrap="virtual" required="1"><%=${$DocTable->FieldData}{Description}{value}[0]%></textarea></td>
                		</tr>
                        	<tr>
                			<td>Profile keywords</td>
                			<td><input type="text" size="48" name="Profile" value="<%=${$DocTable->FieldData}{Profile}{value}[0]%>"  required="1"></td>
                		</tr>
                        	<tr>
                			<td>Search keywords (Meta tags)</td>
                			<td><input type="text" size="48" name="MetaTags" value="<%=${$DocTable->FieldData}{MetaTags}{value}[0]%>" ></td>
                		</tr>
                        	<tr>
                			<td>Copyright Source</td>
                			<td><input type="text" size="48" name="Publisher" value="<%=${$DocTable->FieldData}{Publisher}{value}[0]%>" ></td>
                		</tr>
                        	<tr>
                			<td>Author</td>
                			<td><input type="text" size="48" name="Author" value="<%=${$DocTable->FieldData}{Author}{value}[0]%>" ></td>
                		</tr>
                        	<tr>
                			<td>Expiration Date</td>
                			<td>
                				<input type="text" size="2" name="Month" value="<%=$Expiration[4]+1%>">-
                				<input type="text" size="2" name="Day" value="<%=$Expiration[3]%>">-
                				<input type="text" size="4" name="Year" value="<%=$Expiration[5]+1900%>">
                			</td>
                		</tr>
                       	</table>
			<%}%>
                <hr>          
                <center>
                	<input type="button" value="Change Document" onClick="FormValidation(1)">
                	<input type="button" value="Cancel" onClick="location.href='cpmain.asp'">
                </center>
	        </form>          
        
        	<%}
        else
        	{%>
                <h2 style="margin-left:5pt;">Edit Document Databases</h2>
                <hr>
                <p><b>Articles</b></p>           
                	<ul>
                	<%$DocTable->DocListEdit('article');%>
                	</ul><br>
                <p><b><em>D&B Focus</em> Pages</b></p>           
                	<ul>
                	<%$DocTable->DocListEdit('page');%>
                	</ul><br>
                <p><b>Events & Seminars</b></p>           
                	<ul>
                	<%$DocTable->DocListEdit('event');%>
                	</ul><br>
                <p><b>Forms</b></p>           
                	<ul>
                	<%$DocTable->DocListEdit('form');%>
                	</ul><br>
                <p><b>News</b></p>           
                	<ul>
                	<%$DocTable->DocListEdit('news');%>
                	</ul><br>
        	<%}%>
        </body>
        </html>
	<%}
elsif (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{post}i)
	{                
	$ID = ${$Request->Form}{ID}{item}; 
	$DocTable->GetRecord("ID='$ID'",'');
        $DocTable->LoadFormData;  

	if (${$Request->Form}{'IsSeminar'}{item})
	{
	${$DocTable->FieldData}{Sessions}{value}[0] = '';
	for ($index = 1; $index <= 5; $index++)
		{
		$ThisYear = ${$Request->Form}{"SessionYear".$index}{item};
		$ThisMonth = -1+${$Request->Form}{"SessionMonth".$index}{item};
		$ThisDay = ${$Request->Form}{"SessionDay".$index}{item};
		$ThisAmPm = ${$Request->Form}{"SessionAmPm".$index}{item}?'12':'0';
		$ThisHour = $ThisAmPm + ${$Request->Form}{"SessionHour".$index}{item};
		$ThisMinute = ${$Request->Form}{"SessionMinute".$index}{item}; 
		$ThisTime = $main::ScriptingNamespace->ParameterDate($ThisYear,$ThisMonth,$ThisDay,$ThisHour,$ThisMinute);
		if ($ThisTime > time)
			{${$DocTable->FieldData}{Sessions}{value}[0].= $ThisTime.',';}
		}
	}

	${$DocTable->FieldData}{Expiration}{value}[0] = $main::ScriptingNamespace->ParameterDate(${$Request->Form}{Year}{item},-1+${$Request->Form}{Month}{item},${$Request->Form}{Day}{item},0,0);
        if (${$DocTable->FieldData}{Expiration}{value}[0] < 0) {${$DocTable->FieldData}{Expiration}{value}[0] = 1100000000;}

	$DocType = ${$DocTable->FieldData}{DocType}{value}[0];
	if (($DocType eq 'form') or ($DocType eq 'page'))
		{
                if (${$DocTable->FieldData}{Location}{value}[0] =~ m{d\w*?bates\.com(/.*)}i)
                	{${$DocTable->FieldData}{Location}{value}[0] = $1;} 
                if (-e $Server->MapPath('/').${$DocTable->FieldData}{Location}{value}[0])
                	{
                        if ($DocTable->UpdateRecord('',"ID='$ID'",''))  
                        	{push @Alert, $ActivityLog->AddEntry('changed',${$DocTable->FieldData}{Title}{value}[0],'in','DocTable');}
                        else 
                        	{push @Alert, 'Error updating database';}
                	}
                else
                	{push @Alert, 'Referenced document ('.$Server->MapPath('/').${$DocTable->FieldData}{Location}{value}[0].') does not exist.  Double check address and try again';}
        
       		}
	else
		{
		if ($DocTable->UpdateRecord('',"ID='$ID'",''))
			{push @Alert, $ActivityLog->AddEntry('changed',${$DocTable->FieldData}{Title}{value}[0],'in','DocTable');}
		else 
                       	{push @Alert, 'Error updating database';}
		}
%>			
<html><head>
<script language="javascript">
<!--
<% for (@Alert) {%>alert("<%=$_%>");<%}%>
location.href="cpmain.asp";
//-->
</script>
</head></html>
<%
}      
%>