import logging
import os
import copy
import pyautogui
import time
import numpy as np
import tensorflow as tf
import concurrent.futures as futures
from src.singleton_meta import Singleton
from src.landmark_processor import LandmarkProcessor
from src.keypoint_classifier import KeyPointClassifier
from src.click_config import ClickConfig

class ClickController(metaclass=Singleton):
    def __init__(self) -> None:
        self.is_started = False
        self.is_stoped = True
        self.is_destroyed = False
        self.is_active = False
        self.curr_image_results = None
        self.curr_image = None
        self.is_clicked = False
        
    def start(self):
        if not self.is_started:
            logging.info("ClickController started")
            self.is_started = True
            self.is_stoped = False
            self.pool = futures.ThreadPoolExecutor(max_workers=1)
            self.pool.submit(self.main_loop)
    
    def stop(self):
        self.is_stoped=True
    
    def resume(self):
        self.is_stoped=False
        
    def main_loop(self):
        if self.is_stoped:
            return
        logging.info("ClickController thread started")
        while not self.is_stoped:
            if not self.is_active:
                time.sleep(0.001)
                continue
            debug_image = copy.deepcopy(self.curr_image)
            if self.curr_image_results is not None and debug_image is not None:
                if self.curr_image_results.multi_hand_landmarks is not None:
                    for hand_landmarks, handedness in zip(self.curr_image_results.multi_hand_landmarks, self.curr_image_results.multi_handedness):
                        landmark_list = LandmarkProcessor().calc_landmark_list(image = debug_image, landmarks= hand_landmarks)
                        pre_process_landmark_list = LandmarkProcessor().pre_process_landmark(landmark_list)
                        gesture = KeyPointClassifier().predict_gesture(pre_process_landmark_list)
                        print(gesture)
                        if gesture == 1:
                            if not self.is_clicked:
                                self.is_clicked = True
                                pyautogui.mouseDown()
                            self.is_clicked = True
                        else:
                            if self.is_clicked:
                                self.is_clicked = False
                                pyautogui.mouseUp()
                            self.is_clicked = False
                
    
    def act(self, image_results, image):
        if image_results is not None and image is not None:
            if not self.is_active:
                self.is_active = True
            self.curr_image_results = image_results
            self.curr_image = copy.deepcopy(image)
        else:
            self.is_active = False
            
    def destroy(self):
        self.is_active=False
        self.is_started=False
        self.is_stoped=True
        self.is_destroyed=True
        