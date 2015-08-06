<%
' Date: 29.08.2003

' This ASP source file is designed to work with JUpload v0.50
' For future releases of JUpload, see the forum on 
' http://www.haller-systemservices.net for updates of this file

' Please let me know if you fail to use this script:
' email: hpbjorn@chello.no

'****************************************
'* PAGEINFO - DO NOT MODIFY!!
'*****************************
	strProtocol = Request.ServerVariables("SERVER_PROTOCOL")
	strProtocol = LCase(Mid(strProtocol, 1, InStr(1, strProtocol, "/") - 1) & "://")
	strHost = Request.ServerVariables("HTTP_HOST")
	strURLString = Request.ServerVariables("URL")
	strCompletePageURL = strProtocol & strHost & strURLString
	
	strPage = Mid(strURLString, InStrRev(strURLString, "/") + 1)
'*******************************************


'*********************************************
'*	  CHANGE YOUR INFO IN THIS SECTION!!! 	 *
'*********************************************
	'*****************************************
	'* Relative path from location of this 
	'* file, to where you want your files saved.
	'* If it doesn't exist, it will be created
	strPath = "images"

	'*********************
	'* Appletvariables
	'*****************
	strAPath = "JUpload.jar"
	intAHeight = 200
	intAWidth = 500
	strAAltMsg = "JUpload java applet for uploading multiple files at once with http post method"
	bolAProgressBar = true
	strABoxMsg = "Loading JUpload Applet..."
	strABoxBGColor = "#E0E0FF"
	strABGColor = "#FFFFFF"
	strACompleteURL = "http://mydomain.com/mypage.htm"

	' The applet returns its data to this file as both applet and receiving code resides in current file
	strAActionURL = strCompletePageURL

	bolAAuth = false
	strATagName = "fileUploads"
	bolAResp = true
	bolASuccessD = true
	lngATRSize = 2048000
	bolAFFilter = false
	bolAhideShowAll = false
	bolAPicPreview = true
	strAWindowTitle = "Add files"
	strAImageURL = "jupload.gif"
	strAFilesLbl = "Files:"
	strABytesLbl = "Bytes:"
	strAAddBtn = "Add"
	strARemoveBtn = "Remove"
	strAUploadBtn = "Upload"
	strASuccessDMsg = "Upload was reported to be successfull."
	strASuccessDTitle = "Upload successfull"
	strAAddTip = "Press to open file chooser to add files to upload queue"
	strARemoveTip = "Select files in queue and click this button to remove them from queue"
	strAUploadTip = "Press to start uploading the files in the queue to the configured webserver"
	bolARecursive = false
	bolADebug = true
	bolACheckVersion = false
	strAJavaURL = "http://java.sun.com/j2se/downloads.html"
	strADefaultDir = ""
'*********************************************
'*								END OF SECTION						 *
'*********************************************


'*********************************************
'* Appletsource. Do not modify. Change
'* variables in section above
'*********************************************
	strAppletSrc = "<applet"
	strAppletSrc = strAppletSrc & " code='JUpload/startup.class'"
	strAppletSrc = strAppletSrc & " archive='" & strAPath & "'"
	strAppletSrc = strAppletSrc & " width=" & intAWidth
	strAppletSrc = strAppletSrc & " height=" & intAHeight
	strAppletSrc = strAppletSrc & " alt='" & strAAltMsg & "'>"
	strAppletSrc = strAppletSrc & "<param name='progressbar' value='" & bolAProgressBar & "'>"
	strAppletSrc = strAppletSrc & "<param name='boxmessage' value='" & strABoxMsg & "'>"
	strAppletSrc = strAppletSrc & "<param name='boxbgcolor' value='" & strABoxBGColor & "'>"
	strAppletSrc = strAppletSrc & "<param name='backgroundColor' value='" & strABGColor & "'>"
	strAppletSrc = strAppletSrc & "<param name='completeURL' value='" & strACompleteURL & "'>"
	
	' The applet returns its data to this file as applet and receive code resides in this file
	strAppletSrc = strAppletSrc & "<param name='actionURL' value='" & strAActionURL & "'>"

	strAppletSrc = strAppletSrc & "<param name='askAuthentification' value='" & bolAAuth & "'>"
	strAppletSrc = strAppletSrc & "<param name='tagName' value='" & strATagName & "'>"
	strAppletSrc = strAppletSrc & "<param name='checkResponse' value='" & bolAResp & "'>"
	strAppletSrc = strAppletSrc & "<param name='showSuccessDialog' value='" & bolASuccessD & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxTotalRequestSize' value='" & lngATRSize & "'>"
	strAppletSrc = strAppletSrc & "<param name='imageFileFilter' value='" & bolAFFilter & "'>"
	strAppletSrc = strAppletSrc & "<param name='hideShowAll' value='" & bolAhideShowAll & "'>"
	strAppletSrc = strAppletSrc & "<param name='showPicturePreview' value='" & bolAPicPreview & "'>"
	strAppletSrc = strAppletSrc & "<param name='addWindowTitle' value='" & strAWindowTitle & "'>"
	strAppletSrc = strAppletSrc & "<param name='imageURL' value='" & strAImageURL & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelFiles' value='" & strAFilesLbl & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelBytes' value='" & strABytesLbl & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelAdd' value='" & strAAddBtn & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelRemove' value='" & strARemoveBtn & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelUpload' value='" & strAUploadBtn & "'>"
	strAppletSrc = strAppletSrc & "<param name='successDialogMessage' value='" & strASuccessDMsg & "'>"
	strAppletSrc = strAppletSrc & "<param name='successDialogTitle' value='" & strASuccessDTitle & "'>"
	strAppletSrc = strAppletSrc & "<param name='addToolTip' value='" & strAAddTip & "'>"
	strAppletSrc = strAppletSrc & "<param name='removeToolTip' value='" & strARemoveTip & "'>"
	strAppletSrc = strAppletSrc & "<param name='uploadToolTip' value='" & strAUploadTip & "'>"
	strAppletSrc = strAppletSrc & "<param name='useRecursivePaths' value='" & bolARecursive & "'>"
	strAppletSrc = strAppletSrc & "<param name='debug' value='" & bolADebug & "'>"
	strAppletSrc = strAppletSrc & "<param name='checkJavaVersion' value='" & bolACheckVersion & "'>"
	strAppletSrc = strAppletSrc & "<param name='checkJavaVersionGotoURL' value='" & strAJavaURL & "'>"
	strAppletSrc = strAppletSrc & "<param name='defaultAddDirectory' value='" & strADefaultDir & "'>"
	strAppletSrc = strAppletSrc & "</applet>"

'***********************************************************
'* Code that receives and saves the files.
'* Do not modify!
'****************************************
	If Request.TotalBytes > 0 Then
		Dim rawData
		Dim separator 
		Dim lenSeparator
		Dim currentPos, begPos, endPos, inStrByte
		Dim filename, data
	
		rawData = Request.BinaryRead(Request.TotalBytes)
		
		'*******************************************************************
		'* Must find another way to get the separator dynamically. Anyone?
		separator = stringToByte("-----------------------v7sdfosd7idf9wkfzh7ylqa8DyIq")
		lenSeparator = LenB(separator)
		currentPos = 1
		inStrByte = 1
		data = ""
		filename = ""
		
		While inStrByte > 0
			currentPos = inStrByte + lenSeparator
			inStrByte = InStrB(currentPos, rawData, separator)
		
			'*********************
			'* FIND FILENAME
			begPos = InStrB(currentPos, rawData, stringToByte("filename=")) + 10
			endPos = InStrB(begPos, rawData, stringToByte(";")) - 1
			filename = MidB(rawData, begPos, endPos - begPos)

			If filename <> separator Then
				'*********************
				'* FIND CONTENT-TYPE
				begPos = InStrB(currentPos, rawData, stringToByte("Content-Type:")) + 14
				endPos = InStrB(begPos, rawData, chrB(13))
		
				'*********************
				'* FIND DATA
				begPos = endPos + 4
				endPos = InStrB(begPos, rawData, separator) - 2
				
				' To include the final bit (last file) of the rawData (max 1MB size)
				' Find another way to do this?!
				If endPos < begPos Then
					endPos = begPos + 1024000
				End If
				
				data = MidB(rawData, begPos, endPos - begPos)
		
				'*****************************
				'* SAVE THE FILE
				Dim File, FSO, strFullPath
				Set FSO = Server.CreateObject("Scripting.FileSystemObject")
				
				strFullPath = Server.MapPath(strPath)
				If Not FSO.FolderExists(strFullPath) Then
					FSO.CreateFolder(strFullPath)
				End If
				strSaveToPath = CStr(strFullPath & "\" & byteToString(filename))
				Set File = FSO.CreateTextFile(strSaveToPath)
					
				For currPos = 1 to LenB(data)
						File.Write Chr(AscB(MidB(data,currPos,1)))
				Next	
				File.Close
			End If
		Wend
	END IF

	'************************************
	'* FUNCTIONS FOR CONVERTING BETWEEN
	'* BINARY/BYTE AND STRING
	'*****************************
  Private Function stringToByte(toConv)
    Dim tempChar
     For i = 1 to Len(toConv)
       tempChar = Mid(toConv, i, 1)
      stringToByte = stringToByte & chrB(AscB(tempChar))
     Next
  End Function

  Private Function byteToString(toConv)
    For i = 1 to LenB(toConv)
      byteToString = byteToString & chr(AscB(MidB(toConv,i,1))) 
    Next
  End Function

%>
<html>
<body>
<%=strAppletSrc%>
</body>
</html>

