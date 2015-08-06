<%@ LANGUAGE = JavaScript debug="true" %>   
<%
if (Request.Cookies('clientDurhamAndBates').Value.length<3) {Response.Redirect("/client");}
var Client = Request.Cookies('clientDurhamAndBates')('ID');
var Doc = Request.QueryString('ID');
var RecvdFilePath = Server.MapPath("/_private/client/"+Client+"/"+Doc);
Response.Buffer = 1;
Response.Clear();
//Response.ContentType="application/octet-stream";
Response.ContentType="application/pdf";
//Response.AddHeader("content-disposition","attachment; filename="+Doc);
Response.WriteFile(RecvdFilePath); 
Response.Flush;
Response.End;
%>