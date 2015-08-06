<%
$SubmissionContent ='toasting';
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
$ActivePage = $ActivePageNode->{xml};       
$Script = 'script';

$ActivePage =~ s{<calculation.*?target=.(\w+).*?>(.*?)</calculation>}{<$Script language="javascript1.2" xml:space="preserve">\n<!--\n\tDBForm.$1.value=$2;\n//-->\n</$Script>}isg;
$ActivePage =~ s[<function.*?name=.(\w+).*?target=.(\w+).*?>(.*?)</function>][<$Script language="javascript1.2" xml:space="preserve">\n<!--\n\tfunction $1()\n\t{DBForm.$2.value=$3;}\n//-->\n</$Script>]isg;
$ActivePage =~ s[<display/s+target=.(\w+).*?/>][<span id="displayValue"><$Script language="javascript1.2" xml:space="preserve">\n<!--\n\tdocument.write(DBForm.$1.value);\n//-->\n</$Script></span>]isg;
$ActivePage =~ s{<page.*?title="(.*?)".*?>}{<page><h3>$1</h3>}isg;

for ('repeat','RepeatInstance','refDefault','refX','page','template','submission','xml')
	{$ActivePage =~ s{<$_.*?>(.*?)</$_>}{$1}isg;}
for ('RepeatTemplate','Iterations','selection','excluded')
	{$ActivePage =~ s{<$_.*?>.*?</$_>}{}isg;}
          
$ActivePage =~ s{<input type="text".*?size="(.*?)".*?value="(.*?)".*?>}{<span id='show' style="width: @{[$1*7]};">$2</span>}isg;
$ActivePage =~ s{<input type="hidden".*?size="(.*?)".*?value="(.*?)".*?>}{<span id='show' style="width: @{[$1*7]};">$2</span>}isg;
$ActivePage =~ s{</input>}{</span>}isg;
$ActivePage =~ s{<textarea.*?>(.*?)</textarea>}{<table id="FormerTextArea"><tr><td>$1</td></tr></table>}isg;
$ActivePage =~ s{<select.*?<option.*?selected.*?>(.*?)</option>.*?</select>}{<span id='show'>$1</span>}isg;
for ('script','calculation','function','display') {$ActivePage =~ s{<$_.*?>.*?</$_>}{}isg;}

$SubmissionXSL = Win32::OLE->new('Msxml2.DOMDocument.3.0');
$SubmissionXSL->load($DocRoot.'/component/forms/submissionbody.xsl');
$SubmissionContent = $HTMLTree->transformNode($SubmissionXSL);
$SubmissionContent =~ s{<SubmissionContent/>}{$ActivePage}
$SubmissionContent =~ s{<SubmissionTime/>}{$SubmitTime}
%>