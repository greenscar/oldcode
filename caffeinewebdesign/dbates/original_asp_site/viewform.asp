<%@ LANGUAGE = PerlScript %> 
<!--#Include virtual="/component/SQLTable.asp"--> 
<%                  

if (!$Session->{Form}) {$Response->Redirect('/deny.asp');}
if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{post}i)
	{   
	if (${$Request->Form}{CancelForm}{item})
		{
		$Session->{Form} = 0;
		undef $Session->{XMLFile};
		$Response->Redirect('/client');
		exit;
		}
	else
		{
                $CurrentPage = $Session->{XMLFile}->selectSingleNode('//page[@active=1]');
		if (!$CurrentPage)
			{
			$CurrentPage = $Session->{XMLFile}->selectSingleNode('//template[not(@PreviouslyExcluded and @PreviouslyExcluded=1)]//page[not(@PreviouslyExcluded and @PreviouslyExcluded=1)]');
			$CurrentPage->setAttribute('active',1);
			}
        	$JumpToPage = ${$Request->Form}{JumpToPage}{item};
                $QueNextPage = ${$Request->Form}{QueNextPage}{item};   
        	if ($JumpToPage eq $CurrentPage->getAttribute('title'))
        		{
			$ValidPages = $Session->{XMLFile}->selectNodes('//template[not(@PreviouslyExcluded and @PreviouslyExcluded=1)]//page[not(@PreviouslyExcluded and @PreviouslyExcluded=1)]');     
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
		}                      
	}                 
%> 
<!--#Include virtual="/component/forms/LoadFormPage.asp"-->

