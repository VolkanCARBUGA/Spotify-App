
from models.base import Base
from fastapi import FastAPI
from routers import auth
from database import engine
app = FastAPI()

app.include_router(auth.router, prefix="/auth",)
Base.metadata.create_all(bind=engine)