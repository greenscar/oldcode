<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('uw','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->               
<!--#Include virtual="/component/UWTable.asp"-->                
<html><body>
<%
use Win32API::File;
$UWID = ${$Session->{'Persona'}}[3][1];
$UWRecord = $UWTable->GetRecord("ID='$UWID'",''); 
$UWRoot = $Server->MapPath('/data/uw/'.${$UWTable->FieldData}{'Folder'}{value}[0]);                   
$RecvdFile = $Request->QueryString('id')->{item};
if (-e "$UWRoot\\index.xml")
	{
	$DB = Win32::OLE->new('Msxml2.DOMDocument.4.0');
	$DB->load("$UWRoot\\index.xml");                
	$FileItem = $DB->selectNodes("/index/item[\@file='$RecvdFile']");
	if ($FileItem->{length} > 0) {$FileItem->removeAll();}
	$DB->save("$UWRoot\\index.xml");
	open(TEST, ">$UWRoot\\test.file");
	print TEST "hi";
	close (TEST);
	}
$RecvdFilePath = "$UWRoot\\$RecvdFile";
if (-e $RecvdFilePath) {Win32API::File::DeleteFile($RecvdFilePath);}                      
$Response->Redirect("default.asp");
%>
</body></html>
