;;@echo off
;;"c:/Program Files/Chez Scheme 9.5.2/bin/a6nt/scheme.exe" --script %~f0 %~f1
;;goto :eof
;; vim:ft=scheme:nolisp
(import (rnrs base)            ; define-syntax
  (rnrs exceptions))     ; get `with-exception-handler`
(define split-string (string-append "YSC" "aadsddfsdfsdf"))
(define split-string ";")
(define (writeln . args)
  (for-each (lambda (x) (display x) (display " ")) args)
  (newline))
(define (procedure-source? p)
  (define source (((inspect/object p) 'code) 'source))
  (and source (source 'value)))
(define (second x) (cadr x))

(define (string-suffix? str suf)
  (let ((k1 (string-length str))
        (k2 (string-length suf)))
    (and (>= k1 k2)
         (string=? suf
           (substring str (- k1 k2) k1)))))

(define (string-prefix? str pre)
  (let ((k1 (string-length str))
        (k2 (string-length pre)))
    (and (>= k1 k2)
         (string=? pre
           (substring str 0 k2)))))
(define (flatten xs)
  (cond
    ((null? xs) xs)
    ((atom? xs) (list xs))
    (else
      (append (flatten (car xs)) (flatten (cdr xs))))))

(define (tags file)
  (define (ignore-errors thunk)
    (call/cc
      (lambda (k)
        (with-exception-handler
          (lambda (x) (if (error? x) (k #f) (k x)))
          thunk))))
  (ignore-errors (lambda () (load file)))
  (newline)
  (for-each
    (lambda (x)
      (display x)
      (newline)
      (display 
        (or
          (and (top-level-bound? x)
               (let ((val (top-level-value x)))
                 (if (procedure? val)
                     (let ((prc (procedure-source? val)))
                       (or (and prc (cons x (second prc))) val))
                     ((inspect/object val) 'type))))
          (and (top-level-syntax? x) (top-level-syntax x))))
      (newline))
    (environment-symbols (interaction-environment))))

(define (get-lines port)
  (let loop ((x (get-line port)) (lines '()))
    (if (eof-object? x)
        (reverse lines)
        (loop (get-line port) (cons x lines)))))

(define (string-trim-left str trim)
  (define (loop str)
    (if (string-prefix? str trim)
        (loop (substring str (string-length trim) (string-length str)))
        str))
  (if (string=? "" trim)
      str
      (loop str)))
(define (string-trim-right str trim)
  (define (loop str)
    (if (string-suffix? str trim)
        (loop (substring str 0 (- (string-length str) (string-length trim))))
        str))
  (if (string=? "" trim)
      str
      (loop str)))
(define (System . cmds)
  (for-each (lambda (cmd) (writeln cmd) (system cmd))
    cmds))
(define (string-append* . strings)
  (apply string-append 
    (map (lambda (x) (string-append x " "))
      strings)))

(define (kmp t p)
  (define (make-next p)
    (define k (string-length p))
    (define next (make-vector (1+ k)))

    (vector-set! next 0 -1)

    (let loop ((i 0) (j -1))
      (when (< i k)
        (if (or (= j -1) (char=? (string-ref p i) (string-ref p j)))
            (let ((i (1+ i)) (j (1+ j)))
              (vector-set! next i j)
              (loop i j))
            (let ((j (vector-ref next j)))
              (loop i j)))))
    next)
  (define k (string-length t))
  (define l (string-length p))
  (define next (make-next p))
  (let loop ((i 0) (j 0))
    (if (and (< i k) (< j l))
        (if (or (= j -1) (char=? (string-ref t i) (string-ref p j)))
            (loop (1+ i) (1+ j))
            (loop i (vector-ref next j)))
        (if (= j l)
            (- i j)
            #f))))

(define (substring? str sub) (kmp str sub))
(define (string-find str1 str2) (kmp str2 str1))
(define string-join
  (case-lambda 
    ((los) (string-join "" los))
    ((str los)
     (if (null? los)
         ""
         (apply string-append (car los)
           (map (lambda (x) (string-append str x))
             (cdr los)))))))

(define string-split 
  (case-lambda
    ((str) (string-split str " "))
    ((str sep)
     (if (string=? sep "")
         (map string (string->list str))
         (let loop ((str str) (los '()))
           (let ((find? (string-find sep str)))
             (if find?
                 (let ((t (substring str 0 find?)))
                   (loop (substring str 
                           (+ find? (string-length sep))
                           (string-length str)) 
                     (cons t los)))
                 (reverse (cons str los)))))))))

