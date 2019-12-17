(defmacro  when (test &rest body)
  `(if ,test
       (progn
         ,@body)))

(macroexpand-all '
 (when 1 2 3))

(disassemble 'when)
(defun fact (n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))

(disassemble-internal #'fact 1 nil)
(disassemble 'fact)
