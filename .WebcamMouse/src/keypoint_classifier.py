import os
import numpy as np
import tensorflow as tf
from src.singleton_meta import Singleton
from src.click_config import ClickConfig
import logging

class KeyPointClassifier(metaclass=Singleton):
    def __init__(
        self,
        models_paths = ['utils\models\keypoint_classifier_catch.keras','utils\models\keypoint_classifier_nip.keras'] 
    ):
        # turn models_paths into an absolute path
        base_dir = os.path.dirname(__file__)
        absolute_models_paths = [os.path.join(base_dir, model_path) for model_path in models_paths]
        logging.info(absolute_models_paths[0])

        self.model = tf.keras.models.load_model(filepath=absolute_models_paths[ClickConfig().gesture_index],compile=True)
        
    def predict_gesture(self, landmarks_list):
        result = self.model.predict(np.array([landmarks_list], dtype=np.float32), verbose=0)
        result_index = np.argmax(np.squeeze(result))
        return result_index
    
    def change_model(self, gesture_index):
        self.model = tf.keras.models.load_model(filepath=models_paths[gesture_index],compile=True)
        return True