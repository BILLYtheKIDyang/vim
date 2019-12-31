(require typed/racket)

(define (namespace-variable? [x : Symbol])
  (namespace-variable-value x #t (lambda () #f)))
(let ()
  (system "rm -rf c:/Users/Administrator/.MyComplete")
  (with-output-to-file "c:/Users/Administrator/.MyComplete"
                       (lambda ()
                         (for-each 
                           (lambda ([x : Symbol])
                             (display x)
                             (display ",")
                             (display 
                               (let ((var (namespace-variable? x)))
                                 (if var
                                     (if (procedure? var)
                                         (format "~s: ~s" var (procedure-arity var))
                                         var)
                                     (namespace-syntax-introduce (namespace-symbol->identifier x)))))
                             (newline))
                           (namespace-mapped-symbols)))))

(string-prefix? "ab" "a")
(:print-type "a")
(print-hash-table)
(print 1 )
(print 1 2 )

(expand '
        (:print-type 'a))
(make-struct-type-property 3)
