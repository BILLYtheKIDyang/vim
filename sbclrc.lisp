(defvar split-string ";")
(setf *print-pretty* nil)
(setf *print-case* :downcase)
(defun tags (file)
  (ignore-errors (load file))
  (do-all-symbols (sym)
    (cond
      ((and (not (fboundp sym)) (boundp sym)) 
       (format t "~a~a~a~%" (string-downcase (symbol-name sym)) split-string 'var))
      ((not (fboundp sym)) )
      (t
        (format t "~a~a~s~%" (string-downcase (symbol-name sym))
          split-string
          (cons sym
            (or (and (macro-function sym)
                     (sb-impl::%fun-lambda-list (macro-function sym)))
                (and (symbol-function sym)
                     (sb-impl::%fun-lambda-list (symbol-function sym))))))))))
