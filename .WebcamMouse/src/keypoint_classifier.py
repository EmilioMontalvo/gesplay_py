import os
import numpy as np
import tensorflow as tf
from src.singleton_meta import Singleton
from src.click_config import ClickConfig

class KeyPointClassifier(metaclass=Singleton):
    def __init__(
        self,
        models_paths = ['src/utils/models/keypoint_classifier_catch.keras','src/utils/models/keypoint_classifier_nip.keras'] 
    ):
        self.model = tf.keras.models.load_model(filepath=models_paths[ClickConfig().gesture_index],compile=True)
        
    def predict_gesture(self, landmarks_list):
        result = self.model.predict(np.array([landmarks_list], dtype=np.float32), verbose=0)
        result_index = np.argmax(np.squeeze(result))
        return result_index
    
    def change_model(self, gesture_index):
        self.model = tf.keras.models.load_model(filepath=models_paths[gesture_index],compile=True)
        return True