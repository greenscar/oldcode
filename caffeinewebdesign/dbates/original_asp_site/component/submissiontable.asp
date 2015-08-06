<%
{
package SubmissionTable;
@ISA = ('SQLTable');   

sub AddEntry
	{
	my $self = shift;   
                       
	$self->{'FIELDDATA'}->{'TransID'}->{'value'} = [$main::ActivityLog->TransactionID];
	$self->{'FIELDDATA'}->{'ServerTime'}->{'value'} = [time];               
	my $SubmissionTitle = $main::Session->{XMLFile}->selectSingleNode('//submission')->getAttribute('title');
	if (!$SubmissionTitle) {$SubmissionTitle = $main::Session->{XMLFile}->selectSingleNode('//submission/template')->getAttribute('title');}
	$self->{'FIELDDATA'}->{'SubmissionTitle'}->{'value'} = [$SubmissionTitle];
	$self->{'FIELDDATA'}->{'ClientID'}->{'value'} = [$main::Session->{XMLFile}->selectSingleNode('//ClientTable/ID')->{text}];
	$self->{'FIELDDATA'}->{'CompletionStatus'}->{'value'} = [$main::SubmissionStatus];

	$SubmissionNode = $main::Session->{XMLFile}->createElement('SubmissionTable');
	$main::Session->{XMLFile}->documentElement->appendChild($SubmissionNode);
	for ('TransID','ServerTime','SubmissionTitle','ClientID','CompletionStatus')
		{         
		my $TempNode = $main::Session->{XMLFile}->createElement($_);	
		$SubmissionNode->appendChild($TempNode);
		$TempNode->{text}=${$self->FieldData}{$_}{value}[0];
		undef $TempNode;
		}     

	$self->{'FIELDDATA'}->{'Data'}->{'value'} = [${$main::Session->{XMLFile}}{xml}];
	$self->AddRecord; 

	return;
	}

sub UpdateEntry
	{           
	my $self = shift; 
	(my $TransID) = @_; 

	my $RecordCount = $self->GetRecord("TransID='$TransID'",'');
	if (!$RecordCount) {return 0;}
	$self->{'FIELDDATA'}->{'ServerTime'}->{'value'} = [time];
	$self->{'FIELDDATA'}->{'CompletionStatus'}->{'value'} = [$main::SubmissionStatus];
	$self->{'FIELDDATA'}->{'Data'}->{'value'} = [${$main::Session->{XMLFile}}{xml}];
	$self->UpdateRecord('',"TransID='$TransID'",'');      

	my $SubmissionNode = $main::Session->{XMLFile}->selectSingleNode('//SubmissionTable');
	for ('ServerTime','CompletionStatus')
		{$SubmissionNode->selectSingleNode($_)->{text}=${$self->FieldData}{$_}{value}[0];}

	return 1;
	}    

sub SubmissionList
	{
	my $self = shift;     
	my $ClientID = ${$main::Session->{'Persona'}}[$main::AreaNameID{$main::Session->{'LoginToArea'}}][1];
	my $DocumentCount = $self->GetRecord("ClientID='$ClientID'",'ServerTime DESC');
	my $index = 0;  
	my @StatusImage = ("<img src='/resource/incomplete.jpg' border='0'>","<img src='/resource/complete.jpg' border='0'>");

	if ($DocumentCount)
		{        
		$main::Response->write("<table style='margin-left:10pt'>");
        	while ($index < $DocumentCount)
        		{
        		$main::Response->write("<tr>");
                                  
			my $CompletionStatus = ${$self->FieldData}{CompletionStatus}{value}[$index];
			my $TransID = ${$self->FieldData}{TransID}{value}[$index];               

        		$main::Response->write("<td align='right'>"); 
			$main::Response->write("<a href='/RetrieveForm.asp?TransID=$TransID'>".$StatusImage[$CompletionStatus].'</a>');
       			$main::Response->write("</td>");      
				
        		$main::Response->write("<td>"); 
	        		$main::Response->write('<span style="font-family:arial,helvetica;font-size:8pt;margin:2pt;font-weight:bold">'.&main::ShortTime(${$self->FieldData}{ServerTime}{value}[$index]).'</span>');				
        		$main::Response->write("</td>"); 
                            
               		$main::Response->write("<td>"); 
       	        	$main::Response->write('<span style="font-family:arial,helvetica;font-size:8pt;margin:2pt;">'.${$self->FieldData}{SubmissionTitle}{value}[$index].'</span>');				
               		$main::Response->write("</td>"); 

			if ($CompletionStatus)
				{
                		$main::Response->write("<td>"); 
        	        		$main::Response->write("<a href='/RetrieveForm.asp?TransID=$TransID&Clone=1'><img src='/resource/clone.jpg' border='0'></a>");
                		$main::Response->write("</td>");
				}    
			else
				{
                		$main::Response->write("<td>"); 
        	        		$main::Response->write("<a href='/client/FormManager.asp?TransID=$TransID&Delete=1'><img src='/resource/delete.jpg' border='0'></a>");
                		$main::Response->write("</td>");
				}



			my $ReceivedBy = ${$self->FieldData}{ReceivedBy}{value}[$index];
			if (length($ReceivedBy)>1)
				{
	        		$main::Response->write("<tr>"); 
                        		$main::Response->write("<td colspan='4' align='center'>"); 
                	        		$main::Response->write("<span style='color:navy;font-size:8pt;'>Received by $ReceivedBy: ");				
                	        		$main::Response->write($main::ScriptingNamespace->PrettyTime(${$self->FieldData}{ReceivedTime}{value}[$index]).'</span>');				
                        		$main::Response->write("</td>");
	        		$main::Response->write("</tr>");
				}
			elsif ($CompletionStatus)
				{
	        		$main::Response->write("<tr>");     
                        		$main::Response->write("<td colspan='4' align='center'>"); 
                	        		$main::Response->write("<span style='color:navy;font-size:8pt;'><em>Awaiting review by Durham and Bates</em></span>");				
                        		$main::Response->write("</td>");  
	        		$main::Response->write("</tr>");
				}
	       		$index++;
        		} 
		$main::Response->write("</table>");
		}
	else
		{$main::Response->write("<li style='margin-left:10pt'><span><em>Currently There Are No Matching Items</em></span></li>");}
	return $DocumentCount;
	}
sub SearchSubmissions
	{
	my $self = shift;   
	(my $Criteria) = @_;  
	my $DocumentCount = $self->GetRecord($Criteria,'ServerTime DESC');
	my $index = 0;  
	my @StatusImage = ("<img src='/resource/incomplete.jpg' border='0'>","<img src='/resource/complete.jpg' border='0'>");

	if ($DocumentCount)
		{        
		$main::Response->write("<table style='margin-left:10pt'>");
        	while ($index < $DocumentCount)
        		{
        		$main::Response->write("<tr>");
                                  
			my $CompletionStatus = ${$self->FieldData}{CompletionStatus}{value}[$index];
			my $TransID = ${$self->FieldData}{TransID}{value}[$index];               

        		$main::Response->write("<td align='right'>"); 
			$main::Response->write("<a href='/agent/RetrieveForm.asp?TransID=$TransID'>".$StatusImage[$CompletionStatus].'</a>');
       			$main::Response->write("</td>");  

        		$main::Response->write("<td>"); 
        		$main::Response->write('<span style="font-family:arial,helvetica;font-size:9pt;margin:2pt;font-weight:bold">'.&main::ShortTime(${$self->FieldData}{ServerTime}{value}[$index]).'</span>');				
        		$main::Response->write("</td>"); 

        		$main::Response->write("<td>"); 
	        		$main::Response->write('<span style="font-family:arial,helvetica;font-size:9pt;margin:2pt;font-weight:bold;color:red;">'.uc(${$self->FieldData}{ClientID}{value}[$index]).'</span>');				
        		$main::Response->write("</td>");    

                            
               		$main::Response->write("<td>"); 
       	        	$main::Response->write('<span style="font-family:arial,helvetica;font-size:9pt;margin:2pt;">'.${$self->FieldData}{SubmissionTitle}{value}[$index].'</span>');				
               		$main::Response->write("</td>"); 

			my $ReceivedBy = ${$self->FieldData}{ReceivedBy}{value}[$index];
			if (length($ReceivedBy)>1)
				{
	        		$main::Response->write("<tr>"); 
                        		$main::Response->write("<td colspan='4'>"); 
                	        		$main::Response->write("<span style='color:navy;font-size:8pt;margin:2pt;'>Received by $ReceivedBy: ");				
                	        		$main::Response->write($main::ScriptingNamespace->PrettyTime(${$self->FieldData}{ReceivedTime}{value}[$index]).'</span>');				
                        		$main::Response->write("</td>");
	        		$main::Response->write("</tr>");
				}
			elsif ($CompletionStatus)
				{
	        		$main::Response->write("<tr>");     
                        		$main::Response->write("<td colspan='3'>"); 
                	        		$main::Response->write("<span style='color:navy;font-size:8pt;margin:2pt;'><em>Awaiting review by Durham and Bates</em></span>");				
                        		$main::Response->write("</td>");  
	        		$main::Response->write("</tr>");
				}
	       		$index++;
        		} 
		$main::Response->write("</table>");
		}
	else
		{$main::Response->write("<li style='margin-left:10pt'><span><em>Currently There Are No Matching Items</em></span></li>");}
	return $DocumentCount;
	}
}

$SubmissionTable = SubmissionTable->new(); 
$SubmissionTable->TableName('SubmissionTable'); 
$SubmissionTable->Chronological(1);
$SubmissionTable->PrimaryIndex('TransID');
$SubmissionTable->FieldData(
	{
        'TransID'=>
		{
		'type'=>'adVarWChar',
		'size'=>'20',
		'value'=>[]		
		},                                    
        'ServerTime'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		},
        'SubmissionTitle'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		},    
        'ClientID'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},    
        'CompletionStatus'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		}, 
        'ReceivedBy'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},   
        'ReceivedTime'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		},     
        'ReceivedTrans'=>
		{
		'type'=>'adVarWChar',
		'size'=>'20',
		'value'=>[]		
		},     
        'Data'=>
		{
		'type'=>'adLongVarWChar',
		'value'=>[]		
		},
        }
	); 
%>