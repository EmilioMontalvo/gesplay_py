# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import logging

from src.singleton_meta import Singleton

logger = logging.getLogger("TaskManager")


class TaskManager(metaclass=Singleton):
    """Singleton class for saftly killing the process and free the memory
    """

    def __init__(self):
        logger.info("Intialize TaskManaller singleton")
        self.is_started = False

    def start(self):
        if not self.is_started:          
            # Start singletons

            from src.cursor_config import CursorConfig
            CursorConfig().start()
            
            from src.click_config import ClickConfig
            ClickConfig().start()

            from src.udp.udp_client import UdpClient
            # UdpClient().start()

            from src.camera_manager import CameraManager
            CameraManager().start()

            from src.detectors.hand_detector import HandDetector
            HandDetector().start()

            from src.controllers.mouse_controller import MouseController
            MouseController().start()
            
            from src.controllers.click_controller import ClickController
            ClickController().start()

            self.is_started = True

    def exit(self):
        logger.info("Exit program")

        # Stop singletons
        from src.camera_manager import CameraManager
        CameraManager().destroy()

        from src.detectors.hand_detector import HandDetector
        HandDetector().destroy()

        from src.udp.udp_client import UdpClient
        UdpClient().destroy()

        from src.controllers.mouse_controller import MouseController
        MouseController().destroy()
        
        from src.controllers.click_controller import ClickController
        ClickController().destroy()


        exit()