<%@ LANGUAGE = PerlScript %> 
<%
if (!$Session->{Form}) {$Response->Redirect('/deny.asp');}
                  
if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{post}i)
	{
	use Win32::OLE;
	$Session->{FormProcess} = 0;
	$CompletionNode = $Session->{XMLFile}->selectSingleNode('//SubmissionTable/CompletionStatus');
	if ($CompletionNode) {$CompletionStatus = $CompletionNode->{text};}

	if (${$Request->Form}{CancelForm}{item})
        	{
        	$Session->{Form}=0;
        	undef $Session->{XMLFile};
        	undef $Session->{FormViewer};
        	undef $Session->{FormViewMode};
		if ($CompletionStatus)	
			{$Response->Redirect('/client');}
		else                                                     
			{$Response->Redirect('/client');}
        	} 

	if (!$CompletionStatus)
		{
          	for $key (Win32::OLE::in $Request->Form)
                     	{ 
                      	$value = ${$Request->Form}{$key}{item};
                      	if ($value ne '')
                     		{                           
				#need to encode non-alphanumeric stuff here so it doesn't break the xml
				#$value =~ s{([^a-z\s])}{'&#'.ord($1).';'}isge;
                      		$FieldMatches = $Session->{XMLFile}->selectNodes('//page[@active=1]//*[@name="'.$key.'"]');
				for ($index = 0; $index < $FieldMatches->{length}; $index++)
                      			{                                                   
					$FieldMatch = $FieldMatches->item($index);
                      			$FieldType = $FieldType->{nodeName};
                      			if ($FieldType eq 'select')
                      				{$FieldMatch->selectSingleNode('selection')->{text} = $value;}
                      			elsif ($FieldType eq 'radio')
                      				{$FieldMatch->{text} = ($FieldMatch->{text} eq $FieldMatch->getAttribute('value'))?$value:'';}
                      			else
                      				{
       						$FieldMatch->{text} = $value;
       						if ($key eq 'ContactName') {$Session->{XMLFile}->selectSingleNode('//ClientTable/ContactName')->{text} = $value;}
       						if ($key eq 'ClientEmail') {$Session->{XMLFile}->selectSingleNode('//ClientTable/ContactEmail')->{text} = $value;}
       						if ($key eq 'ClientName') {$Session->{XMLFile}->selectSingleNode('//ClientTable/Name')->{text} = $value;}
       						}
                      			} 
                      		}
                      	}     
		}   

	$FormViewMode = (${$Request->Form}{FormViewMode}{item} || $Session->{FormViewMode}); 

	if ($FormViewMode ne $Session->{FormViewMode})           
		{$Session->{FormViewMode} = $FormViewMode;}
	else
		{
                $CurrentPage = $Session->{XMLFile}->selectSingleNode('//page[@active=1]');
                $JumpToPage = ${$Request->Form}{JumpToPage}{item};
                $QueNextPage = ${$Request->Form}{QueNextPage}{item};   
        
        	if ($JumpToPage eq $CurrentPage->getAttribute('title'))
        		{
        		$ValidPages = $Session->{XMLFile}->selectNodes('//template[not(excluded=1 and excluded)]//page[not(excluded=1 and excluded)]');     
        		for ($index = 0; $index < $ValidPages->{length}; $index++)
        			{
        			if ($ValidPages->item($index)->getAttribute('active') == 1)
        				{
        				$NextPage = $ValidPages->item($index+$QueNextPage);
        				last;
        				}
        			}
        		}
        	else
        		{
        		if ($JumpToPage)
        			{$NextPage = $Session->{XMLFile}->selectSingleNode("//page[\@title='$JumpToPage']");}                                            
        		else
        			{$NextPage = $CurrentPage;}
        		}
                         
        	$CurrentPage->removeAttribute('active');
        	$NextPage->setAttribute('active','1');     

        	if (${$Request->Form}{Complete}{item})
        		{$CurrentPage->setAttribute('complete','1');}
        	else
        		{$CurrentPage->removeAttribute('complete');}
                   
        	if (!$CompletionStatus)
        		{
                        $IncompletePages = $Session->{XMLFile}->selectNodes('//template[not(@PreviouslyExcluded=1 and @PreviouslyExcluded)]//page[not(@complete) and not(@PreviouslyExcluded=1 and @PreviouslyExcluded)]')->{length};
                        $SubmissionComplete = ! $IncompletePages;
                        $RequestSubmit = ${$Request->Form}{SendForm}{item};
                        if ($RequestSubmit and $SubmissionComplete)
                                {  
                                $NextPage->removeAttribute('active');
				$FirstPage = $Session->{XMLFile}->selectSingleNode('//template[not(@PreviouslyExcluded=1 and @PreviouslyExcluded)]//page[not(@PreviouslyExcluded=1 and @PreviouslyExcluded)]'); 
				$FirstPage->setAttribute('active','1');
                                $Response->Redirect("/component/forms/finishsubmission.asp");
                                } 
        		}
		}                                                 
	}                           

%> 
<!--#Include virtual="/component/forms/LoadFormPage.asp"-->