;;@echo off
;;rem vim: ft=lisp
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
(let ((line "") (code ""))
  (princ "elisp> ")
  (while (setf line (read-from-minibuffer ""))
    (if (> (length line) 0) 
        (progn
          (setf code (concat code "\n" line))
          (princ "       "))
        (progn
          (if (> (length code) 0)
              (progn 
                (condition-case e
                  (princ (eval (car (read-from-string code))))
                  (error (princ (error-message-string e))))
                (princ "\n")))
          (setf code "")
          (princ "elisp> ")))))
