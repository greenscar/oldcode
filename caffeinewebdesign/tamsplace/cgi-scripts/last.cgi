#!/usr/bin/perl
$last=$ENV{'HTTP_REFERER'};
print("Content-type: text/html\r\n\r\n");
print("$last");
