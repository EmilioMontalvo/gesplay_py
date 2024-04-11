import websockets
import asyncio

class WebSocketClient:
    def __init__(self):
        self.ws = None
        self.uri = "ws://localhost:5000"

    async def connect(self):
        self.ws = await websockets.connect(self.uri)

    async def send(self, message):
        await self.ws.send(message)

    async def receive(self):
        return await self.ws.recv()

    async def close(self):
        await self.ws.close()

    async def main(self):
        await self.connect()
        await self.send("Hello, World!")
        response = await self.receive()
        print(response)
        

    def start(self):
        asyncio.run(self.main())

    def destroy(self):
        asyncio.run(self.close())
        self.ws = None