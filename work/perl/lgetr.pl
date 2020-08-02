#!/usr/bin/perl -w
# file: lgetr.pl line get remote

use IO::Socket;

my $server = shift;
my $fh = IO::Socket::INET->new($server);
my $line = <$fh>;
print $line;
while ($line = <$fh>)  {
   print $line;
}
