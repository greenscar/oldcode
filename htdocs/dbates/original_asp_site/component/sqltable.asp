<script language="perlscript" runat="server">

{
package SQLTable;
#use strict;

# Constructor

sub new 
	{  
	my $proto = shift;
        my $class = ref($proto) || $proto;
        my $self  = {};  
        $self->{FIELDDATA} = {};
        bless ($self, $class);
        return $self;
	}

# Methods 

sub DataTypes
	{   
	my $self = shift;
	(my $type) = @_;
	my %DataType = 
		(
		adBigInt => {value => 20, null => 0},
		adBinary => {value => 128, null => 0},
		adBoolean => {value => 11, null => 0},
		adBSTR => {value => 8, null => 0},
		adChapter => {value => 136, null => 0},
		adChar => {value => 129, null => ' '},
		adCurrency => {value => 6, null => 0},
		adDate => {value => 7, null => 0},
		adDBDate => {value => 133, null => 0},
		adDBTime => {value => 134, null => 0},
		adDBTimeStamp => {value => 135, null => 0},
		adDecimal => {value => 14, null => 0},
		adDouble => {value => 5, null => 0},
		adEmpty => {value => 0, null => 0},
		adError => {value => 10, null => 0},
		adFileTime => {value => 64, null => 0},
		adGUID => {value => 72, null => 0},
		adIDispatch => {value => 9, null => 0},
		adInteger => {value => 3, null => 0},
		adIUnknown => {value => 13, null => 0},
		adLongVarBinary => {value => 205, null => 0},
		adLongVarChar => {value => 201, null => ' '},
		adLongVarWChar => {value => 203, null => ' '},
		adNumeric => {value => 131, null => 0},
		adPropVariant => {value => 138, null => 0},
		adSingle => {value => 4, null => 0},
		adSmallInt => {value => 2, null => 0},
		adTinyInt => {value => 16, null => 0},
		adUnsignedBigInt => {value => 21, null => 0},
		adUnsignedInt => {value => 19, null => 0},
		adUnsignedSmallInt => {value => 18, null => 0},
		adUnsignedTinyInt => {value => 17, null => 0},
		adUserDefined => {value => 132, null => 0},
		adVarBinary => {value => 204, null => 0},
		adVarChar => {value => 200, null => ' '},
		adVariant => {value => 12, null => 0},
		adVarNumeric => {value => 139, null => 0},
		adVarWChar => {value => 202, null => ' '},
		adWChar => {value => 130, null => ' '}
		);
	return $DataType{$type};
	}
            
sub Provider
        {
        my $self = shift;
        if (@_) {$self->{PROVIDER} = shift; }
        return $self->{PROVIDER};
        }     

sub ProviderString
	{
	my $self = shift;
	(my $CatalogName, my $Provider) = @_; 
	my $ProviderString;                     
	if ($Provider eq 'jet')
		{$ProviderString = 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=admin;Password=;Jet OLEDB:Engine Type=4;Data Source='.$main::Server->MapPath("/data/$CatalogName.mdb");}
	elsif ($Provider eq 'sql') 
		{$ProviderString = 'Provider=SQLOLEDB;User ID=dbates;Password=gnmvn+vaqly;Initial Catalog='.$CatalogName;}
	#$ProviderString = 'DSN=dbates.dbates;UID=dbates;';
	return $ProviderString;
	}

sub CatalogName
        {
        my $self = shift;
        if (@_) {$self->{CATALOGNAME} = shift; }
        return $self->{CATALOGNAME};
        }

sub TableName 
        {
        my $self = shift;
        if (@_) { $self->{TABLENAME} = shift; }
        return $self->{TABLENAME};
        }

sub PrimaryIndex 
        {
        my $self = shift;
        if (@_) { $self->{PRIMARYINDEX} = shift; }
        return $self->{PRIMARYINDEX};
        }  

sub Chronological 
        {
        my $self = shift;
        if (@_) { $self->{CHRONOLOGICAL} = shift; }
        return $self->{CHRONOLOGICAL};
        }

sub FieldData 
        {
        my $self = shift;
        if (@_) {$self->{FIELDDATA} = shift; }
        return $self->{FIELDDATA};
        }         

sub InitFields
	{
        my $self = shift;
	for my $ColumnName (keys %{$self->{FIELDDATA}})
		{${$self->{FIELDDATA}}{$ColumnName}{value} = [];}
	return 1;
	}

sub ParseData
	{
	my $self = shift;
	my $ColumnName;
	my $RecordCount = @{${$self->FieldData}{$self->PrimaryIndex}{value}};
	for $ColumnName (keys %{$self->FieldData})
		{       
		my $type = ${$self->FieldData}{$ColumnName}{type};    
		my $index = 0;
		while ($index < $RecordCount)
			{
			if (! ${$self->FieldData}{$ColumnName}{value}[$index])
				{${$self->FieldData}{$ColumnName}{value}[$index] = $self->DataTypes($type)->{null};}
			$index++;
			}
		} 
	return;
	}      

sub LoadFormData
	{
	my $self = shift;
	my @FormFields;      
	(my @IncludedFields) = ${$main::Request->Form}{IncludedFields}{item} =~ m{(\S+)\s}isg;
	for my $ColumnName (@IncludedFields)
		{
		if (${$self->FieldData}{$ColumnName})
			{
			${$self->FieldData}{$ColumnName}{value}[0] = ${$main::Request->Form}{$ColumnName}{item};
			push @FormFields, $ColumnName;
			}
		}          
	return @FormFields;
	}  

sub DumpData
	{
	my $self = shift;
	$main::Response->write("<html><body><h3>${$self}{TABLENAME}, Field Data</h3>");
	for (sort keys %{$self->FieldData})
		{
		$main::Response->write("$_: ");
		$main::Response->write(" ${$self->FieldData}{$_}{value}[0]");
		$main::Response->write(" [${$self->FieldData}{$_}{type},");
		$main::Response->write(" ${$self->FieldData}{$_}{size}]<br>");
		}
	$main::Response->write("</body></html>");
	exit;
	#later do this as multidimensional table
	}

sub DataToNode 
	{
	my $self = shift;  
	(my $ParentNode) = @_;
	my $TableNode = $main::Session->{XMLFile}->createElement($self->TableName);
	$ParentNode->appendChild($TableNode);
	for (sort keys %{$self->FieldData})
		{
		my $FieldNode = $main::Session->{XMLFile}->createElement($_);
		$FieldNode->{text} = ${$self->FieldData}{$_}{value}[0]; 
		if ($_ ne 'CryptPW') {$TableNode->appendChild($FieldNode);}
		}
	}  

sub DataToOptions
	{
	my $self = shift;  
	(my $Criterion, my $SortColumns, my $KeyField, my $ResultField) = @_;
	my $RecordCount = $self->GetRecord($Criterion, $SortColumns);
	my @OptionTags;
	my $index;
	while ($index < $RecordCount)
		{
		push @OptionTags, "<option value='${$self->FieldData}{$KeyField}{value}[$index]'>${$self->FieldData}{$ResultField}{value}[$index]</option>";
		$index++;
		}
	return @OptionTags;
	}
	
sub OpenConnection
	{
	my $self = shift;
	(my $Instance, my $CatalogName, my $Provider) = @_;
	if (!$Provider) {$Provider = $main::Session->{DBType};}
	if (!$Instance and !$CatalogName and $self->CatalogName) {$CatalogName = $self->CatalogName;}  
	$CatalogName = $CatalogName || 'dbates';
	$self->{'DBCONNECTION'.$Instance} = $main::Server->CreateObject("ADODB.Connection");

	$self->{LASTDBERROR} = 0;
	$self->{'DBCONNECTION'.$Instance}->Open($self->ProviderString($CatalogName, $Provider));    
	if ($self->{'DBCONNECTION'.$Instance}->Errors->count > $self->{LASTDBERROR})
		{
		$main::Response->write("<ul><li>ERROR:".$self->{LASTDBERROR}."</li>");
		$main::Response->write("<ul><li>ConnectionProperties:".$self->{'DBCONNECTION'.$Instance}->{ConnectionString}."</li>");
		for (keys %{$self->{'DBCONNECTION'.$Instance}->Errors->item($self->{LASTDBERROR})})
			{$main::Response->write("<li style='color:red;'>$_:".$self->{'DBCONNECTION'.$Instance}->Errors->item($self->{LASTDBERROR})->{$_}.'</li>');}
		$self->{LASTDBERROR}=$self->{LASTDBERROR}+1; 
		$main::Response->write('</ul>');
		}
	return $self->{'DBCONNECTION'.$Instance}->{State}; 
	}

sub DBConnection
	{
	my $self = shift;
	(my $Instance) = @_;
	return $self->{'DBCONNECTION'.$Instance} || 0;
	}


sub CloseConnection
	{
	my $self = shift; 
	(my $Instance) = @_;
	$self->{'DBCONNECTION'.$Instance}->close;
	my $CloseFlag = $self->{'DBCONNECTION'.$Instance}->{State};  
	$self->{'DBCONNECTION'.$Instance} = undef;
	return !$CloseFlag;
	}

sub OpenRecordset
	{
	my $self = shift;
	(my $Instance) = @_;
	$self->{'RECORDSET'.$Instance} = $main::Server->CreateObject("ADODB.Recordset");
	$self->{'RECORDSET'.$Instance}->{CursorType}=1;
	$self->{'RECORDSET'.$Instance}->{CursorLocation}=2;
	$self->{'RECORDSET'.$Instance}->{LockType}=3;
	return 1; 
	}

sub Recordset
	{
        my $self = shift;
	(my $Instance) = @_;
        return $self->{'RECORDSET'.$Instance};
	}

sub CloseRecordset
	{
	my $self = shift;
	(my $Instance) = @_;
        $self->{'RECORDSET'.$Instance}->close;
	$self->{'RECORDSET'.$Instance} = undef;
	return 1;
	}

sub AddRecord
	{
	my $self = shift; 
	(my $Instance, my $CatalogName, my $Provider) = @_;
	$self->ParseData;          		    
	$self->OpenConnection($Instance, $CatalogName, $Provider);
	$self->OpenRecordset($Instance);
	$self->Recordset($Instance)->Open("SELECT * FROM @{[$self->TableName]} WHERE 1=2", $self->DBConnection($Instance));
	$self->Recordset($Instance)->AddNew;     
	for my $ColumnName (keys %{$self->FieldData})
		{
		${$self->Recordset}{$ColumnName}=${$self->FieldData}{$ColumnName}{value}[0];
		}   
	my $TableName = $self->TableName;
	my $PrimaryIndex = $self->PrimaryIndex;
	my $ID = ${$self->{FIELDDATA}}{$PrimaryIndex}{value}[0]; 
	$self->Recordset($Instance)->Update;
	$self->CloseRecordset($Instance);
	$self->OpenRecordset;
	$self->Recordset($Instance)->Open("SELECT * FROM $TableName WHERE $PrimaryIndex='$ID'", $self->DBConnection($Instance));
	$self->Recordset($Instance)->MoveLast;
	my $FindRecordSuccess = $self->Recordset($Instance)->Recordcount; 
	$self->CloseRecordset($Instance);
	$self->CloseConnection($Instance);
	return $FindRecordSuccess;
	}

sub FindRecord
	{
	my $self = shift;
	(my $Criterion, my $Instance, my $CatalogName, my $Provider) = @_;
	if (length($Criterion)>0) {$Criterion = "WHERE $Criterion";}
	$self->OpenConnection($Instance, $CatalogName, $Provider);
	$self->OpenRecordset($Instance);
	$self->Recordset($Instance)->Open("SELECT * FROM @{[$self->TableName]} $Criterion", $self->DBConnection($Instance));
	$self->Recordset($Instance)->MoveLast;
	my $FindRecordSuccess = $self->Recordset($Instance)->Recordcount;
	$self->CloseRecordset($Instance);
	$self->CloseConnection($Instance);
        return $FindRecordSuccess;
	}

sub GetRecord
	{
	my $self = shift;
	(my $Criterion , my $SortColumns, my $Instance, my $CatalogName, my $Provider) = @_;
	my $GetRecordSuccess;
	if (length($Criterion)>0) {$Criterion = qq{WHERE $Criterion};}
	if (length($SortColumns)>0) {$SortColumns = "ORDER BY $SortColumns";}
	$self->InitFields;
	if (!$self->OpenConnection($Instance, $CatalogName, $Provider)) {return 0;}
	$self->OpenRecordset($Instance);         
	my $Query = "SELECT * FROM @{[$self->TableName]} $Criterion $SortColumns";	
	#if ($SortColumns) {die $Query;}
	$self->Recordset($Instance)->Open($Query, $self->DBConnection($Instance));
	#$self->DumpRecord;
	if ($self->Recordset($Instance)->{EOF})
		{$GetRecordSuccess = 0;}
	else
		{
		while (! $self->Recordset($Instance)->{EOF})
			{
			for ($ThisField = 0; $ThisField < $self->Recordset($Instance)->Fields->{Count}; $ThisField++)
				{                                                              
				$ColumnName = $self->Recordset($Instance)->Fields->item($ThisField)->{name};
				push @{$self->{FIELDDATA}{$ColumnName}{value}}, $self->Recordset($Instance)->Fields->item($ThisField)->{value};
				}
			$self->Recordset($Instance)->MoveNext;
			}
		$GetRecordSuccess = $self->Recordset($Instance)->Recordcount;
		}
	$self->CloseRecordset($Instance);
	$self->CloseConnection($Instance); 
        return $GetRecordSuccess;
	}  

sub DumpRecord
	{
	my $self = shift;                    
	$main::Response->write("<html><body><h3>${$self}{TABLENAME}, Record</h3>");
	for ($ThisField = 0; $ThisField < $self->Recordset($Instance)->Fields->{Count}; $ThisField++)
		{
		$ThisFieldName = $self->Recordset($Instance)->Fields->item($ThisField)->{name};
		$ThisFieldValue = $self->Recordset($Instance)->Fields->item($ThisField)->{value};
		$main::Response->write("$ThisFieldName: $ThisFieldValue<br/>");
		#$main::Response->write("${$self->Recordset}{$_}{value}<br>");
		}
	$main::Response->write("</body></html>");
	exit;
	#later do this as multidimensional table
	}
              


sub UpdateRecord
	{
	my $self = shift;  
	(my $Fields, my $Criterion , my $SortColumns, my $Instance, my $CatalogName, my $Provider) = @_;
	my $TheseFields;
	if (! ref $Fields) 
		{
		$TheseFields = "*";
		$Fields = [keys %{$self->FieldData}];
		} 
	else 	
		{$TheseFields = join (',',@{$Fields});}
	if (length($Criterion)>0) {$Criterion = "WHERE $Criterion";}
	if (length($SortColumns)>0) {$SortColumns = "ORDER BY $SortColumns";}
	my $index = 0;  
	my $UpdateRecordSuccess = 0; 
	if ($Criterion)
		{     
        	$self->OpenConnection($Instance, $CatalogName, $Provider);
               	$self->OpenRecordset($Instance);
        	$self->Recordset($Instance)->Open("SELECT $TheseFields FROM @{[$self->TableName]} $Criterion $SortColumns", $self->DBConnection($Instance));
        	if (! $self->Recordset($Instance)->{EOF})
			{
			$self->Recordset($Instance)->MoveLast;
			$UpdateRecordSuccess = $self->Recordset($Instance)->Recordcount;
			$self->Recordset($Instance)->MoveFirst;
			$self->ParseData;    
                       	while (($index<$UpdateRecordSuccess) and (! $self->Recordset($Instance)->{EOF}))
                       		{
				for my $ColumnName (@{$Fields})
                			{
					${$self->Recordset}{$ColumnName}=${$self->FieldData}{$ColumnName}{value}[$index];
					} 
                		$self->Recordset($Instance)->MoveNext;
                		$index++;
                		}
			}  
                $self->Recordset($Instance)->Update;
                $self->CloseRecordset($Instance);
                $self->CloseConnection($Instance);
		}      
	return $UpdateRecordSuccess;
	}

sub DeleteRecord
	{
	my $self = shift;
	(my $Criterion, my $TransID, my $Instance, my $CatalogName, my $Provider) = @_;
	if ($self->PersistRecord($Criterion,$TransID))
		{
		my $Query = qq{SELECT * FROM @{[$self->TableName]} WHERE $Criterion};
        	$self->OpenConnection($Instance, $CatalogName, $Provider); 
        	$self->DBConnection($Instance)->Execute("DELETE FROM @{[$self->TableName]} WHERE $Criterion");
        	$self->CloseConnection($Instance);  
		return 1;       
		}
	else
		{return 0;}
	} 

sub PersistRecord
	{
	my $self = shift;
	(my $Criterion, my $TransID, my $Instance, my $CatalogName, my $Provider) = @_;
	my $Query = qq{SELECT * FROM @{[$self->TableName]} WHERE $Criterion};
      	$self->OpenConnection($Instance, $CatalogName, $Provider); 
        $self->OpenRecordset($Instance);         
        $self->Recordset($Instance)->Open($Query, $self->DBConnection($Instance));
        $self->Recordset($Instance)->Save($main::Server->MapPath("/data/$TransID.xml"), 1);		
        $self->CloseRecordset($Instance);    
        $self->CloseConnection($Instance); 
	return -e $main::Server->MapPath("/data/$TransID.xml");
	}   

sub CreateDatabase
	{  
	my $self = shift;
	(my $CatalogName, my $Provider) = @_;
	if (!$Provider) {$Provider = $main::Session->{DBType};}
	if (!$CatalogName) {$CatalogName = $self->CatalogName?$self->CatalogName:'dbates';}
	$DBCatalog = $main::Server->CreateObject("ADOX.Catalog");
	$DBCatalog->create($self->ProviderString($CatalogName, $Provider));
	undef $DBCatalog; 
	return 1;
	}   

sub CreateTable
	{
	my $self = shift;
	(my $CatalogName, my $Provider, my $TableName) = @_;    
	my $DBCatalog = $main::Server->CreateObject("ADOX.Catalog");  
	my $Table = $main::Server->CreateObject("ADOX.Table");  
	my $ColumnTypes;
	$DBCatalog->{ActiveConnection} = $self->ProviderString($self->CatalogName, $self->Provider);
	$Table->{Name} = $TableName; 
	for (sort {$a cmp $b} keys %{${'main::'.$TableName}->FieldData})
		{
		my $ColumnType = $self->DataTypes(${${'main::'.$TableName}->FieldData}{$_}{type})->{value};
		$Table->Columns->Append($_,$ColumnType,${${'main::'.$TableName}->FieldData}{$_}{size});
		if ($_ ne ${'main::'.$TableName}->PrimaryIndex) 
			{$Table->Columns($_)->{Attributes} = 2;}
		$ColumnTypes .= " ".${${'main::'.$TableName}->FieldData}{$_}{type};
		} 

	my $PrimaryIndex = $main::Server->CreateObject("ADOX.Key");
	$PrimaryIndex->{Name} = $TableName.'PrimaryKey';
	$PrimaryIndex->{Type} = 1;                                                              
	$PrimaryIndex->Columns->Append(${'main::'.$TableName}->PrimaryIndex);
	$Table->Keys->Append($PrimaryIndex); 
                        
	$DBCatalog->Tables->Append($Table);
	if (! $DBCatalog->Tables($TableName)) 
		{
		die "not created $TableName ".$Table->Columns->Count." ".$DBCatalog->Tables->Count." $ColumnTypes";
		}                

	undef $PrimaryIndex;	
	undef $Table;
	undef $DBCatalog;
	return 1;
	}   
}
</script>

<script language="javascript" runat="server">
function UTCTime(PerlTimeCode)
	{
	JavaScriptTimeCode = PerlTimeCode * 1000; 
	Time = new Date(JavaScriptTimeCode);
	return Time.toUTCString();
	}
</script>

<script language="javascript" runat="server">
function PrettyTime(PerlTimeCode)
	{
	JavaScriptTimeCode = PerlTimeCode * 1000; 
	Time = new Date(JavaScriptTimeCode);
	return Time.toLocaleString();
	}
</script>

<script language="javascript" runat="server">
function ParameterDate(Year, Month, Day, Hour, Minute)
	{
	Time = new Date(Year, Month, Day, Hour, Minute);
	return Time/1000;
	}
</script>

<script language="PerlScript" runat="server">
sub ShortTime
	{              
	(my $PerlTimeCode) = @_;   
	if ($PerlTimeCode)
		{
        	my @Time = localtime($PerlTimeCode);
        	$Time[5] += 1900;
		$Time[4]++;
        	if (length($Time[1])<2) {$Time[1] = '0'.$Time[1];}
		if ($Time[2]>12) 
			{
			$Time[2]-=12;
			$PM = "pm";    
			}
		else {$PM='am';}
        	return "$Time[4]/$Time[3]/$Time[5] $Time[2]:$Time[1] $PM";
		}	
	else
		{return;}
	} 
</script>

