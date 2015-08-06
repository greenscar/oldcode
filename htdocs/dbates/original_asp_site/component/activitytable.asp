<%
{
package ActivityTable;
@ISA = ('SQLTable');
   
sub TransactionID 
        {  
	my $self = shift;
	undef $SessionID;
	$main::Session->{'ActivityCount'}++;
	for (split // , $main::Session->{'SessionID'})	
		{$SessionID .= (($_+6)%10);}
	$self->{TRANSID} = join("-",substr($SessionID,0,length($SessionID)-6),substr($SessionID,length($SessionID)-6,3),substr($SessionID,length($SessionID)-3,3),$main::Session->{'ActivityCount'});
	return $self->{TRANSID}; 
        }

sub AddEntry
	{
	my $self = shift;   
	$self->{'FIELDDATA'}->{'TransID'}->{'value'} = [$self->TransactionID];
	$self->{'FIELDDATA'}->{'ServerTime'}->{'value'} = [time];
	$self->{'FIELDDATA'}->{'RemoteIP'}->{'value'} = [${$main::Request}{ServerVariables}{'REMOTE_HOST'}{item}];
	$self->{'FIELDDATA'}->{'PersonaType'}->{'value'} = [$main::Session->{'LoginToArea'}];
	$self->{'FIELDDATA'}->{'PersonaID'}->{'value'} = [${$main::Session->{'Persona'}}[$main::AreaNameID{$main::Session->{'LoginToArea'}}][1]];
	$self->{'FIELDDATA'}->{'PersonaName'}->{'value'} = [${$main::Session->{'Persona'}}[$main::AreaNameID{$main::Session->{'LoginToArea'}}][3]];
	$self->{'FIELDDATA'}->{'Activity'}->{'value'} = [$_[0]];
	$self->{'FIELDDATA'}->{'DirectObject'}->{'value'} = [$_[1]];
	$self->{'FIELDDATA'}->{'IndirectPrep'}->{'value'} = [$_[2]];
	$self->{'FIELDDATA'}->{'IndirectObject'}->{'value'} = [$_[3]];
	$self->AddRecord;
	return $self->ParseEntry;
	}

sub ParseEntry
	{
	my $self = shift;
	$HumanTime = $main::ScriptingNamespace->PrettyTime(${$self->{'FIELDDATA'}->{'ServerTime'}->{'value'}}[0]);
	return 	"$HumanTime. ".
		"${$self->{'FIELDDATA'}->{'PersonaName'}->{'value'}}[0] ".
		"${$self->{'FIELDDATA'}->{'Activity'}->{'value'}}[0] ".
		"${$self->{'FIELDDATA'}->{'DirectObject'}->{'value'}}[0] ".
		"${$self->{'FIELDDATA'}->{'IndirectPrep'}->{'value'}}[0] ".
		"${$self->{'FIELDDATA'}->{'IndirectObject'}->{'value'}}[0] ".
		"(${$self->{'FIELDDATA'}->{'TransID'}->{'value'}}[0]).";
	}
}

$ActivityLog = ActivityTable->new(); 
$ActivityLog->TableName('ActivityLog');
$ActivityLog->Chronological(1);
$ActivityLog->PrimaryIndex('TransID');
$ActivityLog->FieldData(
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
        'RemoteIP'=>
		{
		'type'=>'adVarWChar',
		'size'=>'16',
		'value'=>[]		
		},
        'PersonaType'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},

        'PersonaID'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		},

        'PersonaName'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},

        'Activity'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=>[]		
		},

        'DirectObject'=>
		{
		'type'=>'adVarWChar',
		'size'=>'30',
		'value'=>[]		
		},

        'IndirectPrep'=>
		{
		'type'=>'adVarWChar',
		'size'=>'30',
		'value'=>[]		
		},

        'IndirectObject'=>
		{
		'type'=>'adVarWChar',
		'size'=>'50',
		'value'=>[]		
		}
        }
	); 
%>
        
