<% @LANGUAGE = PerlScript %>              
<!--#Include virtual="/component/SQLTable.asp"-->  
<!--#Include virtual="/component/ArchiveTable.asp"--> 
<%
$CatalogName = $ArchiveTable->CatalogName($Request->QueryString('catalog')->item|| 'dbates');
$Provider = $ArchiveTable->Provider($Request->QueryString('provider')->item|| $Session->{DBType});
%>

<html>
<body> 

<h3>Verify Database System</h3>
<li>Database</li>
	<ul>
		<li>Running <b><%=$Provider%></b> database engine</li>
		<li>Using catalog <b><%=$CatalogName%></b></li>
		<%
		if (!$ArchiveTable->GetConnection)
			{
				{
        			%>
        			<ul><li>Need to create database file...
        			<%
        			if ($ArchiveTable->CreateDatabase) 
        				{
					$Response->write('done.');
					} 
        			else 
        				{
        				$Response->write('error.');
        				}
        			%>
        			</li></ul>
        			<%
        			}
			}
        			%>
		<li>Connection state: <%=$ArchiveTable->GetConnection%></li>

	</ul>

<li>Tables/Columns</li>
	<ul>
	<%
	$ArchiveTable->VerifyColumns('ArchiveTable');%>
        
        <!--#Include virtual="/component/ActivityTable.asp"--> 
        <%
	$ArchiveTable->VerifyColumns('ActivityLog');
	undef $ActivityLog;
	%>
        
        <!--#Include virtual="/component/AssociateTable.asp"-->
        <%
	$ArchiveTable->VerifyColumns('AssociateTable');
	undef $AssociateTable;
	%>
        
        <!--#Include virtual="/component/ClientTable.asp"--> 
        <%
	$ArchiveTable->VerifyColumns('ClientTable');
	undef $ClientTable;
	%>
        
        <!--#Include virtual="/component/DocTable.asp"-->  
        <%
	$ArchiveTable->VerifyColumns('DocTable');
	undef $DocTable;
	%>
          
        <!--#Include virtual="/component/LinkTable.asp"--> 
        <%
	$ArchiveTable->VerifyColumns('LinkTable');
	undef $LinkTable;
	%>
        
        <!--#Include virtual="/component/MailTable.asp"--> 
        <%
	$ArchiveTable->VerifyColumns('MailTable');
	undef $MailTable;
	%>
        
        <!--#Include virtual="/component/SubmissionTable.asp"-->  
        <%
	$ArchiveTable->VerifyColumns('SubmissionTable');
	undef $SubmissionTable;

	undef $ArchiveTable; 
	%>

	</ul>
</body>
</html>