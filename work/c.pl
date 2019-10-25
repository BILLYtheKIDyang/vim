use feature "say";
$r = [1,2,3];
say ref($r);
$r  = {1,2,3,4};
say ref($r);
sub fact {
   my ($n) = @_;
   if ($n < 2) {
      1;
   } else {
      $n * fact($n - 1);
   }
}
$r = sub { return 0; };
$r = \&fact;
say ref($r);
say $r->();
