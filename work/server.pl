# Filename: server.pl
use strict;
use Socket;

my $port = shift || 7890;
my $proto = getprotobyname('tcp');
my $server = "localhost";

socket(SOCKET, PF_INET, SOCK_STREAM, $proto) 
   or die "Can't open socket $!\n";
setsockopt(SOCKET, SOL_SOCKET, SO_REUSEADDR, 1)
   or die "Can't set socket option to SO_REUSEADDR $!\n";

bind(SOCKET, pack_sockaddr_in($port, inet_aton($server)))
   or die "Can't bind to port $port!\n";
listen(SOCKET, 5) or die "listen: $!";
print "SERVER started on port $port\n";

my $client_addr;
while ($client_addr = accept(NEW_SOCKET, SOCKET)) {
   my $name = gethostbyaddr($client_addr, AF_INET);
   print NEW_SOCKET "The server says Hi";
   print "Connection recieved from $name\n";
   close NEW_SOCKET;
}
