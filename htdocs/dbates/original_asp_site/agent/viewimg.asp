<% @Language = "PerlScript" %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->               
<!--#Include virtual="/component/UWTable.asp"-->                
<!--#Include virtual="/component/DocTable.asp"-->                

<%
%ContentType = 
	{ 
	'jpg' => 'image/jpeg',
	'jpeg' => 'image/jpeg',
	'tif' => 'image/tiff',
	'tiff' => 'image/tiff',
	'doc' => 'application/msword',
	'xls' => 'application/x-msexcel',
	'zip' => 'application/x-zip-compressed'
	};
$UWID = $Request->QueryString('UWID')->{item};
$UWRecord = $UWTable->GetRecord("ID='$UWID'",''); 
$UWRoot = '/data/uw/'.${$UWTable->FieldData}{'Folder'}{value}[0];
$RecvdFile = $Request->QueryString('id')->{item};
$RecvdFile =~ s{.*?/(\w+\.\w+$)}{$1};
($ext) = $RecvdFile =~ m{\.(.*?)$};
$RecvdFilePath = $Server->MapPath("$UWRoot/$RecvdFile");
if (-e $RecvdFilePath)
	{                  
	$objStream = $Server->CreateObject("ADODB.Stream");
	$objStream->Open();
	$objStream->{Type}=1;
	$objStream->LoadFromFile($RecvdFilePath);

        $Response->{Buffer} = 1;
	$Response->Clear();
#	$Response->{ContentType}=$ContentType{$ext};
	$Response->{ContentType}="application/octet-stream";
	$Response->AddHeader("content-disposition","attachment; filename=$RecvdFile");
	$Response->AddHeader("Content-Transfer-Encoding","binary");
#	$Response->{CharSet} = "UTF-8";
	$Response->BinaryWrite($objStream->read()); 
	$objStream->close();
	undef $objStream;
                           
	$Response->Flush;
	$Response->End;
	}
%>
