(defmacro  when (test &rest body)
  `(if ,test
       (progn
         ,@body)))

(macroexpand-all '
 (when 1 2 3))
