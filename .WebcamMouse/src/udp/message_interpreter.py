from src.udp.message import Message
from src.cursor_config import CursorConfig

class MessageInterpreter:
    def __init__(self):
        pass

    def interpret(self, message):
        if message == None:
            print("Invalid Message")
        if message.instruction == "update_cursor_config":
            CursorConfig().load_from_dict(message.content)
        