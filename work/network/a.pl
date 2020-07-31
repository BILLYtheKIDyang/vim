($addr) = (gethostbyname("www.baidu.com"))[4];
print "Slate's address is ", join(".", unpack("C4", $addr)), "\n";

