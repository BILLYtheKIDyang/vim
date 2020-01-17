(defmacro aif2 (test &optional then else)
  (let ((win (gensym)))
    `(multiple-value-bind (it ,win) ,test
       (if (or it ,win) ,then ,else))))

(defmacro aif (test-form then-form &optional else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,else-form)))


(defun fact (n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))));
(fact 10)
(fact 123)
(fact 1234)
(macroexpand-1 '
  (defun fact (n)
    (if (< n 2)
        1
        (* n (fact (- n 1))))))
