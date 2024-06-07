from src.singleton_meta import Singleton

class GeneralConfig(metaclass=Singleton):
    def __init__(self):
        self.camera_id = 0
        self.paused_app = False
        self.paused_camera = False
        self.paused_mause_control = False
    
    def start(self):
        pass

    