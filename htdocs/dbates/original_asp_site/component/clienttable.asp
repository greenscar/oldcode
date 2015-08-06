<%
{
package ClientTable;
@ISA = ('SQLTable');

sub CheckLogin
	{
	my $self = shift;
	($AllegedID, $AllegedPW, $CryptAllegedPW) = @_;
	# first see if account exists, then check if password matches
	if ($self->GetRecord("ID='$AllegedID'",'')) 
		{
		my $RecordCryptPW = ${$self->FieldData}{CryptPW}{value}[0];
		$CryptAllegedPW = length($CryptAllegedPW) ? $CryptAllegedPW : crypt($AllegedPW, $RecordCryptPW);
		return ($CryptAllegedPW eq ${$self->FieldData}{CryptPW}{value}[0]);
		}
	else
		{return 0;} 
	}

sub NewVisit
	{
	my $self = shift; 
	my ($ID) = @_;
	$self->GetRecord("ID='$ID'",'');
	${$self->FieldData}{Hits}{value}[0]++;
	$main::Session->{Hits} = ${$self->FieldData}{Hits}{value}[0];
	return $self->UpdateRecord(['ID','Hits'],"ID='$AllegedID'",'');
	}

# package end
}

$ClientTable =ClientTable->new(); 
$ClientTable->TableName('ClientTable');
$ClientTable->PrimaryIndex('ID');
$ClientTable->FieldData(
	{
        'ID'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		}, 
        'Active'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},  
        'CryptPW'=>
		{
		'type'=>'adVarWChar',
		'size'=>'16',
		'value'=>[]		
		},    
        'Name'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},    
        'ContactName'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},    
        'ContactPhone'=>
		{
		'type'=>'adVarWChar',
		'size'=>'25',
		'value'=>[]		
		},
        'ContactEmail'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},
        'Hits'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		},
        'Profile'=>
		{
		'type'=>'adVarWChar',
		'size'=>'60',
		'value'=>[]		
		},
        'ProdLead'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'CSRLead'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'DeptCommercial'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'ProdCommercial'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'CSRCommercial'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'DeptMarine'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'ProdMarine'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'CSRMarine'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'DeptPersonal'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'ProdPersonal'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'CSRPersonal'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'DeptProfProg'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'ProdProfProg'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},
        'CSRProfProg'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		}, 
	}
	); 
%>
