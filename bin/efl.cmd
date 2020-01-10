@echo off
emacs -batch -l %~dpn0 %*
goto :eof
