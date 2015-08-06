<%
sub CheckAccount
	{
	(my $AreaName, $AreaSecure) = @_;  
	%AreaNameID =
		(
		public => 0,
		client => 1,
		agent => 2,
		uw => 3
		);
	$Session->{'LoginToArea'} = $AreaName;
	$Target=$Request->{ServerVariables}->{'SCRIPT_NAME'}->{item};
	$QueryString = $Request->{ServerVariables}->{'QUERY_STRING'}->{item};
	if ($QueryString) {$Target.='?'.$QueryString;}

        ###### Check entry point and redirect if neccessary
        $SecureStatus = $Request->ServerVariables('HTTPS')->item =~ m{on}is; 
        $HostAddress = lc($Request->ServerVariables('HTTP_HOST')->item);
	if ($HostAddress ne 'www.dbates.com')
		{
		$HostAddress = 'www.dbates.com';
		$Redirect=1;
		}   
        if ($Session->{'Locale'})
        	{
        	if ($AreaSecure)
        		{                                                  
        		$HttpProtocol = $Session->{AvailableHttpsProtocol};
        		if (!$SecureStatus and ($HttpProtocol eq 'https://'))
        			{
				$Redirect = 1;
				}
        		}
        	else
        		{
        		$HttpProtocol = 'http://';
        		if ($SecureStatus)
        			{
				$Redirect = 1;
				}
        		}
		}
        else 
        	{
        	$HttpProtocol = 'http://';
        	}

	$FullTarget = $HttpProtocol.$HostAddress.$Target;

	if (${$Session->{'Persona'}}[$AreaNameID{$AreaName}][0] ne $Session->{'SessionID'})
		{                                                                          
		$Session->{'RedirectTarget'} = $FullTarget;
		$Response->Redirect('/component/login.asp');
		exit;
		}

        if ($Redirect) 
		{
		$Response->Redirect($FullTarget);
		}
	else 
		{
		my @Persona = @{$Session->{'Persona'}};
        	if ($Persona[$AreaNameID{$AreaName}][4])
                        {
        		$Persona[$AreaNameID{$AreaName}][4] = 0;	
        		$Session->{'Persona'} = \@Persona;
                	if ($AreaName eq 'client')
                		{$SigninPage = "/signin.asp";}
			else
                		{$SigninPage = "/$AreaName/signin.asp";}
                        %>
			<html><head>
                        <script language="javascript">
                        <!--
                        Identity = confirm("Currently logged in as <%=${$Session->{'Persona'}}[$AreaNameID{$AreaName}][3]%>.  Continue under this identity?  (Click CANCEL to log in again.)");
                        if (!Identity)
                        	{top.location.href='<%=$SigninPage%>';}
                        //-->
                        </script>
			</head></html>
                        <%
                        }
       		} 
	}         

sub ConfirmPrivacy2
	{
	if (!$Session->{Privacy})
		{                     
		$Response->Redirect('/privacy.asp?confirm=1');
		exit;
		}
	else
		{
		$Response->Redirect($Session->{'RedirectTarget'});
		}
	}

sub ConfirmPrivacy
	{
	if (!$Session->{Privacy})
		{                     
		$Session->{'RedirectTarget'} = $FullTarget;
		$Response->Redirect('/privacy.asp?confirm=1');
		exit;
		}
	}

sub Debug
	{
	(my $Comment) = @_;
	%>
	<html><body><h2><%=$Comment%></h2></body</html>
	<%
	return 0;
	}
%>
