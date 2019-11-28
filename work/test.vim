if 1
   call term_start("python", #{term_kill: 'term', term_finish: 'close'})
   only
   call term_sendkeys(term_list()[0], "exit()" . "\<CR>")
endif 
