;;@echo off
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
;; vim:ft=elisp:syntax=lisp:lisp
(with-temp-file "tags.txt"
  (let ((symbols '()))
    (mapatoms (lambda (x) (push x symbols)))
    (setf symbols (sort symbols #'string< ))
    (dolist (x symbols)
    (when (and (> (length (symbol-name x)) 3)
               (not (string-prefix-p "-" (symbol-name x)))
               (not (string-prefix-p ":" (symbol-name x)))
               (not (string-prefix-p "&" (symbol-name x))))
      (insert (format "(defun %s () nil)\n" x))))))
(shell-command "ctags --fields=+l --language-force=Lisp tags.txt")
