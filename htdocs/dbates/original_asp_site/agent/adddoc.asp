<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<% &CheckAccount('agent','1'); %>
<!--#Include virtual="/component/SQLTable.asp"-->  
<!--#Include virtual="/component/AssociateTable.asp"-->                
<%
if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m/get/i)
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
	<link rel="stylesheet" type="text/css" href="/agent/document/resource/agent.css">
	<title>Upload New Document</title>
</head>
<body> 
<a name="top"></a>     
<h1>Add New Document</h1>
<form action="AddDoc.asp" name="DBForm" method="post" enctype="multipart/form-data">
        <b>1. Create File.</b>  Create your document in Microsoft Word.  Then go to FILE and SAVE AS.  At the bottom of the "SAVE AS" dialog box, choose "HTML document" from the list of "Save as File Type" entries.  Name and save your file.<br><br>
        <b>2. Select HTML document to post</b>.  Use the BROWSE button to locate the file you saved in step 1.
        	<ul><input type="file" name="Location" required="1"></ul>
        <b>3. What type of document is it?</b>
        	<ul>
                	<input type="radio" name="DocType" value="article" checked> Article
                	<input type="radio" name="DocType" value="event"> Event/Seminar
                	<input type="radio" name="DocType" value="news"> News
        	</ul>
        <b>4. Which access level? </b>
        	<ul>
                	<input type="radio" name="Access" value="0" checked>Public access
                	<input type="radio" name="Access" value="1">Clients only
        	</ul>
        <b>5. Will this be a featured item? </b>
        	<ul>
	        	<input type="checkbox" name="Feature" value="1">Featured
        	</ul>
	<b>6. For seminars, will there be online registration?
                	<input type="radio" name="IsSeminar" value="1"> Yes <input type="radio" name="IsSeminar" value="0" checked> No</p><br>
			<p>Registrar: <select name="RecipientName" size="1"><%=$OptionString%></select></p>
			<p>Session Date/Times:</p> 
			<ul>    
<% for ($index = 1; $index <= 5; $index++)
	{%>
                                
                                <li>
        				<B>Date</b> <input type="text" size="2" name="SessionMonth<%=$index%>">-
        				<input type="text" size="2" name="SessionDay<%=$index%>">-
        				<input type="text" size="4" name="SessionYear<%=$index%>" onFocus="javascript:Time=new Date();this.value=Time.getYear();">
        
        				<b>Time</b> <input type="text" size="2" name="SessionHour<%=$index%>">:                                                                                                      
        				<input type="text" size="2" name="SessionMinute<%=$index%>">: 
        				<select size="1" name="SessionAmPm<%=$index%>">
                                                <option value="0">am</option>
                                                <option value="1">pm</option>
                                        </select> 
                                </li>
	<%}%>
			</ul>
	<br>                                 
        <b>7. Document information</b>
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
			<td>Search keywords (Meta tags)</td>
			<td><input type="text" size="30" name="MetaTags"></td>
		</tr>
        	<tr>
			<td>Copyright Source</td>
			<td><input type="text" size="30" name="Publisher" value="Durham and Bates"></td>
		</tr>
        	<tr>
			<td>Author</td>
			<td><input type="text" size="30" name="Author"></td>
		</tr>
        	<tr>
			<td>Expiration Date</td>
			<td>
				<input type="text" size="2" name="Month" onFocus="javascript:Time=new Date();this.value=1+Time.getMonth();">-
				<input type="text" size="2" name="Day" onFocus="javascript:Time=new Date();this.value=Time.getDate();">-
				<input type="text" size="4" name="Year" onFocus="javascript:Time=new Date();this.value=1+Time.getYear();">
			</td>
		</tr>
       	</table>
<hr>          
<center>
	<input type="submit" value="Send Document">
	<input type="button" value="Cancel" onClick="location.href='cpmain.asp'">
</center>
</form>          

<hr> 
<a name="help"></a>
<h2>About the "Add New Document" page</h2>
<table border="0" cellpadding="4px">
<tr bgcolor="#DDDDFF"><td colspan="2"><b>Fields</b></td></tr>
<tr valign="top" width="200px"><td align="right"><b>Featured</b></td>
	<td>Featured items are displayed with a special bullet and placed at the top of the list of documents.</td></tr>
<tr valign="top" width="200px"><td align="right"><b>Document Title, Description</b></td>
	<td>These are the title/description of the document as the client will see them listed in the Articles, Events and News pages.</td></tr>
<tr valign="top" width="200px"><td align="right"><b>Profile Keywords</b></td>
	<td>These codes are matched against the keywords in the 
	client's profile.  If a code appears in both the document's profile 
	and the client's profile it will be displayed on the various 
	document pages.</td></tr>    
<tr valign="top" width="200px"><td align="right"><b>Search Keywords</b></td>
	<td>These are the keywords which search engines will use to find particular documents.</td></tr>
<tr valign="top" width="200px"><td align="right"><b>Author</b></td>
	<td>The author field ends up being buried in the HTML code of the document.  I'm not sure what else we would use it for.</td></tr>
<tr valign="top" width="200px"><td align="right"><b>Expires</b></td>
	<td>Mostly used in event and news documents.  The document will automatically be removed to the trash area once it expires.</td></tr>
</table>

</body></html>
<%
}

elsif ($Request->ServerVariables('REQUEST_METHOD')->item =~ m{post}i)
{
%>                 
<!--#Include virtual="/component/MailTable.asp"-->                
<!--#Include virtual="/component/ActivityTable.asp"-->                
<!--#Include virtual="/component/DocTable.asp"-->                     
<%
#Load form data into DocTable, bring file into memory
if ($DocTable->OpenUpload)                     
	{         
        $DocID = $DocTable->DocID;         
        $DocTable->LoadUploadData;                                                                                          

	for ($index = 1; $index <= 5; $index++)
		{
		$ThisYear = ${$DocTable->Upload->Form}{"SessionYear".$index}{value};
		$ThisMonth = -1+${$DocTable->Upload->Form}{"SessionMonth".$index}{value};
		$ThisDay = ${$DocTable->Upload->Form}{"SessionDay".$index}{value};
		$ThisAmPm = ${$DocTable->Upload->Form}{"SessionAmPm".$index}{value}?'12':'0';
		$ThisHour = $ThisAmPm + ${$DocTable->Upload->Form}{"SessionHour".$index}{value};
		$ThisMinute = ${$DocTable->Upload->Form}{"SessionMinute".$index}{value}; 
		$ThisTime = $main::ScriptingNamespace->ParameterDate($ThisYear,$ThisMonth,$ThisDay,$ThisHour,$ThisMinute);
		if ($ThisTime > time)
			{${$DocTable->FieldData}{Sessions}{value}[0].= $ThisTime.',';}
		}
	${$DocTable->FieldData}{Expiration}{value}[0] = $main::ScriptingNamespace->ParameterDate(${$DocTable->Upload->Form}{Year}{value},-1+${$DocTable->Upload->Form}{Month}{value},${$DocTable->Upload->Form}{Day}{value});
	if (${$DocTable->FieldData}{Expiration}{value}[0] < time) {${$DocTable->FieldData}{Expiration}{value}[0] = 1100000000;}

        $UploadDoc = $DocTable->Upload->Files->{'Location'}->Binary;
        $DocTable->CloseUpload;   
                    
        #Safety first, then extract body or frameset
        $UploadDoc =~ s{\x3c%.*?%\x3e}{}isg;
        $UploadDoc =~ s{<script.*?>.*?</script.*?>}{}isg; 
        
        ($DocBody) = $UploadDoc =~ m{<body.*?>(.*?)</body}is;
	$DocBody = '<body>'.$DocBody.'</body>';
        ($DocFrameSet) = $UploadDoc =~ m{(<frameset.*?</frameset>)}is; 
        if ($DocFrameSet) {undef $DocBody;}
        undef $UploadDoc; 

	#Get template and sub in values                        
        @FileInfo=stat($Server->MapPath('/').'/data/template/document.tem');
        open (DocTemplate, '<'.$Server->MapPath('/').'/data/template/document.tem');
        read (DocTemplate, $NewDocument, $FileInfo[7]);
        close(DocTemplate);
         
	$Title = ${$DocTable->FieldData}{Title}{value}[0];
        $NewDocument =~ s{~Title~}{$Title}isg;
        $NewDocument =~ s{~Description~}{${$DocTable->FieldData}{Description}{value}[0]}isg;
        $NewDocument =~ s{~MetaTags~}{${$DocTable->FieldData}{MetaTags}{value}[0]}isg;
        $NewDocument =~ s{~Author~}{${$DocTable->FieldData}{Author}{value}[0]}isg;
        $NewDocument =~ s{~Publisher~}{${$DocTable->FieldData}{Publisher}{value}[0]}isg;
        $NewDocument =~ s{~DocBody~}{$DocBody}is; 
        $NewDocument =~ s{~DocFrameSet~}{$DocFrameSet}isg;
	
	if ($DocTable->AddRecord)
		{
                open (DOCUMENT, '>'.$Server->MapPath('/')."/data/$DocID.doc");
                print DOCUMENT $NewDocument;
                close (DOCUMENT);

                push @Alert, $ActivityLog->AddEntry('added',$Title,'to','DocTable');
                #send me a copy to proofread
                $AssociateTable->GetRecord("ID='${$Session->{Persona}}[2][1]'",'');
                ${$MailTable->FieldData}{FromName}{value}[0] = ${$AssociateTable->FieldData}{Name}{value}[0];
                ${$MailTable->FieldData}{FromAddress}{value}[0] = ${$AssociateTable->FieldData}{Email}{value}[0];
                ${$MailTable->FieldData}{Subject}{value}[0] = "New Document Upload";
                ${$MailTable->FieldData}{BodyText}{value}[0] = $NewDocument;
                undef $NewDocument;
                undef $index;
                $WebmasterRecords = $AssociateTable->GetRecord(qq{Role LIKE '%webmaster%'},'');	
                while ($index < $WebmasterRecords)
                	{
                $MailTable->AddRecipient(${$AssociateTable->FieldData}{Name}{value}[0],${$AssociateTable->FieldData}{Email}{value}[0]);
                	$index++;
                }
                if(! $MailTable->SendMail)
			{push @Alert, 'Error sending mail';}
		}
	else 
		{push @Alert, 'Error updating database';}
   
	}
else 
	{push @Alert, 'Error uploading document';}
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
