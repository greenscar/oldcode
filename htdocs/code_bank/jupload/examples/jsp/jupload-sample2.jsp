<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Upload Page</title>
</head>
<body>

URL of this page is http://localhost:8080/photo/jsp/fileUploadApplet.jsp
<BR>

<applet 
	code="JUpload/startup.class"
	archive="/photo/client/JUpload.jar"
	width="450"
	height="200">

	<PARAM NAME="debug" VALUE="true">
	<PARAM NAME="fixJakartaBug" VALUE="true">

	<param name="actionURL" value="http://localhost:8080/photo/jsp/fileUploadAppletProcessor.jsp">
	<param name="imageURL" value="/photo/images/JUpload.gif">
	<PARAM NAME="checkResponse" VALUE="true">
</applet>


</body>
</html>