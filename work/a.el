;; vim: ft=elisp syntax=lisp

(require 'cl-lib)
(setf x 0 total 0)
(catch 'break
  (while t
    (cl-incf total x)
    (if (> (cl-incf x) 10)
        (throw 'break total))))

