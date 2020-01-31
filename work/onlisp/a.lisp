(defun compose (&rest fns)
  (if fns
      (let ((fn1 (car (last fns)))
            (fns (butlast fns)))
        #'(lambda (&rest args)
            (reduce #'funcall fns
                    :form-end t
                    :initial-value (apply fn1 args))))
      #'indentity))

(funcall
  de
  )
