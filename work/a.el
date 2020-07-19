(defun even? (n)
  (if (= n 0)
      t
      (odd? (- n 1))))
(defun odd? (n)
  (if (= n 0)
      f
      (even? (- n 1))))

(odd? 133)
(setf max-specpdl-size (* max-specpdl-size 2))
