;;@echo off
;;rem -*- emacs-lisp -*-
;;rem vim: ft=lisp
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
(setf line "")
(setf code "")
(setf lisp '())
(princ "elisp> ")

(defun repl ()
  (setf line (string-trim (read-from-minibuffer ""))
  (if (> (length line) 0) (setf code (concat code "\n" line)))
  (while (< 0 (length code)) 
    (condition-case e
      (setf lisp-pair (read-from-string code))
      (error
        (let ((type (car e)))
          (cond
            ((eq type 'invalid-read-syntax)
             (setf code (substring code 1))
             (setf lisp-pair nil))
            ((eq type 'end-of-file)
             (repl))))))
    (and lisp-pair 
         (setf lisp (cons (car lisp-pair) lisp))
         (setf code (substring code (cdr lisp-pair)))))
  (condition-case e
    (princ (car (last (mapcar #'eval (reverse lisp)))))
    (error (princ (error-message-string e))))
  (setf lisp '())
  (princ "\nelisp> ")
  (repl))
(repl)

