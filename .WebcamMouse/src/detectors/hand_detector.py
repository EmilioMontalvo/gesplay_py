import cv2
import logging
import mediapipe as mp
import numpy as np

from src.singleton_meta import Singleton
mp_hands = mp.solutions.hands

class HandDetector(metaclass=Singleton):    
    
    def __init__(self):        
        logging.info("Init HandDetector")
        self.hands = None
        self.mp_landmarks = None
        self.is_started = False
        self.hand_position = None
        self.mp_result = None
    
    def start(self):
        if not self.is_started:
            logging.info("HandDetector Started")
            self.hands = mp_hands.Hands(
                static_image_mode=False,
                max_num_hands=1,
                min_detection_confidence=0.5)
            self.is_started = True

    def get_hand_position(self, frame):
        if self.is_started:            
            results = self.hands.process(frame)
            height, width, _ = frame.shape

            if results.multi_hand_landmarks is not None:
                self.mp_result=results
                for hand_landmarks in results.multi_hand_landmarks:
                    landmarks_palm1=hand_landmarks.landmark[5]
                    landmarks_palm2=hand_landmarks.landmark[17]
                    landmarks_palm3=hand_landmarks.landmark[0]
                    
                    average_x=np.mean((landmarks_palm1.x+landmarks_palm2.x+landmarks_palm3.x)/3*width)
                    average_y=np.mean((landmarks_palm1.y+landmarks_palm2.y+landmarks_palm3.y)/3*height)
                    self.hand_position = [-average_x, average_y] 
            else:
                self.hand_position = None               
        return self.hand_position
    

    def destroy(self):
        self.hands.close()
        self.is_started = False
        self.hand_position = None
        self.mp_landmarks = None
