perl -pe '$_ .= "\n" if /\S/' pol.sh
perl -pe 's/^/\n/' pol.sh
perl -pe 'print unless /^$/' pol.sh
perl -lne 'print if length' ./pol.sh
perl -00 -pe '$_ .= "\n"x2' ./pol.sh
perl -pe '$_ = "$. $_"' ./pol.sh
perl -pe '$_ = ++$x." $_" if /./' ./pol.sh
perl -pe '$_ = ++$x." $_" if /\S/' ./pol.sh
echo a b c d | perl -MList::Util=shuffle -alne '$,=":"; print shuffle @F'
# 4.5 Find the numerically smallest element (minimum element) on each line
perl -MList::Util=min -alne 'print min @F' pol.sh
# 4.6 Find the numerically smallest element (minimum element) over all lines
perl -MList::Util=min -alne '@M = (@M, @F); END { print min @M }' pol.sh
# 
perl -le '$string = "bananas"; $string =~ y/A-Za-z/N-ZA-Mn-za-m/; print $string' pol.sh
#
perl -ne 'print if $.  <= 10' pol.sh
#
perl -ne '$. <= 10 && print' pol.sh
perl -ne 'print if 1..10' pol.sh
perl -ne 'print; exit if $. == 10' pol.sh
perl -ne '$last = $_; END { print $last }' pol.sh
perl -ne 'print if eof' pol.sh
perl -ne 'push @a, $_; @a = @a[@a-10..$#a] if @a > 10; END { print @a }' pol.sh
perl -ne 'push @a, $_; shift @a if @a > 10; END { print @a }' pol.sh
perl -ne '/regex/ && print' pol.sh
perl -ne 'print if /regex/' pol.sh
perl -ne '!/regex/ && print' pol.sh
perl -ne 'print if !/regex/' pol.sh
perl -ne 'print unless /regex/' pol.sh
perl -ne '/regex/ || print' pol.sh 
perl -ne '/regex/ && $last && print $last; $last = $_' pol.sh
ruby -ne 'puts $_ unless /regex/' pol.sh
