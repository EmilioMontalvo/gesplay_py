from src.udp.message import Message
from src.cursor_config import CursorConfig
from src.click_config import ClickConfig
from src.task_manager import TaskManager
from src.general_config import GeneralConfig
from src.camera_manager import CameraManager
from src.windows.custom_cursor import CustomCursor

class MessageInterpreter:
    def __init__(self):
        pass

    def interpret(self, message):
        if message == None:
            print("Invalid Message")
        elif message.instruction == "update_cursor_config":
            CursorConfig().load_from_dict(message.content)
            print(message.content)
        elif message.instruction == "update_click_config":
            ClickConfig().load_from_dict(message.content)
            pass
        elif message.instruction == "update_camera_config":
            print(message.content)
            CameraManager().change_camera(message.content["camera_id"])
            pass
        elif message.instruction == "pause_mouse":
            GeneralConfig().pause()
            pass
        elif message.instruction == "resume_mouse":
            GeneralConfig().resume()
            pass
        elif message.instruction == "update_cursor_icon_config":
            print(message.content)
            CustomCursor().load_from_dict(message.content)
            pass

        elif message.instruction == "exit":
            print("Closing camera mouse")
            TaskManager().exit()
