while (<DATA>) {
   ($first, $last) = /(\w+) (\w+)/;
   print "$last, $first\n";
}
__DATA__
Steve Belnheim
Betty Boop
Igor CHevsky
Norma Cord
Jon DeLoach
Betty Boop
