<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>  
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/AssociateTable.asp"-->               
<%
$AssociateRecords = $AssociateTable->GetRecord("Active=1 and DeptOutside=0",'');
while ($index < $AssociateRecords)
        {
	(@NameUnits) = ${$AssociateTable->FieldData}{'Name'}{value}[$index] =~ m{(\w+)}g;
	$NameIndex = pop @NameUnits;
	$AgentName{$NameIndex}=${$AssociateTable->FieldData}{'Name'}{value}[$index];
	$AgentPhone{$NameIndex}=${$AssociateTable->FieldData}{'DirectLine'}{value}[$index];
	$AgentFax{$NameIndex}= ${$AssociateTable->FieldData}{'Fax'}{value}[$index];
	$AgentEmail{$NameIndex}=${$AssociateTable->FieldData}{'Email'}{value}[$index];
        if (${$AssociateTable->FieldData}{'DeptAgency'}{value}[$index])
		{
		if ($DeptName{$NameIndex}) {$DeptName{$NameIndex}.=" &#149; ";}
		$DeptName{$NameIndex}.="Agency Services";
		}
        if (${$AssociateTable->FieldData}{'DeptCommercial'}{value}[$index])
		{
		if ($DeptName{$NameIndex}) {$DeptName{$NameIndex}.=" &#149; ";}
		$DeptName{$NameIndex}.="Commercial Lines";
		}
        if (${$AssociateTable->FieldData}{'DeptMarine'}{value}[$index])
		{
		if ($DeptName{$NameIndex}) {$DeptName{$NameIndex}.=" &#149; ";}
		$DeptName{$NameIndex}.="Marine";
		}
        if (${$AssociateTable->FieldData}{'DeptPersonal'}{value}[$index])
		{
		if ($DeptName{$NameIndex}) {$DeptName{$NameIndex}.=" &#149; ";}
		$DeptName{$NameIndex}.="Personal Lines";
		}
        if (${$AssociateTable->FieldData}{'DeptProfProg'}{value}[$index])
		{
		if ($DeptName{$NameIndex}) {$DeptName{$NameIndex}.=" &#149; ";}
		$DeptName{$NameIndex}.="Professional";
		}
        if (${$AssociateTable->FieldData}{'DeptConsult'}{value}[$index])
		{
		if ($DeptName{$NameIndex}) {$DeptName{$NameIndex}.=" &#149; ";}
		$DeptName{$NameIndex}.="Business Consulting";
		}
        if (${$AssociateTable->FieldData}{'DeptOutside'}{value}[$index])
		{
		$DeptName{$NameIndex}.="Agency Services";
		}
        $AgentTitle{$NameIndex} = ${$AssociateTable->FieldData}{'Title'}{value}[$index];
        $AgentTitle{$NameIndex} =~ s{,}{<br>}g; 
	$index++;
	} 
%>
<html>
<head>
	<title>Durham and Bates - Office Directory </title>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, directory, contact, phone, email">
	<script type="text/javascript">
	<!--
	var otliam = "<a href='&#109;&#97;&#105;&#108;&#116;&#111&#58;";
	var ta = "&#64;";
	//-->
	</script>
</head>
<body topmargin="0" leftmargin="0">
<!--#Include virtual="/component/PreToc.asp"-->
        <img src="/resource/title.jpg" ><br>
        <img src="/resource/t_contact.jpg">
        <br><br>
        <table cellspacing="2pt" cellpadding="0" align="center" width="90%">
        <% 
        $Response->flush;	       
        for (sort {$a cmp $b} keys %AgentName)
                {%>
        	<tr>
        		<td colspan="2" valign="top" id="directory" style="padding-top: 5px; border-bottom: solid black 1px;">
        		        <b><%=$AgentName{$_}%> &#149; <font color="navy"><%=$DeptName{$_}%></font></b>
        		</td>
                </tr>
                <tr>			
        		<td width="300px" valign="top" id="directory" style="border-left: solid #cccccc 1px; padding-left: 10px;"><%=$AgentTitle{$_}%></td>
        		<td width="200px" valign="top" id="directory">
					<%($Name,$Domain) = split(m{@},$AgentEmail{$_});%>
					<script type="text/javascript">
        					<!--
						document.write(otliam+"<%=$Name%>"+ta+"<%=$Domain%>'><name><%=$Name%></name>"+ta+"<domain><%=$Domain%></domain>");
						//-->
					</script>
					</a><br/>
        				<%=$AgentPhone{$_}%> direct line<br>
        				<%=$AgentFax{$_}%> fax
        		</td>
                  </tr>  
                <% 
                $Response->flush;	
                } 
        %>                 
	</table>
<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>

