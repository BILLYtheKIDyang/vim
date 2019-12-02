(princ (elpl-cli-arguments))
(--batch --eval (setq lexical-binding t) --eval (let ((s "")) (while t (setq s (concat s "
" (read-from-minibuffer (if (string= s "") "ELPL> " "")))) (condition-case err (progn (unless (string= s "
") (print (eval (read s) lexical-binding))) (setq s "")) (end-of-file) (error (setq s "") (print err))))))
("--batch" "--eval" "(setq lexical-binding t)" "--eval" "(let ((s \"\")) (while t (setq s (concat s \"\n\" (read-from-minibuffer (if (string= s \"\") \"ELPL> \" \"\")))) (condition-case err (progn (unless (string= s \"\n\") (print (eval (read s) lexical-binding))) (setq s \"\")) (end-of-file) (error (setq s \"\") (print err)))))")

ELISP> 
