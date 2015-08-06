#!/usr/bin/perl -w

#
# Copyright by eb @ jupload community forum (jupload.biz)
#

use Apache;
use CGI;

my $q = new CGI; # create a new CGI object.
my %params = $q->Vars; # get the name of the parameters given by JUpload, aka the names of the files.

# import the file on the upload directory
foreach my $param (keys %params)
{
my $filename = $q->param($param);
my $filehandle = $q->upload($param);

binmode $filehandle;

# regexp to adapt the file path we received
my $fname = $filename;
$fname =~ s/\\/\//g;
$fname =~ s/\.\.//g;

# determine the file name in its path
my $pos;
$fname = substr($fname, $pos+1) if (($pos = rindex($fname, '/')) != -1);

# store the file in an uploadir in binary mode
$fname = sprintf "%s/%s", "/var/www/upload/", $fname;
open (OUTFILE, ">$fname");
my $bytesread; my $buffer;
while ($bytesread = read($filehandle, $buffer, 1024))
{
print OUTFILE $buffer;
}
close OUTFILE;
}

