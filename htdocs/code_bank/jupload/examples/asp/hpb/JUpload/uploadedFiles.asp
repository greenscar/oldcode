<%@Language=VBScript%>
<% Option Explicit %>
<!--#include file="vars.inc"-->
<%
	Dim FSO, Folder, Files, nFile
	Dim iFile, bgColor
	Dim strQSA, strQSADelFile, strName
	
	strQSADelFile = "DelFile"
	
	strQSA = request.querystring("QSA")
	strName = request.querystring("Name")
	
	Set FSO = CreateObject("Scripting.FileSystemObject")
	if not (FSO.FolderExists(Server.MapPath(strPath))) then FSO.CreateFolder(Server.MapPath(strPath))

	if(strQSA = strQSADelFile) then

		if (FSO.FileExists(Server.MapPath(strPath & "/" & strName))) then
			FSO.DeleteFile(Server.MapPath(strPath & "/" & strName))
		end if

		response.redirect(strPgResult)
	end if

	Set Folder = FSO.GetFolder(Server.MapPath(strPath))
	Set Files = Folder.Files

	iFile = 0
%>
<html>
<head>
<style type="text/css">
   body,p,table { font-family: arial; font-size:12px; }
</style>
<title>Uploaded files</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
[ <a href="<%=strPgQueue%>">Back to upload screen</a> | <a href="<%=strPgResult%>">Refresh the list</a> ] <br>
<br>
<table border="0" cellspacing="0" cellpadding="1" style="border:1px solid black;">
	<tr bgcolor="black">
		<td><strong><font color="white">Filename</font></strong></td>
		<td><strong><font color="white">Filesize</font></strong></td>
		<td><strong><font color="white">KB</font></strong></td>
		<td><strong><font color="white">Delete</font></strong></td>
	<tr>
<%
	For Each nFile In Files
		if iFile mod 2 = 0 then
			bgColor = "#FFFFFF"
		else
			bgColor = "#ECECEC"
		end if
		
		if FSO.FileExists(Folder & "\" & nFile.Name) then
%>
	<tr bgcolor="<%=bgColor%>">
		<td style="border-bottom:1px solid #CCCCCC;">&nbsp;<a href="<%=strPath & "/" & nFile.Name%>" target="_blank"><%=nFile.Name%></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td style="border-bottom:1px solid #CCCCCC;" align="right"><%=FormatNumber(nFile.Size, 0)%>&nbsp;&nbsp;</td>
		<td style="border-bottom:1px solid #CCCCCC;" align="right"><%=FormatNumber(nFile.Size / 1024, 0) & " KB"%>&nbsp;&nbsp;</td>
		<td style="border-bottom:1px solid #CCCCCC;" align="center"><img src="images/delete.png" border="0" onMouseOver="this.style.cursor='hand';" onMouseOut="this.style.cursor='pointer';" onClick="location.href='<%=strPgResult%>?QSA=<%=strQSADelFile%>&Name=<%=nFile.Name%>';"></td>
	<tr>
<%
		
			iFile = iFile + 1
		end if
	Next
	
	if iFile = 0 then
%>
	<tr bgcolor="<%=bgColor%>">
		<td colspan="4" style="border-bottom:1px solid #CCCCCC;" align="center">Couldn't find any files in the upload folder '<%=strPath%>'</td>
	<tr>
<%
	end if

%>
</table>
</body>
</html>
<%
	Set FSO = nothing
	Set Folder = nothing
	Set Files = nothing
%>
