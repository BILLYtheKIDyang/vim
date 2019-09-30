print "PID=$$\n";

my $child = fork();
die "can't fork: $!" unless defined $child;

if ($child > 0) {
   print "Parent process: PID=$$, child=$child\n";
} else {
   my $ppid = getppid();
   print "Child process: PID=$$, parent=$ppid\n";
}
