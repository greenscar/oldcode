<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->               
<!--#Include virtual="/component/UWTable.asp"-->                

<%
use Win32API::File;
$UWID = $Request->QueryString('UWID')->{item};
$UWRecord = $UWTable->GetRecord("ID='$UWID'",''); 
$DocRoot = $Server->MapPath('/');                   
$UWRoot = $DocRoot.'/data/uw/'.${$UWTable->FieldData}{'Folder'}{value}[0];
$RecvdFile = $Request->QueryString('id')->{item};
$RecvdFile =~ s{.*?/(\w+\.\w+$)}{$1};
if (-e "$UWRoot/index.xml")
	{
	$DB = Win32::OLE->new('Msxml2.DOMDocument.4.0');
	$DB->load($UWRoot.'/index.xml');
	$FileItem = $DB->selectNodes("/index/item[\@file='$RecvdFile']");
	if ($FileItem) {$FileItem->removeAll();}
	$DB->save($UWRoot.'/index.xml');
	}
$RecvdFilePath = "$UWRoot/$RecvdFile";
if (-e $RecvdFilePath)
	{
	$RecvdFilePath =~ s{/}{\\}g;
	Win32API::File::DeleteFile($RecvdFilePath);
	}
$Response->Redirect("uwpage.asp?id=$UWID");
%>
