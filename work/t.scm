(let-values
  ([(in ou er id) (open-process-ports "help" (buffer-mode block) (make-transcoder (utf-8-codec)))])
  (let loop ()
    (unless (eof-object? (peek-char ou))
      (display (read-char ou))
      (loop))))

(path-first "/home/a/")
