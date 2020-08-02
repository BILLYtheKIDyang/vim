#!/usr/bin/perl
# file: tcp_echo_serv1.pl
# usage: tcp_echo_serv1.pl [port]

use strict;
use socket;
use IO::Handle;
use constant MY_ECHO_PORT = 2007;

my ($bytes_out, $bytes_in)  = (0, 0);
my $port = shift  || MY_ECHO_PORT;
my $protocol = getprotobyname('tcp');

$SIG{ 'INT' } =  sub {
   print STDERR "bytes_sent =$bytes_out, bytes_received = $bytes_in\n";
   exit 0;
};

socket(SOCK, AF_INET, SOCK_STREAM, $protocol) 
   or die "socket() failed: $!";
setsockopt(SOCK, SOL_SOCKET, SO_REUSEADDR, 1)
   or die  "Can't set  SO_REUSEADDR: $!";
my $my_addr = sockaddr_in($port, INADDR_ANY);
