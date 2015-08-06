<%@ LANGUAGE = PerlScript %>     
<html>
<head>
	<title>Durham & Bates underwriter area</title>
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
                Check('AllegedID','ID');
                Check('AllegedPW','Password');
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
			<h2 style="font-family:verdana,arial;">Durham & Bates underwriter area</h2>
		</td>
	</tr>
	<tr>
		<td align="right">
			<b>ID</b>
		</td>
		<td align="left" bgcolor="#DDDDDD">
			<input type="text" name="AllegedID" size="4" required="Your ID">
		</td>
		<td align="right">
			<b>Password</b>
		</td>
		<td align="left" bgcolor="#DDDDDD">
			<input type="text" name="AllegedPW" size="8" required="Your password">
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