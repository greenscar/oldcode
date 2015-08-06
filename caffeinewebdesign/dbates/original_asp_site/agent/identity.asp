<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<% &CheckAccount('agent','1'); %>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/AssociateTable.asp"-->                
<!--#Include virtual="/component/ActivityTable.asp"-->                
<%

if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m{get}i)
        {
	$AssociateRecords = $AssociateTable->GetRecord('Active=1','Name');                    
        $NoneOptionString = "<option value='!'> None</option>\n";
        $AllOptionString = $NoneOptionString;
        $DeptOutsideOptionString = $NoneOptionString;
        $DeptCommercialOptionString = $NoneOptionString;
        $DeptPersonalOptionString = $NoneOptionString;
        $DeptMarineOptionString = $NoneOptionString;
        $DeptProfProgOptionString = $NoneOptionString;
        $DeptLCOptionString = $NoneOptionString;

	while ($index < $AssociateRecords)
		{
		$AllOptionString .= "\t\t\t\t<option value='${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";
		@DeptCode = 
			(
			${$AssociateTable->FieldData}{DeptCommercial}{value}[$index],
			${$AssociateTable->FieldData}{DeptPersonal}{value}[$index],
			${$AssociateTable->FieldData}{DeptMarine}{value}[$index],
			${$AssociateTable->FieldData}{DeptProfProg}{value}[$index],
			${$AssociateTable->FieldData}{DeptOutside}{value}[$index]
			);
		if ($DeptCode[0]) {$DeptCommercialOptionString .= "\t\t\t\t<option value='${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";}
		if ($DeptCode[1]) {$DeptPersonalOptionString .= "\t\t\t\t<option value='${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";}
		if ($DeptCode[2]) {$DeptMarineOptionString .= "\t\t\t\t<option value='${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";}
		if ($DeptCode[3] or $DeptCode[0]) {$DeptProfProgOptionString .= "\t\t\t\t<option value='${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";}
		if ($DeptCode[4]) {$DeptOutsideOptionString .= "\t\t\t\t<option value='${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";}
		if ($DeptCode[0] or $DeptCode[1] or $DeptCode[3]) {$DeptLCOptionString .= "\t\t\t\t<option value='${$AssociateTable->FieldData}{ID}{value}[$index]'>${$AssociateTable->FieldData}{Name}{value}[$index]</option>\n";}

		if (${$AssociateTable->FieldData}{Role}{value}[$index] =~ m{webmaster}i)
			{$Webmaster = ${$AssociateTable->FieldData}{ID}{value}[$index];}
		if (${$AssociateTable->FieldData}{Role}{value}[$index] =~ m{dbmonitor}i)
			{$DBMonitor = ${$AssociateTable->FieldData}{ID}{value}[$index];}
		if (${$AssociateTable->FieldData}{Role}{value}[$index] =~ m{clcsr}i)
			{push @CLPool, ${$AssociateTable->FieldData}{ID}{value}[$index];}
		if (${$AssociateTable->FieldData}{Role}{value}[$index] =~ m{plcsr}i)
			{push @PLPool, ${$AssociateTable->FieldData}{ID}{value}[$index];}
		if (${$AssociateTable->FieldData}{Role}{value}[$index] =~ m{cmcsr}i)
			{push @CMPool, ${$AssociateTable->FieldData}{ID}{value}[$index];}
		if (${$AssociateTable->FieldData}{Role}{value}[$index] =~ m{lccsr}i)
			{push @LCPool, ${$AssociateTable->FieldData}{ID}{value}[$index];}
		if (${$AssociateTable->FieldData}{Role}{value}[$index] =~ m{prcsr}i)
			{push @PRPool, ${$AssociateTable->FieldData}{ID}{value}[$index];}
		$index++
		}
        %>
        <html><head>
        <title>Mail Monitors</title>
        <link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
        </head>                                                   
        <body>
        <form action="identity.asp" method="post">            
        <table border="0" width="80%" cellspacing="0" cellpadding="5pt" bgcolor="#EFEFEF" align="center">                                     
        	<tr>
        		<td align="center" colspan="2">
        			<h1>Mail Monitors</h1>
        		</td>
        	</tr>             
        	<tr bgcolor="#DDDDFF" align="top">
        		<td>
                		<b>Webmaster</b><br>  
        			<%
        			$DeptOutsideOptionString =~ s{(<option value='$Webmaster')}{$1 selected}isg;
        			%>
                		<select name="Webmaster">
        				<%=$DeptOutsideOptionString%>
        			</select>
        		</td>
        		<td> 
                		<b>D&B Site Monitor</b><br>
        			<%
        			$AllOptionString =~ s{(<option value='$DBMonitor')}{$1 selected}isg;
        			%>
                		<select name="DBMonitor">
        				<%=$AllOptionString%>
        			</select>
        		</td>
        	</tr>
        	<tr bgcolor="#D0D0D0">
        		<td colspan="2">&nbsp;
        		</td>
        	</tr> 
        	<tr bgcolor="#DDDDFF" align="top">
        		<td>
        		<b>Commercial Lines</b>
        		</td>
        		<td> 
			<%
			for ($index=1;$index<=3;$index++)
				{
				$This = $DeptCommercialOptionString;
				if (length($CLPool[$index-1])>1)
					{$This =~ s{(<option value='$CLPool[$index-1]')}{$1 selected}isg;}
				%>
		        	<select name="CLPool<%=$index%>"><%=$This%></select><br>
				<%			
				}
			%>
        		</td>
        	</tr>     
        
        	<tr bgcolor="#D0D0D0" align="top">
        		<td>
        		<b>Program Business</b>
        		</td>
        		<td> 
			<%
			for ($index=1;$index<=3;$index++)
				{
				$This = $DeptProfProgOptionString;
				if (length($PRPool[$index-1])>1)
					{$This =~ s{(<option value='$PRPool[$index-1]')}{$1 selected}isg;}
				%>
		        	<select name="PRPool<%=$index%>"><%=$This%></select><br>
				<%			
				}
			%>
        		</td>
        	</tr>     
        
        	<tr bgcolor="#DDDDFF" align="top">
        		<td>
        		<b>Light Commercial</b>
        		</td>
        		<td> 
			<%
			for ($index=1;$index<=3;$index++)
				{
				$This = $DeptLCOptionString;
				if (length($LCPool[$index-1])>1)
					{$This =~ s{(<option value='$LCPool[$index-1]')}{$1 selected}isg;}
				%>
		        	<select name="LCPool<%=$index%>"><%=$This%></select><br>
				<%			
				}
			%>
        		</td>
        	</tr> 
        
        	<tr bgcolor="#D0D0D0" align="top">
        		<td>
        		<b>Personal Lines</b>
        		</td>
        		<td> 
			<%
			for ($index=1;$index<=3;$index++)
				{
				$This = $DeptPersonalOptionString;
				if (length($PLPool[$index-1])>1)
					{$This =~ s{(<option value='$PLPool[$index-1]')}{$1 selected}isg;}
				%>
		        	<select name="PLPool<%=$index%>"><%=$This%></select><br>
				<%			
				}
			%>
        		</td>
        	</tr> 

        	<tr bgcolor="#DDDDFF" align="top">
        		<td>
        		<b>Marine</b>
        		</td>
        		<td> 
			<%
			for ($index=1;$index<=3;$index++)
				{
				$This = $DeptMarineOptionString;
				if (length($CMPool[$index-1])>1)
					{$This =~ s{(<option value='$CMPool[$index-1]')}{$1 selected}isg;}
				%>
		        	<select name="CMPool<%=$index%>"><%=$This%></select><br>
				<%			
				}
			%>
        		</td>
        	</tr>  
        
        	<tr>
        		<td colspan=2 align="center">
        			<hr>
        			<input type="submit"  value="Update Addresses">&nbsp;
        			<input type="button"  value="Done" onClick="location.href='cpmain.asp'">    
        		</td>
        	</tr>
        </table>
        </form>
        </body>
	</html>
	<%
	}

if ($Request->ServerVariables('REQUEST_METHOD')->item =~ m{post}i)
        {
	$AssociateRecords = $AssociateTable->GetRecord('Active=1','Name');                    
	while ($index<$AssociateRecords)
		{
		$ID{${$AssociateTable->FieldData}{ID}{value}[$index]} = $index;
		${$AssociateTable->FieldData}{Role}{value}[$index] = '';
		$index++;
		}
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'Webmaster'}{item}}] .= 'webmaster ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'DBMonitor'}{item}}] .= 'dbmonitor ';

	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'CLPool1'}{item}}] .= 'clcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'CLPool2'}{item}}] .= 'clcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'CLPool3'}{item}}] .= 'clcsr ';

	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'PLPool1'}{item}}] .= 'plcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'PLPool2'}{item}}] .= 'plcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'PLPool3'}{item}}] .= 'plcsr ';

	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'CMPool1'}{item}}] .= 'cmcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'CMPool2'}{item}}] .= 'cmcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'CMPool3'}{item}}] .= 'cmcsr ';

	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'LCPool1'}{item}}] .= 'lccsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'LCPool2'}{item}}] .= 'lccsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'LCPool3'}{item}}] .= 'lccsr ';

	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'PRPool1'}{item}}] .= 'prcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'PRPool2'}{item}}] .= 'prcsr ';
	${$AssociateTable->FieldData}{Role}{value}[$ID{${$Request->Form}{'PRPool3'}{item}}] .= 'prcsr ';
        if ($AssociateTable->UpdateRecord(['Role','Name'],'Active=1','Name'))
		{push @Alert, $ActivityLog->AddEntry('changed','mail monitor settings','in','AssociateTable');}
	else
		{push @Alert, "Database error";}
        %>			
        <html><head>
        <script language="javascript">
        <!--
        location.href="cpmain.asp";
	<% for (@Alert) {%>alert('<%=$_%>');<%}%>	
        //-->
        </script>
        </head></html>
        <%
}
%>