<%@ LANGUAGE = PerlScript %>     

<%
#      
$DocRoot = $Server->MapPath('/');
@FileInfo = stat("$DocRoot/about/shiptour/ships.xml");
open (SHIPS, "<$DocRoot/about/shiptour/ships.xml") || die "$! $DocRoot"; 
read (SHIPS, $ShipsFile, $FileInfo[7]);
close (SHIPS);

$ShipItem = $Request->QueryString('item')->item; 
if (length($ShipItem) == 0) {$ShipItem = 1;}
$ShipPrev = ((14 + $ShipItem) % 16) + 1; 
$ShipNext = ($ShipItem % 16) +1;
                         
($ThisShip) = $ShipsFile =~ m{<ship id='$ShipItem'>(.*?)</ship>}isg;
undef $ShipsFile;

($ShipTitle) = $ThisShip =~ m{<title>(.*?)</title>}isg;
(@Points) = $ThisShip =~ m{<point>(.*?)</point>}isg;
#$ShipImage = "ship$ShipItem.jpg";
$ShipImage = "coming.gif";
%>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="/resource/dbates.css">
	<title>Virtual Tour of Model Ships</title>
</head>    

<body topmargin="0" leftmargin="0">
<table align="center" border="1" width='470px' cellpadding="3pt">
	<tr>
		<td>
		<center><img src="<%= $ShipImage %>"></center>
		<br>
		<p><b><%= $ShipItem%>. "<%= $ShipTitle %>"</b></p>
			<ul>
                                <%
                                for (@Points)
                                	{
                                %>
                                	<li><%= $_ %></li>
                                <%
                                	}
                                %>   
                        </ul> 
		</td>
	</tr>
	<tr>
		<td>
		<center>
		<a href="tour.asp?item=<%=$ShipPrev%>"><img src="/resource/dialp.jpg" border="0" width="30" height="37"></a>
		<img src="/resource/modelship.jpg">
		<a href="tour.asp?item=<%=$ShipNext%>"><img src="/resource/dialn.jpg" border="0" width="32" height="37"></a>
		</center>
		</td>
	</tr>        
	<tr>
		<td>
                <MAP NAME="OfficeMap">
                        <AREA SHAPE="RECT" COORDS="298,100,316,117" HREF="tour.asp?item=1" alt="SOVEREIGN OF THE SEAS">
                        <AREA SHAPE="RECT" COORDS="298,119,316,136" HREF="tour.asp?item=2" alt="U.S.S. CONSTITUTION - 'OLD IRONSIDES'">
                        <AREA SHAPE="RECT" COORDS="298,138,316,155" HREF="tour.asp?item=3" alt="THE SEA WITCH">
                        <AREA SHAPE="RECT" COORDS="376,101,395,117" HREF="tour.asp?item=4" alt="BROTHER JONATHAN">
                        <AREA SHAPE="RECT" COORDS="430,101,448,117" HREF="tour.asp?item=5" alt="TYPHOON">
                        <AREA SHAPE="RECT" COORDS="394,124,412,141" HREF="tour.asp?item=6" alt="Old Dutch SHOKKOR">
                        <AREA SHAPE="RECT" COORDS="351,170,371,189" HREF="tour.asp?item=7" alt="UNTITLED">
                        <AREA SHAPE="RECT" COORDS="424,181,442,199" HREF="tour.asp?item=8" alt="ELSIE">
                        <AREA SHAPE="RECT" COORDS="286,193,306,212" HREF="tour.asp?item=9" alt="Old Dutch TJALK">
                        <AREA SHAPE="RECT" COORDS="192,165,217,183" HREF="tour.asp?item=10" alt="VINTA">
                        <AREA SHAPE="RECT" COORDS="21,106,44,124" HREF="tour.asp?item=11" alt="FELUCCA or XEBEC">
                        <AREA SHAPE="RECT" COORDS="49,14,73,31" HREF="tour.asp?item=12" alt="GLAD">
                        <AREA SHAPE="RECT" COORDS="103,25,128,44" HREF="tour.asp?item=13" alt="SCHOONER">
                        <AREA SHAPE="RECT" COORDS="180,42,206,61" HREF="tour.asp?item=14" alt="SPANISH GALLEON">
                        <AREA SHAPE="RECT" COORDS="234,31,259,48" HREF="tour.asp?item=15" alt="U.S.S. Constitution - 'Old Ironsides'">
                        <AREA SHAPE="RECT" COORDS="286,19,312,37" HREF="tour.asp?item=16" alt="SOVEREIGN OF THE SEAS">
                </MAP>
                <center>
		<p>Move forward/backward with the navigational arrows, or click directly on a ship number</p>
		<img src="shiptour.jpg" border="0" usemap="#OfficeMap"><br>
		<p><b>Durham and Bates Agencies Portland Office</b></p>
                </center> 
		</td>
	</tr>
</table>
</body>
</html>  
