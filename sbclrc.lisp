(defun load-file (file) (load file))

(defun tags ()
  (run-program "/usr/bin/rm" '("-rf" "~/.MyComplete"))
  (with-open-file 
    (output 
      #.(concatenate 'string (posix-getenv "HOME") "/.MyComplete")
      :direction :output 
      :if-exists :overwrite
      :if-does-not-exist :create)
    (do-all-symbols (sym)
      (let ((package (symbol-package sym)))
        (cond
          ((not (fboundp sym))); (format output "~a;variable~%" (string-downcase (symbol-name sym))))
          (t
            (format output "~a;~a~%" 
              (string-downcase (symbol-name sym))
              (or (and (macro-function sym)
                       (sb-impl::%fun-lambda-list (macro-function sym)))
                  (and (symbol-function sym)
                       (sb-impl::%fun-lambda-list (symbol-function sym)))))))))))
