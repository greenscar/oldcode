<%     
$CurrentPage = $Session->{XMLFile}->selectSingleNode('//page[@active]');
if (!$CurrentPage)
	{
	$CurrentPage = $Session->{XMLFile}->selectSingleNode('//template[not(excluded=1 and excluded)]//page[@active=1 and not(excluded=1 and excluded)]'); 
	$CurrentPage->setAttribute('active','1');
	}

$CompletionNode = $Session->{XMLFile}->selectSingleNode('//SubmissionTable/CompletionStatus');
if ($CompletionNode) {$CompletionStatus = $CompletionNode->{text};}

if (!$CompletionStatus)
	{                              
     $RepeatNodes = $CurrentPage->selectNodes('.//repeat');
     for ($index = 0; $index < $RepeatNodes->{length}; $index++)
        	{
        	$ThisNode = $RepeatNodes->item($index);
               $IterationNode = $ThisNode->selectSingleNode('Iterations');
        	if ($IterationNode->selectSingleNode('refX'))
        		{     
        		$IterationNode = $IterationNode->selectSingleNode('refX');
        		$TemplateCopies = $Session->{XMLFile}->selectSingleNode($IterationNode->{text})->{text};
        		}
        	else
        		{$TemplateCopies = $IterationNode->{text};}     
        
        	$TemplateNode = $ThisNode->selectSingleNode('.//RepeatTemplate/RepeatInstance');
        
        	while ($TemplateCopies >= $ThisNode->selectNodes('.//RepeatInstance')->{length})
        		{
        		$InstanceID = $ThisNode->selectNodes('.//RepeatInstance')->{length};
        		$NewInstance = $TemplateNode->cloneNode(true);
        		$FieldInstance = $NewInstance->selectNodes('.//@name'); 
        		for ($index2 = 0; $index2 < $FieldInstance->{length}; $index2++)
        			{$FieldInstance->item($index2)->{value} .= $InstanceID;}
        		$ThisNode->appendChild($NewInstance);
        		}
        	while ($TemplateCopies < $ThisNode->selectNodes('RepeatInstance')->{length})
        		{
        		$TempNode = $ThisNode->removeChild($ThisNode->{lastChild});
        		if (!$TempNode->nodeName) {last;}
        		}
        	}  
	}                    

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
%>
<!--#Include virtual="/component/forms/RenderFormPage.asp"-->
