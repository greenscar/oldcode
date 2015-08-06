<%
{
package DocTable;
@ISA = ('SQLTable');    

sub DocID
	{
	$self = shift;                  
	my $DocName;              
	while ((-e $main::Server->MapPath('/')."/data/$DocName.doc") or (!$DocName))
		{for ($index=0;$index<8;$index++) {$DocName.=chr(rand(26)+65);}}
	${$self->FieldData}{ID}{value}[0] = $DocName;
	return $DocName;
	}         

sub OpenUpload
	{
	my $self = shift; 
	$self->{UPLOAD} = $main::Server->CreateObject("Persits.Upload.1");
	return $self->{UPLOAD}->Save;
	}  

sub OpenHardUpload
	{
	my $self = shift; 
	($Path) = @_;
	$self->{UPLOAD} = $main::Server->CreateObject("Persits.Upload.1");
	$self->{UPLOAD}->{OverwriteFiles} = 0;
	return $self->{UPLOAD}->Save($Path);
	}  

sub OpenDownload
	{
	my $self = shift; 
	$self->{DOWNLOAD} = $main::Server->CreateObject("Persits.Upload.1");
	return $self->{DOWNLOAD};
	}  

sub CloseDownload
	{
	my $self = shift;
	undef $self->{DOWNLOAD};
	return 1;
	} 

sub Download
	{
	my $self = shift;
	return $self->{DOWNLOAD}; 
	}             


sub Upload
	{
	my $self = shift;
	return $self->{UPLOAD}; 
	}

sub CloseUpload
	{
	my $self = shift;
	undef $self->{UPLOAD};
	return 1;
	}              

sub LoadUploadData
	{
	my $self = shift;
	for my $ColumnName (keys %{$self->FieldData})
		{
		if (${$self->Upload->Form}{$ColumnName}{value})
			{${$self->FieldData}{$ColumnName}{value}[0] = ${$self->Upload->Form}{$ColumnName}{value};}
		}
	${$self->FieldData}{Location}{value}[0] = "/data/${$self->FieldData}{ID}{value}[0].doc";
	return 1;
	}

sub DocList
	{
	my $self = shift;
	(my $DocType, $Feature) = @_;
	my $Query = "DocType='$DocType' AND Expiration>@{[time]}";
	if (length($Feature)>0) {$Query .= " AND Feature=$Feature";} 
	my $DocumentCount = $self->GetRecord($Query ,'Title');
	my $index = 0;
	if ($DocumentCount)
		{
        	while ($index < $DocumentCount)
        		{
        		$main::Response->write("<li");                   
        		if (${$self->FieldData}{Feature}{value}[$index])
        			{$main::Response->write(" class='feature'");}
        		$main::Response->write("><p>");
        		if ($DocType eq 'page')
        			{$main::Response->write("<a href='".${$self->FieldData}{Location}{value}[$index]."' target='_new'>");}
			elsif ($DocType eq 'form')
        			{$main::Response->write("<a href='/LoadForm.asp?ID=".${$self->FieldData}{ID}{value}[$index]."'>");}
        		else
        			{$main::Response->write("<a href='/ViewDocument.asp?ID=".${$self->FieldData}{ID}{value}[$index]."'>");}
        		$main::Response->write("${$self->FieldData}{Title}{value}[$index]</a>&nbsp;&nbsp;");
        		$main::Response->write("${$self->FieldData}{Description}{value}[$index]");
        		if (${$self->FieldData}{Access}{value}[$index])
        			{$main::Response->write(" <small><b>[Client access only]</b></small>");}
        		$main::Response->write("</p></li>");
        		$index++;
        		}
		}
	else
		{$main::Response->write("<li><p><em>Currently there are no listed items; check back soon.</em></p></li>");}
	return $DocumentCount;
	}

sub DocListEdit
	{
	my $self = shift;
	(my $DocType) = @_;
	my $Query = "DocType='$DocType'";
	my $DocumentCount = $self->GetRecord($Query ,'Title');
	my $index = 0;
	if ($DocumentCount)
		{
        	while ($index < $DocumentCount)
        		{
       			$main::Response->write("<li><p><a style='font-size:8pt;' href='/agent/EditDoc.asp?ID=".${$self->FieldData}{ID}{value}[$index]."'>");
        		$main::Response->write("${$self->FieldData}{Title}{value}[$index]</a></p></li>");
        		$index++;
        		}
		}
	else
		{$main::Response->write("<li><p><em>Currently There Are No Matching Items</em></p></li>");}
	return $DocumentCount;
	} 

sub Sessions
	{
	my $self = shift;
	return ${$self->FieldData}{Sessions}{value}[0] =~ m{(\d+)}isg;
	} 
}

$DocTable = DocTable->new(); 
$DocTable->TableName('DocTable');
$DocTable->PrimaryIndex('ID');
$DocTable->FieldData(
	{
        'ID'=>
		{
		'type'=>'adVarWChar',
		'size'=>'20',
		'value'=>[]		
		},                                    
        'Location'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		},
        'Title'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		},  
        'Description'=>
		{
		'type'=>'adLongVarWChar',
		'value'=>[]		
		},
        'Publisher'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		},
        'Author'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		}, 
        'DocType'=>
		{
		'type'=>'adVarWChar',
		'size'=>'20',
		'value'=>[]		
		}, 
        'Access'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'Feature'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		}, 
        'Profile'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		},
        'MetaTags'=>
		{
		'type'=>'adVarWChar',
		'size'=>'160',
		'value'=>[]		
		},
        'Expiration'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		}, 
        'IsSeminar'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
	'Sessions'=>
		{
		'type'=>'adVarWChar',
		'size'=>'240',
		'value'=>[]		
		},
        'RecipientName'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		},
        'RecipientAddress'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		},
        }
	); 
%>