from sqlmodel import SQLModel, Field
from pydantic import BaseModel
from typing import List, Optional



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



