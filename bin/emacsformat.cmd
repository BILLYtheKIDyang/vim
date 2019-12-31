;;@echo off
;;rem -*- emacs-lisp -*-
;;rem vim: ft=lisp
;;rem d:/emacs/bin/emacs -batch -l %~f0 2>nul
;;d:/emacs/bin/emacs -batch -l %~f0
;;goto :eof
(require 'subr-x)
(setf line "")
(setf code nil)
(setf inhibit-message t)
(setf buf (create-file-buffer "*"))
(while t
  (condition-case e
      (progn
	(setf line (read-from-minibuffer ""))
	(push line code))
    (error
     (with-temp-buffer
       (scheme-mode)
       (insert (string-join (reverse code) "\n"))
       (setf code nil)
       (indent-region (point-min) (point-max) nil)
       (princ (buffer-string))
       (kill-emacs)))))
