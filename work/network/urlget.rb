require 'net/http'

begin
  h = Net::HTTP::new("www.baidu.com", 80)
  resp, data = h.get("/index.html", nil)
rescue => err
  puts "Error: #{err}"
  exit
end
