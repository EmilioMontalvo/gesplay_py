import json
from src.singleton_meta import Singleton

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
    
    def load_from_dict(self, data):
        self.camera_id = data["camera_id"]
        self.gesture_index = data["gesture_index"]
    