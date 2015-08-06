<html>
<head><title>Craigs List</title></head>
<body>
<?php
$links = Array('Select' => '',
   'Furniture' => 'http://austin.craigslist.org/search/fur?query=&minAsk=min&maxAsk=max&addTwo=by-owner&hasPic=1', 
   'Computers' => 'http://austin.craigslist.org/search/sys?query=&minAsk=min&maxAsk=max&hasPic=1',
   'Electronics' => 'http://austin.craigslist.org/search/ele?hasPic=1',
   'Garden' => 'http://austin.craigslist.org/search/grd?hasPic=1',
   'Toys' => 'http://austin.craigslist.org/search/tag?hasPic=1',
   'General' => 'http://austin.craigslist.org/search/for?hasPic=1',
   'Household' => 'http://austin.craigslist.org/search/hsh?hasPic=1',
   'Materials' => 'http://austin.craigslist.org/search/mat?hasPic=1',
   'Photo' => 'http://austin.craigslist.org/search/pho?hasPic=1',
   'Sporting Goods' => 'http://austin.craigslist.org/search/spo?hasPic=1',
   'Tools' => 'http://austin.craigslist.org/search/tls?hasPic=1'
   );
?>
   <table align="center">
   <tr><th>Select a Category</th></tr>
   <tr>
      <td>
         <form name="selectType" method="get" action="index.php">
         <select name="cat" onChange="document.selectType.submit()">
         <?php
            foreach($links as $id=>$val)
            {
               echo("<option value=\"$id\"");
               if((isset($_GET["cat"])) && (strcmp($id, $_GET["cat"]) == 0))
               {
                  echo(" selected");
               }
               echo(">$id</option>\n\t");
            }
         ?>
         </select>
         </form>
      </td>
   </tr>
   </table>
<hr>
<?php
if((isset($_GET["cat"])) && (strcmp($_GET["cat"], "Select") != 0))
{
   //$dnss = array('http://austin.craigslist.org/search/fur?query=&minAsk=min&maxAsk=max&addTwo=by-owner&hasPic=1', 'http://austin.craigslist.org/search/sys?query=&minAsk=min&maxAsk=max&addTwo=&hasPic=1');//, "http://austin.craigslist.org/search/hsh?hasPic=1", "http://austin.craigslist.org/search/sys?query=network%20cable"); 
   $dns = $links[$_GET["cat"]];
   set_time_limit(360);
   $log = new Secretary();
   #usage:
   $sub_links = array();
   $x = 0;
   $s = array(0, 100, 200);
   foreach($s as $id => $count_start)
   {
      $r = new HTTPRequest($dns. "&s=$count_start");
      $page = $r->DownloadToString();
      $pic_in_image = "<span style=\"color:orange;\"> pic</span>";
      $array = explode("\n", $page);
      foreach($array as $id=>$val)
      {
         if(is_string($val))
         {
				//a href="/fur/484144706.html"
				$cat = $_GET["cat"];
				$link = "/[0-9]+\.html/";
				$haslink = preg_match($link, $val);
				if($haslink > 0) 
				{
					$open_loc = strpos($val, "<a href=\"");
					$link = substr($val, ($open_loc + 9));
					$close_pos = strpos($link, "\"");
					$link = substr($link, 0, $close_pos);
					$links = preg_split("/<span style=\"color\:orange;\">\ pic<\/span>/", $val);
					foreach($links as $id=>$val)
					{
						$val = trim($val);
						//echo("$id => $val<br>\n\n");
						// </p><p> Nov 19 - <a href="/fur/484134445.html">Sofa and Chair  with new slipcovers - $200</a><font size="-1"> (Leander)</font><br>
					   $openpos = strpos($val, "<a");
						$closepos = strpos($val, "</a>");
						$len = $closepos - $openpos + 4;
						$descrlink = substr($val, $openpos, $len);
						$linklen = strpos($descrlink, "\">");
						$sublink = substr($descrlink, 9, $linklen - 9); 
						$fulllink = "http://austin.craigslist.com" . $sublink;
						$r = new HTTPRequest($fulllink);
						#echo("<hr>");
						$subpage = $r->DownloadToString();
						$subpagearray = explode("\n", $subpage);
						$pic_line = "";
						$open_loc = "x";
						$pics = Array();
						foreach($subpagearray as $id=>$a_line)
						{
							$open_loc = strpos($a_line, "img src=");
							if($open_loc)
							{
								$pic = substr($a_line, $open_loc);//($open_loc + 9));
								//echo($pic . "\n");
								$close_loc = strpos($pic, "\">");
								$pic = substr($a_line, $open_loc, $close_loc);
								array_push($pics, $pic);
							}
						}
						foreach($pics as $id=>$a_pic)
						{
							echo("<$a_pic\">\n");
						}
						if(sizeof($pics) > 0)
						{
							echo("<br>\n");
							$open_ahref_loc = strpos($val, "a href=");
							$val = str_replace("href=\"", "href=\"http://austin.craigslist.org", $val);
							$close_ahref_loc= strpos($val, ">", $open_ahref_loc);
							$fullink = substr($val, 0, ($close_ahref_loc));
							$fullink .= " target=\"_blank\"";
							$fullink .= substr($val, $close_ahref_loc);
					  
							echo($fullink);
							echo("<hr>\n");
						}
						$descrlink = str_replace("<a href=\"/", "<a href=\"http://austin.craigslist.org/", $descrlink);
						#echo("$descrlink<br><hr><br>\n");
						
					}
				}
				/*
            if(!empty($open_loc))
					echo($val . "\nopen_loc = $open_loc\n");
				if((strlen($link) > 12) && (substr_compare($link, "http://austin", 0, 13) == 0))
            {
               $r = new HTTPRequest($link);
               $subpage = $r->DownloadToString();
               $subpagearray = explode("\n", $subpage);
               $pic_line = "";
               $open_loc = "x";
               $pics = Array();
               foreach($subpagearray as $id=>$a_line)
               {
                  $open_loc = strpos($a_line, "img src=");
                  if($open_loc)
                  {
                     $pic = substr($a_line, $open_loc);//($open_loc + 9));
                     $close_loc = strpos($pic, "\">");
                     $pic = substr($a_line, $open_loc, $close_loc);
                     array_push($pics, $pic);
                  }
               }
               foreach($pics as $id=>$a_pic)
               {
                  echo("<$a_pic\">\n");
               }
               if(sizeof($pics) > 0)
               {
                  echo("<br>\n");
                  $open_ahref_loc = strpos($val, "a href=");
                  $close_ahref_loc= strpos($val, ">", $open_ahref_loc);
                  $link = substr($val, 0, ($close_ahref_loc));
                  $link .= " target=\"_blank\"";
                  $link .= substr($val, $close_ahref_loc);
              
                  echo($link);
                  echo("<hr>\n");
               }
            }
				*/
         }
      }
   }
   foreach($sub_links as $id => $val)
   {
      $fp = fopen($val, "r");
      while(!feof($fp))
      {
         $a_line = getline($fp, "\n");
         $open_loc = strpos($a_line, "img src=");
         if($open_loc)
         {
            $a_line = substr($a_line, ($open_loc + 9));
            $close_loc = strpos($a_line, "alt=\"\"");
            $a_line = substr($a_line, 0, ($close_loc - 2));
            echo($a_line . "<br>\n");
         }
      }
      //echo("$id = $val\n<br>\n");
   }
}

function getline( $fp, $delim )
{
   $result = "";
   while( !feof( $fp ) )
   {
       $tmp = fgetc( $fp );
       $log->write($tmp);
       if( $tmp == $delim )
           return $result;
       $result .= $tmp;
   }
   return $result;
}
?>
<?php
class Secretary
{
   var $file_name;
   function Secretary()
   {
      date_default_timezone_set('America/Los_Angeles');
      
      $fn = date("Y_m_d", mktime());
      $this->file_name = "C:\\webserver\\apache\\logs\\" . /*date("Y_m_d", mktime()) .*/ "craigslist.log";
   }
   function write($msg)
   {
      // open file
      $fd = fopen($this->file_name, "a");
      
      // append date/time to message
      $str = "[" . date("H:i", mktime()) . "] " . $msg;
      
      // write string
      fwrite($fd, $str . "\n");
      
      // close file
      fclose($fd);
   }
   function log_end_of_fxn()
   {
      // open file
      $fd = fopen($this->file_name, "a");
      
      // append date/time to message
      $str = "[" . date("Y/m/d H:i", mktime()) . "] --------------------------------------------";
      
      // write string
      fwrite($fd, $str . "\n");
      
      // close file
      fclose($fd);
   }
      
}
?>
<table align="center">
<tr><th>Select a Category</th></tr>
<tr>
   <td>
      <form name="selectTypeBottom" method="get" action="index.php">
      <select name="cat" onChange="document.selectTypeBottom.submit()">
      <?php
         foreach($links as $id=>$val)
         {
            echo("<option value=\"$id\"");
            if((isset($_GET["cat"])) && (strcmp($id, $_GET["cat"]) == 0))
            {
               echo(" selected");
            }
            echo(">$id</option>\n\t");
         }
      ?>
      </select>
      </form>
   </td>
</tr>
</table>
<hr>
</body>
</html>
<?php
class HTTPRequest
{
   var $_fp;        // HTTP socket
   var $_url;        // full URL
   var $_host;        // HTTP host
   var $_protocol;    // protocol (HTTP/HTTPS)
   var $_uri;        // request URI
   var $_port;        // port
  
   // scan url
   function _scan_url()
   {
       $req = $this->_url;
		 
       $pos = strpos($req, '://');
       $this->_protocol = strtolower(substr($req, 0, $pos));
      
       $req = substr($req, $pos+3);
       $pos = strpos($req, '/');
		 if($pos === false)
           $pos = strlen($req);
       $host = substr($req, 0, $pos);
      
       if(strpos($host, ':') !== false)
       {
           list($this->_host, $this->_port) = explode(':', $host);
       }
       else
       {
           $this->_host = $host;
           $this->_port = ($this->_protocol == 'https') ? 443 : 80;
       }
      
       $this->_uri = substr($req, $pos);
       if($this->_uri == '')
           $this->_uri = '/';
   }
  
   // constructor
   function HTTPRequest($url)
   {
		//echo("url => $url<br>\n");
       $this->_url = $url;
		 //echo("this->_url = $url<br>");
       $this->_scan_url();
   }
  
   // download URL to string
   function DownloadToString()
   {
       $crlf = "\r\n";
      
       // generate request
       $req = 'GET ' . $this->_uri . ' HTTP/1.0' . $crlf
           .    'Host: ' . $this->_host . $crlf
           .    $crlf;
      
       // fetch
       echo($this->_host . "<br>");
       echo($this->_port . "<br>");
		 $this->_fp = fsockopen(($this->_protocol == 'https' ? 'ssl://' : '') . $this->_host, $this->_port);
       fwrite($this->_fp, $req);
       while(is_resource($this->_fp) && $this->_fp && !feof($this->_fp))
           @$response .= fread($this->_fp, 1024);
       fclose($this->_fp);
      
       // split header and body
       $pos = strpos($response, $crlf . $crlf);
       if($pos === false)
           return($response);
       $header = substr($response, 0, $pos);
       $body = substr($response, $pos + 2 * strlen($crlf));
      
       // parse headers
       $headers = array();
       $lines = explode($crlf, $header);
       foreach($lines as $line)
           if(($pos = strpos($line, ':')) !== false)
               $headers[strtolower(trim(substr($line, 0, $pos)))] = trim(substr($line, $pos+1));
      
       // redirection?
       if(isset($headers['location']))
       {
           $http = new HTTPRequest($headers['location']);
           return($http->DownloadToString($http));
       }
       else
       {
           return($body);
       }
   }
}
?>

