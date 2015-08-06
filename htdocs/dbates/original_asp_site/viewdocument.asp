<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"-->  
<%
$ID = ${$Request->QueryString}{ID}{item};
$DocTable->GetRecord("ID='$ID'",'');
%>
<!--#Include virtual="/component/Redirect.asp"-->
<%                  
$Access = ${$DocTable->FieldData}{Access}{value}[0]?'client':'public';
&CheckAccount($Access,'0');  
$FileLocation = $Server->MapPath(${$DocTable->FieldData}{Location}{value}[0]);
@FileInfo = stat($FileLocation);
open (DOCUMENT, '<'.$FileLocation) || die $FileLocation;
read (DOCUMENT, $DocumentFile, $FileInfo[7]);
close (DOCUMENT);
%>
<%=$DocumentFile =~ m{(<html>.*?)<body}is%>
<body topmargin="0" leftmargin="0">
	<!--#Include virtual="/component/PreToc.asp"--> 
        	<!--#Include virtual="/component/DocumentBanners.asp"-->
        	<%=Banner(${$DocTable->FieldData}{DocType}{value}[0])%>
        	<%=$DocumentFile =~ m{<body.*?>(.*?)</body>}is%>
        	<!--#Include virtual="/component/SeminarRegistrationForm.asp"-->
        	<%ShowSeminarForm(${$DocTable->FieldData}{DocType}{value}[0],${$DocTable->FieldData}{IsSeminar}{value}[0]);%>
	<!--#Include virtual="/component/MidToc.asp"-->
	<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>
<%
undef $DocumentFile;
%>
