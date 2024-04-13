import socket
import logging
import cv2

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
    
    def send_bytes(self, image):
        buffer = cv2.imencode('.jpg', image)[1].tobytes()
        self.sock.sendto(buffer, (UDP_IP, UDP_PORT))

    def close(self):
        self.sock.close()

    def destroy(self):
        self.close()
        logger.info("UdpClient destroyed")
