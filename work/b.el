(defun fact (n)
  (if (< n 2)
      1
    (* n (fact (- n 1)))))

(fact 12)

(emacs-version)
(documentation 'emacs-version)
(documentation 'org-mode)
yes

(find-file "b.el")
(buffer-string)
(def
