
open(IN, "<", "help.cnx") or die "Can't open tags for update: $!";
while (<IN>) {
   print $1,"\n"  if /^\|(.+\.txt)\|/;
}
close(IN);
