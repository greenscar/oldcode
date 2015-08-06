<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../includes/conn.asp"-->
<!--#include file="../includes/functions.asp"-->
<%
	'****************************************
	'* QUERYSTRINGS
	'**************
	intBGID = CInt(Request.Querystring("ID"))
	strQSA = CStr(Request.Querystring("QSA"))
	
	'****************************************
	'* PAGEINFO
	'**********
	strProtocol = Request.ServerVariables("SERVER_PROTOCOL")
	strProtocol = LCase(Mid(strProtocol, 1, InStr(1, strProtocol, "/") - 1) & "://")
	strHost = Request.ServerVariables("HTTP_HOST")
	strURLString = Request.ServerVariables("URL")
	strCompletePageURL = strProtocol & strHost & strURLString
	
	strPage = Mid(strURLString, InStrRev(strURLString, "/") + 1)
	
	strPageTitle = "Administrasjon av bildegalleri"

	'********************************************
	'* GALLERY RELATED VARIABLES
	'***************************
	IF strQSA = "New" THEN
		strBGPath = "../gallery/" & cstr(intBGID)
	END IF

	'********************************************
	'* APPLET VARIABLES
	'******************
	strAppletPath = "lib/JUpload.jar"
	strAppletbgColor = "#FFFFFF"
	strAppletHeight = 400
	strAppletWidth = 500
	strAppletAddBtn = "Legg Til"
	strAppletRemoveBtn = "Fjern"
	strAppletUploadBtn = "Last Opp"
	strAppletAltMsg = "JUpload java applet for uploading multiple files at once with http post method"
	strAppletGOTOAfterAdd = "http://localhost/vipsclub/admin/goto.asp"'strCompletePageURL 'Replace(strCompletePageURL, strPage, "admin_gallery_show_Gallery.asp")

	strAppletSrc = "<applet"
	strAppletSrc = strAppletSrc & " code='JUpload/startup.class'"
	strAppletSrc = strAppletSrc & " archive='" & strAppletPath & "'"
	strAppletSrc = strAppletSrc & " width=" & strAppletWidth
	strAppletSrc = strAppletSrc & " height=" & strAppletHeight
	strAppletSrc = strAppletSrc & " alt='" & strAppletAltMsg & "'>"
	strAppletSrc = strAppletSrc & " <param name='actionURL' value='" & strCompletePageURL & "'>"
	strAppletSrc = strAppletSrc & " <param name='backgroundColor' value='" & strAppletbgColor & "'>"
	strAppletSrc = strAppletSrc & " <param name='labelAdd' value='" & strAppletAddBtn & "'>'"
	strAppletSrc = strAppletSrc & " <param name='labelRemove' value='" & strAppletRemoveBtn & "'>'"
	strAppletSrc = strAppletSrc & " <param name='labelUpload' value='" & strAppletUploadBtn & "'>'"
	strAppletSrc = strAppletSrc & " <param name='completeURL' value='" & strAppletGOTOAfterAdd & "'>"

'	response.write(strCompletePageURL & "<br>")
'	response.write(strPage)
'	response.write(strJARURL)

	IF Request.TotalBytes > 0 THEN
		Dim rawData
		Dim separator 
		Dim lenSeparator
		Dim currentPos
		Dim inStrByte
		Dim value, mValue
		Dim tempValue
	
		rawData = Request.BinaryRead(Request.TotalBytes)
		separator = stringToByte("v7sdfosd7idf9wkfzh7ylqa8DyIq")
		lenSeparator = LenB(separator)
		currentPos = 1
		inStrByte = 1
		tempValue = ""
		
		While inStrByte > 0
			currentPos = inStrByte + lenSeparator
			inStrByte = InStrB(currentPos, rawData, separator)
	
			'*********************
			'* FIND FILENAME
			begPos = InStrB(currentPos, rawData, stringToByte("filename=")) + 10
			endPos = InStrB(begPos, rawData, chrB(13)) - 2
			filename = MidB(rawData, begPos, endPos - begPos)
	
			'*********************
			'* FIND CONTENT-TYPE
			begPos = InStrB(currentPos, rawData, stringToByte("Content-Type:")) + 14
			endPos = InStrB(begPos, rawData, chrB(13))
	
			'*********************
			'* FIND DATA
			begPos = endPos + 4
			endPos = InStrB(begPos, rawData, separator) - 2
			
			' To include the rest of the rawData (max 1MB size)
			' Find another way to do this?!
			if endPos < begPos then
				endPos = begPos + 1024000
			end if
			
			data = MidB(rawData, begPos, endPos - begPos)
	
			'*****************************
			'* SAVE THE FILE
			Dim file, fso
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
		
			path = cstr(server.MapPath(byteToString(filename)))
			Set file = fso.CreateTextFile(path)
			value = data
				
			For tPoint = 1 to LenB(value)
					file.Write Chr(AscB(MidB(value,tPoint,1)))
			Next	
			file.Close
		Wend
	END IF
%>

<html>
<head>
<title><%=strPageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../css/admin.css" type="text/css">
</head>

<body bgcolor="#797979">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="white" class="border_hard">
				<tr>
					<td align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr> 
								<td class="headerhard"><%=strPageTitle%></td>
							</tr>
							<tr>
								<td align="center" class="text10reg"><br>
							[ <a href="<%=strPage%>">Gallerioversikt</a> | <a href="<%=strPage%>?QSA=Cat">Kategorioversikt</a> 
							| <a href="<%=strPage%>?QSA=NewCat">Ny kategori</a> | <a href="admin.asp">Hovedside</a> 
							]<br>
							<br>
								</td>
							</tr>
							<tr> 
								<td align="center" class="text10reg">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><%=strAppletSrc%></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>

