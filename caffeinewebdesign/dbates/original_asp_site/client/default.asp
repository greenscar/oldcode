<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('client','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/ClientTable.asp"-->                
<!--#Include virtual="/component/DocTable.asp"-->                     
<!--#Include virtual="/client/client_frame_left.asp"-->                     
                        	<img src="resource/title.gif" width="394" height="51"/><br/><br/>
                		<h3><p>> Insurance news and resources customized for <i><%=$ClientName%></i>:</p></h3><br/>
				<!--
                        	<p><img src="resource/news.gif" width="157" height="12"/></p><br/>
                              		<%$DocTable->DocList('article',1);%>     
                              		<%$DocTable->DocList('page');%>     
                        	<br/>
				-->

	                	<%
                        	$FAQ = $DB->selectsingleNode("//client[\@id='$ClientID']/faq");
				if ($FAQ)
					{
					$FAQpage = $FAQ->getAttribute('src');
					if ($FAQpage)
        					{
        					%>
        	                        	<p><a href="faq.asp"><img src="resource/faq.gif" border="0" width="157" height="12"/></a></p>
        					<li class='feature'><p><a href="faq.asp">Click here for a customized database of answers to insurance questions.</a></p></li>
                                        	<br/>
        					<%
        					}
					else
        					{
        					%>
        	                        	<p><img src="resource/faq.gif" width="157" height="12"/></p>
        					<li class='feature'><p>&nbsp;Insurance issues database under construction.</p></li>
                                        	<br/>
        					<%
        					}
					}

                        	$Links = $DB->selectNodes("//link[ancestor::global or ancestor::client[\@id='$ClientID']]");
				if ($Links->{length}>0)
					{
					%>
	                        	<p><img src="resource/links.gif" width="157" height="11"/></p><br/>
					<%
                                       	for ($LinkIndex = 0; $LinkIndex < $Links->{length} ; $LinkIndex++)
                                        		{
                                        		$Link = $Links->item($LinkIndex);
                        				$Response->write("<li class='feature'><p>&nbsp;<a target='_new' href='".$Link->getAttribute('source')."'>".$Link->getAttribute('title')."</a> ".$Link->getAttribute('description')."</p></li>");
                                        		}
                	                %>
                                	<br/>
					<%
					}

                        	$Links = $DB->selectNodes("//form[ancestor::global or ancestor::client[\@id='$ClientID']]");
				if ($Links->{length}>0)
					{
					%>
	                        	<p><img src="resource/forms.gif" width="157" height="11"/></p><br/>
					<%
                                       	for ($LinkIndex = 0; $LinkIndex < $Links->{length} ; $LinkIndex++)
                                        		{
                                        		$Link = $Links->item($LinkIndex);
                        				$Response->write("<li class='feature'><p>&nbsp;<a href='".$Link->getAttribute('source')."'>".$Link->getAttribute('title')."</a> ".$Link->getAttribute('description')."</p></li>");
                                        		}
                	                %>
                                	<br/>
					<%
					}
				%>
				<br/>               
<!--#Include virtual="/client/client_frame_right.asp"-->                     