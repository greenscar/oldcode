<% @LANGUAGE = PerlScript %>              
<!--#Include virtual="/component/SQLTable.asp"-->  
<!--#Include virtual="/component/ArchiveTable.asp"--> 

<html>
<body> 

<h3>Copy Database</h3>

<li>Tables/Columns</li>
	<ul>
	<%                    
	$SelectionCriteria = '';
	$SourceCatalog = 'dbates';
	$SourceProvider = 'jet';
	$TargetCatalog = 'test';
	$TargetProvider = 'jet';

	$Success = $ArchiveTable->CopyDB($SelectionCriteria, 0, $SourceCatalog, $SourceProvider, 1, $TargetCatalog, $TargetProvider);
	undef $ArchiveTable; 
	%>
	</ul>
	<li><%=$Success%></li>
</body>
</html>