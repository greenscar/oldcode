<%@ LANGUAGE = JavaScript debug="true" %>   
<%                          
var DocRoot = Server.MapPath('/');          
var UploadInfo = Server.CreateObject('Msxml2.DOMDocument.3.0');
var TransID = Request.Form('TransID');
var UploadIndex = DocRoot+'_private\\client\\forms\\'+TransID+'\\index.xml';
if (!UploadInfo.load(UploadIndex))
	{UploadInfo.loadXML('<attachments />');}
var Attachments = UploadInfo.documentElement;

for (var i=0; i<Request.Files.Count-1; i++)
	{                            
	var ThisFile = Request.Files[i];
	var FileSize = ThisFile.ContentLength;
	if (FileSize > 0)
		{
                var FilePath = ThisFile.FileName;
        	var FileNames = FilePath.split('\\');
        	var FileName = FileNames[FileNames.length - 1];
        	var FileType = ThisFile.ContentType;
        	//later need to create seperate folders based on sessionid with form inside
        	var StoragePath = DocRoot+'_private\\client\\forms\\'+TransID+'\\'+FileName;
                var SaveStatus = ThisFile.SaveAs(StoragePath);
        
        	var ThisAttachment = UploadInfo.createElement('attachment');
        	ThisAttachment.setAttribute('name', FileName);
        	ThisAttachment.setAttribute('size', FileSize);
        	ThisAttachment.setAttribute('type', FileType);
        	ThisAttachment.setAttribute('path', StoragePath);
        	Attachments.appendChild(ThisAttachment);
		}
	}

UploadInfo.save(UploadIndex);
Session('task')=0;
Response.Redirect("finishsubmission.asp");
%>