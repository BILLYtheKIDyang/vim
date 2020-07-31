require 'socket'

PORT = 12321

server = TCPServer.new(PORT)

while (session = server.accept) 
  Thread.new(session) do |my_session|
    my_session.puts Time.new
    my_session.close
  end
end
