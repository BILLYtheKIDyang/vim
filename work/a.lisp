(defun fact (n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))
(fact 3)
(fact 33)
(define (fact n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))

(fact 33)
