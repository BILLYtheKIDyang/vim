(define (ind buff stack)
        (define (char-open? c) (or (char=? c #\() (char=? c #\[)))
        (define (char-close? c) (or (char=? c #\)) (char=? c #\])))
        (define (char-open/close? c)
                (or (char-open? c) (char-close? c)))
        (define (cdr* x) (if (null? x) x (cdr x)))
        (define (get-token s i)
                (let ([k (string-length s)])
                     (let loop ([i (+ 1 i)])
                          (if (>= i k)
                              k
                              (let ([ci (string-ref s i)])
                                   (if (or (char-whitespace? ci)
                                         (char=? ci #\')
                                         (char=? ci #\")
                                         (char=? ci #\;)
                                         (char-open/close? ci))
                                       i
                                       (loop (+ i 1))))))))
        (for-each
          (lambda (line)
                  (let ([k (string-length line)])
                       (let char-loop ([i 0])
                            (when (< i k)
                                  (let ([ci (string-ref line i)])
                                       (cond
                                         [(char=? ci #\;)
                                          (cond
                                            [(or in-string? in-bar? in-block?) (char-loop (+ i 1))]
                                            [(let ([j (- i 1)])
                                                  (and (>= j 0) (char=? (string-ref line j) #\#)))
                                             (char-loop (+ i 1))]
                                            [else (char-loop k)])]
                                         [(char=? ci #\\) (char-loop (+ i 2))]
                                         [(char=? ci #\|)
                                          (cond
                                            [in-bar? (set! in-bar? #f) (char-loop (+ i 1))]
                                            [(let ([j (+ i 1)])
                                                  (and in-block?
                                                    (< j k)
                                                    (char=? (string-ref line j) #\#)))
                                             (set! in-block? #f)
                                             (char-loop (+ i 2))]
                                            [(let ([j (- i 1)])
                                                  (and (>= j 0) (char=? (string-ref line j) #\#)))
                                             (set! in-block? #t)
                                             (char-loop (+ i 1))]
                                            [(not (or in-string? in-block?))
                                             (set! in-bar? #t)
                                             (char-loop (+ i 1))])]
                                         [(char=? ci #\")
                                          (cond
                                            [in-string? (set! in-string? #f)]
                                            [(not (or in-bar? in-block?)) (set! in-string? #t)])
                                          (char-loop (+ i 1))]

                                         [(char-open? ci)
                                          (if (or in-bar? in-string? in-block?)
                                              (char-loop (+ i 1))
                                              (let ([p (get-token line i)])
                                                   (set! stack
                                                         (cons (cons i (substring line (+ 1 i) p)) stack))
                                                   (char-loop p)))]

                                         [(char-close? ci)
                                          (unless (or in-bar? in-string? in-block?)
                                                  (set! stack (cdr* stack)))
                                          (char-loop (+ i 1))]
                                         [else (char-loop (+ i 1))]))))))
          buff)
        (if (null? stack)
            0
            (if (or (null? stack) in-bar? in-string? in-block?)
                -1
                (if (and (not (null? (cdr stack)))
                      (member (cdadr stack) pair-list))
                    (+ 1 (caar stack))
                    (let ((e (assoc (cdar stack) ind-list)))
                         (if e
                             (+ (cdr e) (caar stack))
                             (+ 3 (caar stack))))))))
