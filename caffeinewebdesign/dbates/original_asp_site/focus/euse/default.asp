<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>  
<%
$Response->Redirect("euse0.asp");
%>