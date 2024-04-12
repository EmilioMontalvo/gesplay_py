# limitations under the License.
import logging
from src.camera_manager import CameraManager
from src.detectors.hand_detector import HandDetector
from src.udp.udp_client import UdpClient


class Pipeline:
    def __init__(self):
        logging.info("Init Pipeline")

    def pipeline_tick(self) -> None:
        frame_rgb = CameraManager().get_frame_rgb()
        hand_position = HandDetector().get_hand_position(frame_rgb)        
        UdpClient().send(hand_position)

       