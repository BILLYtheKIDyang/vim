$counter = 0;
while ($counter < 10) {
   print "Still counting...$counter\n";
   $counter++;
}

@flavors = qw(chocolate vanilla strawberry mint sherbert);
for ($index = 0; $index < @flavors; $index++) {
   print "My flavorite flavor is $flavors[$index] and...";
} print "many others. \n";

foreach $cone (@flavors) {
   print "I'd like a cone of $cone\n";
}

@Music = ('White Album,Beatles',
   'Graceland,Paul Simon',
   'A Boy Named Sue, Goo Goo Dolls');
foreach $record (@Music) {
   ($record_name, $artist) = split(/,/, $record);
}

$numbers = join(', ', (1..10));

$message = "Elvis was here";
print "The string \"$message\" consists of: ",
join('-', split(//, $message));

@Chiefs = qw(Clinton Bush Reagan Carter Ford Nixon);
join(' ', sort @Chiefs);

@numbers = (1,3,5,7,9,2,4,6,8,0);
join(', ', @numbers);
@sorted = sort { $a <=> $b; } @numbers;
join(', ', @sorted);

@lines = qw(I do not like green eggs and ham);
join(' ', reverse @lines);

$myhome = `ls \$HOME`;
$myhome = `ls \%WINDIR%`;
@myhome = `ls \%WINDIR%`;
@myhome = qx'dir %WINDIR%';

print foreach (sort @myhome)

