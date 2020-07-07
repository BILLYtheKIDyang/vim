print "any last request?";
if (<STDIN> =~ /^[yY]/) {
   print "The request is?";
   <STDIN>;
}

print "any last request?";
if (<STDIN> =~ /^y/i) {
}
