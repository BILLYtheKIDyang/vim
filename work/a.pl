use Tk;
$mw = MainWindow->new;
$mw->Label( -text => "Hello World!" )->pack();
$mw->Button( -text => "Exit", -command => sub { $mw->destroy; print "done";} )->pack;
&MainLoop();

sub fact {
   my ($n) = @_;
   if ($n < 2) {
      1;
   } else {
      $n * fact($n - 1);
   }
}
(1,2,3);
[1,2,3];
{1,2,3};
@a = [1,2,3];
print foreach @a;   
print foreach [1,2,3];
