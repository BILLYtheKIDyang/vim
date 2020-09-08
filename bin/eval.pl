#!/usr/bin/perl
use Data::Dumper;
use feature qw(say);
#use 5.010;
$Data::Dumper::Varname="";
$Data::Dumper::Indent=0;
$Data::Dumper::Pair=': ';
$Data::Dumper::Bless='';
$| = 1;
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
   # print "\n";
   #if (length($code) > 0) { say Dumper(eval $code ); }
   if (length($code) > 0) { say pretty(eval $code ); }
   if ($@) { say"$@"; $@='';}
   $code='';
   print 'perl> ';
}
sub pretty_atom {
   my ($var) = shift;
   if (ref($var)) {
      pretty_ref($var);
   } else {
      pretty_scalar($var);
   }
}
sub pretty {
   (join ", ", map { pretty_atom $_ } @_);
}
sub pretty_scalar {
   my ($a) = @_;
   if (($a ^ $a) ne '0') {
      $a =~ s/([\\\'])/\\$1/g;
      "'" . $a .  "'";
   } else {
      $a;
   }
}
sub pretty_ref {
   my ($r) = @_;
   my $ref_type = ref($r);
   if  ($ref_type eq "ARRAY")  {
      pretty_array($r);
   } elsif ($ref_type eq "HASH") {
      pretty_hash($r);
   } else {
      "$ref_type";
   }
}
sub pretty_array {
   my ($r) = @_;
   '[ ' .( join  ", ", (map {  pretty_atom $_;} @$r)) .' ]';
}

sub pretty_hash  {
   my ($r) = @_;
   my ($k, $v);
   my (@a);
   while (($k, $v) = each %$r) {
      push @a, ("$k => " .  pretty_atom $v);
   }
   '{ ' . (join ", ", @a) .  ' }';
}
