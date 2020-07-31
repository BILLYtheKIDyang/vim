require 'open-uri'

data = nil
open("http://www.baidu.com/") { |f| data = f.read }

puts "Retrived #{data.split.size} lines, #{data.size} bytes"
puts data
Administrator@WIN-C202 MINGW64 ~/Desktop
$


