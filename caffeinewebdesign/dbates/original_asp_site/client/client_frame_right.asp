			</td>
			<td width="16" background="resource/divider.gif">&nbsp;</td>
			<td width="144" bgcolor="#004C7A" valign="top" align="center" style="padding-top: 15px;">
				<img src="resource/serviceteam.gif" width="103" height="23"/>
       	                	<%                                              
				%Teams = ('executive'=>'ACCOUNT LEADERS','service'=>'ACCOUNT SERVICE','extended'=>'ADDITIONAL SERVICE RESOURCES');
				for $SubTeam ('executive','service','extended','test')
					{
	                               	$Team = $DB->selectSingleNode("/content/clients/client[\@id='$ClientID']/team[$SubTeam]");
					if ($Team)
						{                                                                                     
						%><br/><p class="toc"><%=$Teams{$SubTeam}%></p><%
		                               	$Members = $DB->selectNodes("/content/clients/client[\@id='$ClientID']/team/$SubTeam/member");
                                               	for ($MemberIndex = 0; $MemberIndex < $Members->{length}; $MemberIndex++)
                                                		{
                                                		$Member = $Members->item($MemberIndex);
                                				$Response->write("<p class='toc'><a class='toc' href='mailto:".$Member->getAttribute('email')."'>> ".$Member->getAttribute('name')."</a><br/><i>".$Member->getAttribute('title')."</i><br/>".$Member->getAttribute('phone')."</p>");
                                                		}
						}
					}
               	                %>                
			</td>

		</tr>
	</table>
</body>
</html>