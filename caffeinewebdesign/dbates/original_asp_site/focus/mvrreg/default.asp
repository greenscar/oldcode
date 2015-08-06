<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>  
<%
$Response->Redirect("mvrreg0.asp");
%>