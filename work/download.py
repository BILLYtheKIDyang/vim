import urllib, sys

f = urllib.urlopen(sys.argv[1])
f = urllib.urlopen('http://www.baidu.com')
while 1:
    buf = f.read(2048)
    if not len(buf):
        break
    sys.stdout.write(buf)
