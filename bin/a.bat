;;@echo off
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
;; vim:ft=elisp:syntax=lisp:lisp
(with-temp-file "tags.txt"
  (insert "!_TAG_FILE_FORMAT	2	/extended format; --format=1 will not append ;\" to lines/\n")
  (insert "!_TAG_FILE_SORTED	1	/0=unsorted, 1=sorted, 2=foldcase/\n")
  (insert "!_TAG_PROGRAM_AUTHOR	Darren Hiebert	/dhiebert@users.sourceforge.net/\n")
  (insert "!_TAG_PROGRAM_NAME	Exuberant Ctags	//\n")
  (insert "!_TAG_PROGRAM_URL	http://ctags.sourceforge.net	/official site/\n")
  (insert "!_TAG_PROGRAM_VERSION	5.8	//\n")
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
