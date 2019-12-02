; vim:ft=elisp:syntax=lisp:lisp
(require 'cl)
(require 'cl-lib)
(defun self-and-double (x) (list x (+ x x)))
(defun mappend (fn the-list)
  "Apply fn to each element of list and append the results."
  (apply #'append (mapcar fn the-list)))
(self-and-double 3)
(apply #'self-and-double '(3))

(mapcar #'self-and-double '(1 10 300))
(mappend #'self-and-double '(1 10 300))

(defun numbers-and-negations (input)
  "Given a list, return only the numbers and their negations."
  (mappend #'numbers-and-negation input))
(defun numbers-and-negation (x)
  "If x is a number, return a list of x and -x."
  (if (numberp x)
      (list x (- x))
      nil))

(princ
  (numbers-and-negations '(testing 1 2 3 test))
  )

(defun mappend (fn the-list)
  "Apply fn to each elment of list and append the results."
  (if (null the-list)
      nil
      (append (funcall fn (first the-list))
              (mappend fn (rest the-list)))))

(funcall #'+ 2 3)
(apply #'+ '(2 3))
(funcall #'+ '(2 3))
(defun list* (x &rest xs) (if (null xs) x (cons x (apply #'list* xs))))
(defmacro while (test &rest body) "Repeat body while test is true" (list* 'cl-loop (list 'unless test '(return nil)) body))

(macroexpand ' (while (> 3 2) (print 3)))


(defmacro  t-becomes-nil (variable) `(if (eq ,variable t) (setf ,variable nil)))

(macroexpand ' (t-becomes-nil foo))

(dotimes (i 100) (print i))
(dotimes (i 100) (princ i) (princ "\n"))
(documentation 'dotimes)
(setf border  '
  ((1 2 3)
   (4 5 6)
   (7 8 9)))

