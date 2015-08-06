<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/" xml:space="preserve">

<html>
        <head>
        	<title>D&amp;B Forms</title>
		<style type="text/css">
                        @page 
                        	{ 
                        	size 8.5in 11in; 
                        	margin: 1in; 
                        	}
                        
                        a
                                {
                        	font-weight: normal;
                        	text-decoration: underline;
                        	color: #063DAE;
                        	}
                        
                        a:hover
                                {
                        	color: #C00000;
                        	}
                        
                        body
                                {
                        	font-family: verdana, arial, helvetica, sans-serif;
                        	font-size: 9pt;
                                } 
                        
                        form	{
                        	margin: 2pt; 
                        	}           
                        
                        h1	{margin: 5pt;}
                        h2	{margin: 5pt;}
                        h3	{font-size: 12pt; margin: 5pt;}
                        h4	{font-size: 10pt; margin: 5pt;} 
                        
                        hr	{margin: 0pt;} 
                        
                        li
                        	{list-style-type: disc;}
                        p
                                { 
                                font-size: 9pt;
                        	margin: 5pt;
                                }  
                        
                        td
                        	{
                        	padding-left:5pt;
                        	font-size: 10pt;
                        	}      
			textarea {font-family: verdana, helvetica, sans;}                        
                        #PageTable
                        	{ 
				width:560px;
                        	background-color: #F0F0FF;  
                        	margin-left:10pt; 
                        	margin-right:10pt;  
                        	page-break-inside:avoid;
                        	}  
                        
                        #MainTable
                        	{
                        	width:600px;
                        	background-color: #E0E0FF;
                        	}   
                        
                        #SubmissionBar
                        	{              
                        	font-weight: bold;
                        	background-color: #001060; 
                        	color: white;
                        	} 
                        
                        #TemplateBar
                        	{              
                        	font-weight: bold;
                        	background-color: navy; 
                        	color: white;
                        	}
                        	        
                        
                        #section
                        	{              
                        	font-weight: bold;
                        	font-size: 9pt;
                        	background-color: black; 
                        	color: white;    
                        	}    
                        
                        #subsection
                        	{              
                        	font-weight: bold;
                        	font-size: 9pt;
                        	background-color: navy; 
                        	color: white; 
                        	}
                        
                        #subheading
                        	{              
                        	font-weight: bold;
                        	font-size: 9pt;
                        	background-color: #A0A0A0; 
                        	color: white;
                        	}
                        	
                        .incomplete
                        	{    
                        	background-color: yellow; 
                        	}
                        
                        #AutoTotal
                        	{ 
                        	background-color: navy;
                        	color: white;
                        	font-weight: bold;
                        	}
                        
                        #less
                        	{
                        	font-size: 7pt;
                        	}   
                        
                        #displayValue
                        	{
                        	border: solid blue 1px;
                        	text-align:left;
                        	width: 100%; 
				padding: 3px;
                        	}
                        
                        #FormerTextArea
                        	{
                        	background-color:white;
                        	border: solid blue 1px;
                        	color:black;
                        	width:100%;
                        	}
                        #show
                        	{                      
				border: solid blue 1px;
                        	background-color:white;
                        	color:black;
				padding: 3px;
                        	}
		</style>
        	<script language="javascript" src="http://www.dbates.com/component/forms/validation.js"></script>
        </head>
        <body topmargin="0" leftmargin="0">
		<table id="MainTable" cellspacing="0pt" cellpadding="0pt" border="0">      
        		<tr>
        			<td id="SubmissionBar"> 
                                	<h3><xsl:value-of select="/submission/ClientTable/Name"/></h3>
        			</td>
        		</tr>  
        		<tr>
        			<td id="TemplateBar"> 
                                	<h4><xsl:value-of select="/submission/SubmissionTable/SubmissionTitle"/></h4>
				</td>
			</tr>   
                	<tr id="section">
				<td>
					<h4>
					Submission #
					<xsl:value-of select="/submission/SubmissionTable/TransID"/>: 
					<xsl:comment>SubmissionTime</xsl:comment>
					</h4>
				</td>
			</tr>
			<tr>
				<td><p style="margin-left:15pt;"><xsl:value-of select="//page[@active]/@instructions"/></p></td>
        		</tr>
			<tr>
				<td style="padding-bottom: 12px;">                   
					<xsl:comment>SubmissionContent</xsl:comment>
				</td>
			</tr>
		</table>
	</body>
</html>

</xsl:template>  
              
</xsl:stylesheet>
