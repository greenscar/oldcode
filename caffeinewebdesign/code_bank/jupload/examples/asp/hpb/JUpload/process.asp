<%@LANGUAGE=VBSCRIPT%>
<%Option Explicit%>
<!--#include file="vars.inc"-->
<%
	Server.ScriptTimeout = 10000	'ensures that we get everything uploaded
	'Dim statements
	Dim FSO, strFullPath, uplFile, strSaveToPath
	Dim rawData, data, filename, lenFND
	Dim sep, endsep
	Dim currentPos, begPos, endPos, currPos, nextSepPos
	Dim strFileNameBegin
	Dim i
	
	'* Do not modify!
	'****************************************
	If Request.TotalBytes > 0 Then
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
		rawData = Request.BinaryRead(Request.TotalBytes)
		'response.write(byteToString(rawData))
		
		
		'*******************************************************************
		'* Define separators
		sep = stringToByte("----JUPLOAD--BOUNDARY--")
		endsep = stringToByte("----JUPLOAD-BOUNDARY--")
		'response.write(replace(byteToString(sep), Chr(13), "<br>"))

		'*******************************************************************
		'* Initialization
		strFileNameBegin = stringToByte("filename")
		lenFND = LenB(strFileNameBegin)
		currentPos = 1
		'response.write("Total lengde: " &  Request.TotalBytes)

		While currentPos <= Request.TotalBytes
			currentPos = InStrB(currentPos, rawData, strFileNameBegin) + lenFND + 2 'we add two to get to the filename itself

			if (currentPos = 0) then
				currentPos = Request.TotalBytes + 20
			else
				'*********************
				'* FIND FILENAME
				begPos = currentPos 	'update the temp-variable begPos
				endPos = InStrB(begPos, rawData, stringToByte(";")) - 1
				filename = MidB(rawData, begPos, endPos - begPos)
				currentPos = InStrB(currentPos, rawData, stringToByte("Content-Type"))	'move to the last attribute before the data
				'response.write("found filename: " & byteToString(filename))
				'*********************
				'* FIND DATA
				begPos = InStrB(currentPos, rawData, ChrB(13)) + 4
				
				'checks if we've reached the end
				nextSepPos = InStrB(currentPos, rawData, sep)
				'response.write("<br>neste sep: " & nextSepPos & "<br>")
				if nextSepPos = 0 then
					'set endpos to the index of the end separator
					endPos = InStrB(currentPos, rawData, endsep) - 2
				else
					endPos = nextSepPos - 2
				end if

				data = MidB(rawData, begPos, endPos - begPos)
				
				'*****************************
				'* SAVE THE FILE
				strFullPath = Server.MapPath(strPath)

				If Not FSO.FolderExists(strFullPath) Then
					FSO.CreateFolder(strFullPath)
				End If
				'response.write(byteToString(filename))
				strSaveToPath = strFullPath & "\" & replace(byteToString(filename)," ", "_")
				
				Set uplFile = FSO.CreateTextFile(LCase(strSaveToPath))
					
				For currPos = 1 to LenB(data)
					uplFile.Write Chr(AscB(MidB(data, currPos, 1)))
				Next	
				uplFile.Close
	
				currentPos = endPos + 60
				'response.write("update currPos: " & currentPos)
			end if
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