<%
{
package UWTable;
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
		return ($CryptAllegedPW eq $RecordCryptPW);
		}
	else
		{return 0;} 
	}
# package end
}

$UWTable =UWTable->new(); 
$UWTable->TableName('UWTable');
$UWTable->PrimaryIndex('ID');
$UWTable->FieldData(
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
        'Folder'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},
        'ContactEmail'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		}

	}
	); 
%>