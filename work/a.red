Red []
i: 1
while [i < 10] [
   print i
   i: i + 1
]

print "Hello World"

halt

request-file

request-file/file %test.red
request-file/file/save %test.red

ask "Enter some text: "

Red[]
print ask "Enter some text: "
halt

print request-dir

write %mydata "This is some text that I want to save for later."

print read %mydata

probe read %mydata
