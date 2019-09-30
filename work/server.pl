# Filename: server.pl
use strict;
use IO::Socket;

my $sock = new IO::Socket::INET(
   LocalHost => 'localhost',
   LocalPort => 1200,
   Proto     => 'tcp',
   Listen    => 5,
   Reuse     => 1
);
die "Socket could not be created.  Reason: $!" unless $sock;
my ($new_sock, $buf);
while ($new_sock = $sock->accept()) {
   while (defined ($buf = <$new_sock>)) {
      print $buf;
   }
}
close ($sock);
