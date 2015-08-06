<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>                
<html>
<head>
<base target="main">
<script language="javascript">
<!--                          
function GotoHelp()
	{
	MainFrame=window.parent.main.location.hash; 
	if (MainFrame=="#help")
		{Anchor='#top';}
	else
		{Anchor='#help';}
	window.parent.main.location.hash=Anchor;		
	}
//-->
</script>
</head>
<body bgcolor="EEEEEE">
<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">
	<tr valign="center">
		<td align="CENTER">
			<a href="cpmain.asp"><img border="0" src="/agent/document/resource/tabcontrol.jpg" alt="Return to agent control panel"></a>&nbsp;
			<a href="suggest.asp"><img border="0" src="/agent/document/resource/tabidea.jpg" alt="Send comment/suggestion"></a>&nbsp;
			<a href="/" target="_top"><img border="0" src="/agent/document/resource/tabpublic.jpg" alt="View the main www.dbates.com website"></a>
			<a onClick="GotoHelp()"><img border="0" src="/agent/document/resource/tabhelp.jpg" alt="Toggles on/off help information"></a></td>
	</tr>
</table>
</body>
</html> 
<%

%>