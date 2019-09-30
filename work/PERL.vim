setlocal omnifunc=PERL_complete
function! PERL_complete(findstart, base) abort
   " This function is called twice, once with a:findstart and immediately
   " thereafter without a:findstart
   " With a:findstart, return the col where the prefix starts
   " Without a:findstart, return the method options
   " We run Devel::IntelliPerl only once and cache the results
   if a:findstart

      " Get some info for the command
      let words = split(getline('.'), '\W\+')
      let word = words[-1]
      let s:ofc_results =perleval("[AllSymbols(''.ref($". word .").'::')]")
      let prefix_len = s:ofc_results[0]

      return col('.') - prefix_len - 1
   endif

   return s:ofc_results[1:-1]
endfunction
perl<<EOP
sub AllSymbols {
my ($ns) = @_;
my @ss;
while (my ($k, $v) = each(%$ns)) { push @ss, $k; }
sort @ss;
}
EOP
