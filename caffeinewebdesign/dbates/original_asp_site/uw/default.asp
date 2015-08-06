<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('uw','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->               
<!--#Include virtual="/component/UWTable.asp"-->                

<%
$UWID = ${$Session->{'Persona'}}[3][1];
$UWRecord = $UWTable->GetRecord("ID='$UWID'",''); 
%>
<html>
<head>
	<title>Durham & Bates Download Area</title> 
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<style>
		td.hdl
			{
			text-align: center;
			empty-cells: show;
			font-family: verdana, helvetica, arial, sans;
			font-size: 10px;
			padding: 2px;
			background-color: #EEEEFF;
			}
		td.dl
			{
			border-right: solid black 1px;
			text-align: center;
			empty-cells: show;
			font-family: verdana, helvetica, arial, sans;
			font-size: 10px;
			padding: 2px;
			}
	</style>
</head>
<body topmargin="0" leftmargin="0">
<!--#Include virtual="/component/PreToc.asp"-->       
<img src="/resource/title.jpg"><br>
<img src="/resource/t_download.gif"><br>
<h4 style="margin-bottom: 0px;">Account: <%=${$UWTable->FieldData}{'Name'}{value}[0]%></h4>

<%                     
$DocRoot = $Server->MapPath('/');                   
$UWRoot = $DocRoot.'/data/uw/'.${$UWTable->FieldData}{'Folder'}{value}[0];
if (-e $UWRoot.'/index.xml')
	{
	$DB = Win32::OLE->new('Msxml2.DOMDocument.4.0');
	$DB->load($UWRoot.'/index.xml');
	$XSL = Win32::OLE->new('Msxml2.DOMDocument.4.0');
	$XSL->load($DocRoot.'/uw/index.xsl');
	$Folder = $XSL->selectSingleNode('//*[@name="Folder"]');
	$Folder->{text} = ${$UWTable->FieldData}{'Folder'}{value}[0];
	$FileItems = $DB->selectNodes('/index/item');
	if ($FileItems->length > 0)
		{
%>
<table style="margin-left: 10px; width: 450px; margin-top: 0px; empty-cells: show;" cellspacing="0">
	<tr>
		<td class="hdl" style="width: 40px;">Date</td>
		<td class="hdl" style="width: 60px;">File</td>
		<td class="hdl" style="width: 40px;">Size</td>
		<td class="hdl">Notes</td>
		<td class="hdl">&nbsp;</td>
	</tr>
<%
               	for ($ItemIndex = -1+$FileItems->length; $ItemIndex >= 0 ; $ItemIndex--)
        		{
        		$FileItem = $FileItems->item($ItemIndex)->getAttribute('file');		
        		if (-e $UWRoot.'/'.$FileItem)
        			{                                       
        			$ThisFile = $FileItems->item($ItemIndex)->transformNode($XSL);
        			$Response->write($ThisFile);
        			}
        		}
		%></table><hr><p>(Due to limitations on our web server storage space, please be sure to delete files once they've been successfully downloaded.  Thanks!)</p><%
		}
	else	{$Response->write("<hr/><p>No Files Found.</p>");}

	}
else	{$Response->write("<hr/><p>No Files Found.</p>");}

%>

<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>