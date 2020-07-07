my $myString = "Hello World!";
($myString =~ m/world/i) ? 1 : 0;
($myString =~ m/world/) ? 1 : 0;


print(/^Sender|From:\s+(.*)/);

my $x = join ":", 4, 6, 8, 10, 12;
my $y = join "foo", "bar";
my $empty = join "baz", @empty;

use IO::File;
$filehandle = new IO::File;
$filehandle->open("a.pl") or die "could not open a.pl";
$text = "";
until ($filehandle->eof) {
   $filehandle->read($newtext, 1);
   $text .= $newtext;
}
print $text;
$filehandle->close;


use utf8;
use charnames qw/:full/;
$BWV[887] = "G\N{MUSIC SHARP SIGN} minor";
($note, $black, $mode) = $BWV[886] =~ /^([A-G])(.)\s+(\S+)/;
print "That's lookin' sharp!\n" if $black eq chr(9893);

perl -pe 
