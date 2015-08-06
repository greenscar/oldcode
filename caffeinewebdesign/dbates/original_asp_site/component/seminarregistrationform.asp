<%
sub ShowSeminarForm
	{
	if (($_[0] eq 'event') and ($_[1]))
		{%>
                <form action="/SeminarRegistration.asp" method="post">    
                	<input type="hidden" name="ID" value="<%=$ID%>">
                <table width="90%" border="0" align="center" bgcolor="#EEEEEE">
                        <tr>
                		<td colspan="2" bgcolor="#0000AA">
                			<h2 style="color:white">Register Online</h2>
                		</td>
                	</tr>
                        <tr>
                		<td colspan="2" bgcolor="#DDDDFF">
                			<p>1. Please complete the following information:</p>
                		</td>
                	</tr>
                        <tr>
                		<td align="right">Name</td>
                		<td><input type="text" size="30" name="Name"></td>
                	</tr>
                        <tr>
                		<td align="right">Company</td>
                		<td><input type="text" size="30" name="Company"></td>
                	</tr>
                        <tr>
                		<td align="right">Names of<br>Attendees</td>
                		<td><textarea name="Attendees" wrap="virtual" rows="3" cols="40"></textarea></td>
                	</tr>
                        <tr>
                		<td align="right">Phone</td>
                		<td><input type="text" size="30" name="Phone"></td>
                	</tr>
                        <tr>
                		<td align="right">E-mail</td>
                		<td><input type="text" size="30" name="Email"></td>
                	</tr>
                        <tr>
                		<td colspan="2" bgcolor="#DDDDFF"><p>2. Which session will you be attending?</p>
                		</td>
                	</tr> 
                        <tr>
                		<td></td>
                		<td>
                                        <p><%
					$FirstFlag = 1;
                			for (sort $DocTable->Sessions)
                				{
						if ($_ > time)
							{
							%><input type="radio" name="Session" value="<%=$ScriptingNamespace->PrettyTime($_)%>" <%=$FirstFlag?'checked':''%>><%=$ScriptingNamespace->PrettyTime($_)%><br><%
							undef $FirstFlag;
							}
						}
					%></p>
                                </td>
                	</tr>
                	<tr>
                		<td colspan="2" bgcolor="#DDDDFF">&nbsp;&nbsp;3.&nbsp; <input type="submit" value="Click here to complete registration">
                		</td>
                	</tr>
                </table>                                   
                </form>
        	<%}
	}
%> 