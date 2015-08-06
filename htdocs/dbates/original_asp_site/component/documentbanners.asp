<%
sub Banner
{
($DocType) = @_;
#if ($DocType eq 'article')
	{%>
	<table width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td bgcolor="#002060">
				<p style="font-family:Copperplate Gothic Bold;font-size:20pt;color:white;"><%=$DocType%></p>
			</td>
		</tr>
	</table>
	<%}
return
}      
%>