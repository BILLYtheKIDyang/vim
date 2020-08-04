#!/usr/bin/env python2
# Get list of available socket options -- Chapter 3  -- sockopts.py

import socket
solist = [x for x in dir(socket) if x.startswith('SO_')]
solist.sort()
for x in solist:
    print(x)
