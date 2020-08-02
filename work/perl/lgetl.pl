#!/usr/bin/perl -w
# file: lgetl.pl line get local

use IO::File;

my $file = shift;
my $fh = IO::File->new($file);
my $line = <$fh>;
print $line;
while ($line = <$fh>)  {
   print $line;
}
