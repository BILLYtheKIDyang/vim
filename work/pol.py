import sys
import re
for line in sys.stdin.read():
    if re.search("regex", line):
        print(line)
