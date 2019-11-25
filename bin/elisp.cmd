;;@echo off
;;rem -*- emacs-lisp -*-
;;rem vim: ft=lisp
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
(require 'subr-x)
(setf line "")
(setf code "")
(setf lisp '())
(setf lisp-pair nil)
(setf done nil)

(princ "elisp> ")
(while t
  (while (not done)
    (and (or (string= code "") end-of-file)
         (setf line (string-trim (read-from-minibuffer "")))
         (if (> (length line) 0) 
             (setf code (string-trim (concat code "\n" line)))))
    (condition-case e
      (progn 
        (setf lisp-pair (read-from-string code))
        (setf code (substring code (cdr lisp-pair)))
        (setf lisp (cons (car lisp-pair) lisp))
        (setf end-of-file nil)
        (if (string= code "")
            (setf done t)
            (setf done nil)))
      (error
        (let ((type (car e)))
          (cond
            ((and (eq type 'invalid-read-syntax) 
                  (not (string= code "")))
             (setf code (substring code 1)))
            ((eq type 'end-of-file) 
             (setf end-of-file t)))))))
  (condition-case e
    (princ (car (last (mapcar #'eval (reverse lisp)))))
    (error (princ (error-message-string e))))
  (setf done nil)
  (setf lisp '())
  (princ "\nelisp> "))
