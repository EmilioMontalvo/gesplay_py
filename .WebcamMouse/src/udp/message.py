import json

class Message:
    def __init__(self, instruction, content):
        self.instruction = instruction
        self.content = content

    def to_json(self):
        return json.dumps({
            "instruction": self.instruction,
            "content": self.content
        })

    @classmethod
    def from_json(cls, json_string):
        try:
            data = json.loads(json_string)
            return cls(data["instruction"], data["content"])
        except:
            return None
        
    
    def __str__(self):
        return self.to_json()