;;@echo off
;;"c:/Program Files/Chez Scheme 9.5.2/bin/a6nt/scheme.exe" --script %~f0 %~f1
;;goto :eof
;; vim:ft=scheme
(import (rnrs base)            ; define-syntax
  (rnrs exceptions))     ; get `with-exception-handler`
(define-syntax try
  (syntax-rules (catch)
    ((_ body (catch catcher))
     (call-with-current-continuation
       (lambda (exit)
         (with-exception-handler
           (lambda (condition)
             catcher
             (exit condition))
           (lambda () body)))))))


(define (procedure-source? p)
  (define source (((inspect/object p) 'code) 'source))
  (and source (source 'value)))
(define (string-prefix? str pre)
  (and (>= (string-length str) (string-length pre))
       (string=? pre (substring str 0 (string-length pre)))))
(define (second x) (cadr x))
(define (tags)
  (let ((file (string-append (or (getenv "HOME") (string-append (getenv "HOMEDRIVE") (getenv "HOMEPATH"))) "/.MyComplete")))
    (system (string-append "rm -rf " file))
    (with-output-to-file 
      file
      (lambda ()
        (for-each 
          (lambda (x)
            (display x)
            (display ";")
            (display
              (or 
                (and (top-level-bound? x)
                     (let* ((val (top-level-value x))
                            (prc (procedure-source? val)))
                           (or (and prc (second prc)) val)))
                (and (top-level-syntax? x) (top-level-syntax x))))
            (newline))
          (environment-symbols (interaction-environment)))))))
