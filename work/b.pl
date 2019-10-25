my @a = (1,2,3);
@b = @a;
undef @b;
[@b];
$b[0] = 100;
push @b, 1;
[@a, @b];

$^X;
_;
$ARGV;
@ARGV;
DATA;
@F;
@INC;
%INC;
%ENV;
@EXPORT;
@EXPORT_OK;
%EXPORT_TAGS;
%SIG;
STDERR;
STDIN;
STDOUT;
$a = 1;
$b = 2;
[$a, $b];
@list1 = (1 .. 100);
@list2 = (5, 10, 15, 20);

sub addemup {
   my ($arr1, $arr2) = (shift, shift);

   my $total = 0;
   print $arr1, "\n";
   print $arr2, "\n";
   foreach $num (@$arr1, @$arr2) {
      $total += $num;
   }
   $total;
}
print "The total is: ".addemup(\@list1, \@list2).".\n";

sub AUTOLOAD {
   my (@arguments) = @_;
   $args = join(', ', @arguments);
   print "$AUTOLOAD was never defined.\n";
   print "The arguments passed were $args.\n";
}

$driver = "Jody";
$miles = 50;
$gallons = 5;
&mileage($driver, $miles, $gallons);

sub AUTOLOAD {
   my (@arguments) = @_;
   my($package, $command) = split("::", $AUTOLOAD, 2);
   return `$command @arguments`;
}

$day = dir("");
print "Today is $day.\n" . calc(3,2007);


while (($key, $value) = each(%main::)) {
   print "$key:  $value\n";
}; 

