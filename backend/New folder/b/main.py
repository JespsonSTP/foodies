from datetime import datetime, timedelta, timezone
from typing import Annotated, List, Optional

import jwt
from fastapi import Depends, FastAPI, HTTPException, status, Query
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jwt.exceptions import InvalidTokenError
from passlib.context import CryptContext
from pydantic import BaseModel
from sqlmodel import Field, Session, SQLModel, create_engine, select


SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"

connect_args = {"check_same_thread": False}
engine = create_engine(sqlite_url, connect_args=connect_args)


fake_users_db = {
    "johndoe": {
        "username": "johndoe",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": "$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW",
        "disabled": False,
    }
}

class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: str | None = None

# Base model for general user data
class UserBase(SQLModel):
    full_name: str = Field(index=True)
    username: str = Field(index=True)
    email: str = Field(index=True)
    disabled: bool = Field(default=False)
    age: Optional[int] = Field(default=None, index=True)


# User model representing the database table
class User(UserBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)



# Public-facing model, excluding sensitive info
class UserPublic(UserBase):
    id: int



# Model for creating a new user
class UserCreate(UserBase):
    password: str  # Not hashed yet, intended for creation



# Model for updating existing user data
class UserUpdate(SQLModel):
    full_name: Optional[str] = None
    age: Optional[int] = None
    disabled: Optional[bool] = None



# Authentication model strictly for internal use
class UserAuth(BaseModel):
    username: str
    hashed_password: str


app = FastAPI()