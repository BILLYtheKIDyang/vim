(defun fact (n k)
  (if (< n 2)
      (funcall k 1)
      (fact (- n 1) 
            (lambda (x) 
              (funcall k (* x n))))))


(fact 10 (lambda (x) x))
(fact 10 (lambda (x) `(the result is ,x)))

