(define-syntax when
  (syntax-rules ()
		((when test code ...)
		 (if test
		     (begin
		      code ...)))))


(define fact
  (lambda (n)
    (if (< n 2)
        1
      (* n (fact (- n 1))))))

(fact 10)
(when 1 2 3)

(expand '(when 1 2 3))
