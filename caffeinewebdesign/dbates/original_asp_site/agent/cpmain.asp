<%@ LANGUAGE = PerlScript %>
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('agent','1');%>                
<html>
<head>
	<link REL="stylesheet" TYPE="text/css" HREF="/agent/document/resource/agent.css">
        <script language="javascript">
                <!--
                function TID(formObj)
                	{
                	TID=formObj.TID1.value+"-"+formObj.TID2.value+"-"+formObj.TID3.value+"-"+formObj.TID4.value;
                	formObj.TransID.value=TID;
			formObj.submit();
                	}
                function Delphi(formObj)
                	{
                	if (formObj[0].value.length < 2)
                		{alert("Please enter a valid client code");
                		return false;
                		}
                
                	else
                		{formObj.submit();
                		return true;
                		}
                	} 
                //-->
        </script>
</head>
<body>
<a name="top"></a>
<table width="95%" align="center" bgcolor="#FFFFFF" cellspacing="0px" cellpadding="3px"> 
<tr valign="center" bgcolor="#000000">
	<td colspan="2" bgcolor="black" align="center">
		<font color="white"><b>Form & Application Submissions</b></font>
	</td></tr>
<tr valign="center" bgcolor="#DDDDDD">
	<td bgcolor="blue" width="4px">&nbsp;</td>
	<td>
		<li>
			<form action="FormManager.asp" method="get" style="margin:0pt;"> 
        			<input type="text" size="6" name="ID"> 
        			<input type="submit" value="View by Client ID">
				 (Leave blank to view all clients.)
			</form>
		</li>
		<li>
			<form action="RetrieveForm.asp" method="get" style="margin:0pt;"> 
				<input type="hidden" name="TransID"/>
        			<input type="text" size="4" name="TID1">-
        			<input type="text" size="3" name="TID2">-
        			<input type="text" size="3" name="TID3">-
        			<input type="text" size="2" name="TID4">&nbsp;
        			<input type="button" value="View by Transaction ID" onClick="TID(this.form)">
			</form>
		</li>
	</td>
	</tr>
</table>

<table width="95%" align="center" bgcolor="#FFFFFF" cellspacing="0px" cellpadding="3px"> 
<tr valign="top" bgcolor="#DDDDDD" >
	<td colspan="4" bgcolor="black" align="center">
		<font color="white"><b>Databases</b></font>
	</td></tr>
<tr valign="top" bgcolor="#DDDDDD" > 
	<td bgcolor="forestgreen" width="4px">&nbsp;</td>
	<td>
	<b>Client Web Accounts</b><br>
	<li><a href="ViewClient.asp">View/Edit Clients</a></li>
	<li><b>View/Add Clients by Delphi ID</b></li>
	<ul><li><form action="EditClient.asp" method="get" onSubmit="return Delphi(this)">
			<input type="text" size="8" name="ID">
			&nbsp;<input type="submit" value="Go">
			</form> </li></ul>

	</td>
<td bgcolor="gold" width="4px">&nbsp;</td>
<td>	
<b>Underwriter Access</b> <br>
	<li><a href="ViewUW.asp">Underwriter pages</a></li>
	<li><b>View/Add Undewriter</b></li>
	<ul><li><form action="EditUW.asp" method="get" onSubmit="return Delphi(this)">
			<input type="text" size="8" name="ID">
			&nbsp;<input type="submit" value="Go">
			</form> </li></ul>
</td>
</tr>	    

<tr valign="top" bgcolor="#DDDDDD" > 
<td bgcolor="gold" width="4px">&nbsp;</td>
<td>
<b>Document Databases</b><br>         
	<li><a href="EditDoc.asp">View/Edit Documents</a></li>
	<li><a href="AddDoc.asp">Upload New Document</a></li>
	<li><a href="AddPage.asp">Reference Existing Page</a></li>
</td>                        
<td bgcolor="forestgreen" width="4px">&nbsp;</td>
	<td>
	<b>D&B Associates</b><br>
	<li><a href="ViewAssociate.asp">View/Edit Associate Profiles</a></li>
	<li><b>View/Add Associates by Delphi ID</b></li>
	<ul><li><form action="EditAssociate.asp" method="get" onSubmit="return Delphi(this)">
			<input type="text" size="8" name="ID">
			&nbsp;<input type="submit" value="Go">
			</form> </li></ul>

	</td></tr>
<tr valign="top" bgcolor="#DDDDDD" > 
	<!--
	<td bgcolor="blue" width="4px">&nbsp;</td>
	<td>
		<b>Site Activity Log</b><br>
		<li><a href="ViewLog.asp?type=agent"><b>View Agent Log</b></a></li>
		<li><a href="ViewLog.asp?type=client"><b>View Client Log</b></a></li>
	</td>  
	-->
        <td bgcolor="blue" width="4px">&nbsp;</td>
        <td>	
        <b>Web Link Database</b> <br>
        	<li><a href="ViewLink.asp">View/Edit links</a></li>
        	<li><a href="EditLink.asp">Add New Link</a></li>
        </td>

	<td bgcolor="#C00000" width="4px">&nbsp;</td>
	<td>
		<b>Utilities</b><br>
		<li><a href="identity.asp"><b>Mail Monitor Settings</b></a></li>     
		<li><a href="cpother.asp"><b>The <em>Other</em> Control Panel</b></a></li>
		<li><a href="https://www.dbates.com/stats"><b>Verio Site Settings</b></a></li>
	</td>

</tr>
</table>       

<br>
<hr size="5">
<h2><a name="help"></a>About the Control Panel</h2>

<p>This web page is the main control panel for the agents' area of the Durham and 
Bates web site. It's divided into two main sections:</p>
<ul>
<li><b>The navigation bar at the top.</b>  This bar will be always be visible 
as you navigate to different parts of the agents' site.  It includes the "@dbates.com" button,
which will always return you to this control panel page.  There is also
a "suggestions" button in case you have any ideas to improve the site.  The
"www.dbates" button brings up the main www.dbates.com web site.  <font color="red">Finally, the "Help" button 
moves you to the help section of whatever page you're looking at (if such a help
 section exists; clicking again on the "Help" button takes you back to the top of your page.</font></li>
<li><b>The control panel.</b>  This includes various tools (described below) which allow to create and modify
 client accounts as well as the documents which they will see when they visit 
the client area of the website.</li>
</ul>                                
              
<h2>Control Panel Tools</h2>
<li><b>Form & Application Submissions.</b>  When clients fill out web forms, their information is saved to
a database.  When the form is first submitted, the agent will receive an e-mail which includes
 a link to that form.  Subsequently, if an agent wants
 to review a particular form submission it can be viewed by using one of the tools below.</li>
<ul><li><b>View Submissions By Client ID.</b>  This brings up a chronological
 log of form submissions, sorted by client ID.  Leaving the ID lists all form submissions.  
<li><b>View Form Submissions by Transaction ID.</b>  After the client has 
successfully sent a web form, the submission is assigned a transaction number 
which can be referenced if there are any questions about a submission.</li></ul>

<li><b>Databases</b></li>
<ul>
<li><b>Client Web Accounts.</b>  Before a client can access the clients-only area of the web site, an agent must grant them access by creating 
a web account.  The web account contains basic information about the client, 
such as their name and contact information, as well as account information such as
the departments, producers and service representatives who serve that client.  The 
client account also includes <b>profile information</b>, from which the web site 
will custom-create web pages for the client -- only containing the articles, forms, news and links 
 which are relevant to the particular client.</li>
<ul><li><b>View/Edit Clients.</b>  This page displays an index of all the client profiles. 
Clicking on a particular client's ID (left column) brings up their account information,
 from which information can be changed, the client's password can be reset, or the account
 may be deleted.</li>
<li><b>View/Add Clients by Delphi ID.</b>  The clients log in to the website using 
a username and a password.  For convenience, their username is the same as their 
Delphi ID.  From this tool you may:
	<ul><li><b>Call up a client's account</b> by their Delphi ID.</li>
	<li>If the client doesn't have an account yet, you will be asked whether you
 would like to <b>create a new account</b> for this client.</li></ul>
</li></ul>

<li><b>Document Databases.</b>  The web site will ultimately contain many, many different documents 
for clients and the general public -- including articles, event listings and news items.  By using the 
tools listed below, associates may create, organize, rearrange and remove these documents.</li>
<ul><li><b>View/Edit Documents.</b>  This tool brings up a list of all the documents in the database.  From there you may change the 
properties of the document (location, client/public, expiration date) or remove the document.</li>
<li><b>Upload new page.</b>  Using this tool you may import a document you have created in Microsoft Word into the web site's document database.  This
 is most useful for short documents, such as news items or articles.  Longer, more involved documents may need to be created and posted manually.
</li>
<li><b>Reference existing page.</b>  This is used to include permanent parts of the site (such as forms, department pages, and tutorials) in client searches for relevant materials.</li>
</ul> 


<li><b>Web Link Database.</b>  All of the links (to other websites) are stored in 
a central database.  Which particular links a client will see depends on his/her profile, as
 well as the profile of the link.</li>
<ul><li><b>View/Edit Links.</b>  This brings up an index of all the links in the database.  From
 here you can edit the properties of the link, or view the link's site.</li>
<li><b>Add New Link.</b></li>
</ul>

<li><b>Underwriter Pages</b>  Associates may upload large image files to the web server so that underwriters may view and/or download them later.  Each underwriter is granted a username/password with 
which they can browse a folder containing images uploaded specifically for them.
<ul><li><b>Underwriter pages</b>  This brings up a list of all the underwriter accounts.  Clicking on the underwriter ID allows you to edit the account information for that underwriter.  Clicking on the underwriter's name allows you to upload, view and delete image files.</li>
<li><b>View/Add underwriter.</b>  After an underwriter code is entered into the form field, the database is searched for a matching underwriter profile.  If no profile exists for that underwriter, a new account is created.</li>
</ul></li>  

<li><b>D&B Associates.</b>  Associate information for the D&B office directory is kept in a central database.  Instead of a webmaster 
having to update each of the web pages when an associate's information changes, just the associate's database entry is updated.  The associate's profile
contains name, title, department, and contact information.
<ul><li><b>View/Edit associates.</b>  This brings up a list of all the associates in the database.  Clicking on an associate brings up their profile, which can be edited or deleted.</li>
<li><b>View/Add associates.</b>  After a Delphi associate code is entered into the form field, the database is searched for a matching associate profile.  If no profile exists for that client, a new profile is created.</li>
</ul></li>  

<!--<li><b>Site Activity Log.</b>  For security and E&O purposes the site keeps a log of important transactions.  You may view either agent or client activities, sorted chronologically.</li>-->

<li><b>Utilities</b>
	<ul>
		<li><b>Mail Monitor Settings</b>  This sets the e-mail addresses for receiving client mail, the site monitor at D&B, and the webmaster.
		</li>
		<li><b>The other control panel</b> This will eventually contain tools for maintaining the site's database.</li>
		<li><b>Verio Site Settings</b>  This provides access to the general site settings through Verio's control panel.
		</li>
	</ul>
</li>
</ul>
	
</body>
</html>
