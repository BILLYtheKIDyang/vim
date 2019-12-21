fun! EmacsLispComplete(start, base)
   if a:start
      let line = getline('.')
      let start = col('.') - 1
      while start > 0 && line[start - 1] =~ '\k'
         let start -= 1
      endwhile
      return start
   else
      let base = a:base
      let data =(system("emacs --batch --eval \"(mapatoms (lambda (x) (when (string-suffix-p \\\"" . base . "\\\" (symbol-name x)) (princ (format \\\"%s,%s\n---END---\n\\\" x (ignore-errors (or (documentation x) (document-property x)) )))))))\""))
      let res = []
      for symboldoc in sort(split(data, "---END---\n"))
         let sd = split(symboldoc, ",")
         if len(sd) > 0
            call add(res, {
                     \ 'icase': 1,
                     \ 'word': sd[0],
                     \ 'info': join(sd[1:], ''),
                     \ })
         endif

      endfor
      return res
   endif
endfunction
