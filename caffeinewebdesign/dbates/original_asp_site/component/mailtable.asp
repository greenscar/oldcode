<%
{
package MailTable;
@ISA = ('SQLTable');

sub InitMail 
	{  
	my $self = shift; 
        if ($main::Session->{EnableMail})
		{
		$self->{MAILER}  = $main::Server->CreateObject("Persits.MailSender");
		$self->{ONLINE} = 1; 
		}                       
	${$self->FieldData}{ContentType}{value}[0] = 'text/html';
	${$self->FieldData}{RemoteHost}{value}[0] = $main::Session->{MailServer};
	${$self->FieldData}{TimeOut}{value}[0] = '60';
	return $self->{ONLINE}
	}

sub CloseMailer
	{
	my $self = shift;
	undef $self->{RecipientName};
	undef $self->{RecipientAddress}; 
	undef $self->{Attachments}; 
	$self->InitFields;
	undef $self->{MAILER};
	undef $self->{ONLINE};
	return;
	}

sub Online
	{
	my $self = shift;
	return $self->{ONLINE};
	}

sub AddRecipient
	{
	my $self = shift;
	(my $Name, my $Address) = @_;   
	#$Address =~ s{\@}{at}isg;
	if ($Name =~ m{\w+#}i)
		{$self->AddLogicalRecipients($Name);}
	else
		{
		push @{$self->{RecipientName}}, $Name;
		push @{$self->{RecipientAddress}}, $Address;
		}
	return join (', ',@{$self->{RecipientName}});
	}

sub AddAttachments
	{
	my $self = shift;
	(my $FileName) = @_;   
	push @{$self->{Attachments}}, $FileName; 
	return 1;
	}

sub AddLogicalRecipients
	{
	my $self = shift;
	(my $Name) = @_;
	my $index;
	if ($Name =~ m{id#(\w+)}i)
		{
		my $IDRecords = $main::AssociateTable->GetRecord(qq{ID='$1'},'');	
		while ($index < $IDRecords)
			{$self->AddRecipient(${$main::AssociateTable->FieldData}{Name}{value}[0],${$main::AssociateTable->FieldData}{Email}{value}[0]);
			$index++;}
		}
	elsif ($Name =~ m{team#(\w+)}i)
		{                           
		my $TeamID = $1;
		my $ClientRecords = $main::ClientTable->GetRecord("ID='${$main::Session->{Persona}}[1][1]'",'');
		my $TeamMembers = $main::AssociateTable->GetRecord("ID='${$main::ClientTable->FieldData}{$TeamID}{value}[0]'",'');
		$self->AddRecipient(${$main::AssociateTable->FieldData}{Name}{value}[0],${$main::AssociateTable->FieldData}{Email}{value}[0]);
		}

	elsif ($Name =~ m{role#(\w+)}i)
		{         
		my $RoleID = $1;  
		my $PrimaryCSR;  
		if ($RoleID =~ m{(..)CSR}i)
			{   
			$DeptID = $1; 
			my %Dept =
				( 
				'CL'=>'Commercial',
				'CM'=>'Marine',
				'PL'=>'Personal',
				'LC'=>'Commercial',
				'PR'=>'ProfProg',
				); 
			my $ClientRecords = $main::ClientTable->GetRecord("ID='${$main::Session->{Persona}}[1][1]'",'');			
			$PrimaryCSR = ${$main::ClientTable->FieldData}{'CSR'.$Dept{uc($DeptID)}}{value}[0];
			}
		my $RoleRecords = $main::AssociateTable->GetRecord(qq{Role LIKE '%$RoleID%'},'');	
		while ($index < $RoleRecords)
			{
			my $RoleID = ${$main::AssociateTable->FieldData}{ID}{value}[$index];
			if ($RoleID ne $PrimaryCSR)
				{
				$self->AddRecipient(${$main::AssociateTable->FieldData}{Name}{value}[$index],${$main::AssociateTable->FieldData}{Email}{value}[$index]);
				}
			$index++;
			}
		}
	return join (', ',@{$self->{RecipientName}});                 
	}

sub RecipientsToString
	{
	my $self = shift;  
	my $index;   
	my @Names = @{$self->{RecipientName}}; 
        my $RecipientCount = @Names;
	my @Addresses = @{$self->{RecipientAddress}}; 
        my $RecipientString;
        while ($index < $RecipientCount)
        		{
        		$RecipientString .="<recipient><name>@{[shift @Names]}</name><address>@{[shift @Addresses]}</address></recipient>";
		        $index++
		        }

	return $RecipientString;
	}    

sub DumpMail
	{
	my $self = shift;   
	$main::Response->write("<html><body><h3>${$self}{TABLENAME}, Field Data</h3>");
	for (keys %{$self->FieldData})
		{
		if ($_ ne 'Recipients')
			{
			$main::Response->write("$_: ");
			$main::Response->write(" ${$self->FieldData}{$_}{value}[0]<br>");
			}
		}
	my @Names = @{$self->{RecipientName}};
        my @Addresses = @{$self->{RecipientAddress}};
	while ($Names[0])
     		{
		$main::Response->write("Recipient: ");
		$main::Response->write(shift @Addresses);
		$main::Response->write(" ");
		$main::Response->write(shift @Names);
		$main::Response->write("<br/>");
		}                                    
        my @Attachments = @{$self->{Attachments}};

	for (my $index = 0; $index < scalar(@Attachments); $index++)
	     	{
		$main::Response->write("Attachment: ");
		$main::Response->write($Attachments[$index]);
		$main::Response->write("<br/>");
		}                                    

	$main::Response->write("<hr/>");
	$main::Response->write("</body></html>");
	$main::Response->flush;
	exit;
	}   

sub SendMail
	{
	my $self = shift;
	my $Success;  
	$self->InitMail;     
	if (! $self->{ExistingMail}) {${$self->FieldData}{ServerTime}{value}[0] = time;}
	if ($self->Online)
		{  
        	my @Names = @{$self->{RecipientName}};
        	my @Addresses = @{$self->{RecipientAddress}};
		for (my $index = 0; $index < scalar(@Names); $index++)                            
			{$self->{MAILER}->AddAddress($Addresses[$index], $Names[$index]);}
        	my @Attachments = @{$self->{Attachments}};          
		for (my $index = 0; $index < scalar(@Attachments); $index++)                            
			{                               
			if (-e $Attachments[$index])
				{$self->{MAILER}->AddAttachment($Attachments[$index]);}
			else
				{die "file note found $Attachments[$index]";}
			}
		#translate between old and new mail object properties here...                        
		if (${$self->FieldData}{'ContentType'}{value}[0]=='text/html') {${$self->{MAILER}}{IsHTML}=1;}
       		${$self->{MAILER}}{'Timeout'} = ${$self->FieldData}{'TimeOut'}{value}[0];
       		${$self->{MAILER}}{'Body'} = ${$self->FieldData}{'BodyText'}{value}[0];
       		${$self->{MAILER}}{'FromName'} = ${$self->FieldData}{'FromName'}{value}[0];
       		${$self->{MAILER}}{'From'} = ${$self->FieldData}{'FromAddress'}{value}[0];
#        		${$self->{MAILER}}->AddReplyto(${$self->FieldData}{'ReplyTo'}{value}[0]);
       		${$self->{MAILER}}{'Subject'} = ${$self->FieldData}{'Subject'}{value}[0];
       		${$self->{MAILER}}{'Host'} = ${$self->FieldData}{'RemoteHost'}{value}[0];
        	if ($self->{MAILER}->Send) 
			{$Success = 1;}
		else
			{
#			die "here $!";
			$self->DumpMail;
			}
		}
	if ($Success) 
		{$main::ActivityLog->AddEntry('sent','mail','to',join (', ',@{$self->{RecipientName}}));}
	else
		{       
		if ($self->SaveMail) 
			{
			$main::ActivityLog->AddEntry('queued','mail','for',join (', ',@{$self->{RecipientName}}));
			$Success = 1;
			}  
		else {die "didn't save mail";}
		}     
	$self->CloseMailer;
	return $Success;
	}   
         
sub SaveMail
	{
	$self = shift;
	my $Success;
	if (!$self->{ExistingMail})
		{
		${$self->FieldData}{TransID}{value}[0] = $main::ActivityLog->TransactionID;
		${$self->FieldData}{Recipients}{value}[0] = $self->RecipientsToString;
		if ($self->AddRecord) {$Success = 1;} 
		else {die "didn't add record";}
		}
	return $Success;
	}                       

sub RetrieveMail
	{ 
	$self = shift;
	my $TransID = $_[0];
	my $Unstuck;
	if ($TransID)
		{
		$self->{ExistingMail} = 1;
		(my @Recipients) = ${$self->FieldData}{Recipients}{value}[0] =~ m{<recipient>(.*?)</recipient>}isg;
		for (@Recipients)
			{
			push @{$self->{RecipientName}}, m{<name>(.*?)</name>}i;
			push @{$self->{RecipientAddress}}, m{<address>(.*?)</address>}i;
			}
		if ($self->SendMail)
			{
			$Unstuck = 1;
			$self->DeleteRecord("TransID=$TransID",$TransID);
			}
		}     
	$self->{ExistingMail} = undef;
	return $Unstuck;
	}

# package end
}        
$MailTable = MailTable->new();   
$MailTable->TableName('MailTable');
$MailTable->Chronological(1);
$MailTable->PrimaryIndex('TransID');
$MailTable->FieldData(
	{
        'TransID'=>
		{
		'type'=>'adVarWChar',
		'size'=>'20',
		'value'=> []		
		},
        'ServerTime'=>
		{
		'type'=>'adInteger',
		'value'=>[]		
		},
        'BodyText'=>
		{
		'type'=>'adLongVarWChar',
		'value'=> []
		},                                    
        'ContentType'=>
		{
		'type'=>'adVarWChar',
		'size'=>'20',
		'value'=> ['text/html']
		},
        'FromName'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=> []
		},  
        'FromAddress'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=> []
		},        
	'ReplyTo'=>
		{
		'type'=>'adVarWChar',
		'size'=>'40',
		'value'=> []
		},
        'Subject'=>
		{
		'type'=>'adVarWChar',
		'size'=>'120',
		'value'=> []
		},                                    
        'RemoteHost'=>
		{
		'type'=>'adVarWChar',
		'size'=>'50',
		'value'=> [$main::Session->{MailServer}]
		},
        'TimeOut'=>
		{
		'type'=>'adUnsignedTinyInt',
		'value'=> ['60']
		},
        'Recipients'=>
		{
		'type'=>'adVarWChar',
		'size'=> '240',
		'value'=> []	
		},                                    
        }
	); 
%>
