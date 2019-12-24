;;@echo off
;;"c:/Program Files/Chez Scheme 9.5.2/bin/a6nt/scheme.exe" --script %~f0
;;goto :eof
;; vim:ft=elisp:syntax=lisp:lisp
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
(for-each 
  (lambda (x)
    (display x)
    (display ",")
    (try (display (top-level-value x))
         (catch (display "")))
    (newline))
  (environment-symbols (interaction-environment)))
