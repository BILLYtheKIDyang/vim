#!/usr/bin/env python2
# UDP Example  - Chapter 2 - udp.py

import socket, sys

host = sys.argv[1]
textport = sys.argv[2]

s = socket.socket(socket.AF_INET,  socket.SOCK_DGRAM)
try:
    port = int(textport)
except ValueError:
    # That didn't work.  Look it up instead.
    port = socket.getservbyname(textport, 'udp')

s.connect((host, port))
print("Enter data to  transmit: ")
data  = sys.stdin.readline().strip()
data = data.encode("utf-8")
s.sendall(data)
print("Looking for replies; press Ctrl-C or Ctrl-Break to stop.")
while  1:
    buf =  s.recv(2048)
    buf =  buf.decode("utf-8")
    if not len(buf):
        break
    sys.stdout.write(buf)
