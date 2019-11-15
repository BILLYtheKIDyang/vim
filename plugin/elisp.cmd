;;@echo off
;;rem vim: ft=lisp
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof

(setf line "")
(setf code "")
(setf lisp '())
(princ "elisp> ")

(defun repl ()
  (setf line (read-from-minibuffer ""))
  (if (> (length line) 0) (setf code (concat code "\n" line)))
  (while (< 0 (length code)) 
    (condition-case e
      (setf lisp-pair (read-from-string code))
      (end-of-file (repl)))
    (setf lisp (cons (car lisp-pair) lisp))
    (setf code (substring code (cdr lisp-pair))))
  (condition-case e
    (princ (car (last (mapcar #'eval (reverse lisp)))))
    (error (princ (concat "EVAL: " (error-message-string e)))))
  (setf lisp '())
  (princ "\nelisp> ")
  (repl))
(repl)
