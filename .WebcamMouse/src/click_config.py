import json
from src.singleton_meta import Singleton
from src.keypoint_classifier import KeyPointClassifier


class ClickConfig(metaclass=Singleton):
    def __init__(self):
        self.camera_id = 0
        #   0 -> catch
        #   1 -> nip
        self.gesture_index = 0

    def start(self):
        pass

    def load_from_json(self, json_string):
        data = json.loads(json_string)
        self.camera_id = data["camera_id"]
        self.gesture_index = data["gesture_index"]
        self.set_model()

    def load_from_dict(self, data):
        self.camera_id = data["camera_id"]
        self.gesture_index = data["gesture_index"]
        self.set_model()

    def set_model(self):
        KeyPointClassifier().change_model(self.gesture_index)
