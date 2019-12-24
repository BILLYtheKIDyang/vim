
let lnum = 1
while lnum <= line("$")
   let lnum += 1
endwhile

echo &filetype



call VimScriptCompleteCache()
