(define (dir-walk top code)
  (code top)
  (when  (file-directory? top)
    (for-each 
      (lambda (x) 
        (let  ((path (string-append top "/" x)))
          (when  (and (file-exists?  path) (= (get-mode "/") (get-mode path)))
            (dir-walk  path  code))))
      (directory-list top))))
(define (print-dir dir)
  (display dir)
  (newline))

(dir-walk "/home/a/.vim"  print-dir)


