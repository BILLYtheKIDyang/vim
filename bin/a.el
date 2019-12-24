(load-file "/home/a/.vim/bin/elisptags")
(defun fact (n)
  (if (< n 2)
      1
    (* n (fact (- n 1)))))

(fact 123)

(require 'disass)


(defun dis(fn)
  "disassemble fn and print it"
  (disassemble fn)
  (with-current-buffer "*Disassemble*"
    (buffer-string)))

(dis 'dis)
(dis 'fact)
(help-function-arglist 'fact)
(help-function-arglist 'defmacro)
(help-function-arglist 'string-prefix-p)
(documentation 'string-prefix-p)
(elisp-get-fnsym-args-string 'string-prefix-p)
(elisp-get-var-docstring 'exec-path)

(elisp-get-fnsym-args-string 'elisp-get-fnsym-args-string)

(elisptags)

