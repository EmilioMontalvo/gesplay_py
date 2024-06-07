from src.singleton_meta import Singleton

class GeneralConfig(metaclass=Singleton):
    def __init__(self):
        self.camera_id = 0
        self.paused_app = False
        self.paused_camera = False
        self.paused_mouse_control = False
    
    def start(self):
        pass
    
    def pause(self):
        self.paused_mouse_control = True
    
    def resume(self):
        self.paused_mouse_control = False