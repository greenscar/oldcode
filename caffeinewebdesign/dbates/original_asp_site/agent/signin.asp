<%@ LANGUAGE = PerlScript %>     
<html>
<head>
	<title>DBATES.COM control panel</title>
        <script language="javascript">
        <!--                      
        function Check(ElementName, ElementTitle)
        	{   
        	if (eval("office."+ElementName+".value.length") == 0)
        		{AlertString=AlertString+"  "+ElementTitle+"\n";}
        	}
        
        function Mandatory()
                {
        	AlertString="";
                Check('AllegedID','Agent ID');
                Check('AllegedPW','Agent Password');
        	if (AlertString.length == 0)
        		{return true;}
        	else
        		{alert("Please complete:\n"+AlertString);
        		return false;}
                }

        //-->
        </script>
	<style> 
        	body
                        {
                	font-family: verdana, arial; 
			font-weight: bold;
                	font-size: 10pt;
                	background-color: #FFFFFF;
                        color: #000000; 
                        }          
	</style>
</head>

<body> 
      
<form name='office' action='<%=$Session->{'AvailableHttpsProtocol'}%><%=$Request->ServerVariables('HTTP_HOST')->item%>/component/login.asp' onSubmit='return Mandatory()' method='post'>
<table border="0" cellspacing="0" cellpadding="5pt" align="center">
	<tr>
		<td colspan="4" align="center" bgcolor="black">
			<img src="/resource/about.jpg">
		</td>
	</tr>  
	<tr>
		<td colspan="4" align="center" bgcolor="#AAAACC">
			<h2 style="font-family:verdana,arial;">DBATES.COM control panel</h2>
		</td>
	</tr>
	<tr>
		<td align="right">
			<b>Agent ID</b>
		</td>
		<td align="left" bgcolor="#DDDDDD">
			<input type="text" name="AllegedID" size="4" required="Your agent ID">
		</td>
		<td align="right">
			<b>Agent Password</b>
		</td>
		<td align="left" bgcolor="#DDDDDD">
			<input type="text" name="AllegedPW" size="8" required="Your agent password">
		</td>
	</tr>                         
	<tr>
		<td colspan="4" align="center"  bgcolor="#AAAACC" height="50px">
			<input type="submit" value="Enter">
		</td>
	</tr>
</table>
</form>  

</body>
</html>

