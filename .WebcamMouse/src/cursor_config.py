import json
from src.singleton_meta import Singleton

class CursorConfig(metaclass=Singleton):
    def __init__(self):
        self.camera_id = 0
        self.spd_up = 40
        self.spd_down = 40
        self.spd_left = 40
        self.spd_right = 40
        self.pointer_smooth = 63
        self.tick_interval_ms = 30
    
    def start(self):
        pass

    def load_from_json(self, json_string):
        data = json.loads(json_string)
        self.camera_id = data["camera_id"]
        self.spd_up = data["spd_up"]
        self.spd_down = data["spd_down"]
        self.spd_left = data["spd_left"]
        self.spd_right = data["spd_right"]
        self.pointer_smooth = data["pointer_smooth"]
        self.tick_interval_ms = data["tick_interval_ms"]
    
    def load_from_dict(self, data):
        self.camera_id = data["camera_id"]
        self.spd_up = data["spd_up"]
        self.spd_down = data["spd_down"]
        self.spd_left = data["spd_left"]
        self.spd_right = data["spd_right"]
        self.pointer_smooth = data["pointer_smooth"]
        self.tick_interval_ms = data["tick_interval_ms"]
        print(self.pointer_smooth)