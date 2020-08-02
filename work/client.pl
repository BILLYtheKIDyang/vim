# Filename: client.pl
use strict;
use Socket;

my $host = shift || 'localhost';
my $port = shift || 7890;
my $server = "localhost";

socket(SOCKET, PF_INET, SOCK_STREAM, (getprotobyname('tcp'))[2])
   or die "Can't create a socket $!\n";
connect(SOCKET, pack_sockaddr_in($port, inet_aton($server)))
   or die "Can't connect to port $port!\n";

my $line;
while ($line = <SOCKET>) {
   print "$line\n";
}
close SOCKET or die "close: $!";
