(defun fact (n)
  (if (< n 2)
      1
    (* n (fact (- n 1)))))

(fact 122)

(defmacro while (test &rest body)
  `(loop
    (unless ,test (return nil))
    ,@body))
(pprint
 (macroexpand-all '
  (let ((n 0))
    (while (< n 10)
      (print n)
      (setf n (1+ n))))))

(let ((n 0))
  (while (< n 10)
    (print n)
    (setf n (1+ n))))
(
