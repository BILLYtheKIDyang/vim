;; vim:ft=lisp:syntax=lisp
(require 'cl-lib)
(setf x 0 total 0)
(catch 'break
  (while t
    (cl-incf total x)
    (if (> (cl-incf x) 10)
        (throw 'break total))))

(let ()
  (setf num 0)
  (while (< num 4)
    (princ (format "Iteration %d.\n" num))
    (setf num (1+ num))))

(while (progn
         (forward-line 1)
         (print (point))
         (not (looking-at "$"))))
(find-file "a.el")

(setf a  (buffer-string) b 1)
(substring a 0)

(describe-function 'describe-function)
(type-of [1 2 3])
(defmacro square-sum (x y)
  (let ((sum (gensym)))
    `(let ((,sum (+ ,x ,y)))
       (* ,sum ,sum))))
(macroexpand '(square-sum 3 4))
(setf op '+)
(eval `(,op 1 2))


(defun trim (s)
  (let ((s* (replace-regexp-in-string "[ \t]*$" "" s)))
    (replace-regexp-in-string "^[ \t]*" "" s*)))

(trim " I am old ")
" I am old "

(defun take (n l)
  (cond
   ((< n 0) ())
   ((= n 0) ())
   ((null l) ())
   (t (cons (car l) (take (- n 1) (cdr l))))))

(take 3 '(1 2 3 4 5 6))  
(take 33 '(1 2 3))

(require 'cl)
(let ((x 3))
  (defun get-x () x))
(get-x)

(let ((x 4)) (get-x))
(lexical-let ((x 3))
	     (defun getx () x))
(getx)



(defun square (x) (* x x))
(defun five (x y)
  (sqrt (+ (square x) (square y))))
(five 3 4)

(defun foo () 1)
(defun bar() (foo))
(bar)
(defun foo () 2)
(bar)
(kill-emacs)
(documentation 'kill-emacs)
(symbol-function 'kill-emacs)

(defun fact (n)
  (if (< n 2)
      1
    (* n (fact (- n 1)))))
(fact 33)
(fact 10)


heckdoc-ispell-defun

default-frame-alist
