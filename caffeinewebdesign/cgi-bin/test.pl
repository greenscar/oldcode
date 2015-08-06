#!/usr/bin/perl -wT
use CGI;
use CGI::Log;

print "Content-type: text/html\n\n";
open(FILE, "< /Users/james/Desktop/craigslistbike.html");
#print(<FILE>);
#my($contents) = <FILE>;
#print($contents);
#exit();
my($filecontents) = "";
while(<FILE>)
{
#print($_);
 $filecontents .= $_;
}
close(FILE);
print("-=-=-=-=-=-=-=-=-=-=-=-=-=-\n");

my($subpage) = removenewlines($filecontents);
print($subpage);
print("-=-=-=-=-=-=-=-=-=-=-=-=-=-\n");

my($subreg) = "<h2>(.*)</h2><hr>Date\:\\s*(\\d\\d\\d\\d\-\\d\\d\-\\d\\d),\\s*(\\d{1,2}\:\\d\\d[AP]M)\\s*[A-Z]{3}<br>(Reply.*</a>)\\s<sup>";#(Reply(.*</a>)?)";
$subreg .= ".*<div\\sid=\"userbody\">(.*)<!--\\sSTART.*(<table.*</table>)";
      if($subpage =~ m/$subreg/m)
      {
         print("<br>xxxxxxxxxxxxxxxx<br>");
         $subdescr = $1;
         print("\n<br>\n");
         print("1 -> '$1'\n");
	 print("2 -> '$2'\n");
	 print("3 -> '$3'\n");
	 print("4 -> '$4'\n");
	 print("5 -> '$5'\n");
	 print("6 -> '$6'\n");
	 print("7 -> '$7'\n");
         #print($subdescr);
         #print("subdescr -> '$subdescr'\n<br>");
         #print("\n<br>\n");
         #print($doc->h4("subdescr => " . $1));
         #print("\n");
         #print($doc->hr);
         #print("\n<br>\n");
      }

sub removenewlines($)
{
	my($str) = shift;
	$str =~ s/\n*//g;
	#print($str);
	return($str);
}
