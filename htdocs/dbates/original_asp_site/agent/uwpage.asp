<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/AssociateTable.asp"--> 
<!--#Include virtual="/component/UWTable.asp"--> 

<%
if (${$Request->ServerVariables}{REQUEST_METHOD}{item} =~ m{get}i)
	{
        $UWID=${$Request->QueryString}{ID}{item}; 
        $UWRecord = $UWTable->GetRecord("ID='$UWID'",''); 
	$UWNAME=${$UWTable->FieldData}{'Name'}{value}[0];
	$UWROOT=${$UWTable->FieldData}{'Folder'}{value}[0];
        %>                                                                                  
        <html>
        <head>
        	<title>File Transfer Area</title> 
        	<link rel="stylesheet" type="text/css" href="/agent/document/resource/agent.css">
        	<style>
        		td.hdl
        			{
        			text-align: center;
        			empty-cells: show;
        			font-family: verdana, helvetica, arial, sans;
        			font-size: 10px;
        			padding: 2px;
        			background-color: #EEEEFF;
        			}
        		td.dl
        			{
        			border-right: solid black 1px;
        			text-align: center;
        			empty-cells: show;
        			font-family: verdana, helvetica, arial, sans;
        			font-size: 10px;
        			padding: 2px;
        			}
        	</style>
        </head>
        <body>                                                                                          
        <h1 style="margin-bottom: 0px;">File Transfer Area</h1>
        <h3 style="margin-bottom: 0px;">Account: <%=${$UWTable->FieldData}{'Name'}{value}[0]%></h3>
        <h2 style="margin-top: 20px;">Upload New Files</h2>   
        <hr style="width: 500px; text-align: left;"/>

        <form action="uwpage.aspx" name="DBForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="UWID" value="<%=$UWID%>"/>
		<input type="hidden" name="UWNAME" value="<%=$UWNAME%>"/>
		<input type="hidden" name="UWROOT" value="<%=$UWROOT%>"/>
	<table>
		<tr>
			<td style="border-bottom: solid black 1px;"/>
			<td style="text-align: center; border-bottom: solid black 1px;">Select file to post</td>
			<td style="text-align: center; border-bottom: solid black 1px;">Description of file and/or any neccessary notes.</td>
		</tr>                                              
		<%
		for ($index=1; $index<=8; $index++)
			{%>
		
		<tr>
			<td style="background-color:<%=$index%2?'#EEEEFF':''%>"><%=$index%>.</td>
			<td style="background-color:<%=$index%2?'#EEEEFF':''%>"><p><input type="file" name="Location<%=$index%>" required="1"></p></td>
			<td style="background-color:<%=$index%2?'#EEEEFF':''%>"><p><textarea rows="1" cols="40" name="Notes<%=$index%>" wrap="virtual" required="1"></textarea></p></td>
		</tr>
			<%}
		%>
		<tr>
			<td colspan="3" style="text-align:center; border-top: solid black 1px;"><p><input type="submit" value="Send Files"><input type="button" value="Cancel" onClick="location.href='cpmain.asp'"></p></td>
		</tr>
	</table>



        <h2 style="margin-top: 25px;">View/Delete Current Files</h2>
        <hr style="width: 500px; text-align: left;"/>
        <%                     
        $DocRoot = $Server->MapPath('/');                   
        $UWRoot = $DocRoot.'/data/uw/'.${$UWTable->FieldData}{'Folder'}{value}[0];
        if (-e $UWRoot.'/index.xml')
        	{
        	$DB = Win32::OLE->new('Msxml2.DOMDocument.4.0');
        	$DB->load($UWRoot.'/index.xml');
        	$XSL = Win32::OLE->new('Msxml2.DOMDocument.4.0');
        	$XSL->load($DocRoot.'/component/uwpage.xsl');
        	$Folder = $XSL->selectSingleNode('//*[@name="Folder"]');
        	$Folder->{text} = ${$UWTable->FieldData}{'Folder'}{value}[0];
        	$UWNode = $XSL->selectSingleNode('//*[@name="UWID"]');
        	$UWNode->{text} = $UWID;
        	$UWRootNode = $XSL->selectSingleNode('//*[@name="Folder"]');
        	$UWRootNode->{text} = ${$UWTable->FieldData}{'Folder'}{value}[0];
        	$FileItems = $DB->selectNodes('/index/item');
        	if ($FileItems->length > 0)
        		{
        %>
        <table style="width: 600px; margin-top: 0px; empty-cells: show;" cellspacing="0">
        	<tr>
        		<td class="hdl" style="width: 40px;">Date</td>
        		<td class="hdl" style="width: 60px;">File</td>
        		<td class="hdl" style="width: 40px;">Size</td>
        		<td class="hdl">Notes</td>
        		<td class="hdl" style="width: 60px;">&nbsp;</td>
        	</tr>
        <%
                	for ($ItemIndex = -1+$FileItems->length; $ItemIndex >= 0 ; $ItemIndex--)
                		{
                		$FileItem = $FileItems->item($ItemIndex)->getAttribute('file');		
                		if (-e $UWRoot.'/'.$FileItem)
                			{                                       
                			$ThisFile = $FileItems->item($ItemIndex)->transformNode($XSL);
                			$Response->write($ThisFile);
                			}
                		}
        		$Response->write('</table>');
        		}
        	else	{$Response->write("<hr/><p>No Files Found.</p>");}
        
        	}
        else	{$Response->write("<hr/><p>No Files Found.</p>");}
        
        %>
        <hr style="width: 500px; text-align: left;"/>
	<p style="margin-left: 30px;">
        	<input type="button" value="Done" onClick="location.href='cpmain.asp'">
	</p>   
	</form>
        </body>
        </html>
	<%
	}%>

