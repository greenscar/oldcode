<% @Language="PerlScript"%>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>  
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/AssociateTable.asp"-->               
<%      
sub GetRole
	{                           
	$RoleID = $_[0]; 
	$index=0;
	my $RoleRecords = $AssociateTable->GetRecord(qq{Role LIKE '%$RoleID%'},'');	
        while ($index<=$RoleRecords)
		{
                %>
        	<p style="margin-left:0pt;">
		<a href="mailto:<%=${$AssociateTable->FieldData}{'Email'}{value}[$index]%>"><%=${$AssociateTable->FieldData}{'Name'}{value}[$index]%></a><br>
                <%=${$AssociateTable->FieldData}{'Title'}{value}[$index]%></p>
        	<% 
		$index++;  
		}
	}
%>

<html>
	<head> 
		<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, commercial, business, coverage, liability, property, auto, technology, internet, email, e-mail, employee, hiring">
        	<title>Durham & Bates Technology Division</title>
		<style>
			body
				{
				MARGIN: 0pt;
				COLOR: #000000;
				FONT-FAMILY: verdana,arial;     
				BACKGROUND-COLOR: #063D6E;
				}                         
			p
				{
				font-size: 9pt;
				text-align:justify;
				margin: 8pt;
				}
			#nav
				{              
				font-size: 8pt;
				color: white;
				text-decoration: none;
				font-weight: bold;           
				margin: 2pt;
				}
		</style>    
	<script language="javascript">
	window.name='dbmain';
	<!--    
	function PopUp()
		{
                <%
                if (($Request->Cookies('publicDurhamAndBates')->Item('POPUP') =~ m{off}isg))
                	{     
			%>
			return 0;
			<%
			}  
                else 
                	{
                	if (-e $Server->MapPath('/services/tech/promote.asp'))
                		{
                		%>		
                		window.open("promote.asp","PopUp","resizeable=yes,width=320,height=240");
				return 1;
                		<%		
                		}
                	}
                %>
		}
	//-->
	</script>
	</head>
	<body onLoad="PopUp();">
		<table width="640px" align="center" border="2pt" bordercolor="black" cellspacing="0pt" cellpadding="0pt"><tr><td>
		<table width="632px" align="center" border="0pt" bordercolor="black" cellspacing="0pt" cellpadding="0pt">
			<tr bgcolor="white">            
				<td background="trim.gif" width="11px" style="margin:0px;">&nbsp;</td>				
				<td align="left" width="295px" valign="bottom">
					<img src="title.jpg" style="margin-left:10pt">
				</td>
				<td bgcolor="black" align="center" width="326px" valign="bottom">
					<a id="nav" href="/">HOME</a>
					<img src="spacer.gif" height="12pt">					   
					<a id="nav" href="/services">SERVICES</a>
					<img src="spacer.gif" height="12pt">					   
					<a id="nav" href="/about/news.asp">NEWS</a>                               
					<img src="spacer.gif" height="12pt">					   
					<a id="nav" href="/sitemap.asp">SITEMAP</a>
				</td>
			</tr>
			<tr bgcolor="black">
				<td colspan="3"><img src="tech1.jpg"></td>
			</tr>
			<tr bgcolor="white">
				<td background="trim.gif" width="11px" style="margin:0px;">&nbsp;</td>
				<td colspan="2">
                                        <p><b style="font-size:110%">T</b>echnology companies are very much in a separate realm from other traditional "old economy" companies.  Today's technology companies thrive on innovation and change in a fast-paced environment where time is a limited and extremely valuable commodity.</p>
                                        <p>With the new opportunities afforded by technology come a new set of risks.  Factors such as Intellectual Property liability and protection create significant risk in an industry that is rapidly changing related products and services, such as software and hardware upgrades and revolving competitors.</p>
                                        <p>Technology firms staff is typically spread extremely thin.  It is imperative that management focus on the opportunities of their business as well as the risk.  Durham & Bates Technology Team has positioned itself to provide valuable risk management expertise, which allows management to focus on growing the business.</p>
                                        <p>Durham & Bates Technology professionals assist clients in managing risk such as Software/Hardware Errors & Omissions, Copyright/Trademark/Patent Infringement, Internet and Media risk, Employment Practices Liability, Directors & Officers Liability, among other more traditional risks.</p>

					<%
					if (($Request->Cookies('publicDurhamAndBates')->Item('PopUp') =~ m{off}) and (-e $Server->MapPath('/services/tech/promote.asp')))
						{
						%>
						<hr width="90%" color="gray" size="1pt">
						<a href="/ViewDocument.asp?ID=tech" target="_new" style="font-size:10pt;">
							<img src="tech.jpg" align="left" style="margin:10pt" border="4pt">
						</a>
						<p><b>Upcoming Seminars:</b></p>
						<ul>
							<li>
								<a href="/ViewDocument.asp?ID=tech" target="_new" style="font-size:10pt;">Technology @ Work: Security & Employment Issues in the Digital Age</a>
							</li>
						</ul>
						<br clear="left">
						<%
						}
					%>  

					<hr width="90%" color="gray" size="1pt">
					<p><b>Durham & Bates Technology Team</b></p>
					<ul>
                                                <%              
        					&GetRole('tech');
						%>
					</ul>     

					<hr width="90%" color="gray" size="1pt">
					<p><b>Related Articles and Resources</b></p>  
					<ul>
						<li><p><a href='/focus/euse'>Addressing Employee Internet and E-Mail Use</a></p></li>
					</ul>
				</td>
			</tr>                 
			<tr bgcolor="#063D6E">
				<td colspan="3" height="8pt"></td>
			</tr>
			<tr bgcolor="black">
				<td colspan="3" align="center">       
					<a href="/disclaim.asp" style="color:white;font-size:8pt;">Copyright 2001 Durham & Bates Agencies, Inc.</a>
				</td>
			</tr>
		</table>
		</td></tr></table>
	</body>
</html>