<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%                  
$Access = $Session->{XMLFile}->selectSingleNode('//DocTable/Access')->{text}?'client':'public';
&CheckAccount($Access,'1');     
%>
<!--#Include virtual="/component/SQLTable.asp"--> 
<!--#Include virtual="/component/SubmissionTable.asp"-->              
<!--#Include virtual="/component/MailTable.asp"-->     
<!--#Include virtual="/component/AssociateTable.asp"-->     
<!--#Include virtual="/component/ClientTable.asp"-->  
<!--#Include virtual="/component/ActivityTable.asp"-->                
<%       
$SubmissionNode = $Session->{XMLFile}->selectSingleNode('//SubmissionTable');
if ($SubmissionNode) # already come out of the form, update with new time/data (not transid)
        {
        $TransID = $SubmissionNode->selectSingleNode('//TransID')->{text};
        $UpdateSuccess = $SubmissionTable->UpdateEntry($TransID);
        }           
else #first time coming out of form, add data to table and to XML submission variable
       	{
	$SubmissionTable->AddEntry;     
	$SubmissionNode = $Session->{XMLFile}->selectSingleNode('//SubmissionTable');
	$TransID = $SubmissionNode->selectSingleNode('//TransID')->{text};
        $DocRoot = $Server->MapPath('/');                   
	$FormFolder = "$DocRoot\\_private\\client\\forms\\$TransID";
	$FolderSuccess = mkdir($FormFolder);
	$Session->{FormProcess} = 0;
	$Session->{FormTask} = 0;
	}

if (length($Request->QueryString('step')->item)>0)
	{
	$Session->{FormProcess} = $Request->QueryString('step')->item;
	$Gstep = $Request->QueryString('step')->item;
	}
if (length($Request->QueryString('task')->item)>0)
	{
	$Session->{FormTask} = $Request->QueryString('task')->item;
	$Gtask = $Request->QueryString('task')->item;
	}
if (length($Request->Form('step')->item))
	{
	$Session->{FormProcess} = $Request->Form('step')->item;
	$Pstep = $Request->Form('step')->item;
	}
if (length($Request->Form('task')->item))
	{
	$Session->{FormTask} = $Request->Form('task')->item;
	$Ptask = $Request->Form('task')->item;
	}
#processing cases here, increment formprocess on successful complete
if ($Session->{FormProcess} == 2) # submission page
	{
        if ($Session->{FormTask} == 1) #store data, generate content for e-mail and send
        	{      
		&SendSubmission;
        	$Session->{FormProcess} = 3;
        	$Session->{FormTask} = 0;
        	}
	}

if ($Session->{FormProcess} == 1) # notes page
	{
        if ($Session->{FormTask} == 1) #add notes to submission table
        	{                        
		if(!$SubmissionNode->selectSingleNode('notes'))
			{
			$Notes = $Session->{XMLFile}->createElement('notes');
			$SubmissionNode->appendChild($Notes);
			}
		else
			{$Notes = $SubmissionNode->selectSingleNode('notes');}
		$NotesText = $Request->Form('notes')->item;
		$Notes->{text} = qq{<![CDATA[$NotesText]]>};
        	$Session->{FormProcess} = 2;
        	$Session->{FormTask} = 0;
        	}
	}

if ($Session->{FormProcess} == 0) # attachments page
	{
        $DocRoot = $Server->MapPath('/');                   
	$UploadInfo = $Server->CreateObject('Msxml2.DOMDocument.3.0');
	$UploadInfoPath = $DocRoot."\\_private\\client\\forms\\$TransID\\index.xml";
        if ($Session->{FormTask} == 2) #delete attachment
        	{                          
        	use Win32API::File;                                 
		$DeletedFile = $Request->QueryString('name')->item;
       		$RecvdFilePath = "$DocRoot\\_private\\client\\forms\\$TransID\\$DeletedFile";
		if ($UploadInfo->load($UploadInfoPath))
			{
			$Attachments = $UploadInfo->selectSingleNode('//attachments');
			$RemovedNode = $UploadInfo->selectSingleNode("//attachment[\@name='$DeletedFile']");
			if(!($Attachments->removeChild($RemovedNode)))
				{die "couldn't remove file node: $!";}
			}
		else
			{die "couldn't load index file: $UploadInfoPath";}

                if (-e $RecvdFilePath)
			{
			if (!(Win32API::File::DeleteFile($RecvdFilePath)))
				{die "couldn't delete file: $!;";}
			}
		else
			{print "can't find file to delete: $RecvdFilePath";}
		$UploadInfo->save($UploadInfoPath); #so the information is updated in time for below
        	$Session->{FormTask} = 0;
        	}
        if ($Session->{FormTask} == 3) #moving on...
        	{                        
        	$Session->{FormProcess} = 1;
        	$Session->{FormTask} = 0;
        	}
	}

if ($Session->{FormProcess} == -1) # cancel
	{
	&ClearForm;
	#but also remove the transid directory
	$Response->redirect('/client');
	}

#display cases here
%>
        <html>
        <head>
        	<title>Finish Submission</title> 
        	<link rel="stylesheet" type="text/css" href="/client/document/resource/client.css">
        	<style>
		p {margin: 4px;}                        
		li {margin: 6px;}                        
		h2 {margin: 2px;}
		h3 {margin: 2px;}			
		h4 {margin: 2px;}			
		textarea {font-family: verdana, helvetica, sans;}

        	</style>
                <script language="javascript">
                <!--                      
                function UploadDone()
                        {
        		var WaitingUploads = addattachments.location1.value.length + addattachments.location2.value.length + addattachments.location3.value.length + addattachments.location4.value.length + addattachments.location5.value.length;
        		if (WaitingUploads > 0)
        			{
        			alert("First click the 'Add Files To Form' button before going on to the next page.  Otherwise your new file attachments will not be included with your form.");
				addattachments.addbutton.style.color='red';
        			return false;
        			}
        		else
        			{return true;}
                        }
        
                //-->
                </script>

        </head>
        <body>                                                                  
<!--                        
<p style="background-color: red">Session: <%=$Session->{FormProcess}%>/<%=$Session->{FormTask}%></p>
<p style="background-color: yellow">Form: <%=$Pstep%>/<%=$Ptask%></p>
<p style="background-color: green">Query: <%=$Gstep%>/<%=$Gtask%></p>
-->
<%

if ($Session->{FormProcess}==0) # done editing form
	{   
	%>                  
	<table width="520">
		<tr>
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td width="480">
        <h2 style="margin-bottom: 2px;">Finishing Form:  Attach Files</h2>
	<p>Before you send your form to Durham &amp; Bates you have the option to include files such as photos, spreadsheets, or other related documents.  Depending on you connection speed and the number/size of the files you send, this step may take a few moments.  Please try to limit the total size of your file attachments to 1 Megabyte.</p>
	<%                                                          
	if ($UploadInfo->load($UploadInfoPath))
		{                                       
		$Attachments = $UploadInfo->selectNodes('//attachment');
        	if ($Attachments->{length} > 0)
        		{
        		%>
        		<form name="removeattachment" action="finishsubmission.asp" method="post">              
        			<input type="hidden" name="step" value="0"/>		             
        			<input type="hidden" name="task" value="2"/>		
                        	<table width="440" align="center" style="margin: 8px; border: solid black 2px;">
                        		<tr>
                        			<td colspan="3" width="440" style="text-align: center; border-bottom: solid black 1px;"><p><b>Currently Attached Files</b></p></td>
                        		</tr>                                              
                        		<%
                        		for ($index=0; $index<$Attachments->{length}; $index++)
                        			{
        					$ThisAttachment = $Attachments->item($index);
        					%>
                        		
                        		<tr>
                        			<td width="80" align="center" style="background-color:<%=$index%2?'':'#EEEEFF'%>"><p style="color: blue; font-size: 8px"><a href="finishsubmission.asp?step=0&task=2&name=<%=$ThisAttachment->getAttribute('name')%>">REMOVE</a></p></td>
                        			<td width="260" style="background-color:<%=$index%2?'':'#EEEEFF'%>"><%=$ThisAttachment->getAttribute('name')%></td>
                        			<td width="100" style="background-color:<%=$index%2?'':'#EEEEFF'%>"><%=$ThisAttachment->getAttribute('size')%> Bytes</td>
                        		</tr>
                        			<%
        					}
                        		%>
                        	</table>
               		</form>
        		<%
        		}
		}
	%>

		<form action="addattachments.aspx" name="addattachments" method="post" enctype="multipart/form-data">
			<input type="hidden" name="TransID" value="<%=$TransID%>">
                	<table width="440" align="center" style="margin: 8px; border: solid black 2px;">
                		<tr>
                			<td width="440" colspan="2" style="text-align: center; border-bottom: solid black 1px;"><p><b>Select new files to attach</b></p></td>
                		</tr>                                              
                		<%
                		for ($index=1; $index<=6; $index++)
                			{%>
                		
                		<tr>
                			<td align="right" width="80" style="background-color:<%=$index%2?'#EEEEFF':''%>"><%=$index%>.</td>
                			<td width="360" style="background-color:<%=$index%2?'#EEEEFF':''%>"><p><input type="file" name="location<%=$index%>" required="1"></p></td>
                		</tr>
                			<%}
                		%>
                		<tr>
                			<td colspan="2" style="text-align:center; border-top: solid black 1px;">
						<p>
							<input name="addbutton" type="submit" value="Add Files to Form">
						</p>
					</td>
                		</tr>
                	</table>
       		</form>        
			</td>
		</tr>
		<tr>                                                
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td>
	<h3>Next: Add notes or instructions</h3>
	<p>When you have finished adding any files you wish to send with your form, click on the button below to go to the next step.</p>
	<div align="right"><form name="nextpage" action="finishsubmission.asp" onSubmit="return UploadDone();" method="post"><input type="hidden" name="task" value="3"/><input type="hidden" name="step" value="0"/><input type="submit" name="next" value="Next =>"/></form></div>
	<h3>Other options:</h3>                                      
	<li><a href="/editform.asp">Return to your form to make changes.</a></li>
	<li><a href="finishsubmission.asp?step=2&task=0">Send your form to Durham &amp; Bates now.</a></li>
	<li><a href="finishsubmission.asp?step=-1&task=0">Cancel and erase your form.</a></li>
			</td>
		</tr>
	</table>
	<%
	}
if ($Session->{FormProcess}==1) # done changing attachments
	{
	%>
	<table width="520">
		<tr>
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td width="480">
                                <h2 style="margin-bottom: 2px;">Finishing Form:  Add Notes and/or Instructions</h2>
                        	<p>If there is any additional information you need to include please place it here:</p>
                        	<form name="notes" action="finishsubmission.asp" method="post">                           
					<input type="hidden" name="task" value="1"/>
					<input type="hidden" name="step" value="1"/> 
					<%                                                         
					if ($SubmissionNode->selectSingleNode('//notes'))
						{
						$StoredNotes = $SubmissionNode->selectSingleNode('//notes')->{text};
						$StoredNotes =~ s{<\!\[CDATA\[(.*?)\]\]>}{$1}isg;
						}
					%>
                        		<textarea cols="42" rows="5" name="notes"><%=$StoredNotes%></textarea>
			</td>
		</tr>
		<tr>                                                
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td width="480">
                        	<h3>Next: Send your form to Durham &amp; Bates</h3>
                        	<p>When you have finished adding any notes or instructions, click on the button below to go to the next step.</p>
                        	<div align="right"><input type="submit" value="Next =>"/></div>
				</form>
                        	<h3>Other options:</h3>                                      
                        	<li><a href="/editform.asp">Return to your form to make changes.</a></li>                   
                        	<li><a href="finishsubmission.asp?step=0&task=0">Add/delete files</a></li>
                        	<li><a href="finishsubmission.asp?step=-1&task=0">Cancel and erase your form.</a></li>
			</td>
		</tr>
	</table>
	<%
	}
if ($Session->{FormProcess}==2) # done editing additional notes
	{                                           
	%>
	<table width="520">
		<tr>
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td width="480">
                                <h2 style="margin-bottom: 2px;">Finishing Form:  Send to Durham &amp; Bates</h2>
 				<p>If you have completed your form and have added any neccessary attachments and/or instructions you are now ready to send it to Durham &amp; Bates.</p>
                        	<form name="notes" action="finishsubmission.asp" method="post"> 
                        		<input type="hidden" name="step" value="2"/>		                          
                        		<input type="hidden" name="task" value="1"/>		
                        	<div align="right"><input type="submit" value="Send Form =>"/></div>
				</form>
			</td>
		</tr>
		<tr>                                                
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td width="480">
                        	<h3>Other options:</h3>                                      
                        	<li><a href="/editform.asp">Return to your form to make changes.</a></li>                   
                        	<li><a href="finishsubmission.asp?step=0&task=0">Add/delete files</a></li>
                        	<li><a href="finishsubmission.asp?step=1&task=0">Add/delete notes</a></li>
                        	<li><a href="finishsubmission.asp?step=-1&task=0">Cancel and erase your form.</a></li>
			</td>
		</tr>
	</table>
	<%
	}
if ($Session->{FormProcess}==3) # done with submission, display confirmation screen and link to return
	{
	%>
	<table width="520" height="240">
		<tr>
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td width="480">
                                <h2 style="margin-bottom: 2px;">Thank You!</h2>
				<p>Your form has been sent to Durham and Bates.  Your transaction number is <%=$TransID%></p>
			</td>
		</tr>
		<tr>                                                
			<td width="40" bgcolor="#EEEEFF">&nbsp;</td>
			<td width="480" align="right">
				<form action="/client"><input type="submit" value="Done =>"/><form>
			</td>
		</tr>
	</table>
	<%
	&ClearForm;
	}
%>
	</body>
</html>

<%
sub SendSubmission
	{
       	use Win32API::File;      
        $DocRoot = $Server->MapPath('/');                   
	$UploadInfo = $Server->CreateObject('Msxml2.DOMDocument.3.0');
	$UploadInfoPath = $DocRoot."\\_private\\client\\forms\\$TransID\\index.xml";

	$SubmissionStatus = 1;
	$TimeNode = $SubmissionNode->selectSingleNode('ServerTime');
	$SubmitTime = $ScriptingNamespace->PrettyTime($TimeNode->{text});
	$Host = $Request->ServerVariables('SERVER_NAME')->item;
	$TransIDValue = $Session->{XMLFile}->selectSingleNode('//SubmissionTable/TransID')->{text};
	$ClientName = $Session->{XMLFile}->selectSingleNode('//ClientTable/Name')->{text};
	$SubmissionTitle = $Session->{XMLFile}->selectSingleNode('//SubmissionTable/SubmissionTitle')->{text};
        $TransID = $SubmissionNode->selectSingleNode('//TransID')->{text};
        $UpdateSuccess = $SubmissionTable->UpdateEntry($TransID);

	###### generate the agent message
	$NotificationFile = '/data/template/submission.tem';
	@FileInfo = stat($Server->MapPath($NotificationFile));
	open (NOTIFICATION, '<'.$Server->MapPath($NotificationFile));
	read (NOTIFICATION, $AgentNotification, $FileInfo[7]);
	close (NOTIFICATION);
	$AgentNotification =~ s{~SubmitTime~}{$SubmitTime}isg;
	$AgentNotification =~ s{~Host~}{$Host}isg;
	$AgentNotification =~ s{~TransID~}{$TransIDValue}isg;
	$AgentNotification =~ s{~ClientName~}{$ClientName}isg;
	$AgentNotification =~ s{~SubmissionTitle~}{$SubmissionTitle}isg;

        ########## generalize this later...
        $HTMLTree = $Session->{XMLFile}->CloneNode(true);   
        
        $ExternalReferences = $Session->{XMLFile}->selectNodes('//excluded/refX');
        for ($index = 0; $index < $ExternalReferences->{length}; $index++)
        	{
        	$TagPath = $ExternalReferences->item($index)->{text};    
        	$RefValue = $Session->{XMLFile}->selectSingleNode($TagPath)->{text};
        	$ExternalReferences->item($index)->{parentNode}->{parentNode}->setAttribute('PreviouslyExcluded', $RefValue);
        	}
        
        $ExternalReferences = $HTMLTree->selectNodes('//refX');
        for ($index = 0; $index < $ExternalReferences->{length}; $index++)
        	{
        	$TagPath = $ExternalReferences->item($index)->{text};
        	$ReferenceNode = $Session->{XMLFile}->selectSingleNode($TagPath);
        	if ($ReferenceNode)  
        		{$ExternalReferences->item($index)->{text} = $ReferenceNode->{text};}
        	else
        		{die "$TagPath ->".$Session->{XMLFile}->{xml};}
        	}  
        
        $DisplayPageNodes = $HTMLTree->selectNodes('//template[not(excluded=1 and excluded)]//page[not(excluded=1 and excluded)]');
        $ActivePageNode = $HTMLTree->createElement('DisplayPages');
        for ($index = 0; $index < $DisplayPageNodes->{length}; $index++)
        	{$ActivePageNode->appendChild($DisplayPageNodes->item($index)->cloneNode(1));} 
        $HTMLTree->{documentElement}->appendChild($ActivePageNode);
        $ActivePageNode = $HTMLTree->selectSingleNode('//DisplayPages');
        
        $InputTags = $ActivePageNode->selectNodes('.//input');
        for ($index = 0; $index < $InputTags->length; $index++)
                {            
                $ThisInput = $InputTags->item($index);
                if ($ThisInput->{text} eq $ThisInput->getAttribute('value'))
                	{$ThisInput->setAttribute('checked',1);}
                else                                                    
                	{$ThisInput->removeAttribute('checked');}
                if (length($ThisInput->text)) 
                        {
                        $ThisInput->setAttribute('value',$ThisInput->text);
                        $ThisInput->{text} = '';
                        }
                } 
        $SelectTags = $ActivePageNode->selectNodes('.//select[selection]');  
        for ($index = 0; $index < $SelectTags->length; $index++)
                {            
                $ThisSelect = $SelectTags->item($index);
                $ThisSelection = $ThisSelect->selectSingleNode('selection')->text;
                if ($ThisSelection->text) 
        	        {$ThisSelect->selectSingleNode('option[@id='.$ThisSelection.']')->setAttribute('selected',1);}
                }                              
	#here's where we leave xml-land...
	#can we do some of the above stuff with the stylesheet too?

        $DocRoot = $Server->MapPath('/');                   
	$FormFolder = "$DocRoot\\_private\\client\\forms\\$TransID";

        $FormTransform = Win32::OLE->new('Msxml2.DOMDocument.3.0');
        $FormTransform->load($DocRoot.'/component/forms/FormTransformation.xsl');
	#$ActivePageNode->save($FormFolder."\\pagenode.xml");
        $ActivePage = $ActivePageNode->transformNode($FormTransform);
	$ActivePage =~ s{<br></br>}{<br />}isg; # because otherwise it's double
	#$ActivePage =~ s{<script*?>.*?</script>}{}isg; #don't remember why we did this...
        
        $SubmissionXSL = Win32::OLE->new('Msxml2.DOMDocument.3.0');
        $SubmissionXSL->load($DocRoot.'/component/forms/submissionbody.xsl');
        $SubmissionContent = $HTMLTree->transformNode($SubmissionXSL);
        $SubmissionContent =~ s{<!--SubmissionTime-->}{$SubmitTime};
        $SubmissionContent =~ s{<!--SubmissionContent-->}{$ActivePage};
        ################
	#Send the e-mail
	if (1)
		{
		if (1)
			{
        		$PrimaryRecipients = $Session->{XMLFile}->selectNodes('//Recipients/PrimaryRecipient');
        		for ($index = 0; $index < $PrimaryRecipients->{length}; $index++) {$PrimaryNames .= $MailTable->AddRecipient($PrimaryRecipients->item($index)->selectSingleNode('name')->{text},$PrimaryRecipients->item($index)->selectSingleNode('address')->{text}).' ';}
        		$BackupRecipients = $Session->{XMLFile}->selectNodes('//Recipients/BackupRecipient');
        		for ($index = 0; $index < $BackupRecipients->{length}; $index++) {$MailTable->AddRecipient($BackupRecipients->item($index)->selectSingleNode('name')->{text},$BackupRecipients->item($index)->selectSingleNode('address')->{text});}
			}
                                                                                   
		if (1)
			{
			$MailTable->AddRecipient('Douglas Miller',"bigthe\@bellsouth.net");
			}
		${$MailTable->FieldData}{FromName}{value}[0] = $Session->{XMLFile}->selectSingleNode('//ClientTable/ContactName')->{text};
		${$MailTable->FieldData}{FromAddress}{value}[0] = $Session->{XMLFile}->selectSingleNode('//ClientTable/ContactEmail')->{text};
		${$MailTable->FieldData}{Subject}{value}[0] = $Session->{XMLFile}->selectSingleNode('//ClientTable/Name')->{text}.', '.$Session->{XMLFile}->selectSingleNode('//SubmissionTable/SubmissionTitle')->{text};
		${$MailTable->FieldData}{BodyText}{value}[0] = $AgentNotification;  
		#add form as attachment
		if (1)
			{
       			open (FORM, ">$FormFolder\\form.htm");
       			print FORM $SubmissionContent;;
       			close (FORM);
       			$AttachmentSuccess = $MailTable->AddAttachments("$FormFolder\\form.htm");
			}
		#add instructions, if any
		if ($SubmissionNode->selectSingleNode('//notes'))
			{
                        $StoredNotes = $SubmissionNode->selectSingleNode('//notes')->{text};
                        $StoredNotes =~ s{<\!\[CDATA\[(.*?)\]\]>}{$1}isg;
			if (length($StoredNotes))
				{
				open (TEMPLATE, "<$DocRoot/component/forms/notes_template.htm");
				@FileInfo = stat(TEMPLATE);
				read (TEMPLATE, $NotesTemplate, $FileInfo[7]);
				close (TEMPLATE);
				$NotesTemplate =~ s{<!--Notes-->}{$StoredNotes};

        			open (NOTES, ">$FormFolder\\notes.htm");
        			print NOTES $NotesTemplate;
        			#print NOTES $StoredNotes;
        			close (NOTES);
        			$AttachmentSuccess = $MailTable->AddAttachments("$FormFolder\\notes.htm");
				}
			}
		#add other file attachments, if any
		if ($UploadInfo->load($UploadInfoPath))
			{                                       
			$Attachments = $UploadInfo->selectNodes('//attachment');
	        	if ($Attachments->{length} > 0)
        			{
                       		for ($index=0; $index<$Attachments->{length}; $index++)
                       			{
       					$ThisAttachment = $Attachments->item($index);
					$AttachmentSuccess = $MailTable->AddAttachments($ThisAttachment->getAttribute('path'));
					}
				}
			}

		if ($MailTable->SendMail)
			{
			push (@Alert,"Your submission has been sent to Durham and Bates");  
			$ActivityLog->AddEntry('submitted form',"'$SubmissionTitle'",'in transaction',$TransID);
			}
		else
			{push @Alert, "There was a problem with the mail server.  Please try again at a later time";}
		}
	# keep backup copy of form for now                           
	if (-e "$FormFolder\\index.xml") {Win32API::File::DeleteFile("$FormFolder\\index.xml");}
	if (-e "$FormFolder\\form.htm") {Win32API::File::DeleteFile("$FormFolder\\form.htm");}
	if (-e "$FormFolder\\notes.htm") {Win32API::File::DeleteFile("$FormFolder\\notes.htm");}
	$Session->{XMLFile}->save("$FormFolder\\form.xml");
	}
sub ClearForm
	{
        undef $Session->{XSLFile};
        undef $Session->{XMLFile};
	undef $Session->{FormProcess};
	undef $Session->{Task};
        $Session->{Form}=0; 
	}
%>