import logging
import os
import copy
import pyautogui
import numpy as np
import tensorflow as tf
import concurrent.futures as futures
from src.singleton_meta import Singleton
from src.landmark_processor import LandmarkProcessor

class ClickController(metaclass=singleton):
    def __init__(self) -> None:
        self.is_started = False
        self.is_stopped = True
        self.is_destroyed = False
        self.is_active = False
        self.curr_image_results = None
        self.curr_image = None
        
    def start(self):
        if not self.is_started:
            logging.info("ClickController started")
            self.is_started = True
            self.is_stopped = False
            self.pool = futures.ThreadPoolExecutor(max_workers=1)
            self.pool.submit(self.main_loop)
    
    def stop(self):
        self.is_stoped=True
    
    def resume(self):
        self.is_stoped=False
        
    def main_loop(self):
        if self.is_stopped:
            return
        logging.info("ClickController thread started")
        while not self.is_stoped:
            if self.curr_image_results and self.curr_image:
                if self.curr_image_results.multi_hand_landmarks is not None:
                    for hand_landmarks, handedness in zip(self.curr_image_results.multi_hand_landmarks, self.curr_image_results.multi_handedness):
                        landmark_list = LandmarkProcessor().calc_landmark_list(self.curr_image, hand_landmarks)
                        pre_process_landmark_list = LandmarkProcessor().pre_process_landmark(landmark_list)
                        gesture = KeyPointClassifier().predict_gesture(pre_process_landmark_list)
                        if gesture in [0,1]:
                            pyautogui.click()
                
                
                
    
    def act(self, image_results, image):
        if(landmarks and image):
            if not self.is_active:
                self.is_active = True
            self.curr_image_results = image_results
            self.curr_image = copy.deepcopy(image)
        else:
            self.is_active = False
        