import socket
s = socket.socket()

try:
    s.connect(("packtpub.samsclass.info", 23))
    print(s.recv(1024))
    s.close()
except socket.error as e:
    print(e)
