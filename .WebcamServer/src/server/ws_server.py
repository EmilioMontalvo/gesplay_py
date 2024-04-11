import asyncio
from websockets.server import serve
from src.singleton_meta import Singleton
from decouple import config
from src.camera_manager import CameraManager

class WebSocketServer(metaclass=Singleton):

    def __init__(self):
        self.is_started = False
        self.ws_port = config("WS_PORT")
        self.ws_host = "localhost" 
        self.serve = None   
   
    def start(self):
        if not self.is_started:
            asyncio.run(self.main())
            self.is_started = True
           
    async def echo(self, websocket):
          async for message in websocket:
            print(message)
            await websocket.send(message)
            if message == "camara":
                while True:
                    frame=CameraManager().get_frame()
                    print(frame)                    
                    await websocket.send(str(frame))
                    await asyncio.sleep(0.1)

    async def main(self):
        async with serve(self.echo, self.ws_host, self.ws_port):
            await asyncio.Future()  # run forever        

    def stop(self):
        self.is_started = False
        self.ws_server.close()
    
    def destroy(self):
        self.stop()
        self.ws_server = None
