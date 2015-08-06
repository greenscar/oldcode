<%@ LANGUAGE = JavaScript %>   
<html><body>
<%
if (!Request.Cookies('agentDurhamAndBates').item('ID'))
	{Response.redirect('/agent');}
                           
//rewrite uwpage.asp to send (post) the following items
DocRoot = Server.MapPath('/');                   
UWID = Request.Form.item('UWID');
UWNAME = Request.Form.item('UWNAME');      
UWROOT = Request.Form.item('UWROOT');           
Alert = new Array(0);
%>
<p><%=UWID%></p>
<p><%=UWNAME%></p>
<p><%=UWROOT%></p>

for (ThisFile in Request.Files)
	{
        FilePath = ThisFile.FileName;
	FileName = FilePath.substr(FilePath.lastIndexOf('/'), FilePath.length);
	FileType = ThisFile.ContentType;
	if (FileType=='image/jpeg'||FileType=='image/tiff'||FileType=='application/msword'||FileType=='application/x-msexcel'||FileType=='application/vnd.ms-excel'||FileType=='application/x-zip-compressed')
		{
                Today = new Date();
                ThisYear = Today.getFullYear();
                ThisMonth = Today.getMonth()+1;
                ThisDay = Today.getDate();
                ThisDate = ThisMonth+"/"+ThisDay+"/"+ThisYear;
		DB = Server.CreateObject('Msxml2.DOMDocument.4.0');
		if (DB.selectSingleNode("index"))
			{DB.load(UWRoot+'/index.xml');}
		else
			{DB.loadXML("<index/>");}
		NewItem = DB.createNode(1,'item', '');
		NewItem.text = Request.Form('notes');
		IndexSuccess = DB.documentElement.appendChild(NewItem);
		NewItem.setAttribute('time', ThisDate);
		NewItem.setAttribute('size', int(ThisFile.ContentLength/1000)+' Kbytes');
		NewItem.setAttribute('file', FileName);
		DB.save(UWRoot+'/index.xml');
		if (IndexSuccess)
			{AlertItems = Alert.push(FileName+" uploaded for "+UWName);}
		else 
			{AlertItems = Alert.push("Unable to add uploaded file ("+FileName+") to table of contents");}
		}
	else 
		{AlertItems = Alert.push("Upload not permitted for that type of file ("+FileName+")");}
	}

</body></html>			
<html>
<!--
<head>
	<script language="javascript">
	<!--
        	<% for (ThisAlert in Alert) {%>alert("<%=ThisAlert%>");<%}%>
        	location.href="uwpage.asp?id=<%=UWID%>";
	//-->
	</script>
</head>
</html>
-->