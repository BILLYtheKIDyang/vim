#!/usr/bin/env  python2
# High-Level Gopher Client with urllib - Chapter 1 - urlclient.py

import urllib, sys
host = sys.argv[1]
file = sys.argv[2]

#f = urllib.urlopen('gopher://%s%s' %(host, file))
f = urllib.urlopen('http://%s%s' %(host, file))
for line in f.readlines():
    sys.stdout.write(line)
