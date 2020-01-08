(defun fact (n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))

(fact 33)
(defun fib (n)
  (cond
    ((= n 1) 1)
    ((= n 2) 2)
    (t (+ (fib (- n 1)) (fib (- n 2))))))
(setf max-lisp-eval-depth (* 2 max-lisp-eval-depth))
(dotimes (i 1)
  (print  (fib i)))
