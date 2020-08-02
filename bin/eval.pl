#!/usr/bin/perl
use Data::Dumper;
$Data::Dumper::Varname="";
$Data::Dumper::Indent=0;
$Data::Dumper::Pair=': ';
$Data::Dumper::Bless='';
print 'perl> ';
$code='';
while (defined($s=<>)) {
   if (length($s) > 1) {
      $code =~ s/^my //;
      $code = $code . $s;
      print "..... ";
      next;
   }
   chomp($code);
   if (length($code) > 0) { print  Dumper(eval $code ), "\n"; }
   if ($@) { print"$@\n"; $@='';}
   $code='';
   print 'perl> ';
}
