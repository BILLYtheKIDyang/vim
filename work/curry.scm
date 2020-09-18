(define-syntax curry
  (syntax-rules ()
    ((curry (x ...) body ...)
     (let ()
       (define k (length '(x ...)))
       (define fn (lambda (x ...) body ...))
       (let loop ((as '()) (n 0))
         (lambda a
           (let ((n (+ n (length a))) (as (cons a as)))
             (cond 
               ((> n k) (errorf 'curry "~a" as))
               ((= n k) (apply fn (apply append (reverse as))))
               ((< n k) (loop as n))))))))))

(define-syntax defcurry
  (syntax-rules ()
    ((defcurry (fn x ...) body ...)
     (define fn
       (curry (x ...) body ...)))))

(defcurry (y f x) (f (y f) x))
(defcurry (fact f n) (if (< n 2) 1 (* n (f (- n 1)))))
(trace  fact y)
(y fact 5)
