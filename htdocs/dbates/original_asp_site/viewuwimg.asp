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
$RecvdFilePath = "$UWRoot/$RecvdFile";
if (-e $RecvdFilePath)
	{
	$RecvdFilePath =~ s{/}{\\}g;
	use Win32::OLE::Variant;

	open (IMAGE, "<$RecvdFilePath") || die "$! $RecvdFilePath";
	binmode (IMAGE);
	@FileInfo = stat(IMAGE);
	read (IMAGE, $Image, $FileInfo[7]);
	close(IMAGE);                      
	$ImageVariant = Win32::OLE::Variant->new( VT_UI1, $Image );
	undef $Image;
                           
        $Response->{Buffer} = 1;
	$Response->Clear;
	$Response->{ContentType} = "image/JPEG";
	$Response->AddHeader("Content-Disposition", "inline;filename=$RecvdFile");  
	$Response->BinaryWrite($ImageVariant);           
	$Response->Flush;
	$Response->End;

	undef $ImageVariant;
	undef $Image;
	}
$Response->Redirect("uwpage.asp?id=$UWID");
%>
