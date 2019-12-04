;;@echo off
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
;; vim:ft=elisp:syntax=lisp:lisp
(require 'cl)
(require 'cl-lib)
(require 'subr-x)
(let ((b "C:/Users/Administrator/.vim/.emacs.d/elpa/"))
  (dolist (d (directory-files b))
    (unless (or (string= d "..") (string= d ".") (string= d "archives"))
      (push (concat b d) load-path)
      (let ((p (make-symbol (string-trim-right d "-[0-9.]+"))))
        (condition-case e
          (require p)
          (error (print (error-message-string e))))))))
(let ((symbols '()))
  (mapatoms (lambda (x) (push x symbols)))
  (setf symbols (sort symbols #'string< ))
  (princ "vim:ft=help:lisp\n")
  (dolist (x symbols)
    (princ (make-string 80 ?-))
    (princ "\n")
    (let* ((ss (- 80 (+ (* 2 (length (symbol-name x))) 2)))
           (spaces (if (> ss 0) (make-string ss ?\s) 1)))
      (princ (format "%s%s*%s*" x spaces x))
      (let ((fd (ignore-errors (documentation x)))
            (vd (ignore-errors (documentation-property x 'variable-documentation))))
        (when fd
          (princ (format "\n\n%s" fd)))
        (when vd 
          (princ (format "\n\n%s" vd))))
      (princ "\n"))))

