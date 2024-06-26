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
        self.camera_id = 0
    
    def start(self):
        if not self.is_started:
            logging.info("CameraManager started")
            self.is_started = True
            self.cap = cv2.VideoCapture(self.camera_id, cv2.CAP_DSHOW)
            self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
            self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
            self.cap.set(cv2.CAP_PROP_FPS, 30)

    def get_frame_rgb(self):
        if self.is_started:
            self.is_started = True
            try:
                ret,self.frame = self.cap.read()

                if self.frame is None:
                    return None
                frame_rgb = cv2.cvtColor(self.frame, cv2.COLOR_BGR2RGB)

                return frame_rgb
            except Exception as e:
                logging.error("Error getting frame")
                logging.error(e)
                return None
        else:
            return None
    
    def get_frame(self):
        if self.is_started:
            return self.frame
        else:
            return None
    
    def get_fliped_frame(self):
        if self.is_started:
            return cv2.flip(self.frame,1)
        else:
            return None

    def release(self):
        self.cap.release()

    def destroy(self):
        self.is_started = False
        self.release()
        
    
    def change_camera(self, camera_id):
        self.camera_id = camera_id
        self.destroy()
        self.start()