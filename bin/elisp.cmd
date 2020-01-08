;;@echo off
;;rem -*- emacs-lisp -*-
;;rem vim: ft=lisp
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof

(setf lexical-binding t)
(require 'subr-x)
(require 'cl-lib)
(require 'cl)

(defun gethome () 
  (if (string= system-type  "windows-nt")
      (concat (getenv "HOMEDRIVE")
	      (getenv "HOMEPATH"))
      (getenv "HOME")))
(defun getcomplete () 
  (let ((home (gethome)))
    (concat home 
	    (if (string-equal (substring home 0 1) "/")
		"/" "\\")
        ".MyComplete")))
(setf inhibit-message t)
(defun tags()
  (let ((file (getcomplete)))
    (with-temp-file file
      (mapatoms
       (lambda (x)
	 (insert 
	  (format 
	   "%s;%s\n"
	   x
	   (let ((doc (or  
                      (ignore-errors (elisp-get-fnsym-args-string x))
                      (and (or (macrop x) (functionp x)) (car (last (split-string (or (documentation x) "") "\n"))))
                      (elisp-get-var-docstring x)
			          ": ")))
	     (let ((col (search ":" doc)))
               (if col
                   (substring doc (+ 2 col))
                   doc))))))))))
(setf   code "")
(setf   done nil)
(setf   line "")
(setf   lisp nil)
(setf   lisp-pair nil)
(princ "elisp> ")
(while t
  (while (not done)
    (if (or (string= code "") end-of-file)
        (condition-case e
	    (progn
	      (setf line (string-trim (read-from-minibuffer "")))
	      (if (> (length line) 0) 
		  (setf code (string-trim (concat code "\n" line)))))
          (error (kill-emacs))))
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
      (let ((result (car (last (mapcar (lambda (x) (eval x t)) (reverse lisp))))))
	(if (stringp result)
	    (princ result)
          (pp result)))
    (error (princ (error-message-string e))))
  (setf done nil)
  (setf lisp '())
  (princ "\nelisp> "))
