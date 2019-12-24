(define (fact n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))

(fact 33)

(fact 123)

(define (fact n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))
(fact 33)

(top-level-bound? 'fact)
(top-level-value 'fact)

(define-syntax
