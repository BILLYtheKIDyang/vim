(defmacro progn* (var protected-form handler &rest handlers)
  `(condition-case ,var
     protected-form
     handler
     ,@handlers))
