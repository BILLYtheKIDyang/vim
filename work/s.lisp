(defun fact (n x)
  (if (< n 2)
      x
      (fact (- n 1) (* n x))))

(fact 1190 1)
