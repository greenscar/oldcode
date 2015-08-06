<%@ LANGUAGE = PerlScript %>   
<html><body>
<h2>Location: <%=${$Request->ServerVariables}{'LOCAL_ADDR'}{item}%> (<%=(${$Request->ServerVariables}{'LOCAL_ADDR'}{item}=='208.55.141.67')?'Verio':'EasyStreet'%>)</h2>
<h2>Session Variables</h2>
<%
use Win32::OLE;
for $ThisKey (keys %{$Session})
	{%><li><%=$ThisKey%>: <%=$Session->{$ThisKey}%></li><%}
%>
<li>Locale: <%=$Session->{'Locale'}%></li>
<li>EnableMail: <%=$Session->{'EnableMail'}%></li>
<li>AvailableHttpsProtocol: <%=$Session->{'AvailableHttpsProtocol'}%></li>
<li>DBType: <%=$Session->{'DBType'}%></li>

<h2>Checking installed XML parser</h2>
<% 

for ('Microsoft.XMLDOM','MSXML.DOMDocument', 'MSXML2.DOMDocument','MSXML2.DOMDocument20', 'MSXML2.DOMDocument.3.0', 'MSXML2.DOMDocument.4.0')
	{
        $thing = $Server->CreateObject($_);
        if ($thing)
        	{%><li><%=$_%> installed</li><%}
        undef $thing;
	}              
%>
<h2>Checking other server objects</h2>
<% 

for ('Persits.Upload.1','SMTPsvg.Mailer')
	{
        $thing = $Server->CreateObject($_);
        if ($thing)
        	{%><li><%=$_%> installed</li><%}
        undef $thing;
	}              
%>

<h2>Getting win2000 Env variables</h2>
<%
for $ThisKey (keys %ENV)
	{
	$Response->write("<li>$ThisKey: $ENV{$ThisKey}</li>");
	}
%>
<h2>Getting Server variables</h2>
<%
use Win32::OLE;
for $ThisKey (Win32::OLE::in $Request->ServerVariables)
	{
	$Response->write("<li>$ThisKey: ".${$Request->ServerVariables}{$ThisKey}{item}."</li>");
	}
%>

</body>
</html>