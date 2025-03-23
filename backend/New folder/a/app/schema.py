from pydantic import BaseModel

class Message(BaseModel):
    role: str
    content: str

class Conversation(BaseModel):
    conversation: list[Message]
