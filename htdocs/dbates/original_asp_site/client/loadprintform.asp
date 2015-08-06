<%@ LANGUAGE = PerlScript %>   
<!--#Include virtual="/component/Redirect.asp"-->
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"-->  
<!--#Include virtual="/component/ClientTable.asp"-->  
<%                         
$ThisForm = ${$Request->QueryString}{ID}{item};        
if (-e $Server->MapPath('/client/'.$ThisForm))
	{
	$Session->{'RedirectTarget'} = '/client/'.$ThisForm;
	&ConfirmPrivacy2;
	}
else     
	{
	push @Alert, "Requested form could not be found";
	%>			
	<html><head>
        <script language="javascript">
        <!--
        <% for (@Alert) {%>alert("<%=$_%>");<%}%>
	location.href="/client";
        //-->
        </script>
        </head>
	<body><h1>hi!</h1></body>
	</html>
	<%
	exit;
	}   
	%>