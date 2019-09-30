(load "ref.scm")
(define (apply- f l)
   (let ((v (list->vector l)))
      (let ((k (vector-length v)))
         (case k
            [(0) (f)]
            [(1) (f (ref v 0))]
            [(2) (f (ref v 0) (ref v 1))]
            [(3) (f (ref v 0) (ref v 1) (ref v 2))]
            [(4) (f (ref v 0) (ref v 1) (ref v 2) (ref v 3))]
            [(5) (f (ref v 0) (ref v 1) (ref v 2) (ref v 3) (ref v 4))]
            [(6) (f (ref v 0) (ref v 1) (ref v 2) (ref v 3) (ref v 4) (ref v 5))]
            [(7) (f (ref v 0) (ref v 1) (ref v 2) (ref v 3) (ref v 4) (ref v 5) (ref v 6))]

            ))))


(apply- + '(1))
(apply- + '(1 2 3))

(define (fact n)
   jjjdd
   d
   ds
   d
   f
   sdf
   s
   df
   ssss

