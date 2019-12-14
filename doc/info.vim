function InfoToHelp()
   %s/-- \([a-zA-Z ]\+\): \([a-zA-Z1-9-]\+\).*$/\=printf("%s*%s*\n%s", repeat(' ', 78 - len(submatch(2))), submatch(2), submatch(0))/
   %s/‘\([a-z0-9*-]\+\)’/|\1|/g
   %g/^File:.*Up:.*/d
   :w
   helptag .
endfunction
