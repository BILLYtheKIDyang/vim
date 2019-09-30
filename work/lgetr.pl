use IO::Socket;

$fh = new IO::Socket::INET(
   PeerAddr => 'www.baidu.com',
   PeerPort => 80,
   #Proto    => 'http'

);
die "Can't INET $!" unless $fh;
$line = <$fh>;
print $line;
