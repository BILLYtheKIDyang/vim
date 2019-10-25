use Data::Dumper;
print 'perl> ';
while (defined($s=<>)) {
   if (length($s) >= 2) {
      $code = $code . $s;
      print '..... ';
   } else {
      $code =~ s/^my //;
      $result =  eval $code;
      if ($@) {
         print "Invalid string: \n $code";
      } else {
         #print Dumper($result);
         print $result, "\n";
      }
      $code = '';
      print 'perl> ';
   }
}
