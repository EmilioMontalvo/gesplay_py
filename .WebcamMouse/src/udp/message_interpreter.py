from src.udp.message import Message
from src.cursor_config import CursorConfig
from src.task_manager import TaskManager

class MessageInterpreter:
    def __init__(self):
        pass

    def interpret(self, message):
        if message == None:
            print("Invalid Message")
        elif message.instruction == "update_cursor_config":
            CursorConfig().load_from_dict(message.content)
        elif message.instruction == "update_click_config":
            #TODO: Implement ClickConfig
            pass
        elif message.instruction == "update_camera_config":
            #TODO: Implement CameraConfig
            pass
        elif message.instruction == "exit":
            print("Closing camera mouse")
            TaskManager().exit()
