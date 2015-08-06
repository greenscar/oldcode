<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<!--%&CheckAccount('public','0');%-->
<html>
<head>
	<title>Welcome to Durham and Bates</title>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<meta name="keywords" content="Durham, Bates, Durham and Bates, Durham & Bates, Durham &amp; Bates, insurance, risk, management, consult, portland, oregon, washington, specialist, coverage, business, commercial, professional, marine, personal, property, casualty, liability, shipping">
	<script language="javascript">
	window.name='dbmain';
	<!--    
	function PopUp()

		{
                <%
                if (($Request->Cookies('publicDurhamAndBates')->Item('POPUP') =~ m{off}isg) or ($Session->{PopUp}))
                	{
			%>
			return 0;
			<%
			}  
                else 
                	{
                	if (-e $Server->MapPath('/promote.asp'))
                		{
                		%>		
                		window.open("promote.asp","PopUp","resizeable=yes,width=320,height=200");
				return 1;
                		<%		
                		}
                	}
                %>
		}
	//-->
	</script>
</head>
<body topmargin="0" leftmargin="0" onLoad="PopUp();">
<!--#Include virtual="/component/PreToc.asp"-->
	<img src="/resource/title.gIF" ><br>
	<img src="/resource/t_welcome.jpg">
	<P style="margin-left:20pt;margin-right:20pt;margin-top:10pt;">Since 1907, Durham and Bates has endured as the foremost risk management experts in the West. Our mission is to partner with customers to ensure their success. Today, we are an expanding, multi-lined consulting brokerage offering risk management to a wide range of industries. Durham and Bates is employee-owned; each associate excels in providing the highest quality service and knowledge found anywhere.</P>
	<P style="margin-left:20pt;margin-right:20pt;">DURHAMANDBATES.COM will contribute to the success of your enterprise as a round the clock online resource tool for your business needs. Use this site to research your industry's news, register for a Durham and Bates seminar, file a claim, order an MVR, review your account, learn fundamentals of risk management, explore our rich northwest history, or benefit from our customer resources.  Whatever you choose, we're very glad you're here.</P>
	<P style="margin-left:20pt;margin-right:20pt;margin-top:10pt;"><a href="/services"><img src="/resource/homepics.jpg" border="0" alt="Go To Durham and Bates Services"></a></p>
<!--#Include virtual="/component/MidToc.asp"-->
        <center>
        <p style="font-size:8pt;font-family:arial;">
        &copy; 2000 Durham and Bates Agencies Inc.<br>
        <a href="privacy.asp">Privacy Statement</a>
        </p>
        </center>
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>
