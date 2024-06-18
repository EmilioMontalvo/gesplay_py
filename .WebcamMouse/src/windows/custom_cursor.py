import os
import cv2

class CostumCursor:
    def __init__(self):
        self.icon = None
        self.size=(50,50)

    def set_cursor(self, cursor_id):
        base_dir = os.path.dirname(__file__)
        image_path = os.path.join(base_dir, f"images\cursors\cursor_{cursor_id}.png")
        self.icon = cv2.imread(image_path)

    def reset_cursor(self):
        self.icon = None