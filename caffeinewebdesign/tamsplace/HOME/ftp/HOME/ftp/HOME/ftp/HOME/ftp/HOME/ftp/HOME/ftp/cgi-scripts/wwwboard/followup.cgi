#! /usr/local/bin/perl

######################
# Follow-Up Script for WWW Messages

# Define the Variables
$mesgpageurl = "http://yourdomain.com/wwwboard/msgs.html";
$followup = "http://yourdomain.com/wwwboard/postfp.cgi";

# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

# Split the name-value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair);

    # Un-Webify plus signs and %-encoding
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    # Stop people from using subshells to execute commands
    # Not a big deal when using sendmail, but very important
    # when using UCB mail (aka mailx).
    # $value =~ s/~!/ ~!/g;

    # Uncomment for debugging purposes
    # print "Setting $name to $value<P>";

    $FORM{$name} = $value;
}

if ($FORM{'origkind'} eq 'Question') {
  $exkind = "asked";
}
elsif ($FORM{'origkind'} eq 'Message') {
  $exkind = "said";
}

print "Content-type: text/html\n\n";
print "<html><head><title>Post Followup Response to $FORM{'origsubject'}</title></head>\n";
print "<body><h1>RE: $FORM{'origsubject'}</h1>\n";
print "On $FORM{'origdate'} $FORM{'origrealname'} $exkind:<br>\n";
print "\"$FORM{'origcomments'}\"<p>\n";
print "Your Follow-Up:<br>\n";
print "<form method=POST action=\"$followup\">\n";
print "Your Name: <input type=text name=\"realname\" size=30><br>\n";
print "Your E-Mail: <input type=text name=\"username\" size=40><p>\n";
print "Subject: <input type=text name=\"subject\" value=\"RE: $FORM{'origsubject'}\" size=40><br>\n";
print "<input type=hidden name=\"origfilename\" value=\"$FORM{'origfilename'}\">\n";
print "Reply:<br>\n";
print "<textarea COLS=60 ROWS=5 name=\"comments\"></textarea><p>\n";
print "Optional Link: <input type=text name=\"link\" size=45><br>\n";
print "Link Name: <input type=text name=\"linkname\" size=45><br>\n";
print "Optional Image: <input type=text name=\"image\" size=45><p>\n";
print "<input type=hidden name=\"origfileurl\" value=\"$FORM{'origfileurl'}\">\n";
print "<input type=submit value=\"Post Follow-Up\"> * <input type=reset value=\"Reset Follow-Up\"><hr>\n";
print "* <a href=\"$mesgpageurl\">Back to the Your Domain Message Board</a><br>\n";
print "* <a href=\"$FORM{'origfileurl'}\">Back to the Last Message you were at</a>\n";
print "</body></html>";
