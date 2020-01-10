(progn (find-file "vbm.el")
  (print major-mode)
  (indent-region (point-min) (point-max))
  (write-file "vbm.el"))
