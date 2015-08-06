<%@ LANGUAGE = JavaScript debug="true" %>   
<%
//if (Request.Cookies('agentDurhamAndBates').Value.length<3) {Response.Redirect("/agent/cpmain.asp");}
var DocRoot = Server.MapPath('/');                   
var UWID = Request.Form('UWID');
var UWName = Request.Form('UWNAME');      
var UWRoot = Server.MapPath('/data/uw')+'\\'+Request.Form('UWROOT');           
var Alert = new Array(0);
var AlertItems = 0;
for (var i=0; i<Request.Files.Count-1; i++)
	{                      
	var ThisFile = Request.Files[i];
        var FilePath = ThisFile.FileName;
	var FileNames = FilePath.split('\\');
	var FileName = FileNames[FileNames.length - 1];
	var FileType = ThisFile.ContentType;
	if (FileType=='image/jpeg'||FileType=='image/pjpeg'||FileType=='image/tiff'||FileType=='application/msword'||FileType=='application/x-msexcel'||FileType=='application/vnd.ms-excel'||FileType=='application/x-zip-compressed')
		{
		ThisFile.SaveAs(UWRoot+'\\'+FileName);
                var Today = new Date();
                var ThisYear = Today.getFullYear();
                var ThisMonth = Today.getMonth()+1;
                var ThisDay = Today.getDate();
                var ThisDate = ThisMonth+"/"+ThisDay+"/"+ThisYear;
		var DB = Server.CreateObject('Msxml2.DOMDocument.4.0');
		DB.load(UWRoot+'\\index.xml');
		if (DB.selectSingleNode("//item"))
			{}
		else
			{DB.loadXML("<index/>");}
		var NewItem = DB.createNode(1,'item', '');
		var j = i+1;
		NewItem.text = Request.Form('Notes'+j);
		var IndexSuccess = DB.documentElement.appendChild(NewItem);
		NewItem.setAttribute('time', ThisDate);
		NewItem.setAttribute('size', int(ThisFile.ContentLength/1000)+' Kbytes');
		NewItem.setAttribute('file', FileName);
		DB.save(UWRoot+'\\index.xml');
		if (IndexSuccess)
			{AlertItems = Alert.push(FileName+" uploaded for "+UWName);}
		else 
			{AlertItems = Alert.push("Unable to add uploaded file ("+FileName+") to table of contents");}
		}
	else 
		{
		if (ThisFile.ContentLength>0) {AlertItems = Alert.push("Upload not permitted for that type of file ("+FileName+")");}
		}
	}                                                    
%>
<html>
<head>
	<script language="javascript">
	<!--
        	<%
		for (var ThisAlert=0; ThisAlert<Alert.length; ThisAlert++)
			{%>alert("<%=Alert[ThisAlert]%>");<%}%>
        	location.href="uwpage.asp?id=<%=UWID%>";
	//-->
	</script>
</head>
</html>

