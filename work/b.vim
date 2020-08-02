if 0
   " ipython under windows
   call term_sendkeys(term_list()[0], "for x in range(1):\n")
   call term_sendkeys(term_list()[0], "    print(x)\n")
   call term_sendkeys(term_list()[0], "\n")
endif
if 0
   " python under windows 
   call term_sendkeys(term_list()[0], "for x in range(1):\r")
   call term_sendkeys(term_list()[0], "    print(x)\r")
   call term_sendkeys(term_list()[0], "\r")
endif
if 0
   " xonsh under windows 
   call term_sendkeys(term_list()[0], "for x in range(1):\<CR>")
   call term_sendkeys(term_list()[0], "    print(x)\<CR>")
   sleep 1m
   call term_sendkeys(term_list()[0], "\n")
endif
if 0
   " xonsh under windows 
   call term_sendkeys(term_list()[0], "for x in range(1):\r")
   call term_sendkeys(term_list()[0], "    print(x)\r")
   sleep 1m
   call term_sendkeys(term_list()[0], "\n")
endif

if 1
   call term_sendkeys(term_list()[0], "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\n")
endif
