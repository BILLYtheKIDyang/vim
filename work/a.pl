use feature qw/say/;
say foreach @INC;
use Tk;
$mw = MainWindow->new;
$mw->Label( -text => "Hello World!" )->pack();
$mw->Button( -text => "Exit", -command => sub { $mw->destroy; } )->pack;
MainLoop;
