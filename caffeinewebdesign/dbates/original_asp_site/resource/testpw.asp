<%@ LANGUAGE = PerlScript %>           
<%
$PW1 = crypt('ENIRAM04','WM');
$PW2 = crypt('ERINAM04','WM');
%>
<html><body><%=$PW1%>/<%=$PW2%></body></html>

