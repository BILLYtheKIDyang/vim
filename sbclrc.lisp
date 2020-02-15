(defvar split-string ";")
(setf *print-pretty* nil)
(setf *print-case* :downcase)
(defun tags (file)
  (ignore-errors (load file))
  (do-all-symbols (sym)
    (let* ((package (symbol-package sym))
           (name    (concatenate 'string 
                      (cond 
                        ((eql #.(find-package :cl)      package) "")
                        ((eql #.(find-package :cl-user) package) "")
                        ((eql #.(find-package :keyword) package) ":")
                        (package
                          (concatenate 'string 
                            (string-downcase (package-name package)) 
                            ":")))
                      (string-downcase (symbol-name sym)))))
      (cond
        ((and (not (fboundp sym)) (boundp sym)) (format t "~a~a~a~%" name split-string 'var))
        ((not (fboundp sym)))
        (t
          (format t "~a~a~s~%" name
            split-string
            (cons sym
              (or (and (macro-function sym)
                       (sb-impl::%fun-lambda-list (macro-function sym)))
                  (and (symbol-function sym)
                       (sb-impl::%fun-lambda-list (symbol-function sym)))))))))))
