setlocal dictionary=~/.sbcl_completions
setlocal indentexpr=LispIndent()
setlocal complete+=k
"setlocal equalprg=emacs\ --script\ ~/.vim/bin/emacsformat
setlocal omnifunc=MyComplete
