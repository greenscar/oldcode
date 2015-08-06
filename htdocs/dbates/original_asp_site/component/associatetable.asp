<%
{
package AssociateTable;
@ISA = ('SQLTable');

sub CheckLogin
	{
	my $self = shift;
	($AllegedID, $AllegedPW, $CryptAllegedPW) = @_;
	# first see if account exists, then check if password matches
	if ($self->GetRecord("ID='$AllegedID' and Active=1",'')) 
		{
		my $RecordCryptPW = ${$self->FieldData}{CryptPW}{value}[0];
		$CryptAllegedPW = length($CryptAllegedPW) ? $CryptAllegedPW : crypt($AllegedPW, $RecordCryptPW);
		return ($CryptAllegedPW eq ${$self->FieldData}{CryptPW}{value}[0]);
		}
	else
		{return 0;} 
	}
# package end
}

$AssociateTable =AssociateTable->new(); 
$AssociateTable->TableName('AssociateTable');
$AssociateTable->PrimaryIndex('ID');
$AssociateTable->FieldData(
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
        'Title'=>
		{
		'type'=>'adVarWChar',
		'size'=>'120',
		'value'=>[]		
		},
        'Email'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},   
        'Fax'=>
		{
		'type'=>'adVarWChar',
		'size'=>'25',
		'value'=>[]		
		},
        'DirectLine'=>
		{
		'type'=>'adVarWChar',
		'size'=>'25',
		'value'=>[]		
		}, 
        'Role'=>
		{
		'type'=>'adVarWChar',
		'size'=>'30',
		'value'=>[]		
		},
        'DeptAgency'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'DeptCommercial'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'DeptMarine'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'DeptPersonal'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'DeptProfProg'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'DeptConsulting'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		},
        'DeptOutside'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=>[]		
		}
	}
	); 
%>