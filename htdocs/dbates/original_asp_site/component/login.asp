<% @ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/SQLTable.asp"-->  
<!--#Include virtual="/component/ActivityTable.asp"-->  
<!--#Include virtual="/component/AssociateTable.asp"-->
<!--#Include virtual="/component/ClientTable.asp"-->
<!--#Include virtual="/component/UWTable.asp"-->
<% 
$trace=0;
if ($trace) {$Response->write("<html><body><p>Logging in to $AreaName</p>");}

if ($Session->{'BadTry'} > 20 and $Session->{'BadTry'} < 30) {&DenyAccess('Exceeded connection tries');}
my $AreaName = $Session->{'LoginToArea'};
%AreaNameID =
	(
	public => 0,
	client => 1,
	agent => 2,
	uw => 3
	); 

if (($AreaNameID{$AreaName} == 1) && $trace) {$Response->write("<p>Logging in to $AreaName</p>");}

if ($AreaNameID{$AreaName} eq '') {&DenyAccess('No area target provided');}

# Restrict agent login to local and agent
$IP = $Request->ServerVariables('REMOTE_ADDR')->item;
@ValidIPs = ('69\.30\.125', '65\.13\.144');
for (@ValidIPs)	{$ValidIP += ($IP =~ m{^$_});}

if (($AreaName == 2) && !$ValidIP) {&DenyAccess;}

                             
##### Check identity if it's been submitted #####

if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m{post}i)
	{	
	$AllegedID=uc($Request->Form("AllegedID")->item);        
	$AllegedID=~s{\s}{}sg;
	$AllegedPW=uc($Request->Form("AllegedPW")->item);
	$AllegedPW=~s{\s}{}sg;

        if (($AreaNameID{$AreaName} == 1) && $trace){$Response->write("<p>Checking signin login: $AllegedID/$AllegedPW</p>");}
        if (&CheckPassword) 
        	{$ThisLogin = 'okay';}
        else
        	{&DenyAccess('Improper signin');}
	}

               
##### Or else try getting an identity #####
if ($ThisLogin ne 'okay') {&CheckCookie;}
if ($ThisLogin ne 'okay') {&CheckLogin;}
if ($ThisLogin ne 'okay') {&DenyAccess('Improper login');}

$Session->{'BadTry'} = 0; 

##### Now set persona and area properties #####

my @Persona = @{$Session->{'Persona'}};
# Persona sub array = [login,id,password,name,cookieflag]
# I'd rather save this stuff as hashes, but Session doesn't seem to accept...
if ($AreaName eq 'public')
        {
        $Persona[0] = [$Session->{'SessionID'},'public','public','Public Visitor', 0];
	$Session->{'Persona'} = \@Persona;
        }

if ($AreaName eq 'client')
        {         
	#get client name from recordset
        $Persona[1] = [$Session->{'SessionID'},$AllegedID,${$ClientTable->FieldData}{CryptPW}{value}[0], ${$ClientTable->FieldData}{Name}{value}[0], $CookieFlag];
	if (($AreaNameID{$AreaName} == 1) && $trace) {$Response->write("<p>Client persona set to ".join(', ',@{$Persona[1]})."</p>");}
	$Session->{'Persona'} = \@Persona;
	$Response->Cookies->SetProperty('Item', 'clientDurhamAndBates', "client"); 
	$Response->Cookies('clientDurhamAndBates')->SetProperty('Item', 'PW', ${$ClientTable->FieldData}{CryptPW}{value}[0]);    
	$Response->Cookies('clientDurhamAndBates')->SetProperty('Item', 'ID', $AllegedID);    
	#$Response->Cookies('clientDurhamAndBates')->{Expires} = "December 31, 2010";      
	$ClientTable->NewVisit($AllegedID);
	$ActivityLog->AddEntry('entered','client site','from', $CookieFlag? 'cookie':'signin');
	#if ($Session->{Hits} == 1) {$Response->Redirect('/client/AccountSettings.asp');  exit;}
        }

if ($AreaName eq 'agent')
        {    
	#get agent name from recordset
        $Persona[2] = [$Session->{'SessionID'},$AllegedID,${$AssociateTable->FieldData}{CryptPW}{value}[0], ${$AssociateTable->FieldData}{Name}{value}[0], $CookieFlag];  
	$Session->{'Persona'} = \@Persona;
	$Response->Cookies->SetProperty('Item', 'agentDurhamAndBates', "agent"); 
	$Response->Cookies('agentDurhamAndBates')->SetProperty('Item', 'PW', ${$AssociateTable->FieldData}{CryptPW}{value}[0]);    
	$Response->Cookies('agentDurhamAndBates')->SetProperty('Item', 'ID', $AllegedID);    
	#$Response->Cookies('agentDurhamAndBates')->{Expires} = "December 31, 2010";      
	if ($AreaSecure) {$Response->Cookies('agentDurhamAndBates')->{Secure} = 1;}
       	$ActivityLog->AddEntry('entered','agent site','from', $CookieFlag? 'cookie':'signin');
        }

if ($AreaName eq 'uw')
        {    
        $Persona[3] = [$Session->{'SessionID'},$AllegedID,${$UWTable->FieldData}{CryptPW}{value}[0], ${$UWTable->FieldData}{Name}{value}[0], $CookieFlag];  
	$Session->{'Persona'} = \@Persona;
	$Response->Cookies->SetProperty('Item', 'uwDurhamAndBates', "uw"); 
	$Response->Cookies('uwDurhamAndBates')->SetProperty('Item', 'PW', ${$UWTable->FieldData}{CryptPW}{value}[0]);    
	$Response->Cookies('uwDurhamAndBates')->SetProperty('Item', 'ID', $AllegedID);    
	$Response->Cookies('uwDurhamAndBates')->{Expires} = "December 31, 2010";      
	if ($AreaSecure) {$Response->Cookies('uwDurhamAndBates')->{Secure} = 1;}
       	$ActivityLog->AddEntry('entered','underwriter site','from', $CookieFlag? 'cookie':'signin');
        }
                      
##### Return to from whence we came #####
if (($AreaNameID{$AreaName} == 1) && $trace)
	{
	$Response->write("<p>Success, returning to ".$Session->{'RedirectTarget'}."</p></body></html>");
	exit;
	}

if ($Session->{'RedirectTarget'})
	{
	$Response->Redirect($Session->{'RedirectTarget'});
	exit;
	}
else
	{
	$Response->Redirect('/');
	exit;
	}
################
##### Subs #####

sub CheckCookie
	{
        $AllegedID = $Request->Cookies($AreaName.'DurhamAndBates')->Item('ID');    
        $CryptAllegedPW = $Request->Cookies($AreaName.'DurhamAndBates')->Item('PW');
        if (length($AllegedID)==0)
        	{
		return 0;
		}
        else
                {
                if (&CheckPassword)
                        {
                        $ThisLogin = 'okay';
                        $CookieFlag = 1;		
                        }
                return;
                }
	}

sub CheckLogin
	{

	if ($AreaName eq 'public')
		{
		$ThisLogin = 'okay';
		return;
		}
	elsif ($AreaName eq 'client')
		{
		$Response->Redirect("/signin.asp");
		exit;
		}
	elsif ($AreaName eq 'agent')
		{
		$Response->Redirect("/agent/signin.asp");
		exit;
		}
	elsif ($AreaName eq 'uw')
		{
		$Response->Redirect("/uw/signin.asp");
		exit;
		}
	else
		{
		&DenyAccess('Unable to redirect to login page');
		exit;
		}
	}

sub CheckPassword
	{        
	if (($AreaNameID{$AreaName} == 1) && $trace) {$Response->write("<p>Checking password: $AllegedID/$AllegedPW/$CryptAllegedPW</p>");}

	if (length($AllegedID)<3) 
		{return 0;} # Improper or empty ID
	if ($AreaName eq 'client')
		{return $ClientTable->CheckLogin($AllegedID,$AllegedPW,$CryptAllegedPW);}
	elsif ($AreaName eq 'agent')
		{return ($AssociateTable->CheckLogin($AllegedID,$AllegedPW,$CryptAllegedPW));}
	elsif ($AreaName eq 'uw')
		{return $UWTable->CheckLogin($AllegedID,$AllegedPW,$CryptAllegedPW);}
	else {return 0;}
	}  

sub DenyAccess
	{                          
	($Error) = @_;
	$Session->{'BadTry'}=$Session->{'BadTry'}+1;
	if ($Session->{'BadTry'} > 4)
		{
		$ActivityLog->AddEntry('denied access to',"$AreaName",'because of','improper login');
		%>
		<html>
			<head>
				<style> 
					body
						{
						font-family: verdana, arial; 
						font-weight: bold;
						font-size: 10pt;
						background-color: #FFFFFF;
						color: #000000; 
						}          
				</style>
			</head>
			<body>
				<table border="0" cellspacing="0" cellpadding="5pt" align="center">
					<tr>
						<td  align="center" bgcolor="black">
							<img src="/resource/about.jpg">
						</td>
					</tr>  
					<tr>
						<td  align="center" bgcolor="#AAAACC">
							<h2 style="font-family:verdana,arial;">DBATES.COM control panel</h2>
						</td>
					</tr>
					<tr>
						<td align="center" style="border-bottom: solid black 2px;">
							<h4>CONNECTION ERROR:</h4>
							<p style="color: blue; font-weight: bold;"><%=$Error%></p>
						</td>
					</tr>                         
				</table>
			</body>
		</html>		
		<%
		exit;
		}
	else
		{&CheckLogin;}
	}
%>