#!/usr/bin/env python2
# UDP Connectionless Example - Chapter 2 - udptime.py

import socket, sys, struct, time

hostname = 'time.nist.gov' if len(sys.argv) < 2 else sys.argv[1]
port = 37 if len(sys.argv) < 3 else int(sys.argv[2])

host = socket.gethostbyname(hostname)

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.sendto(b'', (host, port))

print("Looking for replies: press Ctrl-C to stop.")
buf = s.recvfrom(2048)[0]
if len(buf) != 4:
    print("Wrong-sized reply %d: %s" % (len(buf), buf))
    sys.exit(1)

secs = struct.unpack("!I", buf)[0]
secs -= 2208988800
print(time.ctime(int(secs)))
