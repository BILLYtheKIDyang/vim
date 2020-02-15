#!/usr/bin/perl
use Data::Dumper;
$Data::Dumper::Varname="";
$Data::Dumper::Indent=0;
$Data::Dumper::Pair=': ';
$Data::Dumper::Bless='';
print 'perl> ';
while (defined($s=<>)) {
   if (length($s) > 1) {
      $code = $code . $s;
      print '..... ';
   } else {
      $code =~ s/^my //;
      if (length($code) > 1) {
         print Dumper( eval $code),"\n";
      }
      if ($@) { print "WRONG: $@\n";}
      $code = '';
      print 'perl> ';
   }
}
