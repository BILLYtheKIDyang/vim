(define file "/home/a/.vim/bin/t.scm")
(with-input-from-file file
  (lambda ()
    (let ((e (try (read) (catch 
                  
