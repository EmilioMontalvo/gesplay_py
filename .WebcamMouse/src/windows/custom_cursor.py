from src.windows.cursor_image import CursorImage
from src.singleton_meta import Singleton
from enum import Enum
import json

class CursorType(Enum):
    DEFAULT = 1
    NORMAL_BIG = 2
    TARGET = 3
    TARGET_2 = 4
    

Cursors = {
    #image_path, offset
    CursorType.DEFAULT: ["cursor_1.png", "top_left"], #offset can be ["top_left", "top_right", "bottom_left", "bottom_right", "center"]
    CursorType.NORMAL_BIG: ["cursor_2.png", "top_left"],
    CursorType.TARGET: ["cursor_3.png", "center"],
    CursorType.TARGET_2: ["cursor_4.png", "center"],

}


class CustomCursor(metaclass=Singleton):
    def __init__(self):
        self.icon:CursorImage = None
        self.offset= None
        self.size=1
        self.opacity=0.5
        self.color=(79,163,221,255)
        self.cursor_id = CursorType.TARGET_2
    
    def load_from_json(self, json_string):
        data = json.loads(json_string)
        self.cursor_id = data["cursor_id"]
        self.size = data["size"]
        self.opacity = data["opacity"]
        self.color = tuple(data["color"])
        self.set_cursor(self.cursor_id)       
    
    def load_from_dict(self, data):
        self.cursor_id = data["cursor_id"]
        self.size = data["size"]
        self.opacity = data["opacity"]
        self.color = tuple(data["color"])
        self.set_cursor(self.cursor_id)
    
    def start(self):
        self.set_cursor(self.cursor_id)

    def set_cursor(self, cursor_id):
        if cursor_id not in Cursors:
            raise ValueError(f"Invalid cursor ID: {cursor_id}")
        image_path, offset = Cursors[cursor_id]
        tempicon = CursorImage(image_path)
        tempicon.resize_with_aspect_ratio(self.size)
        tempicon.change_color(self.color)
        #tempicon.change_opacity(self.opacity)        
        self.icon = tempicon
        self.offset = offset

    def reset_cursor(self):
        self.icon = None