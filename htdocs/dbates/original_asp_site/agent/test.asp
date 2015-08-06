<%@ LANGUAGE = PerlScript %>    
<html><body>
<%
$UWRoot = $Server->MapPath('/data');
open (TEST, ">$UWRoot\\test.txt") || $Response->write("$!: $UWRoot\\test.txt. (error)<hr/>");
print TEST "hi";
close (TEST);
if (-e "$UWRoot\\test.txt") {$Response->write("file exists");} else {$Response->write("no file written");}
%>
</body></html>