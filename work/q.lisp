(directory "../*.*")
(directory "*.*")
(lambda (n) (* n n))
(defun fact (n) (* n n))
(directory "../*.*") 
<<<<<<< HEAD
=======
(directory "*.*")

>>>>>>> bf978ad286be18b64eae8aa7e71f4264329ab0cf
(defun fact (n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))
<<<<<<< HEAD
(defun fact (n)
  (if (< n 2)
      1
      (*  n (fact (-  n 1)))))

(directory "*.*")
=======
(structure-object 3)
(fact 20)
>>>>>>> bf978ad286be18b64eae8aa7e71f4264329ab0cf
