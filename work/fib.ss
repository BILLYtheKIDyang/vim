(define fat+
  (lambda (x y)
    (if (zero? y)
        x
        (fat+ (1+ x) (1- y)))))
(define (fatfib x)
  (if (< x 2)
      1
      (fat+ (fatfib (1- x) )
            (fatfib (1- (1- x))))))

