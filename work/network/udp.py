from socket import socket, AF_INET, SOCK_DGRAM

udp_socket = socket(AF_INET, SOCK_DGRAM)
addr = ('localhost', 8080)
udp_socket.sendto("你好".encode('gb2312'), addr)
udp_socket.close()
