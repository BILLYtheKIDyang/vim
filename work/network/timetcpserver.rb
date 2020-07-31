require 'socket'

PORT = 12321

server = TCPServer.new(PORT)

while (session = server.accept) 
  session.puts Time.new
  session.close
end
