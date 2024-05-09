import logging
import src.utils as utils
from src.camera_manager import CameraManager
from src.detectors.hand_detector import HandDetector
from src.udp.udp_client import UdpClient
from src.controllers.mouse_controller import MouseController
from src.controllers.click_controller import ClickController


class Pipeline:
    def __init__(self):
        logging.info("Init Pipeline")

    def pipeline_tick(self) -> None:
        frame_rgb = CameraManager().get_frame_rgb()
        frame = CameraManager().get_fliped_frame()
        hand_position = HandDetector().get_hand_position(frame_rgb)
        frame_rgb.flags.writeable = False
        results_image = HandDetector().hands.process(frame_rgb)
        frame_rgb.flags.writeable = True
        MouseController().act(track_loc=hand_position)
        ClickController().act(image_results=results_image, image=frame)

        send_frame=CameraManager().frame
        utils.draw_circle(send_frame, hand_position)
        send_frame=utils.invert_frame(send_frame)
        # UdpClient().send_bytes(send_frame)
    

       