import os
import numpy as np
import tensorflow as tf
from src.singleton_meta import Singleton

class KeyPointClassifier(metaclass=Singleton):
    def __init__(
        self,
        model_path = 'src/utils/models/keypoint_classifier.keras', 
    ):
        self.model = tf.keras.models.load_model(model_path)
        
    def predict_gesture(self, landmarks_list):
        result = self.model.predict(np.array([landmarks_list], dtype=np.float32))
        result_index = np.argmax(np.squeeze(result))
        return result_index