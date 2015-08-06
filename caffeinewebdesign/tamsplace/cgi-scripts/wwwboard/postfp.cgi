#! /usr/local/bin/perl

######################
# Post Follow-Up Message

# Define the Variables
$filename = "/www/htdocs/yourdomain/wwwboard/messages/msgs$$.html";
$mesgpageurl = "http://yourdomain.com/wwwboard/msgs.html";
$filenameurl = "http://yourdomain.com/wwwboard/messages/msgs$$.html";
$logfile = "/www/htdocs/yourdomain/wwwboard/msgslog.html";

# Choose Options
$uselog = 0;    #1 = YES; 0 = NO

# Get the Date
$date = `date +"%A, %B %d at %I:%M %p %Z"`; chop($date);
$shortdate = `date +"%D %r %Z"`; chop($shortdate);

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

&no_comments unless $FORM{'comments'};
&no_name unless $FORM{'realname'};
&no_subject unless $FORM{'subject'};

# Define Form Variables
$origfilename = "$FORM{'origfilename'}";

# Begin the Editing of the Guestbook File
open (FILE,"$origfilename");
@LINES=<FILE>;
close(FILE);
$SIZE=@LINES;

# Open Link File to Output
open (MSG,">$origfilename");

for ($i=0;$i<=$SIZE;$i++) {
   $_=$LINES[$i];
  if (/<META begin>/) { 
    print MSG "<META begin>\n";
    print MSG "<li><a href=\"$filenameurl\">$FORM{'subject'}</a>\n";
    print MSG "<ul><li>Posted By: $FORM{'realname'} on $date</ul>\n";
  }
   else { print MSG $_; }
}
close (MSG);

# Open New Message Posting
open (MESG, ">$filename");
print MESG "<html><head><title>Your domain WWW Message Follow-Up: $FORM{'subject'}</title></head>\n";
print MESG "<body><h1>$FORM{'subject'}</h1>\n";
print MESG "Follow-Up posted by $FORM{'realname'} (<a href=\"mailto:$FORM{'username'}\">$FORM{'username'}</a>) on $date<p>\n";
if ($FORM{'image'}) {
  print MESG "<img src=\"$FORM{'image'}\"><br>\n";
}
print MESG "Follow-Up:<p>\n";
print MESG "$FORM{'comments'}\n";
if ($FORM{'link'}) {
  print MESG "<p>Here is a link that might be useful: <a href=\"$FORM{'link'}\">$FORM{'linkname'}</a><hr>\n";
}
else {
  print MESG "<hr>\n";
}
print MESG "* <a href=\"$mesgpageurl\">Back to the Main Your domain WWW Message Board</a><br>\n";
print MESG "* <a href=\"$FORM{'origfileurl'}\">Back to the Original Message</a>\n";
print MESG "</form></body></html>";
close (MESG);

$chmod = `chmod 755 $filename`;

# Log Addition
if ($uselog eq '1') {
open (LOG, ">>$logfile");
print LOG "$ENV{'REMOTE_HOST'} - [$shortdate] - PID: $$<br>\n";
close (LOG);
}

# Print HTML Response
print "Content-type: text/html\n\n";
print "<html><head><title>Your domain WWW Message Follow-Up: $FORM{'subject'}</title></head>\n";
print "<body><h1>$FORM{'subject'}</h1>\n";
print "Follow-Up posted by $FORM{'realname'} (<a href=\"mailto:$FORM{'username'}\">$FORM{'username'}</a>) on $date<p>\n";
if ($FORM{'image'}) {
  print "<img src=\"$FORM{'image'}\"><br>\n";
}
print "Follow-Up:<p>\n";
print "$FORM{'comments'}\n";
if ($FORM{'link'}) {
  print "<p>Here is a link that might be useful: <a href=\"$FORM{'link'}\">$FORM{'linkname'}</a><hr>\n";
}
else {
  print "<hr>\n";
}
print "* <a href=\"$mesgpageurl\">Back to the Main Your Domain WWW Message Board</a><br>\n";
print "* <a href=\"$FORM{'origfileurl'}\">Back to the Original Message</a>\n";
print "</body></html>";

sub no_comments
{
print "Content-type: text/html\n\n";
print "<html><head><title>Your Domain Message Board - ERROR</title></head>\n";
print "<body><h1>ERROR: NO COMMENTS</h1>\n";
print "You forgot to fill in the Body of your message.  Please <a href=\"$mesgpageurl\">return to the main message page</a> and try again.<p>\n";
print "Thank You.<hr>\n";
print "</body></html>\n";
# Log Error
if ($uselog eq '1') {
open (LOG, ">>$logfile");
print LOG "$ENV{'REMOTE_HOST'} - [$shortdate] - ERR: No Comments<br>\n";
close (LOG);
}
exit;
}
sub no_name
{
print "Content-type: text/html\n\n";
print "<html><head><title>Your Domain Message Board - ERROR</title></head>\n";
print "<body><h1>ERROR: NO NAME</h1>\n";
print "You forgot to fill in your real name.  Please <a href=\"$mesgpageurl\">return to the main message page</a> and try again.<p>\n";
print "Thank You.<hr>\n";
print "</body></html>\n";
# Log Error
if ($uselog eq '1') {
open (LOG, ">>$logfile");
print LOG "$ENV{'REMOTE_HOST'} - [$shortdate] - ERR: No Name<br>\n";
close (LOG);
}
exit;
}
sub no_subject
{
print "Content-type: text/html\n\n";
print "<html><head><title>Your Domain Message Board - ERROR</title></head>\n";
print "<body><h1>ERROR: NO SUBJECT</h1>\n";
print "You forgot to fill in the subject of your message.    Please <a href=\"$mesgpageurl\">return to the main message page</a> and try again.<p>\n";
print "Thank You.<hr>\n";
print "</body></html>\n";
# Log Error
if ($uselog eq '1') {
open (LOG, ">>$logfile");
print LOG "$ENV{'REMOTE_HOST'} - [$shortdate] - ERR: No Subject<br>\n";
close (LOG);
}
exit;
}
