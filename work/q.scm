(define (quicksort xs)
  (if (< (length xs) 2)
      xs
      (append 
        (quicksort (filter (lambda (x) (not (> x (car xs)))) (cdr xs)))
        (list (car xs))
        (quicksort (filter (lambda (x) (> x (car xs))) (cdr xs)))
        )))

(quicksort '(1 3 5 7 9 2 4 6 8 0))
(quicksort '(0 0 1 1 1 1 191 191 191919191919 1919 191991 1 19 191 91))
(define (vector-swap! v i j)
  (define vi (vector-ref v i))
  (define vj (vector-ref v j))
  (vector-set! v i vj)
  (vector-set! v j vi))

(define (vector-part! v i j)
  (
