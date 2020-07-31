#!/usr/bin/env python
import socket
s = socket.socket()
s.settimeout(2)

port = input("Port number: ")
try:
    s.connect(("packtpub.samsclass.info", int(port)))
    print(s.recv(1024))
    s.close()
except socket.error as e:
    print(e)
