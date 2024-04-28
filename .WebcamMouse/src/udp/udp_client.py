import socket
import logging
import cv2
import concurrent.futures as futures
from src.udp.message import Message
from src.udp.message_interpreter import MessageInterpreter
from src.singleton_meta import Singleton

logger = logging.getLogger("TaskManager")

UDP_IP = "127.0.0.1"
UDP_PORT = 4242
CLIENT_PORT= 4243

class UdpClient(metaclass=Singleton):
    def __init__(self):        
        self.sock = None
        self.message_interpreter = MessageInterpreter()

    
    def start(self): 
        self.sock = socket.socket(socket.AF_INET, 
                    socket.SOCK_DGRAM)
        self.sock.bind((UDP_IP,CLIENT_PORT))
        self.pool = futures.ThreadPoolExecutor(max_workers=1)
        self.pool.submit(self.receiveData)


    def send(self, message):
        self.sock.sendto(str(message).encode(), (UDP_IP, UDP_PORT))
    
    def send_bytes(self, image):
        res_image = cv2.resize(image, (320, 480))
        buffer = cv2.imencode('.jpg', res_image)[1].tobytes()
        self.sock.sendto(buffer, (UDP_IP, UDP_PORT))

    def close(self):
        self.sock.close()

    def destroy(self):
        self.close()
        logger.info("UdpClient destroyed")

    def receiveData(self):
        logger.info("Listener Started...")
        while True:            
            try:
                data,addr = self.sock.recvfrom(1024)
                message = Message.from_json(data.decode('utf-8'))
                self.message_interpreter.interpret(message)
            except:
                #TODO: Close the application is the server closes
                print("Error")
