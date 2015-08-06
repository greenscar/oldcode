<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>                
<html>
<head>
	<title>The Other Control Panel</title>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
</head>
<body>
<a name="top"></a>

<table width="95%" align="center" bgcolor="#FFFFFF" cellspacing="0px" cellpadding="3px"> 
        <tr valign="top" bgcolor="#DDDDDD" >
        	<td colspan="4" bgcolor="black" align="center">
        		<font color="white"><b>The <em>Other</em> Control Panel</b></font>
        	</td>
        </tr>
        <tr valign="top" bgcolor="#DDDDDD" > 
        	<td bgcolor="forestgreen" width="4px">&nbsp;</td>
        	<td>
		<b>Mail</b><br>
		<li><a href="Unstick.asp">View/Unstick Queued Messages</a></li>
        	</td>  

                <td bgcolor="gold" width="4px">&nbsp;</td>
                <td>	
                </td>
        </tr>	    
        <tr valign="top" bgcolor="#DDDDDD" > 
                <td bgcolor="gold" width="4px">&nbsp;</td>
                <td> 
		<b>Verify/Create Database Structure</b><br>
		<li><form action="/component/verifydb.asp" method="get"><input type="text" name="catalog" size="8"><input type="submit"/></form></li>
                </td>

	        <td bgcolor="forestgreen" width="4px">&nbsp;</td>
        	<td>
        	</td>
	</tr>
        <tr valign="top" bgcolor="#DDDDDD" > 
        	<td bgcolor="blue" width="4px">&nbsp;</td>
        	<td>
        	</td>  
        	<td bgcolor="#C00000" width="4px">&nbsp;</td>
        	<td>
        	</td>
        
        </tr>
</table>       

<br>
<hr size="5">
<h2><a name="help"></a>About the Other Control Panel</h2>
</body>
</html>
