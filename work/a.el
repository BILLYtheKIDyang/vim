;; vim: ft=elisp syntax=lisp

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
(find-file "/home/a/.zshrc")
