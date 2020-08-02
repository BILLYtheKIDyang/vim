" Server that will accept connections from a Vim channel.
" Run this server and then in Vim you can open the channel:
"let handle = ch_open('localhost:8765')
"
" Then Vim can send requests to the server:
let response = ch_sendexpr(handle, 'hello!')
"
" And you can control Vim by typing a JSON message here, e.g.:
echom ch_sendexpr(handle, ["ex","echo 'hi there'"])
"
" There is no prompt, just type a line and press Enter.
" To exit cleanly type "quit<Enter>".
"
" See ":help channel-demo" in Vim.
"
" This requires Python 2.6 or later.
