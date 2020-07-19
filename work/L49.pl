$check = "dogs";
$sentence = "All dogs must behave.";
if ($sentence =~ /\b$check\b/) {
   print "The sentence contains $check"
}
$_ = "this is a test";
/(\w+)\W+(\w+)/;
