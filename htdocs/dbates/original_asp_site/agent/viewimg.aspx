<%@ LANGUAGE = JavaScript debug="true" %>   
<%
//if (Request.Cookies('agentDurhamAndBates').Value.length<3) {Response.Redirect("/agent/cpmain.asp");}
var UWID = Request.QueryString('UWID');
var UWRoot = Request.QueryString('UWROOT');
var RecvdFile = Request.QueryString('id');
var RecvdFilePath = Server.MapPath("/data/uw/"+UWRoot+"/"+RecvdFile);
Response.Buffer = 1;
Response.Clear();
Response.ContentType="application/octet-stream";
Response.AddHeader("content-disposition","attachment; filename="+RecvdFile);
Response.WriteFile(RecvdFilePath); 
Response.Flush;
Response.End;
%>
