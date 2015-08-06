#!/usr/local/bin/perl
# A simple logger script to log info from a page using SSI
#               ============================
#
#              < !--#exec cgi="log.cgi"-->
#
#              ============================
#               Create some.log in the directory. Make the directory and the some.log
#               chmod 777  name the script below log.cgi make it chmod 755. Place the
#               tag above in the head of your htm and rename it shtml then make it
#               chmod 755.  That's it.  You may not want all the below info. You can cut
#               some of the print lines to fit your needs.  I usually use the referer date,
#               and remote address.
#
# Script to generate some info about my visitors.
$mainlog = "file.log";
$shortdate = `date +"%D %T %Z"`;
chop ($shortdate);
print "Content-type: text/html\n\n ";
open (MAINLOG, ">>$mainlog");
print MAINLOG "Time: $shortdate\n";
print MAINLOG "User: $ENV{'REMOTE_IDENT'}\n";
print MAINLOG "Host: $ENV{'REMOTE_HOST'}\n";
print MAINLOG "Addr: $ENV{'REMOTE_ADDR'}\n";
print MAINLOG "With: $ENV{'HTTP_USER_AGENT'}\n";
print MAINLOG "Page: $ENV{'DOCUMENT_URI'}\n";
print MAINLOG "From: $ENV{'HTTP_REFERER'}\n\n";
close (MAINLOG);
exit;
