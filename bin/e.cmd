;;@echo off
;;rem -*- emacs-lisp -*-
;;rem vim: ft=lisp
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
(condition-case e
  (while (setf line (read-from-minibuffer ""))
    (princ (concat (nreverse (string-to-list line)))))
  (error (princ (car e))))
