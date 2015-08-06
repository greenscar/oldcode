<html>
<head>
	<title>D&amp;B Forms</title>
	<link rel="stylesheet" type="text/css" href="/component/forms/form.css"/>
	<script language="javascript" src="/component/forms/validation.js"></script>
</head>
        <body topmargin="0" leftmargin="0">
		<table id="MainTable" cellspacing="0pt" cellpadding="0pt" border="0">      
        		<tr>
        			<td id="SubmissionBar"> 
                                	<h3>
						<%=$Session->{XMLFile}->selectSingleNode("/submission/ClientTable/Name")->{text}%>
					</h3>
        			</td>
        		</tr>  
        		<tr>
        			<td id="TemplateBar"> 
                                	<h4>    
						<% 
						$PakTitle = $Session->{XMLFile}->selectSingleNode('/submission/@title');
						if ($PakTitle)
							{$Response->write($PakTitle->{text});}
						%>
						<%=$Session->{XMLFile}->selectSingleNode('/submission/template[page/@active]/@title')->{text}%>
						<%
						if ($Session->{FormViewMode} eq 'page')
							{%>
							->                                             
							<%=$Session->{XMLFile}->selectSingleNode('//page[@active]/@title')->{text}%>
							<%}%>
                        		</h4>
				</td>
			</tr>   
                <%
                if ($CompletionStatus)
                {
		%>
                	<tr id="section">
				<td><h4>Submission #<%=$Session->{XMLFile}->selectSingleNode("/submission/SubmissionTable/TransID")->{text}%>: <%=$ScriptingNamespace->PrettyTime($Session->{XMLFile}->selectSingleNode("/submission/SubmissionTable/ServerTime")->{text})%></h4>
				</td>
			</tr>
                <%
		}
                %>             

			<tr>
				<td>
					<br/> 
					<%                      
					$Instructions = $Session->{XMLFile}->selectSingleNode('//page[@active]/@instructions');
					if ($Instructions)
						{%> 
						<p style="margin-left:15pt;">
	                                      		<%=$Instructions->{text}%>
						</p>
						<%}
					%>
        			</td>
        		</tr>
			<tr>
				<td>                   
				<% 
				if ($Session->{FormViewer} eq 'agent') 
					{$FormProcessor = '/agent/ViewForm.asp';} 
				else 
					{
					if ($CompletionStatus)
						{$FormProcessor = '/ViewForm.asp';}
					else
						{$FormProcessor = '/EditForm.asp';}
					}			
				%>
                        	<form name="DBForm" action="<%=$FormProcessor%>" method="post"> 
                        		<input type="hidden" name="QueNextPage"/>
					<input type="hidden" name="Complete"/>
                        		<input type="hidden" name="FinishLater"/>
                        		<input type="hidden" name="CancelForm"/>
                        		<input type="hidden" name="SendForm"/>
                        
                        	<%   
				if ($Session->{'FormViewer'} eq 'agent')
					{
        				if ($Session->{'FormViewMode'} eq 'submission')
        					{$ViewSelection = '//template[not(excluded=1 and excluded)]//page[not(excluded=1 and excluded)]';}
        				elsif ($Session->{'FormViewMode'} eq 'template')
        					{$ViewSelection = '//template[page/@active=1 and not(excluded=1 and excluded)]//page[not(excluded=1 and excluded)]';}
        				else 	{$ViewSelection = '//template[not(excluded=1 and excluded)]//page[@active=1 and not(excluded=1 and excluded)]';}
        				$DisplayPageNodes = $HTMLTree->selectNodes($ViewSelection);
        
        				$ActivePageNode = $HTMLTree->createElement('DisplayPages');
        				for ($index = 0; $index < $DisplayPageNodes->{length}; $index++)
        					{$ActivePageNode->appendChild($DisplayPageNodes->item($index)->cloneNode(1));} 
        
        				$HTMLTree->{documentElement}->appendChild($ActivePageNode);
					$ActivePageNode = $HTMLTree->selectSingleNode('//DisplayPages');
					}
				else
					{                     
					$ActivePageNode = $HTMLTree->selectSingleNode('//page[@active=1]');
					}

				$InputTags = $ActivePageNode->selectNodes('.//input');
				for ($index = 0; $index < $InputTags->length; $index++)
					{            
					$ThisInput = $InputTags->item($index);
					if ($ThisInput->{text} eq $ThisInput->getAttribute('value'))
							{$ThisInput->setAttribute('checked',1);}
					else                                                    
							{$ThisInput->removeAttribute('checked');}
					if ($ThisInput->getAttribute('type') eq 'radio')
						{$ThisInput->{text} = '';}
					else
						{
        					if (length($ThisInput->text)) 
        							{
        							$ThisInput->setAttribute('value',$ThisInput->text);
        							$ThisInput->{text} = '';
        							}
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
				if ($Session->{FormViewMode} eq 'submission') 
					{
					$ActivePage =~ s{<page.*?title="(.*?)".*?>}{<page><h3>$1</h3>}isg;
					}
                                for ('repeat','RepeatInstance','refDefault','refX','page','template','submission','xml')
                                	{$ActivePage =~ s{<$_.*?>(.*?)</$_>}{$1}isg;}
                                for ('RepeatTemplate','Iterations','selection','excluded')
                                	{$ActivePage =~ s{<$_.*?>.*?</$_>}{}isg;}
                                          
				if ($CompletionStatus)
					{
					$ActivePage =~ s{<input type="text".*?size="(.*?)".*?value="(.*?)".*?>}{<span id='show' style="width: @{[$1*8]};">$2</span>}isg;
					$ActivePage =~ s{<input type="hidden".*?size="(.*?)".*?value="(.*?)".*?>}{<span id='show' style="width: @{[$1*8]};">$2</span>}isg;
					$ActivePage =~ s{</input>}{</span>}isg;
					$ActivePage =~ s{<textarea.*?>(.*?)</textarea>}{<table id="FormerTextArea"><tr><td>$1</td></tr></table>}isg;
					$ActivePage =~ s{<select.*?<option.*?selected.*?>(.*?)</option>.*?</select>}{<span id='show'>$1</span>}isg;
                               		for ('script','calculation','function','display')
                                		{$ActivePage =~ s{<$_.*?>.*?</$_>}{}isg;}
                                 	}
				$Response->write($ActivePage);      

				$Response->write("<p style='text-align:center;margin-top:10pt;'>");

				$ValidPages = $Session->{XMLFile}->selectNodes("//template[not(excluded=1 and excluded)]//page[not(excluded=1 and excluded)]");
				$TotalPages = $ValidPages->{length};
				while ($index < $TotalPages)
					{   
					$PageCompletionStatus = $ValidPages->item($index)->getAttribute('complete');
					if ($ValidPages->item($index)->getAttribute('active'))
						{
						$ActivePageIndex = $index;
						$ActivePageComplete = $PageCompletionStatus
						}
					$CompletedPages += $PageCompletionStatus; 
					$index++;
					}  

				if (($Session->{FormViewMode} ne 'submission') and ($Session->{FormViewMode} ne 'template'))
					{
        				if ($ActivePageIndex > 0) {$Response->write("<input type='button' value='Previous Page' onClick='javascript:DBForm.QueNextPage.value=\"-1\";FormValidation(1);'/>");} 
        
        				if ($TotalPages > 1)    
        					{                                    
        					%><select name='JumpToPage' onChange="javascript:FormValidation(0);">
        					<%
        					for ($index = 0; $index < $TotalPages; $index++)
        						{
        						$Response->write("<option id='$index'");
        						if ($index == $ActivePageIndex) {$Response->write(" selected = '1'");}
        						if ($ValidPages->item($index)->getAttribute('complete')) {$Response->write(" style='background-color:black;color:white;'");}
        						$Response->write('>'.$ValidPages->item($index)->getAttribute('title'));						
        						$Response->write("</option>");
        					        }                                   
        					%>
        					</select><%
        					}
        
        				if ($TotalPages - $ActivePageIndex - 1 > 0) 
        					{%><input type="button" value="Next Page" onClick="javascript:DBForm.QueNextPage.value='1';FormValidation(1);"/><%} 
					}
				%>        

                		<br/>
                		<img src="/resource/spacerline.gif" style="margin:2px;"/>
                		<br/>        
                                <%
				if (!$CompletionStatus)
					{
        				if ((($TotalPages - $CompletedPages) == 0) or ((($TotalPages - $CompletedPages) == 1) and !$ActivePageComplete))
                         		{%><input type="button" value="Finish" style="color:red;font-weight:bold;" onClick="javascript:DBForm.SendForm.value=1;FormValidation(1);"/>&nbsp<%}
					%>
	                	      	<!--<input type="button" name="DoLater" value="Save &amp; Complete Later" onClick="javascript:DBForm.FinishLater.value='1';FormValidation(0);"/> &nbsp;    -->
					<%
					}
				if ($Session->{'FormViewer'} eq 'agent')
					{
					%>
        				<select name="FormViewMode" onChange="FormValidation(0)">
        					<option value="page" <%=($Session->{'FormViewMode'} eq 'page')?'selected="1"':''%>>View by page</option>
        					<!--<option value="template" <%=($Session->{'FormViewMode'} eq 'template')?'selected="1"':''%>>View by form</option>-->
        					<option value="submission" <%=($Session->{'FormViewMode'} eq 'submission')?'selected="1"':''%>>View by entire submission</option>
        				</select> 
                                        &nbsp;
					<%
					}
					%>
                	      	<input type="button" name="Cancel" value="Cancel" onClick="javascript:DBForm.CancelForm.value='1';FormValidation(0);"/>
                		</p>
                        	</form>  
			</td>
		</tr>
	</table>
	</body>
	</html>