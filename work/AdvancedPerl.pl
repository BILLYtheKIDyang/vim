# 4-2
use Tk;

sub CreateButton {
   my ($parent, $title) = @_;
   my ($b);
   $callback_proc = sub {
      print "Button $title pressed\n";
   };
   $b = $parent->Button(
      '-text' => "$title",
      '-fg' => 'red',
      '-command'=> $callback_proc
   );
   $b->pack();
}
$topwindow = MainWindow->new();

CreateButton($topwindow, "hello");
CreateButton($topwindow, "world");
MainLoop();

# 4-3
sub even_number_printer_gen{
   my ($input) = @_;
   if ($input % 2) { $input++; }
   my $rs = sub {
      print "$input";
      $input += 2;
   };
   return $rs;
}
$iterator = even_number_printer_gen(30);
for ($I = 0; $I < 10; $I++) {
   &$iterator();
}
print "\n";

# 4-4
sub even_odd_print_gen {
   use strict;
   my ($rs1, $rs2);
   my ($last) = shift;
   $rs1 = sub { # Even nubmer printer
      if ($last % 2) { 
         $last++;
      } else { 
         $last += 2;
      }
      print "$last \n";
   };
   $rs2 = sub{ # odd nubmer printer
      if($last % 2) { 
         $last += 2;
      } else { 
         $last++; 
      }
      print "$last \n";
   };
   return ($rs1, $rs2);

}

($even_iter, $odd_iter) = even_odd_print_gen(10);
&$even_iter();
&$odd_iter();
&$odd_iter();
&$even_iter();
&$odd_iter();
#################################

use IO::Socket;

my $sock = new IO::Socket::INET(
   LocalHost => 'localhost',
   LocalPort => 1200,
   Proto     => 'tcp',
   Listen    => 5,
   Reuse     => 1
);
die "Socket could not be created.  Reason: $!" unless $sock;
my ($new_sock, $buf);
while ($new_sock = $sock->accept()) {
   while (defined ($buf = <$new_sock>)) {
      print $buf;
   }
}
close ($sock);
