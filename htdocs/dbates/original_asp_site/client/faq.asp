<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('client','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/ClientTable.asp"-->                
<!--#Include virtual="/component/DocTable.asp"-->                     
<!--#Include virtual="/client/client_frame_left.asp"-->                     
                        	<img src="resource/title.gif" width="394" height="51"/><br/><br/>
                		<h3><p>> Insurance news and resources customized for <i><%=$ClientName%></i>:</p></h3><br/>
                        	<p><img src="resource/faq.gif" width="157" height="12"/></p>
				<%
                        	$FAQ = $DB->selectsingleNode("//client[\@id='$ClientID']/faq")->getAttribute('src');
				open (FAQ, "<$DocRoot$FAQ");
				@FileInfo = stat(FAQ);
				read (FAQ, $FAQ, $FileInfo[7]);
				close (FAQ);
				$Response->write($FAQ);
				%>
				<br/>               
<!--#Include virtual="/client/client_frame_right.asp"-->