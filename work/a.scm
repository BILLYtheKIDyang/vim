(define (odd? n)
  (if (= n 1)
      #t
      (even? (- n 1))))
(define (even? n)
  (if (= n 0)
      #f
      (odd? (- n 1))))
(odd? 101)
(trace odd? even?)
(odd? 101)
