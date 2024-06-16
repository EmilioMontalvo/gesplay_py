import logging
import src.utils as utils
import time
from src.camera_manager import CameraManager
from src.detectors.hand_detector import HandDetector
from src.udp.udp_client import UdpClient
from src.controllers.mouse_controller import MouseController
from src.controllers.click_controller import ClickController
from src.general_config import GeneralConfig
import os
import cv2

base_dir = os.path.dirname(__file__)
image_path = os.path.join(base_dir, "images\placeholder.jpg")
placeholder = cv2.imread(image_path)

class Pipeline:
    def __init__(self):
        logging.info("Init Pipeline")
        self.last_clicked = False

    def pipeline_tick(self) -> None:
        frame_rgb = CameraManager().get_frame_rgb()
        if GeneralConfig().paused_mouse_control:
            return
        
        if frame_rgb is None:            
            UdpClient().send_bytes(placeholder)
            return

        frame = CameraManager().get_fliped_frame()
        hand_position = HandDetector().get_hand_position(frame_rgb)
        frame_rgb.flags.writeable = False
        results_image = HandDetector().hands.process(frame_rgb)
        frame_rgb.flags.writeable = True
        ClickController().act(image_results=results_image, image=frame)
        if ClickController().is_clicked and not self.last_clicked:
            MouseController().pause()
        self.last_clicked = ClickController().is_clicked
        MouseController().act(track_loc=hand_position)

        send_frame = CameraManager().frame
        utils.draw_circle(send_frame, hand_position)
        send_frame = utils.invert_frame(send_frame)
        UdpClient().send_bytes(send_frame)
