<%
{
package ArchiveTable;
@ISA = ('SQLTable');    

sub TypeConv
	{
	my $self = shift;
	(my $DataType, my $DataSize) = @_;
	my %ChangeType = 
		(
                '2'=>'adSmallInt',
                '3'=>'adInteger',  
                '4'=>'adSingle',
                '5'=>'adDouble',
                '6'=>'adCurrency',
                '7'=>'adDate',
                '11'=>'adBool',
                '16'=>'adTinyInt', 
                '17'=>'adUnsignedTinyInt', 
                '72'=>'adGUID',
                '128'=>'adBinary', 
                '129'=>'adChar', 
                '130'=>'adWChar', 
                '200'=>'adVarChar',    
                '201'=>'adLongVarChar',
                '202'=>'adVarWChar',
                '203'=>'adLongVarWChar',
                '204'=>'adVarBinary', 
                '205'=>'adLongVarWChar'
		);

	if ($ChangeType{$DataType})
		{return $ChangeType{$DataType};}
	else                                    
		{return $DataType;}
	}  

sub GetConnection
	{
	my $self = shift;                          
	my $ConnectionState = $self->OpenConnection('',$self->CatalogName, $self->Provider);
	$self->CloseConnection;
	return $ConnectionState;
	}

sub GetTables
	{
	my $self = shift;     
	use Win32::OLE; 
	my @TableNames;
	my $DBCatalog = $main::Server->CreateObject("ADOX.Catalog");
	$DBCatalog->{ActiveConnection} = $self->ProviderString($self->CatalogName, $self->Provider);
	for (Win32::OLE::in $DBCatalog->Tables) 
		{
		if (lc($_->{type}) eq 'table')
			{push @TableNames, $_->{name};}
		}
	undef $DBCatalog;
	return @TableNames;
	}

sub GetColumns
	{
	my $self = shift;     
	use Win32::OLE;
	my $ColumnNames;
	(my $TableName) = @_;
	my $DBCatalog = $main::Server->CreateObject("ADOX.Catalog");
	$DBCatalog->{ActiveConnection} = $self->ProviderString($self->CatalogName, $self->Provider);
	for (Win32::OLE::in $DBCatalog->Tables($TableName)->Columns) {push @ColumnNames, $_->{name};}
	undef $DBCatalog;
	return @ColumnNames;
	}  

sub VerifyColumns
	{
	my $self = shift;
	(my $TableName) = @_; 
	use Win32::OLE;
	my $DBCatalog2 = $main::Server->CreateObject("ADOX.Catalog");
	$DBCatalog2->{ActiveConnection} = $self->ProviderString($self->CatalogName, $self->Provider);
	if ($DBCatalog2->Tables($TableName))
		{$main::Response->write("<li>$TableName: Exists</li><ul>");}
	else                                  
		{
		$main::Response->write("<li>$TableName: Doesn't exist, creating...");
	
        	if (! $self->CreateTable($self->CatalogName, $self->Provider, $TableName)) 
        		{ 
        		$main::Response->write("error creating $TableName</li>");
        		return 0;
        		}   
		else 
			{
			$main::Response->write('done!</li>');
			return 1;
			}   
		}

	for (sort {$a cmp $b} keys %{${'main::'.$TableName}->FieldData})
		{        
		$ThisColumn = $DBCatalog2->Tables($TableName)->Columns($_);
		$ColumnExists = $ThisColumn?'Exists':'<b>Does not exist</b>';
		$DefinedType = ${${'main::'.$TableName}->FieldData}{$_}{type};
		$ActualType = $self->TypeConv($ThisColumn->{type},$ThisColumn->{DefinedSize});
		$TypesMatch =  ($DefinedType eq $ActualType)?'Match':"<b>$DefinedType eq $ActualType</b>";
		$DefinedSize = ${${'main::'.$TableName}->FieldData}{$_}{size};
		$ActualSize = $ThisColumn->{DefinedSize};
		$SizesMatch = ($DefinedSize == $ActualSize)?'Match':"<b>$DefinedSize == $ActualSize</b>";
		$main::Response->write("<li>$_: $ColumnExists</li>");
		$main::Response->write("<ul>");
			$main::Response->write("<li>type: $TypesMatch</li>");
			$main::Response->write("<li>size: $SizesMatch</li>");
		$main::Response->write("</ul>");
		}
	$main::Response->write("</ul>"); 
	undef $DBCatalog2;
	}    

sub CopyDB
	{  
	my $self = shift; 
	(my $SelectionCriteria, my $SourceInstance, my $SourceCatalog, my $SourceProvider, my $TargetInstance, my $TargetCatalog, my $TargetProvider) = @_;
	$self->OpenConnection($SourceInstance, $SourceCatalog, $SourceProvider) || return 'Couldn\'t open source connection';
	$self->OpenConnection($TargetInstance, $TargetCatalog, $TargetProvider) || return 'Couldn\'t open target connection';
	if (length($SelectionCriteria)>0) {$SelectionCriteria = qq{WHERE $SelectionCriteria};}
         
	$self->Provider($SourceProvider);
	$self->CatalogName($SourceCatalog);

	my @TableList = $self->GetTables;  
	my @ColumnNames;
	my $SourceCount;
	my $TargetCount;

	for my $TableName (@TableList)
		{             
		$main::Response->write("<li>$TableName: ");
		undef $Count;
        	$self->OpenRecordset($SourceInstance);
        	$self->Recordset($SourceInstance)->Open("SELECT * FROM $TableName $SelectionCriteria", $self->DBConnection($SourceInstance));
        	$self->OpenRecordset($TargetInstance);                                      
        	$self->Recordset($TargetInstance)->Open("SELECT * FROM $TableName WHERE 1=2", $self->DBConnection($TargetInstance));
		@ColumnNames = $self->GetColumns($TableName);
        	while (! $self->Recordset($SourceInstance)->{EOF})
                        {
        		$self->Recordset($TargetInstance)->AddNew;
                        for my $ColumnName (@ColumnNames)
                                {${$self->Recordset($TargetInstance)}{$ColumnName}=${$self->Recordset($SourceInstance)}{$ColumnName}{value};}
                        $self->Recordset($SourceInstance)->MoveNext;
                        }                          
		$self->Recordset($TargetInstance)->Update;
        	$self->CloseRecordset($SourceInstance);
        	$self->CloseRecordset($TargetInstance);
		$Count++; 
		$main::Response->write("$Count records</li>");
		}
	$self->CloseConnection($SourceInstance);
	$self->CloseConnection($TargetInstance);  
	return 'Success?';
	}
}

$ArchiveTable = ArchiveTable->new(); 
$ArchiveTable->TableName('ArchiveTable'); 
$ArchiveTable->Chronological(1);
$ArchiveTable->PrimaryIndex('ArchivalVolume');
$ArchiveTable->FieldData(
	{
        'ArchivalVolume'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		},  
        'ArchivalDate'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		},    
        'DeletionDate'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		}
        }
	);


%>