(directory "../*.*")
(directory "*.*")
(lambda (n) (* n n))
(defun fact (n) (* n n))
(directory "../*.*") 
(directory "*.*")

(defun fact (n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))
(structure-object 3)
(fact 20)
