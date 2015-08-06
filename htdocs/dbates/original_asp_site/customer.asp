<%@ LANGUAGE = PerlScript %>  
<!--#Include virtual="/component/Redirect.asp"-->
<%&CheckAccount('public','0');%>
<!--#Include virtual="/component/SQLTable.asp"-->                     
<!--#Include virtual="/component/DocTable.asp"-->                     
<html>

<head>
	<title>Durham and Bates - Customer Resources</title>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<meta name="keywords" content="Durham, Bates, insurance, risk, management, consult, oregon, washington, customer, resource, article, liability, employment, regulations, d&o">
</head>
<body topmargin="0" leftmargin="0">
<!--#Include virtual="/component/PreToc.asp"-->
	<img src="/resource/title.jpg" ><br>
	<img src="/resource/t_resource.jpg"><br>
	<p>In this Age of Information, it is more difficult than ever to weed out all the relevant information that can impact your business.  We want to be a resource provider that you can count on to compile and report only the most important developments that may influence the success of your business.  Our associates are developing timely material that we believe will benefit you, from in-depth packets to brief newsletters.</p>
	<p><b>Featured Articles</b></p>
        <ul>
      		<%$DocTable->DocList('article',1);%>     
        </ul>  
	<p><b><em>D&B Focus</em> articles</b></p>
        <ul>
      		<%$DocTable->DocList('page');%>     
        </ul>  

	<p><b>Partnerships</b></p>
        <ul>
                <li>
                        <p>
                        <a href="http://www.barran.com/free_electronic_alerts.htm" target="_new">Free Electronic Alerts from Barran Liebman LLP</a>
                        &nbsp; &nbsp;
                        Through our partnership with the Northwest Labor and Employment law firm Barran Liebman, Durham and Bates invites you to utilize an excellent resource for receiving updated information essential for all employers. These alerts summarize the most recent developments in employee and labor case law and statutes. You can visit the Barran and Liebman website directly and subscribe to their free service or browse the current and archived articles.
                        </p>
                </li>
        </ul>
	<p><b>Archived Articles</b></p>
		<ul>
		<%$DocTable->DocList('article', 0);%>     
		</ul>
<!--#Include virtual="/component/MidToc.asp"-->
<!--#Include virtual="/component/PostToc.asp"-->
</body>
</html>
