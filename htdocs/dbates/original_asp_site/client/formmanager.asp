<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('client','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/SubmissionTable.asp"--> 
<%   

if (${$Request->QueryString}{Delete}{item} != 1)
	{
        %>                    
        <html>
        <head>
        	<title>Durham and Bates - Submissions Manager</title>
        	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
        	<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, form, application, client, interactive, certificate, MVR, report">
        </head>
        <body topmargin="0" leftmargin="0">
        <!--#Include virtual="/component/PreToc.asp"-->
        	<img src="/resource/title.jpg" ><br>
        	<img src="/resource/t_submgr.jpg"><br>
        	<p>Below are <a href="/forms.asp">forms and applications</a> which you have previously submitted to Durham and Bates.  Click on:</p>
        	<table style="margin-left:10pt;margin-right:10pt;">
        		<!--<tr><td align="right" valign="top"><img src='/resource/incomplete.jpg'></td><td>To load an incomplete submission that you had previously saved.</td></tr>
        		<tr><td align="right" valign="top"><img src='/resource/delete.jpg'></td><td>To delete a saved, incomplete submission which you will not be sending to Durham and Bates.</td></tr>
			-->
        		<tr><td align="right" valign="top"><img src='/resource/complete.jpg'></td><td>To view a completed submission</td></tr>
        		<tr><td align="right" valign="top"><img src='/resource/clone.jpg'></td><td>To copy a previously completed submission to a new, active submission.  This is useful for report forms which change only slightly during each reporting period.</td></tr>
        	</table>
        	<img src="/resource/linetab.gif"><br>
        
        	<%$SubmissionTable->SubmissionList;%>
                <br>
        <!--#Include virtual="/component/MidToc.asp"-->
        <!--#Include virtual="/component/PostToc.asp"-->
        </body>
        </html>
	<%
	} 

else
	{
	$TransID = ${$Request->QueryString}{TransID}{item};
	if ($SubmissionTable->DeleteRecord("TransID='$TransID'","$TransID"))
		{push @Alert, "Your saved submission has been deleted";}
	else
		{push @Alert, "Your saved submission was not deleted";}
	%>        
        <html>
        <head>
        	<script language="javascript">
        	<!--
        		<% for (@Alert) {%>alert("<%=$_%>");<%}%>
        		location.href="/client/FormManager.asp";
        	//-->
        	</script>
        </head>
        </html>
	<%
	}
%>
