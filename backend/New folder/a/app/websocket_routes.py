from fastapi import APIRouter, WebSocket
import openai
from langchain.embeddings import OpenAIEmbeddings
from langchain.chat_models import ChatOpenAI
from langchain.prompts import PromptTemplate, SystemMessagePromptTemplate
from langchain.vectorstores.pgvector import PGVector
from langchain.schema import AIMessage, HumanMessage, SystemMessage

from app.config import OPENAI_API_KEY


router = APIRouter()
openai.api_key = OPENAI_API_KEY

# Initialize OpenAI Embeddings and Chat
embeddings = OpenAIEmbeddings()
chat_model = ChatOpenAI(temperature=0)


def get_embeddings(text: str):
    return embeddings.embed_text(text)

def get_chat_response(message: str):
    response = chat_model.generate([message])
    return response.generations[0].text


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        await websocket.send_text(f"Message text was: {data}")

