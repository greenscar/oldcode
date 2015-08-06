<%
' Date: 09.10.2003

' This ASP source file is designed to work with JUpload v0.69
' For future releases of JUpload, see the forum on 
' http://www.haller-systemservices.net for updates of this file

' Please let me know if you fail to use this script:
' email: hpbjorn@chello.no

	Server.ScriptTimeout = 1000

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
	strBackgroundColor = "#e0e0e0"
	URLCompleteURL = "http://mydomain.com/mypage.htm"
	' To make the script return the data to itself
	URLActionURL = strCompletePageURL
	bolAskAuthentification = false
	strTagName = "uploadedFiles"
	bolCheckResponse = true
	bolShowSuccessDialog = true
	bolImageFileFilter = false
	bolHideShowAll = false
	bolShowPicturePreview = true
	strAddWindowTitle = "Add files"
	strImageURL = ""
	strLabelFiles = "Files:"
	strLabelBytes = "Bytes:"
	strLabelAdd = "Add"
	strLabelRemove = "Remove"
	strLabelUpload = "Upload"
	strSuccessDialogMessage = "Upload was reported to be successful."
	strSuccessDialogTitle = "Upload successfull"
	strAddToolTip = "Press to open file chooser to add files to upload queue"
	strRemoveToolTip = "Select files in queue and click this button to remove them from queue"
	strUploadToolTip = "Press to start uploading the files in the queue to the configured webserver"
	bolUseRecursivePaths = false
	bolDebug = true
	bolCheckJavaVersion = true
	URLCheckJavaVersionGotoURL = "http://java.sun.com/j2se/downloads.html"
	strBrowserCookie = ""
	strDefaultAddDirectory = ""
	bolUsePutMethod = false
	lngMaxFreeSpaceOnServer = -1
	strMaxFreeSpaceOnServerWarning = "File is too large for server"
	strMaxFreeSpaceOnServerTitle = "File too large"
	lngMaxTotalRequestSize = 2000000
	strMaxTotalRequestSizeWarning = "File too large for upload"
	strMaxTotalRequestSizeTitle = "File too large"
	bolCustomFileFilter = false
	strCustomFileFilterDescription = "Customized"
	strCustomFileFilterExtensions = "gif,jpeg,jpg,png,bmp,tif"
	intMaxNumberFiles = -1
	strMaxNumberFilesWarning = "Maximum number of files reached."
	strMaxNumberFilesTitle = "Filelimit reached"
	bolFixJakartaBug = false
	intMaxFilesPerRequest = -1
	bolShowServerResponse = false
	urlErrorURL = ""
	lstPreselectedFiles = ""
	bolRealTimeResponse = true
	strDebugLogfile = "/jupload.log"
	intMainSplitpaneLocation = 250
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
	strAppletSrc = strAppletSrc & " height=" & intAHeight & ">"
	strAppletSrc = strAppletSrc & "<param name='backgroundColor' value='" & strBackgroundColor & "'>"
	strAppletSrc = strAppletSrc & "<param name='completeURL' value='" & URLCompleteURL & "'>"
	strAppletSrc = strAppletSrc & "<param name='actionURL' value='" & URLActionURL & "'>"
	strAppletSrc = strAppletSrc & "<param name='askAuthentification' value='" & bolAskAuthentification & "'>"
	strAppletSrc = strAppletSrc & "<param name='tagName' value='" & strTagName & "'>"
	strAppletSrc = strAppletSrc & "<param name='checkResponse' value='" & bolCheckResponse & "'>"
	strAppletSrc = strAppletSrc & "<param name='showSuccessDialog' value='" & bolShowSuccessDialog & "'>"
	strAppletSrc = strAppletSrc & "<param name='imageFileFilter' value='" & bolImageFileFilter & "'>"
	strAppletSrc = strAppletSrc & "<param name='hideShowAll' value='" & bolHideShowAll & "'>"
	strAppletSrc = strAppletSrc & "<param name='showPicturePreview' value='" & bolShowPicturePreview & "'>"
	strAppletSrc = strAppletSrc & "<param name='addWindowTitle' value='" & strAddWindowTitle & "'>"
	strAppletSrc = strAppletSrc & "<param name='imageURL' value='" & strImageURL & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelFiles' value='" & strLabelFiles & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelBytes' value='" & strLabelBytes & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelAdd' value='" & strLabelAdd & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelRemove' value='" & strLabelRemove & "'>"
	strAppletSrc = strAppletSrc & "<param name='labelUpload' value='" & strLabelUpload & "'>"
	strAppletSrc = strAppletSrc & "<param name='successDialogMessage' value='" & strSuccessDialogMessage & "'>"
	strAppletSrc = strAppletSrc & "<param name='successDialogTitle' value='" & strSuccessDialogTitle & "'>"
	strAppletSrc = strAppletSrc & "<param name='addToolTip' value='" & strAddToolTip & "'>"
	strAppletSrc = strAppletSrc & "<param name='removeToolTip' value='" & strRemoveToolTip & "'>"
	strAppletSrc = strAppletSrc & "<param name='uploadToolTip' value='" & strUploadToolTip & "'>"
	strAppletSrc = strAppletSrc & "<param name='useRecursivePaths' value='" & bolUseRecursivePaths & "'>"
	strAppletSrc = strAppletSrc & "<param name='debug' value='" & bolDebug & "'>"
	strAppletSrc = strAppletSrc & "<param name='checkJavaVersion' value='" & bolCheckJavaVersion & "'>"
	strAppletSrc = strAppletSrc & "<param name='checkJavaVersionGotoURL' value='" & URLCheckJavaVersionGotoURL & "'>"
	strAppletSrc = strAppletSrc & "<param name='browserCookie' value='" & strBrowserCookie & "'>"
	strAppletSrc = strAppletSrc & "<param name='defaultAddDirectory' value='" & strDefaultAddDirectory & "'>"
	strAppletSrc = strAppletSrc & "<param name='usePutMethod' value='" & bolUsePutMethod & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxFreeSpaceOnServer' value='" & lngMaxFreeSpaceOnServer & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxFreeSpaceOnServerWarning' value='" & strMaxFreeSpaceOnServerWarning & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxFreeSpaceOnServerTitle' value='" & strMaxFreeSpaceOnServerTitle & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxTotalRequestSize' value='" & lngMaxTotalRequestSize & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxTotalRequestSizeWarning' value='" & strMaxTotalRequestSizeWarning & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxTotalRequestSizeTitle' value='" & strMaxTotalRequestSizeTitle & "'>"
	strAppletSrc = strAppletSrc & "<param name='customFileFilter' value='" & bolCustomFileFilter & "'>"
	strAppletSrc = strAppletSrc & "<param name='customFileFilterDescription' value='" & strCustomFileFilterDescription & "'>"
	strAppletSrc = strAppletSrc & "<param name='customFileFilterExtensions' value='" & strCustomFileFilterExtensions & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxNumberFiles' value='" & intMaxNumberFiles & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxNumberFilesWarning' value='" & strMaxNumberFilesWarning & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxNumberFilesTitle' value='" & strMaxNumberFilesTitle & "'>"
	strAppletSrc = strAppletSrc & "<param name='fixJakartaBug' value='" & bolFixJakartaBug & "'>"
	strAppletSrc = strAppletSrc & "<param name='maxFilesPerRequest' value='" & intMaxFilesPerRequest & "'>"
	strAppletSrc = strAppletSrc & "<param name='showServerResponse' value='" & bolShowServerResponse & "'>"
	strAppletSrc = strAppletSrc & "<param name='errorURL' value='" & urlErrorURL & "'>"
	strAppletSrc = strAppletSrc & "<param name='preselectedFiles' value='" & lstPreselectedFiles & "'>"
	strAppletSrc = strAppletSrc & "<param name='realTimeResponse' value='" & bolRealTimeResponse & "'>"
	strAppletSrc = strAppletSrc & "<param name='debugLogfile' value='" & strDebugLogfile & "'>"
	strAppletSrc = strAppletSrc & "<param name='mainSplitpaneLocation' value='" & intMainSplitpaneLocation & "'>"
	strAppletSrc = strAppletSrc & "</applet>"

'***********************************************************
'* Code that receives and saves the files.
'* Do not modify!
'****************************************
	If Request.TotalBytes > 0 Then
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
		rawData = Request.BinaryRead(Request.TotalBytes)
		
		'*******************************************************************
		'* Finds the separator
		separatorPart1 = stringToByte("----JUPLOAD--BOUNDARY--")
		separatorPart2 = stringToByte("--JUPLOAD-BOUNDARY--")
		
		lenSeparatorPart1 = LenB(separatorPart1)
		lenSeparatorPart2 = LenB(separatorPart2)
		endSepPos = InStrB(lenSeparatorPart1, rawData, separatorPart2)
		
		separator = separatorPart1
		separator = separator & MidB(rawData,lenSeparatorPart1 + 1, endSepPos + lenSeparatorPart2 - lenSeparatorPart1)
		lenSeparator = LenB(separator)

		'*******************************************************************
		'* Initialization
		data = ""
		filename = ""
		currentPos = lenSeparator

		While currentPos < Request.TotalBytes
			'*********************
			'* FIND CONTENT-LENGTH
			strConLenDel = stringToByte("Content-Length: ")
			lenCLD = LenB(strConLenDel)
			begPos = InStrB(currentPos, rawData, strConLenDel) + lenCLD
			endPos = InStrB(begPos, rawData, ChrB(13))
			strConLen = MidB(rawData, begPos, endPos - begPos)
			intConLen = CLng(byteToString(strConLen))

			'*********************
			'* FIND FILENAME
			strFileNameDelimiter = stringToByte("Content-Description: \")
			lenFND = LenB(strFileNameDelimiter)
			begPos = InStrB(currentPos, rawData, strFileNameDelimiter) + lenFND
			endPos = InStrB(begPos, rawData, ChrB(13))
			filename = MidB(rawData, begPos, endPos - begPos)
			currentPos = endPos + 5 'Randomly picked, just to get to the next line in the header
			
			'*********************
			'* FIND CONTENT / DATA
			begPos = InStrB(currentPos, rawData, ChrB(13)) + 4
			data = MidB(rawData, begPos, intConLen)
			
			'*****************************
			'* SAVE THE FILE
			Dim File, FSO, strFullPath, strPath
			
			strFullPath = Server.MapPath(strPath)
			If Not FSO.FolderExists(strFullPath) Then
				FSO.CreateFolder(strFullPath)
			End If
			'response.write(byteToString(filename))
			strSaveToPath = strFullPath & "\" & byteToString(filename)
			
			Set File = FSO.CreateTextFile(strSaveToPath)
				
			For currPos = 1 to LenB(data)
					File.Write Chr(AscB(MidB(data,currPos,1)))
			Next	
			File.Close
			
			currentPos = InStrB(currentPos, rawData, separator)
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
