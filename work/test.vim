if 1
   call term_start("python", #{term_finish: 'close', term_kill: 'term'})
   only
   call term_sendkeys(term_list()[0], "exit()" . "\<CR>")

endif 
