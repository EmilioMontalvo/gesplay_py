from src.singleton_meta import Singleton

class CursorConfig(metaclass=Singleton):
    def __init__(self):
        self.camera_id = 0
        self.spd_up = 40
        self.spd_down = 40
        self.spd_left = 40
        self.spd_right = 40
        self.pointer_smooth = 63
        self.tick_interval_ms = 16
    
    def start(self):
        pass