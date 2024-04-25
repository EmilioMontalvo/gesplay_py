import logging
import src.utils as utils
from src.camera_manager import CameraManager
from src.detectors.hand_detector import HandDetector
from src.udp.udp_client import UdpClient
from src.controllers.mouse_controller import MouseController


class Pipeline:
    def __init__(self):
        logging.info("Init Pipeline")

    def pipeline_tick(self) -> None:
        frame_rgb = CameraManager().get_frame_rgb()
        hand_position = HandDetector().get_hand_position(frame_rgb)
        MouseController().act(track_loc=hand_position)

        send_frame=CameraManager().frame
        utils.draw_circle(send_frame, hand_position)
        send_frame=utils.invert_frame(send_frame)
        UdpClient().send_bytes(send_frame)
    

       