require 'socket'

PORT = 12321
HOST = ARGV[0] || 'localhost'

server = UDPSocket.open
server.bind nil, PORT

loop do
  text, sender = server.recvfrom(1)
  server.send(Time.new.to_s + "\n", 0, sender[3], sender[1])
end
