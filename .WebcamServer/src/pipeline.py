# limitations under the License.
import logging
from src.camera_manager import CameraManager
from src.detectors.hand_detector import HandDetector
from src.server.ws_server import WebSocketServer

class Pipeline:
    def __init__(self):
        logging.info("Init Pipeline")

    def pipeline_tick(self) -> None:
        frame_rgb = CameraManager().get_frame_rgb()

        hand_position = HandDetector().get_hand_position(frame_rgb)

        #WebSocketServer().send_message(str(hand_position))