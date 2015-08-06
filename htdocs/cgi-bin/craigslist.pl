#!/usr/bin/perl -wT
use CGI;
#require HTTP::Request;
require URI::Fetch;
require LWP::UserAgent;
my($doc) = CGI->new;

print($doc->header('text/html'));
print("<html><header><title>CraigsListSearch</title></header><body>\n");

my($site) = 'http://portland.craigslist.org';
my(%links) = getcatlinks($site);


my(%categories) = %links;



printcatform($doc, %categories);

   
if(defined($doc->param("category")))
{
   my($start) = 0;
   my($page) = undef;
   for($start = 0; $start < 600; $start += 100)
   {
      if(defined($doc->param("search_for")) && $doc->param("search_for") !~ /^\s*$/)
      {
         #print("search_for = " . $doc->param("search_for") . "<br>");
         if(defined($doc->param("min_ask")) && defined($doc->param("max_ask")))
         {
            print("min_ask & max_ask defined");
            $page = removenewlines(fetchcatpage($site, $doc->param("category"), $start, $doc->param("search_for"), $doc->param("min_ask"), $doc->param("max_ask")));
         }
         else
         {
            print("<h1>not defined</h1>");
            $page = removenewlines(fetchcatpage($site, $doc->param("category"), $start, $doc->param("search_for")));
         }
      }
      else
      { 
         if(defined($doc->param("min_ask")) && defined($doc->param("max_ask")))
         {
            print("min_ask & max_ask defined");
            $page = removenewlines(fetchcatpage($site, $doc->param("category"), $start, "", $doc->param("min_ask"), $doc->param("max_ask")));
         }
         else
         {
            #print("search_for = undefined" . "<br>");
            $page = removenewlines(fetchcatpage($site, $doc->param("category"), $start));
         }
      }
      #print("\n<hr>\n");
      #print("<hr>\n");
      #print("<hr>\n");
      #print("\n\n$page\n\n");
      #print("<hr>\n");
      #print("<hr>\n");
      #print("<hr>\n");
      $reg = "\\s*<p\\sclass=\"row\">";
      $reg .= "\\s*<span\\sclass=\"ih\"\\sid=\"images:([a-z0-9A-Z]+\.jpg)\">&nbsp;<\/span>";
      #$reg .= "\\s*(\\w+)";
      $reg .= "\\s*(\\w+)\\s+(\\d+)\\s-\\s<a\\shref=\"(http:\/\/portland\.craigslist\.org\/(\\w+\/)+\\d+\.html)\">(.+?)</a>.+?\\s*";
      $reg .= "\\s*(\\\$\\d+)\\s*(<font\\ssize=\"\-1\">\\s*.+?</font>)?";
      my($x)=0;
      while($page =~ m/$reg/g)
      {
         $x++;
         my($subpage) = "";
         my($image) = $1;
         #print("image = $image<br>");
         my($month) = $2;
         my($day) = $3;
         my($link) = $4;
         my($garbage) = $5;
         my($descr) = $6;
         my($price) = $7;
         my($location) = $8;
         my($subdescr) = undef;
         my($date) = undef;
         my($time) = undef;
         my($replyto) = undef;
         my($descrlong) = undef;
         my($pics) = undef;
         my($filecontents) = fetchpage($link);
         #print("filecontents = <br><hr>$filecontents<hr><br>");
         $subpage = removenewlines($filecontents);
         my($subreg) = "<h2>(.*)</h2><hr>Date\:\\s*(\\d\\d\\d\\d\-\\d\\d\-\\d\\d),\\s*(\\d{1,2}\:\\d\\d[AP]M)\\s*[A-Z]{3}<br>(Reply.*</a>)\\s<sup>";#(Reply(.*</a>)?)";
         $subreg .= ".*<div\\sid=\"userbody\">(.*)<!--\\sSTART.*(<table.*</table>)";
         if($subpage =~ m/$subreg/m)
         {
            $subdescr = $1;
            $date = $2;
            $time = $3;
            $replyto = $4;
            $descrlong = $5;
            $pics = $6;
            if($subdescr !~ m/(furnitureurway|mattresslw|thegoodmod|encorehomefurnishings)/)
            {
               if(!defined($doc->param("show_details")) || $doc->param("show_details") !~ /false/)
               {
                  print("<table border=0>\n");
                  print("<tr><td><h3>$date $time - <a href=\"$link\">$subdescr</a></h3></td></tr>\n");
                  print("<tr><td style=\"color:red\">$price</td></tr>\n");
                  print("<tr><td>$descrlong</td></tr>\n");
                  print("<tr><td>$pics</td></tr>\n");
                  print("<tr><td>$replyto</td></tr>\n");
                  print("</table>\n");
                  print($doc->hr);
               }
               else
               {
                  print("<a href=\"$link\">$pics</a>\n");
                  print("<a href=\"$link\">$subdescr</a>\n");
                  print($doc->hr);
                  
                  #print("<table border=1>\n");
                  #print("<tr><td>$pics</td></tr>\n");
                  #print("<tr><td><h3><a href=\"$link\">$subdescr</a></h3></td></tr>\n");
                  #print("</table>\n");
                  #print($doc->hr);
               }
            }
            
         }
      }
   }
}


printcatform($doc, %categories);


print($doc->end_html);






sub fetchcatpage
{
   #http://portland.craigslist.org/search/grd?query=&srchType=A&minAsk=&maxAsk=&hasPic=1
   my($site) = shift;
   my($cat) = shift;
   my($start) = shift;
   my($search_for) = shift;
   my($min) = shift;
   my($max) = shift;
   print("min - $min max - $max");
   my($page) = undef;
   if(defined($search_for))
   {
      if(defined($min) && defined ($max))
      {
         print("min = $min && max = $max");
         $page = $site . "/search/" . $cat . "?hasPic=1&query=$search_for&srchType=A&minAsk=$min&maxAsk=$max&s=$start";
      }
      else
      {
         $page = $site . "/search/" . $cat . "?hasPic=1&query=$search_for&srchType=A&s=$start";
      }
      #print($page . "<br>");
   }
   else
   {
      $page = $site . "/search/" . $cat . "?hasPic=1&s=$start";
      #print($page . "<br>");
   }
   #print($page);
   return(fetchpage($page));
}

sub removenewlines
{
	my($str) = shift;
	$str =~ s/\n*//g;
	#print($str);
	return($str);
}
sub fetchpage
{
   my($page) = @_;
   print("fetchpage($page)<br>");
   $browser = LWP::UserAgent->new();
	$browser->timeout(10);
	my $request = HTTP::Request->new(GET => $page);
   my $response = $browser->request($request);
	if ($response->is_error()) {printf "%s\n", $response->status_line;}
	#print("<hr>" . $response->content() . "<hr>");
	return($response->content());
}



sub printcatform {
   my($doc) = shift;
   my(%categories) = @_;
   
   print($doc->hr);
   print($doc->start_form(-method=>GET, -enctype=>'application/x-www-form-urlencoded'));
   print($doc->scrolling_list(
           -name    => "category",
           -size => 1,
           -values => \%categories));
   print($doc->br);
   print("minAsk: ", $doc->textfield(
            -name => "min_ask",
            -value => "",
            -size => 10,
            -maxlength => 10,
            -label => "Min"
            ));
   print("maxAsk: ", $doc->textfield(
            -name => "max_ask",
            -value => "",
            -size => 10,
            -maxlength => 10,
            -label => "Max"));
   print($doc->br);
   print($doc->textfield(
            -name => "search_for",
            -value => "",
            -size => 50,
            -maxlength => 100));
   print($doc->br);
   print($doc->checkbox(
            -name => "show_details",
            -checked => 0,
            -value => "false",
            -label => 'Show only photos'));
   print($doc->br);
   print($doc->submit(-name=>'button_name', -value=>'Search'));
   print($doc->end_form);
}


sub println {
	my (@msg) = @_;
	foreach (@msg) {
      print($_ . "\n");
	}
}



sub getcatlinks {
   my($link) = @_;
   my($contents) = fetchpage($link);
   $contents = removenewlines($contents);
   my($reg) = "<div\\sclass=\"cats\">\\s+(<ul\\sid=\"sss0\">.*?)</div>";
   my(%links) = ();
   if($contents =~ m/$reg/s)
   {
      my($catlist) = $1;
      while($catlist =~ m/<a\shref=\"(.*?)\/\">(.*?)<\/a>/g)
      {
         #print("$1 - $2<br>");
         $links{$1} = $2;
      }
      #print("---- $1 ----");
   }
   #print($categories);
   return(%links);
}
