import cv2
import logging
from src.singleton_meta import Singleton

class CameraManager(metaclass=Singleton):
    def __init__(self):
        logging.info("CameraManager Init")
        self.cap = None
        self.is_started = False
        self.frame = None
        self.is_started = False
    
    def start(self):
        if not self.is_started:
            logging.info("CameraManager started")
            self.is_started = True
            self.cap = cv2.VideoCapture(0, cv2.CAP_DSHOW)
            self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
            self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
            self.cap.set(cv2.CAP_PROP_FPS, 30)

    def get_frame_rgb(self):
        if self.is_started:
            self.is_started = True
            ret,self.frame = self.cap.read()
            frame_rgb = cv2.cvtColor(self.frame, cv2.COLOR_BGR2RGB)

            return frame_rgb
        else:
            return cv2.imread("placeholder.jpg")
    
    def get_frame(self):
        if self.is_started:
            return self.frame
        else:
            return cv2.imread("placeholder.jpg")
    
    def get_fliped_frame(self):
        if self.is_started:
            return cv2.flip(self.frame,1)
        else:
            return cv2.imread("placeholder.jpg")

    def release(self):
        self.cap.release()

    def destroy(self):
        self.release()
        self.is_started = False