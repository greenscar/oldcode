<%@Language=VBScript%>
<% Option Explicit %>
<!--#include file="vars.inc"-->
<html>
<head>
<style type="text/css">
   body,p,table { font-family: arial; font-size:12px; }

   #uploadlist {
   	border:1px solid black;
    align:left;
   }

   #uploadlist thead { background-color:black;color:white;  }

   #uploadlist img {
    border:none;
    vertical-align:middle;
   }
  </style>
<script type="text/javascript">
   function clearTbody() {
    var tbody = document.getElementById("uploadlistbody");
    while (tbody.childNodes.length > 0) {
      tbody.removeChild(tbody.firstChild);
    }
   }

   function displayFileQueue() {
    if (!document.JUpload) return;
    if (!document.JUpload.jsIsReady()) return;
    var number = document.JUpload.jsGetFileNumber();
    var i = 0;
    clearTbody();
    for (i=0; i<number; i=i+1) {    
     var theTableBody = document.getElementById("uploadlistbody");
     var newRow = theTableBody.insertRow(0);
     if (i%2!=0) { newRow.style.background='#ECECEC'; }
     var name = document.JUpload.jsGetFileAt(i);
     var unit = 'b';
     var size = document.JUpload.jsGetFileSizeAt(i);
     if(size>1024) { size=size/1024; unit='Kb'; }
     if(size>1024) { size=size/1024; unit='Mb'; }
     if(size>1024) { size=size/1024; unit='Gb'; }
     size = Math.round(size*100)/100;
     var newCell;

     newCell = newRow.insertCell(0);
     newCell.innerHTML = '<img src="images/file.png"> ';
	 newCell.style.borderBottom = '1px solid #CCCCCC';
     newCell = newRow.insertCell(1);
     newCell.align='left';
     newCell.innerHTML = name;
	 newCell.style.borderBottom = '1px solid #CCCCCC';
     newCell = newRow.insertCell(2);
     newCell.align = 'right';
     newCell.innerHTML = size + '' + unit;
	 newCell.style.borderBottom = '1px solid #CCCCCC';
     newCell = newRow.insertCell(3);
     newCell.align = 'right';
     newCell.innerHTML = '<a href="#" onclick="document.JUpload.jsRemoveFileAt(' + i + ');displayFileQueue();"> <img src="images/delete.png" alt="Delete"></a>';
	 newCell.style.borderBottom = '1px solid #CCCCCC';
    }
   }

   function initonload() {
    if (!document.JUpload) return;
    
    if (document.JUpload.jsIsReady()) {
     document.JUpload.jsRegisterAddedListener("myAddListener");
     document.JUpload.jsRegisterUploadListener("myUploadListener");
    }
    else {
     window.setTimeout('initonload()',5);
    }
   }

   function myAddListener() { displayFileQueue(); }

   function myUploadListener() {
	var number = document.JUpload.jsGetFileNumber();   	
	if(number > 0) {
		toggle('progressStatus'); 
		setTimeout('progress()',5000);
	}
   }

   function toggle(el) {
    lyr = document.getElementById(el);
    if (lyr.style.display != 'block') { lyr.style.display = 'block'; } 
    else { lyr.style.display = 'none'; }
   }

   function progress() {
    if (!document.JUpload) return;
    var w = document.JUpload.jsGetTotalProgressbarValue();
    //alert(w);
    document.getElementById('bar').style.width = w+'%';
    document.getElementById('progbarstats').innerHTML = "Progress: " + w + "%";
    setTimeout('progress()',50);
   }

  </script>
<title>Example using ASP with JUpload</title>
</head>

<body onload="initonload();">
[ <a href="<%=strPgResult%>">See uploaded files</a> | <a href="<%=strPgQueue%>">Refresh this page</a> ] <br>
<br>
NB! If you refresh this page, the filequeue will be deleted!!<br>
<!-- 
<form name="JUploadForm">
	<input type="hidden" name="HiddenSampleSessionId" value="123456789abcdef">
	<input type="button" value="Check JUpload" onClick="alert(document.JUpload.jsIsReady())">
	<input type="button" value="Add files" onClick="document.JUpload.jsClickAdd()">
	<input type="button" value="Remove Files" onClick="document.JUpload.jsClickRemove()">
	<input type="button" value="Upload!" onClick="document.JUpload.jsClickUpload()">
</form>
 -->
<!-- for skins:
<applet ...
archive="skinlf.jar,jupload.jar"
... alt="JUpload Applet">
-->
	<applet 
		code="JUpload/startup.class"
		archive="jupload.jar"
		width="0"
		height="0"
		mayscript
		name="JUpload"
		alt="JUpload by www.jupload.biz">
	
		<!-- Java Plug-In Options -->
		<param name="boxmessage" value="Laster inn javaapplet - vennligst vent...">
		<param name="boxbgcolor" value="#e0e0ff">
		<param name="backgroundColor" value="#e0e0ff">
		<param name="actionURL" value="<%=strPgProcess%>">
		<param name="completeURL" value="<%=strPgMain & "?frame=" & strPgResult%>">
		<param name="defaultAddDirectory" value="E:\MyDocs\Bilder">
		<param name="progressbar" value="true">
		<param name="checkResponse" value="false">
		<param name="realTimeResponse" value="false">
		<param name="showSuccessDialog" value="false">
		<param name="showPicturePreview" value="true">
		<param name="imageFileFilter" value="false">
		<param name="mainSplitpaneLocation" value="0">
		<param name="hideAddButton" value="true">
		<param name="hideRemoveButton" value="true">
		<param name="hideUploadButton" value="true">
		<param name="showStatusPanel" value="false">
		<param name="checkJavaVersion" value="true">
		<param name="checkJavaVersionGotoURL" value="http://www.java.com/">
		
		<!-- Unused params:
		<param name="useRecursivePaths" value="false">
		<param name="errorURL" value="http://www.example.com/upload-error.html">
		<param name="skinThemePackURL" value="aquathemepack.zip">
		<param name="debug" value="false">
		<param name="debugLogfile" value="c:/jupload.log">
		<param name="customFileFilter" value="true">
		<param name="customFileFilterDescription" value="Bilddateien (Jpeg und GIF)">
		<param name="customFileFilterExtensions" value="gif,jpg,jpeg">
		-->
		
		<!-- Additional params:
		<param name="hideShowAll" value="false">
		<param name="askAuthentification" value="false">
		<param name="tagName" value="uploadedFiles">
		<param name="addWindowTitle" value="Dateien auswählen">
		<param name="imageURL" value="../images/applet-logo.gif">
		<param name="labelFiles" value="Dateien:">
		<param name="labelbytes" value="Größe:">
		<param name="labelAdd" value="Hinzufügen">
		<param name="labelRemove" value="Entfernen">
		<param name="labelUpload" value="Hochladen">
		<param name="successDialogMessage" value="Hochladen war erfolgreich">
		<param name="successDialogTitle" value="Alles Okay!">
		<param name="addToolTip" value="Klicken um Dateien hinzuzufügen">
		<param name="removeToolTip" value="Klicken um Dateien zu entfernen">
		<param name="uploadToolTip" value="Klicken um gewählte Dateien zu übertragen">
		<param name="maxFreeSpaceOnServer" value="20000000">
		<param name="maxFreeSpaceOnServerWarning" value="Ihr Server-Account ist überfüllt!">
		<param name="maxFreeSpaceOnServerTitle" value="Serverplatz reicht nicht aus">
		<param name="maxTotalRequestSize" value="2000000">
		<param name="showServerResponse" value="true">
		<param name="preselectedFiles"
		value="d:/webcam1.jpg;d:/webcam2.jpg">
		-->
		 Your browser does not support applets. Or you have disabled applet in your options.
		 To use this applet, please install the newest version of Sun's java. You can get it from <a href="http://www.java.com/">java.com</a>
		
	</applet>
	<div id="main">
		<table id="uploadlist" cellpading="1" cellspacing="0" width="400">
			<thead>
				<tr bgcolor="black" style="color:#FFFFFF;"><td>&nbsp;</td>
				<td align="left"><b>File</b></td>
				<td align="right"><b>Size</b></td><td>&nbsp;</td></tr>
			</thead>
			<tbody id="uploadlistbody">
				<tr><td>&nbsp;</td><td>Please add files by using the <img src="images/add.gif" alt="" /> icon in your lower right</td></tr>
			</tbody>
			<tr>
				<td style="border-top:1px solid black;" colspan="4" align="right">
					<img onMouseOver="this.style.cursor='hand';" onMouseOut="this.style.cursor='pointer';" onClick="document.JUpload.jsClickAdd();" src="images/add.gif" title="Add files to the list" border="0">
					&nbsp;&nbsp;<img onMouseOver="this.style.cusror='hand';" onMouseOut="this.style.cusror='pointer';" onclick="document.JUpload.jsClickUpload();" src="images/upload.gif" title="Upload the files in the queue" border="0">
				</td>
			</tr>
		</table>

		<div align="center" id="progressStatus" style="z-index:1; width:221px;  height:70px; padding:5px 5px 5px 5px; margin: 5px 5px 5px 5px; display:none;">
			<div id="progbar" align="left" style="border: 1px solid black; width:200px; height:6px; background-color:white;"><img src="images/b.gif" width="1%" height="6" id="bar" /></div>
			<div id="progbarstats" align="center" style="width:200px; height:20px; background-color:white;">Progress: 0%</div>
		</div>
	</div>
</body>
</html>
