import socket
# aa
# aa

s = socket.socket()

try:
    s.connect(("packtpub.samsclass.info", 22))
    print(s.recv(1024))
    s.close()
except socket.error as err:
    print(err)
