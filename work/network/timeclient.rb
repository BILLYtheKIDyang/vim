require 'socket'
require 'timeout'

PORT = 12321

HOST = ARGV[0] || 'localhost'

socket = UDPSocket.new
socket.connect(HOST, PORT)

socket.send("", 0)
Timeout.timeout(10) do
  time = socket.gets
  puts time
end
