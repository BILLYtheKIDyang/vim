#!/usr/bin/env python
import socket
s = socket.socket()
s.settimeout(2)

for port in range(3000, 4000):
    try:
        s.connect(("packtpub.samsclass.info", port))
        print(s.recv(1024))
        s.close()
    except socket.error as e:
        print(e)
