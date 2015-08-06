<%@Language=VBScript%>
<% Option Explicit %>
<!--#include file="vars.inc"-->
<%
	Dim strFrame, strFrameSrc
	
	strFrame = request.querystring("frame")

	if strFrame <> "" then
		strFrameSrc = strFrame
	else
		strFrameSrc = strPgQueue
	end if

%>

<iframe src="<%=strFrameSrc%>" width="600" height="400" frameborder="0"></iframe>