import os
import cv2
from src.windows.cursor_image import CursorImage
from src.singleton_meta import Singleton
from enum import Enum

class CursorType(Enum):
    DEFAULT = 1
    CROSSHAIR = 2
    HAND = 3
    IBEAM = 4
    NO = 5
    SIZE_ALL = 6
    SIZE_NESW = 7
    SIZE_NS = 8
    SIZE_NWSE = 9
    SIZE_WE = 10
    UP_ARROW = 11
    WAIT = 12

Cursors = {
    #image_path, offset
    CursorType.DEFAULT: ["cursor_1.png", (50, 50)],
    CursorType.CROSSHAIR: ["cursor_2.png", (50, 50)],
    CursorType.HAND: ["cursor_3.png", (50, 50)],
    CursorType.IBEAM: ["cursor_4.png", (50, 50)],
    CursorType.NO: ["cursor_5.png", (50, 50)],
    CursorType.SIZE_ALL: ["cursor_6.png", (50, 50)],
}


class CustomCursor(metaclass=Singleton):
    def __init__(self):
        self.icon:CursorImage = None
        self.offset= None
        self.size=1
        self.opacity=1
        self.color=None
        self.cursor_id = CursorType.DEFAULT
        
    
    def start(self):
        self.set_cursor(self.cursor_id)

    def set_cursor(self, cursor_id):
        if cursor_id not in Cursors:
            raise ValueError(f"Invalid cursor ID: {cursor_id}")
        image_path, offset = Cursors[cursor_id]
        tempicon = CursorImage(image_path)
        tempicon.resize_with_aspect_ratio(self.size)
        tempicon.change_color(self.color)
        tempicon.change_opacity(self.opacity)
        self.icon = tempicon
        self.offset = offset

    def reset_cursor(self):
        self.icon = None