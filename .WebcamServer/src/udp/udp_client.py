import socket
import logging

from src.singleton_meta import Singleton

logger = logging.getLogger("TaskManager")

UDP_IP = "127.0.0.1"
UDP_PORT = 4242

class UdpClient(metaclass=Singleton):
    def __init__(self):        
        self.sock = None
    
    def start(self): 
        self.sock = socket.socket(socket.AF_INET, 
                    socket.SOCK_DGRAM)


    def send(self, message):
        self.sock.sendto(str(message).encode(), (UDP_IP, UDP_PORT))

    def close(self):
        self.sock.close()

    def destroy(self):
        self.close()
        logger.info("UdpClient destroyed")
