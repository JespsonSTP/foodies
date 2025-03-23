#standard python library imports
import os
import json
import logging
import requests
import models
from datetime import datetime, timedelta, timezone

#import to handle environment variable
from dotenv import find_dotenv, load_dotenv

#fastapi imports
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import create_db_and_tables
from app.hero_routes import router as hero_router
from app.websocket_routes import router as websocket_router
from app.chat import router as chat_router

load_dotenv(find_dotenv())


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
def on_startup():
    create_db_and_tables()

app.include_router(hero_router, prefix="/heroes")
app.include_router(websocket_router, prefix="/ws")
