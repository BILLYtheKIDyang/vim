open(FH, "camel.gif") || die "$!";
binmode(FH);
print FH "GIF87a\056\001\045\015\000";
close(FH);

$_ = "Our house is in the middle of our street.";
s/middle/end/;
s/in/at/;
if (s/apartment/condo/) {
   dd;
}
$^O;
